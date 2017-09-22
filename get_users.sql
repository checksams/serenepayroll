DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_users`;

DELIMITER $$
CREATE PROCEDURE `get_users`()
begin
SELECT `usr_code`, `usr_name`, `usr_full_name`,`usr_emp_code`,
`usr_pwd_reset`, `usr_last_login`, `usr_login_atempts`
FROM `serenehrdb`.`shr_users`

;

end$$
DELIMITER ;



