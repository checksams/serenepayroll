DROP PROCEDURE  IF EXISTS `serenehrdb`.`rpt_payslip_001`;

DELIMITER $$
CREATE PROCEDURE `rpt_payslip_001`(v_tr_code int,
											v_pr_code int,
											v_emp_code bigint)
begin
if (v_emp_code is null or v_emp_code = 0) then
	SELECT `ppe_code`,`pel_sht_desc`,`pel_desc`,`pel_taxable`,
		`pel_deduction`,`pel_depends_on`,`pel_type`,round(`ppe_amt`,2)ppe_amt,
		round(`ppe_ded_amt_b4_tax`,2)ppe_ded_amt_b4_tax,
		round(`ppe_val_of_benfit_amt`,2)ppe_val_of_benfit_amt,
		round(`ppe_ot_hours`,2)ppe_ot_hours,
		`emp_sht_desc`, concat(`emp_other_names`,' ',`emp_surname`) as emp_name,
		emp_code,pel_order
	FROM `serenehrdb`.`shr_prd_pay_elements`  ppe
	left join `serenehrdb`.`shr_employees` emp on (ppe.ppe_emp_code=emp.emp_code)
	left join `shr_pay_elements` pel on (pel.pel_code=ppe.ppe_pel_code)
	where emp_code = emp_code
	and emp_pr_code = v_pr_code
	and ppe_tr_code = v_tr_code
	order by pel_order,pel_deduction,pel_sht_desc
	;
else
	SELECT `ppe_code`,`pel_sht_desc`,`pel_desc`,`pel_taxable`,
		`pel_deduction`,`pel_depends_on`,`pel_type`,round(`ppe_amt`,2)ppe_amt,
		round(`ppe_ded_amt_b4_tax`,2)ppe_ded_amt_b4_tax,
		round(`ppe_val_of_benfit_amt`,2)ppe_val_of_benfit_amt,
		round(`ppe_ot_hours`,2)ppe_ot_hours,
		`emp_sht_desc`, concat(`emp_other_names`,' ',`emp_surname`) as emp_name,
		emp_code,pel_order
	FROM `serenehrdb`.`shr_prd_pay_elements`  ppe
	left join `serenehrdb`.`shr_employees` emp on (ppe.ppe_emp_code=emp.emp_code)
	left join `shr_pay_elements` pel on (pel.pel_code=ppe.ppe_pel_code)
	where emp_code = emp_code
	and emp_pr_code = v_pr_code
	and ppe_tr_code = v_tr_code
	union all 
	SELECT `ppe_code`,concat(`pel_sht_desc`,' Relief')pel_sht_desc,concat(`pel_desc`,' Relief')pel_desc,`pel_taxable`,
		`pel_deduction`,`pel_depends_on`,'STATEMENT ITEM' pel_type,round(`ppe_ded_amt_b4_tax`,2)ppe_amt,
		round(`ppe_ded_amt_b4_tax`,2)ppe_ded_amt_b4_tax,
		round(`ppe_val_of_benfit_amt`,2)ppe_val_of_benfit_amt,
		round(`ppe_ot_hours`,2)ppe_ot_hours,
		`emp_sht_desc`, concat(`emp_other_names`,' ',`emp_surname`) as emp_name,
		emp_code,pel_order
	FROM `serenehrdb`.`shr_prd_pay_elements`  ppe
	left join `serenehrdb`.`shr_employees` emp on (ppe.ppe_emp_code=emp.emp_code)
	left join `shr_pay_elements` pel on (pel.pel_code=ppe.ppe_pel_code)
	where emp_code = emp_code
	and emp_pr_code = v_pr_code
	and ppe_tr_code = v_tr_code
	and ppe_ded_amt_b4_tax > 0
	union all
	SELECT `ppe_code`,`pel_sht_desc`,`pel_desc`,`pel_taxable`,
		`pel_deduction`,`pel_depends_on`,'STATEMENT ITEM' pel_type,round(`ppe_amt`,2)ppe_amt,
		round(`ppe_ded_amt_b4_tax`,2)ppe_ded_amt_b4_tax,
		round(`ppe_val_of_benfit_amt`,2)ppe_val_of_benfit_amt,
		round(`ppe_ot_hours`,2)ppe_ot_hours,
		`emp_sht_desc`, concat(`emp_other_names`,' ',`emp_surname`) as emp_name,
		emp_code,pel_order
	FROM `serenehrdb`.`shr_prd_pay_elements`  ppe
	left join `serenehrdb`.`shr_employees` emp on (ppe.ppe_emp_code=emp.emp_code)
	left join `shr_pay_elements` pel on (pel.pel_code=ppe.ppe_pel_code)
	where emp_code = emp_code
	and emp_pr_code = v_pr_code
	and ppe_tr_code = v_tr_code
	and pel_sht_desc = 'PRELIEF'
	order by pel_order,pel_deduction,pel_sht_desc
	;

end if;
end$$
DELIMITER ;

