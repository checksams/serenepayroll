DROP PROCEDURE IF EXISTS `get_payrolls_ddl`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payrolls_ddl`()
begin
select null pr_code,'null' pr_sht_desc,null pr_desc,null pr_org_code,
	null org_desc,null pr_wef,null pr_wet
union all
SELECT `pr_code`,`pr_sht_desc`,`pr_desc`,`pr_org_code`,
    `org_desc`,`pr_wef`, `pr_wet`
FROM `serenehrdb`.`shr_payrolls` `p`  left join  `serenehrdb`.`shr_organizations` `o`
on (`p`.`pr_org_code` = `o`.`org_code`)
where `pr_org_code` = `org_code`
;
end$$
DELIMITER ;


