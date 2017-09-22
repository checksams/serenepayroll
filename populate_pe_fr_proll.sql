DROP PROCEDURE IF EXISTS `populate_pe_fr_proll`;

DELIMITER $$

CREATE PROCEDURE `populate_pe_fr_proll`(v_pel_code int,
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
END;
$$