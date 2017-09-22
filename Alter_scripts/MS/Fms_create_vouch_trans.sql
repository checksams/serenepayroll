USE [KAPSARA]
GO

/****** Object:  StoredProcedure [dbo].[Fms_create_vouch_trans]    Script Date: 9/17/2017 11:51:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










ALTER     procedure [dbo].[Fms_create_vouch_trans](
	@TRN_CODE int output,
	@TRN_TRANSCODE nvarchar(30) output,
	@TRN_DRCR nvarchar(5),
	@TRN_AMOUNT numeric(18, 2),
	@VCH_CODE int,
	@TRN_DESCRIPTION nvarchar(200),
	@TRN_ACC_CODE int,
	@TRN_GLACC nvarchar(15)
)
as
declare @SCLS_CODE int, @v_err_msg nvarchar(1000)
declare @Trans_no nvarchar(30), @csr_Truns cursor
begin
	if @TRN_DESCRIPTION = ''
	begin
		set @v_err_msg = 'Pass the transaction description to proceed.'
		RAISERROR (@v_err_msg, 16, 1)
		ROLLBACK TRANSACTION	
		return	
	end
	if isnull(@VCH_CODE,0) = 0
	begin
		set @v_err_msg = 'Pass the transaction voucher number to proceed.'
		RAISERROR (@v_err_msg, 16, 1)
		ROLLBACK TRANSACTION	
		return	
	end
	if isnull(@TRN_AMOUNT,0) = 0
	begin
		set @v_err_msg = 'Pass the transaction amount to proceed.'
		RAISERROR (@v_err_msg, 16, 1)
		ROLLBACK TRANSACTION	
		return	
	end
	
	if @TRN_TRANSCODE = ''
		select @Trans_no=convert(nvarchar(50),max(cast(isnull(TRN_TRANSCODE,'1') as int))+1) from FMS_TRANSACTIONS where TRN_VCH_CODE = @VCH_CODE
	else
		set @Trans_no=@TRN_TRANSCODE
        SELECT     @SCLS_CODE=ACC_SCLS_CODE FROM  FMS_ACCOUNTS where acc_code=@TRN_ACC_CODE 

        if isnull(@SCLS_CODE,0)=0 
          begin
		set @v_err_msg = 'Invalid account passed.'
		RAISERROR (@v_err_msg, 16, 1)
		ROLLBACK TRANSACTION	
		return	
	  end
            
        
	if isnull(@TRN_DRCR,'C') <> 'D' 
		SET @TRN_DRCR = 'C'
	if isnull(@TRN_CODE,0) <> 0 
		begin
			UPDATE dbo.FMS_TRANSACTIONS
			SET 	TRN_DRCR = @TRN_DRCR,
				TRN_AMOUNT = @TRN_AMOUNT, 
				TRN_DESCRIPTION = @TRN_DESCRIPTION, 
				TRN_GLACC = @TRN_GLACC, 
				TRN_SCLS_CODE = @SCLS_CODE,
				TRN_ACC_CODE = @TRN_ACC_CODE
			WHERE TRN_CODE = @TRN_CODE
		end
	else
		begin
			INSERT INTO dbo.FMS_TRANSACTIONS(TRN_TRANSCODE, TRN_DRCR,TRN_AMOUNT, 
			TRN_VCH_CODE, TRN_DESCRIPTION, TRN_GLACC, TRN_SCLS_CODE,TRN_ACC_CODE)
			VALUES(@Trans_no,@TRN_DRCR,@TRN_AMOUNT, 
			@VCH_CODE, @TRN_DESCRIPTION, @TRN_GLACC,@SCLS_CODE ,@TRN_ACC_CODE)
			set @TRN_TRANSCODE = @Trans_no
		end
	set @TRN_CODE = scope_identity()
	set @TRN_TRANSCODE = scope_identity()
end 








GO

