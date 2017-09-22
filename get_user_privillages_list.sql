DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_user_privillages_list`;

DELIMITER $$
CREATE PROCEDURE `get_user_privillages_list`(v_ur_code bigint)
begin
SELECT `up_code`,`up_name`,`up_desc`, 
	round(`up_min_amt`)up_min_amt,
	round(`up_max_amt`)up_max_amt,
	up_type
FROM `serenehrdb`.`shr_user_privillages`
where up_code not in (select urp_up_code from `shr_user_role_privlg`
				where urp_ur_code = v_ur_code);

end$$
DELIMITER ;

