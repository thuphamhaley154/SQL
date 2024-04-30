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










