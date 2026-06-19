
--Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, 
--projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

WITH avg_price_and_payroll AS (
	SELECT 
	round(avg(avg_price_czk)::NUMERIC, 2) AS avg_price_in_year,
	round(avg(avg_payroll_value_czk)::NUMERIC, 2) AS avg_payroll_in_year,
	payroll_year
	FROM t_tomas_smejkal_project_sql_primary_v2 ttspspv  
	GROUP BY payroll_year
	)
SELECT avg_price_in_year, 
	round(((avg_price_in_year - (lag(avg_price_in_year) OVER (ORDER BY payroll_year))) / (LAG(avg_price_in_year) OVER (ORDER BY avg_price_in_year)) * 100)::NUMERIC, 2) AS price_perc_encrease,
	avg_payroll_in_year, 
	round(((avg_payroll_in_year - (lag(avg_payroll_in_year) OVER (ORDER BY payroll_year))) / (LAG(avg_payroll_in_year) OVER (ORDER BY avg_payroll_in_year)) * 100)::NUMERIC, 2) AS payroll_perc_encrease,
	avg_price_and_payroll.payroll_year,
    ttspssfv.gdp, 
    round(((gdp - (lag(gdp) OVER (ORDER BY payroll_year))) / (LAG(gdp) OVER (ORDER BY gdp)) * 100)::NUMERIC, 2) AS gdp_perc_change,
    ttspssfv.country 
FROM avg_price_and_payroll 
JOIN t_tomas_smejkal_project_sql_secondary_final_v2 ttspssfv  
	ON avg_price_and_payroll.payroll_year = ttspssfv.year 
WHERE ttspssfv.country = 'Czech Republic'
GROUP BY avg_price_in_year, avg_payroll_in_year, payroll_Year, gdp, country
ORDER BY payroll_year
;
