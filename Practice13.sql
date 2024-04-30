/*EX1: Write a query to retrieve the count of companies that have posted duplicate job listings.
Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.
https://datalemur.com/questions/duplicate-job-listings */
SELECT COUNT(DISTINCT company_id) AS duplicate_job_count
FROM job_listings
WHERE (title, description, company_id) IN (
    SELECT title, description, company_id
    FROM job_listings
    GROUP BY title, description, company_id
    HAVING COUNT(*) > 1)

/*EX2: Assume you're given a table containing data on Amazon customers and their spending on products in different category, 
write a query to identify the top two highest-grossing products within each category in the year 2022. The output should include the category, product, and total spend.
https://datalemur.com/questions/sql-highest-grossing */ 
--sp có doanh thu cao nhất của mỗi danh mục 
--<= tổng chi tiêu cho từng sản phẩm trong mỗi danh mục 
WITH product_ofspend AS
(SELECT category,product, 
SUM(spend) as total_spend 
FROM product_spend
WHERE EXTRACT(year FROM transaction_date) ='2022'
GROUP BY category,product),
/*RANK() để xếp hạng các sản phẩm trong mỗi danh mục dựa trên tổng chi tiêu, sắp xếp từ cao xuống thấp.
OVER(PARTITION BY ..)category đảm bảo rằng xếp hạng chỉ được tính riêng cho mỗi danh mục.*/ 
top_spend AS (SELECT *,  
  RANK() OVER (PARTITION BY category 
  ORDER BY total_spend DESC) AS ranking 
FROM product_ofspend)

SELECT category, product, total_spend 
FROM top_spend 
WHERE ranking <= 2 
ORDER BY category, ranking;

--EX3: https://datalemur.com/questions/frequent-callers
SELECT COUNT (policy_holder_id) AS policy_holder_count
FROM (SELECT policy_holder_id,
COUNT (case_id) AS case_id_count
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(case_id)>=3) AS case_count

--EX4: https://datalemur.com/questions/sql-page-with-no-likes 
select a.page_id
from pages as a 
left join page_likes b
on a.page_id = b.page_id
where b.liked_date IS NULL 
ORDER BY a.page_id ASC 

--EX5: https://datalemur.com/questions/user-retention


--EX6: https://leetcode.com/problems/monthly-transactions-i/?envType=study-plan-v2&envId=top-sql-50
select country,
left(trans_date, 7) as month,
count(1) as trans_count,
sum(case when state = 'approved' then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount, 
sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from Transactions
group by country, left(trans_date, 7)

--EX7: https://leetcode.com/problems/product-sales-analysis-iii/description/?envType=study-plan-v2&envId=top-sql-50 
WITH RankedSales AS (
    SELECT a.product_id, a.year AS first_year, a.quantity, a.price,
    RANK() OVER (PARTITION BY a.product_id ORDER BY a.year) AS row_num
    FROM Sales a)
SELECT b.product_id, b.first_year, b.quantity, b.price
FROM RankedSales b
WHERE b.row_num = 1;

--EX8: https://leetcode.com/problems/customers-who-bought-all-products/description/?envType=study-plan-v2&envId=top-sql-50 
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product);

--EX9: https://leetcode.com/problems/employees-whose-manager-left-the-company/description/?envType=study-plan-v2&envId=top-sql-50
select employee_id 
from Employees
where salary < 30000
and manager_id not in (select employee_id from Employees)
order by employee_id;

--EX10: https://datalemur.com/questions/duplicate-job-listings
SELECT COUNT(DISTINCT company_id) AS duplicate_job_count
FROM job_listings
WHERE (title, description, company_id) IN (
    SELECT title, description, company_id
    FROM job_listings
    GROUP BY title, description, company_id
    HAVING COUNT(*) > 1)

--EX11: https://leetcode.com/problems/movie-rating/?envType=study-plan-v2&envId=top-sql-50


--EX12:https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/?envType=study-plan-v2&envId=top-sql-50
WITH all_ids AS
(SELECT requester_id AS id
FROM RequestAccepted
UNION ALL
SELECT accepter_id AS id
FROM RequestAccepted)

SELECT id, num
FROM (SELECT id, COUNT(*) AS num FROM all_ids
GROUP BY id) AS counts
WHERE num = (SELECT MAX(num)
FROM (SELECT COUNT(*) AS num FROM all_ids
GROUP BY id) AS max_counts);
























