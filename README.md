# SQL_Project_Tomas_Smejkal_V2
Repository for ENGETO sql project _ version 2
# SQL_Project_Tomas_Smejkal ENGETO Data academy 22_04_2025_v2
_(Tato verze je korigována po zpětné vazbě od hodnotitele projektu z prvního odevzdání a obsahuje korekce k vzneseným námitkám )_

 **Přípomínky hodnotitele:** 
 - _U primární tabulky doporučuji rovnou průměrovat ceny a mzdy za celý rok.
 - Sekundární tabulka má dle zadání obsahovat data ze všech evropských zemí
 - Dotaz k otázce 1: dotaz je velmi jednoduchý a je třeba dělat analýzu ručně. To v projektu nechceme - využij porovnání vždy s předchozím rokem, např. pomocí funkce LAG.
 - Otázka 2: Dle zadání máte porovnat ceny chleba a mléka, ne másla. Dej si zároveň pozor na formulaci odpovědi. Je opravdu možné koupit tento počet potravin zároveň?
 - Otázka 3: Odpověď není správně. Ptáme se na meziroční nárůst za celé sledované období. Opět využij funkci LAG.
 - Dotaz k odpovědi 4: Zde bych doporučila využít spíše CTE, než temporary tabulky.
 - Přidej úvod a závěr projektu.
 - Podívej se ještě na formátování průvodní listiny, je to trochu nepřehledné_.

-------------------------

### Projekt z SQL ###

## Úvod: ##

Cílem projektu je procvičení a ověření získaných znalostí z probraných lekcí. Projekt je zaměřen na znalosti dotazovacího jazyka SQL v Postgre databazi. Dotazy a použitá databáze jsou zpracovány pomocí softwaru DBeaver. Poskytnuté tabulky firmou Engeto, jsou upravené datové tabulky získané z veřejně dostupných zdrojů.

***Úvod do projektu a jeho zadání:***

Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.

Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.

Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.

﻿

**Datové sady, které je možné požít pro získání vhodného datového podkladu:**

***Primární tabulky:***

*czechia_payroll* – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
*czechia_payroll_calculation* – Číselník kalkulací v tabulce mezd.
*czechia_payroll_industry_branch* – Číselník odvětví v tabulce mezd.
*czechia_payroll_unit* – Číselník jednotek hodnot v tabulce mezd.
*czechia_payroll_value_type* – Číselník typů hodnot v tabulce mezd.
*czechia_price* – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
*czechia_price_category* – Číselník kategorií potravin, které se vyskytují v našem přehledu.

***Číselníky sdílených informací o ČR:***

czechia_region – Číselník krajů České republiky dle normy CZ-NUTS 2.
czechia_district – Číselník okresů České republiky dle normy LAU.

***Dodatečné tabulky:***

countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.
﻿

**Výzkumné otázky**

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
﻿

**Výstupy z projektu**

Pomozte kolegům s daným úkolem. Výstupem by měly být dvě tabulky v databázi, ze kterých se požadovaná data dají získat. Tabulky pojmenujte ***t_{jmeno}_{prijmeni}_project_SQL_primary_final*** (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) a ***t_{jmeno}_{prijmeni}_project_SQL_secondary_final (pro dodatečná data o dalších evropských státech)***.

Dále připravte sadu SQL, které z vámi připravených tabulek získají datový podklad k odpovězení na vytyčené výzkumné otázky. Pozor, otázky/hypotézy mohou vaše výstupy podporovat i vyvracet! Záleží na tom, co říkají data.

Na svém GitHub účtu vytvořte veřejný repozitář, kam uložíte všechny informace k projektu – hlavně SQL skript generující výslednou tabulku, popis mezivýsledků (průvodní listinu) ve formátu markdown (.md) a informace o výstupních datech (například kde chybí hodnoty apod.).

Neupravujte data v primárních tabulkách! Pokud bude potřeba transformovat hodnoty, dělejte tak až v tabulkách nebo pohledech, které si nově vytváříte.

***

## **Analýza dat pro tvorbu primarní tabulky t_tomas_smejkal_project_sql_primary**

Zdroj tabulky **czechia_payroll**: https://csu.gov.cz/

Technická dokumentace zdrojové datové sady : https://csu.gov.cz/docs/107508/a7309d97-c5be-4ef4-de2f-d2962e385b93/110079-22dds.htm

### **Popis sloupců v tabulce czechia_payroll**:

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

				

***Období dat od roku 2000 - 2021.*** 
***
Zdroj tabulky **czechia_price**: https://csu.gov.cz/

Technická dokumentace zdrojové datové sady : https://data.csu.gov.cz/datastat/info/SADA/CEN0101G

### **Popis sloupců v tabulce czechia_price**:

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

***Období měřených dat 2006 - 2018***.
				
***Poznámka - v dokumentaci není jednoznačně uvedeno že pro celorepublikové měření je hodnota NULL.***


## **Analýza dat pro tvorbu sekundární tabulky t_tomas_smejkal_project_sql_secondary_final**

Pro vytvoření sekundární tabulky jsou k dispozici data ze dvou tabulek: **countries** a **economies**.

Popis sloupců tabulky **countries**:

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
						
**_Poznámka - detailnějsí popis sloupců není nutný, protože pro zodpovězení výzkumných otázaek není tabulka relevantní a nebude použita_**.

Popis sloupců tabulky **economies**:

						- country 	( světové státy )
						- year		(rok měření )
						- gdp		(hrubý domácí produkt - HDP za měřený rok )
						- population
						
						- gini
						- taxes
						- fertility
						- mortaliy_under5

			**Obsahuje data z období 1960 - 2020**

**_Poznámka - dokumentace nenalezena na stránkách statistického úřadu. Pro zodpovězení výzkumné otázky budou potřeba pouze první tři sloupce_**.

*******

## **Vytvoření primarní tabulky t_tomas_smejkal_project_sql_primary_V2**

Pro zodpovězení výzkumných otázek č.1 - 4  budu potřebovat spojit tyto tabulky :
																				
																- czechia_price				
																- czechia_payroll
																- czechia_price_category
																- czechia_payroll_industry_branch

Výsledná tabulka obsahuje tyto sloupce:

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

__Hlavní tabulky czechia_price a payroll_year jsou spojeny přes sloupec: czechia_price.date_from a checzia_payroll.payroll_year__
		Dodatečné tabulky: 

				- czechia_price_category je spojena přes sloupce czechia_price_category.code = czechia_price.category_code

				- czechia_payroll_industry_branch je spojena přes sloupce czechia_payroll.industry_branch_code = czechia_payroll_industry_branch.code

**Výsledná tabulka obsahuje pouze shodné bodobí dat z let 2006 - 2018.**

Při slučování byla pouze vybrána/filtrována relevantní data z tabulky **czechia_payroll** a **czechia_price** pro zodpovězení výzkumných otázek tedy :

				- czechia_payroll.value_type_code = 5958 ( průměřná mzda )

				- czechia_payroll.unit_code = 200 ( jednotka v Kč )

				- czechia_payroll.calculation_code = 200 ( položka 200 přepočtený počet zaměstnanců na plný úvazek )

				- czechia_price IS NULL ( měření celorepublikové )

						
	
## **Vytvoření sekundární tabulky t_tomas_smejkal_project_sql_secondary_final**

Pro vytvoření sekundární tabulky budu potřebovat tyto tabulky:

															- economies
															- countries

Výsledná tabulka obsahuje tyto sloupce: 

															- country
															- year
															- gdp
															- population    
															- gini    

Tabulky jsou spojeny přes sloupce economies.country = countries.country.

Při slučování byla pouze vybrána/vyfiltrována relevantní data pro období mezi lety 2006 - 2018 a evropské země:

														 - countries.continent = 'Europe'
														 - economies.YEAR BETWEEN 2006 AND 2018

**Výsledná tabulka obsahuje pouze shodné bodobí dat z let 2006 - 2018 stejně jako primární tabulka**										

***

# Výzkumné otázky #

**1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**

**_Z výsledných dat průměrných mezd seskupených dle roku měření a odvětví je vidět, že průměrná mzda ve všech odvětvích v měřených letech 2006 - 2018 stoupá._**

U některých odvětví jako například "Administrativní a podpůrné činnosti", "Činnosti v oblasti nemovitostí", "Informační a komunikační činnosti", "Peněžnictví a pojišťovnictví", "Profesní a věděcké práce", 

"Stavebnictví","Těžba a dobívání" můžeme vidět v letech 2012 a 2013 nízký meziroční pokles.

Zajímavé je i zjištění, že v oboru "Výroba a rozvod elektřiny, plynu, tepla" došlo v průběhu zkoumaných let k delšímu meziročnímu poklesu mezd od roku 2012 a trval až do roku 2016. Ale v porovnání mezi roky 2008 a 2016 došlo celkovému růstu mezd v tomto období.

---
**2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**

Jako první a poslední porovnatelné období jsou brány roky 2006 a 2018. Jako průměrná mzda je počítáta průměrná mzda ze všech období ve zkoumaném roce.

**_Z výsledných dat je vidět, že v roce 2006 bylo možné z průměrné mzdy koupit 1312 kusů chleba a 202 kusů másla. V roce 2018 bylo z průměrné mzdy možné zakoupit 1365 kusů chleba ale už jenom 159 kusů másla._**

---
**3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**

Jako ukazatel počítáme procentuální přírustek cen potraviny v každém roce, jelikož je cena měřena několikrát za rok. 

**_Z výsledných dat je vidět, že nejnížší přírůstek má měřená potravina "Kapr Živý" v roce 2010. Pokud zrušíme funkci limit 1 tak vidíme že pro kapra je hodnota 0 bez meziročního přírůstku v letech 2010 - 2018. Asi je to tím že je to sezonní potravina a přes rok se moc neprodává._**

---
**4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**

Pro stanovení průměrné ceny je počítána jako průměrná cena všech průměrných cen ze všech kategorií potravin. Průměrná mzda je také počítána jako průměrná mzda ze všech průměrných mezd ze všech odvětví. 

Pro vytvoření vysledků bylo použito dvou dočasných temp tabulek a to pro výpočet průměrné ceny za měřený rok a průměrné mzdy za měřený rok.

**_Z výsledných dat je vidět že nejvyšší procentulní nárust cen byl zaznamenán v roce 2017 a to 9,82 %, které bylo provázeno  nárůstem mezd o 6,17 % v témže roce. Nejvyšší nárůst mezd byl zaznamenán v roce 2018 a to o 7,7 %. V měřeném obodobí let 2006 - 2018 nebyl zaznamenán růst cen nebo mezd o více jak 10%. V některých letech docházelo i k mírným poklesům._**

---
**5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**

Protože srovnáváme ceny a mzdy, které jsou dostupné pouze pro Českou republiku, yla v sekundární tabulce vyfiltrována data pouze pro Českou republiku. 

**_Z výsledných dat vidíme, že nejvyší růst HDP byl v letech 2007 a 2015 a to o 5,39 %. V roce 2007-2008 došlo k nárustu cena o cca 6% a růstu mezd o 7%. V roce 2015 byl růst mezd 2,6 % a cem dokonce o -1,1 %.
Nejnižší HDP tedy pokles o -5,05% byl zaznamenán v roce 2009, který byl  prováze i poklesem cen o -7,7 %. Následné roky pak ukazují s roustoucím HDP i roustucí ceny a mzdy.
Zdat nevyplývá, že by s extrémními růst či pokles HDP měl vliv na cenu potravin či výši mezd._**

---




