CREATE DATABASE `serenehrdb` /*!40100 DEFAULT CHARACTER SET utf8 */;

use serenehrdb;

CREATE TABLE `serenehrdb`.`shr_user_roles` (
    `ur_code` INT NOT NULL AUTO_INCREMENT,
    `ur_name` VARCHAR(30) NOT NULL,
    `ur_desc` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`ur_code`)
)  COMMENT='User Roles';

INSERT INTO `serenehrdb`.`shr_user_roles`
(`ur_name`,`ur_desc`)
VALUES
("ADMIN","ADMINISTRATOR"),
("USER","DEFAULT USER");

CREATE TABLE `serenehrdb`.`shr_user_privillages` (
    `up_code` INT NOT NULL AUTO_INCREMENT,
    `up_name` VARCHAR(30) NOT NULL,
    `up_desc` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`up_code`)
)  COMMENT='User Privilages';

ALTER TABLE `serenehrdb`.`shr_user_privillages` 
ADD COLUMN `up_min_amt` DECIMAL(25,5) NULL AFTER `up_desc`,
ADD COLUMN `up_max_amt` DECIMAL(25,5) NULL AFTER `up_min_amt`;
ALTER TABLE `serenehrdb`.`shr_user_privillages` 
ADD COLUMN `up_type` VARCHAR(45) NULL AFTER `up_max_amt`;

ALTER TABLE `serenehrdb`.`shr_user_privillages` 
CHANGE COLUMN `up_desc` `up_desc` VARCHAR(1000) NOT NULL ;

CREATE TABLE `serenehrdb`.`shr_users` (
    `usr_code` INT NOT NULL AUTO_INCREMENT,
    `usr_name` VARCHAR(30) NOT NULL,
    `usr_full_name` VARCHAR(100) NOT NULL,
    `usr_emp_code` INT,
    `usr_pwd` VARCHAR(1000),
    `usr_last_login` DATETIME,
    `usr_login_atempts` INT,
    `usr_pwd_reset` VARCHAR(5),
    PRIMARY KEY (`usr_code`)
)  COMMENT='Users';

ALTER TABLE `serenehrdb`.`shr_users` 
ADD UNIQUE INDEX `usr_name_UNIQUE` (`usr_name` ASC);

INSERT INTO `serenehrdb`.`shr_users`
(`usr_name`,`usr_full_name`,`usr_emp_code`,`usr_pwd`,`usr_last_login`,`usr_login_atempts`,`usr_pwd_reset`)
VALUES
("Admin", "Administrator",null,MD5("manager"),null,null,"N"),
("User", "User",null,MD5("hruser"),null,null,"N");

commit;

CREATE TABLE `serenehrdb`.`shr_areas` (
    `ar_code` INT NOT NULL AUTO_INCREMENT,
    `ar_name` VARCHAR(30) NOT NULL,
    `ar_desc` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`ar_code`)
)  COMMENT='System areas';

CREATE TABLE `serenehrdb`.`shr_areas_subone` (
    `arso_code` INT NOT NULL AUTO_INCREMENT,
    `arso_ar_code` INT,
    `arso_name` VARCHAR(30) NOT NULL,
    `arso_desc` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`arso_code`)
)  COMMENT='System sub areas level 1';

ALTER TABLE `serenehrdb`.`shr_areas_subone` 
ADD CONSTRAINT `arso_ar_code_fk`
  FOREIGN KEY (`arso_ar_code`)
  REFERENCES `serenehrdb`.`shr_areas` (`ar_code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `serenehrdb`.`shr_areas_subtwo` (
    `arst_code` INT NOT NULL AUTO_INCREMENT,
    `arst_arso_code` INT,
    `arst_ar_code` INT,
    `arst_name` VARCHAR(30) NOT NULL,
    `arst_desc` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`arst_code`)
)  COMMENT='System sub areas level 2';

ALTER TABLE `serenehrdb`.`shr_areas_subtwo` 
ADD CONSTRAINT `arst_arso_code_fk`
  FOREIGN KEY (`arst_arso_code`)
  REFERENCES `serenehrdb`.`shr_areas_subone` (`arso_code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `serenehrdb`.`shr_areas_subthree` (
    `artr_code` INT NOT NULL AUTO_INCREMENT,
    `artr_name` VARCHAR(30) NOT NULL,
    `artr_desc` VARCHAR(100) NOT NULL,
    `artr_arst_code` INT,
    `artr_arso_code` INT,
    `artr_ar_code` INT,
    PRIMARY KEY (`artr_code`)
)  COMMENT='System sub areas level 2';

ALTER TABLE `serenehrdb`.`shr_areas_subthree` 
ADD CONSTRAINT `artr_arst_code_fk`
  FOREIGN KEY (`artr_arst_code`)
  REFERENCES `serenehrdb`.`shr_areas_subtwo` (`arst_code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


CREATE TABLE `serenehrdb`.`shr_organizations` (
    `org_code` INT NOT NULL AUTO_INCREMENT,
    `org_sht_desc` VARCHAR(30) NOT NULL,
    `org_desc` VARCHAR(1000) NOT NULL,
    `org_postal_address` VARCHAR(1000),
    `org_physical_address` VARCHAR(1000),
    `org_type` VARCHAR(10),
    `org_parent_org_code` INT,
    `org_parent_org_sht_desc` VARCHAR(30),
    `org_wef` DATETIME,
    `org_wet` DATETIME,
    `org_level` SMALLINT,
    PRIMARY KEY (`org_code`)
)  COMMENT='Organization structure';


CREATE TABLE `serenehrdb`.`shr_job_titles` (
    `jt_code` INT NOT NULL AUTO_INCREMENT,
    `jt_sht_code` VARCHAR(45) NOT NULL,
    `jt_desc` VARCHAR(100) NULL,
    PRIMARY KEY (`jt_code`)
)  COMMENT='Job Titles';

USE `serenehrdb`;
CREATE OR REPLACE VIEW `vw_job_titlles` AS
    SELECT 
        `shr_job_titles`.`jt_code`,
        `shr_job_titles`.`jt_sht_code`,
        `shr_job_titles`.`jt_desc`
    FROM
        `serenehrdb`.`shr_job_titles`;

CREATE TABLE `shr_employees` (
    `emp_code` int(11) NOT NULL AUTO_INCREMENT,
    `emp_sht_desc` varchar(45) DEFAULT NULL,
    `emp_surname` varchar(100) NOT NULL,
    `emp_other_names` varchar(100) DEFAULT NULL,
    `emp_tel_no1` varchar(45) DEFAULT NULL,
    `emp_tel_no2` varchar(45) DEFAULT NULL,
    `emp_sms_no` varchar(45) DEFAULT NULL,
    `emp_contract_date` date DEFAULT NULL,
    `emp_final_date` date DEFAULT NULL,
    `emp_org_code` int(11) NOT NULL,
    `emp_organization` varchar(100) NOT NULL,
    PRIMARY KEY (`emp_code`),
    KEY `emp_org_code_fk_idx` (`emp_org_code`),
    CONSTRAINT `emp_org_code_fk` FOREIGN KEY (`emp_org_code`)
        REFERENCES `shr_organizations` (`org_code`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Employee Details';


ALTER TABLE `serenehrdb`.`shr_employees` 
ADD COLUMN `emp_join_date` DATE NULL AFTER `emp_gender`,
ADD COLUMN `emp_work_email` VARCHAR(100) NULL AFTER `emp_join_date`,
ADD COLUMN `emp_personal_email` VARCHAR(100) NULL AFTER `emp_work_email`;

USE `serenehrdb`;
CREATE OR REPLACE VIEW `vw_empployees` AS
    SELECT 
        `shr_employees`.`emp_code`,
        `shr_employees`.`emp_sht_desc`,
        `shr_employees`.`emp_surname`,
        `shr_employees`.`emp_other_names`,
        `shr_employees`.`emp_tel_no1`,
        `shr_employees`.`emp_tel_no2`,
        `shr_employees`.`emp_sms_no`,
        `shr_employees`.`emp_contract_date`,
        `shr_employees`.`emp_final_date`,
        `shr_employees`.`emp_org_code`,
        `shr_employees`.`emp_organization`,
        `shr_employees`.`emp_gender`
    FROM
        `serenehrdb`.`shr_employees`;

CREATE TABLE `imp_shr_employees` (
    `emp_code` int(11) NOT NULL AUTO_INCREMENT,
    `emp_sht_desc` varchar(45) DEFAULT NULL,
    `emp_surname` varchar(100) DEFAULT NULL,
    `emp_other_names` varchar(100) DEFAULT NULL,
    `emp_tel_no1` varchar(45) DEFAULT NULL,
    `emp_tel_no2` varchar(45) DEFAULT NULL,
    `emp_sms_no` varchar(45) DEFAULT NULL,
    `emp_contract_date` date DEFAULT NULL,
    `emp_final_date` date DEFAULT NULL,
    `emp_org_code` int(11) DEFAULT NULL,
    `emp_organization` varchar(100) DEFAULT NULL,
    `emp_gender` varchar(15) DEFAULT null,
    `emp_join_date` date DEFAULT NULL,
    `emp_work_email` varchar(100) DEFAULT NULL,
    `emp_personal_email` varchar(100) DEFAULT NULL,
    PRIMARY KEY (`emp_code`),
    KEY `emp_org_code_fk_idx` (`emp_org_code`)
)  ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='Employee Details Import';

CREATE TABLE `serenehrdb`.`shr_payrolls` (
    `pr_code` INT NOT NULL AUTO_INCREMENT,
    `pr_sht_desc` VARCHAR(45) NOT NULL,
    `pr_desc` VARCHAR(100) NULL,
    `pr_org_code` INT NULL,
    `pr_wef` DATE NULL,
    `pr_wet` DATE NULL,
    PRIMARY KEY (`pr_code`),
    INDEX `pr_org_code_fk_idx` (`pr_org_code` ASC),
    CONSTRAINT `pr_org_code_fk` FOREIGN KEY (`pr_org_code`)
        REFERENCES `serenehrdb`.`shr_organizations` (`org_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT
)  COMMENT='Payroll Definition Table';

CREATE TABLE `serenehrdb`.`shr_taxes` (
    `tx_code` INT NOT NULL AUTO_INCREMENT,
    `tx_sht_desc` VARCHAR(45) NOT NULL,
    `tx_desc` VARCHAR(100) NOT NULL,
    `tx_wef` DATE NOT NULL,
    `tx_wet` DATE NULL,
    PRIMARY KEY (`tx_code`)
)  COMMENT='Taxes and Charges Types';

CREATE TABLE `serenehrdb`.`shr_tax_rates` (
    `txr_code` INT NOT NULL AUTO_INCREMENT,
    `txr_desc` VARCHAR(100) NULL,
    `txr_rate_type` VARCHAR(45) NULL,
    `txr_rate` INT NOT NULL,
    `txr_div_factr` INT NULL,
    `txr_wef` DATE NOT NULL,
    `txr_wet` DATE NULL,
    `txr_tx_code` INT NULL,
    PRIMARY KEY (`txr_code`),
    INDEX `txr_tx_code_fk_idx` (`txr_tx_code` ASC),
    CONSTRAINT `txr_tx_code_fk` FOREIGN KEY (`txr_tx_code`)
        REFERENCES `serenehrdb`.`shr_taxes` (`tx_code`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  COMMENT='Tax Rates';

ALTER TABLE `serenehrdb`.`shr_tax_rates` 
ADD COLUMN `txr_range_from` INT NULL AFTER `txr_tx_code`,
ADD COLUMN `txr_range_to` INT NULL AFTER `txr_range_from`;

ALTER TABLE `serenehrdb`.`shr_tax_rates` 
CHANGE COLUMN `txr_range_to` `txr_range_to` BIGINT NULL DEFAULT NULL ;

CREATE TABLE `serenehrdb`.`shr_pay_elements` (
    `pel_code` INT NOT NULL AUTO_INCREMENT,
    `pel_sht_desc` VARCHAR(45) NOT NULL,
    `pel_desc` VARCHAR(200) NOT NULL,
    `pel_taxable` VARCHAR(5) NULL,
    `pel_deduction` VARCHAR(5) NULL,
    `pel_depends_on` INT NULL,
    `pel_type` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`pel_code`)
)  COMMENT='Pay elements table';


CREATE TABLE `serenehrdb`.`shr_proll_pelements` (
    `pp_code` INT NOT NULL AUTO_INCREMENT,
    `pp_pel_code` INT NOT NULL,
    `pp_pr_code` INT NOT NULL,
    PRIMARY KEY (`pp_code`),
    INDEX `pp_pel_code_idx` (`pp_pel_code` ASC),
    INDEX `pp_pr_code_idx` (`pp_pr_code` ASC),
    CONSTRAINT `pp_pel_code_fk` FOREIGN KEY (`pp_pel_code`)
        REFERENCES `serenehrdb`.`shr_pay_elements` (`pel_code`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `pp_pr_code_fk` FOREIGN KEY (`pp_pr_code`)
        REFERENCES `serenehrdb`.`shr_payrolls` (`pr_code`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  COMMENT='Payroll Pay Elements';

CREATE TABLE `serenehrdb`.`shr_loan_types` (
    `lt_code` INT NOT NULL AUTO_INCREMENT,
    `lt_sht_desc` VARCHAR(45) NOT NULL,
    `lt_desc` VARCHAR(100) NOT NULL,
    `lt_min_repay_prd` INT NOT NULL,
    `lt_max_repay_prd` INT NOT NULL,
    `lt_min_amt` INT NOT NULL,
    `lt_max_amt` INT NOT NULL,
    `lt_wef` DATE NOT NULL,
    `lt_wet` DATE NULL,
    PRIMARY KEY (`lt_code`)
)  COMMENT='Loan Types';

ALTER TABLE `serenehrdb`.`shr_loan_types` 
ADD UNIQUE INDEX `lt_sht_desc_UNIQUE` (`lt_sht_desc` ASC),
ADD UNIQUE INDEX `lt_desc_UNIQUE` (`lt_desc` ASC);

CREATE TABLE `serenehrdb`.`shr_loan_intr_rates` (
    `lir_code` INT NOT NULL AUTO_INCREMENT,
    `lir_rate` INT NOT NULL,
    `lir_div_factr` INT NOT NULL,
    `lir_wef` DATE NOT NULL,
    `lir_wet` DATE NULL,
    `lir_lt_code` INT NOT NULL,
    PRIMARY KEY (`lir_code`),
    INDEX `lir_lt_code_idx` (`lir_lt_code` ASC),
    CONSTRAINT `lir_lt_code_fk` FOREIGN KEY (`lir_lt_code`)
        REFERENCES `serenehrdb`.`shr_loan_types` (`lt_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT
)  COMMENT='Loan Interest Rates';


########################################################################
ALTER TABLE `serenehrdb`.`shr_employees` 
ADD COLUMN `emp_id_no` VARCHAR(45) NULL AFTER `emp_personal_email`,
ADD COLUMN `emp_nssf_no` VARCHAR(45) NULL AFTER `emp_id_no`,
ADD COLUMN `emp_pin_no` VARCHAR(45) NULL AFTER `emp_nssf_no`,
ADD COLUMN `emp_nhif_no` VARCHAR(45) NULL AFTER `emp_pin_no`,
ADD COLUMN `emp_lasc_no` VARCHAR(45) NULL AFTER `emp_nhif_no`;

ALTER TABLE `serenehrdb`.`shr_employees` 
ADD COLUMN `emp_nxt_kin_sname` VARCHAR(150) NULL AFTER `emp_lasc_no`,
ADD COLUMN `emp_nxt_kin_onames` VARCHAR(150) NULL AFTER `emp_nxt_kin_sname`,
ADD COLUMN `emp_nxt_kin_tel_no` VARCHAR(45) NULL AFTER `emp_nxt_kin_onames`;

ALTER TABLE `serenehrdb`.`shr_employees` 
ADD COLUMN `emp_pr_code` INT NULL AFTER `emp_nxt_kin_tel_no`,
ADD INDEX `emp_pr_code_idx` (`emp_pr_code` ASC);
ALTER TABLE `serenehrdb`.`shr_employees` 
ADD CONSTRAINT `emp_pr_code_fk`
  FOREIGN KEY (`emp_pr_code`)
  REFERENCES `serenehrdb`.`shr_payrolls` (`pr_code`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE `serenehrdb`.`shr_organizations` 
ADD COLUMN `org_pin_no` VARCHAR(45) NULL AFTER `org_level`,
ADD COLUMN `org_p9a_approval_no` VARCHAR(45) NULL AFTER `org_pin_no`,
ADD COLUMN `org_nssf_no` VARCHAR(45) NULL AFTER `org_p9a_approval_no`,
ADD COLUMN `org_nhif_no` VARCHAR(45) NULL AFTER `org_nssf_no`;

CREATE TABLE `serenehrdb`.`shr_banks` (
    `bnk_code` INT NOT NULL AUTO_INCREMENT,
    `bnk_sht_desc` VARCHAR(15) NOT NULL,
    `bnk_name` VARCHAR(300) NOT NULL,
    `bnk_postal_address` VARCHAR(1000) NULL,
    `bnk_physical_address` VARCHAR(1000) NULL,
    `bnk_kba_code` VARCHAR(15) NULL,
    PRIMARY KEY (`bnk_code`)
)  COMMENT='Banks';

CREATE TABLE `serenehrdb`.`shr_bank_branches` (
    `bbr_code` INT NOT NULL AUTO_INCREMENT,
    `bbr_sht_desc` VARCHAR(15) NOT NULL,
    `bbr_name` VARCHAR(300) NOT NULL,
    `bbr_postal_address` VARCHAR(1000) NULL,
    `bbr_physical_address` VARCHAR(1000) NULL,
    `bbr_tel_no1` VARCHAR(45) NULL,
    `bbr_tel_no2` VARCHAR(45) NULL,
    `bbr_bnk_code` INT NOT NULL,
    PRIMARY KEY (`bbr_code`),
    INDEX `bbr_bnk_code_idx` (`bbr_bnk_code` ASC),
    CONSTRAINT `bbr_bnk_code_fk` FOREIGN KEY (`bbr_bnk_code`)
        REFERENCES `serenehrdb`.`shr_banks` (`bnk_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT
)  COMMENT='Bank Branches';

ALTER TABLE `serenehrdb`.`shr_taxes` 
ADD COLUMN `tx_rate_type` VARCHAR(45) NOT NULL DEFAULT 'FIXED' AFTER `tx_wet`;


CREATE TABLE `serenehrdb`.`shr_emp_loans` (
    `el_code` INT NOT NULL AUTO_INCREMENT,
    `el_emp_code` INT NOT NULL,
    `el_date` DATE NOT NULL,
    `el_eff_date` DATE NOT NULL,
    `el_loan_applied_amt` DECIMAL(25 , 5 ) NOT NULL,
    `el_service_charge` DECIMAL(25 , 5 ) NOT NULL,
    `el_issued_amt` DECIMAL(25 , 5 ) NOT NULL,
    `el_intr_rate` INT NULL,
    `el_intr_div_factr` INT NULL,
    `el_done_by` VARCHAR(100) NOT NULL,
    `el_authorised_by` VARCHAR(100) NULL,
    `el_authorised_date` DATE NULL,
    `el_authorised` VARCHAR(5) NULL,
    `el_tot_tax_amt` DECIMAL(25 , 5 ) NULL COMMENT 'Employee Loans',
    `el_lt_code` INT NOT NULL,
    PRIMARY KEY (`el_code`),
    INDEX `el_emp_code_idx` (`el_emp_code` ASC),
    INDEX `el_lt_code_idx` (`el_lt_code` ASC),
    CONSTRAINT `el_emp_code_fk` FOREIGN KEY (`el_emp_code`)
        REFERENCES `serenehrdb`.`shr_employees` (`emp_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `el_lt_code_fk` FOREIGN KEY (`el_lt_code`)
        REFERENCES `serenehrdb`.`shr_loan_types` (`lt_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT
)  COMMENT='Employee Loans';

ALTER TABLE `serenehrdb`.`shr_emp_loans` 
ADD COLUMN `el_tr_code` BIGINT NULL AFTER `el_lt_code`;

ALTER TABLE `serenehrdb`.`shr_emp_loans` 
ADD INDEX `el_tr_code_idx` (`el_tr_code` ASC);

#not working
ALTER TABLE `serenehrdb`.`shr_emp_loans` 
ADD CONSTRAINT `el_tr_code_fk`
  FOREIGN KEY (`el_tr_code`)
  REFERENCES `serenehrdb`.`shr_transactions` (`tr_code`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE `serenehrdb`.`shr_emp_loans` 
ADD COLUMN `el_loan_amt` DECIMAL(25,5) NULL DEFAULT 0 AFTER `el_tr_code`;
ALTER TABLE `serenehrdb`.`shr_emp_loans` 
ADD COLUMN `el_processed` varchar(5) NULL DEFAULT null AFTER `el_loan_amt`;
ALTER TABLE `serenehrdb`.`shr_emp_loans` 
ADD COLUMN `el_processed_by` varchar(5) NULL DEFAULT null AFTER `el_processed`;
ALTER TABLE `serenehrdb`.`shr_emp_loans` 
ADD COLUMN `el_processed_date` varchar(5) NULL DEFAULT null AFTER `el_processed_by`;

###TODO#########
ALTER TABLE `serenehrdb`.`shr_emp_loans` 
ADD COLUMN `el_final_repay_date` Date NULL DEFAULT null AFTER `el_processed_date`;
ALTER TABLE `serenehrdb`.`shr_emp_loans` 
ADD COLUMN `el_tot_instalments` int NULL DEFAULT null AFTER `el_final_repay_date`;
ALTER TABLE `serenehrdb`.`shr_emp_loans` 
ADD COLUMN `el_instalment_amt` decimal(25,5) NULL DEFAULT null AFTER `el_tot_instalments`;


CREATE TABLE `serenehrdb`.`shr_emp_pay_elements` (
    `epe_code` INT NOT NULL AUTO_INCREMENT,
    `epe_emp_code` INT NOT NULL,
    `epe_pel_code` INT NOT NULL,
    `epe_amt` DECIMAL(25 , 5 ) NULL,
    `epe_date` DATETIME NOT NULL DEFAULT Now (),
    `epe_created_by` VARCHAR(100) NULL,
    PRIMARY KEY (`epe_code`),
    INDEX `epe_emp_code_idx` (`epe_emp_code` ASC),
    INDEX `epe_pel_code_idx` (`epe_pel_code` ASC),
    CONSTRAINT `epe_emp_code_fk` FOREIGN KEY (`epe_emp_code`)
        REFERENCES `serenehrdb`.`shr_employees` (`emp_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `epe_pel_code_fk` FOREIGN KEY (`epe_pel_code`)
        REFERENCES `serenehrdb`.`shr_pay_elements` (`pel_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT
)  COMMENT='Employee Pay elements';

ALTER TABLE `serenehrdb`.`shr_emp_pay_elements` 
ADD COLUMN `epe_status` VARCHAR(45) NULL DEFAULT 'ACTIVE' COMMENT 'Pay Element Status (ACTIVE,INACTIVE)' AFTER `epe_created_by`;

ALTER TABLE `serenehrdb`.`shr_payrolls` 
ADD COLUMN `pr_freq` VARCHAR(45) NULL DEFAULT 'MONTHLY' COMMENT 'Payroll frequency of processing' AFTER `pr_wet`;


CREATE TABLE `serenehrdb`.`shr_transactions` (
    `tr_code` INT NOT NULL AUTO_INCREMENT,
    `tr_type` VARCHAR(45) NOT NULL,
    `tr_date` DATETIME NOT NULL DEFAULT Now (),
    `tr_done_by` VARCHAR(100) NOT NULL,
    `tr_authorised` VARCHAR(5) NULL,
    `tr_authorised_date` DATETIME NULL,
    `tr_authorised_by` VARCHAR(100) NULL,
    PRIMARY KEY (`tr_code`)
)  COMMENT='System Transactions';

ALTER TABLE `serenehrdb`.`shr_transactions` 
ADD COLUMN `tr_pr_code` INT NULL AFTER `tr_authorised_by`,
ADD INDEX `tr_pr_code_idx` (`tr_pr_code` ASC);
ALTER TABLE `serenehrdb`.`shr_transactions` 
ADD CONSTRAINT `tr_pr_code_fk`
  FOREIGN KEY (`tr_pr_code`)
  REFERENCES `serenehrdb`.`shr_payrolls` (`pr_code`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

CREATE TABLE `serenehrdb`.`shr_prd_pay_elements` (
    `ppe_code` INT NOT NULL AUTO_INCREMENT,
    `ppe_emp_code` INT NOT NULL,
    `ppe_pel_code` INT NOT NULL,
    `ppe_amt` DECIMAL(25 , 5 ) NOT NULL,
    `ppe_date` DATETIME NOT NULL DEFAULT Now (),
    `ppe_done_by` VARCHAR(100) NOT NULL,
    `ppe_authorized` VARCHAR(5) NULL DEFAULT 'NO',
    `ppe_authorized_by` VARCHAR(100) NULL,
    `ppe_authorized_date` DATETIME NULL,
    `ppe_tr_code` INT NULL,
    PRIMARY KEY (`ppe_code`),
    INDEX `ppe_tr_code_idx` (`ppe_tr_code` ASC),
    INDEX `ppe_emp_code_idx` (`ppe_emp_code` ASC),
    INDEX `ppe_pel_code_idx` (`ppe_pel_code` ASC),
    CONSTRAINT `ppe_tr_code_fk` FOREIGN KEY (`ppe_tr_code`)
        REFERENCES `serenehrdb`.`shr_transactions` (`tr_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ppe_emp_code_fk` FOREIGN KEY (`ppe_emp_code`)
        REFERENCES `serenehrdb`.`shr_employees` (`emp_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ppe_pel_code_fk` FOREIGN KEY (`ppe_pel_code`)
        REFERENCES `serenehrdb`.`shr_pay_elements` (`pel_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT
)  COMMENT='Periodic Pay Elements';

CREATE TABLE `shr_mkt_intr_rates` (
    `mkt_code` int(11) NOT NULL AUTO_INCREMENT,
    `mkt_rate` int(11) NOT NULL,
    `mkt_div_factr` int(11) NOT NULL,
    `mkt_wef` date NOT NULL,
    `mkt_wet` date DEFAULT NULL,
    `mkt_lt_code` int(11) NOT NULL,
    `mkt_frequency` varchar(20) NOT NULL Default 'MONTHLY',
    PRIMARY KEY (`mkt_code`),
    KEY `mkt_lt_code_idx` (`mkt_lt_code`),
    CONSTRAINT `mkt_lt_code_fk` FOREIGN KEY (`mkt_lt_code`)
        REFERENCES `shr_loan_types` (`lt_code`)
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Loan Interest Rates';


CREATE TABLE `serenehrdb`.`shr_user_role_privlg` (
    `urp_code` BIGINT NOT NULL AUTO_INCREMENT,
    `urp_ur_code` INT NULL,
    `urp_up_code` INT NULL,
    `urp_date` DATETIME NOT NULL DEFAULT Now (),
    PRIMARY KEY (`urp_code`),
    INDEX `urp_ur_code_idx` (`urp_ur_code` ASC),
    INDEX `urp_up_code_idx` (`urp_up_code` ASC),
    CONSTRAINT `urp_ur_code_fk` FOREIGN KEY (`urp_ur_code`)
        REFERENCES `serenehrdb`.`shr_user_roles` (`ur_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `urp_up_code_fk` FOREIGN KEY (`urp_up_code`)
        REFERENCES `serenehrdb`.`shr_user_privillages` (`up_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT
)  COMMENT='Role privilages';

ALTER TABLE `serenehrdb`.`shr_user_role_privlg` 
ADD COLUMN `urp_min_amt` BIGINT NULL AFTER `urp_date`,
ADD COLUMN `urp_max_amt` BIGINT NULL AFTER `urp_min_amt`;

CREATE TABLE `serenehrdb`.`shr_user_roles_granted` (
    `usg_code` BIGINT NOT NULL AUTO_INCREMENT,
    `usg_usr_code` INT NOT NULL,
    `usg_ur_code` INT NOT NULL,
    `usg_date` DATETIME NULL DEFAULT Now (),
    `usg_created_by` VARCHAR(100) NULL,
    PRIMARY KEY (`usg_code`),
    INDEX `usg_usr_code_idx` (`usg_usr_code` ASC),
    INDEX `usg_ur_code_idx` (`usg_ur_code` ASC),
    CONSTRAINT `usg_usr_code_fk` FOREIGN KEY (`usg_usr_code`)
        REFERENCES `serenehrdb`.`shr_users` (`usr_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `usg_ur_code_fk` FOREIGN KEY (`usg_ur_code`)
        REFERENCES `serenehrdb`.`shr_user_roles` (`ur_code`)
        ON DELETE RESTRICT ON UPDATE RESTRICT
)  COMMENT='Granted User Roles';

ALTER TABLE `serenehrdb`.`shr_employees` 
ADD COLUMN `emp_bbr_code` INT NULL AFTER `emp_pr_code`,
ADD INDEX `emp_bbr_code_idx` (`emp_bbr_code` ASC);
ALTER TABLE `serenehrdb`.`shr_employees` 
ADD CONSTRAINT `emp_bbr_code_fk`
  FOREIGN KEY (`emp_bbr_code`)
  REFERENCES `serenehrdb`.`shr_bank_branches` (`bbr_code`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE `serenehrdb`.`shr_employees` 
ADD COLUMN `emp_bank_acc_no` VARCHAR(45) NULL AFTER `emp_bbr_code`;

ALTER TABLE `serenehrdb`.`shr_employees` 
ADD COLUMN `emp_bnk_code` INT NULL AFTER `emp_bank_acc_no`,
ADD INDEX `emp_bnk_code_idx` (`emp_bnk_code` ASC);
ALTER TABLE `serenehrdb`.`shr_employees` 
ADD CONSTRAINT `emp_bnk_code_fk`
  FOREIGN KEY (`emp_bnk_code`)
  REFERENCES `serenehrdb`.`shr_banks` (`bnk_code`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

ALTER TABLE `serenehrdb`.`shr_tax_rates` 
ADD COLUMN `txr_frequency` VARCHAR(45) NULL DEFAULT 'MONTHLY' AFTER `txr_range_to`;

ALTER TABLE `serenehrdb`.`shr_pay_elements` 
ADD COLUMN `pel_applied_to` VARCHAR(45) NOT NULL DEFAULT 'EMPLOYEE' AFTER `pel_type`;

ALTER TABLE `serenehrdb`.`shr_pay_elements` 
ADD UNIQUE INDEX `pel_sht_desc_UNIQUE` (`pel_sht_desc` ASC);

ALTER TABLE `serenehrdb`.`shr_employees` 
ADD COLUMN `emp_photo` MEDIUMBLOB NULL AFTER `emp_bnk_code`;

ALTER TABLE `serenehrdb`.`shr_employees` 
ADD COLUMN `emp_photo_filename` VARCHAR(100) NULL AFTER `emp_photo`,
ADD COLUMN `emp_phot_ext` VARCHAR(10) NULL AFTER `emp_photo_filename`;

ALTER TABLE `serenehrdb`.`shr_employees` 
ADD COLUMN `emp_photo_updatedby` VARCHAR(100) NULL AFTER `emp_phot_ext`;

ALTER TABLE `serenehrdb`.`shr_pay_elements` 
ADD COLUMN `pel_nontax_allowed_amt` DECIMAL(25,5) NULL COMMENT 'Maximum amount that should not be taxable.' AFTER `pel_applied_to`,
ADD COLUMN `pel_prescribed_amt` DECIMAL(25,5) NULL COMMENT 'Prescribed amount by the authorities' AFTER `pel_nontax_allowed_amt`;

ALTER TABLE `serenehrdb`.`shr_prd_pay_elements` 
ADD COLUMN `ppe_ded_amt_b4_tax` DECIMAL(25,5) NULL COMMENT 'Deduction amount before PAYE computaion.' AFTER `ppe_tr_code`;
ALTER TABLE `serenehrdb`.`shr_prd_pay_elements` 
ADD COLUMN `ppe_val_of_benfit_amt` DECIMAL(25,5) NULL COMMENT 'Value of Benefit. (Applies to Benefits Only)' AFTER `ppe_ded_amt_b4_tax`;

ALTER TABLE `serenehrdb`.`shr_prd_pay_elements` 
ADD COLUMN `ppe_ot_hours` DECIMAL(5,2) NULL COMMENT 'Overtime Hours' AFTER `ppe_val_of_benfit_amt`;

ALTER TABLE `serenehrdb`.`shr_emp_pay_elements` 
ADD COLUMN `epe_ot_hours` DECIMAL(5,2) NULL COMMENT 'Overtime Hours' AFTER `epe_status`;

ALTER TABLE `serenehrdb`.`shr_payrolls` 
ADD COLUMN `pr_day1_hrs` DECIMAL(5,2) NULL COMMENT 'Day 7 (Sunday) working hours' AFTER `pr_freq`,
ADD COLUMN `pr_day2_hrs` DECIMAL(5,2) NULL COMMENT 'Day 7 (Monday) working hours' AFTER `pr_day1_hrs`,
ADD COLUMN `pr_day3_hrs` DECIMAL(5,2) NULL COMMENT 'Day 7 (Tuesday) working hours' AFTER `pr_day2_hrs`,
ADD COLUMN `pr_day4_hrs` DECIMAL(5,2) NULL COMMENT 'Day 7 (Wednesday) working hours' AFTER `pr_day3_hrs`,
ADD COLUMN `pr_day5_hrs` DECIMAL(5,2) NULL COMMENT 'Day 7 (Thursday) working hours' AFTER `pr_day4_hrs`,
ADD COLUMN `pr_day6_hrs` DECIMAL(5,2) NULL COMMENT 'Day 7 (Friday) working hours' AFTER `pr_day5_hrs`,
ADD COLUMN `pr_day7_hrs` DECIMAL(5,2) NULL COMMENT 'Day 7 (Saturday) working hours' AFTER `pr_day6_hrs`;

ALTER TABLE `serenehrdb`.`shr_transactions` 
ADD COLUMN `tr_pr_month` INT(11) NULL AFTER `tr_pr_code`,
ADD COLUMN `tr_pr_year` INT NULL AFTER `tr_pr_month`;

ALTER TABLE `serenehrdb`.`shr_pay_elements` 
ADD COLUMN `pel_order` INT NULL COMMENT 'Payslip Pay Element Order.' AFTER `pel_prescribed_amt`;

UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='1' WHERE `pel_code`='1';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='2' WHERE `pel_code`='2';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='3' WHERE `pel_code`='3';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='4' WHERE `pel_code`='4';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='5' WHERE `pel_code`='5';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='6' WHERE `pel_code`='6';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='7' WHERE `pel_code`='7';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='8' WHERE `pel_code`='9';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='9' WHERE `pel_code`='10';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='10' WHERE `pel_code`='11';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='11' WHERE `pel_code`='12';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='12' WHERE `pel_code`='13';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='13' WHERE `pel_code`='16';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='14' WHERE `pel_code`='18';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='15' WHERE `pel_code`='19';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='16' WHERE `pel_code`='20';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='17' WHERE `pel_code`='21';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='18' WHERE `pel_code`='22';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='19' WHERE `pel_code`='23';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='20' WHERE `pel_code`='24';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='21' WHERE `pel_code`='25';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='22' WHERE `pel_code`='26';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='23' WHERE `pel_code`='27';
UPDATE `serenehrdb`.`shr_pay_elements` SET `pel_order`='24' WHERE `pel_code`='28';

ALTER TABLE `serenehrdb`.`shr_pay_elements` 
ADD COLUMN `pel_selected` INT NULL AFTER `pel_order`;
ALTER TABLE `serenehrdb`.`shr_pay_elements` 
CHANGE COLUMN `pel_selected` `pel_selected` INT(11) NULL DEFAULT 0 ;

