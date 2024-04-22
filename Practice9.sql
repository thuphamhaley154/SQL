/*EX1: Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and phone viewership. 
Output the total viewership for laptops as laptop_reviews and the total viewership for mobile devices as mobile_views. https://datalemur.com/questions/laptop-mobile-viewership */
SELECT 
SUM(CASE 
  WHEN device_type = 'laptop' THEN 1 ELSE 0 
END) AS laptop_reviews,
SUM(CASE 
  WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 
END) AS mobile_views
FROM viewership;

/*EX2: In SQL, (x, y, z) is the primary key column for this table. Each row of this table contains the lengths of three line segments.
 Report for every three line segments whether they can form a triangle. https://leetcode.com/problems/triangle-judgement/description/?envType=study-plan-v2&envId=top-sql-50 */
SELECT * ,
CASE 
    WHEN x+y > z AND x+z>y AND y+z>x THEN 'Yes'
    ELSE 'No'
END AS triangle
FROM Triangle

/*EX3: [UnitedHealth SQL Interview Question] Calls to the Advocate4Me call centre are categorised, but sometimes they can't fit neatly into a category. 
These uncategorised calls are labelled “n/a”, or are just empty (when a support agent enters nothing into the category field).Write a query to find the percentage of 
calls that cannot be categorised. Round your answer to 1 decimal place. https://datalemur.com/questions/uncategorized-calls-percentage  */


/*EX4: Find the names of the customer that are not referred by the customer with id = 2. https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan-v2&envId=top-sql-50  */
SELECT name FROM Customer
WHERE referee_id != 2 or referee_id is null

/*EX5: Make a report showing the number of survivors and non-survivors by passenger class.
Classes are categorized based on the pclass value as:
pclass = 1: first_class
pclass = 2: second_classs
pclass = 3: third_class
Output the number of survivors and non-survivors by each class. https://platform.stratascratch.com/coding/9881-make-a-report-showing-the-number-of-survivors-and-non-survivors-by-passenger-class?code_type=1  */
SELECT survived,
    SUM(CASE WHEN pclass = 1 THEN 1 ELSE 0 END) AS first_class,
    SUM(CASE WHEN pclass = 2 THEN 1 ELSE 0 END) AS second_class,
    SUM(CASE WHEN pclass = 3 THEN 1 ELSE 0 END) AS third_class
FROM titanic
GROUP BY survived;










