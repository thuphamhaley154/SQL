/*EX1: Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) 
rounded down to the nearest integer. Note: CITY.CountryCode and COUNTRY.Code are matching key columns. 
https://www.hackerrank.com/challenges/average-population-of-each-continent/problem?isFullScreen=true */
Select Country.Continent, 
FLOOR(AVG(City.Population)) 
From CITY 
INNER JOIN COUNTRY 
ON CITY.CountryCode = COUNTRY.Code 
GROUP BY COUNTRY.Continent;

/*EX2: [TikTok SQL Interview Question] Write a query to find the activation rate. Round the percentage to 2 decimal places. 
https://datalemur.com/questions/signup-confirmation-rate */
SELECT 
  ROUND(CAST(COUNT(b.email_id) AS DECIMAL)
    /COUNT(DISTINCT a.email_id),2) AS confirm_rate
FROM emails AS a 
LEFT JOIN texts AS b 
  ON a.email_id = b.email_id
  AND b.signup_action = 'Confirmed';


/*EX3: Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped 
by age group. Round the percentage to 2 decimal places in the output. 
https://datalemur.com/questions/time-spent-snaps */

select age_bucket,
round((sum(case when activity_type = 'send' then time_spent else 0 end) / sum(time_spent)) * 100 , 2) as send_perc,
round((sum(case when activity_type = 'open' then time_spent else 0 end) / sum(time_spent)) * 100 , 2) as open_perc
from (select a.activity_type,a.time_spent,b.age_bucket
from activities as a  
left join age_breakdown as b  
on a.user_id = b.user_id
where a.activity_type in ('send','open') ) AS age_group 
group by age_bucket;

/*EX4: Write a query that effectively identifies the company ID of such Supercloud customers. As of 5 Dec 2022, data in the customer_contracts and products tables were updated.
https://datalemur.com/questions/supercloud-customer */
SELECT customer_id
FROM (SELECT a.customer_id,
COUNT(DISTINCT b.product_category) AS unique_count
FROM customer_contracts AS a 
LEFT JOIN products AS b 
ON a.product_id = b.product_id
GROUP BY a.customer_id) AS supercloud
WHERE unique_count = (SELECT COUNT(DISTINCT product_category) FROM products)
ORDER BY customer_id;

/*EX5: For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.Write a solution to report the ids and the names 
of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer
https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/?envType=study-plan-v2&envId=top-sql-50 */
select a.employee_id, name, reports_count, average_age
from (select reports_to as employee_id, 
count(distinct employee_id) as reports_count,
round(avg(age)) as average_age
from Employees
group by reports_to
having reports_to is not null) a
left join Employees b 
on a.employee_id = b.employee_id
order by a.employee_id;

/*EX6: Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
https://leetcode.com/problems/list-the-products-ordered-in-a-period/description/?envType=study-plan-v2&envId=top-sql-50 */

select a.product_name, unit
from products as a
join (select product_id, order_date, sum(unit) as unit
  from orders 
  where order_date between '2020-02-01' and '2020-02-29'
  group by product_id) as b
on a.product_id = b.product_id
where unit >= 100
group by a.product_name;

c2: select a.product_name, sum(unit) as unit
from Products a
left join Orders b
on a.product_id = b.product_id
where b.order_date between '2020-02-01' and '2020-02-29'
group by a.product_id
having sum(unit) >= 100

/*EX7: Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.
https://datalemur.com/questions/sql-page-with-no-likes */
select a.page_id
from pages as a 
left join page_likes b
on a.page_id = b.page_id
where b.liked_date IS NULL 
ORDER BY a.page_id ASC  














