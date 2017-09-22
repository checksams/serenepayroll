DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_curr_user_priv`;

DELIMITER $$
CREATE PROCEDURE `get_curr_user_priv`(v_user varchar(100))
begin
SELECT ur_name,usr_name,up_name,
`urp_min_amt`, `urp_max_amt`
FROM `serenehrdb`.`shr_users` usr
left join `serenehrdb`.`shr_user_roles_granted` urg on (urg.usg_usr_code = usr.usr_code)
left join `serenehrdb`.`shr_user_roles` ur on (ur.ur_code = urg.usg_ur_code)
left join `serenehrdb`.`shr_user_role_privlg` urp on (urp.urp_ur_code = ur.ur_code)
left join `serenehrdb`.`shr_user_privillages` up on (up.up_code = urp.urp_up_code)
where upper(usr_name) = upper(v_user);

end$$
DELIMITER ;

