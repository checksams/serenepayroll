SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `serenehrdb` DEFAULT CHARACTER SET utf8 ;
USE `serenehrdb` ;

-- -----------------------------------------------------
-- Table `serenehrdb`.`imp_shr_employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`imp_shr_employees` (
  `emp_code` INT(11) NOT NULL AUTO_INCREMENT,
  `emp_sht_desc` VARCHAR(45) NULL DEFAULT NULL,
  `emp_surname` VARCHAR(100) NULL DEFAULT NULL,
  `emp_other_names` VARCHAR(100) NULL DEFAULT NULL,
  `emp_tel_no1` VARCHAR(45) NULL DEFAULT NULL,
  `emp_tel_no2` VARCHAR(45) NULL DEFAULT NULL,
  `emp_sms_no` VARCHAR(45) NULL DEFAULT NULL,
  `emp_contract_date` DATE NULL DEFAULT NULL,
  `emp_final_date` DATE NULL DEFAULT NULL,
  `emp_org_code` INT(11) NULL DEFAULT NULL,
  `emp_organization` VARCHAR(100) NULL DEFAULT NULL,
  `emp_gender` VARCHAR(15) NULL DEFAULT NULL,
  `emp_join_date` DATE NULL DEFAULT NULL,
  `emp_work_email` VARCHAR(100) NULL DEFAULT NULL,
  `emp_personal_email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`emp_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Employee Details Import';

CREATE INDEX `emp_org_code_fk_idx` ON `serenehrdb`.`imp_shr_employees` (`emp_org_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_areas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_areas` (
  `ar_code` INT(11) NOT NULL AUTO_INCREMENT,
  `ar_name` VARCHAR(30) NOT NULL,
  `ar_desc` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ar_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'System areas';


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_areas_subone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_areas_subone` (
  `arso_code` INT(11) NOT NULL AUTO_INCREMENT,
  `arso_ar_code` INT(11) NULL DEFAULT NULL,
  `arso_name` VARCHAR(30) NOT NULL,
  `arso_desc` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`arso_code`),
  CONSTRAINT `arso_ar_code_fk`
    FOREIGN KEY (`arso_ar_code`)
    REFERENCES `serenehrdb`.`shr_areas` (`ar_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'System sub areas level 1';

CREATE INDEX `arso_ar_code_fk` ON `serenehrdb`.`shr_areas_subone` (`arso_ar_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_areas_subtwo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_areas_subtwo` (
  `arst_code` INT(11) NOT NULL AUTO_INCREMENT,
  `arst_arso_code` INT(11) NULL DEFAULT NULL,
  `arst_ar_code` INT(11) NULL DEFAULT NULL,
  `arst_name` VARCHAR(30) NOT NULL,
  `arst_desc` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`arst_code`),
  CONSTRAINT `arst_arso_code_fk`
    FOREIGN KEY (`arst_arso_code`)
    REFERENCES `serenehrdb`.`shr_areas_subone` (`arso_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'System sub areas level 2';

CREATE INDEX `arst_arso_code_fk` ON `serenehrdb`.`shr_areas_subtwo` (`arst_arso_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_areas_subthree`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_areas_subthree` (
  `artr_code` INT(11) NOT NULL AUTO_INCREMENT,
  `artr_name` VARCHAR(30) NOT NULL,
  `artr_desc` VARCHAR(100) NOT NULL,
  `artr_arst_code` INT(11) NULL DEFAULT NULL,
  `artr_arso_code` INT(11) NULL DEFAULT NULL,
  `artr_ar_code` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`artr_code`),
  CONSTRAINT `artr_arst_code_fk`
    FOREIGN KEY (`artr_arst_code`)
    REFERENCES `serenehrdb`.`shr_areas_subtwo` (`arst_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'System sub areas level 2';

CREATE INDEX `artr_arst_code_fk` ON `serenehrdb`.`shr_areas_subthree` (`artr_arst_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_banks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_banks` (
  `bnk_code` INT(11) NOT NULL AUTO_INCREMENT,
  `bnk_sht_desc` VARCHAR(15) NOT NULL,
  `bnk_name` VARCHAR(300) NOT NULL,
  `bnk_postal_address` VARCHAR(1000) NULL DEFAULT NULL,
  `bnk_physical_address` VARCHAR(1000) NULL DEFAULT NULL,
  `bnk_kba_code` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`bnk_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 1427
DEFAULT CHARACTER SET = utf8
COMMENT = 'Banks';


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_bank_branches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_bank_branches` (
  `bbr_code` INT(11) NOT NULL AUTO_INCREMENT,
  `bbr_sht_desc` VARCHAR(15) NOT NULL,
  `bbr_name` VARCHAR(300) NOT NULL,
  `bbr_postal_address` VARCHAR(1000) NULL DEFAULT NULL,
  `bbr_physical_address` VARCHAR(1000) NULL DEFAULT NULL,
  `bbr_tel_no1` VARCHAR(45) NULL DEFAULT NULL,
  `bbr_tel_no2` VARCHAR(45) NULL DEFAULT NULL,
  `bbr_bnk_code` INT(11) NOT NULL,
  PRIMARY KEY (`bbr_code`),
  CONSTRAINT `bbr_bnk_code_fk`
    FOREIGN KEY (`bbr_bnk_code`)
    REFERENCES `serenehrdb`.`shr_banks` (`bnk_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 3933
DEFAULT CHARACTER SET = utf8
COMMENT = 'Bank Branches';

CREATE INDEX `bbr_bnk_code_idx` ON `serenehrdb`.`shr_bank_branches` (`bbr_bnk_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_organizations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_organizations` (
  `org_code` INT(11) NOT NULL AUTO_INCREMENT,
  `org_sht_desc` VARCHAR(30) NOT NULL,
  `org_desc` VARCHAR(1000) NOT NULL,
  `org_postal_address` VARCHAR(1000) NULL DEFAULT NULL,
  `org_physical_address` VARCHAR(1000) NULL DEFAULT NULL,
  `org_type` VARCHAR(10) NULL DEFAULT NULL,
  `org_parent_org_code` INT(11) NULL DEFAULT NULL,
  `org_parent_org_sht_desc` VARCHAR(30) NULL DEFAULT NULL,
  `org_wef` DATE NULL DEFAULT NULL,
  `org_wet` DATE NULL DEFAULT NULL,
  `org_level` SMALLINT(6) NULL DEFAULT NULL,
  `org_pin_no` VARCHAR(45) NULL DEFAULT NULL,
  `org_p9a_approval_no` VARCHAR(45) NULL DEFAULT NULL,
  `org_nssf_no` VARCHAR(45) NULL DEFAULT NULL,
  `org_nhif_no` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`org_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8
COMMENT = 'Organization structure';


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_payrolls`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_payrolls` (
  `pr_code` INT(11) NOT NULL AUTO_INCREMENT,
  `pr_sht_desc` VARCHAR(45) NOT NULL,
  `pr_desc` VARCHAR(100) NULL DEFAULT NULL,
  `pr_org_code` INT(11) NULL DEFAULT NULL,
  `pr_wef` DATE NULL DEFAULT NULL,
  `pr_wet` DATE NULL DEFAULT NULL,
  `pr_freq` VARCHAR(45) NULL DEFAULT 'MONTHLY' COMMENT 'Payroll frequency of processing',
  `pr_day1_hrs` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Day 7 (Sunday) working hours',
  `pr_day2_hrs` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Day 7 (Monday) working hours',
  `pr_day3_hrs` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Day 7 (Tuesday) working hours',
  `pr_day4_hrs` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Day 7 (Wednesday) working hours',
  `pr_day5_hrs` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Day 7 (Thursday) working hours',
  `pr_day6_hrs` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Day 7 (Friday) working hours',
  `pr_day7_hrs` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Day 7 (Saturday) working hours',
  PRIMARY KEY (`pr_code`),
  CONSTRAINT `pr_org_code_fk`
    FOREIGN KEY (`pr_org_code`)
    REFERENCES `serenehrdb`.`shr_organizations` (`org_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COMMENT = 'Payroll Definition Table';

CREATE INDEX `pr_org_code_fk_idx` ON `serenehrdb`.`shr_payrolls` (`pr_org_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_employees` (
  `emp_code` INT(11) NOT NULL AUTO_INCREMENT,
  `emp_sht_desc` VARCHAR(45) NULL DEFAULT NULL,
  `emp_surname` VARCHAR(100) NOT NULL,
  `emp_other_names` VARCHAR(100) NULL DEFAULT NULL,
  `emp_tel_no1` VARCHAR(45) NULL DEFAULT NULL,
  `emp_tel_no2` VARCHAR(45) NULL DEFAULT NULL,
  `emp_sms_no` VARCHAR(45) NULL DEFAULT NULL,
  `emp_contract_date` DATE NULL DEFAULT NULL,
  `emp_final_date` DATE NULL DEFAULT NULL,
  `emp_org_code` INT(11) NOT NULL,
  `emp_organization` VARCHAR(100) NOT NULL,
  `emp_gender` VARCHAR(15) NULL DEFAULT 'MALE',
  `emp_join_date` DATE NULL DEFAULT NULL,
  `emp_work_email` VARCHAR(100) NULL DEFAULT NULL,
  `emp_personal_email` VARCHAR(100) NULL DEFAULT NULL,
  `emp_id_no` VARCHAR(45) NULL DEFAULT NULL,
  `emp_nssf_no` VARCHAR(45) NULL DEFAULT NULL,
  `emp_pin_no` VARCHAR(45) NULL DEFAULT NULL,
  `emp_nhif_no` VARCHAR(45) NULL DEFAULT NULL,
  `emp_lasc_no` VARCHAR(45) NULL DEFAULT NULL,
  `emp_nxt_kin_sname` VARCHAR(150) NULL DEFAULT NULL,
  `emp_nxt_kin_onames` VARCHAR(150) NULL DEFAULT NULL,
  `emp_nxt_kin_tel_no` VARCHAR(45) NULL DEFAULT NULL,
  `emp_pr_code` INT(11) NULL DEFAULT NULL,
  `emp_bbr_code` INT(11) NULL DEFAULT NULL,
  `emp_bank_acc_no` VARCHAR(45) NULL DEFAULT NULL,
  `emp_bnk_code` INT(11) NULL DEFAULT NULL,
  `emp_photo` MEDIUMBLOB NULL DEFAULT NULL,
  `emp_photo_filename` VARCHAR(100) NULL DEFAULT NULL,
  `emp_phot_ext` VARCHAR(10) NULL DEFAULT NULL,
  `emp_photo_updatedby` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`emp_code`),
  CONSTRAINT `emp_bbr_code_fk`
    FOREIGN KEY (`emp_bbr_code`)
    REFERENCES `serenehrdb`.`shr_bank_branches` (`bbr_code`),
  CONSTRAINT `emp_bnk_code_fk`
    FOREIGN KEY (`emp_bnk_code`)
    REFERENCES `serenehrdb`.`shr_banks` (`bnk_code`),
  CONSTRAINT `emp_org_code_fk`
    FOREIGN KEY (`emp_org_code`)
    REFERENCES `serenehrdb`.`shr_organizations` (`org_code`),
  CONSTRAINT `emp_pr_code_fk`
    FOREIGN KEY (`emp_pr_code`)
    REFERENCES `serenehrdb`.`shr_payrolls` (`pr_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 68
DEFAULT CHARACTER SET = utf8
COMMENT = 'Employee Details';

CREATE INDEX `emp_org_code_fk_idx` ON `serenehrdb`.`shr_employees` (`emp_org_code` ASC);

CREATE INDEX `emp_pr_code_idx` ON `serenehrdb`.`shr_employees` (`emp_pr_code` ASC);

CREATE INDEX `emp_bbr_code_idx` ON `serenehrdb`.`shr_employees` (`emp_bbr_code` ASC);

CREATE INDEX `emp_bnk_code_idx` ON `serenehrdb`.`shr_employees` (`emp_bnk_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_loan_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_loan_types` (
  `lt_code` INT(11) NOT NULL AUTO_INCREMENT,
  `lt_sht_desc` VARCHAR(45) NOT NULL,
  `lt_desc` VARCHAR(100) NOT NULL,
  `lt_min_repay_prd` INT(11) NOT NULL,
  `lt_max_repay_prd` INT(11) NOT NULL,
  `lt_min_amt` INT(11) NOT NULL,
  `lt_max_amt` INT(11) NOT NULL,
  `lt_wef` DATE NOT NULL,
  `lt_wet` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`lt_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8
COMMENT = 'Loan Types';

CREATE UNIQUE INDEX `lt_sht_desc_UNIQUE` ON `serenehrdb`.`shr_loan_types` (`lt_sht_desc` ASC);

CREATE UNIQUE INDEX `lt_desc_UNIQUE` ON `serenehrdb`.`shr_loan_types` (`lt_desc` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_emp_loans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_emp_loans` (
  `el_code` INT(11) NOT NULL AUTO_INCREMENT,
  `el_emp_code` INT(11) NOT NULL,
  `el_date` DATE NOT NULL,
  `el_eff_date` DATE NOT NULL,
  `el_loan_applied_amt` DECIMAL(25,5) NOT NULL,
  `el_service_charge` DECIMAL(25,5) NOT NULL,
  `el_issued_amt` DECIMAL(25,5) NOT NULL,
  `el_intr_rate` INT(11) NULL DEFAULT NULL,
  `el_intr_div_factr` INT(11) NULL DEFAULT NULL,
  `el_done_by` VARCHAR(100) NOT NULL,
  `el_authorised_by` VARCHAR(100) NULL DEFAULT NULL,
  `el_authorised_date` DATE NULL DEFAULT NULL,
  `el_authorised` VARCHAR(5) NULL DEFAULT NULL,
  `el_tot_tax_amt` DECIMAL(25,5) NULL DEFAULT NULL COMMENT 'Employee Loans',
  `el_lt_code` INT(11) NOT NULL,
  `el_tr_code` BIGINT(20) NULL DEFAULT NULL,
  `el_loan_amt` DECIMAL(25,5) NULL DEFAULT '0.00000',
  `el_processed` VARCHAR(5) NULL DEFAULT NULL,
  `el_processed_by` VARCHAR(5) NULL DEFAULT NULL,
  `el_processed_date` DATE NULL DEFAULT NULL,
  `el_final_repay_date` DATE NULL DEFAULT NULL,
  `el_tot_instalments` INT(11) NULL DEFAULT NULL,
  `el_instalment_amt` DECIMAL(25,5) NULL DEFAULT NULL,
  PRIMARY KEY (`el_code`),
  CONSTRAINT `el_emp_code_fk`
    FOREIGN KEY (`el_emp_code`)
    REFERENCES `serenehrdb`.`shr_employees` (`emp_code`),
  CONSTRAINT `el_lt_code_fk`
    FOREIGN KEY (`el_lt_code`)
    REFERENCES `serenehrdb`.`shr_loan_types` (`lt_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8
COMMENT = 'Employee Loans';

CREATE INDEX `el_emp_code_idx` ON `serenehrdb`.`shr_emp_loans` (`el_emp_code` ASC);

CREATE INDEX `el_lt_code_idx` ON `serenehrdb`.`shr_emp_loans` (`el_lt_code` ASC);

CREATE INDEX `el_tr_code_idx` ON `serenehrdb`.`shr_emp_loans` (`el_tr_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_pay_elements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_pay_elements` (
  `pel_code` INT(11) NOT NULL AUTO_INCREMENT,
  `pel_sht_desc` VARCHAR(45) NOT NULL,
  `pel_desc` VARCHAR(200) NOT NULL,
  `pel_taxable` VARCHAR(5) NULL DEFAULT NULL,
  `pel_deduction` VARCHAR(5) NULL DEFAULT NULL,
  `pel_depends_on` INT(11) NULL DEFAULT NULL,
  `pel_type` VARCHAR(100) NOT NULL,
  `pel_applied_to` VARCHAR(45) NOT NULL DEFAULT 'EMPLOYEE',
  `pel_nontax_allowed_amt` DECIMAL(25,5) NULL DEFAULT NULL COMMENT 'Maximum amount that should not be taxable.',
  `pel_prescribed_amt` DECIMAL(25,5) NULL DEFAULT NULL COMMENT 'Prescribed amount by the authorities',
  `pel_order` INT(11) NULL DEFAULT NULL COMMENT 'Payslip Pay Element Order',
  `pel_selected` INT(11) NULL DEFAULT '0',
  PRIMARY KEY (`pel_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 29
DEFAULT CHARACTER SET = utf8
COMMENT = 'Pay elements table';

CREATE UNIQUE INDEX `pel_sht_desc_UNIQUE` ON `serenehrdb`.`shr_pay_elements` (`pel_sht_desc` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_emp_pay_elements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_emp_pay_elements` (
  `epe_code` INT(11) NOT NULL AUTO_INCREMENT,
  `epe_emp_code` INT(11) NOT NULL,
  `epe_pel_code` INT(11) NOT NULL,
  `epe_amt` DECIMAL(25,5) NULL DEFAULT NULL,
  `epe_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `epe_created_by` VARCHAR(100) NULL DEFAULT NULL,
  `epe_status` VARCHAR(45) NULL DEFAULT 'ACTIVE' COMMENT 'Pay Element Status (ACTIVE,INACTIVE)',
  `epe_ot_hours` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Overtime Hours',
  PRIMARY KEY (`epe_code`),
  CONSTRAINT `epe_emp_code_fk`
    FOREIGN KEY (`epe_emp_code`)
    REFERENCES `serenehrdb`.`shr_employees` (`emp_code`),
  CONSTRAINT `epe_pel_code_fk`
    FOREIGN KEY (`epe_pel_code`)
    REFERENCES `serenehrdb`.`shr_pay_elements` (`pel_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 116
DEFAULT CHARACTER SET = utf8
COMMENT = 'Employee Pay elements';

CREATE INDEX `epe_emp_code_idx` ON `serenehrdb`.`shr_emp_pay_elements` (`epe_emp_code` ASC);

CREATE INDEX `epe_pel_code_idx` ON `serenehrdb`.`shr_emp_pay_elements` (`epe_pel_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_job_titles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_job_titles` (
  `jt_code` INT(11) NOT NULL AUTO_INCREMENT,
  `jt_sht_code` VARCHAR(45) NOT NULL,
  `jt_desc` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`jt_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8
COMMENT = 'Job Titles';


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_loan_intr_rates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_loan_intr_rates` (
  `lir_code` INT(11) NOT NULL AUTO_INCREMENT,
  `lir_rate` INT(11) NOT NULL,
  `lir_div_factr` INT(11) NOT NULL,
  `lir_wef` DATE NOT NULL,
  `lir_wet` DATE NULL DEFAULT NULL,
  `lir_lt_code` INT(11) NOT NULL,
  PRIMARY KEY (`lir_code`),
  CONSTRAINT `lir_lt_code_fk`
    FOREIGN KEY (`lir_lt_code`)
    REFERENCES `serenehrdb`.`shr_loan_types` (`lt_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8
COMMENT = 'Loan Interest Rates';

CREATE INDEX `lir_lt_code_idx` ON `serenehrdb`.`shr_loan_intr_rates` (`lir_lt_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_mkt_intr_rates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_mkt_intr_rates` (
  `mkt_code` INT(11) NOT NULL AUTO_INCREMENT,
  `mkt_rate` INT(11) NOT NULL,
  `mkt_div_factr` INT(11) NOT NULL,
  `mkt_wef` DATE NOT NULL,
  `mkt_wet` DATE NULL DEFAULT NULL,
  `mkt_lt_code` INT(11) NOT NULL,
  `mkt_frequency` VARCHAR(20) NOT NULL DEFAULT 'MONTHLY',
  PRIMARY KEY (`mkt_code`),
  CONSTRAINT `mkt_lt_code_fk`
    FOREIGN KEY (`mkt_lt_code`)
    REFERENCES `serenehrdb`.`shr_loan_types` (`lt_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Loan Interest Rates';

CREATE INDEX `mkt_lt_code_idx` ON `serenehrdb`.`shr_mkt_intr_rates` (`mkt_lt_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_transactions` (
  `tr_code` INT(11) NOT NULL AUTO_INCREMENT,
  `tr_type` VARCHAR(45) NOT NULL,
  `tr_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tr_done_by` VARCHAR(100) NOT NULL,
  `tr_authorised` VARCHAR(5) NULL DEFAULT NULL,
  `tr_authorised_date` DATETIME NULL DEFAULT NULL,
  `tr_authorised_by` VARCHAR(100) NULL DEFAULT NULL,
  `tr_pr_code` INT(11) NULL DEFAULT NULL,
  `tr_pr_month` INT(11) NULL DEFAULT NULL,
  `tr_pr_year` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`tr_code`),
  CONSTRAINT `tr_pr_code_fk`
    FOREIGN KEY (`tr_pr_code`)
    REFERENCES `serenehrdb`.`shr_payrolls` (`pr_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8
COMMENT = 'System Transactions';

CREATE INDEX `tr_pr_code_idx` ON `serenehrdb`.`shr_transactions` (`tr_pr_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_prd_pay_elements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_prd_pay_elements` (
  `ppe_code` INT(11) NOT NULL AUTO_INCREMENT,
  `ppe_emp_code` INT(11) NOT NULL,
  `ppe_pel_code` INT(11) NOT NULL,
  `ppe_amt` DECIMAL(25,5) NOT NULL,
  `ppe_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ppe_done_by` VARCHAR(100) NOT NULL,
  `ppe_authorized` VARCHAR(5) NULL DEFAULT 'NO',
  `ppe_authorized_by` VARCHAR(100) NULL DEFAULT NULL,
  `ppe_authorized_date` DATETIME NULL DEFAULT NULL,
  `ppe_tr_code` INT(11) NULL DEFAULT NULL,
  `ppe_ded_amt_b4_tax` DECIMAL(25,5) NULL DEFAULT NULL COMMENT 'Deduction amount before PAYE computaion.',
  `ppe_val_of_benfit_amt` DECIMAL(25,5) NULL DEFAULT NULL COMMENT 'Value of Benefit. (Applies to Benefits Only)',
  `ppe_ot_hours` DECIMAL(5,2) NULL DEFAULT NULL COMMENT 'Overtime Hours',
  PRIMARY KEY (`ppe_code`),
  CONSTRAINT `ppe_emp_code_fk`
    FOREIGN KEY (`ppe_emp_code`)
    REFERENCES `serenehrdb`.`shr_employees` (`emp_code`),
  CONSTRAINT `ppe_pel_code_fk`
    FOREIGN KEY (`ppe_pel_code`)
    REFERENCES `serenehrdb`.`shr_pay_elements` (`pel_code`),
  CONSTRAINT `ppe_tr_code_fk`
    FOREIGN KEY (`ppe_tr_code`)
    REFERENCES `serenehrdb`.`shr_transactions` (`tr_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 119
DEFAULT CHARACTER SET = utf8
COMMENT = 'Periodic Pay Elements';

CREATE INDEX `ppe_tr_code_idx` ON `serenehrdb`.`shr_prd_pay_elements` (`ppe_tr_code` ASC);

CREATE INDEX `ppe_emp_code_idx` ON `serenehrdb`.`shr_prd_pay_elements` (`ppe_emp_code` ASC);

CREATE INDEX `ppe_pel_code_idx` ON `serenehrdb`.`shr_prd_pay_elements` (`ppe_pel_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_proll_pelements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_proll_pelements` (
  `pp_code` INT(11) NOT NULL AUTO_INCREMENT,
  `pp_pel_code` INT(11) NOT NULL,
  `pp_pr_code` INT(11) NOT NULL,
  PRIMARY KEY (`pp_code`),
  CONSTRAINT `pp_pel_code_fk`
    FOREIGN KEY (`pp_pel_code`)
    REFERENCES `serenehrdb`.`shr_pay_elements` (`pel_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pp_pr_code_fk`
    FOREIGN KEY (`pp_pr_code`)
    REFERENCES `serenehrdb`.`shr_payrolls` (`pr_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 40
DEFAULT CHARACTER SET = utf8
COMMENT = 'Payroll Pay Elements';

CREATE INDEX `pp_pel_code_idx` ON `serenehrdb`.`shr_proll_pelements` (`pp_pel_code` ASC);

CREATE INDEX `pp_pr_code_idx` ON `serenehrdb`.`shr_proll_pelements` (`pp_pr_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_taxes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_taxes` (
  `tx_code` INT(11) NOT NULL AUTO_INCREMENT,
  `tx_sht_desc` VARCHAR(45) NOT NULL,
  `tx_desc` VARCHAR(100) NOT NULL,
  `tx_wef` DATE NOT NULL,
  `tx_wet` DATE NULL DEFAULT NULL,
  `tx_rate_type` VARCHAR(45) NOT NULL DEFAULT 'FIXED',
  PRIMARY KEY (`tx_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8
COMMENT = 'Taxes and Charges Types';


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_tax_rates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_tax_rates` (
  `txr_code` INT(11) NOT NULL AUTO_INCREMENT,
  `txr_desc` VARCHAR(100) NULL DEFAULT NULL,
  `txr_rate_type` VARCHAR(45) NULL DEFAULT NULL,
  `txr_rate` INT(11) NOT NULL,
  `txr_div_factr` INT(11) NULL DEFAULT NULL,
  `txr_wef` DATE NOT NULL,
  `txr_wet` DATE NULL DEFAULT NULL,
  `txr_tx_code` INT(11) NULL DEFAULT NULL,
  `txr_range_from` INT(11) NULL DEFAULT NULL,
  `txr_range_to` BIGINT(20) NULL DEFAULT NULL,
  `txr_frequency` VARCHAR(45) NULL DEFAULT 'MONTHLY',
  PRIMARY KEY (`txr_code`),
  CONSTRAINT `txr_tx_code_fk`
    FOREIGN KEY (`txr_tx_code`)
    REFERENCES `serenehrdb`.`shr_taxes` (`tx_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 132
DEFAULT CHARACTER SET = utf8
COMMENT = 'Tax Rates';

CREATE INDEX `txr_tx_code_fk_idx` ON `serenehrdb`.`shr_tax_rates` (`txr_tx_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_user_privillages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_user_privillages` (
  `up_code` INT(11) NOT NULL AUTO_INCREMENT,
  `up_name` VARCHAR(30) NOT NULL,
  `up_desc` VARCHAR(100) NOT NULL,
  `up_min_amt` DECIMAL(25,5) NULL DEFAULT NULL,
  `up_max_amt` DECIMAL(25,5) NULL DEFAULT NULL,
  `up_type` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`up_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8
COMMENT = 'User Privilages';


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_user_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_user_roles` (
  `ur_code` INT(11) NOT NULL AUTO_INCREMENT,
  `ur_name` VARCHAR(30) NOT NULL,
  `ur_desc` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ur_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COMMENT = 'User Roles and Privilages';


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_user_role_privlg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_user_role_privlg` (
  `urp_code` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `urp_ur_code` INT(11) NULL DEFAULT NULL,
  `urp_up_code` INT(11) NULL DEFAULT NULL,
  `urp_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `urp_min_amt` BIGINT(20) NULL DEFAULT NULL,
  `urp_max_amt` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`urp_code`),
  CONSTRAINT `urp_up_code_fk`
    FOREIGN KEY (`urp_up_code`)
    REFERENCES `serenehrdb`.`shr_user_privillages` (`up_code`),
  CONSTRAINT `urp_ur_code_fk`
    FOREIGN KEY (`urp_ur_code`)
    REFERENCES `serenehrdb`.`shr_user_roles` (`ur_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 55
DEFAULT CHARACTER SET = utf8
COMMENT = 'Role privilages';

CREATE INDEX `urp_ur_code_idx` ON `serenehrdb`.`shr_user_role_privlg` (`urp_ur_code` ASC);

CREATE INDEX `urp_up_code_idx` ON `serenehrdb`.`shr_user_role_privlg` (`urp_up_code` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_users` (
  `usr_code` INT(11) NOT NULL AUTO_INCREMENT,
  `usr_name` VARCHAR(30) NOT NULL,
  `usr_full_name` VARCHAR(100) NOT NULL,
  `usr_emp_code` INT(11) NULL DEFAULT NULL,
  `usr_pwd` VARCHAR(1000) NULL DEFAULT NULL,
  `usr_last_login` DATETIME NULL DEFAULT NULL,
  `usr_login_atempts` INT(11) NULL DEFAULT NULL,
  `usr_pwd_reset` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`usr_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8
COMMENT = 'Users';

CREATE UNIQUE INDEX `usr_name_UNIQUE` ON `serenehrdb`.`shr_users` (`usr_name` ASC);


-- -----------------------------------------------------
-- Table `serenehrdb`.`shr_user_roles_granted`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`shr_user_roles_granted` (
  `usg_code` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `usg_usr_code` INT(11) NOT NULL,
  `usg_ur_code` INT(11) NOT NULL,
  `usg_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `usg_created_by` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`usg_code`),
  CONSTRAINT `usg_ur_code_fk`
    FOREIGN KEY (`usg_ur_code`)
    REFERENCES `serenehrdb`.`shr_user_roles` (`ur_code`),
  CONSTRAINT `usg_usr_code_fk`
    FOREIGN KEY (`usg_usr_code`)
    REFERENCES `serenehrdb`.`shr_users` (`usr_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8
COMMENT = 'Granted User Roles';

CREATE INDEX `usg_usr_code_idx` ON `serenehrdb`.`shr_user_roles_granted` (`usg_usr_code` ASC);

CREATE INDEX `usg_ur_code_idx` ON `serenehrdb`.`shr_user_roles_granted` (`usg_ur_code` ASC);

USE `serenehrdb` ;

-- -----------------------------------------------------
-- Placeholder table for view `serenehrdb`.`vw_empployees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`vw_empployees` (`emp_code` INT, `emp_sht_desc` INT, `emp_surname` INT, `emp_other_names` INT, `emp_tel_no1` INT, `emp_tel_no2` INT, `emp_sms_no` INT, `emp_contract_date` INT, `emp_final_date` INT, `emp_organization` INT, `emp_gender` INT, `emp_join_date` INT, `emp_work_email` INT, `emp_personal_email` INT);

-- -----------------------------------------------------
-- Placeholder table for view `serenehrdb`.`vw_job_titlles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`vw_job_titlles` (`jt_code` INT, `jt_sht_code` INT, `jt_desc` INT);

-- -----------------------------------------------------
-- Placeholder table for view `serenehrdb`.`vw_orgarnization_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `serenehrdb`.`vw_orgarnization_view` (`org_code` INT, `org_sht_desc` INT, `org_desc` INT, `org_postal_address` INT, `org_physical_address` INT, `org_type` INT, `org_parent_org_code` INT, `org_parent_org_sht_desc` INT, `parent_organization` INT, `org_wef` INT, `org_wet` INT, `org_level` INT);

-- -----------------------------------------------------
-- procedure auth_emp_loan
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `auth_emp_loan`(v_el_code int,
									v_user varchar(100))
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_authorised,v_processed varchar(5);
declare v_error TEXT;

declare v_eff_date datetime;
declare v_intr_rate,v_intr_div_factr decimal(25,5);
declare v_lt_code bigint;
declare done boolean;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text=v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set v_error = ' ';

if v_user is null or v_user = '' then	
	set v_error_no = 1;
	set v_error = ' ';
	select concat(v_error,'Log in first to proceed...') into v_error;
	call raise_error();
end if;

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to find loan record...') into v_error;
SELECT el_eff_date,el_authorised,el_lt_code,
	  case when el_processed is null then 'NO' else el_processed end as el_processed
into v_eff_date,v_authorised,v_lt_code,v_processed
FROM `serenehrdb`.`shr_emp_loans` el
left join `serenehrdb`.`shr_loan_types`  lt on (el.el_lt_code=lt.lt_code)
where el_code = v_el_code;

if v_processed != 'YES' or v_processed is null then	
	set v_error_no = 1;
	set v_error = ' ';
	select concat(v_error,'Process loan first to proceed... Loan Id=', v_el_code,
			' processed=', v_processed) into v_error;
	call raise_error();
end if;

if v_authorised != 'NO' then	
	set v_error_no = 1;
	set v_error = ' ';
	select concat(v_error,'Authorising authorised transactions is not allowed...Loan Id=', v_el_code,
			' Authorised=', v_authorised) into v_error;
	call raise_error();
end if;

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to authorise loan...Loan Id=', v_el_code) into v_error;
Update `serenehrdb`.`shr_emp_loans`
	set `el_authorised_by` = v_user, 
		`el_authorised_date` = Now(), 
		`el_authorised` = 'YES'
WHERE `el_code` = v_el_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure calc_taxes
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `calc_taxes`(v_tx_code  int,
							v_date		datetime,
							v_amt_to_tax   decimal(25,5),
							out  v_tax_amt    decimal(25,5)
							)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error text;

  DECLARE c_txr_rate,c_txr_div_factr,c_txr_range_from, c_txr_range_to,
			v_cnt,cr_txr_rate,cr_txr_div_factr,
			cr_txr_range_from, cr_txr_range_to INT;
  
  DECLARE v_tax_rate INT;
  DECLARE c_emp_surname VARCHAR(150);
  DECLARE c_rate_type,v_rate_type VARCHAR(150);
  declare fxd_done,abs_done,steprng_done boolean;
  DECLARE v_range_amnt decimal;

  DECLARE cursor_tax CURSOR FOR 
	select `txr_rate`, `txr_div_factr`,`txr_range_from`, `txr_range_to`
	from `serenehrdb`.`shr_taxes`  t left join `serenehrdb`.`shr_tax_rates` r
	on t.tx_code = r.txr_tx_code 
	where t.tx_code = v_tx_code and tx_rate_type ='FIXED'
	and ((v_amt_to_tax >= txr_range_from) AND (v_amt_to_tax < txr_range_to))
	#and v_dt between `tx_wef` and  `tx_wet`
	order by txr_range_to
	;
  DECLARE cursor_abs_steprange_tax CURSOR FOR 
	select `txr_rate`, `txr_div_factr`,`txr_range_from`, `txr_range_to`
	from `serenehrdb`.`shr_taxes`  t left join `serenehrdb`.`shr_tax_rates` r
	on t.tx_code = r.txr_tx_code 
	where t.tx_code = v_tx_code and tx_rate_type IN ('STEP RANGE')
	and ((v_amt_to_tax > txr_range_from) AND (v_amt_to_tax <= txr_range_to))
	#and v_dt between `tx_wef` and  `tx_wet`
	order by txr_range_to
	;
  DECLARE cursor_steprange_tax CURSOR FOR 
	select `txr_rate`, `txr_div_factr`,`txr_range_from`, `txr_range_to`
	from `serenehrdb`.`shr_taxes`  t left join `serenehrdb`.`shr_tax_rates` r
	on t.tx_code = r.txr_tx_code 
	where t.tx_code = v_tx_code and tx_rate_type IN ('STEP RANGE')
	and txr_range_to < v_amt_to_tax
	#and v_dt between `tx_wef` and  `tx_wet`
	order by txr_range_to
	;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 
			sqlstate_code = RETURNED_SQLSTATE, 
			mysql_error = MYSQL_ERRNO, 
			message_text = MESSAGE_TEXT;

		if sqlstate_code <> '00000' then
			if v_error_no = 1 then 
				signal sqlstate '45000'
					set message_text= v_error;  #'Debuging';
			else
				#signal sqlstate '45000' set message_text= 'Unable to save records...';
				resignal;
			end if;			
		end if;
	END;

SET autocommit=0;
START TRANSACTION;
	select 'Error...' into v_error;
set v_cnt = 0;  
set v_tax_amt = 0;

	select `tx_rate_type` into c_rate_type
	from `serenehrdb`.`shr_taxes` 
	where tx_code = v_tx_code #and v_dt between `tx_wef` and  `tx_wet`
	;

	IF c_rate_type = 'FIXED' THEN
		BEGIN
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET fxd_done = TRUE;
			OPEN cursor_tax;
			  SET fxd_done = FALSE;
			  read_fxd_loop: LOOP
				FETCH cursor_tax INTO c_txr_rate,c_txr_div_factr,c_txr_range_from, c_txr_range_to;
				IF fxd_done THEN
				  LEAVE read_fxd_loop;
				END IF;

				set v_cnt = v_cnt + 1;

				IF c_rate_type ='FIXED' THEN
					# tax tariff rate is a fixed type
					IF c_txr_div_factr > 1 THEN
						#this is not a fixed amount
						SET v_tax_amt = (( c_txr_rate / c_txr_div_factr) * v_amt_to_tax);
						set v_tax_rate := c_txr_rate;
						set v_rate_type =c_rate_type;
					ELSE
						#this is  a fixed amount
						set v_tax_amt :=  (c_txr_rate ) ;
						set v_tax_rate := c_txr_rate;
						set v_rate_type =c_rate_type;
					END IF;
					#IF NVL(v_tax_amt,0) < c1rec.trt_min_amt THEN
					#	v_tax_amt := c1rec.trt_min_amt;
					#END IF;
				END IF;
			  END LOOP;
		  CLOSE cursor_tax;
		END;
	ELSEIF c_rate_type = 'STEP RANGE' THEN	
		begin
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET abs_done = TRUE;		  
			set v_cnt = 0;
			set abs_done = false;
			OPEN cursor_abs_steprange_tax;
			  SET abs_done = FALSE;
			  read_abs_loop: LOOP
				FETCH cursor_abs_steprange_tax INTO c_txr_rate,c_txr_div_factr,c_txr_range_from, c_txr_range_to;
				IF abs_done THEN
				  LEAVE read_abs_loop;
				END IF;
				BEGIN
					DECLARE CONTINUE HANDLER FOR NOT FOUND SET steprng_done = TRUE;
					set v_cnt = v_cnt + 1;
					set steprng_done = false;
					set v_range_amnt = 0;

					OPEN cursor_steprange_tax;
					  SET steprng_done = FALSE;
					  read_steprng_loop: LOOP
						FETCH cursor_steprange_tax INTO cr_txr_rate,cr_txr_div_factr,cr_txr_range_from, cr_txr_range_to;
						IF steprng_done THEN
						  LEAVE read_steprng_loop;
						END IF;

						set v_cnt = v_cnt + 1;

						IF c_rate_type ='STEP RANGE' THEN
							# tax tariff rate is a fixed type
							IF cr_txr_div_factr > 1 THEN
								#this is not a fixed amount
								SET v_tax_amt = v_tax_amt + round(( cr_txr_rate / cr_txr_div_factr) * (cr_txr_range_to-cr_txr_range_from),4);
								set v_range_amnt = v_range_amnt + (cr_txr_range_to-cr_txr_range_from);
								set v_tax_rate := cr_txr_rate;
								set v_rate_type =c_rate_type;
							ELSE
								#this is  a fixed amount
								set v_tax_amt :=  (cr_txr_rate ) ;
								set v_tax_rate := cr_txr_rate;
								set v_rate_type =c_rate_type;
							END IF;
							#IF NVL(v_tax_amt,0) < c1rec.trt_min_amt THEN
							#	v_tax_amt := c1rec.trt_min_amt;
							#END IF;
						END IF;
					  END LOOP;
					  CLOSE cursor_steprange_tax;
				end;

				IF c_txr_div_factr > 1 THEN
					set v_tax_amt = v_tax_amt + ROUND((v_amt_to_tax - v_range_amnt) * (c_txr_rate / c_txr_div_factr),4);
					set v_rate_type 	= c_rate_type;
				ELSE
					set v_tax_amt 		= v_tax_amt + (c_txr_rate );
					set v_tax_rate 		= NULL;
					set v_rate_type 	= c_rate_type;
				END IF;
						
					/*
					set v_error_no = 1;
					select concat('Calc_tax v_range_amount=',v_range_amnt, ' v_tax_amt=', v_tax_amt, 
							' v_amt_to_tax=',v_amt_to_tax,' c_txr_rate=',c_txr_rate,' c_txr_div_factr=',c_txr_div_factr,
							' lastrange=',ROUND((v_amt_to_tax - v_range_amnt) * (c_txr_rate / c_txr_div_factr))) into v_error;
					call raise_error();*/
			  END LOOP;
			  CLOSE cursor_abs_steprange_tax;
		end;
	END IF;
	if v_tax_amt is not null then
		set v_tax_amt = round(v_tax_amt);
	end if;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure cursor_loop_example
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor_loop_example`()
BEGIN
  DECLARE c_emp_code, v_cnt INT;
  DECLARE c_emp_surname VARCHAR(150);
  declare done boolean;
  DECLARE cursor_i CURSOR FOR SELECT emp_code,emp_surname FROM shr_employees;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

set v_cnt = 0;  
OPEN cursor_i;
  read_loop: LOOP
    FETCH cursor_i INTO c_emp_code,c_emp_surname;
	set v_cnt = v_cnt + 1;
	if v_cnt = 20 then
		call aih();
	end if;
    IF done THEN
      LEAVE read_loop;
    END IF;
    #INSERT INTO table_B(ID, VAL) VALUES(cursor_ID, cursor_VAL);
  END LOOP;
  CLOSE cursor_i;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_all_bank_branches
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_all_bank_branches`(v_bnk_code int)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Unable to delete bank branch records';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Bank Branch already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
DELETE FROM `serenehrdb`.`shr_bank_branches`
WHERE `bbr_bnk_code` = v_bnk_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_all_bank_details
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_all_bank_details`()
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Unable to delete bank branch records';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Bank Branch already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
DELETE FROM `serenehrdb`.`shr_bank_branches`
WHERE `bbr_bnk_code` != 0;

DELETE FROM `serenehrdb`.`shr_banks`
WHERE `bnk_code` != 0;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_all_tax_rates
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_all_tax_rates`(v_tx_code int)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Unable to delete tax rate record';
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

set v_error_no = 1;
DELETE FROM `serenehrdb`.`shr_tax_rates` WHERE `txr_tx_code` = v_tx_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_bank_branches
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_bank_branches`(v_bbr_code int)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Unable to delete bank branch record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Bank already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
DELETE FROM `serenehrdb`.`shr_bank_branches`
WHERE `bbr_code` = v_bbr_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_banks
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_banks`(v_bnk_code int)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Unable to delete bank record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Bank already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
DELETE FROM `serenehrdb`.`shr_banks`
WHERE `bnk_code` = v_bnk_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_emp_loan
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_emp_loan`(v_el_code int)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_authorised varchar(5);
declare v_error TEXT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text=v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set v_error = ' ';

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to find loan record...') into v_error;
select el_authorised into v_authorised FROM `serenehrdb`.`shr_emp_loans`
WHERE `el_code` = v_el_code;

if v_authorised != 'NO' then	
	set v_error_no = 1;
	set v_error = ' ';
	select concat(v_error,'Deleting authorized transactions is not allowed...Loan Id=', v_el_code,
			' Authorised=', v_authorised) into v_error;
	call raise_error();
end if;

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to delete loan record...Loan Id=', v_el_code) into v_error;
DELETE FROM `serenehrdb`.`shr_emp_loans`
WHERE `el_code` = v_el_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_emp_pay_elements
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_emp_pay_elements`(v_epe_code int)
BEGIN

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error text;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text= v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
select 'Unable to delete empoyee pay element record' into v_error;
DELETE FROM `serenehrdb`.`shr_emp_pay_elements`
WHERE `epe_code` = v_epe_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_loan_intr_rates
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_loan_intr_rates`(v_lir_code int)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Unable to delete loan interest rate record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Employee already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
DELETE FROM `serenehrdb`.`shr_loan_intr_rates`
WHERE `lir_code` = v_lir_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_loan_type
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_loan_type`(v_lt_code int)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Unable to delete loan type record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Employee already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
DELETE FROM `serenehrdb`.`shr_loan_types`
WHERE `lt_code` = v_lt_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_payelements
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_payelements`(v_pel_code int)
BEGIN
declare v_sht_desc varchar(100);
declare v_desc varchar(1000);

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error varchar(2000);

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text=v_error; 
		else
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
select concat('Empoyee pay element record not found. pel_code=',v_pel_code) into v_error;
select pel_sht_desc,pel_desc into v_sht_desc, v_desc FROM `serenehrdb`.`shr_pay_elements`
WHERE `pel_code` = v_pel_code;

if v_sht_desc in ('BP','NSSF','NHIF','LASC','PAYE','FBFT','LIR','ELEC','WATER','FURNTURE',
				'WATER-AGRIC','	ELEC-AGRIC','	PENSION','PRELIEF','INRELIEF','MEDICAL',
				'NORMALOT','HOLIDAYOT','ABSENCE') then

	select concat('Pay Element (', v_desc, ') is a System defined pay element and therefore cannot be deleted at this level. ') into v_error;
	call raise_error();
end if;
set v_error_no = 1;
select 'Unable to delete employee pay element...' into v_error;
delete from `serenehrdb`.`shr_emp_pay_elements`
where epe_pel_code = v_pel_code;

set v_error_no = 1;
select 'Unable to delete pay element...' into v_error;
DELETE FROM `serenehrdb`.`shr_pay_elements`
WHERE `pel_code` = v_pel_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_payroll
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_payroll`(v_pr_code int)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Unable to delete payroll record';
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

set v_error_no = 1;
DELETE FROM `serenehrdb`.`shr_payrolls`
WHERE `pr_code` = v_pr_code;
COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_proll_pelements
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_proll_pelements`(v_pp_code int)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Unable to delete pay element record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Employee already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
DELETE FROM `serenehrdb`.`shr_proll_pelements`
WHERE `pp_code` = v_pp_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_tax
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_tax`(v_tx_code int)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Unable to delete tax record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Tax already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
DELETE FROM `serenehrdb`.`shr_taxes`
WHERE `tx_code` = v_tx_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_tax_rates
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_tax_rates`(v_txr_code int)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Unable to delete tax rate record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Employee already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
DELETE FROM `serenehrdb`.`shr_tax_rates` WHERE `txr_code` = v_txr_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_user
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user`(v_usr_code bigint)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no,v_cnt int;
declare v_authorised varchar(5);
declare v_error TEXT;
declare v_name varchar(45);

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text=v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set v_error = ' ';

select count(1) into v_cnt FROM `serenehrdb`.`shr_users`
WHERE `usr_code` = v_usr_code;

if v_cnt > 0 then
select upper(usr_name) into v_name FROM `serenehrdb`.`shr_users`
WHERE `usr_code` = v_usr_code;
	if v_name = 'ADMIN' then
		set v_error_no = 1;
		set v_error = ' ';
		select concat(v_error,'You are not allowed to delete an Administrator...') into v_error;
		call raise_error();
	end if;
end if;

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to delete record...') into v_error;
DELETE FROM `serenehrdb`.`shr_users`
WHERE `usr_code` = v_usr_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_user_privillages
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user_privillages`(v_up_code bigint)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_authorised varchar(5);
declare v_error TEXT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text=v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set v_error = ' ';

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to delete loan record...') into v_error;
DELETE FROM `serenehrdb`.`shr_user_privillages`
WHERE `up_code` = v_up_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_user_role_privlg
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user_role_privlg`(v_urp_code bigint)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_authorised varchar(5);
declare v_error TEXT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text=v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set v_error = ' ';

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to delete record...') into v_error;
DELETE FROM `serenehrdb`.`shr_user_role_privlg`
WHERE `urp_code` = v_urp_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_user_roles
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user_roles`(v_ur_code bigint)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_authorised varchar(5);
declare v_error TEXT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text=v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set v_error = ' ';

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to delete record...') into v_error;
DELETE FROM `serenehrdb`.`shr_user_roles`
WHERE `ur_code` = v_ur_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_user_roles_granted
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user_roles_granted`(v_usg_code bigint)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_authorised varchar(5);
declare v_error TEXT;
declare v_name varchar(45);

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text=v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set v_error = ' ';

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to delete record...') into v_error;
DELETE FROM `serenehrdb`.`shr_user_roles_granted`
WHERE `usg_code` = v_usg_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure employee_delete
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_delete`(v_emp_code int)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

SET autocommit=0;
START TRANSACTION;

DELETE FROM `serenehrdb`.`shr_employees`
WHERE `emp_code` = v_emp_code;

commit;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure employee_update
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_update`(v_emp_code int,
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_bank_branch_list
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_bank_branch_list`(v_bnk_code int)
begin
	select 0 bbr_code, 'null' bbr_sht_desc, '' bbr_name
	union all
	SELECT `bbr_code`,`bbr_sht_desc`, `bbr_name`
	FROM `serenehrdb`.`shr_bank_branches` bbr
	left join `serenehrdb`.`shr_banks` bnk on (bnk.bnk_code = bbr.bbr_bnk_code)
	where bbr_bnk_code = v_bnk_code
	order by bbr_name
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_bank_branches
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_bank_branches`(v_bnk_code int)
begin
SELECT `bbr_code`,`bbr_sht_desc`, `bbr_name`, `bbr_postal_address`,
    `bbr_physical_address`,`bbr_tel_no1`,`bbr_tel_no2`,`bbr_bnk_code`
FROM `serenehrdb`.`shr_bank_branches`
where bbr_bnk_code = v_bnk_code 
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_bank_list
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_bank_list`()
begin
select 0 bnk_code, 'null' bnk_sht_desc, null bnk_name
union all
SELECT `bnk_code`,`bnk_sht_desc`,`bnk_name`
FROM `serenehrdb`.`shr_banks` order by bnk_name asc
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_banks
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_banks`(v_sht_desc  varchar(15),
														v_bnk_name varchar(300))
begin
SELECT `bnk_code`,`bnk_sht_desc`,`bnk_name`,`bnk_postal_address`,
    `bnk_physical_address`, `bnk_kba_code`
FROM `serenehrdb`.`shr_banks`
where bnk_name like CONCAT('%',CONCAT(v_bnk_name,'%')) 
and bnk_sht_desc like CONCAT('%',CONCAT(v_sht_desc,'%')) 
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_curr_user_priv
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_curr_user_priv`(v_user varchar(100))
begin
SELECT ur_name,usr_name,up_name,
`urp_min_amt`, `urp_max_amt`
FROM `serenehrdb`.`shr_users` usr
left join `serenehrdb`.`shr_user_roles_granted` urg on (urg.usg_usr_code = usr.usr_code)
left join `serenehrdb`.`shr_user_roles` ur on (ur.ur_code = urg.usg_ur_code)
left join `serenehrdb`.`shr_user_role_privlg` urp on (urp.urp_ur_code = ur.ur_code)
left join `serenehrdb`.`shr_user_privillages` up on (up.up_code = urp.urp_up_code)
where upper(usr_name) = upper(v_user);

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_emp_loans
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emp_loans`(v_emp_code int)
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

-- -----------------------------------------------------
-- procedure get_emp_pay_elements
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
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

-- -----------------------------------------------------
-- procedure get_emp_prd_pay_elements
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emp_prd_pay_elements`(v_emp_code int,
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

-- -----------------------------------------------------
-- procedure get_employee_photo
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_employee_photo`(v_emp_code bigint)
begin
SELECT  `emp_photo`
FROM `serenehrdb`.`shr_employees`
where `emp_code` = v_emp_code
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_employees
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_employees`(v_sht_desc  varchar(45),
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
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_loan_intr_rates
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_loan_intr_rates`(v_lir_code int)
begin
SELECT `lir_code`,`lir_rate`,`lir_div_factr`,
DATE_FORMAT(`lir_wef`,'%d/%m/%Y') as lir_wef,
DATE_FORMAT(`lir_wet`,'%d/%m/%Y') as lir_wet, `lir_lt_code`
FROM `serenehrdb`.`shr_loan_intr_rates`
where `lir_code` = v_lir_code
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_loan_types
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_loan_types`()
begin
SELECT `lt_code`,`lt_sht_desc`,`lt_desc`,`lt_min_repay_prd`,
    `lt_max_repay_prd`,`lt_min_amt`,`lt_max_amt`,`lt_wef`,`lt_wet`
FROM `serenehrdb`.`shr_loan_types`
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_loan_types_ddl
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_loan_types_ddl`()
begin
select null lt_code,'null' lt_sht_desc, null lt_desc
union all
SELECT `lt_code`,`lt_sht_desc`,`lt_desc`
FROM `serenehrdb`.`shr_loan_types`
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_orgarnizations
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_orgarnizations`()
begin
SELECT a.`org_code`,
    a.`org_sht_desc`,
    a.`org_desc`,
    a.`org_postal_address`,
    a.`org_physical_address`,
    a.`org_type`,
    a.`org_parent_org_code`,
    a.`org_parent_org_sht_desc`,
    b.`org_desc` as parent_organization,
    a.`org_wef`,
    a.`org_wet`,
    a.`org_level`
FROM `serenehrdb`.`shr_organizations` a
LEFT JOIN `serenehrdb`.`shr_organizations` b
ON a.`org_parent_org_code` = b.`org_code`;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_payelements
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payelements`()
begin
SELECT `pel_code`,`pel_sht_desc`,`pel_desc`,`pel_taxable`,
    `pel_deduction`,`pel_depends_on`,`pel_type`, pel_applied_to, 
	round(`pel_nontax_allowed_amt`,2)pel_nontax_allowed_amt, 
	round(`pel_prescribed_amt`,2)pel_prescribed_amt,
	case when pel_selected = 1 then 1 else 0 end as pel_selected,
	pel_order
FROM `serenehrdb`.`shr_pay_elements`
order by pel_order
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_payroll_employees
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_employees`(v_pr_code int)
begin
SELECT `emp_code`, `emp_sht_desc`, `emp_surname`, `emp_other_names`,
	`emp_contract_date`, `emp_join_date`, `emp_id_no`,
    `emp_nssf_no`, `emp_pin_no`, `emp_nhif_no`, `emp_lasc_no`
FROM `serenehrdb`.`shr_employees`
where emp_pr_code = v_pr_code
and (emp_final_date is null or emp_final_date > Now())
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_payroll_transactions
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_transactions`(v_pr_code int,
											v_status varchar(50))
begin
SELECT `tr_code`, `tr_type`, `tr_date`, `tr_done_by`,`tr_pr_month`, `tr_pr_year`
FROM `serenehrdb`.`shr_transactions` tr 
where tr_pr_code = v_pr_code and `tr_authorised` = v_status
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_payrolls
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payrolls`()
begin
SELECT `pr_code`,`pr_sht_desc`,`pr_desc`,`pr_org_code`,
    `org_desc`,`pr_wef`, `pr_wet`,
	`pr_day1_hrs`, `pr_day2_hrs`, `pr_day3_hrs`, `pr_day4_hrs`, 
	`pr_day5_hrs`, `pr_day6_hrs`, `pr_day7_hrs`
FROM `serenehrdb`.`shr_payrolls` `p`  left join  `serenehrdb`.`shr_organizations` `o`
on (`p`.`pr_org_code` = `o`.`org_code`)
where `pr_org_code` = `org_code`
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_payrolls_ddl
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payrolls_ddl`()
begin
select null pr_code,'null' pr_sht_desc,null pr_desc,null pr_org_code,
	null org_desc,null pr_wef,null pr_wet
union all
SELECT `pr_code`,`pr_sht_desc`,`pr_desc`,`pr_org_code`,
    `org_desc`,`pr_wef`, `pr_wet`
FROM `serenehrdb`.`shr_payrolls` `p`  left join  `serenehrdb`.`shr_organizations` `o`
on (`p`.`pr_org_code` = `o`.`org_code`)
where `pr_org_code` = `org_code`
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_proll_pelements
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_proll_pelements`(v_pel_code int)
begin
SELECT `pp_code`,`pr_desc`,`pel_desc`
FROM `serenehrdb`.`shr_proll_pelements` `pp` 
left join `serenehrdb`.`shr_pay_elements` `pel` on (pp.pp_pel_code = pel.pel_code)
left join `serenehrdb`.`shr_payrolls` `pr` on (pp.pp_pr_code = pr.pr_code)
where `pp_pel_code` = v_pel_code
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_tax_rates
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_tax_rates`(v_tx_code  int)
begin
SELECT `txr_code`,`txr_desc`,`txr_rate_type`,`txr_rate`, `txr_div_factr`,
    DATE_FORMAT(`txr_wef`,'%d/%m/%Y') as txr_wef, 
	DATE_FORMAT(`txr_wet`,'%d/%m/%Y') as txr_wet,  `txr_tx_code`,`txr_range_from`,`txr_range_to`,
	`txr_frequency`
FROM `serenehrdb`.`shr_tax_rates` `tr`
left join `serenehrdb`.`shr_taxes` `t` on (tr.txr_tx_code = t.tx_code)
where `txr_tx_code` = v_tx_code
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_taxes
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_taxes`()
begin
SELECT `tx_code`,`tx_sht_desc`,`tx_desc`,`tx_wef`,`tx_wet`
FROM `serenehrdb`.`shr_taxes`
;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_user_privillages
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_privillages`()
begin
SELECT `up_code`,`up_name`,`up_desc`, 
	round(`up_min_amt`)up_min_amt,
	round(`up_max_amt`)up_max_amt,
	up_type
FROM `serenehrdb`.`shr_user_privillages`;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_user_privillages_list
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_privillages_list`(v_ur_code bigint)
begin
SELECT `up_code`,`up_name`,`up_desc`, 
	round(`up_min_amt`)up_min_amt,
	round(`up_max_amt`)up_max_amt,
	up_type
FROM `serenehrdb`.`shr_user_privillages`
where up_code not in (select urp_up_code from `shr_user_role_privlg`
				where urp_ur_code = v_ur_code);

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_user_role_privlg
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_role_privlg`(v_ur_code bigint)
begin
SELECT up_code,up_name,up_type,urp_min_amt, urp_max_amt,urp_code,ur_code,
	case when urp_code is null then 0 else 1 end as checked
FROM `serenehrdb`.`shr_user_privillages` up
left join `serenehrdb`.`shr_user_role_privlg` urp on (urp.urp_up_code = up.up_code)
left join `serenehrdb`.`shr_user_roles` ur on (ur.ur_code = urp.urp_ur_code)
where urp_ur_code = v_ur_code
;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_user_roles
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_roles`()
begin
SELECT `ur_code`,`ur_name`,`ur_desc`
FROM `serenehrdb`.`shr_user_roles`;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_user_roles_granted
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_roles_granted`(v_usr_code bigint)
begin
SELECT `ur_code`,`ur_name`,`ur_desc`,`usg_code`
FROM `serenehrdb`.`shr_user_roles_granted` usg
left join `serenehrdb`.`shr_user_roles` ur on (ur.ur_code=usg_ur_code)
where usg_usr_code = v_usr_code

;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_user_roles_list
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_roles_list`(v_usr_code bigint)
begin
SELECT `ur_code`,`ur_name`,`ur_desc`
FROM `serenehrdb`.`shr_user_roles`
where ur_code not in (select usg_ur_code from `shr_user_roles_granted`
				where usg_usr_code = v_usr_code);
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_users
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_users`()
begin
SELECT `usr_code`, `usr_name`, `usr_full_name`,`usr_emp_code`,
`usr_pwd_reset`, `usr_last_login`, `usr_login_atempts`
FROM `serenehrdb`.`shr_users`

;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure jobtitle_delete
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `jobtitle_delete`(v_jt_code int)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

SET autocommit=0;
START TRANSACTION;

DELETE FROM `serenehrdb`.`shr_job_titles`
WHERE `jt_code` = v_jt_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure jobtitles_update
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `jobtitles_update`(in v_jt_code int,
								v_sht_desc  varchar(45),
								v_desc  varchar(1000),
								out v_jtcode int
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

SET autocommit=0;
START TRANSACTION;
if v_jt_code is null or v_jt_code = 0 then
	INSERT INTO `serenehrdb`.`shr_job_titles`
	(`jt_sht_code`,`jt_desc`)
	VALUES
	(v_sht_desc,v_desc);

	select max(jt_code) into v_jtcode from  `serenehrdb`.`shr_job_titles`;
else	
	UPDATE `serenehrdb`.`shr_job_titles`
	SET `jt_sht_code` = v_sht_desc,
		`jt_desc` = v_desc
	WHERE `jt_code` = v_jt_code; 
	set v_jtcode = v_jt_code;
end if;
COMMIT;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure org_delete
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `org_delete`(v_org_code int)
BEGIN
DELETE FROM `serenehrdb`.`shr_organizations`
WHERE `org_code` = v_org_code;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure populate_pe_fr_proll
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_pe_fr_proll`(v_pel_code int,
								v_pr_code int,
								v_amt	decimal(25,5),
								v_created_by  varchar(100)
								)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error text;

	DECLARE c_emp_code, v_cnt INT;
	DECLARE c_emp_surname VARCHAR(150);
	declare done boolean;

	DECLARE cursor_i CURSOR FOR SELECT emp_code,emp_surname FROM shr_employees
					where emp_pr_code = v_pr_code;
	
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 
			sqlstate_code = RETURNED_SQLSTATE, 
			mysql_error= MYSQL_ERRNO, 
			message_text = MESSAGE_TEXT;

		if sqlstate_code <> '00000' then
			if v_error_no = 1 then #duplicate accessible
				signal sqlstate '45000'
					set message_text='Error creating employee pay element record';
			elseif v_error_no = 2 then #duplicate accessible
				signal sqlstate '45000'
					set message_text= 'Error updating employee pay element record';
			else
				#signal sqlstate '45000' set message_text= 'Unable to save records...';
				resignal;
			end if;			
		end if;
	END;


SET autocommit=0;
START TRANSACTION;

	set v_cnt = 0;  
	OPEN cursor_i;
	  read_loop: LOOP
		FETCH cursor_i INTO c_emp_code,c_emp_surname;
		IF done THEN
		  LEAVE read_loop;
		END IF;
		
		select count(1) into v_cnt from `serenehrdb`.`shr_emp_pay_elements`
		where epe_emp_code = c_emp_code and epe_pel_code = v_pel_code;
		if v_cnt = 0 then
			set v_error_no = 10;
			INSERT INTO `serenehrdb`.`shr_emp_pay_elements`
			(`epe_emp_code`,`epe_pel_code`,`epe_amt`,`epe_date`,`epe_created_by`,`epe_status`)
			VALUES
			(c_emp_code,v_pel_code,v_amt,Now(),v_created_by,'ACTIVE');
		end if;

	  END LOOP;
	  CLOSE cursor_i;

COMMIT;
#END TRANSACTION
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure populate_pe_to_employees
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_pe_to_employees`(v_created_by  varchar(100))
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error text;

	DECLARE c_emp_code, v_cnt INT;
	DECLARE c_emp_surname VARCHAR(150);
	declare done boolean;
	declare v_pel_code,v_pr_code bigint;


	DECLARE cursor_pr CURSOR FOR SELECT distinct pp_pel_code,pp_pr_code
					FROM `serenehrdb`.`shr_proll_pelements` `pp` 
					order by pp_pr_code;

	DECLARE cursor_i CURSOR FOR SELECT emp_code,emp_surname FROM shr_employees
					where emp_pr_code = v_pr_code;
	
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 
			sqlstate_code = RETURNED_SQLSTATE, 
			mysql_error= MYSQL_ERRNO, 
			message_text = MESSAGE_TEXT;

		if sqlstate_code <> '00000' then
			if v_error_no = 1 then
				signal sqlstate '45000'
					set message_text=v_error;				
			elseif v_error_no = 1 then #duplicate accessible
				signal sqlstate '45000'
					set message_text='Error creating employee pay element record';
			elseif v_error_no = 2 then #duplicate accessible
				signal sqlstate '45000'
					set message_text= 'Error updating employee pay element record';
			else
				#signal sqlstate '45000' set message_text= 'Unable to save records...';
				resignal;
			end if;			
		end if;
	END;


SET autocommit=0;
START TRANSACTION;

set v_error_no = 1;
set v_error=' ';

	set v_cnt = 0;  
	set done = false;
	OPEN cursor_pr;
	  read_pr_loop: LOOP
		FETCH cursor_pr INTO v_pel_code,v_pr_code;
		IF done THEN
			set done = false;
			LEAVE read_pr_loop;
		END IF;
				
			set v_cnt = 0;  
			OPEN cursor_i;
			  read_loop: LOOP
				FETCH cursor_i INTO c_emp_code,c_emp_surname;
				IF done THEN
				  set done = false;
				  LEAVE read_loop;
				END IF;

				select count(1) into v_cnt from `serenehrdb`.`shr_emp_pay_elements`
				where epe_emp_code = c_emp_code and epe_pel_code = v_pel_code;
				if v_cnt = 0 then
					set v_error_no = 10;
					INSERT INTO `serenehrdb`.`shr_emp_pay_elements`
					(`epe_emp_code`,`epe_pel_code`,`epe_amt`,`epe_date`,`epe_created_by`,`epe_status`)
					VALUES
					(c_emp_code,v_pel_code,null,Now(),v_created_by,'ACTIVE');
				end if;

			  END LOOP;
			  CLOSE cursor_i;


		  END LOOP;
		  CLOSE cursor_pr;

COMMIT;
#END TRANSACTION
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure populate_prd_pay_elements
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_prd_pay_elements`(v_pr_code int,
								v_created_by  varchar(100),
								v_month	int,
								v_year	int
								)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error text;

	DECLARE v_tr_code INT;
	DECLARE c_emp_code, v_cnt, v_cnt2 INT;
	DECLARE c_epe_code,c_epe_amt,c_pel_code INT;
	DECLARE c_emp_surname VARCHAR(150);
	declare done boolean;

	DECLARE cursor_e CURSOR FOR SELECT emp_code,emp_surname FROM shr_employees
					where emp_pr_code = v_pr_code;
	
	DECLARE cursor_pe CURSOR FOR SELECT epe_code,epe_amt,epe_pel_code
					FROM `shr_emp_pay_elements`
					where epe_emp_code = c_emp_code and epe_status = 'ACTIVE';

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 
			sqlstate_code = RETURNED_SQLSTATE, 
			mysql_error= MYSQL_ERRNO, 
			message_text = MESSAGE_TEXT;

		if sqlstate_code <> '00000' then
			if v_error_no = 1 then #duplicate accessible
				signal sqlstate '45000'
					set message_text='Select a payroll to proceed';
			elseif v_error_no = 2 then #duplicate accessible
				signal sqlstate '45000'
					set message_text= 'Error updating bank record';
			else
				#signal sqlstate '45000' set message_text= 'Unable to save records...';
				resignal;
			end if;			
		end if;
	END;


SET autocommit=0;
START TRANSACTION;

	if (v_pr_code = -1) then
		set v_error_no = 1;
		call raise_error();
	end if;

	select count(1) into v_cnt2 from `shr_transactions` tr 
	where `tr_type` = 'PAYROLL'
	and `tr_authorised` = 'NO'
	and tr_pr_code = v_pr_code;

	if v_cnt2 > 0 then
		select tr_code into v_tr_code from `shr_transactions` tr 
		where `tr_type` = 'PAYROLL'
		and `tr_authorised` = 'NO'
		and tr_pr_code = v_pr_code;
	else
		INSERT INTO `serenehrdb`.`shr_transactions`
		(`tr_type`,`tr_date`,`tr_done_by`,`tr_authorised`,
		`tr_authorised_date`,`tr_authorised_by`,`tr_pr_code`)
		VALUES
		('PAYROLL',Now(),v_created_by,'NO',
		null,null,v_pr_code);
		select max(tr_code) into v_tr_code  from shr_transactions;
	end if;

	if not (v_month is null or v_month = 0) or (v_year is null or v_year = 0) then
		update `serenehrdb`.`shr_transactions`
		set `tr_pr_month` = v_month, `tr_pr_year` = v_year
		where tr_code = v_tr_code;
	end if;

	set v_cnt = 0;  
	OPEN cursor_e;
	  read_loop: LOOP
		FETCH cursor_e INTO c_emp_code,c_emp_surname;
		IF done THEN
		  LEAVE read_loop;
		END IF;
		set v_cnt=0;
		OPEN cursor_pe;
		  read_pe_loop: LOOP
			FETCH cursor_pe INTO c_epe_code,c_epe_amt,c_pel_code;
			IF done THEN
			  LEAVE read_pe_loop;
			END IF;
			if c_epe_amt is  null then	
				set c_epe_amt = 0;
			end if;
			
			select count(1) into v_cnt from `serenehrdb`.`shr_prd_pay_elements`
			where ppe_emp_code = c_emp_code and ppe_pel_code = c_pel_code;
			if v_cnt = 0 then
				set v_error_no = 100;
				INSERT INTO `serenehrdb`.`shr_prd_pay_elements`
				(`ppe_emp_code`,`ppe_pel_code`,`ppe_amt`,`ppe_date`,
				`ppe_done_by`,`ppe_authorized`,`ppe_authorized_by`,`ppe_authorized_date`,
				`ppe_tr_code`)
				VALUES
				(c_emp_code,c_pel_code,c_epe_amt,Now(),
				v_created_by,'NO',null,null,
				v_tr_code);
			end if;

		  END LOOP;
		  CLOSE cursor_pe;
		  set done = false;
	  END LOOP;
	  CLOSE cursor_e;

COMMIT;
#END TRANSACTION
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure post_amt_to_employees
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `post_amt_to_employees`(v_amt	decimal(25,2),
										v_pel_code	bigint,
										v_pr_code	bigint,
										v_created_by  varchar(100))
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error text;

	DECLARE c_emp_code, v_cnt INT;
	DECLARE c_emp_surname VARCHAR(150);
	declare done boolean;

	DECLARE cursor_i CURSOR FOR SELECT emp_code,emp_surname FROM shr_employees
					where emp_pr_code = v_pr_code;
	
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 
			sqlstate_code = RETURNED_SQLSTATE, 
			mysql_error= MYSQL_ERRNO, 
			message_text = MESSAGE_TEXT;

		if sqlstate_code <> '00000' then
			if v_error_no = 1 then
				signal sqlstate '45000'
					set message_text=v_error;				
			elseif v_error_no = 1 then #duplicate accessible
				signal sqlstate '45000'
					set message_text='Error creating employee pay element record';
			elseif v_error_no = 2 then #duplicate accessible
				signal sqlstate '45000'
					set message_text= 'Error updating employee pay element record';
			else
				#signal sqlstate '45000' set message_text= 'Unable to save records...';
				resignal;
			end if;			
		end if;
	END;


SET autocommit=0;
START TRANSACTION;

	set v_error_no = 1;
	set v_error=' ';

	if v_amt is null then
		set v_error_no = 1;
		select 'Capture an amount to post to employees.' into v_error;
		call raise_error();
	end if;

	set v_cnt = 0;  
	OPEN cursor_i;
	  read_loop: LOOP
		FETCH cursor_i INTO c_emp_code,c_emp_surname;
		IF done THEN
		  set done = false;
		  LEAVE read_loop;
		END IF;

		select count(1) into v_cnt from `serenehrdb`.`shr_emp_pay_elements`
		where epe_emp_code = c_emp_code and epe_pel_code = v_pel_code;
		if v_cnt = 0 then
			set v_error_no = 10;
			INSERT INTO `serenehrdb`.`shr_emp_pay_elements`
			(`epe_emp_code`,`epe_pel_code`,`epe_amt`,`epe_date`,`epe_created_by`,`epe_status`)
			VALUES
			(c_emp_code,v_pel_code,v_amt,Now(),v_created_by,'ACTIVE');
		else	
			update  `serenehrdb`.`shr_emp_pay_elements`
			set `epe_amt` = v_amt
			where epe_emp_code = c_emp_code and epe_pel_code = v_pel_code;
		end if;

	  END LOOP;
	  CLOSE cursor_i;

COMMIT;
#END TRANSACTION
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure process_emp_loan
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `process_emp_loan`(v_el_code int,
									v_user varchar(100))
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, v_tot_instalments int;
declare v_authorised varchar(5);
declare v_error TEXT;

declare v_eff_date datetime;
declare v_final_repay_date date;
declare v_loan_applied_amt,v_service_charge,v_tot_tax_amt,v_instalment_amt decimal(25,5);
declare v_issued_amt,v_intr_rate,v_intr_div_factr decimal(25,5);
declare v_lt_code bigint;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text=v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set v_error = ' ';

if v_user is null or v_user = '' then	
	set v_error_no = 1;
	set v_error = ' ';
	select concat(v_error,'Log in first to proceed...') into v_error;
	call raise_error();
end if;

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to find loan record...') into v_error;
SELECT el_eff_date,el_lt_code,el_tot_instalments,el_instalment_amt,
	case when el_authorised is null then 'NO' else el_authorised end as el_authorised,
	case when el_loan_applied_amt is null then 0 else el_loan_applied_amt end as el_loan_applied_amt,
	case when el_service_charge is null then 0 else el_service_charge end as el_service_charge,
	case when el_tot_tax_amt is null then 0 else el_tot_tax_amt end as el_tot_tax_amt
into v_eff_date,v_lt_code,v_tot_instalments,v_instalment_amt,
	v_authorised,
	v_loan_applied_amt,v_service_charge,v_tot_tax_amt
FROM `serenehrdb`.`shr_emp_loans` el
left join `serenehrdb`.`shr_loan_types`  lt on (el.el_lt_code=lt.lt_code)
where el_code = v_el_code;

if v_authorised != 'NO' then	
	set v_error_no = 1;
	set v_error = ' ';
	select concat(v_error,'Processing authorized transactions is not allowed...Loan Id=', v_el_code,
			' Authorised=', v_authorised) into v_error;
	call raise_error();
end if;

set v_error_no = 1;
set v_error = ' ';
select concat(v_error,'Unable to fetch loan interest rates..Loan Id=', v_el_code) into v_error;
select `lir_rate`, `lir_div_factr` into v_intr_rate, v_intr_div_factr
from `shr_loan_intr_rates`
where `lir_lt_code` = v_lt_code
and v_eff_date between `lir_wef` and case when `lir_wet` is null then Now() else `lir_wef` end;

set v_issued_amt = v_loan_applied_amt - v_service_charge - v_tot_tax_amt;

	if (not(v_tot_instalments is null or v_tot_instalments = 0)
		and not(v_instalment_amt is null or v_instalment_amt = 0)) then
			if not(v_tot_instalments is null or v_tot_instalments = 0) then
				SELECT DATE_ADD(v_effdate,INTERVAL v_tot_instalments MONTH) into v_final_repay_date;
				if (v_instalment_amt is null or v_instalment_amt = 0) then
					select round(v_loan_applied_amt/v_tot_instalments) into v_instalment_amt;
				end if;
			elseif not(v_instalment_amt is null or v_instalment_amt = 0) then
				select round(v_loan_applied_amt/v_instalment_amt) into v_tot_instalments;
				SELECT DATE_ADD(v_effdate,INTERVAL v_tot_instalments MONTH) into v_final_repay_date;
			else				
				set v_error_no = 1;
				set v_error = ' ';
				select concat(v_error,'Unable to calculate loan installments...') into v_error;
				call raise_error();
			end if;
	end if; 


set v_error_no = 100;
set v_error = ' ';
select concat(v_error,'Unable to update loan record...Loan Id=', v_el_code) into v_error;
Update `serenehrdb`.`shr_emp_loans`
	set el_issued_amt = v_issued_amt,
		el_intr_rate = v_intr_rate,
		el_intr_div_factr = v_intr_div_factr,
		el_processed = 'YES',
		el_processed_by = v_user,
		el_processed_date = Now(),
		el_tot_instalments = v_tot_instalments,
		el_instalment_amt = v_instalment_amt,
		el_final_repay_date = v_final_repay_date
WHERE `el_code` = v_el_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure process_payroll
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `process_payroll`(v_tr_code  int,
									v_processed_by  varchar(100)
									)
BEGIN
declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, v_var int;
declare v_error text;

	DECLARE v_date		varchar(10);
	DECLARE v_amt_to_tax, v_nssf_amt   decimal(25,5);
	DECLARE v_tax_amt, v_prelief_amt, v_inrelief_amt, v_pens_relief_amt,
			v_ppe_ded_amt_b4_tax, v_tot_ded_amt_b4_tax, v_val_of_benfit_amt,
			v_basic_pay, v_tot_month_hrs decimal(25,5);
	DECLARE v_extra_payable_amt, v_gross_pay, v_net_pay, v_tax   decimal(25,5);

	DECLARE v_tx_code, c_element_order,c_month,c_year INT;
	DECLARE c_emp_code, v_cnt, v_cnt2 INT;
	DECLARE c_epe_code,c_epe_amt,c_pel_code, c_ppe_code BIGINT;
	DECLARE c_pel_sht_desc, c_pel_desc, c_pel_type varchar(100);
	DECLARE c_deduction, c_pel_taxable  varchar(5);
	DECLARE c_emp_surname VARCHAR(150);
	DECLARE c_nontax_allowed_amt, c_prescribed_amt, c_ot_hours,
			c_day1_hrs, c_day2_hrs, c_day3_hrs, c_day4_hrs, c_day5_hrs,
			c_day6_hrs, c_day7_hrs  decimal(25,5); 
	DECLARE v_last_day_of_month, v_day, v_week_day int;
	DECLARE v_rung_date date;
	
	declare done boolean;

	DECLARE cursor_e CURSOR FOR SELECT emp_code,emp_surname,tr_pr_month,tr_pr_year,
					case when pr_day1_hrs is null then 0 else pr_day1_hrs end  as pr_day1_hrs,
					case when pr_day2_hrs is null then 0 else pr_day2_hrs end  as pr_day2_hrs,
					case when pr_day3_hrs is null then 0 else pr_day3_hrs end  as pr_day3_hrs,
					case when pr_day4_hrs is null then 0 else pr_day4_hrs end  as pr_day4_hrs,
					case when pr_day5_hrs is null then 0 else pr_day5_hrs end  as pr_day5_hrs,
					case when pr_day6_hrs is null then 0 else pr_day6_hrs end  as pr_day6_hrs,
					case when pr_day7_hrs is null then 0 else pr_day7_hrs end  as pr_day7_hrs
					FROM shr_employees,`shr_transactions`, shr_payrolls
					where tr_pr_code = emp_pr_code and tr_pr_code = pr_code
					and tr_code = v_tr_code;

	DECLARE cursor_pe CURSOR FOR SELECT epe_code,
					case when epe_amt is null then 0 else epe_amt end as epe_amt,
					epe_pel_code, ppe_code,pel_type,
					pel_sht_desc,pel_desc,
					case pel_sht_desc
						when 'NSSF' then 1
						when 'BP' then 2
						when 'NHIF' then 3
						when 'PRELIEF' then 4
						when 'PENSION' then 5
						when 'LIFEINSURANCE' then 6
						when 'MEDICAL' then 7
						when 'GP' then 41
						when 'TP' then 49
						when 'PAYE' then 50
						when 'TAX' then 51
						when 'NP' then 52
						else 40
						end as element_order, pel_deduction, pel_taxable,
					case when pel_nontax_allowed_amt is null then 0 else pel_nontax_allowed_amt end as pel_nontax_allowed_amt,
					case when pel_prescribed_amt is null then 0 else pel_prescribed_amt end as pel_prescribed_amt,
					case when epe_ot_hours is null then 0 else epe_ot_hours end as epe_ot_hours
					FROM `shr_emp_pay_elements` epe
					left join `shr_prd_pay_elements` ppe 
							on (ppe.ppe_pel_code=epe.epe_pel_code and ppe.ppe_emp_code=epe.epe_emp_code)
					left join `shr_pay_elements` pel on (ppe.ppe_pel_code=pel.pel_code)
					where epe_emp_code = c_emp_code and epe_status = 'ACTIVE'
					and ppe_tr_code = v_tr_code
					#and pel_sht_desc in ('NSSF','BP','NHIF','PAYE','PRELIEF','PENSION','LIFEINSURANCE','MEDICAL')
					order by element_order;

	#Delete attached inactive pay elements
	DECLARE cursor_pe_del CURSOR FOR SELECT epe_code,epe_amt,epe_pel_code
					FROM `shr_emp_pay_elements` epe
					left join `shr_prd_pay_elements` ppe on (ppe.ppe_pel_code=epe.epe_pel_code)
					where epe_emp_code = c_emp_code and epe_status = 'INACTIVE'
					and ppe_tr_code = v_tr_code;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 
			sqlstate_code = RETURNED_SQLSTATE, 
			mysql_error = MYSQL_ERRNO, 
			message_text = MESSAGE_TEXT;

		if sqlstate_code <> '00000' then
			if v_error_no = 1 then 
				signal sqlstate '45000'
					set message_text= v_error;  #'Debuging';
			elseif v_error_no = 1 then 
				signal sqlstate '45000'
					set message_text= 'Select a payroll transaction to proceed';
			elseif v_error_no = 3 then
				signal sqlstate '45000'
					set message_text= 'xxxxxx';
			else
				#signal sqlstate '45000' set message_text= 'Unable to save records...';
				resignal;
			end if;			
		end if;
		close cursor_e;
		close cursor_pe;
	END;


SET autocommit=0;
START TRANSACTION;
	select 'Error...' into v_error;

	if (v_tr_code = 0 or v_tr_code is null) then
		set v_error_no = 1;
		set v_error = ' ';
		set v_error = 'Select a payroll transaction to proceed...';
		call raise_error();
	end if;

	set v_cnt = 0;  
	OPEN cursor_e;
	  read_loop: LOOP
		FETCH cursor_e INTO c_emp_code,c_emp_surname,c_month,c_year,
			c_day1_hrs, c_day2_hrs, c_day3_hrs, c_day4_hrs, c_day5_hrs, c_day6_hrs, c_day7_hrs;

		IF done THEN
		  LEAVE read_loop;
		END IF;
		
		set v_cnt=0, v_cnt2=0;
		set v_nssf_amt = 0;
		set v_prelief_amt = 0;
		set v_inrelief_amt = 0;
		set v_pens_relief_amt = 0;
		set v_ppe_ded_amt_b4_tax = 0;
		set v_tot_ded_amt_b4_tax = 0;
		set v_val_of_benfit_amt = 0;
		set v_extra_payable_amt = 0;
		set v_amt_to_tax = 0;
		set v_basic_pay = 0,v_gross_pay=0,v_net_pay=0,v_tax=0;
		set v_tot_month_hrs = 0;

		BEGIN
		#Get the total working hours for the month
		set v_day = 1;
		select Day(last_day(STR_TO_DATE(concat('01/',c_month,'/',c_year),'%d/%m/%Y'))) into v_last_day_of_month;
		month_loop: loop
			select STR_TO_DATE(concat(v_day,'/',c_month,'/',c_year),'%d/%m/%Y') into v_rung_date;
			select case when WEEKDAY(now()) = 7 then 1
					when WEEKDAY(v_rung_date) = 0 then 2
					when WEEKDAY(v_rung_date) = 1 then 3
					when WEEKDAY(v_rung_date) = 2 then 4
					when WEEKDAY(v_rung_date) = 3 then 5
					when WEEKDAY(v_rung_date) = 4 then 6
					when WEEKDAY(v_rung_date) = 5 then 7
					when WEEKDAY(v_rung_date) = 6 then 0 end as day into v_week_day;
			if v_week_day = 1 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day1_hrs;
			elseif v_week_day = 2 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day2_hrs;
			elseif v_week_day = 3 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day3_hrs;
			elseif v_week_day = 4 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day4_hrs;
			elseif v_week_day = 5 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day5_hrs;
			elseif v_week_day = 6 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day6_hrs;
			elseif v_week_day = 7 then
				set v_tot_month_hrs = v_tot_month_hrs + c_day7_hrs;
			end if;	
			
			#NEXT
			set v_day = v_day + 1;
			if v_day <= v_last_day_of_month and v_day >=1 then
				ITERATE month_loop;
			end if;
			leave month_loop;
		end loop month_loop;
		END;

		if v_day = 1 then
			set v_error_no = 1;
			select concat('Error... Month hrs=',v_tot_month_hrs,' last=',v_last_day_of_month, ' day=',v_day,' week_day=',v_week_day) into v_error;
			call raise_error();
		end if;

		SELECT count(1) into v_cnt
		FROM `shr_emp_pay_elements` epe
		left join `shr_prd_pay_elements` ppe 
				on (ppe.ppe_pel_code=epe.epe_pel_code and ppe.ppe_emp_code=epe.epe_emp_code)
		left join `shr_pay_elements` pel on (ppe.ppe_pel_code=pel.pel_code)
		where epe_emp_code = c_emp_code and epe_status = 'ACTIVE'
		and ppe_tr_code = v_tr_code
		#and pel_sht_desc in ('NSSF','BP','NHIF','PAYE','PRELIEF','PENSION','LIFEINSURANCE','MEDICAL')
		;

		OPEN cursor_pe;
		  read_pe_loop: LOOP

			FETCH cursor_pe INTO c_epe_code,c_epe_amt,c_pel_code,c_ppe_code,c_pel_type,
							     c_pel_sht_desc,c_pel_desc, c_element_order,c_deduction,c_pel_taxable,
								 c_nontax_allowed_amt,c_prescribed_amt, c_ot_hours;

			/*IF done THEN
			  LEAVE read_pe_loop;
			END IF;*/
			set v_cnt2 = v_cnt2 + 1;
			if v_cnt2 > v_cnt then
				LEAVE read_pe_loop;
			end if;
			if c_epe_amt is  null then	
				set c_epe_amt = 0;
			end if;
			
			set v_tx_code = null;
			set v_tax_amt = 0;
			if v_amt_to_tax is null then	
				set v_amt_to_tax = 0;
			end if;
/*
if c_emp_code = 34 and c_pel_sht_desc = 'ELEC' then
	set v_error_no = 1;
	
	select concat('xxx c_emp_amt=', 300) into v_error;
	call raise_error();
end if;*/
			if c_pel_sht_desc = 'NSSF' then
				set v_error_no = 1;
				select 'Unable to get NSSF setup rates and taxes.' into v_error;
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'NSSF';
				
				set v_error_no = 1;
				select 'Unable to calculate NSSF amount.' into v_error;
				call `calc_taxes`(v_tx_code,
							Now(),
							v_amt_to_tax,
							v_tax_amt
							);
				set v_error_no = 3,v_nssf_amt=v_tax_amt;
				set c_epe_amt = v_tax_amt;
				set v_ppe_ded_amt_b4_tax = v_nssf_amt;
				set v_tot_ded_amt_b4_tax = v_tot_ded_amt_b4_tax + v_nssf_amt;

			elseif c_pel_sht_desc = 'BP' then
				set v_error_no = 1;
				if v_nssf_amt is null then
					set v_nssf_amt = 0;
				end if;
				select 'Unable to set basic pay amount.' into v_error;
				set v_amt_to_tax = c_epe_amt, v_basic_pay = c_epe_amt;

			elseif c_pel_sht_desc = 'PRELIEF' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'PRELIEF';
				set v_error_no = 1;
				select concat('Unable to calculate ', c_pel_desc) into v_error;
				call `calc_taxes`(v_tx_code,
							Now(),
							v_amt_to_tax,
							v_tax_amt
							);
				set v_prelief_amt = v_tax_amt,c_epe_amt=v_tax_amt;

			elseif c_pel_sht_desc = 'PENSION' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'PENSION';

				set v_error_no = 1;
				select concat('Unable to calculate ', c_pel_desc) into v_error;
				
				select case when c_epe_amt is null then 0 else c_epe_amt end into c_epe_amt;
				if c_nontax_allowed_amt > c_epe_amt then
					set v_pens_relief_amt = c_epe_amt;
				elseif c_nontax_allowed_amt < c_epe_amt then
					set v_pens_relief_amt = c_nontax_allowed_amt;					
				end if;
				set v_ppe_ded_amt_b4_tax = v_pens_relief_amt;
				set v_tot_ded_amt_b4_tax = v_tot_ded_amt_b4_tax + v_pens_relief_amt;

				#set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;

			elseif c_pel_sht_desc = 'LIFEINSURANCE' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'LIFEINSURANCE';
				set v_error_no = 1;
				select concat('Unable to calculate ', c_pel_desc) into v_error;
				select case when c_epe_amt is null then 0 else c_epe_amt end into c_epe_amt;
				if c_nontax_allowed_amt > c_epe_amt then
					set v_inrelief_amt = c_epe_amt;
				elseif c_nontax_allowed_amt < c_epe_amt then
					set v_inrelief_amt = c_nontax_allowed_amt;					
				end if;
				set v_ppe_ded_amt_b4_tax = v_inrelief_amt;
				set v_tot_ded_amt_b4_tax = v_tot_ded_amt_b4_tax + v_inrelief_amt;

				#set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;

			elseif c_pel_sht_desc = 'MEDICAL' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'MEDICAL';
				set v_error_no = 1;
				select concat('Unable to calculate ', c_pel_desc) into v_error;
				select case when c_epe_amt is null then 0 else c_epe_amt end into c_epe_amt;
				if c_nontax_allowed_amt > c_epe_amt then
					set v_inrelief_amt = c_epe_amt;
				elseif c_nontax_allowed_amt < c_epe_amt then
					set v_inrelief_amt = c_nontax_allowed_amt;					
				end if;
				set v_ppe_ded_amt_b4_tax = v_inrelief_amt;
				set v_tot_ded_amt_b4_tax = v_tot_ded_amt_b4_tax + v_inrelief_amt;

				#set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;

			elseif c_pel_sht_desc = 'NORMALOT' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				select case when v_basic_pay is null then 0 else v_basic_pay end into v_basic_pay;
				select case when v_tot_month_hrs is null then 1
					   when v_tot_month_hrs = 0 then 1
					   else v_tot_month_hrs end into v_tot_month_hrs;
				
				if v_tot_month_hrs > 1 then
					set c_epe_amt = round((v_basic_pay/v_tot_month_hrs) * 1.5 * c_ot_hours,2); 
					if c_deduction = 'NO' then
						set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;
					else
						set v_extra_payable_amt = v_extra_payable_amt - c_epe_amt;
					end if;
				end if;

			elseif c_pel_sht_desc = 'HOLIDAYOT' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				select case when v_basic_pay is null then 0 else v_basic_pay end into v_basic_pay;
				select case when v_tot_month_hrs is null then 1
					   when v_tot_month_hrs = 0 then 1
					   else v_tot_month_hrs end into v_tot_month_hrs;
				
				if v_tot_month_hrs > 1 then
					set c_epe_amt = round((v_basic_pay/v_tot_month_hrs) * 2 * c_ot_hours,2); 
					if c_deduction = 'NO' then
						set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;
					else
						set v_extra_payable_amt = v_extra_payable_amt - c_epe_amt;
					end if;
				end if;

			elseif c_pel_sht_desc = 'ABSENCE' then
				set v_error_no = 1;
				select concat('Unable to fetch pay element details ', c_pel_desc) into v_error;
				select case when v_basic_pay is null then 0 else v_basic_pay end into v_basic_pay;
				select case when v_tot_month_hrs is null then 1
					   when v_tot_month_hrs = 0 then 1
					   else v_tot_month_hrs end into v_tot_month_hrs;
				
				if v_tot_month_hrs > 1 then
					set c_epe_amt = round((v_basic_pay/v_tot_month_hrs) * c_ot_hours,2); 
					set v_extra_payable_amt = v_extra_payable_amt - c_epe_amt;
				end if;

			elseif c_pel_sht_desc = 'NHIF' then
				set v_error_no = 1;
				select 'Unable to get NHIF setup rates and taxes.' into v_error;
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'NHIF';
				set v_error_no = 1;
				select concat('Unable to calculate ', c_pel_desc,' c_emp_code=',c_emp_code,' v_tr_code=',v_tr_code) into v_error;

				call `calc_taxes`(v_tx_code,
							Now(),
							v_amt_to_tax,
							v_tax_amt
							);
				set v_error_no = 3;
				set c_epe_amt = v_tax_amt;

			elseif c_pel_sht_desc = 'GP' then
				set v_error_no = 1;
				select 'Unable to calculate taxable pay.' into v_error;
				select case when v_gross_pay is null then 0 else v_gross_pay end into v_gross_pay;
				set c_epe_amt = v_gross_pay;

			elseif c_pel_sht_desc = 'TP' then
				set v_error_no = 1;
				select 'Unable to calculate taxable pay.' into v_error;	

				select case when v_extra_payable_amt is null then 0 else v_extra_payable_amt end into v_extra_payable_amt;
				select case when v_nssf_amt is null then 0 else v_nssf_amt end into v_nssf_amt;
				#select case when v_inrelief_amt is null then 0 else v_inrelief_amt end into v_inrelief_amt;
				#select case when v_pens_relief_amt is null then 0 else v_pens_relief_amt end into v_pens_relief_amt;

				set v_amt_to_tax = v_amt_to_tax + v_extra_payable_amt 
									- v_tot_ded_amt_b4_tax;
				set c_epe_amt = v_amt_to_tax;

			elseif c_pel_sht_desc = 'NP' then
				set v_error_no = 1;
				select 'Unable to calculate taxable pay.' into v_error;
				select case when v_net_pay is null then 0 else v_net_pay end into v_net_pay;
				set c_epe_amt = v_net_pay;

			elseif c_pel_sht_desc = 'TAX' then
				set v_error_no = 1;
				select 'Unable to calculate taxable pay.' into v_error;
				select case when v_tax is null then 0 else v_tax end into v_tax;
				set c_epe_amt = v_tax;

			elseif c_pel_sht_desc = 'PAYE' then
				set v_error_no = 1;

				select 'Unable to get PAYE setup rates and taxes.' into v_error;
				select tx_code into v_tx_code from shr_taxes
				where tx_sht_desc = 'PAYE';
				/*
				select case when v_extra_payable_amt is null then 0 else v_extra_payable_amt end into v_extra_payable_amt;
				select case when v_nssf_amt is null then 0 else v_nssf_amt end into v_nssf_amt;
				#select case when v_inrelief_amt is null then 0 else v_inrelief_amt end into v_inrelief_amt;
				#select case when v_pens_relief_amt is null then 0 else v_pens_relief_amt end into v_pens_relief_amt;

				set v_amt_to_tax = v_amt_to_tax + v_extra_payable_amt 
									- v_tot_ded_amt_b4_tax;
				*/
				set v_error_no = 1;
				select concat('Unable to compute PAYE amount to tax=', v_amt_to_tax) into v_error;

				call `calc_taxes`(v_tx_code,
							Now(),
							v_amt_to_tax,
							v_tax_amt
							);
				set v_error_no = 1;
				select concat('Unable to update PAYE. PAYE amount=',v_tax_amt) into v_error;
				select case when v_prelief_amt is null then 0 else v_prelief_amt end into v_prelief_amt;
				set c_epe_amt = v_tax_amt - v_prelief_amt, v_tax = v_tax_amt;

				/*
				if c_emp_code = 34 then
				select concat('PAYE amount to tax=', v_amt_to_tax, ' ',c_epe_amt,
				' v_extra=',v_extra_payable_amt, 
				' v_tot_ded=',v_tot_ded_amt_b4_tax) into v_error;
				call raise_error();	
				end if;*/

			elseif c_element_order = 40 and c_pel_taxable = 'YES' then /*and c_pel_type = 'BENEFIT'*/ 
				set v_error_no = 1;
				select concat('Unable to calculate ', c_pel_desc) into v_error;
				select case when c_epe_amt is null then 0 else c_epe_amt end into c_epe_amt;

				#set v_tot_val_of_benfit_amt = v_tot_val_of_benfit_amt + v_val_of_benfit_amt;
				if c_deduction = 'NO' then
					set v_extra_payable_amt = v_extra_payable_amt + c_epe_amt;
				else
					set v_extra_payable_amt = v_extra_payable_amt - c_epe_amt;
				end if;

			end if;

			if not c_pel_sht_desc in ('PAYE','NSSF','NHIF','GP','TP','NP','PRELIEF','LIFEINSURANCE') then
				if c_deduction = 'NO' then
					set v_gross_pay = v_gross_pay + c_epe_amt;
				#else
					#set v_gross_pay = v_gross_pay - c_epe_amt;
				end if;
			end if;

			if c_pel_sht_desc not in ('GP','TP','NP','PRELIEF') and c_pel_type != 'STATEMENT ITEM' then
				if c_deduction = 'NO' then
					set v_net_pay = v_net_pay + c_epe_amt;
				else
					set v_net_pay = v_net_pay - c_epe_amt;
				end if;
			end if;
			if c_epe_amt is  null then	
				set c_epe_amt = 0;
			end if;

			set v_error_no = 1;
			select concat('Unable to update Payroll Pay Element...ppe_code=',c_ppe_code) into v_error;
			update shr_prd_pay_elements
			set ppe_amt = c_epe_amt,
				ppe_ded_amt_b4_tax = v_ppe_ded_amt_b4_tax,
				ppe_val_of_benfit_amt = v_val_of_benfit_amt,
				ppe_ot_hours = c_ot_hours
			where ppe_code = c_ppe_code;

			if v_cnt2 > 2 and v_basic_pay = 0 then
				set v_error_no = 1;
				select concat('Unable to update zero payable amount',' ') into v_error;
				update shr_prd_pay_elements
				set ppe_amt = 0,
					ppe_ded_amt_b4_tax = 0,
					ppe_val_of_benfit_amt = 0,
					ppe_ot_hours = 0
				where `ppe_emp_code` = c_emp_code and  `ppe_tr_code` = v_tr_code;
			end if;
			set v_ppe_ded_amt_b4_tax = 0,v_val_of_benfit_amt=0;
			set v_error_no = 99999;
		  END LOOP;
		  CLOSE cursor_pe;
		  set done = false;
	  END LOOP;
	  CLOSE cursor_e;

COMMIT;
#END TRANSACTION
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure rpt_payslip_001
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_payslip_001`(v_tr_code int,
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

-- -----------------------------------------------------
-- procedure rpt_salarylist_001
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_salarylist_001`(v_tr_code int,
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

-- -----------------------------------------------------
-- procedure update_bank_branches
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_bank_branches`(v_bbr_code int,
								v_sht_desc varchar(15),
								v_name varchar(300),
								v_postal_address varchar(1000),
								v_physical_address varchar(1000),
								v_tel_no1 varchar(45),
								v_tel_no2 varchar(45),
								v_bnk_code int,
								out v_bbrcode int
								)
BEGIN
declare v_cnt, v_bnkcode int;
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error text;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating bank record';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text= 'Error updating bank record';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set v_bnkcode = v_bnk_code;

select count(1) into v_cnt from `serenehrdb`.`shr_bank_branches`
where bbr_sht_desc = v_sht_desc and bbr_bnk_code = v_bnk_code;

#CALL raise_error (1356, 'My Error Message');
if (v_bbr_code is null or v_bbr_code = 0)  and v_cnt = 0 then
	set v_error_no = 1;
	INSERT INTO `serenehrdb`.`shr_bank_branches`
	(`bbr_sht_desc`,`bbr_name`,`bbr_postal_address`,`bbr_physical_address`,
	`bbr_tel_no1`,`bbr_tel_no2`,`bbr_bnk_code`)
	VALUES
	(v_sht_desc,v_name,v_postal_address,v_physical_address,
	v_tel_no1,v_tel_no2,v_bnkcode);
	select max(bbr_code) into v_bbrcode from `serenehrdb`.`shr_bank_branches`;
else
	if v_cnt > 0 then
		UPDATE `serenehrdb`.`shr_bank_branches`
		SET 
		`bbr_name` = v_name,
		`bbr_postal_address` = v_postal_address,
		`bbr_physical_address` = v_physical_address,
		`bbr_tel_no1` = v_tel_no1,
		`bbr_tel_no2` = v_tel_no2
		WHERE `bbr_sht_desc` = v_sht_desc
		and bbr_bnk_code = v_bnk_code;

		select bbr_code into v_bbrcode from `serenehrdb`.`shr_bank_branches`
		where `bbr_sht_desc` = v_sht_desc and bbr_bnk_code = v_bnk_code;
	else
		set v_error_no = 2;
		UPDATE `serenehrdb`.`shr_bank_branches`
		SET `bbr_sht_desc` = v_sht_desc,
		`bbr_name` = v_name,
		`bbr_postal_address` = v_postal_address,
		`bbr_physical_address` = v_physical_address,
		`bbr_tel_no1` = v_tel_no1,
		`bbr_tel_no2` = v_tel_no2
		WHERE `bbr_code` = v_bbr_code;
		set v_bbrcode = v_bbr_code;
	end if;
end if;


COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_banks
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_banks`(v_bnk_code int,
								v_sht_desc varchar(15),
								v_name varchar(300),
								v_postal_address varchar(1000),
								v_physical_address varchar(1000),
								v_kba_code varchar(15),
								out v_bnkcode int
								)
BEGIN
declare v_cnt int;
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error text;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating bank record';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text= 'Error updating bank record';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

select count(1) into v_cnt from `serenehrdb`.`shr_banks`
where bnk_sht_desc = v_sht_desc;

#CALL raise_error (1356, 'My Error Message');
if (v_bnk_code is null or v_bnk_code = 0) and v_cnt = 0 then
	set v_error_no = 1;
	INSERT INTO `serenehrdb`.`shr_banks`
	(`bnk_sht_desc`,`bnk_name`,`bnk_postal_address`,
	`bnk_physical_address`,`bnk_kba_code`)
	VALUES
	(v_sht_desc,v_name,v_postal_address,
	v_physical_address,v_kba_code);
	select max(bnk_code) into v_bnkcode from `serenehrdb`.`shr_banks`;
else
	if v_cnt > 0 then
		set v_error_no = 3;
		UPDATE `serenehrdb`.`shr_banks`
		SET `bnk_name` = v_name,
			`bnk_postal_address` = v_postal_address,
			`bnk_physical_address` = v_physical_address,
			`bnk_kba_code` = v_kba_code
		WHERE `bnk_sht_desc` = v_sht_desc;
		select bnk_code into v_bnkcode from `serenehrdb`.`shr_banks`
		where `bnk_sht_desc` = v_sht_desc;

	else
		set v_error_no = 2;
		UPDATE `serenehrdb`.`shr_banks`
		SET `bnk_sht_desc` = v_sht_desc,
			`bnk_name` = v_name,
			`bnk_postal_address` = v_postal_address,
			`bnk_physical_address` = v_physical_address,
			`bnk_kba_code` = v_kba_code
		WHERE `bnk_code` = v_bnk_code;
		set v_bnkcode = v_bnk_code;
	end if;
end if;


COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_emp_loans
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_emp_loans`(v_el_code bigint,
								v_emp_code  bigint,
								v_eff_date  varchar(10),
								v_loan_applied_amt  decimal(25,5),
								v_service_charge  decimal(25,5),
								v_done_by  varchar(100),
								v_lt_code		int,
								out v_elcode int,
								v_tot_instalments int,
								v_instalment_amt decimal(25,5)
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, var int;
declare v_error text;
declare v_effdate date;
declare v_issued_amt  decimal(25,5);
declare v_authorised varchar(5);
declare no_data_found boolean;
declare v_final_repay_date date;
		
DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_data_found = TRUE;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 11 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation loan effective date';
		elseif v_error_no in (2,3) then #duplicate accessible
			signal sqlstate '45000'
				set message_text= v_error; #'Error validation W.E.T date';
		elseif v_error_no = 100 then
			signal sqlstate '45000'
				set message_text= v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set no_data_found = false;

if v_done_by is null or v_done_by = '' then	
	set v_error_no = 1;
	set v_error = ' ';
	select concat(v_error,'Log in first to proceed...') into v_error;
	call raise_error();
end if;

	if not (v_el_code is null or v_el_code = 0) then
		set v_error_no = 100;
		set v_error = ' ';
		select concat(v_error,'Unable to find loan record...') into v_error;
		SELECT case when el_authorised is null then 'NO' else el_authorised end as el_authorised
		into v_authorised
		FROM `serenehrdb`.`shr_emp_loans` el
		left join `serenehrdb`.`shr_loan_types`  lt on (el.el_lt_code=lt.lt_code)
		where el_code = v_el_code;

		if no_data_found = true then
			set v_error_no = 100;
			select concat('Unable to find loan record...v_el_code=',v_el_code) into v_error;
			call raise_error();
		end if;
		set no_data_found = false;
	end if;

	if v_authorised != 'NO' and v_authorised is not null then	
		set v_error_no = 100;
		set v_error = ' ';
		select concat(v_error,'Updating authorised transactions is not allowed...Loan Id=', v_el_code,
				' Authorised=', v_authorised) into v_error;
		call raise_error();
	end if;

	if ((v_tot_instalments is null or v_tot_instalments = 0)
		and (v_instalment_amt is null or v_instalment_amt = 0)) then
			set v_error_no = 100;
			set v_error = ' ';
			select concat(v_error,'Enter the installment amount or expected total number of repayment installments to proceed...') into v_error;
			call raise_error();
	end if;

	set v_issued_amt = v_loan_applied_amt - v_service_charge;

	set v_error_no = 1;
	if v_eff_date is null then	
		set v_effdate = ' ';
	end if;
	select char_length(v_eff_date) into var;
	if var >= 10 then
		set v_error_no = 1;
		SELECT STR_TO_DATE(v_eff_date,'%d/%m/%Y') into v_effdate;
	else	
		set v_error_no = 2;
		select concat('The loan effective date is not valid... ',v_effdate) into v_error;
		call raise_error();
	end if;

	if v_loan_applied_amt is null or v_loan_applied_amt = 0 then
		set v_error_no = 3;
		select concat('The loan applied amount cannot be zero... loan_applied_amt=',v_loan_applied_amt) into v_error;
		call raise_error();
	end if;

	if v_el_code is null or v_el_code = 0 then
		set v_error_no = 30;
		select 'Unable to create loan record...' into v_error;
		INSERT INTO `serenehrdb`.`shr_emp_loans`
		(`el_emp_code`,`el_date`,`el_eff_date`,`el_loan_applied_amt`,`el_issued_amt`,
		`el_service_charge`,`el_intr_rate`,`el_intr_div_factr`,
		`el_done_by`,`el_authorised_by`,`el_authorised_date`,`el_authorised`,
		`el_tot_tax_amt`,`el_lt_code`,`el_final_repay_date`, `el_tot_instalments`, 
		`el_instalment_amt`)
		VALUES
		(v_emp_code,Now(),v_effdate,v_loan_applied_amt,v_issued_amt,
		v_service_charge,0,1,
		v_done_by,null,null,'NO',
		0,v_lt_code,v_final_repay_date,v_tot_instalments,
		v_instalment_amt);
		select max(el_code) into v_elcode from  `serenehrdb`.`shr_emp_loans`;
	else	

		set v_error_no = 3;
		select 'Unable to update loan record...' into v_error;
		UPDATE `serenehrdb`.`shr_emp_loans`
		SET `el_eff_date` = v_effdate,
			`el_loan_applied_amt` = v_loan_applied_amt,
			`el_issued_amt` = v_issued_amt,
			`el_service_charge` = v_service_charge,
			`el_done_by` = v_done_by,
			`el_final_repay_date` = v_final_repay_date,
			`el_tot_instalments` = v_tot_instalments,
			`el_instalment_amt` = v_instalment_amt			
		WHERE `el_code` = v_el_code;
		set v_elcode = v_el_code;
	end if;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_emp_pay_elements
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_emp_pay_elements`(v_epe_code int,
								v_emp_code int,
								v_pel_code int,
								v_amt decimal(25,5),
								v_created_by  varchar(100),
								out v_epecode int,
								v_ot_hours int
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating employee pay element record...';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error updating employee pay element record...';
		elseif v_error_no = 3 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error updating employee pay element record..3...';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

if v_epe_code is null or v_epe_code = 0 then
	set v_error_no = 1;
	INSERT INTO `serenehrdb`.`shr_emp_pay_elements`
	(`epe_emp_code`,`epe_pel_code`,`epe_amt`,`epe_date`,`epe_created_by`, `epe_ot_hours`)
	VALUES
	(v_emp_code,v_pel_code,v_amt,Now(),v_created_by, v_ot_hours);
	select max(epe_code) into v_epecode from  `serenehrdb`.`shr_emp_pay_elements`;
else	
	set v_error_no = 2;
	UPDATE `serenehrdb`.`shr_emp_pay_elements`
	SET `epe_amt` = v_amt
	WHERE `epe_code` = v_epe_code;
	set v_epecode = v_epe_code;
end if;

if v_epe_code is not null and v_epe_code > 0 then
	set v_error_no = 3;
	UPDATE `serenehrdb`.`shr_emp_pay_elements`
	SET `epe_amt` = v_amt,
		`epe_ot_hours` = v_ot_hours
	WHERE `epe_code` = v_epe_code;
	set v_epecode = v_epe_code;
end if;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_emp_photo
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_emp_photo`(v_emp_code bigint,
								v_photo_stream  mediumblob,
								v_photo_updatedby varchar(100)
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, var int;
declare v_error text;
declare no_data_found boolean;
		
DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_data_found = TRUE;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 11 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation loan effective date';
		elseif v_error_no in (2,3) then #duplicate accessible
			signal sqlstate '45000'
				set message_text= v_error; #'Error validation W.E.T date';
		elseif v_error_no = 100 then
			signal sqlstate '45000'
				set message_text= v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
	select length(v_photo_stream) into var;
	if var is null or var = 0 then
		set v_error_no = 3;
		select 'Upload a photo to proceed...' into v_error;
		call raise_error();
	end if;
	
	if v_emp_code is null or v_emp_code = 0 then
		set v_error_no = 3;
		select 'Select an employee to proceed...' into v_error;
		call raise_error();
	end if;	
	
	if v_photo_updatedby is null or v_photo_updatedby = "" then
		set v_error_no = 3;
		select 'Login first to proceed...' into v_error;
		call raise_error();
	end if;	

	set v_error_no = 3;
	select 'Unable to update employee photo...' into v_error;
	UPDATE `serenehrdb`.`shr_employees`
	SET `emp_photo` = v_photo_stream,
		`emp_photo_updatedby` = v_photo_updatedby
	WHERE `emp_code` = v_emp_code;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_loan_intr_rates
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_loan_intr_rates`(v_lir_code int,
								v_rate    int,
								v_div_factr    int,
								v_wef	varchar(45),
								v_wet varchar(45),
								v_lt_code int,
								out v_lircode int
								)
BEGIN
declare v_lir_wef, v_lir_wet date;
declare var int;
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation W.E.F date';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation W.E.T date';
		elseif v_error_no = 3 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating loan rate record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating loan rate record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Employee already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;


select char_length(v_wef) into var;
if var >= 10 then
	set v_error_no = 1;
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_lir_wef;
end if;
select char_length(v_wet) into var;
if var >= 10 then
	set v_error_no = 2;
	SELECT STR_TO_DATE(v_wet,'%d/%m/%Y') into v_lir_wet;
end if;


#CALL raise_error (1356, 'My Error Message v_org_code=' + v_org_code);
if v_lir_code is null or v_lir_code = 0 then
	set v_error_no = 3;
	INSERT INTO `serenehrdb`.`shr_loan_intr_rates`
	(`lir_rate`,`lir_div_factr`,`lir_wef`,`lir_wet`,`lir_lt_code`)
	VALUES
	(v_rate,v_div_factr,v_lir_wef,v_lir_wet,v_lt_code);
	select max(lir_code) into v_lircode from  `serenehrdb`.`shr_loan_intr_rates`;
else	
	set v_error_no = 4;
	UPDATE `serenehrdb`.`shr_loan_intr_rates`
	SET `lir_rate` = v_rate,
		`lir_div_factr` = v_div_factr,
		`lir_wef` = v_wef,
		`lir_wet` = v_wet
	WHERE `lir_code` = v_lir_code;
	set v_lircode = v_lir_code;
end if;


COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_loan_types
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_loan_types`(v_lt_code int,
								v_sht_desc  varchar(45),
								v_desc  varchar(100),
								v_min_repay_prd    int,
								v_max_repay_prd    int,
								v_min_amt    int,
								v_max_amt    int,
								v_wef	varchar(45),
								v_wet varchar(45),
								out v_ltcode int
								)
BEGIN
declare v_lt_wef, v_lt_wet date;
declare var int;
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation W.E.F date';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation W.E.T date';
		elseif v_error_no = 3 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating loan type record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating loan type record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Employee already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;


select char_length(v_wef) into var;
if var >= 10 then
	set v_error_no = 1;
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_lt_wef;
end if;
select char_length(v_wet) into var;
if var >= 10 then
	set v_error_no = 2;
	SELECT STR_TO_DATE(v_wet,'%d/%m/%Y') into v_lt_wet;
end if;


#CALL raise_error (1356, 'My Error Message v_org_code=' + v_org_code);
if v_lt_code is null or v_lt_code = 0 then
	set v_error_no = 3;
	INSERT INTO `serenehrdb`.`shr_loan_types`
	(`lt_sht_desc`,`lt_desc`,`lt_min_repay_prd`,`lt_max_repay_prd`,
	`lt_min_amt`,`lt_max_amt`,`lt_wef`,`lt_wet`)
	VALUES
	(v_sht_desc,v_desc,v_min_repay_prd,v_max_repay_prd,
	v_min_amt,v_max_amt,v_lt_wef,v_lt_wet);
	select max(lt_code) into v_ltcode from  `serenehrdb`.`shr_loan_types`;
else	
	set v_error_no = 4;
	UPDATE `serenehrdb`.`shr_loan_types`
	SET `lt_sht_desc` = v_sht_desc,
		`lt_desc` = v_desc,
		`lt_min_repay_prd` = v_min_repay_prd,
		`lt_max_repay_prd` = v_max_repay_prd,
		`lt_min_amt` = v_min_amt,
		`lt_max_amt` = v_max_amt,
		`lt_wef` = v_lt_wef,
		`lt_wet` = v_lt_wet
	WHERE `lt_code` = v_lt_code;
	set v_ltcode = v_lt_code;
end if;


COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_org
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_org`(in v_org_code int,
								v_sht_desc  varchar(45),
								v_desc  varchar(1000),
								v_postal_address  varchar(1000),
								v_physical_address  varchar(1000),
								v_type  varchar(5),
								v_parent_org_code	int,
								v_wef	varchar(45),
								v_wet	varchar(45),
								out v_orgcode int
								)
BEGIN
declare v_parent_org_sht_desc	varchar(45);
declare v_parent_orgcode int;
declare v_level	smallint;
declare v_dt_wef, v_dt_wet date;
declare v_ln, var, v_runng_org_code,v_runng_org_code2 int;
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

SET autocommit=0;
START TRANSACTION;

set v_level = 1;
set v_runng_org_code = v_parent_org_code;
select count(1) into var 
from  `serenehrdb`.`shr_organizations` where org_code = v_runng_org_code;
while var > 0 do
	set v_level = (v_level + 1);
	select org_parent_org_code into v_runng_org_code2 
	from  `serenehrdb`.`shr_organizations` where org_code = v_runng_org_code;
	select count(1) into var 
	from  `serenehrdb`.`shr_organizations` where org_code = v_runng_org_code2;
	set v_runng_org_code = v_runng_org_code2;
end while;


#SELECT STR_TO_DATE('2013/05/21 extra characters','%Y/%m/%d') into v_dt_wef;
select char_length(v_wef) into var;
/*if (var>0) then
	SELECT STR_TO_DATE((select replace(v_wef,' PM','')),'%d/%m/%Y %H:%i:%s') into v_dt_wef;
else
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_dt_wef;
end if;*/

if var >= 10 then
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_dt_wef;
end if;

select char_length(v_wet) into var;
if var >= 10 then
	SELECT STR_TO_DATE(v_wet,'%d/%m/%Y') into v_dt_wet;
end if;
if (v_dt_wet is not null) then
	if (v_dt_wet < v_dt_wet) then
		call unavailable_proc();  
	end if;
end if;
select LENGTH(v_wef) into v_ln;

if v_parent_org_code is not null or v_parent_org_code !=0 then
	select org_sht_desc into v_parent_org_sht_desc 
	from  `serenehrdb`.`shr_organizations` where org_code = v_parent_org_code;
	set v_parent_orgcode = v_parent_org_code;
else
	set v_parent_orgcode = v_parent_org_code;
	set v_parent_org_sht_desc = null;
end if;
#CALL raise_error (1356, 'My Error Message v_org_code=' + v_org_code);
if v_org_code is null or v_org_code = 0 then
	INSERT INTO `serenehrdb`.`shr_organizations`
	(`org_sht_desc`,`org_desc`,`org_postal_address`,`org_physical_address`,
	`org_type`,`org_parent_org_code`,`org_parent_org_sht_desc`,`org_wef`,
	`org_wet`,`org_level`)
	VALUES
	(v_sht_desc,v_desc,v_postal_address,v_physical_address,
	v_type,v_parent_orgcode,v_parent_org_sht_desc,v_dt_wef,
	v_dt_wet,v_level);
	select max(org_code) into v_orgcode from  `serenehrdb`.`shr_organizations`;
else	
	UPDATE `serenehrdb`.`shr_organizations`
	SET `org_sht_desc` = v_sht_desc,
	`org_desc` = v_desc,
	`org_postal_address` = v_postal_address,
	`org_physical_address` = v_physical_address,
	`org_type` = v_type,
	`org_parent_org_code` = v_parent_orgcode,
	`org_parent_org_sht_desc` = v_parent_org_sht_desc,
	`org_wef` = v_dt_wef,
	`org_wet` = v_dt_wet,
	`org_level` = v_level
	WHERE `org_code` = v_org_code; 
	set v_orgcode = v_org_code;
end if;
COMMIT;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_payelement_downwrds
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_payelement_downwrds`(v_pel_code int)
BEGIN
	declare c_pel_code,c_pel_order, v_min_pel_order int;
	declare sqlstate_code char(5) default '00000';
	declare message_text TEXT;
	declare mysql_error, v_error_no int;
	declare v_error text;
	declare done boolean;

	DECLARE cursor_pe CURSOR FOR SELECT pel_code, pel_order
			from shr_pay_elements
			where pel_code = v_pel_code;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 
			sqlstate_code = RETURNED_SQLSTATE, 
			mysql_error= MYSQL_ERRNO, 
			message_text = MESSAGE_TEXT;

		if sqlstate_code <> '00000' then
			
			if v_error_no = 1 then 
				signal sqlstate '45000'
					set message_text= v_error;
			else
				#signal sqlstate '45000' set message_text= 'Unable to save records...';
				resignal;
			end if;			
		end if;
	END;

SET autocommit=0;
START TRANSACTION;

	set done = false;
	OPEN cursor_pe;
	  read_pe_loop: LOOP
		FETCH cursor_pe INTO c_pel_code,c_pel_order;
		IF done THEN
		  LEAVE read_pe_loop;
		END IF;
		
		select min(pel_order) into v_min_pel_order
		from `shr_pay_elements`
		where pel_order > c_pel_order;

		select case when v_min_pel_order is null then 0 else v_min_pel_order end into v_min_pel_order;
		
		if v_min_pel_order > 0 then
			update `shr_pay_elements`
			set pel_order = c_pel_order
			where pel_order = v_min_pel_order;
			
			update `shr_pay_elements`
			set pel_order = v_min_pel_order
			where pel_code = v_pel_code;
		end if;
		
	  END LOOP;
	CLOSE cursor_pe;
	set done = false;

	
COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_payelement_select
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_payelement_select`(v_pel_code int,
											v_select int)
BEGIN
	declare c_pel_code,c_pel_order, v_max_pel_order int;
	declare sqlstate_code char(5) default '00000';
	declare message_text TEXT;
	declare mysql_error, v_error_no int;
	declare v_error text;
	declare done boolean;

	DECLARE cursor_pe CURSOR FOR SELECT pel_code, pel_order
			from shr_pay_elements
			where pel_code = v_pel_code;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 
			sqlstate_code = RETURNED_SQLSTATE, 
			mysql_error= MYSQL_ERRNO, 
			message_text = MESSAGE_TEXT;

		if sqlstate_code <> '00000' then
			
			if v_error_no = 1 then 
				signal sqlstate '45000'
					set message_text= v_error;
			else
				#signal sqlstate '45000' set message_text= 'Unable to save records...';
				resignal;
			end if;			
		end if;
	END;

SET autocommit=0;
START TRANSACTION;

	set v_error_no = 1;
	set v_error = ' ';

	update `shr_pay_elements`
	set pel_selected = v_select
	where pel_code = v_pel_code;

	
COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_payelement_upwrds
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_payelement_upwrds`(v_pel_code int)
BEGIN
	declare c_pel_code,c_pel_order, v_max_pel_order int;
	declare sqlstate_code char(5) default '00000';
	declare message_text TEXT;
	declare mysql_error, v_error_no int;
	declare v_error text;
	declare done boolean;

	DECLARE cursor_pe CURSOR FOR SELECT pel_code, pel_order
			from shr_pay_elements
			where pel_code = v_pel_code;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 
			sqlstate_code = RETURNED_SQLSTATE, 
			mysql_error= MYSQL_ERRNO, 
			message_text = MESSAGE_TEXT;

		if sqlstate_code <> '00000' then
			
			if v_error_no = 1 then 
				signal sqlstate '45000'
					set message_text= v_error;
			else
				#signal sqlstate '45000' set message_text= 'Unable to save records...';
				resignal;
			end if;			
		end if;
	END;

SET autocommit=0;
START TRANSACTION;

	set v_error_no = 1;
	set v_error = ' ';
	
	set done = false;
	OPEN cursor_pe;
	  read_pe_loop: LOOP
		FETCH cursor_pe INTO c_pel_code,c_pel_order;
		IF done THEN
		  LEAVE read_pe_loop;
		END IF;
		
		select max(pel_order) into v_max_pel_order
		from `shr_pay_elements`
		where pel_order < c_pel_order;

		select case when v_max_pel_order is null then 0 else v_max_pel_order end into v_max_pel_order;
		
		if v_max_pel_order > 0 then
			update `shr_pay_elements`
			set pel_order = c_pel_order
			where pel_order = v_max_pel_order;
			
			update `shr_pay_elements`
			set pel_order = v_max_pel_order
			where pel_code = v_pel_code;
		end if;
		
	  END LOOP;
	CLOSE cursor_pe;
	#select concat('Max order=',v_max_pel_order,' order=',c_pel_order) into v_error;
	#call raise_error();
	set done = false;

	
COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_payelements
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_payelements`(v_pel_code int,
								v_sht_desc  varchar(100),
								v_desc  varchar(200),
								v_taxable   varchar(45),
								v_deduction	varchar(45),
								v_depends_on		int,
								v_type	varchar(45),
								out v_pelcode int,
								v_applied_to	varchar(45),
								v_nontax_allowed_amt	decimal(25,5),
								v_prescribed_amt	decimal(25,5)
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no,v_cnt int;
declare v_error text;
declare v_appliedto varchar(45);

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation W.E.F date';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text= 'Error validation W.E.T date';
		elseif v_error_no = 3 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating Pay Element record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating Pay Element record';
		elseif v_error_no = 100 then
			signal sqlstate '45000'
				set message_text= v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

set v_appliedto = v_applied_to;
if v_appliedto is null or v_appliedto = '' then
	set v_appliedto = 'EMPLOYEE';
end if;

#set v_error = concat('v_pel_code=', v_pel_code);
#CALL raise_error (1356, 'My Error Message');
if v_pel_code is null or v_pel_code = 0 then

	select count(1) into v_cnt from `serenehrdb`.`shr_pay_elements`
	where `pel_sht_desc` = v_sht_desc;
	if v_cnt > 0 then
		set v_error_no = 100;
		select concat('The pay element Short Description ',v_sht_desc,' is already being used.') into v_error;
		call raise_error();
	end if;
	select count(1) into v_cnt from `serenehrdb`.`shr_pay_elements`
	where `pel_desc` = v_desc;
	if v_cnt > 0 then
		set v_error_no = 100;
		select concat('The Pay Element Description ',v_desc,' is already being used.') into v_error;
		call raise_error();
	end if;

	set v_error_no = 3;
	select 'Unable to create record...' into v_error;
	INSERT INTO `serenehrdb`.`shr_pay_elements`
	(`pel_sht_desc`,`pel_desc`,`pel_taxable`,
	`pel_deduction`,`pel_depends_on`,`pel_type`,`pel_applied_to`,
	`pel_nontax_allowed_amt`,`pel_prescribed_amt`)
	VALUES
	(v_sht_desc,v_desc,v_taxable,
	v_deduction,v_depends_on,v_type,v_appliedto,
	v_nontax_allowed_amt, v_prescribed_amt);
	select max(pel_code) into v_pelcode from  `serenehrdb`.`shr_pay_elements`;
else	
	set v_error_no = 4;
	select 'Unable to update record...' into v_error;
	UPDATE `serenehrdb`.`shr_pay_elements`
	SET `pel_sht_desc` = v_sht_desc,
		`pel_desc` = v_desc,
		`pel_taxable` = v_taxable,
		`pel_deduction` = v_deduction,
		`pel_depends_on` = v_depends_on,
		`pel_type` = v_type,
		`pel_applied_to` = v_appliedto,
		`pel_nontax_allowed_amt` = v_nontax_allowed_amt,
		`pel_prescribed_amt` = v_prescribed_amt
	WHERE `pel_code` = v_pel_code;
	set v_pelcode = v_pel_code;
end if;


COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_payroll
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_payroll`(v_pr_code int,
								v_sht_desc  varchar(45),
								v_desc  varchar(100),
								v_org_code	int,
								v_wef	varchar(45),
								v_wet varchar(45),
								out v_prcode int,
								v_day1_hrs   decimal(5,2), 
								v_day2_hrs   decimal(5,2), 
								v_day3_hrs   decimal(5,2), 
								v_day4_hrs   decimal(5,2), 
								v_day5_hrs   decimal(5,2), 
								v_day6_hrs   decimal(5,2), 
								v_day7_hrs   decimal(5,2)
								)
BEGIN
declare v_pr_wef, v_pr_wet date;
declare var int;
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation W.E.F date';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation W.E.T date';
		elseif v_error_no = 3 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating payroll record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating payroll record';
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


select char_length(v_wef) into var;
if var >= 10 then
	set v_error_no = 1;
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_pr_wef;
end if;
select char_length(v_wet) into var;
if var >= 10 then
	set v_error_no = 2;
	SELECT STR_TO_DATE(v_wet,'%d/%m/%Y') into v_pr_wet;
end if;


#CALL raise_error (1356, 'My Error Message v_org_code=' + v_org_code);
if v_pr_code is null or v_pr_code = 0 then
	set v_error_no = 3;
	INSERT INTO `serenehrdb`.`shr_payrolls`
	(`pr_code`,`pr_sht_desc`,`pr_desc`,`pr_org_code`,`pr_wef`,`pr_wet`,
	 `pr_day1_hrs`, `pr_day2_hrs`, `pr_day3_hrs`, `pr_day4_hrs`, 
	 `pr_day5_hrs`, `pr_day6_hrs`, `pr_day7_hrs`)
	VALUES
	(v_pr_code,v_sht_desc,v_desc,v_org_code,v_pr_wef,v_pr_wet,
	 v_day1_hrs, v_day2_hrs, v_day3_hrs, v_day4_hrs, 
	 v_day5_hrs, v_day6_hrs, v_day7_hrs);
	select max(pr_code) into v_prcode from  `serenehrdb`.`shr_payrolls`;
else	
	set v_error_no = 4;
	UPDATE `serenehrdb`.`shr_payrolls`
	SET `pr_code` = v_pr_code,
		`pr_sht_desc` = v_sht_desc,
		`pr_desc` = v_desc,
		`pr_org_code` = v_org_code,
		`pr_wef` = v_pr_wef,
		`pr_wet` = v_pr_wet,
		`pr_day1_hrs` = v_day1_hrs, 
		`pr_day2_hrs` = v_day2_hrs, 
		`pr_day3_hrs` = v_day3_hrs, 
		`pr_day4_hrs` = v_day4_hrs, 
		`pr_day5_hrs` = v_day5_hrs, 
		`pr_day6_hrs` = v_day6_hrs, 
		`pr_day7_hrs` = v_day7_hrs
	WHERE `pr_code` = v_pr_code;
	set v_prcode = v_pr_code;
end if;


COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_proll_pelements
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_proll_pelements`(v_pel_code int,
								v_pr_code int
								)
BEGIN
declare v_cnt int;
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error text;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text= v_error; #'Error validation payroll record';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text= 'Error validation W.E.T date';
		elseif v_error_no = 3 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating Payrol Pay Element record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating Pay Element record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Pay Element already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;
set v_error_no = 1;
select count(*) into v_cnt from `serenehrdb`.`shr_proll_pelements`
where `pp_pel_code` = v_pel_code and `pp_pr_code` = v_pr_code;

if (v_pr_code is null or v_pr_code = 0) then
	set v_error_no = 1;
	select 'Select a payroll to attach...' into v_error;
	call raise_error();
elseif (v_pel_code is null or v_pel_code = 0) then
	set v_error_no = 1;
	select 'Select a pay element to proceed...' into v_error;
	call raise_error();
end if;

set v_error = concat(concat(concat('v_pel_code=', v_pel_code),' v_pr_code='),v_pr_code);
set v_error_no = 1;
if v_cnt is null or v_cnt = 0 then
	set v_error_no = 30;
	INSERT INTO `serenehrdb`.`shr_proll_pelements`
	(`pp_pel_code`,`pp_pr_code`)
	VALUES
	(v_pel_code,v_pr_code);
end if;


COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_tax_rates
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_tax_rates`(v_txr_code int,
								v_desc  varchar(100),
								v_rate_type   varchar(45),
								v_rate   int,
								v_div_factr   int,
								v_wef	varchar(45),
								v_wet varchar(45),
								v_range_from		int,
								v_range_to		int,
								v_tx_code		int,
								out v_txrcode int,
								v_frequency  varchar(45)
								)
BEGIN
declare v_tx_wef, v_tx_wet date;
declare var int;
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;
declare v_error text;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation W.E.F date';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text= 'Error validation W.E.T date';
		elseif v_error_no = 3 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating Tax rate record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating Tax rate record';
		elseif mysql_error = 1406 then
			signal sqlstate '45000'
				set message_text='Employee already exists ';
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;


select char_length(v_wef) into var;
if var >= 10 then
	set v_error_no = 1;
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_tx_wef;
end if;
select char_length(v_wet) into var;
if var >= 10 then
	set v_error_no = 2;
	SELECT STR_TO_DATE(v_wet,'%d/%m/%Y') into v_tx_wet;
end if;
if v_tx_wef is null then
	select tx_wef into v_tx_wef from shr_taxes
	where tx_code = v_tx_code;
end if;

#set v_error = concat('v_txr_code=', v_txr_code);
#CALL raise_error (1356, 'My Error Message');
if v_txr_code is null or v_txr_code = 0 then
	set v_error_no = 3;
	INSERT INTO `serenehrdb`.`shr_tax_rates`
	(`txr_desc`,`txr_rate_type`,`txr_rate`,`txr_div_factr`,
	`txr_wef`,`txr_wet`,`txr_tx_code`,`txr_range_from`,`txr_range_to`,
	`txr_frequency`)
	VALUES
	(v_desc,v_rate_type,v_rate,v_div_factr,
	v_tx_wef,v_tx_wet,v_tx_code, v_range_from, v_range_to,
	v_frequency);
	select max(txr_code) into v_txrcode from  `serenehrdb`.`shr_tax_rates`;
else	
	set v_error_no = 40;
	UPDATE `serenehrdb`.`shr_tax_rates`
	SET `txr_desc` = v_desc,
		`txr_rate_type` = v_rate_type,
		`txr_rate` = v_rate,
		`txr_div_factr` = v_div_factr,
		`txr_wef` = v_tx_wef,
		`txr_wet` = v_tx_wet,
		#`txr_tx_code` = v_tx_code,
		`txr_range_from` = v_range_from,
		`txr_range_to` = v_range_to,
		`txr_frequency` = v_frequency
	WHERE `txr_code` = v_txr_code;
	set v_txrcode = v_txr_code;
end if;


COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_taxes
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_taxes`(v_tx_code int,
								v_sht_desc  varchar(45),
								v_desc  varchar(100),
								v_wef	varchar(45),
								v_wet varchar(45),
								out v_txcode int
								)
BEGIN
declare v_tx_wef, v_tx_wet date;
declare var int;
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no int;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	declare v_error text;
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 1 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation W.E.F date';
		elseif v_error_no = 2 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation W.E.T date';
		elseif v_error_no = 3 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error creating Tax record';
		elseif v_error_no = 4 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error Updating Tax record';
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


select char_length(v_wef) into var;
if var >= 10 then
	set v_error_no = 1;
	SELECT STR_TO_DATE(v_wef,'%d/%m/%Y') into v_tx_wef;
end if;
select char_length(v_wet) into var;
if var >= 10 then
	set v_error_no = 2;
	SELECT STR_TO_DATE(v_wet,'%d/%m/%Y') into v_tx_wet;
end if;


#CALL raise_error (1356, 'My Error Message v_org_code=' + v_org_code);
if v_tx_code is null or v_tx_code = 0 then
	set v_error_no = 3;
	INSERT INTO `serenehrdb`.`shr_taxes`
	(`tx_sht_desc`,`tx_desc`,`tx_wef`,`tx_wet`)
	VALUES
	(v_sht_desc,v_desc,v_tx_wef,v_tx_wet);
	select max(tx_code) into v_txcode from  `serenehrdb`.`shr_taxes`;
else	
	set v_error_no = 4;
	UPDATE `serenehrdb`.`shr_taxes`
	SET `tx_sht_desc` = v_sht_desc,
		`tx_desc` = v_desc,
		`tx_wef` = v_tx_wef,
		`tx_wet` = v_tx_wet
	WHERE `tx_code` = v_tx_code;
	set v_txcode = v_tx_code;
end if;


COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_u
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_u`(v_name  varchar(45),
								v_pwd  varchar(100),
								v_new_pwd  varchar(100),
								v_re_new_pwd  varchar(100)
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, var,v_cnt int;
declare v_error text;
declare no_data_found boolean;
		
DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_data_found = TRUE;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 11 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation loan effective date';
		elseif v_error_no in (2,3) then #duplicate accessible
			signal sqlstate '45000'
				set message_text= v_error; #'Error validation W.E.T date';
		elseif v_error_no = 100 then
			signal sqlstate '45000'
				set message_text= v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

	if v_name is null or v_name = '' then
		set v_error = ' ';
		set v_error_no = 3;
		select 'You must be logged in to perform this task.' into v_error;
		call raise_error();
	end if;

	if v_pwd is null or v_pwd = '' then
		set v_error = ' ';
		set v_error_no = 3;
		select 'Enter the current password to proceed...' into v_error;
		call raise_error();
	end if;

	if v_new_pwd is null or v_new_pwd = '' then
		set v_error = ' ';
		set v_error_no = 3;
		select 'The new password cannot be null...' into v_error;
		call raise_error();
	end if;

	if v_new_pwd <> v_re_new_pwd then
		set v_error = ' ';
		set v_error_no = 3;
		select 'The new password does not match the Re-entered new password...' into v_error;
		call raise_error();
	end if;

	select char_length(v_new_pwd) into var;
	if var < 6 then
		set v_error_no = 3;
		select 'The password should be atleast 6 characters long...' into v_error;
		call raise_error();
	end if;

	Select count(1) into v_cnt from shr_users 
	where usr_name=v_name and usr_pwd=MD5(v_pwd);

	if v_cnt = 0 then
		set v_error = ' ';
		set v_error_no = 3;
		select 'The current password is wrong. Enter the correct password to proceed...' into v_error;

		UPDATE `serenehrdb`.`shr_users`
		SET usr_login_atempts = case when usr_login_atempts is null then 0 else usr_login_atempts end +1
		WHERE `usr_name` = v_name;
		call raise_error();
	end if;

	set v_error = ' ';
	set v_error_no = 3;
	select 'Unable to update record...' into v_error;
	UPDATE `serenehrdb`.`shr_users`
	SET `usr_pwd_reset` = 'NO',
		`usr_pwd` = MD5(v_new_pwd),
		`usr_login_atempts` = 0
	WHERE `usr_name` = v_name;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_user_privillages
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user_privillages`(v_up_code bigint,
								v_name  varchar(45),
								v_desc  varchar(1000),
								v_min_amt  decimal(25,5),
								v_max_amt  decimal(25,5),
								out v_upcode bigint,
								v_type		varchar(45)
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, var int;
declare v_error text;
declare no_data_found boolean;
		
DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_data_found = TRUE;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 11 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation loan effective date';
		elseif v_error_no in (2,3) then #duplicate accessible
			signal sqlstate '45000'
				set message_text= v_error; #'Error validation W.E.T date';
		elseif v_error_no = 100 then
			signal sqlstate '45000'
				set message_text= v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

	if v_up_code is null or v_up_code = 0 then
		set v_error_no = 30;
		select 'Unable to create record...' into v_error;
		INSERT INTO `serenehrdb`.`shr_user_privillages`
		(`up_name`,`up_desc`,`up_min_amt`,`up_max_amt`,`up_type`)
		VALUES
		(v_name,v_desc,v_min_amt,v_max_amt,v_type);
		select max(up_code) into v_upcode from  `serenehrdb`.`shr_user_privillages`;
	else	

		set v_error_no = 3;
		select 'Unable to update record...' into v_error;
		UPDATE `serenehrdb`.`shr_user_privillages`
		SET `up_name` = v_name,
		`up_desc` = v_desc,
		`up_min_amt` = v_min_amt,
		`up_max_amt` = v_max_amt,
		`up_type` = v_type
		WHERE `up_code` = v_up_code;
		set v_upcode = v_up_code;
	end if;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_user_role_privlg
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user_role_privlg`(v_urp_code bigint,
								v_up_code bigint,
								v_ur_code bigint,
								v_min_amt decimal(25,5),
								v_max_amt decimal(25,5),
								out v_urpcode bigint
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, var,v_cnt int;
declare v_error text;
declare no_data_found boolean;
		
DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_data_found = TRUE;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 11 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation loan effective date';
		elseif v_error_no in (2,3) then #duplicate accessible
			signal sqlstate '45000'
				set message_text= v_error; #'Error validation W.E.T date';
		elseif v_error_no = 100 then
			signal sqlstate '45000'
				set message_text= v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

	if v_urp_code > 0  then
		set v_urpcode = v_urp_code;
	else
		select count(1) into v_cnt from  `serenehrdb`.`shr_user_role_privlg`
		where urp_ur_code = v_ur_code and urp_up_code = v_up_code;

		if v_cnt = 1 then
			select urp_code into v_urpcode from  `serenehrdb`.`shr_user_role_privlg`
			where urp_ur_code = v_ur_code and urp_up_code = v_up_code;
		end if;
	end if;

	if v_urpcode is null or v_urpcode = 0 then
		set v_error_no = 3;
		select 'Unable to create record...' into v_error;
		INSERT INTO `serenehrdb`.`shr_user_role_privlg`
		(`urp_ur_code`, `urp_up_code`, `urp_date`, `urp_min_amt`, `urp_max_amt`)
		VALUES
		(v_ur_code, v_up_code, Now(), v_min_amt, v_max_amt);
		select max(urp_code) into v_urpcode from  `serenehrdb`.`shr_user_role_privlg`;
	else	

		set v_error_no = 3;
		select 'Unable to update record...' into v_error;
		UPDATE `serenehrdb`.`shr_user_role_privlg`
		SET `urp_min_amt` = v_min_amt, 
			`urp_max_amt` = v_max_amt
		WHERE `urp_code` = v_urpcode;
	end if;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_user_roles
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user_roles`(v_ur_code bigint,
								v_name  varchar(45),
								v_desc  varchar(1000),
								out v_urcode bigint
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, var int;
declare v_error text;
declare no_data_found boolean;
		
DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_data_found = TRUE;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 11 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation loan effective date';
		elseif v_error_no in (2,3) then #duplicate accessible
			signal sqlstate '45000'
				set message_text= v_error; #'Error validation W.E.T date';
		elseif v_error_no = 100 then
			signal sqlstate '45000'
				set message_text= v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

	if v_ur_code is null or v_ur_code = 0 then
		set v_error_no = 30;
		INSERT INTO `serenehrdb`.`shr_user_roles`
		(`ur_name`,`ur_desc`)
		VALUES
		(v_name,v_desc);
		select max(ur_code) into v_urcode from  `serenehrdb`.`shr_user_roles`;
	else	

		set v_error_no = 3;
		select 'Unable to update record...' into v_error;
		UPDATE `serenehrdb`.`shr_user_roles`
		SET `ur_name` = v_name,
		`ur_desc` = v_desc
		WHERE `ur_code` = v_ur_code;
		set v_urcode = v_ur_code;
	end if;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_user_roles_granted
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user_roles_granted`(v_usg_code bigint,
								v_usr_code  int,
								v_ur_code  int,
								v_created_by  varchar(100),
								out v_usgcode bigint
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, var, v_cnt int;
declare v_error text;
declare no_data_found boolean;
		
DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_data_found = TRUE;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 11 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation loan effective date';
		elseif v_error_no in (2,3) then #duplicate accessible
			signal sqlstate '45000'
				set message_text= v_error; #'Error validation W.E.T date';
		elseif v_error_no = 100 then
			signal sqlstate '45000'
				set message_text= v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

	if v_usg_code > 0  then
		set v_usgcode = v_usg_code;
	else
		select count(1) into v_cnt from  `serenehrdb`.`shr_user_roles_granted`
		where usg_usr_code = v_usr_code and usg_ur_code = v_ur_code;

		if v_cnt = 1 then
			select usg_code into v_usgcode from  `serenehrdb`.`shr_user_roles_granted`
			where usg_usr_code = v_usr_code and usg_ur_code = v_ur_code;
		end if;
	end if;


	if v_usgcode is null or v_usgcode = 0 then
		set v_error_no = 30;
		INSERT INTO `serenehrdb`.`shr_user_roles_granted`
		(`usg_usr_code`,`usg_ur_code`,`usg_date`,`usg_created_by`)
		VALUES
		(v_usr_code,v_ur_code,Now(),v_created_by);
		select max(usg_code) into v_usgcode from  `serenehrdb`.`shr_user_roles_granted`;
	end if;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_users
-- -----------------------------------------------------

DELIMITER $$
USE `serenehrdb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_users`(v_usr_code bigint,
								v_name  varchar(45),
								v_full_name  varchar(1000),
								v_emp_code  int,
								v_pwd_reset   varchar(5),
								out v_usrcode bigint
								)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  

declare sqlstate_code char(5) default '00000';
declare message_text TEXT;
declare mysql_error, v_error_no, var,v_empcode int;
declare v_error text;
declare no_data_found boolean;
		
DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_data_found = TRUE;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
	GET DIAGNOSTICS CONDITION 1 
		sqlstate_code = RETURNED_SQLSTATE, 
		mysql_error= MYSQL_ERRNO, 
		message_text = MESSAGE_TEXT;

	if sqlstate_code <> '00000' then
		if v_error_no = 11 then #duplicate accessible
			signal sqlstate '45000'
				set message_text='Error validation loan effective date';
		elseif v_error_no in (2,3) then #duplicate accessible
			signal sqlstate '45000'
				set message_text= v_error; #'Error validation W.E.T date';
		elseif v_error_no = 100 then
			signal sqlstate '45000'
				set message_text= v_error;
		else
			#signal sqlstate '45000' set message_text= 'Unable to save records...';
			resignal;
		end if;			
	end if;
END;

SET autocommit=0;
START TRANSACTION;

	if v_emp_code is null then
		set v_empcode = null;
	end if;

	if v_usr_code is null or v_usr_code = 0 then
		set v_error_no = 3;
		select 'Unable to create record...' into v_error;
		INSERT INTO `serenehrdb`.`shr_users`
		(`usr_name`,`usr_full_name`,`usr_emp_code`,`usr_pwd`,
		`usr_last_login`,`usr_login_atempts`,`usr_pwd_reset`)
		VALUES
		(v_name,v_full_name,v_empcode,md5(v_name),
		NULL,null,'YES');
		select max(usr_code) into v_usrcode from  `serenehrdb`.`shr_users`;
	else	
		set v_error = ' ';
		set v_error_no = 3;
		select 'Unable to update record...' into v_error;
		UPDATE `serenehrdb`.`shr_users`
		SET `usr_name` = v_name,
			`usr_full_name` = v_full_name,
			`usr_emp_code` = v_empcode,
			`usr_pwd_reset` = v_pwd_reset,
			`usr_login_atempts` = 0
		WHERE `usr_code` = v_usr_code;
		set v_usrcode = v_usr_code;

		if v_pwd_reset = 'YES' then				
			UPDATE `serenehrdb`.`shr_users`
			SET  `usr_pwd` = MD5(v_name)
			WHERE `usr_code` = v_usr_code;
		end if;
	end if;

COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `serenehrdb`.`vw_empployees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `serenehrdb`.`vw_empployees`;
USE `serenehrdb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `serenehrdb`.`vw_empployees` AS select `serenehrdb`.`shr_employees`.`emp_code` AS `emp_code`,`serenehrdb`.`shr_employees`.`emp_sht_desc` AS `emp_sht_desc`,`serenehrdb`.`shr_employees`.`emp_surname` AS `emp_surname`,`serenehrdb`.`shr_employees`.`emp_other_names` AS `emp_other_names`,`serenehrdb`.`shr_employees`.`emp_tel_no1` AS `emp_tel_no1`,`serenehrdb`.`shr_employees`.`emp_tel_no2` AS `emp_tel_no2`,`serenehrdb`.`shr_employees`.`emp_sms_no` AS `emp_sms_no`,`serenehrdb`.`shr_employees`.`emp_contract_date` AS `emp_contract_date`,`serenehrdb`.`shr_employees`.`emp_final_date` AS `emp_final_date`,`serenehrdb`.`shr_employees`.`emp_organization` AS `emp_organization`,`serenehrdb`.`shr_employees`.`emp_gender` AS `emp_gender`,`serenehrdb`.`shr_employees`.`emp_join_date` AS `emp_join_date`,`serenehrdb`.`shr_employees`.`emp_work_email` AS `emp_work_email`,`serenehrdb`.`shr_employees`.`emp_personal_email` AS `emp_personal_email` from `serenehrdb`.`shr_employees`;

-- -----------------------------------------------------
-- View `serenehrdb`.`vw_job_titlles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `serenehrdb`.`vw_job_titlles`;
USE `serenehrdb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `serenehrdb`.`vw_job_titlles` AS select `serenehrdb`.`shr_job_titles`.`jt_code` AS `jt_code`,`serenehrdb`.`shr_job_titles`.`jt_sht_code` AS `jt_sht_code`,`serenehrdb`.`shr_job_titles`.`jt_desc` AS `jt_desc` from `serenehrdb`.`shr_job_titles`;

-- -----------------------------------------------------
-- View `serenehrdb`.`vw_orgarnization_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `serenehrdb`.`vw_orgarnization_view`;
USE `serenehrdb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `serenehrdb`.`vw_orgarnization_view` AS select `a`.`org_code` AS `org_code`,`a`.`org_sht_desc` AS `org_sht_desc`,`a`.`org_desc` AS `org_desc`,`a`.`org_postal_address` AS `org_postal_address`,`a`.`org_physical_address` AS `org_physical_address`,`a`.`org_type` AS `org_type`,`a`.`org_parent_org_code` AS `org_parent_org_code`,`a`.`org_parent_org_sht_desc` AS `org_parent_org_sht_desc`,`b`.`org_desc` AS `parent_organization`,`a`.`org_wef` AS `org_wef`,`a`.`org_wet` AS `org_wet`,`a`.`org_level` AS `org_level` from (`serenehrdb`.`shr_organizations` `a` left join `serenehrdb`.`shr_organizations` `b` on((`a`.`org_parent_org_code` = `b`.`org_code`)));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
