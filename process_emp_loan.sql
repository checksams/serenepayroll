DROP PROCEDURE IF EXISTS `process_emp_loan`;

DELIMITER $$

CREATE PROCEDURE `process_emp_loan` (v_el_code int,
									v_user varchar(100))
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, v_tot_instalments int;
declare v_authorised varchar(5);
declare v_error TEXT;

declare v_eff_date datetime;
declare v_final_repay_date date;
declare v_loan_applied_amt,v_service_charge,v_tot_tax_amt,v_instalment_amt decimal(25,5);
declare v_issued_amt,v_intr_rate,v_intr_div_factr decimal(25,5);
declare v_lt_code bigint;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text=v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set v_error = ' ';

if v_user is null or v_user = '' then	
	set v_error_no = 1;
	set v_error = ' ';
	select concat(v_error,'Log in first to proceed...') into v_error;
	call raise_error();
end if;

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to find loan record...') into v_error;
SELECT el_eff_date,el_lt_code,el_tot_instalments,el_instalment_amt,
	case when el_authorised is null then 'NO' else el_authorised end as el_authorised,
	case when el_loan_applied_amt is null then 0 else el_loan_applied_amt end as el_loan_applied_amt,
	case when el_service_charge is null then 0 else el_service_charge end as el_service_charge,
	case when el_tot_tax_amt is null then 0 else el_tot_tax_amt end as el_tot_tax_amt
into v_eff_date,v_lt_code,v_tot_instalments,v_instalment_amt,
	v_authorised,
	v_loan_applied_amt,v_service_charge,v_tot_tax_amt
FROM `serenehrdb`.`shr_emp_loans` el
left join `serenehrdb`.`shr_loan_types`  lt on (el.el_lt_code=lt.lt_code)
where el_code = v_el_code;

if v_authorised != 'NO' then	
	set v_error_no = 1;
	set v_error = ' ';
	select concat(v_error,'Processing authorized transactions is not allowed...Loan Id=', v_el_code,
			' Authorised=', v_authorised) into v_error;
	call raise_error();
end if;

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to fetch loan interest rates..Loan Id=', v_el_code) into v_error;
select `lir_rate`, `lir_div_factr` into v_intr_rate, v_intr_div_factr
from `shr_loan_intr_rates`
where `lir_lt_code` = v_lt_code
and v_eff_date between `lir_wef` and case when `lir_wet` is null then Now() else `lir_wef` end;

set v_issued_amt = v_loan_applied_amt - v_service_charge - v_tot_tax_amt;

	if (not(v_tot_instalments is null or v_tot_instalments = 0)
		and not(v_instalment_amt is null or v_instalment_amt = 0)) then
			if not(v_tot_instalments is null or v_tot_instalments = 0) then
				SELECT DATE_ADD(v_effdate,INTERVAL v_tot_instalments MONTH) into v_final_repay_date;
				if (v_instalment_amt is null or v_instalment_amt = 0) then
					select round(v_loan_applied_amt/v_tot_instalments) into v_instalment_amt;
				end if;
			elseif not(v_instalment_amt is null or v_instalment_amt = 0) then
				select round(v_loan_applied_amt/v_instalment_amt) into v_tot_instalments;
				SELECT DATE_ADD(v_effdate,INTERVAL v_tot_instalments MONTH) into v_final_repay_date;
			else				
				set v_error_no = 1;
				set v_error = ' ';
				select concat(v_error,'Unable to calculate loan installments...') into v_error;
				call raise_error();
			end if;
	end if; 


set v_error_no = 100;
set v_error = ' ';
select concat(v_error,'Unable to update loan record...Loan Id=', v_el_code) into v_error;
Update `serenehrdb`.`shr_emp_loans`
	set el_issued_amt = v_issued_amt,
		el_intr_rate = v_intr_rate,
		el_intr_div_factr = v_intr_div_factr,
		el_processed = 'YES',
		el_processed_by = v_user,
		el_processed_date = Now(),
		el_tot_instalments = v_tot_instalments,
		el_instalment_amt = v_instalment_amt,
		el_final_repay_date = v_final_repay_date
WHERE `el_code` = v_el_code;

COMMIT;
END;

$$