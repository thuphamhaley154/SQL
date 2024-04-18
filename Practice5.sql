--Ex1: a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
SELECT DISTINCT CITY FROM STATION
WHERE ID%2=0;
--EX2: the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
SELECT COUNT (CITY) - COUNT (DISTINCT CITY)
FROM STATION;
/*Ex3: Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table,
but did not realize her keyboard's  key was broken until after completing the calculation. She wants your help finding 
the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
Write a query calculating the amount of error, round it up to the next integer.*/


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
/*output (gốc/phái sinh phải tính ra): the user, days_between =MAX(day)-MIN(day..)
number of the days between each user's first and last post.
+ input: 
+ điều kiện lọc theo trường nào (gốc hay phái sinh)*/

SELECT user_id,
DATE (MAX(post_date))- DATE(MIN(post_date)) AS  days_between --hamf DATE để có cả giờ 
FROM posts
WHERE post_date>='2021-01-01' AND post_date<'2022-01-01'
GROUP BY user_id
HAVING COUNT (post_id)>=2


/*EX7: Cards Issued Difference [JPMorgan Chase SQL Interview Question] Your team at JPMorgan Chase is preparing to launch a new credit card, 
and to gain some insights, you're analyzing how many credit cards were issued each month.
Write a query that outputs the name of each credit card and the difference in the number of issued cards 
between the month with the highest issuance cards and the lowest issuance. Arrange the results based on the largest disparity*/
/*output (gốc/phái sinh phải tính ra): card_name, difference
+ điều kiện lọc theo trường nào (gốc hay phái sinh)*/
SELECT card_name,
Max(issued_amount)- Min(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC

/*EX8: Pharmacy Analytics (Part 2) [CVS Health SQL Interview Question]Write a query to identify the manufacturers associated with 
the drugs that resulted in losses for CVS Health and calculate the total amount of losses incurred. Output the manufacturer's name, 
the number of drugs associated with losses, and the total losses in absolute value. Display the results sorted in descending order with
the highest losses displayed at the top.*/
/*output (gốc/phái sinh phải tính ra):manufacturer,drug_count,total_loss
+ điều kiện lọc theo trường nào (gốc hay phái sinh): total_sales<cogs*/

SELECT manufacturer,
COUNT (drug) AS drug_count,
ABS(SUM(cogs - total_sales)) AS total_loss
FROM pharmacy_sales
WHERE total_sales <cogs
GROUP BY manufacturer
ORDER BY total_loss DESC 

/*EX9: Not Boring Movies: Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".
Return the result table ordered by rating in descending order*/
/*output (gốc/phái sinh): odd-numbered ID, a description that is not "boring"
+ điều kiện lọc theo trường nào (gốc hay phái sinh) */

SELECT id, movie, description, rating
FROM Cinema
WHERE ID%2=1
AND description <> 'boring'
ORDER BY rating DESC

/*EX10: Write a solution to calculate the number of unique subjects each teacher teaches in the university.
+-------------+------+
| Column Name | Type |
+-------------+------+
| teacher_id  | int  |
| subject_id  | int  |
| dept_id     | int  |
+-------------+------+Each row in this table indicates that the teacher with teacher_id teaches the subject subject_id in the department dept_id*/
/*output (gốc/phái sinh): teacher_id, cnt
+ điều kiện lọc theo trường nào (gốc hay phái sinh) */
SELECT teacher_id,
COUNT (DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;

/*EX11: Write a solution that will, for each user, return the number of followers. Return the result table ordered by user_id in ascending order.
| Column Name | Type |
+-------------+------+
| user_id     | int  |
| follower_id | int  |
+-------------+------+(user_id, follower_id) is the primary key (combination of columns with unique values) for this table.
This table contains the IDs of a user and a follower in a social media app where the follower follows the user*/
/*output (gốc/phái sinh):  user_id , cnt
+ điều kiện lọc theo trường nào (gốc hay phái sinh) */
SELECT  user_id,  
COUNT (follower_id) AS followers_count
FROM Followers
GROUP BY user_id 
ORDER BY  user_id  ASC

/*EX12: Write a solution to find all the classes that have at least five students.
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+(student, class) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled*/
/*output (gốc/phái sinh):  class
+ điều kiện lọc theo trường nào (gốc hay phái sinh) */
SELECT class FROM Courses
GROUP BY class --nhóm lớp để đếm số hs mỗi lớp đã--> đến đếm số hs mỗi lớp 
HAVING COUNT (student)>=5
 

















