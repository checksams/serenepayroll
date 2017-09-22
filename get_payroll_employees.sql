DROP PROCEDURE IF EXISTS `get_payroll_employees`;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_employees`(v_pr_code int)
begin
SELECT `emp_code`, `emp_sht_desc`, `emp_surname`, `emp_other_names`,
	`emp_contract_date`, `emp_join_date`, `emp_id_no`,
    `emp_nssf_no`, `emp_pin_no`, `emp_nhif_no`, `emp_lasc_no`
FROM `serenehrdb`.`shr_employees`
where emp_pr_code = v_pr_code
and (emp_final_date is null or emp_final_date > Now())
;
end;

$$
DELIMITER ;

