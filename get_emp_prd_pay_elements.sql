DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_emp_prd_pay_elements`;

DELIMITER $$
CREATE PROCEDURE `get_emp_prd_pay_elements`(v_emp_code int,
											v_pr_code int,
											v_tr_code int)
begin
SELECT `ppe_code`,`pel_sht_desc`,`pel_desc`,`pel_taxable`,
    `pel_deduction`,`pel_depends_on`,`pel_type`,round(`ppe_amt`,2)ppe_amt,
	round(`ppe_ded_amt_b4_tax`,2)ppe_ded_amt_b4_tax,
	round(`ppe_val_of_benfit_amt`,2)ppe_val_of_benfit_amt,
	round(`ppe_ot_hours`,2)ppe_ot_hours
FROM `serenehrdb`.`shr_prd_pay_elements`  ppe
left join `serenehrdb`.`shr_employees` emp on (ppe.ppe_emp_code=emp.emp_code)
left join `shr_pay_elements` pel on (pel.pel_code=ppe.ppe_pel_code)
where emp_code = v_emp_code and emp_pr_code = v_pr_code
and ppe_tr_code = v_tr_code
order by pel_deduction,pel_sht_desc
;
end$$
DELIMITER ;

