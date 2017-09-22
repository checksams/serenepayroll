select now(),
case when WEEKDAY(now()) = 7 then 1
	when WEEKDAY(now()) = 0 then 2
	when WEEKDAY(now()) = 1 then 3
	when WEEKDAY(now()) = 2 then 4
	when WEEKDAY(now()) = 3 then 5
	when WEEKDAY(now()) = 4 then 6
	when WEEKDAY(now()) = 5 then 7
	when WEEKDAY(now()) = 6 then 0 end as day,
FROM_DAYS(735963) frdays,
STR_TO_DATE('01/01/2015','%d/%m/%Y') date,
last_day(STR_TO_DATE('01/01/2015','%d/%m/%Y'))last_date_of_month,
weekday(last_day(STR_TO_DATE('03/01/2015','%d/%m/%Y')))weekday,
Day(last_day(STR_TO_DATE('01/01/2015','%d/%m/%Y')))last_day_of_month
	

	