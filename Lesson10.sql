--INNER JOIN (table 1 INNER JOIN table2)
SELECT t1.*, t2.* --thể hiện tt của t1,t2 sau khi lấy t1 connect t2 thông qua(ON) key1(t1),key2(t2)
FROM table1 AS t1
INNER JOIN table2 AS t2
ON t1.key1=t2.key2 --ON thể hiện mqh giữa t1,t2 qua các keys
---
SELECT * FROM payment 
SELECT a.payment_id, a.customer_id, b.first_name, b.last_name
FROM payment AS a
INNER JOIN customer AS b
ON a.customer_id=b.customer_id --customer_id: key giống nhau của 2 bảng
--CHALLENGE: có bn người chọn seat theo các loại: Business, Economy, Comfort?
--output: loại ghế: fare_conditions, số lượng người chọn(count)
SELECT * FROM bookings.seats;
SELECT a.fare_conditions,
COUNT (flight_id) AS so_luong FROM bookings.seats AS a
INNER JOIN bookings.boarding_passes AS b 
ON a.seat_no=b.seat_no
GROUP BY a.fare_conditions;

