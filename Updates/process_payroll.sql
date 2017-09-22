USE [serenehrdb]
GO

/****** Object:  StoredProcedure [dbo].[process_payroll]    Script Date: 2/10/2017 9:44:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE  [dbo].[process_payroll](@v_tr_code  int,
									@v_processed_by  nvarchar(100)
									)as
BEGIN
declare @v_var int;
declare @v_error nvarchar(1000)

	DECLARE @v_date		nvarchar(10)
	DECLARE @v_amt_to_tax   decimal(25,5), @v_nssf_amt   decimal(25,5)
	DECLARE @v_tax_amt  decimal(25,5), @v_prelief_amt  decimal(25,5), 
			@v_inrelief_amt  decimal(25,5), @v_pens_relief_amt  decimal(25,5),
			@v_ppe_ded_amt_b4_tax  decimal(25,5), @v_tot_ded_amt_b4_tax  decimal(25,5), 
			@v_val_of_benfit_amt  decimal(25,5),
			@v_basic_pay  decimal(25,5), @v_tot_month_hrs decimal(25,5)
	DECLARE @v_extra_payable_amt   decimal(25,5), @v_gross_pay  decimal(25,5),
			@v_net_pay  decimal(25,5), @v_tax   decimal(25,5), @v_authorised nvarchar(10)

	DECLARE @v_tx_code  int, @c_element_order int,@c_month int,@c_year INT
	declare @v_str_day nvarchar(2),@v_str_c_month nvarchar(2),@v_str_c_year nvarchar(4)
	DECLARE @c_emp_code int, @v_cnt int, @v_cnt2 INT
	DECLARE @c_epe_code int,@c_epe_amt int,@c_pel_code int, @c_ppe_code INT
	DECLARE @c_pel_sht_desc nvarchar(100), @c_pel_desc nvarchar(100), @c_pel_type nvarchar(100)
	DECLARE @c_deduction  nvarchar(5), @c_pel_taxable  nvarchar(5)
	DECLARE @c_emp_surname nVARCHAR(150)
	DECLARE @c_nontax_allowed_amt  decimal(25,5), @c_prescribed_amt  decimal(25,5), 
			@c_ot_hours  decimal(25,5),
			@c_day1_hrs  decimal(25,5), @c_day2_hrs  decimal(25,5), 
			@c_day3_hrs  decimal(25,5), @c_day4_hrs  decimal(25,5), @c_day5_hrs  decimal(25,5),
			@c_day6_hrs  decimal(25,5), @c_day7_hrs  decimal(25,5)
	DECLARE @v_last_day_of_month int, @v_day int, @v_week_day int
	DECLARE @v_rung_date date, @Now date
	
	DECLARE @cursor_e CURSOR 
	set @cursor_e = cursor fast_forward FOR 
	SELECT emp_code,emp_surname,tr_pr_month,tr_pr_year,
					case when pr_day1_hrs is null then 0 else pr_day1_hrs end  as pr_day1_hrs,
					case when pr_day2_hrs is null then 0 else pr_day2_hrs end  as pr_day2_hrs,
					case when pr_day3_hrs is null then 0 else pr_day3_hrs end  as pr_day3_hrs,
					case when pr_day4_hrs is null then 0 else pr_day4_hrs end  as pr_day4_hrs,
					case when pr_day5_hrs is null then 0 else pr_day5_hrs end  as pr_day5_hrs,
					case when pr_day6_hrs is null then 0 else pr_day6_hrs end  as pr_day6_hrs,
					case when pr_day7_hrs is null then 0 else pr_day7_hrs end  as pr_day7_hrs
					FROM shr_employees,shr_transactions, shr_payrolls
					where tr_pr_code = emp_pr_code and tr_pr_code = pr_code
					and tr_code = @v_tr_code

	--Delete attached inactive pay elements
	DECLARE @cursor_pe_del CURSOR 
	set @cursor_pe_del = cursor fast_forward FOR 
	SELECT epe_code,epe_amt,epe_pel_code
					FROM shr_emp_pay_elements epe
					left join shr_prd_pay_elements ppe on (ppe.ppe_pel_code=epe.epe_pel_code)
					where epe_emp_code = @c_emp_code and epe_status = 'INACTIVE'
					and ppe_tr_code = @v_tr_code

SET IMPLICIT_TRANSACTIONS ON
begin try
	select @v_error = 'Error...'
	select @Now = GETDATE();
	if (@v_tr_code = 0 or @v_tr_code is null) 
	begin
		set @v_error = 'Select a payroll transaction to proceed...';
		RAISERROR (@v_error, 16,1)
	end
	select @v_authorised = tr_authorised from shr_transactions
	where tr_code = @v_tr_code
  
	if (@v_authorised='YES')
	begin
		set @v_error = 'The payroll transaction is already authorised...';
		RAISERROR (@v_error, 16,1)
	end
		
	set @v_cnt = 0  
	OPEN @cursor_e
		FETCH  NEXT FROM @cursor_e
		INTO @c_emp_code,@c_emp_surname,@c_month,@c_year,
			@c_day1_hrs, @c_day2_hrs, @c_day3_hrs, @c_day4_hrs, @c_day5_hrs, @c_day6_hrs, @c_day7_hrs

		WHILE @@FETCH_STATUS = 0
		BEGIN
		
		select @v_cnt=0, @v_cnt2=0
		set @v_nssf_amt = 0
		set @v_prelief_amt = 0
		set @v_inrelief_amt = 0
		set @v_pens_relief_amt = 0
		set @v_ppe_ded_amt_b4_tax = 0
		set @v_tot_ded_amt_b4_tax = 0
		set @v_val_of_benfit_amt = 0
		set @v_extra_payable_amt = 0
		set @v_amt_to_tax = 0
		select @v_basic_pay = 0,@v_gross_pay=0,@v_net_pay=0,@v_tax=0
		set @v_tot_month_hrs = 0

		--Get the total working hours for the month
		set @v_day = 1
		SELECT @v_str_c_month = RIGHT ('00'+ CAST (@c_month AS nvarchar), 2),
			   @v_str_c_year = CAST (@c_year AS nvarchar),
			   @v_str_day = RIGHT ('00'+ CAST (@v_day AS nvarchar), 2)
		
		--select Day(last_day(STR_TO_DATE(concat('01/',c_month,'/',c_year),'%d/%m/%Y'))) into v_last_day_of_month;
		--getting the last day of the month
		select @v_last_day_of_month = convert(int,DATEDIFF(m,0,CONVERT(date, '01/'+@v_str_c_month+'/'+@v_str_c_year)))+1
		select @v_last_day_of_month = convert(int,DATEADD(mm, @v_last_day_of_month ,0))
		select @v_last_day_of_month = convert(int,DATEADD(d, -1, @v_last_day_of_month))
		select @v_rung_date = DATEADD(d, @v_last_day_of_month, CONVERT(date, @v_str_day+'/'+@v_str_c_month+'/'+@v_str_c_year,103))
		select @v_last_day_of_month = datepart(dd,@v_rung_date)
				
		while (@v_day <= @v_last_day_of_month and @v_day >=1)
		begin
			select @v_str_day = RIGHT ('00'+ CAST (@v_day AS nvarchar), 2)
			--select STR_TO_DATE(concat(v_day,'/',c_month,'/',c_year),'%d/%m/%Y') into v_rung_date;
			select @v_rung_date = CONVERT(date, @v_str_day+'/'+@v_str_c_month+'/'+@v_str_c_year,103)
			select @v_week_day = datepart(dw,@v_rung_date)
					/*case when WEEKDAY(@v_rung_date) = 7 then 1
					when WEEKDAY(@v_rung_date) = 0 then 2
					when WEEKDAY(@v_rung_date) = 1 then 3
					when WEEKDAY(@v_rung_date) = 2 then 4
					when WEEKDAY(@v_rung_date) = 3 then 5
					when WEEKDAY(@v_rung_date) = 4 then 6
					when WEEKDAY(@v_rung_date) = 5 then 7
					when WEEKDAY(@v_rung_date) = 6 then 0 end
					COMMENT 'Day 1 (Sunday) working hours',
					COMMENT 'Day 2 (Monday) working hours',
					COMMENT 'Day 3 (Tuesday) working hours',
					COMMENT 'Day 4 (Wednesday) working hours',
					COMMENT 'Day 5 (Thursday) working hours',
					COMMENT 'Day 6 (Friday) working hours',
					COMMENT 'Day 7 (Saturday) working hours'*/
			if @v_week_day = 1 
				set @v_tot_month_hrs = @v_tot_month_hrs + @c_day1_hrs
			else if @v_week_day = 2 
				set @v_tot_month_hrs = @v_tot_month_hrs + @c_day2_hrs
			else if @v_week_day = 3 
				set @v_tot_month_hrs = @v_tot_month_hrs + @c_day3_hrs
			else if @v_week_day = 4 
				set @v_tot_month_hrs = @v_tot_month_hrs + @c_day4_hrs
			else if @v_week_day = 5 
				set @v_tot_month_hrs = @v_tot_month_hrs + @c_day5_hrs
			else if @v_week_day = 6 
				set @v_tot_month_hrs = @v_tot_month_hrs + @c_day6_hrs
			else if @v_week_day = 7 
				set @v_tot_month_hrs = @v_tot_month_hrs + @c_day7_hrs
			
			--NEXT
			set @v_day = @v_day + 1
		end --end while loop

		if @v_day = 1 
		begin
			select @v_error = ' Error... Month hrs='+ @v_tot_month_hrs+' last='+ @v_last_day_of_month+ ' day='+ @v_day+' week_day='+@v_week_day
			RAISERROR (@v_error, 16,1)
		end

		SELECT @v_cnt = count(1)
		FROM shr_emp_pay_elements epe
		left join shr_prd_pay_elements ppe 
				on (ppe.ppe_pel_code=epe.epe_pel_code and ppe.ppe_emp_code=epe.epe_emp_code)
		left join shr_pay_elements pel on (ppe.ppe_pel_code=pel.pel_code)
		where epe_emp_code = @c_emp_code and epe_status = 'ACTIVE'
		and ppe_tr_code = @v_tr_code
		--and pel_sht_desc in ('NSSF','BP','NHIF','PAYE','PRELIEF','PENSION','LIFEINSURANCE','MEDICAL')
		

		DECLARE @cursor_pe CURSOR 
		set @cursor_pe = cursor fast_forward FOR 
		SELECT epe_code,
		case when epe_amt is null then 0 else epe_amt end as epe_amt,
		epe_pel_code, ppe_code,pel_type,
		pel_sht_desc,pel_desc,
		case pel_sht_desc
			when 'NSSF' then 1
			when 'BP' then 2
			when 'NHIF' then 3
			when 'PRELIEF' then 4
			when 'PENSION' then 5
			when 'LIFEINSURANCE' then 6
			when 'MEDICAL' then 7
			when 'GP' then 41
			when 'TP' then 49
			when 'PAYE' then 50
			when 'TAX' then 51
			when 'NP' then 52
			else 40
			end as element_order, pel_deduction, pel_taxable,
		case when pel_nontax_allowed_amt is null then 0 else pel_nontax_allowed_amt end as pel_nontax_allowed_amt,
		case when pel_prescribed_amt is null then 0 else pel_prescribed_amt end as pel_prescribed_amt,
		case when epe_ot_hours is null then 0 else epe_ot_hours end as epe_ot_hours
		FROM shr_emp_pay_elements epe
		left join shr_prd_pay_elements ppe 
				on (ppe.ppe_pel_code=epe.epe_pel_code and ppe.ppe_emp_code=epe.epe_emp_code)
		left join shr_pay_elements pel on (ppe.ppe_pel_code=pel.pel_code)
		where epe_emp_code = @c_emp_code and epe_status = 'ACTIVE'
		and ppe_tr_code = @v_tr_code
		--and pel_sht_desc in ('NSSF','BP','NHIF','PAYE','PRELIEF','PENSION','LIFEINSURANCE','MEDICAL')
		order by element_order;
		OPEN @cursor_pe
			FETCH  NEXT FROM @cursor_pe 
			INTO @c_epe_code,@c_epe_amt,@c_pel_code,@c_ppe_code,@c_pel_type,
							     @c_pel_sht_desc,@c_pel_desc, @c_element_order,@c_deduction,@c_pel_taxable,
								 @c_nontax_allowed_amt,@c_prescribed_amt, @c_ot_hours

			WHILE @@FETCH_STATUS = 0
			BEGIN
				set @v_cnt2 = @v_cnt2 + 1
				if @v_cnt2 > @v_cnt
					BREAK
				
				if @c_epe_amt is  null 	
					set @c_epe_amt = 0
				
				set @v_tx_code = null
				set @v_tax_amt = 0
				if @v_amt_to_tax is null 	
					set @v_amt_to_tax = 0
				
	/*
	if c_emp_code = 34 and c_pel_sht_desc = 'ELEC' then
		set v_error_no = 1;
		
		select concat('xxx c_emp_amt=', 300) into v_error;
		call raise_error();
	end if;*/
				if @c_pel_sht_desc = 'NSSF' 
				begin				
					begin try
						select @v_tx_code = tx_code  from shr_taxes
						where tx_sht_desc = 'NSSF'
					end try
					begin catch
						select @v_error = 'Unable to get NSSF setup rates and taxes.' 
						RAISERROR (@v_error, 16,1)
					end catch
						
					begin try
						exec calc_taxes @v_tx_code,
									@Now,
									@v_amt_to_tax,
									@v_tax_amt
								
						set @v_nssf_amt=@v_tax_amt
						set @c_epe_amt = @v_tax_amt
						set @v_ppe_ded_amt_b4_tax = @v_nssf_amt
						set @v_tot_ded_amt_b4_tax = @v_tot_ded_amt_b4_tax + @v_nssf_amt
					end try
					begin catch
						select @v_error = 'Unable to calculate NSSF amount.' 
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'BP' 
				begin
					if @v_nssf_amt is null 
						select @v_nssf_amt = 0
						
					begin try
						select @v_amt_to_tax = @c_epe_amt, @v_basic_pay = @c_epe_amt
					end try
					begin catch
						select @v_error = 'Unable to set basic pay amount.' 
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'PRELIEF' 
				begin
					begin try
						select @v_tx_code = tx_code from shr_taxes
						where tx_sht_desc = 'PRELIEF'
					end try
					begin catch
						select @v_error = 'Unable to fetch pay element details '+ @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
					begin try
						exec calc_taxes @v_tx_code,
									@Now,
									@v_amt_to_tax,
									@v_tax_amt
									
						select @v_prelief_amt = @v_tax_amt,@c_epe_amt=@v_tax_amt
					end try
					begin catch
						select @v_error = 'Unable to calculate ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'PENSION' 
				begin
					begin try
						select @v_tx_code = tx_code from shr_taxes
						where tx_sht_desc = 'PENSION'
					end try
					begin catch
						select @v_error = 'Unable to fetch pay element details '+ @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
									
					begin try
						select @c_epe_amt = case when @c_epe_amt is null then 0 else @c_epe_amt end
						if @c_nontax_allowed_amt > @c_epe_amt 
							set @v_pens_relief_amt = @c_epe_amt
						else if @c_nontax_allowed_amt < @c_epe_amt 
							set @v_pens_relief_amt = @c_nontax_allowed_amt
							
						set @v_ppe_ded_amt_b4_tax = @v_pens_relief_amt
						set @v_tot_ded_amt_b4_tax = @v_tot_ded_amt_b4_tax + @v_pens_relief_amt

						--set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;
					end try
					begin catch
						select @v_error = 'Unable to calculate ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'LIFEINSURANCE' 
				begin
					begin try
						select @v_tx_code = tx_code from shr_taxes
						where tx_sht_desc = 'LIFEINSURANCE'
					end try
					begin catch
						select @v_error = 'Unable to fetch pay element details ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
					begin try
						select @c_epe_amt = case when @c_epe_amt is null then 0 else @c_epe_amt end
						if @c_nontax_allowed_amt > @c_epe_amt 
							set @v_inrelief_amt = @c_epe_amt
						else if @c_nontax_allowed_amt < @c_epe_amt 
							set @v_inrelief_amt = @c_nontax_allowed_amt	
							
						set @v_ppe_ded_amt_b4_tax = @v_inrelief_amt
						set @v_tot_ded_amt_b4_tax = @v_tot_ded_amt_b4_tax + @v_inrelief_amt

						--set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;
					end try
					begin catch
						select @v_error = 'Unable to calculate ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'MEDICAL' 
				begin
					begin try
						select @v_tx_code = tx_code from shr_taxes
						where tx_sht_desc = 'MEDICAL'
					end try
					begin catch
						select @v_error = 'Unable to fetch pay element details ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
					
					begin try
						select @c_epe_amt = case when @c_epe_amt is null then 0 else @c_epe_amt end
						if @c_nontax_allowed_amt > @c_epe_amt 
							set @v_inrelief_amt = @c_epe_amt
						else if @c_nontax_allowed_amt < @c_epe_amt 
							set @v_inrelief_amt = @c_nontax_allowed_amt
							
						set @v_ppe_ded_amt_b4_tax = @v_inrelief_amt;
						set @v_tot_ded_amt_b4_tax = @v_tot_ded_amt_b4_tax + @v_inrelief_amt;

						--#set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;
					end try
					begin catch
						select @v_error = 'Unable to calculate ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'NORMALOT'
				begin
					begin try
						select @v_basic_pay = case when @v_basic_pay is null then 0 else @v_basic_pay end
						select @v_tot_month_hrs = case when @v_tot_month_hrs is null then 1
							   when @v_tot_month_hrs = 0 then 1
							   else @v_tot_month_hrs end
					end try
					begin catch
						select @v_error = 'Unable to fetch pay element details ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
					
					begin try
						if @v_tot_month_hrs > 1 
						begin
							set @c_epe_amt = round((@v_basic_pay/@v_tot_month_hrs) * 1.5 * @c_ot_hours,2)
							if @c_deduction = 'NO' 
								set @v_extra_payable_amt = @v_extra_payable_amt + @c_epe_amt
							else
								set @v_extra_payable_amt = @v_extra_payable_amt - @c_epe_amt							
						end
					end try
					begin catch
						select @v_error = 'Unable to calculate ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'HOLIDAYOT' 
				begin
					begin try
						select @v_basic_pay = case when @v_basic_pay is null then 0 else @v_basic_pay end
						select @v_tot_month_hrs = case when @v_tot_month_hrs is null then 1
							   when @v_tot_month_hrs = 0 then 1
							   else @v_tot_month_hrs end
					end try
					begin catch
						select @v_error = 'Unable to fetch pay element details ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
					begin try
						if @v_tot_month_hrs > 1 
						begin
							set @c_epe_amt = round((@v_basic_pay/@v_tot_month_hrs) * 2 * @c_ot_hours,2)
							if @c_deduction = 'NO' 
								set @v_extra_payable_amt = @v_extra_payable_amt + @c_epe_amt
							else
								set @v_extra_payable_amt = @v_extra_payable_amt - @c_epe_amt						
						end
					end try
					begin catch
						select @v_error = 'Unable to calculate ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'ABSENCE' 
				begin
					begin try
						select @v_basic_pay = case when @v_basic_pay is null then 0 else @v_basic_pay end
						select @v_tot_month_hrs = case when @v_tot_month_hrs is null then 1
							   when @v_tot_month_hrs = 0 then 1
							   else @v_tot_month_hrs end
					end try
					begin catch
						select @v_error = 'Unable to fetch pay element details ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
					
					begin try
						if @v_tot_month_hrs > 1 
						begin
							set @c_epe_amt = round((@v_basic_pay/@v_tot_month_hrs) * @c_ot_hours,2)
							set @v_extra_payable_amt = @v_extra_payable_amt - @c_epe_amt;
						end
					end try
					begin catch
						select @v_error = 'Unable to calculate ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'NHIF'
				begin
					begin try
						select @v_tx_code = tx_code from shr_taxes
						where tx_sht_desc = 'NHIF'
					end try
					begin catch
						select @v_error = 'Unable to get NHIF setup rates and taxes. ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
					
					begin try
						exec calc_taxes @v_tx_code,
									@Now,
									@v_amt_to_tax,
									@v_tax_amt
									
						set @c_epe_amt = @v_tax_amt
					end try
					begin catch
						select @v_error = 'Unable to calculate ' + @c_pel_desc+' c_emp_code='+ @c_emp_code+' v_tr_code='+@v_tr_code
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'GP' 
				begin
					begin try
						select @v_gross_pay = case when @v_gross_pay is null then 0 else @v_gross_pay end
						set @c_epe_amt = @v_gross_pay
					end try
					begin catch
						select @v_error = 'Unable to calculate gross pay...'+@c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'TP' 
				begin
					begin try
						select @v_extra_payable_amt = case when @v_extra_payable_amt is null then 0 else @v_extra_payable_amt end 
						select @v_nssf_amt = case when @v_nssf_amt is null then 0 else @v_nssf_amt end
						--select case when v_inrelief_amt is null then 0 else v_inrelief_amt end into v_inrelief_amt;
						--select case when v_pens_relief_amt is null then 0 else v_pens_relief_amt end into v_pens_relief_amt;
						set @v_amt_to_tax = @v_amt_to_tax + @v_extra_payable_amt 
											- @v_tot_ded_amt_b4_tax
						set @c_epe_amt = @v_amt_to_tax
					end try
					begin catch
						select @v_error = 'Unable to calculate taxable pay....'+@c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'NP' 
				begin
					begin try
						select @v_net_pay = case when @v_net_pay is null then 0 else @v_net_pay end 
						set @c_epe_amt = @v_net_pay
					end try
					begin catch
						select @v_error = 'Unable to calculate net pay...'+@c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'TAX' 
				begin
					begin try
						select @v_tax = case when @v_tax is null then 0 else @v_tax end
						set @c_epe_amt = @v_tax
					end try
					begin catch
						select @v_error = 'Unable to calculate tax...'+@c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_pel_sht_desc = 'PAYE' 
				begin
					begin try
						select @v_tx_code = tx_code from shr_taxes
						where tx_sht_desc = 'PAYE'				
					end try
					begin catch
						select @v_error = 'Unable to get PAYE setup rates and taxes...'+@c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch

					begin try
						exec calc_taxes @v_tx_code,
									@Now,
									@v_amt_to_tax,
									@v_tax_amt
									
					end try
					begin catch
						select @v_error = 'Unable to compute PAYE amount to @@v_amt_to_tax=' + CONVERT(nvarchar,ROUND(@v_amt_to_tax,0))
						RAISERROR (@v_error, 16,1)
					end catch
					
					begin try
						select @v_prelief_amt = case when @v_prelief_amt is null then 0 else @v_prelief_amt end
						select @c_epe_amt = @v_tax_amt - @v_prelief_amt, @v_tax = @v_tax_amt
					end try
					
					begin catch
						select @v_error = 'Unable to update PAYE. PAYE amount='+ @v_tax_amt
						RAISERROR (@v_error, 16,1)
					end catch
				end
				else if @c_element_order = 40 and @c_pel_taxable = 'YES'  /*and c_pel_type = 'BENEFIT'*/ 
				begin
					begin try
						select @c_epe_amt = case when @c_epe_amt is null then 0 else @c_epe_amt end

						--set v_tot_val_of_benfit_amt = v_tot_val_of_benfit_amt + v_val_of_benfit_amt;
						if @c_deduction = 'NO' 
							set @v_extra_payable_amt = @v_extra_payable_amt + @c_epe_amt
						else
							set @v_extra_payable_amt = @v_extra_payable_amt - @c_epe_amt
					end try
					begin catch
						select @v_error = 'Unable to calculate ' + @c_pel_desc
						RAISERROR (@v_error, 16,1)
					end catch
				end

				if @c_pel_sht_desc not in ('PAYE','NSSF','NHIF','GP','TP','NP','PRELIEF','LIFEINSURANCE') 
				begin
					if @c_deduction = 'NO' 
					begin
						set @v_gross_pay = @v_gross_pay + @c_epe_amt
					--else
						--set @v_gross_pay = @v_gross_pay - @c_epe_amt
					end 
				end

				if @c_pel_sht_desc not in ('GP','TP','NP','PRELIEF') and @c_pel_type != 'STATEMENT ITEM' 
				begin
					if @c_deduction = 'NO' 
						set @v_net_pay = @v_net_pay + @c_epe_amt
					else
						set @v_net_pay = @v_net_pay - @c_epe_amt
					 
				end
				if @c_epe_amt is  null 	
					set @c_epe_amt = 0
				
				begin try
					update shr_prd_pay_elements
					set ppe_amt = @c_epe_amt,
						ppe_ded_amt_b4_tax = @v_ppe_ded_amt_b4_tax,
						ppe_val_of_benfit_amt = @v_val_of_benfit_amt,
						ppe_ot_hours = @c_ot_hours
					where ppe_code = @c_ppe_code
				end try
				begin catch
					select @v_error = 'Unable to update Payroll Pay Element...ppe_code='+ @c_ppe_code
					RAISERROR (@v_error, 16,1)
				end catch
				if @v_cnt2 > 2 and @v_basic_pay = 0 
				begin try
					update shr_prd_pay_elements
					set ppe_amt = 0,
						ppe_ded_amt_b4_tax = 0,
						ppe_val_of_benfit_amt = 0,
						ppe_ot_hours = 0
					where ppe_emp_code = @c_emp_code and  ppe_tr_code = @v_tr_code
					select @v_ppe_ded_amt_b4_tax = 0,@v_val_of_benfit_amt=0
				end try
				begin catch
					select @v_error = 'Unable to update zero payable amount...'+ @c_ppe_code
					RAISERROR (@v_error, 16,1)
				end catch
				
				FETCH  NEXT FROM @cursor_pe 
				INTO @c_epe_code,@c_epe_amt,@c_pel_code,@c_ppe_code,@c_pel_type,
									 @c_pel_sht_desc,@c_pel_desc, @c_element_order,@c_deduction,@c_pel_taxable,
									 @c_nontax_allowed_amt,@c_prescribed_amt, @c_ot_hours

			END
			CLOSE @cursor_pe
			DEALLOCATE @cursor_pe
		  
			FETCH  NEXT FROM @cursor_e
			INTO @c_emp_code,@c_emp_surname,@c_month,@c_year,
				@c_day1_hrs, @c_day2_hrs, @c_day3_hrs, @c_day4_hrs, @c_day5_hrs, @c_day6_hrs, @c_day7_hrs

		END
		CLOSE @cursor_e
		DEALLOCATE @cursor_e

	  COMMIT
END TRY
BEGIN CATCH
	set @v_error ='Error processing payroll..'  + ERROR_MESSAGE()
	ROLLBACK
	RAISERROR (@v_error, 16,1)
END CATCH
END 

GO


