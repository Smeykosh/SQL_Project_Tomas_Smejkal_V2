SELECT *
FROM t_tomas_smejkal_project_sql_primary_v2 ttspspv 
;

-- minimální přirůstek v roce pomocí lag
SELECT	payroll_year , 
		name, 
		lag(round(((max(avg_price_czk) - min(avg_price_czk ))/ min(avg_price_czk) * 100 )::NUMERIC, 2)) OVER (PARTITION BY name ORDER BY payroll_year) AS total_price_perc_change_to_previous_year
FROM t_tomas_smejkal_project_sql_primary_V2
GROUP BY payroll_year, name 
HAVING payroll_year IN ('2006','2018')
ORDER BY total_price_perc_change_to_previous_year asc, payroll_year
LIMIT 26
;



