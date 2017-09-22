DROP PROCEDURE IF EXISTS `populate_prd_pay_elements`;

DELIMITER $$

CREATE PROCEDURE `populate_prd_pay_elements`(v_pr_code int,
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
END;
$$