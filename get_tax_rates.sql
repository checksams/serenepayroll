DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_tax_rates`;

DELIMITER $$
CREATE PROCEDURE `get_tax_rates`(v_tx_code  int)
begin
SELECT `txr_code`,`txr_desc`,`txr_rate_type`,`txr_rate`, `txr_div_factr`,
    DATE_FORMAT(`txr_wef`,'%d/%m/%Y') as txr_wef, 
	DATE_FORMAT(`txr_wet`,'%d/%m/%Y') as txr_wet,  `txr_tx_code`,`txr_range_from`,`txr_range_to`,
	`txr_frequency`
FROM `serenehrdb`.`shr_tax_rates` `tr`
left join `serenehrdb`.`shr_taxes` `t` on (tr.txr_tx_code = t.tx_code)
where `txr_tx_code` = v_tx_code
;
end$$
DELIMITER ;
