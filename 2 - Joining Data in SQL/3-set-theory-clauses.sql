/* 3 - Set theory clauses */
/* Exercises */

/* State of the UNION */
SELECT *
  FROM economies2010
    UNION
SELECT *
  FROM economies2015
ORDER BY code, year;

SELECT country_code
  FROM cities
	UNION
SELECT code
  FROM currencies
ORDER BY country_code;

SELECT code, year
  FROM economies
	UNION ALL
SELECT country_code, year
  FROM populations
ORDER BY code, year;

/* INTERSECTional data science */
SELECT code, year
  FROM economies
	iNTERSECT
SELECT country_code, year
  FROM populations
ORDER BY code, year;

SELECT name
  FROM countries
	INTERSECT
SELECT name
  -FROM cities;

/* EXCEPTional */
SELECT name
  FROM cities
	EXCEPT
SELECT capital
  FROM countries
ORDER BY name;

SELECT capital
  FROM countries
	EXCEPT
SELECT name
  FROM cities
ORDER BY capital;

/* Semi-joins and Anti-joins */
SELECT code
  FROM countries
WHERE region = 'Middle East';

SELECT DISTINCT name
  FROM languages
ORDER BY name;

SELECT DISTINCT name
  FROM languages
WHERE code IN
  (SELECT code
   FROM countries
   WHERE region = 'Middle East')
ORDER BY name;

SELECT COUNT(*)
  FROM countries
WHERE continent = 'Oceania';

SELECT c1.code, name, basic_unit AS currency
  FROM countries AS c1
  	INNER JOIN currencies AS c2
    ON c1.code = c2.code
WHERE c1.continent = 'Oceania';

SELECT code, name
  FROM countries
  WHERE continent = 'Oceania'
  	AND code NOT IN
  	(SELECT code
  	 FROM currencies);
     
SELECT name
  FROM cities AS c1
  WHERE country_code IN
(
    SELECT e.code
    FROM economies AS e
    UNION
    SELECT c2.code
    FROM currencies AS c2
    EXCEPT
    SELECT p.country_code
    FROM populations AS p
);
