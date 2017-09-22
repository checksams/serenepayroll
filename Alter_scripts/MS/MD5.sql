USE [serenehrdb]
GO

/****** Object:  UserDefinedFunction [dbo].[MD5]    Script Date: 9/17/2017 11:21:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


	ALTER FUNCTION [dbo].[MD5]
	(
	  @value nvarchar(255)
	)
	RETURNS nvarchar(32)
	AS
	BEGIN
	  RETURN SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5', @value)),3,32);
	END

GO


