DROP PROCEDURE IF EXISTS `get_taxes`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_taxes`()
begin
SELECT `tx_code`,`tx_sht_desc`,`tx_desc`,`tx_wef`,`tx_wet`
FROM `serenehrdb`.`shr_taxes`
;
end$$
DELIMITER ;

