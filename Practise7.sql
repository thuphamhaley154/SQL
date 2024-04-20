/*EX1: Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. 
If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID*/
SELECT Name
FROM STUDENTS
WHERE Marks >75
ORDER BY RIGHT (Name,3),  ID ASC

/*EX2: This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase. Return the result table ordered by user_id.*/
SELECT user_id,
CONCAT (UPPER (LEFT(name,1)), LOWER(RIGHT(name,LENGTH(name)-1))) AS name
--CONCAT (UPPER(LEFT(name,1)), LOWER(SUBSTRING(name FROM 2)) ) AS name
FROM Users
ORDER BY user_id;
--SUBsTRING ('learn data' FROM 3 for 5) => arn d
--= SUBSTRING ('learn data',3,5) => arn d
-- SUBSTRING ('learn data',3) => arn data -- đc hiểu là lấy từ 3 trở đi 

/*EX3: (Part 3) [CVS Health SQL Interview Question] Write a query to calculate the total drug sales for each manufacturer. 
Round the answer to the nearest million and report your results in descending order of total sales. In case of any duplicates, sort them alphabetically 
by the manufacturer name. Since this data will be displayed on a dashboard viewed by business stakeholders, please format your results as follows: "$36 million".*/
SELECT manufacturer,
'$'||ROUND(SUM(total_sales)/1000000,0)||' '||'million' AS sale_mil
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC;

/*EX4: [Amazon SQL Interview Question]  write a query to retrieve the average star rating for each product, grouped by month. 
The output should display the month as a numerical value, product ID, and average star rating rounded to two decimal places. 
Sort the output first by month and then by product ID.*/
--output: groupby: mth, product 
SELECT 
product_id,
EXTRACT (month FROM submit_date) AS mth,
ROUND (AVG (stars),2) AS avg_stars
FROM reviews
GROUP BY product_id, EXTRACT (month FROM submit_date)
ORDER BY EXTRACT (month FROM submit_date), product_id

/*EX5: [Microsoft SQL Interview Question] Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022.
Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending order based on the count of the messages.
Assumption:No two users have sent the same number of messages in August 2022.*/
--output: sender_id, message_count
--input: messages
--đk lọc: 8/2022, 2 ng dùng nhiều nhất 
SELECT sender_id,
COUNT(sender_id) AS message_count --đếm theo ng gưi tin 
FROM messages
WHERE EXTRACT (month FROM sent_date)=8
AND EXTRACT (year FROM sent_date)=2022
GROUP BY sender_id
ORDER BY COUNT(sender_id) DESC
LIMIT 2 --chỉ lấy 2

--EX6: Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.
SELECT tweet_id
FROM Tweets
WHERE LENGTH (content)>15 ;

/*EX7: The table shows the user activities for a social media website. Note that each session belongs to exactly one user. Write a solution to find the daily
active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day*/
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users 
FROM Activity
WHERE activity_date between '2019-06-28' and '2019-07-27' --WHERE DATEDIFF("2019-07-27", activity_date) < 30 
GROUP BY activity_date;

/*EX8: You have been asked to find the number of employees hired between the months of January and July in the year 2022 inclusive.
Your output should contain the number of employees hired in this given time frame.*/
SELECT 
COUNT (id) AS number_employees
FROM employees
WHERE EXTRACT (month FROM joining_date) between 1 and 7
AND EXTRACT (year FROM joining_date)=2022 

--EX9: Find the position of the lower case letter 'a' in the first name of the worker 'Amitah'. 
select
POSITION ('a' IN first_name) AS position
from worker
WHERE first_name ='Amitah'

--Ex10: Find the vintage years of all wines from the country of Macedonia. The year can be found in the 'title' column. 
--Output the wine (i.e., the 'title') along with the year. The year should be a numeric or int data type.
select 
title AS the_wine,
SUBSTRING(title,LENGTH(winery)+2,4) AS vintage_year
from winemag_p2
WHERE country='Macedonia'


















