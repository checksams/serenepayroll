DROP PROCEDURE  IF EXISTS `serenehrdb`.`get_proll_pelements`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_proll_pelements`(v_pel_code int)
begin
SELECT `pp_code`,`pr_desc`,`pel_desc`
FROM `serenehrdb`.`shr_proll_pelements` `pp` 
left join `serenehrdb`.`shr_pay_elements` `pel` on (pp.pp_pel_code = pel.pel_code)
left join `serenehrdb`.`shr_payrolls` `pr` on (pp.pp_pr_code = pr.pr_code)
where `pp_pel_code` = v_pel_code
;
end$$
DELIMITER ;
