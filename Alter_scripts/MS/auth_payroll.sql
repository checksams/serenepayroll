USE [serenehrdb]
GO

/****** Object:  StoredProcedure [dbo].[auth_payroll]    Script Date: 9/16/2017 1:01:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE  [dbo].[auth_payroll](@v_tr_code int,
									@v_auth_by nvarchar(45)) AS
BEGIN
declare @v_error nvarchar(1000),
		@v_postDate datetime, @v_authorised nvarchar(5),
		@v_gl_code   nvarchar(45), @v_cnt bigint, @v_prvg_cnt int,
		@v_days_infuture decimal(10),
		@v_pr_code   bigint, @v_post  nvarchar(5)

declare @c_tr_code bigint,@c_tr_pr_code bigint,@c_emp_code bigint,
		@c_pel_code bigint,@c_ppe_code bigint,@c_pel_sht_desc nvarchar(45),
		@c_pel_desc nvarchar(150),
		@c_ppe_amt decimal(23,5),
		@c_pel_dr_gl_code nvarchar(45), @c_pel_cr_gl_code nvarchar(45), 
		@c_drcr nvarchar(5)
		
	DECLARE @cursor_e CURSOR 
	set @cursor_e = cursor fast_forward FOR 
		select tr_code,tr_pr_code,emp_code
		from shr_prd_pay_elements ppe
		left join shr_employees emp on (ppe.ppe_emp_code=emp.emp_code)
		left join shr_pay_elements pel on (pel.pel_code=ppe.ppe_pel_code)
		left join shr_transactions tr on (tr.tr_code=ppe.ppe_tr_code)
		where tr_code = @v_tr_code
		and pel_type <> 'STATEMENT ITEM'
		group by tr_code,tr_pr_code,emp_code
		order by emp_code

	DECLARE @cursor_t CURSOR 

SET IMPLICIT_TRANSACTIONS ON
BEGIN TRY
	select @v_error = ' '
	
	select @v_postDate = CONVERT(DATETIME,
					CONVERT(nvarchar,tr_pr_year)+RIGHT('00'+CONVERT(nvarchar, tr_pr_month),2) + '28',
				  102)
	from shr_transactions;
	
	select @v_days_infuture =  DATEDIFF(day,getdate(),@v_postDate)
	if @v_days_infuture > 20
	begin
		set @v_error = 'The payroll period is not yet due for authorization...';
		RAISERROR (@v_error, 16,1)
	end

	set @v_cnt = 0

	if (@v_auth_by = '' or @v_auth_by is null) 
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
		where up_code=16 and usr_name= @v_auth_by
	end try--checking privillages
	begin catch
		set @v_error = 'Unable to fetch user roles...' + ERROR_MESSAGE()
		RAISERROR (@v_error, 16,1)
	end catch

	if @v_prvg_cnt = 0 
	begin
		set @v_error = 'You don''t have rights to authorize payroll...'
		RAISERROR (@v_error, 16,1)
	end 

	if (@v_tr_code = 0 or @v_tr_code is null) 
	begin
		set @v_error = 'Select a payroll transaction to proceed...'
		RAISERROR (@v_error, 16,1)
	end
	
	select @v_authorised = tr_authorised from shr_transactions
	where tr_code = @v_tr_code
  
	if (@v_authorised='YES')
	begin
		set @v_error = 'The payroll transaction is already authorised...';
		RAISERROR (@v_error, 16,1)
	end
	
	delete from shr_auth_payroll_trans where apt_tr_code= @v_tr_code
	OPEN @cursor_e
		FETCH  NEXT FROM @cursor_e
		INTO @c_tr_code,@c_tr_pr_code,@c_emp_code
			
			WHILE @@FETCH_STATUS = 0
			BEGIN	
			set @cursor_t = cursor fast_forward FOR 
				select pel_code,ppe_code,pel_sht_desc,pel_desc,abs(ppe_amt),
				pel_dr_gl_code, pel_cr_gl_code, 
				(case when UPPER(pel_sht_desc)='NP' then (case when sign(ppe_amt) = -1 then 'D' else 'C' end)
					  when UPPER(pel_deduction)='NO' then (case when sign(ppe_amt) = -1 then 'C' else 'D' end)
													 else (case when sign(ppe_amt) = -1 then 'D' else 'C' end)
					  end)as drcr
				from shr_prd_pay_elements ppe
				left join shr_employees emp on (ppe.ppe_emp_code=emp.emp_code)
				left join shr_pay_elements pel on (pel.pel_code=ppe.ppe_pel_code)
				left join shr_transactions tr on (tr.tr_code=ppe.ppe_tr_code)
				where tr_code = @c_tr_code and emp_code = @c_emp_code
				and (pel_type <> 'STATEMENT ITEM' or pel_sht_desc='NP')
				order by emp_code,pel_order	
						
				OPEN @cursor_t
					FETCH  NEXT FROM @cursor_t
					INTO @c_pel_code,@c_ppe_code,@c_pel_sht_desc,@c_pel_desc,
						@c_ppe_amt, @c_pel_dr_gl_code, @c_pel_cr_gl_code, @c_drcr
					WHILE @@FETCH_STATUS = 0
					BEGIN

						begin try 

							
							if @c_ppe_amt is not null and @c_ppe_amt <> 0 --@c_pel_sht_desc <> 'NP'
							begin
								--if @c_drcr = 'D'
								--	set @v_gl_code = @c_pel_dr_gl_code
								--else
								--	set @v_gl_code = @c_pel_cr_gl_code
								set @v_gl_code = @c_pel_dr_gl_code

								if @v_gl_code is null
								begin
									select @v_error = 'Set the ' + case when @c_drcr = 'D' then 'Debit '
														else 'Credit ' end + ' G.L. code for pay element '
														+ @c_pel_desc + '...'
									RAISERROR (@v_error, 16,1)
								end;

								insert into shr_auth_payroll_trans(
								apt_tr_code,apt_pr_code ,apt_emp_code,
								apt_pel_code,apt_ppe_code,apt_pel_desc,
								apt_amt,apt_dr_cr, apt_gl_code, apt_date)
								values(@c_tr_code,@c_tr_pr_code,@c_emp_code, 
								@c_pel_code,@c_ppe_code,@c_pel_desc,
								@c_ppe_amt, @c_drcr, @v_gl_code, getdate())

								set @v_cnt = @v_cnt + 1
							end
						end try
						begin catch
							SET @v_error = 'Logging payment records..' + ERROR_MESSAGE()
							RAISERROR (@v_error, 16,1)
						end catch
		
					FETCH  NEXT FROM @cursor_t
					INTO @c_pel_code,@c_ppe_code,@c_pel_sht_desc,@c_pel_desc,
						@c_ppe_amt, @c_pel_dr_gl_code, @c_pel_cr_gl_code, @c_drcr
					END
				CLOSE @cursor_t
				DEALLOCATE @cursor_t

				set @v_pr_code = @c_tr_pr_code
			FETCH  NEXT FROM @cursor_e
			INTO @c_tr_code,@c_tr_pr_code,@c_emp_code
			END
		
		CLOSE @cursor_e
		DEALLOCATE @cursor_e
		
	if @v_cnt = 0 
	begin
		set @v_error = 'NO record has been posted. Make sure all account setups are done..'
		RAISERROR (@v_error, 16,1)
	end
	else
	begin
		select @v_post=pr_post_payroll from shr_payrolls where pr_code = @v_pr_code
		
		if @v_post='YES' 
		begin try
			exec [dbo].[post_payroll] @v_tr_code,@v_auth_by
		end try
		begin catch
			set @v_error = 'Posting...' + ERROR_MESSAGE()
			RAISERROR (@v_error, 16,1)
		end catch

		update shr_transactions
		set tr_authorised='YES',
			tr_authorised_by=@v_auth_by,
			tr_authorised_date=getdate()
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


