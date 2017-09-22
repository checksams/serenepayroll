DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_user_role_privlg`;

DELIMITER $$
CREATE PROCEDURE `get_user_role_privlg`(v_ur_code bigint)
begin
SELECT up_code,up_name,up_type,urp_min_amt, urp_max_amt,urp_code,ur_code,
	case when urp_code is null then 0 else 1 end as checked
FROM `serenehrdb`.`shr_user_privillages` up
left join `serenehrdb`.`shr_user_role_privlg` urp on (urp.urp_up_code = up.up_code)
left join `serenehrdb`.`shr_user_roles` ur on (ur.ur_code = urp.urp_ur_code)
where urp_ur_code = v_ur_code
;

end$$
DELIMITER ;



