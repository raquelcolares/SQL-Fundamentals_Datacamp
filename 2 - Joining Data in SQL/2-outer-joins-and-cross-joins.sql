/* 2 - Outer joins and cross joins */
/* Exercises */ 

/* LEFT and RIGHT JOINs */ 
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
FROM cities AS c1
  INNER JOIN countries AS c2
    ON c1.country_code = c2.code
ORDER BY code DESC;

SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
FROM cities AS c1
  LEFT JOIN countries AS c2
    ON c1.country_code = c2.code
ORDER BY code DESC;

SELECT c.name AS country, local_name, l.name AS language, percent
FROM countries AS c
  INNER JOIN languages AS l
    ON c.code = l.code
ORDER BY country DESC; 

SELECT c.name AS country, local_name, l.name AS language, percent
FROM countries AS c
  LEFT JOIN languages AS l
    ON c.code = l.code
ORDER BY country DESC;

SELECT name, region, gdp_percapita
FROM countries AS c
  LEFT JOIN economies AS e
    ON c.code = e.code
WHERE year = 2010;

SELECT region, AVG(gdp_percapita) AS avg_gdp
FROM countries AS c
  LEFT JOIN economies AS e
    ON c.code = e.code
WHERE year = 2010
GROUP BY region;

SELECT region, AVG(gdp_percapita) AS avg_gdp
FROM countries AS c
  LEFT JOIN economies AS e
    ON c.code = e.code
WHERE year = 2010
GROUP BY region
ORDER BY avg_gdp DESC;

SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM languages
  RIGHT JOIN countries
    ON languages.code = countries.code
  RIGHT JOIN cities
    ON countries.code = cities.country_code
ORDER BY city, language;

/* FULL JOINs */
SELECT name AS country, code, region, basic_unit
FROM countries
  FULL JOIN currencies
    USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region; 

SELECT name AS country, code, region, basic_unit
FROM countries
  LEFT JOIN currencies
    USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region;

SELECT name AS country, code, region, basic_unit
FROM countries
  INNER JOIN currencies
    USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region;

SELECT countries.name, code, languages.name AS language
FROM languages
  FULL JOIN countries
    USING (code)
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
ORDER BY countries.name;

SELECT c1.name AS country, region, l.name AS language,
       basic_unit, frac_unit
FROM countries AS c1
  FULL JOIN languages AS l
    USING (code)
  FULL JOIN currencies AS c2
    USING (code)
WHERE region LIKE 'M%esia';

/* CROSSing the rubicon */
SELECT c.name AS city, l.name AS language
FROM cities AS c        
  CROSS JOIN languages AS l
WHERE c.name LIKE 'Hyder%';

SELECT c.name AS city, l.name AS language
FROM cities AS c        
  INNER JOIN languages AS l
    ON c.country_code = l.code
WHERE c.name LIKE 'Hyder%';

SELECT c.name AS country,
       region,
       life_expectancy AS life_exp
FROM countries AS c
  LEFT JOIN populations AS p
    ON c.code = p.country_code
WHERE year = 2010
ORDER BY life_exp
LIMIT 5;