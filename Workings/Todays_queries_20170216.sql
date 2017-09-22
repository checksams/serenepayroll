/*
select * from shr_payrolls;
select * from shr_prd_pay_elements;
select * from shr_pay_elements;
*/
select --convert(date,
		(convert(nvarchar,tr_pr_month)
		+ convert(nvarchar,tr_pr_year)) as dt
		  from shr_transactions;
select CONVERT(DATETIME,
	CONVERT(nvarchar,tr_pr_year)+RIGHT('00'+CONVERT(nvarchar, tr_pr_month),2) + '28',
		 102) as dt
		  from shr_transactions;
		  SELECT convert(date, '01/01/2000', 103);
go
SELECT RIGHT('0' + DATENAME(DAY, SYSDATETIME()), 2) 
+ ' ' + DATENAME(MONTH, SYSDATETIME())
+ ' ' + DATENAME(YEAR, SYSDATETIME()) AS [DD Month YYYY]
go

SELECT  DATENAME(MONTH, SYSDATETIME())
+ ' ' + DATENAME(YEAR, SYSDATETIME()) AS [DD Month YYYY]

go

SELECT  DATENAME(MONTH, convert(datetime,convert(nvarchar,(201701 + 1))+'28'))
							   + ' ' + DATENAME(YEAR, convert(datetime,convert(nvarchar,(201701 + 1))+'28'))
go

	SELECT DATEDIFF(day,'2014-06-05','2014-08-05') AS DiffDate
	SELECT DATEDIFF(month,'2014-06-05','2014-08-05') AS DiffDate
	SELECT DATEDIFF(week,'2014-06-05','2014-08-05') AS DiffDate
	go

                           -- <!--<asp:MenuItem NavigateUrl="~/aspxAuthorisePayroll.aspx" Text="Authorise Payroll" Selectable="false"/> -->
							
--Getting taxable pay
select sum(q1.amt) as amt from (
	select sum((CASE when pel_deduction='YES' then -1 else 1 end) * ppe_amt) as amt 
	from shr_prd_pay_elements ppe
	left join shr_pay_elements pel on (pel.pel_code=ppe.ppe_pel_code)
	where ppe_emp_code = 1 and  ppe_tr_code = 1 and pel_taxable='YES'
	union
	select sum((CASE when pel_deduction='YES' then -1 else 1 end) * ppe_ded_amt_b4_tax) as amt 
	from shr_prd_pay_elements ppe
	left join shr_pay_elements pel on (pel.pel_code=ppe.ppe_pel_code)
	where ppe_emp_code = 1  and  ppe_tr_code = 1
	) q1;

	SELECT ppe_code,pel_sht_desc,pel_desc,pel_taxable,
		pel_deduction,pel_depends_on,pel_type,round(ppe_amt,2)ppe_amt,
		round(ppe_ded_amt_b4_tax,2)ppe_ded_amt_b4_tax,
		round(ppe_val_of_benfit_amt,2)ppe_val_of_benfit_amt,
		round(ppe_ot_hours,2)ppe_ot_hours,
		emp_sht_desc, emp_other_names+' '+emp_surname as emp_name,
		emp_code,pel_order
	FROM shr_prd_pay_elements  ppe
	left join shr_employees emp on (ppe.ppe_emp_code=emp.emp_code)
	left join shr_pay_elements pel on (pel.pel_code=ppe.ppe_pel_code)
	where emp_code = emp_code
	and emp_pr_code = 6 --@v_pr_code
	and ppe_tr_code = 1 --@v_tr_code
	union all 
	SELECT ppe_code,pel_sht_desc+' Relief' pel_sht_desc,pel_desc+' Relief' pel_desc,pel_taxable,
		pel_deduction,pel_depends_on,'STATEMENT ITEM' pel_type,round(ppe_ded_amt_b4_tax,2)ppe_amt,
		round(ppe_ded_amt_b4_tax,2)ppe_ded_amt_b4_tax,
		round(ppe_val_of_benfit_amt,2)ppe_val_of_benfit_amt,
		round(ppe_ot_hours,2)ppe_ot_hours,
		emp_sht_desc, emp_other_names+' '+emp_surname as emp_name,
		emp_code,pel_order
	FROM shr_prd_pay_elements  ppe
	left join shr_employees emp on (ppe.ppe_emp_code=emp.emp_code)
	left join shr_pay_elements pel on (pel.pel_code=ppe.ppe_pel_code)
	where emp_code = emp_code
	and emp_pr_code = 6 --@v_pr_code
	and ppe_tr_code = 1 --@v_tr_code
	and ppe_ded_amt_b4_tax > 0
	union all
	SELECT ppe_code,pel_sht_desc,pel_desc,pel_taxable,
		pel_deduction,pel_depends_on,'STATEMENT ITEM' pel_type,round(ppe_amt,2)ppe_amt,
		round(ppe_ded_amt_b4_tax,2)ppe_ded_amt_b4_tax,
		round(ppe_val_of_benfit_amt,2)ppe_val_of_benfit_amt,
		round(ppe_ot_hours,2)ppe_ot_hours,
		emp_sht_desc, emp_other_names+' '+emp_surname as emp_name,
		emp_code,pel_order
	FROM shr_prd_pay_elements  ppe
	left join shr_employees emp on (ppe.ppe_emp_code=emp.emp_code)
	left join shr_pay_elements pel on (pel.pel_code=ppe.ppe_pel_code)
	where emp_code = emp_code
	and emp_pr_code = 6 --@v_pr_code
	and ppe_tr_code = 1 --@v_tr_code
	and pel_sht_desc = 'PRELIEF'
	order by pel_order,pel_deduction,pel_sht_desc