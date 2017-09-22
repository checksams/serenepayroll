DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_bank_branches`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_bank_branches`(v_bnk_code int)
begin
SELECT `bbr_code`,`bbr_sht_desc`, `bbr_name`, `bbr_postal_address`,
    `bbr_physical_address`,`bbr_tel_no1`,`bbr_tel_no2`,`bbr_bnk_code`
FROM `serenehrdb`.`shr_bank_branches`
where bbr_bnk_code = v_bnk_code 
;
end$$
DELIMITER ;
