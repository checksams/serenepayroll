DROP PROCEDURE IF EXISTS `get_loan_intr_rates`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_loan_intr_rates`(v_lir_code int)
begin
SELECT `lir_code`,`lir_rate`,`lir_div_factr`,
DATE_FORMAT(`lir_wef`,'%d/%m/%Y') as lir_wef,
DATE_FORMAT(`lir_wet`,'%d/%m/%Y') as lir_wet, `lir_lt_code`
FROM `serenehrdb`.`shr_loan_intr_rates`
where `lir_code` = v_lir_code
;
end$$
DELIMITER ;

