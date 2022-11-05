/* 4 - Full-text Search and PostgresSQL Extensions */
/* Exercises */

/* Introduction to full-text search */
SELECT *
FROM film
WHERE title LIKE 'GOLD%';

SELECT *
FROM film
WHERE title LIKE '%GOLD';

SELECT *
FROM film
WHERE title LIKE '%GOLD%';

SELECT to_tsvector(description)
FROM film; 

SELECT title, description
FROM film
WHERE to_tsvector(title) @@ to_tsquery('elf');

/* Extending PostgreSQL */ 
CREATE TYPE compass_position AS ENUM (
  	'North', 
  	'South',
  	'East', 
  	'West'
); 

CREATE TYPE compass_position AS ENUM (
  	'North', 
  	'South',
  	'East', 
  	'West'
);
SELECT *
FROM pg_type
WHERE typname='compass_position';

SELECT column_name, data_type, udt_name
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE table_name ='film' AND column_name='rating'; 

SELECT *
FROM pg_type 
WHERE typname='mpaa_rating' 

SELECT 
	f.title, 
    i.inventory_id
FROM film as f 
	INNER JOIN inventory AS i ON f.film_id=i.film_id 

SELECT 
	f.title, 
    i.inventory_id,
    inventory_held_by_customer(i.inventory_id) AS held_by_cust
FROM film as f 
	INNER JOIN inventory AS i ON f.film_id=i.film_id 

SELECT 
	f.title, 
    i.inventory_id,
    inventory_held_by_customer(i.inventory_id) as held_by_cust
FROM film as f 
	INNER JOIN inventory AS i ON f.film_id=i.film_id 
WHERE
    inventory_held_by_customer(i.inventory_id) IS NOT NULL 
    
/* Intro to PostgreSQL extensions */
CREATE EXTENSION IF NOT EXISTS pg_trgm; 

SELECT * 
FROM pg_extension; 

SELECT 
  title, 
  description, 
  similarity(title, description)
FROM 
  film

SELECT  
  title, 
  description, 
  levenshtein(title, 'JET NEIGHBOR') AS distance
FROM 
  film
ORDER BY 3

SELECT  
  title, 
  description 
FROM 
  film 
WHERE 
  to_tsvector(description) @@ 
  to_tsquery('Astounding & Drama');

SELECT 
  title, 
  description, 
  similarity(description, 'Astounding Drama') 
FROM 
  film 
WHERE 
  to_tsvector(description) @@ 
  to_tsquery('Astounding & Drama') 
ORDER BY 
	similarity(description, 'Astounding Drama') DESC;