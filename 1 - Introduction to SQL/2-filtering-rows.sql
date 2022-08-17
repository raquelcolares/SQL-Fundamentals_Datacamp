/* 2 - Filtering rows */
/* Exercises */

/* Simple filtering. */ 
SELECT *
FROM films
WHERE release_year = 2016;

SELECT COUNT (*)
FROM films
WHERE release_year < 2000; 

SELECT title, release_year
FROM films
WHERE release_year > 2000; 

SELECT *
FROM films
WHERE language = 'French'; 

SELECT name, birthdate
FROM people
WHERE birthdate = '1974-11-11'; 

SELECT COUNT(*)
FROM films 
WHERE language = 'Hindi'; 

SELECT *
FROM films 
WHERE certification = 'R'; 

/* WHERE AND */
SELECT title, release_year
FROM films
WHERE language = 'Spanish'
AND release_year < 2000; 

SELECT *
FROM films
WHERE language = 'Spanish'
AND release_year > 2000; 

SELECT *
FROM films
WHERE language = 'Spanish'
AND release_year > 2000
AND release_year < 2010; 

/* WHERE AND OR */
SELECT title, release_year
FROM films
WHERE release_year >= 1990
AND release_year < 2000; 

SELECT title, release_year
FROM films
WHERE (release_year >= 1990 AND release_year < 2000)
AND (language = 'French' OR language = 'Spanish')

SELECT title, release_year
FROM films
WHERE (release_year >= 1990 AND release_year < 2000)
AND (language = 'French' OR language = 'Spanish')
AND gross >2000000; 

/* BETWEEN */
SELECT title, release_year
FROM films
WHERE release_year BETWEEN 1990 AND 2000; 

SELECT title, release_year
FROM films
WHERE release_year BETWEEN 1990 AND 2000
AND budget > 100000000; 

SELECT title, release_year
FROM films
WHERE release_year BETWEEN 1990 AND 2000
AND budget > 100000000
AND language = 'Spanish'; 

SELECT title, release_year
FROM films
WHERE release_year BETWEEN 1990 AND 2000
AND budget > 100000000
AND (language = 'Spanish' OR language = 'French'); 

/* WHERE IN */
SELECT title, release_year
FROM films
WHERE release_year IN (1990, 2000)
AND duration > 120; 

SELECT title, language
FROM films
WHERE language IN ('English', 'Spanish', 'French'); 

SELECT title, certification
FROM films
WHERE certification IN ('NC-17', 'R'); 

/* NULL and IS NULL */
SELECT name
FROM people
WHERE deathdate IS NULL;  

SELECT title 
FROM films
WHERE budget IS NULL; 

SELECT COUNT(*)
FROM films
WHERE language IS NULL; 

/* LIKE and NOT LIKE */
SELECT name
FROM people
WHERE name LIKE 'B%'; /* B as a first letter */

SELECT name
FROM people
WHERE name LIKE '_r%'; /* r as a second letter */

SELECT name
FROM people
WHERE name NOT LIKE 'A%';
