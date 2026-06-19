
--Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?213

SELECT round(((sum(avg_payroll_value_czk) / count(avg_payroll_value_czk)) / (sum(avg_price_czk) / count(avg_price_czk)))::NUMERIC, 2) AS products_to_buy_in_payroll_year, 
		name, payroll_year,
		round(((sum(avg_payroll_value_czk) / count(avg_payroll_value_czk)))::NUMERIC, 2) AS avg_payroll_value_czk_in_payroll_year ,
		round((sum(avg_price_czk) / count(avg_price_czk))::NUMERIC, 2) AS avg_product_price_in_payroll_year		
FROM t_tomas_smejkal_project_sql_primary_V2
	WHERE name in ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
GROUP BY name, payroll_year 
	HAVING payroll_year in(2018, 2006)
ORDER BY payroll_year
;


SELECT *
FROM t_tomas_smejkal_project_sql_primary_V2
;


