DROP PROCEDURE IF EXISTS `delete_emp_loan`;

DELIMITER $$

CREATE PROCEDURE `delete_emp_loan` (v_el_code int)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_authorised varchar(5);
declare v_error TEXT;

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

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to find loan record...') into v_error;
select el_authorised into v_authorised FROM `serenehrdb`.`shr_emp_loans`
WHERE `el_code` = v_el_code;

if v_authorised != 'NO' then	
	set v_error_no = 1;
	set v_error = ' ';
	select concat(v_error,'Deleting authorized transactions is not allowed...Loan Id=', v_el_code,
			' Authorised=', v_authorised) into v_error;
	call raise_error();
end if;

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to delete loan record...Loan Id=', v_el_code) into v_error;
DELETE FROM `serenehrdb`.`shr_emp_loans`
WHERE `el_code` = v_el_code;

COMMIT;
END;

$$