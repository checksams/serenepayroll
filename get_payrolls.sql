DROP PROCEDURE IF EXISTS `get_payrolls`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payrolls`()
begin
SELECT `pr_code`,`pr_sht_desc`,`pr_desc`,`pr_org_code`,
    `org_desc`,`pr_wef`, `pr_wet`,
	`pr_day1_hrs`, `pr_day2_hrs`, `pr_day3_hrs`, `pr_day4_hrs`, 
	`pr_day5_hrs`, `pr_day6_hrs`, `pr_day7_hrs`
FROM `serenehrdb`.`shr_payrolls` `p`  left join  `serenehrdb`.`shr_organizations` `o`
on (`p`.`pr_org_code` = `o`.`org_code`)
where `pr_org_code` = `org_code`
;
end$$
DELIMITER ;


