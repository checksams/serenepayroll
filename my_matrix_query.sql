
	SELECT 
		`emp_sht_desc`, concat(`emp_other_names`,' ',`emp_surname`) as emp_name,
		sum(case when `pel_desc`='BASIC PAY' then round(`ppe_amt`,2) else 0 end) as 'BASIC PAY',
		sum(case when `pel_desc`='GROSS PAY' then round(`ppe_amt`,2) else 0 end) as 'GROSS PAY',
		sum(case when `pel_desc`='NET PAY' then round(`ppe_amt`,2) else 0 end) as 'NET PAY'
	FROM `serenehrdb`.`shr_prd_pay_elements`  ppe
	left join `serenehrdb`.`shr_employees` emp on (ppe.ppe_emp_code=emp.emp_code)
	left join `shr_pay_elements` pel on (pel.pel_code=ppe.ppe_pel_code)
	where emp_code = emp_code
	group by emp_sht_desc,concat(`emp_other_names`,' ',`emp_surname`)
	order by pel_order,pel_deduction,pel_sht_desc
;

SELECT GROUP_CONCAT(DISTINCT pel_desc
ORDER BY pel_desc)
	FROM `serenehrdb`.`shr_prd_pay_elements`  ppe
	left join `serenehrdb`.`shr_employees` emp on (ppe.ppe_emp_code=emp.emp_code)
	left join `shr_pay_elements` pel on (pel.pel_code=ppe.ppe_pel_code)
	where emp_code = emp_code;

#To be used in a procedure
SELECT
  CONCAT('SELECT pel_desc,',
  GROUP_CONCAT(peldesc),
  ' FROM `serenehrdb`.`shr_prd_pay_elements`  ppe
	left join `serenehrdb`.`shr_employees` emp on (ppe.ppe_emp_code=emp.emp_code)
	left join `shr_pay_elements` pel on (pel.pel_code=ppe.ppe_pel_code)
	where emp_code = emp_code')
FROM (
SELECT
	CONCAT('sum(case when `pel_desc`=\'',pel_desc, '\' then round(`ppe_amt`,2) else 0 end) as `',pel_desc,'`') as peldesc,`pel_order`
	FROM `serenehrdb`.`shr_prd_pay_elements`  ppe
	left join `serenehrdb`.`shr_employees` emp on (ppe.ppe_emp_code=emp.emp_code)
	left join `shr_pay_elements` pel on (pel.pel_code=ppe.ppe_pel_code)
	where emp_code = emp_code
GROUP BY pel_desc order by pel_order
) s  ;


#Example for above in a stored procedure 
SELECT
  CONCAT('SELECT year,',
  GROUP_CONCAT(sums),
  ' FROM yourtable GROUP BY year')
FROM (
SELECT CONCAT('SUM(name=\'', name, '\') AS `', name, '`') sums
FROM yourtable
GROUP BY name
ORDER BY COUNT(*) DESC
) s
INTO @sql;

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


