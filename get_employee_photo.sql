DROP PROCEDURE IF EXISTS `get_employee_photo`;

DELIMITER $$

CREATE PROCEDURE `get_employee_photo`(v_emp_code bigint)
begin
SELECT  `emp_photo`
FROM `serenehrdb`.`shr_employees`
where `emp_code` = v_emp_code
;
end;

$$
DELIMITER ;

