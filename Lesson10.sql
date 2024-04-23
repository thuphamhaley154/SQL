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


--LEFT JOIN - RIGHT JOIN (table1 LEFT JOIN table2)
SELECT t1.*, t2.* --thể hiện tt của t1,t2 sau khi lấy t1 LEFT JOIN t2 thông qua(ON) key1(t1),key2(t2)
FROM table1 AS t1 --table1: gốc
LEFT JOIN table2 AS t2 --table2: bảng tham chiếu 
ON t1.key1=t2.key2 --ON thể hiện mqh giữa t1,t2 qua các keys
--
SELECT t1.*, t2.* 
FROM table1 AS t1 --table1: bảng tham chiếu 
RIGHT JOIN table2 AS t2 --table2: bảng GỐC
ON t1.key1=t2.key2
--Tìm thông in các chuyến bay của từng máy bay 
--B1: xác định Table
--B2: xác định key JOIN: aircraft_code
--B3: chọn phương thức/loại JOIN 
SELECT a.aircraft_code, b.flight_no
FROM bookings.aircrafts_data AS a
LEFT JOIN bookings.flights AS b
ON a.aircraft_code=b.aircraft_code
WHERE b.flight_no IS NULL --tìm máy bay đang ko có chuyến bay nào

/*CHALLENGE: -tìm hiếu ghế nào đc chọn thường xuyên nhất (ensure all seats là đc liệt kê even chúng never được đặt)
-có seat nào never đc đặt ko?
-chỉ ra HÀNG ghế đc đặt thường xuyên nhất*/
SELECT a.seat_no, --liệt kê các tt số ghế
COUNT (flight_id) AS so_luong --đếm xem có bn chuyến bay 
FROM bookings.seats AS a
LEFT JOIN bookings.boarding_passes AS b
ON a.seat_no=b.seat_no
GROUP BY a.seat_no
--ghế nào đc đăt thường xuyên nhất=> xsếp từ cao --> thấp
ORDER BY COUNT (flight_id) DESC,
--ghế ngồi never đc đặt: seat_no bảng a, ko có ở table b(bị Null)
SELECT a.seat_no
FROM bookings.seats AS a
LEFT JOIN bookings.boarding_passes AS b
ON a.seat_no=b.seat_no
WHERE b.seat_no IS NULL;
--chỉ ra HÀNG ghế đc đặt thường xuyên nhất
SELECT RIGHT(a.seat_no,1) AS line, --liệt kê các tt số ghế
COUNT (flight_id) AS so_luong --đếm xem có bn chuyến bay 
FROM bookings.seats AS a
LEFT JOIN bookings.boarding_passes AS b
ON a.seat_no=b.seat_no
GROUP BY RIGHT(a.seat_no,1)
ORDER BY COUNT (flight_id) DESC;


--FULL JOIN (table1 FULL JOIN table2)
SELECT t1.*, t2.* 
FROM table1 AS t1 
FULL JOIN table2 AS t2 
ON t1.key1=t2.key2
--vd: 
SELECT * FROM bookings.boarding_passes AS a
FULL JOIN bookings.tickets AS b
ON a.ticket_no=b.ticket_no
--Tìm những vé máy bay mà ko đc cấp thẻ lên máy bay, đếm xem bn người=>COUNT(mean:có ticket_no,nhưng ko có boarding_no; có ở table a nhưng ko có ở table b)
SELECT COUNT(*) 
FROM bookings.boarding_passes AS a
FULL JOIN bookings.tickets AS b
ON a.ticket_no=b.ticket_no
WHERE a.ticket_no IS NULL

--JOIN ON MULTIPLE CONDITIONS
--Tính GIÁ$ trung bình của từng số ghế máy bay 
--B1: xác định output: số ghế, giá trung bình | input 
SELECT * FROM bookings.seats 
SELECT * FROM bookings.ticket_flights 
ORDER BY ticket_no 
/*PK:khóa chính trong table (chỉ có 1 thì mới JOIN đc), 
table bookings.ticket_flights có 2 PK mean: có mã máy bay ở trong 2 bản ghi/dòng(1 vé máy bay trong 2 chuyến bay: vé quá cảnh-transit)*/   
--> ko có tt nào để match giữa 2 table này 
SELECT a.seat_no, 
AVG(b.amount) AS avg_amount  --liệt kê số ghế, giá ghế
FROM bookings.boarding_passes AS a
LEFT JOIN bookings.ticket_flights AS b
ON a.ticket_no=b.ticket_no 
AND a.flight_id=b.flight_id
--giá ghế TB
GROUP BY a.seat_no
ORDER BY AVG(b.amount) DESC


--JOIN MULTIPLE TABLE(ko phân biệt table bào gốc hay tham chiếu)
--liệt kê 5 trường tt: số vé, tên KH, giá vé, giờ bay, giờ kết thúc
SELECT a.ticket_no, a.passenger_name, b.amount,
c.scheduled_departure, c.scheduled_arrival
FROM bookings.tickets AS a
INNER JOIN bookings.ticket_flights AS b ON a.ticket_no=b.ticket_no
INNER JOIN bookings.flights AS c ON b.flight_id=c.flight_id
/*CHALLENGE: Những KH nào đến từ Brazil? -query để lấy first_name, last_name, email, quốc gia từ all KH đén từ Brazil*/
SELECT a.first_name, a.last_name, a.email, d.country
FROM public.customer AS a
INNER JOIN public.address AS b ON b.address_id=a.address_id
INNER JOIN public.city AS c ON c.city_id=b.city_id
INNER JOIN public.country AS d ON c.country_id=d.country_id
WHERE d.country = 'Brazil'

--SELF JOIN: join 2 tables giống nhau vào 1
SELECT emp.employee_id, emp.name, emp.manager_id, mng.name AS mng_name
FROM employee AS emp
LEFT JOIN employee AS mng
ON emp.manager_id=mng.employee_id
--CHALLEGE: Tìm films có cùng thời lượng phim 
--output: table1, table2, length
SELECT F1.title as title1, F2.title as titile2, F1.length
FROM film AS F1
JOIN film AS F2
ON F1.length=F2.length
WHERE F1.title<>F2.title


--UNION: ghép 2 hay nhiều table theo chiều dọc vertical 
/*Note: - số lượng colume ở 2 tables phải bằng nhau
- kiểu dữ liệu trong cùng 1 cột phải giống nhau
- UNION loại bỏ 'Trùng' nhau, UNION ALL thì không */
SELECT col1, col2, ... coln
FROM table1
UNION/UNION ALL
SELECT col1, col2, ... coln
FROM table2
UNION/UNION ALL
SELECT col1, col2, ... coln 
FROM table3
--VD: 
SELECT first_name, 'actor' AS source FROM actor
UNION 
SELECT first_name, 'customer' AS source FROM customer 
UNION 
SELECT first_name, 'staff' AS source FROM staff
ORDER BY first_name















