USE [serenehrdb]
GO

/****** Object:  StoredProcedure [dbo].[get_payrolls]    Script Date: 9/17/2017 11:16:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE  [dbo].[get_payrolls] as
begin
SELECT pr_code,pr_sht_desc,pr_desc,pr_org_code,
    org_desc,pr_wef, pr_wet,
	pr_day1_hrs, pr_day2_hrs, pr_day3_hrs, pr_day4_hrs, 
	pr_day5_hrs, pr_day6_hrs, pr_day7_hrs, pr_post_payroll
FROM shr_payrolls p  left join  shr_organizations o
on (p.pr_org_code = o.org_code)
where pr_org_code = org_code

end 

GO


