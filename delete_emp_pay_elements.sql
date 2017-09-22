DROP PROCEDURE IF EXISTS `delete_emp_pay_elements`;

DELIMITER $$

CREATE PROCEDURE `delete_emp_pay_elements` (v_epe_code int)
BEGIN

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error text;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text= v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
select 'Unable to delete empoyee pay element record' into v_error;
DELETE FROM `serenehrdb`.`shr_emp_pay_elements`
WHERE `epe_code` = v_epe_code;

COMMIT;
END;

$$