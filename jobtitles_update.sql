DROP PROCEDURE IF EXISTS `jobtitles_update`;

DELIMITER $$

CREATE PROCEDURE `jobtitles_update` (in v_jt_code int,
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

END;

$$
