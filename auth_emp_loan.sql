DROP PROCEDURE IF EXISTS `auth_emp_loan`;

DELIMITER $$

CREATE PROCEDURE `auth_emp_loan` (v_el_code int,
									v_user varchar(100))
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_authorised,v_processed varchar(5);
declare v_error TEXT;

declare v_eff_date datetime;
declare v_intr_rate,v_intr_div_factr decimal(25,5);
declare v_lt_code bigint;
declare done boolean;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
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
SELECT el_eff_date,el_authorised,el_lt_code,
	  case when el_processed is null then 'NO' else el_processed end as el_processed
into v_eff_date,v_authorised,v_lt_code,v_processed
FROM `serenehrdb`.`shr_emp_loans` el
left join `serenehrdb`.`shr_loan_types`  lt on (el.el_lt_code=lt.lt_code)
where el_code = v_el_code;

if v_processed != 'YES' or v_processed is null then	
	set v_error_no = 1;
	set v_error = ' ';
	select concat(v_error,'Process loan first to proceed... Loan Id=', v_el_code,
			' processed=', v_processed) into v_error;
	call raise_error();
end if;

if v_authorised != 'NO' then	
	set v_error_no = 1;
	set v_error = ' ';
	select concat(v_error,'Authorising authorised transactions is not allowed...Loan Id=', v_el_code,
			' Authorised=', v_authorised) into v_error;
	call raise_error();
end if;

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to authorise loan...Loan Id=', v_el_code) into v_error;
Update `serenehrdb`.`shr_emp_loans`
	set `el_authorised_by` = v_user, 
		`el_authorised_date` = Now(), 
		`el_authorised` = 'YES'
WHERE `el_code` = v_el_code;

COMMIT;
END;

$$