USE [serenehrdb]
GO

/****** Object:  StoredProcedure [dbo].[calc_taxes]    Script Date: 2/10/2017 9:48:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE  [dbo].[calc_taxes](@v_tx_code  int,
							@v_date		datetime,
							@v_amt_to_tax   decimal(25,5),
							@v_tax_amt    decimal(25,5) output
							) as
BEGIN
  declare @v_error nVARCHAR(1000)

  DECLARE @c_txr_rate int,@c_txr_div_factr int,@c_txr_range_from int, @c_txr_range_to int,
			@v_cnt int,@cr_txr_rate int,@cr_txr_div_factr int,
			@cr_txr_range_from int, @cr_txr_range_to INT
  
  DECLARE @v_tax_rate INT
  DECLARE @c_emp_surname nVARCHAR(150)
  DECLARE @c_rate_type nVARCHAR(150),@v_rate_type nVARCHAR(150)
  DECLARE @v_range_amnt decimal(25,5)

  DECLARE @cursor_tax CURSOR 
  set @cursor_tax = cursor FAST_FORWARD for
	select txr_rate, txr_div_factr,txr_range_from, txr_range_to
	from serenehrdb.shr_taxes  t left join serenehrdb.shr_tax_rates r
	on t.tx_code = r.txr_tx_code 
	where t.tx_code = v_tx_code and tx_rate_type ='FIXED'
	and ((v_amt_to_tax >= txr_range_from) AND (v_amt_to_tax < txr_range_to))
	--and v_dt between tx_wef and  tx_wet
	order by txr_range_to
	
  DECLARE @cursor_abs_steprange_tax CURSOR 
  set @cursor_abs_steprange_tax = cursor fast_forward FOR 
	select txr_rate, txr_div_factr,txr_range_from, txr_range_to
	from serenehrdb.shr_taxes  t left join serenehrdb.shr_tax_rates r
	on t.tx_code = r.txr_tx_code 
	where t.tx_code = v_tx_code and tx_rate_type IN ('STEP RANGE')
	and ((v_amt_to_tax > txr_range_from) AND (v_amt_to_tax <= txr_range_to))
	--and v_dt between tx_wef and  tx_wet
	order by txr_range_to
	
  DECLARE @cursor_steprange_tax CURSOR  
  set @cursor_steprange_tax = cursor fast_forward FOR 
	select txr_rate, txr_div_factr,txr_range_from, txr_range_to
	from serenehrdb.shr_taxes  t left join serenehrdb.shr_tax_rates r
	on t.tx_code = r.txr_tx_code 
	where t.tx_code = v_tx_code and tx_rate_type IN ('STEP RANGE')
	and txr_range_to < v_amt_to_tax
	--and v_dt between tx_wef and  tx_wet
	order by txr_range_to

SET IMPLICIT_TRANSACTIONS ON
	select @v_error = 'Error...'
set @v_cnt = 0
set @v_tax_amt = 0

	select @c_rate_type = tx_rate_type
	from shr_taxes 
	where tx_code = @v_tx_code --and v_dt between tx_wef and  tx_wet
	

	IF (@c_rate_type = 'FIXED')
	BEGIN
			OPEN @cursor_tax		
				FETCH NEXT FROM @cursor_tax									
				INTO @c_txr_rate,@c_txr_div_factr,@c_txr_range_from, @c_txr_range_to
				WHILE @@FETCH_STATUS = 0
				begin
					set @v_cnt = @v_cnt + 1;

					IF (@c_rate_type ='FIXED') 
					begin
						--tax tariff rate is a fixed type
						IF (@c_txr_div_factr > 1) 
						BEGIN
							--this is not a fixed amount
							SET @v_tax_amt = (( @c_txr_rate / @c_txr_div_factr) * @v_amt_to_tax)
							set @v_tax_rate = @c_txr_rate
							set @v_rate_type = @c_rate_type
						END
						ELSE
						BEGIN
							--this is  a fixed amount
							set @v_tax_amt =  (@c_txr_rate ) ;
							set @v_tax_rate = @c_txr_rate;
							set @v_rate_type = @c_rate_type;
						END
						--IF NVL(@v_tax_amt,0) < c1rec.trt_min_amt THEN
						--	@v_tax_amt = c1rec.trt_min_amt;
						--END IF;
					end	
				FETCH NEXT FROM @cursor_tax									
				INTO @c_txr_rate,@c_txr_div_factr,@c_txr_range_from, @c_txr_range_to
				end 
			CLOSE @cursor_tax
			DEALLOCATE @cursor_tax
	END
	ELSE IF (@c_rate_type = 'STEP RANGE') 
	BEGIN	
			set @v_cnt = 0
			OPEN @cursor_abs_steprange_tax
				FETCH NEXT FROM @cursor_abs_steprange_tax 
				INTO @c_txr_rate,@c_txr_div_factr,@c_txr_range_from, @c_txr_range_to
				WHILE @@FETCH_STATUS = 0
				BEGIN
					set @v_cnt = @v_cnt + 1
					set @v_range_amnt = 0

					OPEN @cursor_steprange_tax
						FETCH  NEXT FROM @cursor_steprange_tax 
						INTO @cr_txr_rate,@cr_txr_div_factr,@cr_txr_range_from, @cr_txr_range_to
						WHILE @@FETCH_STATUS = 0
						BEGIN

							set @v_cnt = @v_cnt + 1

							IF (@c_rate_type ='STEP RANGE') 
							BEGIN
								-- tax tariff rate is a fixed type
								IF (@cr_txr_div_factr > 1) 
								BEGIN
									--this is not a fixed amount
									SET @v_tax_amt = @v_tax_amt + round(( @cr_txr_rate / @cr_txr_div_factr) * (@cr_txr_range_to-@cr_txr_range_from),4)
									set @v_range_amnt = @v_range_amnt + (@cr_txr_range_to-@cr_txr_range_from)
									set @v_tax_rate = @cr_txr_rate
									set @v_rate_type =@c_rate_type
								END
								ELSE
								BEGIN
									--this is  a fixed amount
									set @v_tax_amt =  (@cr_txr_rate ) 
									set @v_tax_rate = @cr_txr_rate
									set @v_rate_type = @c_rate_type
								END
								--IF NVL(v_tax_amt,0) < c1rec.trt_min_amt THEN
								--	v_tax_amt := c1rec.trt_min_amt;
								--END IF;
							END
						END
					CLOSE @cursor_steprange_tax
					DEALLOCATE @cursor_steprange_tax
				
					IF (@c_txr_div_factr > 1)
					BEGIN
						set @v_tax_amt = @v_tax_amt + ROUND((@v_amt_to_tax - @v_range_amnt) * (@c_txr_rate / @c_txr_div_factr),4)
						set @v_rate_type 	= @c_rate_type
					END
					ELSE
					BEGIN
						set @v_tax_amt 		= @v_tax_amt + (@c_txr_rate )
						set @v_tax_rate 	= NULL
						set @v_rate_type 	= @c_rate_type
					END
							
						/*
						set v_error_no = 1;
						select concat('Calc_tax v_range_amount=',v_range_amnt, ' v_tax_amt=', v_tax_amt, 
								' v_amt_to_tax=',v_amt_to_tax,' c_txr_rate=',c_txr_rate,' c_txr_div_factr=',c_txr_div_factr,
								' lastrange=',ROUND((v_amt_to_tax - v_range_amnt) * (c_txr_rate / c_txr_div_factr))) into v_error;
						call raise_error();*/
				END
			CLOSE @cursor_abs_steprange_tax
			DEALLOCATE @cursor_abs_steprange_tax
	END
	if (@v_tax_amt is not null) 
	begin
		set @v_tax_amt = round(@v_tax_amt,0)
	end 
END 

GO


