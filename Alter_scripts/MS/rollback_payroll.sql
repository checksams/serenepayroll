USE [serenehrdb]
GO

/****** Object:  StoredProcedure [dbo].[rollback_payroll]    Script Date: 9/18/2017 12:24:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE  [dbo].[rollback_payroll](@v_tr_code int,
									@v_rollback_by nvarchar(45)) AS
BEGIN
declare @v_error nvarchar(1000),
		@v_postDate datetime, @v_authorised nvarchar(5),
		@v_gl_code   nvarchar(45), @v_cnt bigint, @v_prvg_cnt decimal(23),
		@v_pr_code   bigint, @v_payroll_period decimal(30)

declare @c_tr_code bigint,@c_tr_pr_code bigint,@c_emp_code bigint,
		@c_tr_payroll_period decimal(30),
		@c_pel_code bigint,@c_ppe_code bigint,@c_pel_sht_desc nvarchar(45),
		@c_pel_desc nvarchar(150),
		@c_ppe_amt decimal(23,5),
		@c_pel_dr_gl_code nvarchar(5), @c_pel_cr_gl_code nvarchar(5), 
		@c_drcr nvarchar(5), @v_futrprls_auth_cnt decimal(23)
		
	DECLARE @cursor_e CURSOR 
	set @cursor_e = cursor fast_forward FOR 
		select tr_code,tr_pr_code,emp_code, tr_payroll_period
		from shr_prd_pay_elements ppe
		left join shr_employees emp on (ppe.ppe_emp_code=emp.emp_code)
		left join shr_pay_elements pel on (pel.pel_code=ppe.ppe_pel_code)
		left join shr_transactions tr on (tr.tr_code=ppe.ppe_tr_code)
		where tr_code = @v_tr_code
		and pel_type <> 'STATEMENT ITEM'
		group by tr_code,tr_pr_code,emp_code, tr_payroll_period
		order by emp_code

SET IMPLICIT_TRANSACTIONS ON
BEGIN TRY
	select @v_error = ' '
	set @v_futrprls_auth_cnt = 0
	
	select @v_postDate = CONVERT(DATETIME,
					CONVERT(nvarchar,tr_pr_year)+RIGHT('00'+CONVERT(nvarchar, tr_pr_month),2) + '28',
				  102)
	from shr_transactions;
	
	set @v_cnt = 0

	if (@v_rollback_by = '' or @v_rollback_by is null) 
	begin
		set @v_error = 'Login to proceed...';
		RAISERROR (@v_error, 16,1)
	end
	begin try --checking privillages
		--select * from shr_user_privillages
		--select * from shr_user_role_privlg
		--select * from shr_users
		--select * from shr_user_roles_granted

		select @v_prvg_cnt =  count(1) from shr_user_roles ur
		left join shr_user_role_privlg urp on (urp.urp_ur_code=ur_code)
		left join shr_user_privillages up on (up.up_code=urp_up_code)
		left join shr_user_roles_granted usg on (usg.usg_ur_code = ur_code)
		left join shr_users usr on (usg.usg_usr_code = usr_code)
		where up_code=16 and usr_name= @v_rollback_by
	end try--checking privillages
	begin catch
		set @v_error = 'Unable to fetch user roles...' + ERROR_MESSAGE()
		RAISERROR (@v_error, 16,1)
	end catch

	if @v_prvg_cnt = 0 
	begin
		set @v_error = 'You do not have rights to rollback payroll...'
		RAISERROR (@v_error, 16,1)
	end 

	if (@v_tr_code = 0 or @v_tr_code is null) 
	begin
		set @v_error = 'Select a payroll transaction to proceed...'
		RAISERROR (@v_error, 16,1)
	end
	select @v_authorised = tr_authorised,
		  @v_payroll_period = tr_payroll_period,
		  @v_pr_code = tr_pr_code
	from shr_transactions
	where tr_code = @v_tr_code
  
	if (@v_authorised='NO')
	begin
		set @v_error = 'This payroll transaction is not yet authorized...';
		RAISERROR (@v_error, 16,1)
	end
	
	select @v_futrprls_auth_cnt = count(1)
	from shr_transactions
	where tr_pr_code = @v_pr_code
	and tr_payroll_period > (select max(tr_payroll_period) 
							from shr_transactions
							where tr_pr_code = @v_pr_code
							and tr_authorised='YES' )
	
	if (@v_futrprls_auth_cnt is not null and @v_futrprls_auth_cnt > 0)
	begin
		set @v_error = '<b>There exists future authorized payrolls which came in '
						+ 'later than this one that need to be rolled back first...</b>';
		RAISERROR (@v_error, 16,1)
	end

	OPEN @cursor_e
		FETCH  NEXT FROM @cursor_e
		INTO @c_tr_code,@c_tr_pr_code,@c_emp_code,@c_tr_payroll_period
		
			WHILE @@FETCH_STATUS = 0
			BEGIN
				begin try
					insert into shr_auth_payroll_trans_rb(
					aptr_apt_code,aptr_tr_code,aptr_pr_code,aptr_emp_code,
					aptr_pel_code ,aptr_ppe_code ,aptr_pel_desc,aptr_dr_cr,
					aptr_gl_code,aptr_amt,aptr_date,
					aptr_rb_date, aptr_rollback_by,aptr_gl_code_contra,aptr_voucher_no,
					aptr_vch_code, aptr_fms_trn_code, aptr_fms_trans_no)
					select apt_code,apt_tr_code,apt_pr_code,apt_emp_code,
					apt_pel_code ,apt_ppe_code ,apt_pel_desc,apt_dr_cr,
					apt_gl_code,apt_amt,apt_date,
					getdate(), @v_rollback_by,apt_gl_code_contra,apt_vouher_no,
					apt_vch_code, apt_fms_trn_code, apt_fms_trans_no
					from shr_auth_payroll_trans
					where apt_tr_code= @c_tr_code and apt_emp_code=@c_emp_code
				end try
				begin catch
					set @v_error = 'Backing up rollback transactions...' + ERROR_MESSAGE()
					RAISERROR (@v_error, 16,1)
				end catch
				
				begin try
					delete from shr_prd_pay_elements 
					where ppe_tr_code in (select tr_code from shr_transactions	
										where tr_pr_code = @c_tr_pr_code
										and tr_payroll_period > @c_tr_payroll_period
										and tr_authorised = 'NO')
					delete from shr_transactions where tr_code in (select tr_code from shr_transactions	
										where tr_pr_code = @c_tr_pr_code
										and tr_payroll_period > @c_tr_payroll_period
										and tr_authorised = 'NO')
				end try	
				begin catch
					set @v_error = 'Rolling back New un-authorized transactions...' + ERROR_MESSAGE()
					RAISERROR (@v_error, 16,1)
				end catch
									
				begin try
					delete from shr_auth_payroll_trans 
					where apt_pr_code = @c_tr_pr_code
					and apt_tr_code in (select tr_code from shr_transactions	
										where tr_pr_code = @c_tr_pr_code
										and tr_payroll_period > @c_tr_payroll_period
										and tr_authorised = 'NO')
					delete from shr_auth_payroll_trans where apt_tr_code = @c_tr_code and apt_emp_code=@c_emp_code
				end try
				begin catch
					set @v_error = 'Rolling back transactions...' + ERROR_MESSAGE()
					RAISERROR (@v_error, 16,1)
				end catch
				set @v_cnt = @v_cnt + 1
			FETCH  NEXT FROM @cursor_e
			INTO @c_tr_code,@c_tr_pr_code,@c_emp_code,@c_tr_payroll_period
			END
		
		CLOSE @cursor_e
		DEALLOCATE @cursor_e

	if @v_cnt = 0 
	begin
		set @v_error = 'NO record has been rolled back..'
		RAISERROR (@v_error, 16,1)
	end
	else
	begin
		update shr_transactions
		set tr_authorised='NO'
		where tr_code = @v_tr_code
		commit
	end;
END TRY 
BEGIN CATCH
	set @v_error = @v_error
	rollback
	RAISERROR (@v_error, 16,1)
END CATCH
END 



GO


