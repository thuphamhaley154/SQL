--WINDOW FUNCTION with SUM(), COUNT (), AVG()
/*Tính tỷ lệ số tiền thanh toán từng ngày với tổng số tiền đã tt của mỗi KH
output: mã KH, tên KH, ngày tt, số tiền tt tại ngày, tổng số tiền đã tt, tỉ lệ */
SELECT a.customer_id, b.first_name, a.payment_date, a.amount,
(SELECT SUM(amount)
FROM payment x
WHERE x.customer_id=a.customer_id
GROUP BY customer_id),
a.amount/(SELECT SUM(amount)
FROM payment x
WHERE x.customer_id=a.customer_id
GROUP BY customer_id) AS ty_le
FROM payment AS a 
JOIN customer AS b ON a.customer_id=b.customer_id;

--C2: 
WITH twt_total_payment AS 
(SELECT customer_id,
SUM(amount) as total 
FROM payment 
GROUP BY customer_id)
SELECT a.customer_id, b.first_name, a.payment_date, a.amount, c.total,
a.amount/ c.total AS ty_le
FROM payment AS a
JOIN customer AS b ON a.customer_id=b.customer_id
JOIN twt_total_payment AS c ON c.customer_id=a.customer_id

--WINDOW FUNCTION 
SELECT a.customer_id, b.first_name, a.payment_date, a.amount,
SUM(a.amount) OVER (PARTITION BY a.customer_id) AS total --WF: gom nhóm theo customer_id; tương tự GROUP BY phải lke hết các trường như sau SELECT, nhưng WF chỉ cần gom nhóm theo 1 cái mk muốn 
FROM payment AS a
JOIN customer AS b ON a.customer_id=b.customer_id

----CHALLENGE 1: Query to return ds các films gồm: film_id, title, length, category, thời lượng tb của phim trong category đó. 
--Sắp xếp kq theo film_id. 
SELECT a.film_id, a.title, a.length, c.name as category,
ROUND(AVG (length) OVER (PARTITION BY c.name), 2) as avg_length --tim length film theo tung category
FROM film AS a 
JOIN public.film_category AS b ON a.film_id=b.film_id
JOIN public.category AS c ON b.category_id=c.category_id

--CHALLENGE 2: Query to return all các chi tiết các thanh toán bao gồm số lần thanh toán đc thực hiện bởi KH này và số tiền T/ứng đó 
--sắp xếp kq theo payment_id 

SELECT *,
COUNT (*) OVER (PARTITION BY customer_id, amount) as so_lan
FROM payment
ORDER BY payment_id

-- OVER (ODER BY...) 
--tính tổng doanh thu từ thời điểm trước đây đến hiện tại, lũy kế
SELECT payment_date, amount, customer_id,
--SUM(amount) OVER(ORDER BY payment_date) AS total_amount --ORDER BY: lũy kế dữ liệu amount
SUM(amount) OVER(PARTITION BY customer_id ORDER BY payment_date) AS total_amount--add PARTITION BY phân nhóm theo từng KH 
FROM payment 












