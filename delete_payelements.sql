
DROP PROCEDURE IF EXISTS `delete_payelements`;

DELIMITER $$

CREATE PROCEDURE `delete_payelements` (v_pel_code int)
BEGIN
declare v_sht_desc varchar(100);
declare v_desc varchar(1000);

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error varchar(2000);

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
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
select concat('Empoyee pay element record not found. pel_code=',v_pel_code) into v_error;
select pel_sht_desc,pel_desc into v_sht_desc, v_desc FROM `serenehrdb`.`shr_pay_elements`
WHERE `pel_code` = v_pel_code;

if v_sht_desc in ('BP','NSSF','NHIF','LASC','PAYE','FBFT','LIR','ELEC','WATER','FURNTURE',
				'WATER-AGRIC','	ELEC-AGRIC','	PENSION','PRELIEF','INRELIEF','MEDICAL',
				'NORMALOT','HOLIDAYOT','ABSENCE') then

	select concat('Pay Element (', v_desc, ') is a System defined pay element and therefore cannot be deleted at this level. ') into v_error;
	call raise_error();
end if;
set v_error_no = 1;
select 'Unable to delete employee pay element...' into v_error;
delete from `serenehrdb`.`shr_emp_pay_elements`
where epe_pel_code = v_pel_code;

set v_error_no = 1;
select 'Unable to delete pay element...' into v_error;
DELETE FROM `serenehrdb`.`shr_pay_elements`
WHERE `pel_code` = v_pel_code;

COMMIT;
END;

$$