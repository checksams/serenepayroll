DROP PROCEDURE IF EXISTS `calc_taxes`;

DELIMITER $$

CREATE PROCEDURE `calc_taxes`(v_tx_code  int,
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
								SET v_tax_amt = v_tax_amt + round(( cr_txr_rate / cr_txr_div_factr) * (cr_txr_range_to-cr_txr_range_from));
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
					set v_tax_amt = v_tax_amt + ROUND((v_amt_to_tax - v_range_amnt) * (c_txr_rate / c_txr_div_factr));
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
END;
$$