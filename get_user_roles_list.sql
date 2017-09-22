DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_user_roles_list`;

DELIMITER $$
CREATE PROCEDURE `get_user_roles_list`(v_usr_code bigint)
begin
SELECT `ur_code`,`ur_name`,`ur_desc`
FROM `serenehrdb`.`shr_user_roles`
where ur_code not in (select usg_ur_code from `shr_user_roles_granted`
				where usg_usr_code = v_usr_code);
end$$
DELIMITER ;

