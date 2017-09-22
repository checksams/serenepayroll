DROP PROCEDURE IF EXISTS `cursor_loop_example`;

DELIMITER $$

CREATE PROCEDURE `cursor_loop_example`()
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
END;
$$