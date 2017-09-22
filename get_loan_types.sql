DROP PROCEDURE IF EXISTS `get_loan_types`;

DELIMITER $$
CREATE PROCEDURE `get_loan_types`()
begin
SELECT `lt_code`,`lt_sht_desc`,`lt_desc`,`lt_min_repay_prd`,
    `lt_max_repay_prd`,`lt_min_amt`,`lt_max_amt`,`lt_wef`,`lt_wet`
FROM `serenehrdb`.`shr_loan_types`
;
end$$
DELIMITER ;

