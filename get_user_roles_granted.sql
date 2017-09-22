DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_user_roles_granted`;

DELIMITER $$
CREATE PROCEDURE `get_user_roles_granted`(v_usr_code bigint)
begin
SELECT `ur_code`,`ur_name`,`ur_desc`,`usg_code`
FROM `serenehrdb`.`shr_user_roles_granted` usg
left join `serenehrdb`.`shr_user_roles` ur on (ur.ur_code=usg_ur_code)
where usg_usr_code = v_usr_code

;

end$$
DELIMITER ;



