--STRING FUCTIONS (xử lý data dạng chuỗi) & DATE/TIME FUNCTIONS (xử lý datas ngày giờ)
--LOWER (viết thường), UPPER(viết hoc), LENGTH
SELECT email,
LOWER (email) AS lower_email,
UPPER (email) AS upper_email,
LENGTH (email) AS length_email
FROM customer
WHERE LENGTH (email) >30;
--Liệt kê các KH có họ hoặc tên nhiều hơn 10 kí tự. KQ trả ra dạng chữ thường.
SELECT 
LOWER (first_name) AS first_name,
LOWER (last_name) AS last_name
FROM customer
WHERE LENGTH (first_name) >10
OR LENGTH (last_name) >10;

--LEFT (), RIGHT () - Chỉ muốn hiển thị 1 vài kí tự đầu/ cuối của 1 trường 
SELECT first_name,
RIGHT (LEFT (first_name,3),1)
FROM customer
--Trích xuất 5 kí tự cuối cùng của đ/c emal. đ/c email kt bằng ".org". Hãy trích xuất chỉ dấu "." từ đ/c email
SELECT 
RIGHT (LEFT (RIGHT (email,5),2),1)
FROM customer


--COCATENATE (NỐI CHUỖI)--1 ds cách KH với họ và tên full 
SELECT 
customer_id,
first_name,
last_name,
--first_name || ' ' || last_name AS full_name 
CONCAT (first_name || ' ' || last_name) AS full_name
FROM customer
-- MASK data của KH:  MARY.SMITH@... -->MAR***H@...
SELECT  
email,
LEFT (email,3) || '***' || RIGHT (email,20)
FROM customer

--REPLACE -- hàm '.org'-->'.com'
SELECT 
email,
REPLACE (email, '.org', '.com') AS new_email
FROM customer

--POSITION: tìm vị trí 1 kí tự đặc biệt nào đấy ở trong 1 trường
SELECT 
email,
LEFT (email, POSITION ('@' IN email )-1) -- 1.tìm vị trí của @ trên email| 2. Tìm  các kí tự bên trái @
FROM customer

--SUBSTRINGS
--Lấy ra kí tự từ 2 đến 4 của first_name
SELECT
first_name,
--RIGHT(LEFT (first_name, 4),2)
SUBSTRING (first_name FROM 2 for 3) --bắt đầu từ kí tự thứ 2, với độ dài 3 kí tự
FROM customer
--Lấy ra tt họ của KH qua email
SELECT
email,
POSITION ('.' IN email),
POSITION ('@' IN email),
POSITION ('@' IN email) - POSITION ('.' IN email)-1,
SUBSTRING (email FROM POSITION ('.' IN email)+1 for POSITION ('@' IN email) - POSITION ('.' IN email)-1)
FROM customer
--Challenge: Giả sử chỉ có email và Họ Kh --> Trích xuất ra Tên --> Họ, Tên
SELECT email,
last_name,
--POSITION ('.' IN email), -- tìm vị trí dấu "." trước --> "."-1
SUBSTRING (email FROM 1 FOR POSITION ('.' IN email)-1) AS frist_name,
SUBSTRING (email FROM 1 FOR POSITION ('.' IN email)-1) || ',' || last_name
FROM customer;


--EXTRACT (hàm xử lý TIME/DATE)
--SELECT EXTRACT (field FROM DATE/TIME/TIMESTAMP(gồm ngày+giờ)/INTERVAL(ktg))
SELECT rental_date,
EXTRACT (month  FROM rental_date), -- hiển thị tháng của ngày cho thuê
EXTRACT (year  FROM rental_date), -- ngày cho thuê đang ở năm thứ bn
EXTRACT (hour  FROM rental_date) 
FROM rental
--Năm 2020, có bn đơn hàng (COUNT) cho thuê trong mỗi tháng (gom nhóm mỗi tháng trc-GROUP by)
SELECT EXTRACT (month FROM rental_date),
COUNT (*)
FROM rental
WHERE EXTRACT (year FROM rental_date) = '2020'
GROUP BY EXTRACT (month FROM rental_date) -- sau WHERE
/*CHALLENGE: -tháng nào có tổng số tiền tt cao nhất (gom nhom theo Tháng)
- Ngày nào tròn tuần có tổng số tiền tt cao nhất (0 là chủ nhật)
- số tiền tt cao nhât mà KH đã chi tiêu trong 1 tuần là bn --gom nhóm theo KH, theo tuần của năm*/
SELECT EXTRACT (month FROM payment_date) AS month_of_year,
SUM (amount) AS total_amount
FROM payment
GROUP BY EXTRACT (month FROM payment_date)
ORDER BY SUM (amount) DESC
--DOW ngày trong tuần 
SELECT EXTRACT (day FROM payment_date) AS day_of_week,
SUM (amount) AS total_amount
FROM payment
GROUP BY EXTRACT (day FROM payment_date)
ORDER BY SUM (amount) DESC
--
SELECT customer_id, EXTRACT (week FROM payment_date),
SUM (amount) AS total_amount
FROM payment 
GROUP BY customer_id, EXTRACT (week FROM payment_date)
ORDER BY SUM (amount)  DESC

--TO_CHAR: chuyển định dạng mà mk muốn vd:ngày/thg/năm -->...
SELECT payment_date,
EXTRACT (day FROM payment_date),
--TO_CHAR (payment_date, 'dd-mm-yyyy hh-mm-ss') 
TO_CHAR (payment_date, 'Month') 
FROM payment


--INTERVAL & TIMESTAMP: tìm ktg giữ 2 ngày bất kì
SELECT current_date, current_timestamp,
customer_id,
rental_date,
return_date,
--return_date - rental_date -- thuê trong tg bao lâu?
--thuê trong bn giờ?
EXTRACT(DAY FROM return_date - rental_date)*24+
EXTRACT(HOUR FROM return_date - rental_date) || 'giờ'
FROM rental;
/*CHALLEGE: ds tất cả THỜI GIAN đã thuê của KH với customer_id 35. 
Tìm hiều KH nào có tg thuê trung bình dài nhất --gom nhóm theo KH */
SELECT customer_id, rental_date, return_date,
return_date - rental_date AS rental_time
FROM rental
WHERE customer_id ='35'
--
SELECT customer_id,
AVG (return_date - rental_date) AS avg_rental_time
FROM rental
GROUP BY customer_id
ORDER BY customer_id DESC


















