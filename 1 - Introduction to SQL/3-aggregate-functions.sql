/* 3 - Aggregate Functions */
/* Exercises */

/* Aggregate functions */ 
SELECT SUM(duration)
FROM films;

SELECT AVG(duration)
FROM films;

SELECT MIN(duration)
FROM films;

SELECT MAX(duration)
FROM films; 

SELECT SUM(gross)
FROM films; 

SELECT AVG(gross)
FROM films; 

SELECT MIN(gross)
FROM films; 

SELECT MAX(gross)
FROM films; 

SELECT SUM(gross)
FROM films
WHERE release_year >= 2000; 

SELECT AVG(gross)
FROM films
WHERE title LIKE 'A%'; 

SELECT MIN(gross)
FROM films
WHERE release_year = 1994; 

SELECT MAX(gross)
FROM films
WHERE release_year BETWEEN 2000 AND 2012; 

/* A note on arithmetic */
SELECT title, gross - budget AS net_profit
FROM films; 

SELECT title, duration/60.0 AS duration_hours
FROM films; 

SELECT AVG(duration)/60.0 AS avg_duration_hours
FROM films; 

SELECT COUNT(deathdate)*100.0/ COUNT(*) AS percentage_dead
FROM people; 

SELECT MAX(release_year)-MIN(release_year) AS difference
FROM films; 

SELECT (MAX(release_year) - MIN(release_year)) / 10.0
AS number_of_decades
FROM films; 

