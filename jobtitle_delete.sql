DROP PROCEDURE IF EXISTS `jobtitle_delete`;

DELIMITER $$

CREATE PROCEDURE `jobtitle_delete` (v_jt_code int)
BEGIN
DECLARE code CHAR(5) DEFAULT '00000';  
#DECLARE EXIT HANDLER FOR SQLSTATE '42000'
    #SELECT 'My Error Message v_org_code=' + cast(v_org_code as char(3));

SET autocommit=0;
START TRANSACTION;

DELETE FROM `serenehrdb`.`shr_job_titles`
WHERE `jt_code` = v_jt_code;

COMMIT;
END;

$$