DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_bank_branch_list`;

DELIMITER $$
CREATE PROCEDURE `get_bank_branch_list`(v_bnk_code int)
begin
	select 0 bbr_code, 'null' bbr_sht_desc, '' bbr_name
	union all
	SELECT `bbr_code`,`bbr_sht_desc`, `bbr_name`
	FROM `serenehrdb`.`shr_bank_branches` bbr
	left join `serenehrdb`.`shr_banks` bnk on (bnk.bnk_code = bbr.bbr_bnk_code)
	where bbr_bnk_code = v_bnk_code
	order by bbr_name
;
end$$
DELIMITER ;
