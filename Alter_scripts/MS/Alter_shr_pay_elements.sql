use serenehrdb_kaps
go

alter table shr_pay_elements add 
pl_dr_gl_code_FS  nvarchar(45),
pl_cr_gl_code_FS  nvarchar(45)

go

--To create vouchers in FOSA or BOSA use:
--Fms_create_voucher_org  : to create the voucher master record in table=fms_Vouchers
--Fms_create_vouch_trans  : to create the voucher transaction in table=FMS_TRANSACTIONS
--Post_Voucher			  : to post a complete voucher into the GL

