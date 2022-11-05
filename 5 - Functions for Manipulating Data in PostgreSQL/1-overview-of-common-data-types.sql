/* 1 - Overview of Common Data Types */
/* Exercises */

/* Overview */
 SELECT * 
 FROM INFORMATION_SCHEMA.TABLES
 WHERE table_schema = 'public';
 
 SELECT * 
 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE table_name = 'actor';
 
 SELECT
 	column_name, 
    data_type
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE table_name ='customer';

/* Date and time data types */
SELECT
	rental_date,
	return_date,
	rental_date + INTERVAL '3 days' AS expected_return_date
FROM rental;

/* Working with ARRAYs */
SELECT 
  title, 
  special_features 
FROM film;

SELECT 
  title, 
  special_features 
FROM film
WHERE special_features[1] = 'Trailers';

SELECT 
  title, 
  special_features 
FROM film
WHERE special_features[2] = 'Deleted Scenes';

SELECT 
  title, 
  special_features 
FROM film 
WHERE 'Trailers' = ANY (special_features);

SELECT 
  title, 
  special_features 
FROM film 
WHERE special_features @> ARRAY[ 'Deleted Scenes' ];


