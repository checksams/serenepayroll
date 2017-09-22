USE [serenehrdb]
GO

/****** Object:  StoredProcedure [dbo].[post_payroll]    Script Date: 9/16/2017 1:02:40 PM ******/
DROP PROCEDURE [dbo].[post_payroll]
GO

/****** Object:  StoredProcedure [dbo].[post_payroll]    Script Date: 9/16/2017 1:02:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[post_payroll](@v_tr_code int,
									@v_auth_by nvarchar(45)) AS
BEGIN
declare @v_error nvarchar(1000),
		@v_postDate datetime, @v_authorised nvarchar(5),
		@v_gl_code   nvarchar(45), @v_cnt bigint, @v_prvg_cnt int,
		@v_days_infuture decimal(10), @v_vch_cnt bigint

declare @c_tr_code bigint,@c_tr_pr_code bigint,@c_emp_code bigint, @c_emp_sht_desc  nvarchar(45),
		@c_emp_name  nvarchar(45),
		@c_pel_code bigint,@c_ppe_code bigint,@c_pel_sht_desc nvarchar(45),
		@c_pel_desc nvarchar(150),
		@c_ppe_amt decimal(23,5),
		@c_pel_dr_gl_code nvarchar(5), @c_pel_cr_gl_code nvarchar(5), 
		@c_drcr nvarchar(5),@c_apt_code  bigint,
		
		@VCH_VOUCHER_NO nvarchar(20),
		@VCH_DESCRIPTION nvarchar(50),
		@VCH_DONEBY nvarchar(50),
		@VCH_BRN_CODE bigint,
		@VCH_CODE bigint,
		@ORG_CODE int,
		@TRN_CODE bigint,
		@TRN_TRANSCODE nvarchar(30),
		@TRN_ACC_CODE	bigint

	DECLARE @cursor_e CURSOR 
	set @cursor_e = cursor fast_forward FOR 
		select tr_code,tr_pr_code,emp_code, emp_sht_desc,concat(emp_other_names, ' ', emp_surname) emp_name
		from shr_prd_pay_elements ppe
		left join shr_employees emp on (ppe.ppe_emp_code=emp.emp_code)
		left join shr_pay_elements pel on (pel.pel_code=ppe.ppe_pel_code)
		left join shr_transactions tr on (tr.tr_code=ppe.ppe_tr_code)
		where tr_code = @v_tr_code
		and pel_type <> 'STATEMENT ITEM'
		group by tr_code,tr_pr_code,emp_code, emp_sht_desc,concat(emp_other_names, ' ', emp_surname)
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

	if (@v_tr_code = 0 or @v_tr_code is null) 
	begin
		set @v_error = 'Select a payroll transaction to proceed...'
		RAISERROR (@v_error, 16,1)
	end
	
	OPEN @cursor_e
		FETCH  NEXT FROM @cursor_e
		INTO @c_tr_code,@c_tr_pr_code,@c_emp_code, @c_emp_sht_desc,@c_emp_name

			WHILE @@FETCH_STATUS = 0
			BEGIN	
			set @cursor_t = cursor fast_forward FOR 
				select apt_code,apt_pel_code,apt_ppe_code,concat(apt_pel_desc,' - ', @c_emp_sht_desc),abs(apt_amt),
				apt_gl_code,apt_dr_cr
				from shr_auth_payroll_trans apt
				where apt_emp_code = @c_emp_code and apt_tr_code = @c_tr_code
				order by apt_pel_code
				
				set @v_vch_cnt = 0
				set @VCH_VOUCHER_NO = ''	
				set @VCH_CODE = 0
				set @ORG_CODE = 1
				set @VCH_DESCRIPTION = CONCAT('SALARY PAYMENT VOUCHER - ', @c_emp_name)
				
				SELECT @VCH_BRN_CODE=BRN_CODE FROM [KAPSARA].[dbo].[DX_BRANCHES] WHERE BRN_ORG_CODE=1
					
				OPEN @cursor_t
					FETCH  NEXT FROM @cursor_t
					INTO @c_apt_code, @c_pel_code,@c_ppe_code,@c_pel_desc,
						@c_ppe_amt, @v_gl_code, @c_drcr
					WHILE @@FETCH_STATUS = 0
					BEGIN

						begin try 							
							set @TRN_CODE = 0
							set @TRN_TRANSCODE = ''
							begin
								if @v_gl_code is null
								begin
									select @v_error = 'Set the ' + case when @c_drcr = 'D' then 'Debit '
														else 'Credit ' end + ' G.L. code for pay element '
														+ @c_pel_desc + '...'
									RAISERROR (@v_error, 16,1)
								end;
																					
								set @v_cnt = @v_cnt + 1							
								set @v_vch_cnt = @v_vch_cnt + 1
								
								if @v_vch_cnt = 1
								begin try
									exec [KAPSARA].[dbo].[fms_create_voucher_org] 
														@VCH_VOUCHER_NO OUTPUT, -- nvarchar(20) output,
														@VCH_DESCRIPTION, -- nvarchar(50),
														@v_auth_by,  --@VCH_DONEBY nvarchar(50),
														@VCH_BRN_CODE, -- int,
														@VCH_CODE OUTPUT, -- int output,
														@ORG_CODE --int

									set @VCH_VOUCHER_NO = convert(nvarchar,@VCH_CODE)
								end try
								begin catch
									SET @v_error = concat('Error creating voucher..',@VCH_DESCRIPTION) + ERROR_MESSAGE()
									RAISERROR (@v_error, 16,1)
								end catch

								begin try
									select @TRN_ACC_CODE=acc_code from [KAPSARA].[dbo].[FMS_ACCOUNTS]
									where acc_sht_desc=@v_gl_code

									exec [KAPSARA].[dbo].[Fms_create_vouch_trans]
												@TRN_CODE OUTPUT, -- int output,
												@TRN_TRANSCODE OUTPUT, -- nvarchar(30) output,
												@c_drcr, --@TRN_DRCR nvarchar(5),
												@c_ppe_amt, --@TRN_AMOUNT numeric(18, 2),
												@VCH_CODE, -- int,
												@c_pel_desc, --@TRN_DESCRIPTION nvarchar(200),
												@TRN_ACC_CODE, -- int,
												@v_gl_code  --@TRN_GLACC nvarchar(15)
											
									update shr_auth_payroll_trans
									set apt_fms_trn_code = @TRN_CODE, apt_fms_trans_no=@TRN_TRANSCODE,
										apt_vouher_no = @VCH_VOUCHER_NO, apt_vch_code=@VCH_CODE
									where apt_code = @c_apt_code
								end try
								begin catch
									SET @v_error = concat('Error creating voucher transaction..',@VCH_DESCRIPTION) + ERROR_MESSAGE()
									RAISERROR (@v_error, 16,1)
								end catch
							end
						end try
						begin catch
							SET @v_error = 'Logging payment records..' + ERROR_MESSAGE()
							RAISERROR (@v_error, 16,1)
						end catch
		
					FETCH  NEXT FROM @cursor_t
					INTO @c_apt_code, @c_pel_code,@c_ppe_code,@c_pel_desc,
						@c_ppe_amt, @v_gl_code, @c_drcr
					END
				CLOSE @cursor_t
				DEALLOCATE @cursor_t

				if @v_vch_cnt > 0
				begin try
					exec [KAPSARA].[dbo].[Post_voucher] @VCH_CODE, @v_auth_by
				end try
				begin catch
					SET @v_error = concat('Posting payment records..',@VCH_DESCRIPTION) + ERROR_MESSAGE()
					RAISERROR (@v_error, 16,1)
				end catch
			FETCH  NEXT FROM @cursor_e
			INTO @c_tr_code,@c_tr_pr_code,@c_emp_code, @c_emp_sht_desc,@c_emp_name
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
	begin try
		rollback
	end try
	begin catch
		
	end catch
	RAISERROR (@v_error, 16,1)
END CATCH
END 



GO


