DROP PROCEDURE IF EXISTS `delete_user`;

DELIMITER $$

CREATE PROCEDURE `delete_user` (v_usr_code bigint)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no,v_cnt int;
declare v_authorised varchar(5);
declare v_error TEXT;
declare v_name varchar(45);

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

select count(1) into v_cnt FROM `serenehrdb`.`shr_users`
WHERE `usr_code` = v_usr_code;

if v_cnt > 0 then
select upper(usr_name) into v_name FROM `serenehrdb`.`shr_users`
WHERE `usr_code` = v_usr_code;
	if v_name = 'ADMIN' then
		set v_error_no = 1;
		set v_error = ' ';
		select concat(v_error,'You are not allowed to delete an Administrator...') into v_error;
		call raise_error();
	end if;
end if;

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to delete record...') into v_error;
DELETE FROM `serenehrdb`.`shr_users`
WHERE `usr_code` = v_usr_code;

COMMIT;
END;

$$