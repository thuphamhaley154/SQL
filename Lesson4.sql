--Aggregate functions: hàm tổng hợp
SELECT 
MAX (amount) AS max_amount,
MIN (amount) AS min_amount,
SUM (amount) AS total_amount,
AVG (amount) AS average_amount,
COUNT (*) AS total_record, --Trong bảng có bn kháchhàng khác nhau
COUNT (DISTINCT customer_id) AS total_record_customer
FROM payment
WHERE payment_date BETWEEN '2020-01-01' AND '2020-02-01'
AND amount >0;

--GROUP BY
--hãy cho biết số lượng đơn hàng của mỗi kh là bn?
SELECT customer_id,
SUM (amount) AS total_amount
FROM payment
GROUP BY customer_id;
--





