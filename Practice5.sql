--Ex1: a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
SELECT DISTINCT CITY FROM STATION
WHERE ID%2=0;
--EX2: the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
SELECT COUNT (CITY) - COUNT (DISTINCT CITY)
FROM STATION;
/*Ex3: Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table,
but did not realize her keyboard's  key was broken until after completing the calculation. She wants your help finding 
the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
Write a query calculating the amount of error , round it up to the next integer.*/


/*EX4:[Alibaba SQL Interview Question] You're trying to find the mean number of items per order on Alibaba, 
rounded to 1 decimal place using tables which includes information on the count of items in each order (item_count table) 
and the corresponding number of orders for each item count (order_occurrences table).
Column Name	Type
item_count	integer
order_occurrences	integer
+output (gốc/phái sinh phải tính ra): mean= tổng items/số đơn hàng, 
+ input: 
+ điều kiện lọc theo trường nào (gốc hay phái sinh)*/
SELECT 
ROUND (CAST (SUM (item_count*order_occurrences)/SUM(order_occurrences) AS DECIMAL),1) AS mean
FROM items_per_order;

/*EX5: Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. 
You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.
Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order*/
/*output (gốc/phái sinh phải tính ra): candidate_id
+ input: 
+ điều kiện lọc theo trường nào (gốc hay phái sinh) */
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) =3 --COUNT để lọc ra các candidate có cả 3 skills
ORDER BY candidate_id ASC;

/*Ex6: [Facebook SQL Interview Question] Given a table of Facebook posts, for each user who posted at least twice in 2021, 
write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. 
Output the user and number of the days between each user's first and last post*/



/*EX7: Cards Issued Difference [JPMorgan Chase SQL Interview Question] Your team at JPMorgan Chase is preparing to launch a new credit card, 
and to gain some insights, you're analyzing how many credit cards were issued each month.
Write a query that outputs the name of each credit card and the difference in the number of issued cards 
between the month with the highest issuance cards and the lowest issuance. Arrange the results based on the largest disparity*/
















