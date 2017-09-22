DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_user_privillages`;

DELIMITER $$
CREATE PROCEDURE `get_user_privillages`()
begin
SELECT `up_code`,`up_name`,`up_desc`, 
	round(`up_min_amt`)up_min_amt,
	round(`up_max_amt`)up_max_amt,
	up_type
FROM `serenehrdb`.`shr_user_privillages`;

end$$
DELIMITER ;

