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
SELECT customer_id, staff_id,
SUM (amount) AS total_amount,
AVG (amount) AS average_amount,
MAX (amount) AS max_amount,
MIN (amount) AS min_amount,
COUNT (*) AS count_rental
FROM payment
GROUP BY customer_id, staff_id
ORDER BY customer_id
--cú pháp: tính/ tổng hợp dựa trên colume1 or colume 2 (NOte:khi muốn gom nhóm theo clue nào thì chỉ đc SELECT theo colume đó )
/*SELECT colume1, colume2 
SUM()
AVG ()
MIN ()
MAX ()
FROM table_mn
GROUP BY colume 1, colume 2*/

SELECT * FROM payment;

--GROUP BY challenge: max, min, sum, avg  chi phí thay thế(của 1 tài sản là CP để mua mới 1 ts với gtri tương đương ts đó)
SELECT film_id,
SUM (replacement_cost) AS total_cost,
ROUND (AVG (replacement_cost),2) AS avg_cost, --2 số thâp phân
MAX (replacement_cost) AS max_cost,
MIN (replacement_cost) AS min_cost
FROM film
GROUP BY film_id
ORDER BY film_id;


--HAVING
--Hãy cho biết khách hàng nào đã trả tổng số tiền >100$
SELECT * FROM payment
SELECT customer_id,
SUM (amount) AS total_amount
FROM payment
GROUP BY customer_id
HAVING SUM (amount) >100
--HAVING:lọc trên trường infor TỔNG HỢP: 
--WHERE sd lọc trên trường có sẵn









