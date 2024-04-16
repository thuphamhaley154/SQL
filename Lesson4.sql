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
--Hãy cho biết khách hàng nào đã trả tổng số tiền >100$, trong thg 1-2020
SELECT * FROM payment

SELECT customer_id, --KO đc để payment_date vào đây, vì chỉ đc SELECT =GROUP BY
SUM (amount) AS total_amount
FROM payment
WHERE payment_date BETWEEN '2020-01-01' AND '2020-02-01'
GROUP BY customer_id
HAVING SUM (amount) >10
--HAVING:lọc trên trường infor TỔNG HỢP: SUM AVG, MIN, AMX --ALWAYS đứng sau GROUP BY
--WHERE sd lọc trên trường có sẵn


-- HAVING challenge: 2020, date 28,29,30/4 có doanh thu cao - giảm dần 
--> AVG khoản payment(amount);NHÓM THEO-GROUP BY khách hàng và ngày payment-chỉ xem xét những ngày mà KH có nhiều hơn 1 khoản payment
SELECT customer_id, DATE (payment_date),
AVG (amount) AS avg_amount,
COUNT (payment_id)--"chỉ xem xét những ngày mà KH có nhiều hơn 1 khoản payment"-->lq đến COUNT xem mỗi KH có bn khoản payment 'payment_id'
FROM payment
WHERE DATE (payment_date) IN ('2020-04-28', '2020-04-29', '2020-04-30') --hàm DATE để including GIỜ
GROUP BY customer_id, DATE (payment_date)
HAVING COUNT (payment_date) >1
ORDER BY customer_id DESC

--TOÁN TỬ VÀ HÀM SỐ HỌC
SELECT 3+7, 3-7, 3*7, 7%3, 7^3
SELECT film_id,
rental_rate,
ROUND (rental_rate*1.1,2) AS new_rental_rate,
CEILING (rental_rate*1.1)-0.1 AS new_rental_rate
FROM film
/*Challenge: Quản lý của bạn đang nghĩ đến việc tăng giá cho những bộ 
phim có chi phí thay thế cao. Vì vậy, bạn nên tạo một danh
sách các bộ phim có giá thuê ít hơn 4% chi phí thay thế--->tỷ lệ giá thuê/CP thay thế<4%
Tạo danh sách film_id đó cùng với tỷ lệ phần trăm (giá
thuê/chi phí thay thế) được làm tròn đến 2 chữ số thập phân*/
SELECT 
film_id, 
rental_rate, 
replacement_cost,
ROUND ((rental_rate/replacement_cost)*100,2) AS percentage
FROM film
WHERE ROUND ((rental_rate/replacement_cost)*100,2) <4 --KO đc lọc theo tên đã AS

--TỔNG KẾT THỨ TỰ THỰC HIỆN CÂU LỆNH
SELECT customer_id,
COUNT (*) AS total_record
FROM payment
WHERE payment_date >='2020-01-30'  --1.tt sau ngày 30 -->WHERE
GROUP BY customer_id
HAVING COUNT (*) <=15
ORDER BY total_record DESC
LIMIT 5;
--2.đếm xem có bn đơn đã tt -->COUNT
--3.Mỗi KH đã có bn hóa đơn tt-->GROUP BY 1 trường ~SELECT 
--4: chỉ hiện info các Kh có tổng số đơn tt <15 đơn -->HAVING, vì đang lọc theo ham Count rồi
--5: xếp thứ tự các đơn hàng -->ORDER BY
--6:chỉ hiện top 5--> LIMIT 5










