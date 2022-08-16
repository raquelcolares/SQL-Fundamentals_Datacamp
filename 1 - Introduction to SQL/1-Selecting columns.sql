/* 1 - Selecting columns */
/* Exercises */

/* Selecting single columns. */
SELECT title
FROM films;

SELECT release_year FROM films

SELECT name from people 

/* Selecting multiple columns. */
SELECT * FROM films /* selecting all columns */

SELECT title, release_year
FROM films;

SELECT title, release_year, country
FROM films;

/* Select distinct. */
SELECT DISTINCT country
FROM films;

SELECT DISTINCT certification
FROM films;

SELECT DISTINCT role
FROM roles;

/* Practice with COUNT. */
SELECT COUNT(*)
FROM people;

SELECT COUNT(birthdate)
FROM people;

SELECT COUNT(DISTINCT birthdate)
FROM people; 

SELECT COUNT(DISTINCT language)
FROM films;






