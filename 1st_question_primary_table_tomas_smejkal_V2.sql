---Zobrazení přírůstků mezd v mezi lety 2006 a 2018

SELECT 	avg_payroll_value_CZK,
		industry_name, 
		payroll_year,
		LAG(avg_payroll_value_CZK) OVER (PARTITION BY industry_name ORDER BY payroll_year) AS payroll_in_previous_year,
		avg_payroll_value_CZK - LAG(avg_payroll_value_CZK) OVER (PARTITION BY  industry_name ORDER BY payroll_year) AS difference
FROM t_tomas_smejkal_project_sql_primary_v2
GROUP BY industry_name, payroll_year, avg_payroll_value_czk
HAVING payroll_year IN ('2006','2018')
ORDER BY industry_name, payroll_year
;





--Zobrazení přírůstků mezd v odvětvích v všech letech mezi lety 2006 a 2018--dodatečný select
SELECT 	avg(avg_payroll_value_CZK) AS avg_industry_payroll_in_year,
		industry_name, 
		payroll_year,
		LAG(avg(avg_payroll_value_CZK)) OVER (PARTITION BY industry_name ORDER BY payroll_year) AS payroll_in_previous_year,
		avg(avg_payroll_value_CZK) - LAG(avg(avg_payroll_value_CZK)) OVER (PARTITION BY  industry_name ORDER BY payroll_year) AS difference
FROM t_tomas_smejkal_project_sql_primary_V2
GROUP BY industry_name, payroll_year
ORDER BY industry_name, payroll_year
;
