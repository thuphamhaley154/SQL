--EX1: https://datalemur.com/questions/yoy-growth-rate
WITH t AS (SELECT  product_id,
EXTRACT (year FROM transaction_date) AS year,
spend AS curr_year_spend,
LAG(spend) OVER(PARTITION BY product_id ORDER BY product_id,
EXTRACT (year FROM transaction_date)) AS prev_year_spend
FROM user_transactions)

SELECT year, product_id, curr_year_spend, prev_year_spend, 
ROUND((curr_year_spend-prev_year_spend)
/prev_year_spend *100,2) as yoy_rate
FROM t ;

--EX2: https://datalemur.com/questions/card-launch-success
