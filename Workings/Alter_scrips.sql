use serenehrdb
go
--Added c# package using nuget
--PM> Install-Package EPPlus 
--For managing excel files

alter table [dbo].[shr_pay_elements] add 
[pel_dr_gl_code] [nvarchar](45),
[pel_cr_gl_code] [nvarchar](45)

go

alter table [dbo].shr_prd_pay_elements add 
[ppe_dr_gl_code] [nvarchar](45),
[ppe_cr_gl_code] [nvarchar](45)

go
alter table [dbo].shr_transactions add 
[tr_payroll_period] decimal(30)

update shr_transactions set tr_payroll_period =
convert(decimal, convert(nvarchar,tr_pr_year) + right('0'+ convert(nvarchar,tr_pr_month),2))
go

CREATE TABLE [dbo].[shr_auth_payroll_trans](
	apt_code   bigint IDENTITY(1,1) NOT NULL,
	apt_tr_code [bigint] NOT NULL,
	apt_pr_code [bigint] NOT NULL,
	apt_emp_code [bigint] NOT NULL,
	apt_pel_code [bigint] NOT NULL,
	apt_ppe_code [bigint] NOT NULL,
	apt_pel_desc [nvarchar](100) NOT NULL,
	apt_dr_cr [nvarchar](1) NOT NULL,
	apt_gl_code	nvarchar(45) NOT NULL,
	apt_amt decimal(23,5) NOT NULL,
	apt_date datetime DEFAULT getdate()
 CONSTRAINT [apt_code_pk] PRIMARY KEY CLUSTERED 
(
	[apt_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[shr_auth_payroll_trans_rb](
	aptr_code   bigint IDENTITY(1,1) NOT NULL,
	aptr_apt_code   bigint,
	aptr_tr_code [bigint] NOT NULL,
	aptr_pr_code [bigint] NOT NULL,
	aptr_emp_code [bigint] NOT NULL,
	aptr_pel_code [bigint] NOT NULL,
	aptr_ppe_code [bigint] NOT NULL,
	aptr_pel_desc [nvarchar](100) NOT NULL,
	aptr_dr_cr [nvarchar](1) NOT NULL,
	aptr_gl_code	nvarchar(45) NOT NULL,
	aptr_amt decimal(23,5) NOT NULL,
	aptr_date datetime,
	aptr_rb_date datetime DEFAULT getdate(),
	aptr_rollback_by	nvarchar(45) not null
 CONSTRAINT [aptr_code_pk] PRIMARY KEY CLUSTERED 
(
	[aptr_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

alter table shr_employees add
emp_status	nvarchar(45) default 'ACTIVE' NOT NULL
GO
alter table shr_employees add
emp_payroll_allowed	nvarchar(5) default 'YES' NOT NULL
GO

--=============================Working Area===================================
--=============================Credential Management==========================
Select usr_name,usr_login_atempts,usr_pwd,dbo.MD5(('username'))CorrectDecryption,
SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5', ('username'))),3,32)CorrectDecryption2
 from shr_users  

User=Test , Password=testing
User=Admin, Password=administrator
User=User, passowrd=username
--========================End Credential Management==========================




SELECT * FROM shr_employees

select pel_code,ppe_code,pel_sht_desc,pel_desc,ppe_amt,
pel_dr_gl_code, pel_cr_gl_code , pel_deduction
from shr_prd_pay_elements ppe
left join shr_employees emp on (ppe.ppe_emp_code=emp.emp_code)
left join shr_pay_elements pel on (pel.pel_code=ppe.ppe_pel_code)
left join shr_transactions tr on (tr.tr_code=ppe.ppe_tr_code)
where tr_code = 1 and emp_code = 1
and (pel_type <> 'STATEMENT ITEM' or pel_sht_desc='NP')
order by emp_code,pel_order	
GO

select *
from shr_pay_elements
where (pel_type <> 'STATEMENT ITEM' or pel_sht_desc in ('GP','NP'))
order by pel_order	

GO


select * from shr_auth_payroll_trans where apt_tr_code=1 and apt_emp_code=1

select * from shr_transactions 
where tr_pr_code = 6
and tr_pr_year >= 2017
and tr_pr_month >= 1
and tr_authorised = 'YES'

	select count(1) from shr_transactions tr 
	where tr_type = 'PAYROLL'
	and tr_pr_month >= 1 and tr_pr_year >= 2017
	and tr_pr_code = 6
	go

	select 
	CONVERT(int,
	CONVERT(nvarchar,tr_pr_year)+RIGHT('00'+CONVERT(nvarchar, tr_pr_month),2)
		 ) as dt
	from shr_transactions tr 
	where tr_type = 'PAYROLL'
	and tr_pr_month >= 1 and tr_pr_year >= 2017
	and tr_pr_code = 6
	and tr_authorised = 'YES'
	
		select @v_last_period= max(
					CONVERT(int,
					CONVERT(nvarchar,tr_pr_year)+RIGHT('00'+CONVERT(nvarchar, tr_pr_month),2)
						 )  )
		from shr_transactions tr 
		where tr_type = 'PAYROLL'
		--and tr_pr_month >= @v_month and tr_pr_year >= @v_year
		and tr_pr_code = @v_pr_code
		and tr_authorised = 'YES'
	
	SELECT DATEDIFF(day,'2014-06-05','2014-08-05') AS DiffDate
	SELECT DATEDIFF(d,'2014-06-05','2014-08-05') AS DiffDate
	SELECT DATEDIFF(month,'2014-06-05','2014-08-05') AS DiffDate
	SELECT DATEDIFF(week,'2014-06-05','2014-08-05') AS DiffDate
go

select * from shr_transactions tr where tr_code <> 1
go

