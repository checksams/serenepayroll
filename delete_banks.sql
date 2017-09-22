DROP PROCEDURE IF EXISTS `delete_banks`;

DELIMITER $$

CREATE PROCEDURE `delete_banks` (v_bnk_code int)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Unable to delete bank record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Bank already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
DELETE FROM `serenehrdb`.`shr_banks`
WHERE `bnk_code` = v_bnk_code;

COMMIT;
END;

$$