--WINDOW FUNCTION with SUM(), COUNT (), AVG()
/*Tính tỷ lệ số tiền thanh toán từng ngày, với tổng số tiền đã tt của mỗi KH
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






