DROP PROCEDURE IF EXISTS `delete_user_role_privlg`;

DELIMITER $$

CREATE PROCEDURE `delete_user_role_privlg` (v_urp_code bigint)
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
select concat(v_error,'Unable to delete record...') into v_error;
DELETE FROM `serenehrdb`.`shr_user_role_privlg`
WHERE `urp_code` = v_urp_code;

COMMIT;
END;

$$