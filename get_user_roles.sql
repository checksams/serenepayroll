DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_user_roles`;

DELIMITER $$
CREATE PROCEDURE `get_user_roles`()
begin
SELECT `ur_code`,`ur_name`,`ur_desc`
FROM `serenehrdb`.`shr_user_roles`;

end$$
DELIMITER ;

