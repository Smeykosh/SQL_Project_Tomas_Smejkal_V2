---nejdřív si vyjádřím průměrné ceny komodity za rok,pak si spočítám přírůstky za rok přes lag.vyjádřím přírůstky v procentec a pak si udělám průměr z ročních přírůstků
WITH yearly_prices AS (
    SELECT
        payroll_year,
        name,
        AVG(avg_price_czk) AS avg_price
    FROM t_tomas_smejkal_project_sql_primary_v2
    GROUP BY payroll_year, name
	),
	lag_prices AS (
    SELECT
        payroll_year,
        name,
        avg_price,
        LAG(avg_price) OVER (PARTITION BY name ORDER BY payroll_year) AS previous_price
    FROM yearly_prices
	),
	yearly_changes AS (
    SELECT
        payroll_year,
        name,
        ROUND(((avg_price - previous_price) / previous_price * 100 )::numeric, 2) AS yearly_change_pct
    FROM lag_prices
)

SELECT
    name,
    ROUND(AVG(yearly_change_pct), 2) AS avg_yearly_change_pct
FROM yearly_changes
WHERE yearly_change_pct IS NOT NULL
GROUP BY name
ORDER BY avg_yearly_change_pct
LIMIT 1
;

