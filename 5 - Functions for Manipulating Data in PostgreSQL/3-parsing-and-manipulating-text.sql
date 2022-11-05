/* 3 - Parsing and Manipulating Text */
/* Exercises */

/* Reformatting string and character data */
SELECT first_name || ' ' || last_name  || ' <' || email || '>' AS full_email 
FROM customer

SELECT CONCAT(first_name, ' ', last_name, ' <', email, '>') AS full_email 
FROM customer 

SELECT 
  UPPER(c.name) || ': ' || INITCAP(f.title) AS film_category,
  LOWER(f.description) AS description
FROM 
  film AS f 
  INNER JOIN film_category AS fc 
  	ON f.film_id = fc.film_id 
  INNER JOIN category AS c 
  	ON fc.category_id = c.category_id;
    
SELECT 
  REPLACE(title, ' ', '_') AS title
FROM film;

/* Parsing string and character data */ 
SELECT 
  title,
  description,
  LENGTH(description) AS desc_len
FROM film;

SELECT 
  LEFT(description, 50) AS short_desc
FROM 
  film AS f;
  
SELECT 
  SUBSTRING(address FROM POSITION(' ' IN address)+1 FOR LENGTH(address))
FROM 
  address; 
  
SELECT
  LEFT(email, POSITION('@' IN email)-1) AS username,
  SUBSTRING(email FROM POSITION('@' IN email)+1 FOR LENGTH(email)) AS domain
FROM customer; 

/* Truncating and padding string data */
SELECT 
	RPAD(first_name, LENGTH(first_name)+1) || last_name AS full_name
FROM customer; 

SELECT 
	first_name || LPAD(last_name, LENGTH(last_name)+1) AS full_name
FROM customer;  

SELECT 
	RPAD(first_name, LENGTH(first_name)+1) 
    || RPAD(last_name, LENGTH(last_name)+2, ' <') 
    || RPAD(email, LENGTH(email)+1, '>') AS full_email
FROM customer;  

SELECT 
  CONCAT(UPPER(c.name), ': ', f.title) AS film_category, 
  TRIM(LEFT(description, 50)) AS film_desc
FROM 
  film AS f 
  INNER JOIN film_category AS fc 
  	ON f.film_id = fc.film_id 
  INNER JOIN category AS c 
  	ON fc.category_id = c.category_id; 
    
SELECT 
  UPPER(c.name) || ': ' || f.title AS film_category, 
  LEFT(description, 50 - 
    POSITION(
      ' ' IN REVERSE(LEFT(description, 50))
    )
  ) 
FROM 
  film AS f 
  INNER JOIN film_category AS fc 
  	ON f.film_id = fc.film_id 
  INNER JOIN category AS c 
  	ON fc.category_id = c.category_id;

