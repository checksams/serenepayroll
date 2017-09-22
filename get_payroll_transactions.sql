DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_payroll_transactions`;

DELIMITER $$
CREATE PROCEDURE `get_payroll_transactions`(v_pr_code int,
											v_status varchar(50))
begin
SELECT `tr_code`, `tr_type`, `tr_date`, `tr_done_by`,`tr_pr_month`, `tr_pr_year`
FROM `serenehrdb`.`shr_transactions` tr 
where tr_pr_code = v_pr_code and `tr_authorised` = v_status
;
end$$
DELIMITER ;

