DROP PROCEDURE IF EXISTS `employee_delete`;

DELIMITER $$

CREATE PROCEDURE `employee_delete` (v_emp_code int)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

SET autocommit=0;
START TRANSACTION;

DELETE FROM `serenehrdb`.`shr_employees`
WHERE `emp_code` = v_emp_code;

commit;
end;

$$
