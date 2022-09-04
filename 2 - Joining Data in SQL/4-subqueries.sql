/* 4 - Subqueries */
/* Exercises */

/* Subqueries inside WHERE and SELECT clauses */
SELECT AVG(life_expectancy)
  FROM populations
WHERE year = 2015;

SELECT *
  FROM populations
WHERE life_expectancy >
  1.15 * (SELECT AVG(life_expectancy)
   FROM populations
   WHERE year = 2015) AND
  year = 2015;

SELECT name, country_code, urbanarea_pop
  FROM cities
WHERE name IN
  (SELECT capital
   FROM countries)
ORDER BY urbanarea_pop DESC;

SELECT countries.name AS country, COUNT(*) AS cities_num
  FROM cities
	  INNER JOIN countries
	  ON countries.code = cities.country_code
GROUP BY country
ORDER BY cities_num DESC, country
LIMIT 9; 

SELECT countries.name AS country,
  (SELECT COUNT(*)
   FROM cities
   WHERE countries.code = cities.country_code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;

/* Subqueries inside FROM clause */
SELECT code, COUNT(*) AS lang_num
  FROM languages
GROUP BY code; 

SELECT local_name, subquery.lang_num
  FROM countries,
  	(SELECT code, COUNT(*) AS lang_num
  	 FROM languages
  	 GROUP BY code) AS subquery
  WHERE countries.code = subquery.code
ORDER BY lang_num DESC; 

SELECT name, continent, inflation_rate
  FROM countries
  	INNER JOIN economies
    USING (code)
WHERE year = 2015; 

SELECT MAX(inflation_rate) AS max_inf
  FROM (
      SELECT name, continent, inflation_rate
      FROM countries
      INNER JOIN economies
      USING (code)
      WHERE year = 2015) AS subquery
GROUP BY continent;

SELECT name, continent, inflation_rate
  FROM countries
	INNER JOIN economies
	ON countries.code = economies.code
  WHERE year = 2015
    AND inflation_rate IN (
        SELECT MAX(inflation_rate) AS max_inf
        FROM (
             SELECT name, continent, inflation_rate
             FROM countries
             INNER JOIN economies
             ON countries.code = economies.code
             WHERE year = 2015) AS subquery
      GROUP BY continent);
     
SELECT code, inflation_rate, unemployment_rate
  FROM economies
  WHERE year = 2015 AND code NOT IN
  	(SELECT code
  	 FROM countries
  	 WHERE (gov_form = 'Constitutional Monarchy' OR gov_form LIKE '%Republic%'))
ORDER BY inflation_rate;

/* Review */
SELECT DISTINCT name, total_investment, imports
  FROM countries AS c
    LEFT JOIN economies AS e
      ON (c.code = e.code
        AND c.code IN (
          SELECT l.code
          FROM languages AS l
          WHERE official = 'true'
        ) )
  WHERE region = 'Central America' AND year = 2015
ORDER BY name; 

SELECT region, continent, AVG(fertility_rate) AS avg_fert_rate
  FROM countries AS c
    INNER JOIN populations AS p
      ON c.code = p.country_code
  WHERE year = 2015
GROUP BY region, continent
ORDER BY avg_fert_rate; 

SELECT name, country_code, city_proper_pop, metroarea_pop,
	  city_proper_pop / metroarea_pop * 100 AS city_perc
  FROM cities
  WHERE name IN
    (SELECT capital
     FROM countries
     WHERE (continent = 'Europe'
        OR continent LIKE '%America'))
       AND metroarea_pop IS NOT NULL
ORDER BY city_perc DESC
LIMIT 10;

