USE [serenehrdb]
GO

/****** Object:  StoredProcedure [dbo].[update_payroll]    Script Date: 9/17/2017 11:05:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE  [dbo].[update_payroll](@v_pr_code int,
								@v_sht_desc  varchar(45),
								@v_desc  varchar(100),
								@v_org_code	int,
								@v_wef	varchar(45),
								@v_wet varchar(45),
								@v_prcode int output,
								@v_day1_hrs   decimal(5,2), 
								@v_day2_hrs   decimal(5,2), 
								@v_day3_hrs   decimal(5,2), 
								@v_day4_hrs   decimal(5,2), 
								@v_day5_hrs   decimal(5,2), 
								@v_day6_hrs   decimal(5,2), 
								@v_day7_hrs   decimal(5,2),
								@v_post varchar(45)
								)as
BEGIN
declare @v_pr_wef date, @v_pr_wet date
declare @var int
declare @v_error nvarchar(1000)

SET IMPLICIT_TRANSACTIONS ON
begin try

	select @var = len(@v_wef)
	if @var >= 10 
		select @v_pr_wef = CONVERT(date, @v_wef)

	select @var = len(@v_wet)
	if @var >= 10
		select @v_pr_wet = CONVERT(date, @v_wet)

	if @v_pr_code is null or @v_pr_code = 0 
	begin try
		INSERT INTO shr_payrolls
		(pr_sht_desc,pr_desc,pr_org_code,pr_wef,pr_wet,
		 pr_day1_hrs, pr_day2_hrs, pr_day3_hrs, pr_day4_hrs, 
		 pr_day5_hrs, pr_day6_hrs, pr_day7_hrs, pr_post_payroll)
		VALUES
		(@v_sht_desc,@v_desc,@v_org_code,@v_pr_wef,@v_pr_wet,
		 @v_day1_hrs, @v_day2_hrs, @v_day3_hrs, @v_day4_hrs, 
		 @v_day5_hrs, @v_day6_hrs, @v_day7_hrs, @v_post)
		select @v_prcode = max(pr_code) from  shr_payrolls
	end try	
	begin catch
		set @v_error = 'Error creating payroll record...' + ERROR_MESSAGE();
		RAISERROR (@v_error, 16,1)
	end catch
	else	
	begin try
		UPDATE shr_payrolls
		SET pr_sht_desc = @v_sht_desc,
			pr_desc = @v_desc,
			pr_org_code = @v_org_code,
			pr_wef = @v_pr_wef,
			pr_wet = @v_pr_wet,
			pr_day1_hrs = @v_day1_hrs, 
			pr_day2_hrs = @v_day2_hrs, 
			pr_day3_hrs = @v_day3_hrs, 
			pr_day4_hrs = @v_day4_hrs, 
			pr_day5_hrs = @v_day5_hrs, 
			pr_day6_hrs = @v_day6_hrs, 
			pr_day7_hrs = @v_day7_hrs,
			pr_post_payroll = @v_post
		WHERE pr_code = @v_pr_code;
		set @v_prcode = @v_pr_code;
	end try
	begin catch
		set @v_error = 'Error updating payroll record...' + ERROR_MESSAGE();
		RAISERROR (@v_error, 16,1)
	end catch
	COMMIT
end try
BEGIN CATCH
	set @v_error = 'Error...' + ERROR_MESSAGE();
	ROLLBACK
	RAISERROR (@v_error, 16,1)
END CATCH
END 

GO


