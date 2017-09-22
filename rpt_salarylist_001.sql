DROP PROCEDURE  IF EXISTS `serenehrdb`.`rpt_salarylist_001`;

DELIMITER $$
CREATE PROCEDURE `rpt_salarylist_001`(v_tr_code int,
											v_pr_code int,
											v_emp_code bigint)
begin
declare v_sql varchar(4000);
SELECT
  CONCAT('SELECT pel_desc,',
  GROUP_CONCAT(pel_desc),
  ' FROM `serenehrdb`.`shr_prd_pay_elements`  ppe
	left join `serenehrdb`.`shr_employees` emp on (ppe.ppe_emp_code=emp.emp_code)
	left join `shr_pay_elements` pel on (pel.pel_code=ppe.ppe_pel_code)
	where emp_code = emp_code')
FROM (
SELECT
	CONCAT('sum(case when `pel_desc`=\'',pel_desc, '\' then round(`ppe_amt`,2) else 0 end) as `',pel_desc,'`') as pel_desc,`pel_order`
	FROM `serenehrdb`.`shr_prd_pay_elements`  ppe
	left join `serenehrdb`.`shr_employees` emp on (ppe.ppe_emp_code=emp.emp_code)
	left join `shr_pay_elements` pel on (pel.pel_code=ppe.ppe_pel_code)
	where emp_code = emp_code
GROUP BY pel_desc order by pel_order
) s
INTO v_sql;

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

end$$
DELIMITER ;

