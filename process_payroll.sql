DROP PROCEDURE IF EXISTS `process_payroll`;

DELIMITER $$

CREATE PROCEDURE `process_payroll`(v_tr_code  int,
									v_processed_by  varchar(100)
									)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, v_var int;
declare v_error text;

	DECLARE v_date		varchar(10);
	DECLARE v_amt_to_tax, v_nssf_amt   decimal(25,5);
	DECLARE v_tax_amt, v_prelief_amt, v_inrelief_amt, v_pens_relief_amt,
			v_ppe_ded_amt_b4_tax, v_tot_ded_amt_b4_tax, v_val_of_benfit_amt,
			v_basic_pay, v_tot_month_hrs decimal(25,5);
	DECLARE v_extra_payable_amt, v_gross_pay, v_net_pay, v_tax   decimal(25,5);

	DECLARE v_tx_code, c_element_order,c_month,c_year INT;
	DECLARE c_emp_code, v_cnt, v_cnt2 INT;
	DECLARE c_epe_code,c_epe_amt,c_pel_code, c_ppe_code BIGINT;
	DECLARE c_pel_sht_desc, c_pel_desc, c_pel_type varchar(100);
	DECLARE c_deduction, c_pel_taxable  varchar(5);
	DECLARE c_emp_surname VARCHAR(150);
	DECLARE c_nontax_allowed_amt, c_prescribed_amt, c_ot_hours,
			c_day1_hrs, c_day2_hrs, c_day3_hrs, c_day4_hrs, c_day5_hrs,
			c_day6_hrs, c_day7_hrs  decimal(25,5); 
	DECLARE v_last_day_of_month, v_day, v_week_day int;
	DECLARE v_rung_date date;
	
	declare done boolean;

	DECLARE cursor_e CURSOR FOR SELECT emp_code,emp_surname,tr_pr_month,tr_pr_year,
					case when pr_day1_hrs is null then 0 else pr_day1_hrs end  as pr_day1_hrs,
					case when pr_day2_hrs is null then 0 else pr_day2_hrs end  as pr_day2_hrs,
					case when pr_day3_hrs is null then 0 else pr_day3_hrs end  as pr_day3_hrs,
					case when pr_day4_hrs is null then 0 else pr_day4_hrs end  as pr_day4_hrs,
					case when pr_day5_hrs is null then 0 else pr_day5_hrs end  as pr_day5_hrs,
					case when pr_day6_hrs is null then 0 else pr_day6_hrs end  as pr_day6_hrs,
					case when pr_day7_hrs is null then 0 else pr_day7_hrs end  as pr_day7_hrs
					FROM shr_employees,`shr_transactions`, shr_payrolls
					where tr_pr_code = emp_pr_code and tr_pr_code = pr_code
					and tr_code = v_tr_code;

	DECLARE cursor_pe CURSOR FOR SELECT epe_code,
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
					FROM `shr_emp_pay_elements` epe
					left join `shr_prd_pay_elements` ppe 
							on (ppe.ppe_pel_code=epe.epe_pel_code and ppe.ppe_emp_code=epe.epe_emp_code)
					left join `shr_pay_elements` pel on (ppe.ppe_pel_code=pel.pel_code)
					where epe_emp_code = c_emp_code and epe_status = 'ACTIVE'
					and ppe_tr_code = v_tr_code
					#and pel_sht_desc in ('NSSF','BP','NHIF','PAYE','PRELIEF','PENSION','LIFEINSURANCE','MEDICAL')
					order by element_order;

	#Delete attached inactive pay elements
	DECLARE cursor_pe_del CURSOR FOR SELECT epe_code,epe_amt,epe_pel_code
					FROM `shr_emp_pay_elements` epe
					left join `shr_prd_pay_elements` ppe on (ppe.ppe_pel_code=epe.epe_pel_code)
					where epe_emp_code = c_emp_code and epe_status = 'INACTIVE'
					and ppe_tr_code = v_tr_code;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 
			sqlstate_code = RETURNED_SQLSTATE, 
			mysql_error = MYSQL_ERRNO, 
			message_text = MESSAGE_TEXT;

		if sqlstate_code <> '00000' then
			if v_error_no = 1 then 
				signal sqlstate '45000'
					set message_text= v_error;  #'Debuging';
			elseif v_error_no = 1 then 
				signal sqlstate '45000'
					set message_text= 'Select a payroll transaction to proceed';
			elseif v_error_no = 3 then
				signal sqlstate '45000'
					set message_text= 'xxxxxx';
			else
				#signal sqlstate '45000' set message_text= 'Unable to save records...';
				resignal;
			end if;			
		end if;
		close cursor_e;
		close cursor_pe;
	END;


SET autocommit=0;
START TRANSACTION;
	select 'Error...' into v_error;

	if (v_tr_code = 0 or v_tr_code is null) then
		set v_error_no = 1;
		set v_error = ' ';
		set v_error = 'Select a payroll transaction to proceed...';
		call raise_error();
	end if;

	set v_cnt = 0;  
	OPEN cursor_e;
	  read_loop: LOOP
		FETCH cursor_e INTO c_emp_code,c_emp_surname,c_month,c_year,
			c_day1_hrs, c_day2_hrs, c_day3_hrs, c_day4_hrs, c_day5_hrs, c_day6_hrs, c_day7_hrs;

		IF done THEN
		  LEAVE read_loop;
		END IF;
		
		set v_cnt=0, v_cnt2=0;
		set v_nssf_amt = 0;
		set v_prelief_amt = 0;
		set v_inrelief_amt = 0;
		set v_pens_relief_amt = 0;
		set v_ppe_ded_amt_b4_tax = 0;
		set v_tot_ded_amt_b4_tax = 0;
		set v_val_of_benfit_amt = 0;
		set v_extra_payable_amt = 0;
		set v_amt_to_tax = 0;
		set v_basic_pay = 0,v_gross_pay=0,v_net_pay=0,v_tax=0;
		set v_tot_month_hrs = 0;

		BEGIN
		#Get the total working hours for the month
		set v_day = 1;
		select Day(last_day(STR_TO_DATE(concat('01/',c_month,'/',c_year),'%d/%m/%Y'))) into v_last_day_of_month;
		month_loop: loop
			select STR_TO_DATE(concat(v_day,'/',c_month,'/',c_year),'%d/%m/%Y') into v_rung_date;
			select case when WEEKDAY(now()) = 7 then 1
					when WEEKDAY(v_rung_date) = 0 then 2
					when WEEKDAY(v_rung_date) = 1 then 3
					when WEEKDAY(v_rung_date) = 2 then 4
					when WEEKDAY(v_rung_date) = 3 then 5
					when WEEKDAY(v_rung_date) = 4 then 6
					when WEEKDAY(v_rung_date) = 5 then 7
					when WEEKDAY(v_rung_date) = 6 then 0 end as day into v_week_day;
			if v_week_day = 1 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day1_hrs;
			elseif v_week_day = 2 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day2_hrs;
			elseif v_week_day = 3 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day3_hrs;
			elseif v_week_day = 4 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day4_hrs;
			elseif v_week_day = 5 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day5_hrs;
			elseif v_week_day = 6 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day6_hrs;
			elseif v_week_day = 7 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day7_hrs;
			end if;	
			
			#NEXT
			set v_day = v_day + 1;
			if v_day <= v_last_day_of_month and v_day >=1 then
				ITERATE month_loop;
			end if;
			leave month_loop;
		end loop month_loop;
		END;

		if v_day = 1 then
			set v_error_no = 1;
			select concat('Error... Month hrs=',v_tot_month_hrs,' last=',v_last_day_of_month, ' day=',v_day,' week_day=',v_week_day) into v_error;
			call raise_error();
		end if;

		SELECT count(1) into v_cnt
		FROM `shr_emp_pay_elements` epe
		left join `shr_prd_pay_elements` ppe 
				on (ppe.ppe_pel_code=epe.epe_pel_code and ppe.ppe_emp_code=epe.epe_emp_code)
		left join `shr_pay_elements` pel on (ppe.ppe_pel_code=pel.pel_code)
		where epe_emp_code = c_emp_code and epe_status = 'ACTIVE'
		and ppe_tr_code = v_tr_code
		#and pel_sht_desc in ('NSSF','BP','NHIF','PAYE','PRELIEF','PENSION','LIFEINSURANCE','MEDICAL')
		;

		OPEN cursor_pe;
		  read_pe_loop: LOOP

			FETCH cursor_pe INTO c_epe_code,c_epe_amt,c_pel_code,c_ppe_code,c_pel_type,
							     c_pel_sht_desc,c_pel_desc, c_element_order,c_deduction,c_pel_taxable,
								 c_nontax_allowed_amt,c_prescribed_amt, c_ot_hours;

			/*IF done THEN
			  LEAVE read_pe_loop;
			END IF;*/
			set v_cnt2 = v_cnt2 + 1;
			if v_cnt2 > v_cnt then
				LEAVE read_pe_loop;
			end if;
			if c_epe_amt is  null then	
				set c_epe_amt = 0;
			end if;
			
			set v_tx_code = null;
			set v_tax_amt = 0;
			if v_amt_to_tax is null then	
				set v_amt_to_tax = 0;
			end if;
/*
if c_emp_code = 34 and c_pel_sht_desc = 'ELEC' then
	set v_error_no = 1;
	
	select concat('xxx c_emp_amt=', 300) into v_error;
	call raise_error();
end if;*/
			if c_pel_sht_desc = 'NSSF' then
				set v_error_no = 1;
				select 'Unable to get NSSF setup rates and taxes.' into v_error;
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'NSSF';
				
				set v_error_no = 1;
				select 'Unable to calculate NSSF amount.' into v_error;
				call `calc_taxes`(v_tx_code,
							Now(),
							v_amt_to_tax,
							v_tax_amt
							);
				set v_error_no = 3,v_nssf_amt=v_tax_amt;
				set c_epe_amt = v_tax_amt;
				set v_ppe_ded_amt_b4_tax = v_nssf_amt;
				set v_tot_ded_amt_b4_tax = v_tot_ded_amt_b4_tax + v_nssf_amt;

			elseif c_pel_sht_desc = 'BP' then
				set v_error_no = 1;
				if v_nssf_amt is null then
					set v_nssf_amt = 0;
				end if;
				select 'Unable to set basic pay amount.' into v_error;
				set v_amt_to_tax = c_epe_amt, v_basic_pay = c_epe_amt;

			elseif c_pel_sht_desc = 'PRELIEF' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'PRELIEF';
				set v_error_no = 1;
				select concat('Unable to calculate ', c_pel_desc) into v_error;
				call `calc_taxes`(v_tx_code,
							Now(),
							v_amt_to_tax,
							v_tax_amt
							);
				set v_prelief_amt = v_tax_amt,c_epe_amt=v_tax_amt;

			elseif c_pel_sht_desc = 'PENSION' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'PENSION';

				set v_error_no = 1;
				select concat('Unable to calculate ', c_pel_desc) into v_error;
				
				select case when c_epe_amt is null then 0 else c_epe_amt end into c_epe_amt;
				if c_nontax_allowed_amt > c_epe_amt then
					set v_pens_relief_amt = c_epe_amt;
				elseif c_nontax_allowed_amt < c_epe_amt then
					set v_pens_relief_amt = c_nontax_allowed_amt;					
				end if;
				set v_ppe_ded_amt_b4_tax = v_pens_relief_amt;
				set v_tot_ded_amt_b4_tax = v_tot_ded_amt_b4_tax + v_pens_relief_amt;

				#set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;

			elseif c_pel_sht_desc = 'LIFEINSURANCE' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'LIFEINSURANCE';
				set v_error_no = 1;
				select concat('Unable to calculate ', c_pel_desc) into v_error;
				select case when c_epe_amt is null then 0 else c_epe_amt end into c_epe_amt;
				if c_nontax_allowed_amt > c_epe_amt then
					set v_inrelief_amt = c_epe_amt;
				elseif c_nontax_allowed_amt < c_epe_amt then
					set v_inrelief_amt = c_nontax_allowed_amt;					
				end if;
				set v_ppe_ded_amt_b4_tax = v_inrelief_amt;
				set v_tot_ded_amt_b4_tax = v_tot_ded_amt_b4_tax + v_inrelief_amt;

				#set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;

			elseif c_pel_sht_desc = 'MEDICAL' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'MEDICAL';
				set v_error_no = 1;
				select concat('Unable to calculate ', c_pel_desc) into v_error;
				select case when c_epe_amt is null then 0 else c_epe_amt end into c_epe_amt;
				if c_nontax_allowed_amt > c_epe_amt then
					set v_inrelief_amt = c_epe_amt;
				elseif c_nontax_allowed_amt < c_epe_amt then
					set v_inrelief_amt = c_nontax_allowed_amt;					
				end if;
				set v_ppe_ded_amt_b4_tax = v_inrelief_amt;
				set v_tot_ded_amt_b4_tax = v_tot_ded_amt_b4_tax + v_inrelief_amt;

				#set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;

			elseif c_pel_sht_desc = 'NORMALOT' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				select case when v_basic_pay is null then 0 else v_basic_pay end into v_basic_pay;
				select case when v_tot_month_hrs is null then 1
					   when v_tot_month_hrs = 0 then 1
					   else v_tot_month_hrs end into v_tot_month_hrs;
				
				if v_tot_month_hrs > 1 then
					set c_epe_amt = round((v_basic_pay/v_tot_month_hrs) * 1.5 * c_ot_hours,2); 
					if c_deduction = 'NO' then
						set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;
					else
						set v_extra_payable_amt = v_extra_payable_amt - c_epe_amt;
					end if;
				end if;

			elseif c_pel_sht_desc = 'HOLIDAYOT' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				select case when v_basic_pay is null then 0 else v_basic_pay end into v_basic_pay;
				select case when v_tot_month_hrs is null then 1
					   when v_tot_month_hrs = 0 then 1
					   else v_tot_month_hrs end into v_tot_month_hrs;
				
				if v_tot_month_hrs > 1 then
					set c_epe_amt = round((v_basic_pay/v_tot_month_hrs) * 2 * c_ot_hours,2); 
					if c_deduction = 'NO' then
						set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;
					else
						set v_extra_payable_amt = v_extra_payable_amt - c_epe_amt;
					end if;
				end if;

			elseif c_pel_sht_desc = 'ABSENCE' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				select case when v_basic_pay is null then 0 else v_basic_pay end into v_basic_pay;
				select case when v_tot_month_hrs is null then 1
					   when v_tot_month_hrs = 0 then 1
					   else v_tot_month_hrs end into v_tot_month_hrs;
				
				if v_tot_month_hrs > 1 then
					set c_epe_amt = round((v_basic_pay/v_tot_month_hrs) * c_ot_hours,2); 
					set v_extra_payable_amt = v_extra_payable_amt - c_epe_amt;
				end if;

			elseif c_pel_sht_desc = 'NHIF' then
				set v_error_no = 1;
				select 'Unable to get NHIF setup rates and taxes.' into v_error;
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'NHIF';
				set v_error_no = 1;
				select concat('Unable to calculate ', c_pel_desc,' c_emp_code=',c_emp_code,' v_tr_code=',v_tr_code) into v_error;

				call `calc_taxes`(v_tx_code,
							Now(),
							v_amt_to_tax,
							v_tax_amt
							);
				set v_error_no = 3;
				set c_epe_amt = v_tax_amt;

			elseif c_pel_sht_desc = 'GP' then
				set v_error_no = 1;
				select 'Unable to calculate taxable pay.' into v_error;
				select case when v_gross_pay is null then 0 else v_gross_pay end into v_gross_pay;
				set c_epe_amt = v_gross_pay;

			elseif c_pel_sht_desc = 'TP' then
				set v_error_no = 1;
				select 'Unable to calculate taxable pay.' into v_error;	

				select case when v_extra_payable_amt is null then 0 else v_extra_payable_amt end into v_extra_payable_amt;
				select case when v_nssf_amt is null then 0 else v_nssf_amt end into v_nssf_amt;
				#select case when v_inrelief_amt is null then 0 else v_inrelief_amt end into v_inrelief_amt;
				#select case when v_pens_relief_amt is null then 0 else v_pens_relief_amt end into v_pens_relief_amt;

				set v_amt_to_tax = v_amt_to_tax + v_extra_payable_amt 
									- v_tot_ded_amt_b4_tax;
				set c_epe_amt = v_amt_to_tax;

			elseif c_pel_sht_desc = 'NP' then
				set v_error_no = 1;
				select 'Unable to calculate taxable pay.' into v_error;
				select case when v_net_pay is null then 0 else v_net_pay end into v_net_pay;
				set c_epe_amt = v_net_pay;

			elseif c_pel_sht_desc = 'TAX' then
				set v_error_no = 1;
				select 'Unable to calculate taxable pay.' into v_error;
				select case when v_tax is null then 0 else v_tax end into v_tax;
				set c_epe_amt = v_tax;

			elseif c_pel_sht_desc = 'PAYE' then
				set v_error_no = 1;

				select 'Unable to get PAYE setup rates and taxes.' into v_error;
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'PAYE';
				/*
				select case when v_extra_payable_amt is null then 0 else v_extra_payable_amt end into v_extra_payable_amt;
				select case when v_nssf_amt is null then 0 else v_nssf_amt end into v_nssf_amt;
				#select case when v_inrelief_amt is null then 0 else v_inrelief_amt end into v_inrelief_amt;
				#select case when v_pens_relief_amt is null then 0 else v_pens_relief_amt end into v_pens_relief_amt;

				set v_amt_to_tax = v_amt_to_tax + v_extra_payable_amt 
									- v_tot_ded_amt_b4_tax;
				*/
				set v_error_no = 1;
				select concat('Unable to compute PAYE amount to tax=', v_amt_to_tax) into v_error;

				call `calc_taxes`(v_tx_code,
							Now(),
							v_amt_to_tax,
							v_tax_amt
							);
				set v_error_no = 1;
				select concat('Unable to update PAYE. PAYE amount=',v_tax_amt) into v_error;
				select case when v_prelief_amt is null then 0 else v_prelief_amt end into v_prelief_amt;
				set c_epe_amt = v_tax_amt - v_prelief_amt, v_tax = v_tax_amt;

				/*
				if c_emp_code = 34 then
				select concat('PAYE amount to tax=', v_amt_to_tax, ' ',c_epe_amt,
				' v_extra=',v_extra_payable_amt, 
				' v_tot_ded=',v_tot_ded_amt_b4_tax) into v_error;
				call raise_error();	
				end if;*/

			elseif c_element_order = 40 and c_pel_taxable = 'YES' then /*and c_pel_type = 'BENEFIT'*/ 
				set v_error_no = 1;
				select concat('Unable to calculate ', c_pel_desc) into v_error;
				select case when c_epe_amt is null then 0 else c_epe_amt end into c_epe_amt;

				#set v_tot_val_of_benfit_amt = v_tot_val_of_benfit_amt + v_val_of_benfit_amt;
				if c_deduction = 'NO' then
					set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;
				else
					set v_extra_payable_amt = v_extra_payable_amt - c_epe_amt;
				end if;

			end if;

			if not c_pel_sht_desc in ('PAYE','NSSF','NHIF','GP','TP','NP','PRELIEF','LIFEINSURANCE') then
				if c_deduction = 'NO' then
					set v_gross_pay = v_gross_pay + c_epe_amt;
				#else
					#set v_gross_pay = v_gross_pay - c_epe_amt;
				end if;
			end if;

			if c_pel_sht_desc not in ('GP','TP','NP','PRELIEF') and c_pel_type != 'STATEMENT ITEM' then
				if c_deduction = 'NO' then
					set v_net_pay = v_net_pay + c_epe_amt;
				else
					set v_net_pay = v_net_pay - c_epe_amt;
				end if;
			end if;
			if c_epe_amt is  null then	
				set c_epe_amt = 0;
			end if;

			set v_error_no = 1;
			select concat('Unable to update Payroll Pay Element...ppe_code=',c_ppe_code) into v_error;
			update shr_prd_pay_elements
			set ppe_amt = c_epe_amt,
				ppe_ded_amt_b4_tax = v_ppe_ded_amt_b4_tax,
				ppe_val_of_benfit_amt = v_val_of_benfit_amt,
				ppe_ot_hours = c_ot_hours
			where ppe_code = c_ppe_code;

			if v_cnt2 > 2 and v_basic_pay = 0 then
				set v_error_no = 1;
				select concat('Unable to update zero payable amount',' ') into v_error;
				update shr_prd_pay_elements
				set ppe_amt = 0,
					ppe_ded_amt_b4_tax = 0,
					ppe_val_of_benfit_amt = 0,
					ppe_ot_hours = 0
				where `ppe_emp_code` = c_emp_code and  `ppe_tr_code` = v_tr_code;
			end if;
			set v_ppe_ded_amt_b4_tax = 0,v_val_of_benfit_amt=0;
			set v_error_no = 99999;
		  END LOOP;
		  CLOSE cursor_pe;
		  set done = false;
	  END LOOP;
	  CLOSE cursor_e;

COMMIT;
#END TRANSACTION
END;
$$