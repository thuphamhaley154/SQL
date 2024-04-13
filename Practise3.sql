--Exercise 1: the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
SELECT * FROM CITY
WHERE COUNTRYCODE ='JPN';
--Ex2: all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT NAME FROM CITY
WHERE COUNTRYCODE = 'USA'
AND POPULATION >120000;
--Ex3: Query a list of CITY and STATE from the STATION table.
SELECT CITY, STATE FROM STATION;
--Ex4: Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT CITY FROM STATION
WHERE CITY LIKE 'a%' OR CITY LIKE 'e%' OR CITY LIKE 'i%' OR CITY LIKE 'o%' OR CITY LIKE 'u%';
--Ex5: the list of CITY names ending with vowels (a, e, i, o, u) from STATION.  Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u';
--Ex6: the list of CITY names from STATION that do not start with vowels.  Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION
WHERE CITY NOT LIKE 'A%' AND CITY NOT LIKE 'E%' AND CITY NOT LIKE 'I%' AND CITY NOT LIKE 'O%' AND CITY NOT LIKE 'U%' ;
--Ex7: a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order
SELECT CITY FROM STATION
WHERE CITY LIKE '%A' OR CITY LIKE '%E' OR CITY LIKE '%E' OR CITY LIKE '%O' OR CITY LIKE '%U';
/*Ex8: a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than  per month 
who have been employees for less than  months. Sort your result by ascending employee_id*/ 
SELECT NAME FROM Employee
WHERE salary >2000
AND months <10
ORDER BY employee_id ASC;
/*Ex9: product_id is the primary key (column with unique values) for this table. low_fats is an ENUM (category) of type ('Y', 'N') where 'Y' means this product
is low fat and 'N' means it is not. recyclable is an ENUM (category) of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.
 Write a solution to find the ids of products that are both low fat and recyclable*/
SELECT product_id FROM Products
WHERE low_fats ='Y'
AND recyclable ='Y';
--Ex10: Find the names of the customer that are not referred by the customer with id = 2
SELECT name FROM Customer
WHERE referee_id != 2 or referee_id is null
/*Ex11: A country is big if: it has an area of at least three million (i.e., 3000000 km2), or
it has a population of at least twenty-five million (i.e., 25000000).
Write a solution to find the name, population, and area of the big countries*/
SELECT name, population, area FROM World
WHERE area >=3000000
OR population >=25000000;
/*Ex12: Table: Views
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+There is no primary key (column with unique values) for this table, the table may have duplicate rows. Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
Note that equal author_id and viewer_id indicate the same person. Write a solution to find all the authors that viewed at least one of their own articles.
Return the result table sorted by id in ascending order.*/
SELECT DISTINCT author_id AS id
FROM Views
WHERE article_id >=1
AND viewer_id = author_id
ORDER BY id ASC;
--Ex13:[Tesla SQL Interview Question] parts_assembly table contains all parts currently in production, each at varying stages of the assembly process. An unfinished part is one that lacks a finish_date.
SELECT part, assembly_step FROM parts_assembly
WHERE finish_date is null
--Ex14: Find all Lyft drivers who earn either equal to or less than 30k USD or equal to or more than 70k USD.
select * from lyft_drivers
WHERE yearly_salary <=30000 OR yearly_salary >=70000
--Ex15: Find the advertising channel where Uber spent more than 100k USD in 2019. 
SELECT advertising_channel FROM uber_advertising
WHERE money_spent >100000
AND year = 2019;










