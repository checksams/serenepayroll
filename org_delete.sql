DROP PROCEDURE IF EXISTS `org_delete`;

DELIMITER $$

CREATE PROCEDURE `org_delete` (v_org_code int)
BEGIN
DELETE FROM `serenehrdb`.`shr_organizations`
WHERE `org_code` = v_org_code;
END;

$$


