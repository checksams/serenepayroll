DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_emp_loans`;

DELIMITER $$
CREATE PROCEDURE `get_emp_loans`(v_emp_code int)
begin
SELECT `el_code`,`el_date`,`el_eff_date`,
    round(`el_loan_applied_amt`,2)el_loan_applied_amt,
	round(`el_service_charge`)el_service_charge,
	round(`el_issued_amt`)el_issued_amt,
    `el_intr_rate`,`el_intr_div_factr`,`el_done_by`,`el_authorised_by`,
    `el_authorised_date`,`el_authorised`,
	round(`el_tot_tax_amt`)el_tot_tax_amt, `el_lt_code`,`lt_desc`,
	`el_final_repay_date`, `el_tot_instalments`,
	round(`el_instalment_amt`)el_instalment_amt
FROM `serenehrdb`.`shr_emp_loans` el
left join `serenehrdb`.`shr_loan_types`  lt on (el.el_lt_code=lt.lt_code)
where el_emp_code = v_emp_code
;
end$$
DELIMITER ;

