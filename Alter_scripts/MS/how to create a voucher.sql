use serenehrdb
go

alter table shr_pay_elements add 
pl_dr_gl_code_FS  nvarchar(45),
pl_cr_gl_code_FS  nvarchar(45)

go

alter table shr_auth_payroll_trans add 
apt_gl_code_contra  nvarchar(45)
go

alter table shr_auth_payroll_trans add 
apt_vouher_no  nvarchar(45),
apt_vch_code  bigint
go

alter table shr_auth_payroll_trans add 
apt_fms_trn_code  bigint,  	
apt_fms_trans_no  nvarchar(45)
go

alter table shr_payrolls add 
pr_post_payroll  nvarchar(45)
go

alter table shr_auth_payroll_trans_rb add 
aptr_gl_code_contra  nvarchar(45),
aptr_voucher_no  nvarchar(45),
aptr_vch_code	bigint,
aptr_fms_trn_code	bigint,
aptr_fms_trans_no  nvarchar(45)
go


select * from shr_auth_payroll_trans_rb
select * from shr_payrolls
SELECT * FROM shr_auth_payroll_trans
SELECT concat(emp_other_names, ' ', emp_surname) FROM shr_employees
SELECT * FROM shr_employees
select * from kapsara.dbo.fms_accounts order by acc_sht_desc
--To create vouchers in FOSA or BOSA use:
--Fms_create_voucher_org  : to create the voucher master record in table=fms_Vouchers
--Fms_create_vouch_trans  : to create the voucher transaction in table=FMS_TRANSACTIONS
--Post_Voucher			  : to post a complete voucher into the GL



--update post_payroll  procedure
--update auth_payroll  procedure
--update rollback_payroll  procedure
--update_payroll	procedure
--get_payrolls		procedure
--MD5				function

