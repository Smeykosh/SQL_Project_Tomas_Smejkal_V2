

CREATE TABLE t_tomas_smejkal_project_sql_secondary_final_V2 AS 
	SELECT 
		economies.country, 
		economies.YEAR, 
		gdp, 
		economies.population, 
		gini
	FROM economies 
	JOIN countries
		ON economies.country = countries.country
	WHERE countries.continent = 'Europe' 
	AND economies.YEAR BETWEEN 2006 AND 2018 
	GROUP BY economies.country, economies.YEAR, economies.gdp, economies.population, economies.gini
	;

SELECT *
FROM t_tomas_smejkal_project_sql_secondary_final_v2 ttspssfv 
ORDER BY year
;