
--Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

WITH temp_avg_prices AS (
	SELECT 
		round((avg(avg_price_czk))::NUMERIC, 2) AS avg_payroll_year_price,
		payroll_year
	FROM t_tomas_smejkal_project_sql_primary_V2	
	GROUP BY payroll_year
	),
	temp_avg_payroll AS (
	SELECT
		round((avg(avg_payroll_value_czk))::NUMERIC, 2) AS avg_payroll_year_value,
		payroll_year
	FROM t_tomas_smejkal_project_sql_primary_V2
	GROUP BY payroll_year
	)
SELECT 
	temp_avg_prices.payroll_year,
	temp_avg_prices.avg_payroll_year_price,
	round(((avg_payroll_year_price - LAG(avg_payroll_year_price) OVER (ORDER BY temp_avg_payroll.payroll_year)) / (LAG(temp_avg_prices.avg_payroll_year_price) OVER (ORDER BY temp_avg_prices.payroll_year)) * 100)::NUMERIC, 2) AS price_perc_growth,
	temp_avg_payroll.avg_payroll_year_value,
	round(((avg_payroll_year_value - LAG(avg_payroll_year_value) OVER (ORDER BY temp_avg_payroll.payroll_year)) / (LAG(temp_avg_payroll.avg_payroll_year_value) OVER (ORDER BY temp_avg_payroll.avg_payroll_year_value)) * 100)::NUMERIC, 2) AS payroll_perc_growth
FROM temp_avg_prices
JOIN temp_avg_payroll
	ON temp_avg_prices.payroll_year = temp_avg_payroll.payroll_year
	;
