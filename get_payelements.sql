DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_payelements`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payelements`()
begin
SELECT `pel_code`,`pel_sht_desc`,`pel_desc`,`pel_taxable`,
    `pel_deduction`,`pel_depends_on`,`pel_type`, pel_applied_to, 
	round(`pel_nontax_allowed_amt`,2)pel_nontax_allowed_amt, 
	round(`pel_prescribed_amt`,2)pel_prescribed_amt,
	case when pel_selected = 1 then 1 else 0 end as pel_selected,
	pel_order
FROM `serenehrdb`.`shr_pay_elements`
order by pel_order
;
end$$
DELIMITER ;

