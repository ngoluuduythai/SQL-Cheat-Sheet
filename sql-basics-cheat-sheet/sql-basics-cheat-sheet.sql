-- Active: 1700845452508@@127.0.0.1@5432@sqlweb

-- Create table country
CREATE TABLE country (
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  population INT,
  area INT
);

-- Create table city
-- CREATE TABLE city (
--   id INT PRIMARY KEY,
--   name VARCHAR(50) NOT NULL,
--   country_id INT REFERENCES country(id),
--   population INT,
--   rating INT
-- );

CREATE TABLE city (
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  country_id INT,
  population INT,
  rating INT
);


-- Insert data for table country
INSERT INTO country (id, name, population, area)
VALUES
(1, 'Taiwan', 23816775, 36197),
(2, 'China', 1402112000, 9596961),
(3, 'India', 1366417754, 3287263),
(4, 'United States', 331002651, 9833517),
(5, 'Brazil', 212559417, 8515767),
(6, 'Canada', 37742154, 9984670),
(7, 'France', 65273511, 643801),
(8, 'Germany', 83783942, 357114),
(9, 'Japan', 126476461, 377915),
(10, 'Australia', 25499884, 7692024),
(11, 'Ireland', 25499884, 7692024),
(12, 'Poland', 25499884, 7692024);

-- Insert data for table city
INSERT INTO city (id, name, country_id, population, rating)
VALUES
(1, 'Dublin', 2, 592713, 3),
(2, 'Taipei', 2, 2636765, 5),
(3, 'Berlin', 8, 3644826, 4),
(4, 'Beijing', 15, 21542000, 4),
(5, 'New York', 4, 18804000, 5),
(6, 'Paris', 7, 2148327, 5),
(7, 'Toronto', 6, 2731571, 5),
(8, 'Tokyo', 9, 13929286, 5),
(9, 'Sydney', 10, 4627345, 5),
(10, 'New Delhi', 3, 16787941, 3),
(11, 'São Paulo', 5, 12106920, 4),
(12, 'Lublin', 3, 334680, 3);

-- Select all countries
SELECT * FROM country;

-- Select all cities
SELECT * FROM city;

-- QUERYING SINGLE TABLE
--- Fetch all columns from the country table:
SELECT *
FROM country;
-- Fetch id and name columns from the city table: SELECT id, name
-- FROM city; Fetch city names sorted by the rating column
-- in the default ASCending order:
SELECT name
FROM city
ORDER BY rating ASC;
--Fetch city names sorted by the rating column
--in the DESCending order:
SELECT name
FROM city
ORDER BY rating DESC;

--ALIASES COLUMNS
SELECT name AS city_name
FROM city;
--TABLES
-- Order exec is FORM AND JOIN -> SELECT -> WHERE -> ORDER BY
-- join country_id in table city to country with city.country_id = country_id
SELECT co.name, ci.name
FROM city AS ci
JOIN country AS co
ON ci.country_id = co.id;

--FILTERING THE OUTPUT
--COMPARISON OPERATORS
--Fetch names of cities that have a rating above 3:
SELECT name
FROM city
WHERE rating > 3;

--Fetch names of cities that are neither Berlin nor Sydney:
SELECT name
FROM city
WHERE name != 'Berlin'
AND
name != 'Sydney';

--TEXT OPERATORS
--Fetch names of cities that start with a 'P'or end with an 's':
SELECT name
FROM city
WHERE name LIKE 'P%'
OR name LIKE '%s';

--Fetch names of cities that start with any letter 
--followed by 'ublin' (like Dublin in Ireland or Lublin in Poland):
SELECT name
FROM city
WHERE name LIKE '_ublin';

--OTHER OPERATORS
--Fetch names of cities that have a population between 500K and 5M:
SELECT name
FROM city
WHERE population BETWEEN 500000 AND 5000000;

--Fetch names of cities that don't miss a rating value:
SELECT name
FROM city
WHERE rating IS NOT NULL;

--Fetch names of cities that are in countries with IDs 1, 4, 7, or 8:
SELECT name
FROM city
WHERE country_id IN (1, 4, 7, 8);

--QUERYING MULTIPLE TABLES
--INNER JOIN
--JOIN (or explicitly INNER JOIN) returns rows 
--that have matching values in both tables.
-- Phần chung của hai bảng
SELECT city.name, country.name
FROM city
JOIN country
  ON city.country_id = country.id;

-- LEFT JOIN
-- LEFT JOIN returns all rows from the left table 
-- with corresponding rows from the right table.
-- If there's no matching row, NULLs are returned as values from the second table.
SELECT city.name, country.name
FROM city
LEFT JOIN country
  ON city.country_id = country.id;

--RIGHT JOIN
--RIGHT JOIN returns all rows from the right table with corresponding rows
--from the left table. If there's no matching row,
-- NULLs are returned as values from the left table.  

SELECT city.name, country.name
FROM city
RIGHT JOIN country
  ON city.country_id = country.id;

-- FULL JOIN
-- FULL JOIN (or explicitly FULL OUTER JOIN)
-- returns all rows from both tables – if there's no matching row
-- in the second table, NULLs are returned.
SELECT city.name, country.name
FROM city
FULL JOIN country
  ON city.country_id = country.id;

-- CROSS JOIN
-- CROSS JOIN returns all possible combinations of rows from both tables. There are two syntaxes available.
SELECT city.name, country.name
FROM city
CROSS JOIN country;

SELECT city.name, country.name
FROM city, country;
-- NATURAL JOIN
-- NATURAL JOIN will join tables by all columns with the same name.
SELECT city.name, country.name
FROM city
NATURAL JOIN country;

-- NATURAL JOIN used these columns to match rows:
-- city.id, city.name, country.id, country.name.
-- NATURAL JOIN is very rarely used in practice.

-- AGGREGATION AND GROUPING
-- GROUP BY groups together rows that have the same values in specified columns.
-- It computes summaries (aggregates) for each unique combination of values.

SELECT country_id, COUNT(*) AS number_of_cities
FROM city 
GROUP BY country_id;

-- AGGREGATE FUNCTIONS
-- avg(expr) − average value for rows within the group
-- count(expr) − count of values for rows within the group
-- max(expr) − maximum value within the group
-- min(expr) − minimum value within the group
-- sum(expr) − sum of values within the group

-- EXAMPLE QUERIES
-- Find out the number of cities:
SELECT COUNT(*)
FROM city;

-- Find out the number of cities with non-null ratings:
SELECT COUNT(rating)
FROM city;

-- Find out the number of distinctive country values:
SELECT COUNT(DISTINCT country_id)
FROM city;

-- Find out the smallest and the greatest country populations:
SELECT MIN(population), MAX(population)
FROM country;

-- Find out the total population of cities in respective countries:
SELECT country_id, SUM(population)
FROM city
GROUP BY country_id;

-- Find out the average rating for cities in respective countries if the average is above 3.0:
SELECT country_id, AVG(rating)
FROM city
GROUP BY country_id
HAVING AVG(rating) > 3.0;

-- SUBQUERIES
-- A subquery is a query that is nested inside another query, or inside another subquery. There are different types of subqueries.

-- SINGLE VALUE
-- The simplest subquery returns exactly one column and exactly one row. It can be used with comparison operators =, <, <=, >, or >=.
-- This query finds cities with the same rating as Paris:
SELECT name
FROM city
WHERE rating = (
  SELECT rating
  FROM city
  WHERE name = 'Paris'
);

-- MULTIPLE VALUES
-- A subquery can also return multiple columns or multiple rows. Such subqueries can be used with operators IN, EXISTS, ALL, or ANY.
-- This query finds cities in countries that have a population above 20M:
SELECT name
FROM city
WHERE country_id IN (
  SELECT country_id
  FROM country
  WHERE population > 20000000
);
-- CORRELATED
-- A correlated subquery refers to the tables introduced in the outer query.
-- A correlated subquery depends on the outer query. It cannot be run independently from the outer query.

-- This query finds cities with a population greater than the average population in the country:
SELECT *
FROM city main_city
WHERE population > (
  SELECT AVG(population)
  FROM city average_city
  WHERE average_city.country_id = main_city.country_id -- filters out the cities in the average_city not in the same country as the main_city.
);

-- This query finds countries that have at least one city:
SELECT name
FROM country
WHERE EXISTS (
  SELECT *
  FROM city
  WHERE country_id = country.id
);

-- SET OPERATIONS
-- Set operations are used to combine the results of two or more queries into a single result.
-- The combined queries must return the same number of columns and compatible data types. The names of the corresponding columns can be different

-- UNION
-- UNION combines the results of two result sets and removes duplicates. UNION ALL doesn't remove duplicate rows.
-- This query displays German cyclists together with German skaters:

CREATE TABLE cycling (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  country VARCHAR(50)
);


-- Insert data for table cycling
INSERT INTO cycling (id, name, country)
VALUES
(1, 'YK', 'DE'),
(2, 'ZG', 'DE'),
(3, 'WT', 'PL');

CREATE TABLE skating (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  country VARCHAR(50)
);


-- Insert data for table cycling
INSERT INTO skating (id, name, country)
VALUES
(1, 'YK', 'DE'),
(2, 'DF', 'DE'),
(3, 'AK', 'PL');


SELECT name
FROM cycling
WHERE country = 'DE'
UNION 
SELECT name
FROM skating
WHERE country = 'DE';

SELECT name
FROM cycling
WHERE country = 'DE'
UNION ALL
SELECT name
FROM skating
WHERE country = 'DE';

-- INTERSECT
-- INTERSECT returns only rows that appear in both result sets.
-- This query displays German cyclists who are also German skaters at the same time:
SELECT name
FROM cycling
WHERE country = 'DE'
INTERSECT
SELECT name
FROM skating
WHERE country = 'DE';

-- EXCEPT
-- EXCEPT returns only the rows that appear in the first result set but do not appear in the second result set.
-- This query displays German cyclists unless they are also German skaters at the same time:
SELECT name
FROM cycling
WHERE country = 'DE'
EXCEPT
SELECT name
FROM skating
WHERE country = 'DE';
