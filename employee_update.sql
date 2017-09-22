DROP PROCEDURE IF EXISTS `employee_update`;

DELIMITER $$

CREATE PROCEDURE `employee_update` (v_emp_code int,
								v_sht_desc  varchar(45),
								v_surname  varchar(100),
								v_other_names  varchar(100),
								v_tel_no1  varchar(45),
								v_tel_no2  varchar(45),
								v_sms_no  varchar(45),
								v_contract_date  varchar(45),
								v_final_date	varchar(45),
								v_org_code int,
								v_organization	varchar(1000),
								v_gender	varchar(45),
								v_join_date	varchar(45),
								v_work_email	varchar(100),
								v_personal_email	varchar(100),
								out v_empcode int,
								v_id_no	varchar(45),
								v_nssf_no	varchar(45),
								v_pin_no	varchar(45),
								v_nhif_no	varchar(45),
								v_lasc_no	varchar(45),
								v_nxt_kin_sname	varchar(300),
								v_nxt_kin_onames	varchar(300),
								v_nxt_kin_tel_no	varchar(45),
								v_pr_code	INT,
								v_bnk_code	INT,
								v_bbr_code	INT,
								v_bank_acc_no	varchar(45)
								)
BEGIN
declare v_contractdate, v_finaldate, v_joindate date;
declare var,v_prcode, v_bbrcode, v_bnkcode int;
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if mysql_error = 1062 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Product already exists';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Employee already exists ';
		elseif v_org_code is null then	
			signal sqlstate '45000'
				set message_text='Select an Organization to proceed.. ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

select char_length(v_contract_date) into var;
if var >= 10 then
	SELECT STR_TO_DATE(v_contract_date,'%d/%m/%Y') into v_contractdate;
end if;
select char_length(v_final_date) into var;
if var >= 10 then
	SELECT STR_TO_DATE(v_final_date,'%d/%m/%Y') into v_finaldate;
end if;
select char_length(v_join_date) into var;
if var >= 10 then
	SELECT STR_TO_DATE(v_join_date,'%d/%m/%Y') into v_joindate;
end if;
if v_pr_code is null or v_pr_code = 0 then
	set v_prcode = null;
else	
	set v_prcode = v_pr_code;
end if;

if v_bnk_code is null or v_bnk_code = 0 then
	set v_bnkcode = null;
else	
	set v_bnkcode = v_bnk_code;
end if;
if v_bbr_code is null or v_bbr_code = 0 then
	set v_bbrcode = null;
else	
	set v_bbrcode = v_bbr_code;
end if;

#CALL raise_error (1356, 'My Error Message v_org_code=' + v_org_code);
if v_emp_code is null or v_emp_code = 0 then
	INSERT INTO `serenehrdb`.`shr_employees`
	(`emp_sht_desc`,`emp_surname`,`emp_other_names`,
	`emp_tel_no1`,`emp_tel_no2`,`emp_sms_no`,`emp_contract_date`,
	`emp_final_date`,`emp_org_code`,`emp_organization`,`emp_gender`,
	`emp_join_date`,`emp_work_email`,`emp_personal_email`, `emp_id_no`,
    `emp_nssf_no`, `emp_pin_no`, `emp_nhif_no`, `emp_lasc_no`,
    `emp_nxt_kin_sname`, `emp_nxt_kin_onames`, `emp_nxt_kin_tel_no`, `emp_pr_code`,
	`emp_bnk_code`,`emp_bbr_code`, `emp_bank_acc_no`)
	VALUES
	(v_sht_desc,v_surname,v_other_names,
	v_tel_no1,v_tel_no2,v_sms_no,v_contractdate,
	v_finaldate,v_org_code,v_organization,v_gender,
	v_joindate,v_work_email,v_personal_email, v_id_no,
    v_nssf_no, v_pin_no, v_nhif_no, v_lasc_no,
    v_nxt_kin_sname, v_nxt_kin_onames, v_nxt_kin_tel_no, v_prcode,
	v_bnkcode,v_bbrcode, v_bank_acc_no);
	select max(emp_code) into v_empcode from  `serenehrdb`.`shr_employees`;
else	
	UPDATE `serenehrdb`.`shr_employees`
	SET
	`emp_sht_desc` = v_sht_desc,
	`emp_surname` = v_surname,
	`emp_other_names` = v_other_names,
	`emp_tel_no1` = v_tel_no1,
	`emp_tel_no2` = v_tel_no2,
	`emp_sms_no` = v_sms_no,
	`emp_contract_date` = v_contractdate,
	`emp_final_date` = v_finaldate,
	`emp_org_code` = v_org_code,
	`emp_organization` = v_organization,
	`emp_gender` = v_gender,
	`emp_join_date` = v_joindate,
	`emp_work_email` = v_work_email,
	`emp_personal_email` = v_personal_email,
    `emp_id_no` = v_id_no,
    `emp_nssf_no` = v_nssf_no,
    `emp_pin_no` = v_pin_no,
    `emp_nhif_no` = v_nhif_no,
    `emp_lasc_no` = v_lasc_no,
    `emp_nxt_kin_sname` = v_nxt_kin_sname,
    `emp_nxt_kin_onames` = v_nxt_kin_onames,
    `emp_nxt_kin_tel_no` = v_nxt_kin_tel_no,
    `emp_pr_code` = v_prcode,
	`emp_bnk_code` = v_bnkcode,
	`emp_bbr_code` = v_bbrcode, 
	`emp_bank_acc_no` = v_bank_acc_no
	WHERE `emp_code` = v_emp_code;
	set v_empcode = v_emp_code;
end if;


COMMIT;
END;

$$