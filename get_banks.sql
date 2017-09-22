DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_banks`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_banks`(v_sht_desc  varchar(15),
														v_bnk_name varchar(300))
begin
SELECT `bnk_code`,`bnk_sht_desc`,`bnk_name`,`bnk_postal_address`,
    `bnk_physical_address`, `bnk_kba_code`
FROM `serenehrdb`.`shr_banks`
where bnk_name like CONCAT('%',CONCAT(v_bnk_name,'%')) 
and bnk_sht_desc like CONCAT('%',CONCAT(v_sht_desc,'%')) 
;
end$$
DELIMITER ;
