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
WITH card_launch AS (
SELECT card_name, issued_amount,
MAKE_DATE(issue_year, issue_month, 1) AS issue_date,
MIN(MAKE_DATE(issue_year, issue_month, 1)) OVER (PARTITION BY card_name) AS launch_date  --MAKE_DATE(year, month, day) sử dụng để tạo ngày đầu tiên của mỗi tháng
FROM monthly_cards_issued)
SELECT card_name, issued_amount
FROM card_launch
WHERE issue_date = launch_date
ORDER BY issued_amount DESC;

--EX3: https://datalemur.com/questions/sql-third-transaction

WITH t AS (SELECT user_id, spend, transaction_date, 
ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS row_num 
FROM transactions)
 
SELECT user_id, spend, transaction_date 
FROM t 
WHERE row_num = 3;


--EX4: https://datalemur.com/questions/histogram-users-purchases

WITH t AS (SELECT transaction_date, user_id, product_id, 
RANK() OVER (PARTITION BY user_id 
      ORDER BY transaction_date DESC) AS transaction_rank 
FROM user_transactions) 
  
SELECT transaction_date, user_id,
COUNT(product_id) AS purchase_count
FROM t 
WHERE transaction_rank = 1 
GROUP BY transaction_date, user_id
ORDER BY transaction_date;

--HARD: EX5: https://datalemur.com/questions/rolling-average-tweets



--EX7: https://datalemur.com/questions/sql-highest-grossing

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

--HARD -EX6: https://datalemur.com/questions/repeated-payments
 
SELECT COUNT(*) AS payment_count
FROM (SELECT t1.transaction_id FROM transactions t1
JOIN transactions t2 ON t1.merchant_id = t2.merchant_id
AND t1.credit_card_id = t2.credit_card_id
AND t1.amount = t2.amount
AND ABS(EXTRACT(EPOCH FROM (t1.transaction_timestamp - t2.transaction_timestamp)) / 60) <= 10
WHERE t1.transaction_id < t2.transaction_id) AS repeated_payments;

--EX8: https://datalemur.com/questions/top-fans-rank
WITH t AS (SELECT artists.artist_name,
DENSE_RANK() OVER (ORDER BY COUNT(songs.song_id) DESC) AS artist_rank
FROM artists
INNER JOIN songs ON artists.artist_id = songs.artist_id
INNER JOIN global_song_rank AS ranking ON songs.song_id = ranking.song_id
WHERE ranking.rank <= 10
GROUP BY artists.artist_name)

SELECT artist_name, artist_rank
FROM t
WHERE artist_rank <= 5;





