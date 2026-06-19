# SQL Projekt – Analýza mezd a cen potravin v České republice

**Autor**: Tomáš Smejkal

**ENGETO Data Academy**

**Datum:** 22. 4. 2025

> Tato verze byla upravena na základě zpětné vazby z prvního odevzdání projektu._
-------------------------

# Obsah

1. Úvod
   
2. Zadání projektu
   
3. Datové zdroje

4. Analýza datových sad

5. Tvorba finálních tabulek

6. Výzkumné otázky a výsledky

7. Závěr


----------------------


# 1. Úvod:

Cílem projektu je procvičení a ověření znalostí SQL získaných během kurzu ENGETO Data Academy.

Projekt byl zpracován v databázovém systému PostgreSQL za použití nástroje DBeaver. 

Datové sady byly poskytnuty společností ENGETO a vycházejí z veřejně dostupných dat Českého statistického úřadu.

# 2. Zadání projektu

Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, 

že se pokusíte odpovědět na pár definovaných výzkumných otázek, 

které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, 

na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. 

Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.


Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání 
dostupnosti potravin na základě průměrných příjmů za určité časové období.

Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, 
jako primární přehled pro ČR.

﻿

# 3. Datové zdroje

## Primární tabulky:

*czechia_payroll* – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.

*czechia_payroll_calculation* – Číselník kalkulací v tabulce mezd.

*czechia_payroll_industry_branch* – Číselník odvětví v tabulce mezd.

*czechia_payroll_unit* – Číselník jednotek hodnot v tabulce mezd.

*czechia_payroll_value_type* – Číselník typů hodnot v tabulce mezd.

*czechia_price* – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.

*czechia_price_category* – Číselník kategorií potravin, které se vyskytují v našem přehledu.

## Číselníky sdílených informací o ČR:

czechia_region – Číselník krajů České republiky dle normy CZ-NUTS 2.
czechia_district – Číselník okresů České republiky dle normy LAU.

## Dodatečné tabulky:

countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.

economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.
﻿

## Výzkumné otázky:

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
﻿

## Výstupy z projektu

Pomozte kolegům s daným úkolem. Výstupem by měly být dvě tabulky v databázi, ze kterých se požadovaná data dají získat. Tabulky pojmenujte ***t_{jmeno}_{prijmeni}_project_SQL_primary_final*** (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) a ***t_{jmeno}_{prijmeni}_project_SQL_secondary_final (pro dodatečná data o dalších evropských státech)***.

Dále připravte sadu SQL, které z vámi připravených tabulek získají datový podklad k odpovězení na vytyčené výzkumné otázky. Pozor, otázky/hypotézy mohou vaše výstupy podporovat i vyvracet! Záleží na tom, co říkají data.

Na svém GitHub účtu vytvořte veřejný repozitář, kam uložíte všechny informace k projektu – hlavně SQL skript generující výslednou tabulku, popis mezivýsledků (průvodní listinu) ve formátu markdown (.md) a informace o výstupních datech (například kde chybí hodnoty apod.).

Neupravujte data v primárních tabulkách! Pokud bude potřeba transformovat hodnoty, dělejte tak až v tabulkách nebo pohledech, které si nově vytváříte.

*******

# 4. Analýza datových sad

## 4.1 Analýza dat pro tvorbu primární tabulky 

**Tabulka** czechia_payroll**: 

**Zdroj dat** ČSÚ  ( https://csu.gov.cz/ )

**Technická dokumentace:** 

zdrojové datové sady : https://csu.gov.cz/docs/107508/a7309d97-c5be-4ef4-de2f-d2962e385b93/110079-22dds.htm

**Popis sloupců:**

id = id záznamu  unikátní identifikátor údaje Veřejné databáze ČSÚ

value 	
		- může být buď mzda v Kč.

	    - nebo počet zaměstnanců. 
	
Value_type_code 	(kódy také vyjádřené v tabulce **czechia_payroll_value_type**)

					- určuje jestli se zobrazí mzda 5958.

			        - nebo jestli počet zaměstnanců kod 316.

Unit_code 			(kódy vyjádřené také v tabulce **czechia_payroll_unit**)

					- jeslti se zobrazí cena v kč - tedy kod 200

		      		- nebo jestli je to počet zaměstnanců v tis - kod 80403

Calculation_code  (kódy vyjádřené také v tabulce **czechia_payroll_calculation**)

					- kod 100 - je fyzický počet zaměstnanců

			        - kod 200 je přepočtený počet zaměstnanců na plný úvazek
			
Payroll_year 		- rok kdy byla průměrná mzda zaznamenána

Payroll_quarter 	- kvártál z roku měření

industry_branch_code - kod měřeného odvětví (kódy vyjádřené také v tabulce **czechia_payroll_industry_branch**)

					A	Zemědělství, lesnictví, rybářství
					
					B	Těžba a dobývání

					C	Zpracovatelský průmysl

					D	Výroba a rozvod elektřiny, plynu, tepla a klimatizovaného vzduchu

					E	Zásobování vodou; činnosti související s odpadními vodami, odpady a sanacemi
					
					F	Stavebnictví
					
					G	Velkoobchod a maloobchod; opravy a údržba motorových vozidel

					H	Doprava a skladování
					
					I	Ubytování, stravování a pohostinství
					
					J	Informační a komunikační činnosti
					
					K	Peněžnictví a pojišťovnictví
					
					L	Činnosti v oblasti nemovitostí
					
					M	Profesní, vědecké a technické činnosti
					
					N	Administrativní a podpůrné činnosti
					
					O	Veřejná správa a obrana; povinné sociální zabezpečení
					
					P	Vzdělávání
					
					Q	Zdravotní a sociální péče
					
					R	Kulturní, zábavní a rekreační činnosti
					
					S	Ostatní činnosti

				

***Datové období***

***2000 - 2021.***

---------------

***Tabulka*** czechia_price: 

***Zdroj dat:*** ČSÚ ( https://csu.gov.cz/ )

***Technická dokumentace***

 : https://data.csu.gov.cz/datastat/info/SADA/CEN0101G

**Popis sloupců:**

id = id záznamu

value - cena v czk

category_code - kod kategorie produktu (kódy též vyjádřeny v tabulce **czechia_price_category**)

				- Hovězí maso zadní bez kosti [1 kg] [0112101]
				
				- Vepřová pečeně s kostí [1 kg] [0112201]
				
				- Šunkový salám [1 kg] [0112704]
				
				- Kuřata kuchaná celá [1 kg] [0112401]
				
				- Mléko polotučné pasterované [1 l] [0114201]
				
				- Eidamská cihla [1 kg] [0114501]
				
				- Jogurt bílý netučný [150 g] [0114401]
				
				- Vejce slepičí čerstvá [10 ks] [0114701]
				
				- Máslo [1 kg] [0115101]
				
				- Rostlinný roztíratelný tuk [1 kg] [0115201]
				
				- Pšeničná mouka hladká [1 kg] [0111201]
				
				- Rýže loupaná dlouhozrnná [1 kg] [0111101]
				
				- Těstoviny vaječné [1 kg] [0111602]
				
				- Chléb konzumní kmínový [1 kg] [0111301]
				
				- Pečivo pšeničné bílé [1 kg] [0111303]
				
				- Cukr krystalový [1 kg] [0118101]
				
				- Přírodní minerální voda uhličitá [1 l] [0122102]
				
				- Jakostní víno bílé - od 2015 [0,75 l] [0212101]
				
				- Jakostní víno bílé - do 2014 [1 l] [0212104]
				
				- Pivo výčepní, světlé, lahvové [0,5 l] [0213201]
				
				- Konzumní brambory [1 kg] [0117401]
				
				- Pomeranče [1 kg] [0116101]
				
				- Banány žluté [1 kg] [0116103]
				
				- Rajská jablka červená kulatá [1 kg] [0117101]
				
				- Jablka konzumní [1 kg] [0116104]
				
				- Papriky [1 kg] [0117103]
				
				- Mrkev [1 kg] [0117106]

date_from - provedené měření od

date_to - provedené měření do

region_code - kod regionu - uzemí

				- Česko [CZ]
				
				- Hlavní město Praha [CZ010]
				
				- Středočeský kraj [CZ020]
				
				- Jihočeský kraj [CZ031]
				
				. Plzeňský kraj [CZ032]
				
				- Karlovarský kraj [CZ041]
				
				- Ústecký kraj [CZ042]
				
				- Liberecký kraj [CZ051]
				
				- Královéhradecký kraj [CZ052]
				
				- Pardubický kraj [CZ053]
				
				- Kraj Vysočina [CZ063]
				
				- Jihomoravský kraj [CZ064]
				
				- Olomoucký kraj [CZ071]
				
				- Zlínský kraj [CZ072]
				
				- Moravskoslezský kraj [CZ080]

***Datové období***

***2006 - 2018***.
				
> Poznámka: V dokumentaci není jednoznačně uvedeno, že pro celorepublikové měření je hodnota NULL.

--------------------------------

## 4.2 Analýza dat pro tvorbu sekundární tabulky 

Pro vytvoření sekundární tabulky jsou k dispozici data ze dvou tabulek: **countries** a **economies**.

**Tabulka:** countries

**Popis sloupců:**

						- country
						- abbreviation
						- avg_height
						- calling_code
						- capital_city
						- continent
						- currency_name
						- religion
						- currency_code
						- domain_tld
						- elevation
						- north
						- south
						- west
						- east
						- government_type
						- independence_date
						- iso_numeric
						- landlocked
						- life_expectancy
						- national_symbol
						- national_dish
						- population_density
						- population
						- region_in_world
						- surface_area
						- yearly_average_temperature
						- median_age_2018
						- iso2
						- iso3
						
> Poznámka: Detailnějsí popis sloupců není až tak nutný, protože pro zodpovězení výzkumných otázek není tabulka až tak relevantní.

**Tabulka:**  economies

						- country 	( světové státy )
						- year		(rok měření )
						- gdp		(hrubý domácí produkt - HDP za měřený rok )
						- population
						
						- gini
						- taxes
						- fertility
						- mortaliy_under5

**Datové období**
			
**1960 - 2020**

> Poznámka: Dokumentace nenalezena na stránkách statistického úřadu. Pro zodpovězení výzkumné otázky budou potřeba pouze prvních pět sloupců ( country, year, dgp, population, gini ).

*******

# 5. Tvorba finálních tabulek

## 5.1 Primární tabulka 

**Název tabulky**

t_tomas_smejkal_project_sql_primary_V2

**Použité tabulky**

Pro zodpovězení výzkumných otázek č.1 - 4  budu potřebovat spojit tyto tabulky :
																				
																- czechia_price				
																- czechia_payroll
																- czechia_price_category
																- czechia_payroll_industry_branch
**Výsledné sloupce:**

																	- avg_price_czk ( ceny jsou již průměrovány za každý rok )
																	- category_code
																	- price_measured_from
																	- price_measured_to
																	- avg_payroll_value_czk ( mzdy průměrovány za každý rok )
																	- payroll_year
																	- name                            |
																	- price_value
																	- price_unit
																	- industry_name   

**Propojení tabulek**

Hlavní tabulky czechia_price a payroll_year jsou spojeny přes sloupec: czechia_price.date_from a checzia_payroll.payroll_year.
		
Dodatečné tabulky: 

				- czechia_price_category je spojena přes sloupce czechia_price_category.code = czechia_price.category_code

				- czechia_payroll_industry_branch je spojena přes sloupce czechia_payroll.industry_branch_code = czechia_payroll_industry_branch.code

**Datové období**

**2006 - 2018.**

**Podmínky filtrování:**

Při slučování byla pouze vybrána/filtrována relevantní data z tabulky **czechia_payroll** a **czechia_price** pro zodpovězení výzkumných otázek tedy :

				- czechia_payroll.value_type_code = 5958 ( průměřná mzda )

				- czechia_payroll.unit_code = 200 ( jednotka v Kč )

				- czechia_payroll.calculation_code = 200 ( položka 200 přepočtený počet zaměstnanců na plný úvazek )

				- czechia_price IS NULL ( měření celorepublikové )

						
	
## 5.2 Sekundární tabulka 

**Název tabulky**

t_tomas_smejkal_project_sql_secondary_final**

**Použité tabulky**

Pro vytvoření sekundární tabulky budu potřebovat tyto tabulky:

															- economies
															- countries

**Výsledné sloupce**

Výsledná tabulka obsahuje tyto sloupce: 

															- country
															- year
															- gdp
															- population    
															- gini    

**Podmínky filtrování**

Tabulky jsou spojeny přes sloupce economies.country = countries.country.

Při slučování byla pouze vybrána/vyfiltrována relevantní data pro období mezi lety 2006 - 2018 a **evropské** země:

														 - countries.continent = 'Europe'
														 - economies.YEAR BETWEEN 2006 AND 2018

**Datové období**

**2006 - 2018**										

--------------------------------------

# 6. Výzkumné otázky a výsledky

## Otázka 1 

**Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**

***Výsledek***

Z výsledných dat průměrných mezd seskupených dle roku měření a odvětví je vidět, že průměrná mzda ve všech odvětvích v měřených letech 2006 - 2018 stoupá._**

U některých odvětví jako například "Administrativní a podpůrné činnosti", "Činnosti v oblasti nemovitostí", "Informační a komunikační činnosti", "Peněžnictví a pojišťovnictví", "Profesní a věděcké práce", 

"Stavebnictví","Těžba a dobívání" můžeme vidět v letech 2012 a 2013 nízký meziroční pokles.

Zajímavé je i zjištění, že v oboru "Výroba a rozvod elektřiny, plynu, tepla" došlo v průběhu zkoumaných let k delšímu meziročnímu poklesu mezd od roku 2012 a trval až do roku 2016. Ale v porovnání mezi roky 2008 a 2016 došlo celkovému růstu mezd v tomto období.

Pokud porovnáme nárust mezd mezi roky 2006 a 2018 tak opět všechna odvětví ukazují nárůst mezd mezi těmito lety. Nejmenší nárůst dosáhlo odvětví "Administrativní a podpůrné činnosti" a to cca 6,5 tis Kč. A naopak největší nárůst mezd dosáhlo odvětví "Informační a komunikační činnosti" a to cca 21 tis. Kč.

***Shrnutí***

✅ Ve všech sledovaných odvětvích došlo mezi roky 2006–2018 k celkovému růstu mezd.

---


## Otázka 2 

**Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**

Jako první a poslední porovnatelné období jsou brány roky 2006 a 2018. Jako průměrná mzda je počítáta průměrná mzda ze všech období ve zkoumaném roce.

***Výsledek***

Rok		Chléb		Mléko

2006	1312 kg		1465 l


2018	1365 kg		1669 l

Z výsledných dat je vidět, že v roce 2006 bylo možné z průměrné mzdy koupit 1312 kusů chleba nebo _1465 litrů mléka_. 
V roce 2018 bylo z průměrné mzdy možné zakoupit 1365 kusů chleba a nebo 1669 litrů mléka.

***Shrnutí**

✅ Růst cen mléka a chleba mezi sledovanými roky odpovídá růstu mezd. V roce 2018 bylo možné oproti roku 2006 koupit o 53 kg více chleba nebo o 204 více mléka.

---


## Otázka 3. 

**Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**

**Výskedek**

Z výsledných dat je vidět, že nejnížší přírůstek má měřená potravina "Kapr Živý", kdy došlo k růstu ceny mezi lety 2006 a 2018 o 0,74 %. 

Naopak mejvyšší růst mezi roky 2006 - 2018 zaznamenaly brambory a to o 163 %.

**Shrnutí**

✅ Nejnižší růst ceny zaznamenal kapr živý.

---

## Otázka 4 

**Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**

**Výsledek**

Z výsledných dat je vidět že nejvyšší procentulní nárust cen byl zaznamenán v roce 2017 a to 9,98 %, které bylo provázeno  nárůstem mezd o 6,17 % v témže roce. 

Nejvyšší nárůst mezd byl zaznamenán v roce 2018 a to o 7,7 %. V měřeném obodobí let 2006 - 2018 nebyl zaznamenán růst cen nebo mezd o více jak 10%. 

V některých letech docházelo i k mírným poklesům.

**Shrnutí**

❌ Ve sledovaném období nebyl zaznamenán rozdíl převyšující 10 % jak u mezd tak u cen.

---

## Otázka 5 

**Má výška HDP vliv na změny ve mzdách a cenách potravin? 
Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**

**Výsledek**

> Protože srovnáváme ceny a mzdy, které jsou dostupné pouze pro Českou republiku, yla v sekundární tabulce vyfiltrována data pouze pro Českou republiku. 

Z výsledných dat vidíme, že nejvyší růst HDP byl v letech 2007,2015, 2017 a to o 5,39 %. V roce 2007 došlo k nárustu cena o cca 6% a růstu mezd o 7%. 
V roce 2015 byl růst mezd 2,6 % a růst cen dokonce zaznamenal pokles o -0,57 %. V roce 2017 však došlo k vyšším nárůstum cen ( o téměř 10 % ) i mezd ( o 6 % ). 

Nejnižší HDP tedy pokles o -5,05% byl zaznamenán v roce 2009, který byl  prováze i poklesem cen o -7,7 %. Následné roky pak ukazují s roustoucím HDP i roustucí ceny a mzdy.
Z dat nevyplývá, že by extrémní růst či pokles HDP měl vliv na cenu potravin či růst mezd.

**Shrnutí**

❌ Nebyla potvrzena jednoznačná závislost mezi vývojem HDP a změnou cen potravin nebo mezd.

---

# 7. Závěr

Největším přínosem projektu pro mě nebylo pouze procvičení SQL, ale především pochopení významu správné interpretace zadání.

Zpětně hodnotím jako klíčové:

							- správné pochopení požadavků,
							- práci s dokumentací,
							- návrh datového modelu,
							- tvorbu SQL dotazů,
							- dokumentaci projektu v Markdownu,
							- práci s verzovacím systémem Git.

Projekt mi poskytl cenné zkušenosti s PostgreSQL, GitHubem a tvorbou datově analytické dokumentace.




