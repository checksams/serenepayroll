DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_emp_pay_elements`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emp_pay_elements`(v_emp_code int)
begin
SELECT `epe_code`,`pel_sht_desc`,`pel_desc`,`pel_taxable`,
    `pel_deduction`,`pel_depends_on`,`pel_type`,round(`epe_amt`,2)epe_amt,`epe_created_by`, `pel_code`,
	round(`epe_ot_hours`,2)epe_ot_hours
FROM `serenehrdb`.`shr_employees` emp 
left join `serenehrdb`.`shr_emp_pay_elements` epe on (epe.epe_emp_code=emp.emp_code)
left join  `serenehrdb`.`shr_pay_elements` pe on (epe.epe_pel_code=pe.pel_code)
where emp_code = v_emp_code
;
end$$
DELIMITER ;

