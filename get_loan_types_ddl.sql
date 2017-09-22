DROP PROCEDURE IF EXISTS `get_loan_types_ddl`;

DELIMITER $$
CREATE PROCEDURE `get_loan_types_ddl`()
begin
select null lt_code,'null' lt_sht_desc, null lt_desc
union all
SELECT `lt_code`,`lt_sht_desc`,`lt_desc`
FROM `serenehrdb`.`shr_loan_types`
;
end$$
DELIMITER ;

