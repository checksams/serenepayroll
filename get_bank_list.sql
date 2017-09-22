DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_bank_list`;

DELIMITER $$
CREATE PROCEDURE `get_bank_list`()
begin
select 0 bnk_code, 'null' bnk_sht_desc, null bnk_name
union all
SELECT `bnk_code`,`bnk_sht_desc`,`bnk_name`
FROM `serenehrdb`.`shr_banks` order by bnk_name asc
;
end$$
DELIMITER ;
