DROP PROCEDURE IF EXISTS `get_employees`;

DELIMITER $$

CREATE PROCEDURE `get_employees`(v_sht_desc  varchar(45),
															v_surname  varchar(100),
															v_other_names  varchar(100),
															v_organization  varchar(100))
begin
SELECT `emp_code`, `emp_sht_desc`, `emp_surname`, `emp_other_names`,
    `emp_tel_no1`, `emp_tel_no2`, `emp_sms_no`, 
	date_format(emp_contract_date,'%d/%m/%Y') emp_contract_date,
    date_format(emp_final_date,'%d/%m/%Y')emp_final_date, `emp_org_code`, `emp_organization`, `emp_gender`,
    date_format(emp_join_date,'%d/%m/%Y')emp_join_date, `emp_work_email`, `emp_personal_email`, `emp_id_no`,
    `emp_nssf_no`, `emp_pin_no`, `emp_nhif_no`, `emp_lasc_no`,
    `emp_nxt_kin_sname`, `emp_nxt_kin_onames`, `emp_nxt_kin_tel_no`, `emp_pr_code`,
	case when `emp_bnk_code` is null then 0 else emp_bnk_code end as emp_bnk_code,
	case when `emp_bbr_code` is null then 0 else emp_bbr_code end as emp_bbr_code,
	`emp_bank_acc_no`
FROM `serenehrdb`.`shr_employees` emp 
where `emp_sht_desc` like CONCAT('%',CONCAT(v_sht_desc,'%')) 
and `emp_surname` like CONCAT('%',CONCAT(v_surname,'%')) 
and `emp_other_names` like CONCAT('%',CONCAT(v_other_names,'%')) 
and `emp_organization` like CONCAT('%',CONCAT(v_organization,'%'))
;
end;

$$
DELIMITER ;

