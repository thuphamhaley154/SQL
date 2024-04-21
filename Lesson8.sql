/*LOGICAL FUNCTIONS & PIVOT TABLE 
- Dùng CASE-WHEN để phân nhóm theo từng category
- COALESE để xử lý các data bị NULL
- CAST để chuyển đổi kiểu data, vd:số -->chuỗi, ngc lại,...
- PIVOT TABLE để định hình dữ liệu */
/*Hãy ploai các bộ phim theo thời lượng short-medium-long
- short:<60 phút
- medium: 60-120 phút
- long: >120 phút => CASE 
						WHEN...THEN   
					 END...*/
SELECT film_id, 
CASE
	WHEN length<60 THEN 'short'
	WHEN length between 60 and 120 THEN 'medium'
	WHEN length>120 THEN 'long' --=ELSE 'long'
END category
FROM film
--đếm mỗi category thì có bn film
SELECT  
CASE
	WHEN length<60 THEN 'short'
	WHEN length between 60 and 120 THEN 'medium'
	WHEN length>120 THEN 'long' --=ELSE 'long'
END category,
COUNT (*) AS so_luong
FROM film
GROUP BY category
--bộ phim có tag là 1 khi có trường rating là G or PG. tag là 0 với còn lại
SELECT film_id,
CASE
	WHEN rating IN ('PG', 'G') THEN 1
	ELSE 0 --WHEN rating NOT IN ('PG', 'G') THEN 0
END tag
FROM film
--CHALLENGE: 
/*1.Cty đã bán bn vé trong các danh mục sau:
- Low price ticket: total_amount<20,000
- Mid price ticket: total_amount between 20,000 and 150,000
- high price ticket: total_amount> 150,000*/
SELECT
COUNT (*) AS so_luong,
CASE
	WHEN amount<20000 THEN 'Low price ticket'
	WHEN amount BETWEEN 20000 and 150000 THEN 'Mid price ticket'
	ELSE 'High price ticket'
END category
FROM bookings.ticket_flights
GROUP BY category

/*2. bn chuyến bay đã khởi hành trong các mùa sau
- Xuân: 2,3,4
- Hè: 5,6,7
_ Thu: 8,9,10
- Đông: 11,12,1*/
SELECT 
COUNT (*) AS so_flights,
CASE
	WHEN EXTRACT (month FROM scheduled_departure) IN (2,3,4) THEN 'Xuân'
	WHEN EXTRACT (month FROM scheduled_departure) IN (5,6,7) THEN 'Hè'
	WHEN EXTRACT (month FROM scheduled_departure) IN (8,9,10) THEN 'Thu'
	WHEN EXTRACT (month FROM scheduled_departure) IN (11,12,1) THEN 'Đông'
END season
FROM bookings.flights
GROUP BY season

/*3.Tạo 1 ds phim và phân cấp theo các cách sau:
1.Xếp hạng là 'PG' or 'PG-13' hoặc thời lượng hơn 210p: 'Great rating or long(tier 1)'
2.Mô tả chứa 'Drama' và thời lượng>90p: Long drama (tier 2)
3. Mô tả chứa 'Drama' và thời lượng ko quá 90p: Shcity drama (tier 3)
4.Giá thuê thấp hơn $1: 'Very cheap (tier 4)
Nếu 1 film ở nhiều DMuc, có đc chỉ định ở mức cao hơn.
Làm cách nào để lọc film chỉ ở trong 4 cấp đô này */
SELECT film_id,
CASE
	WHEN rating IN ('PG', 'PG-13')	OR LENGTH>210 THEN 'Great rating or long (tier 1)'
	WHEN description LIKE '%Drama%' AND LENGTH>90 THEN 'Long Drama (tier 2)'
	WHEN description LIKE '%Drama%' AND LENGTH<=90 THEN 'Shcity drama (tier 3)'
	WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END category
FROM film
WHERE CASE
	WHEN rating IN ('PG', 'PG-13')	OR LENGTH>210 THEN 'Great rating or long (tier 1)'
	WHEN description LIKE '%Drama%' AND LENGTH>90 THEN 'Long Drama (tier 2)'
	WHEN description LIKE '%Drama%' AND LENGTH<=90 THEN 'Shcity drama (tier 3)'
	WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END IS NOT NULL



-- PIVOT BY CASE-WHEN (PIVOT TABLE: trải dài các datas sang nhiều sự dễ theo dõi,vd: như dọc sang ngang,.. )
/*Tính tổng số tiền theo từng loại hóa đơn high-medium-low của từng KH (có chữ từng KH, từng loại ~ GROUP BY)
- high: amount >10
- medium: 5 <=amount <=10
- low: amount <5 */
SELECT customer_id,
CASE
	WHEN amount>10 THEN 'high'
	WHEN amount BETWEEN 5 AND 10 THEN 'medium'
	WHEN amount<5 THEN 'low'
END category,
SUM (amount) AS total_amount
FROM payment
GROUP BY customer_id, category --có SUM thì phải GROUP BY
--Cách 2: PIVOT theo CASE-WHEN
SELECT customer_id,
SUM(CASE
	WHEN amount>10 THEN amount
	ELSE 0
END) AS high,
SUM(CASE
	WHEN amount BETWEEN 5 AND 10 THEN amount
	ELSE 0
END) AS medium,
SUM(CASE
	WHEN amount<5 THEN amount
	ELSE 0
END) AS low
FROM payment
GROUP BY customer_id
ORDER BY customer_id

/*CHALLENGE: Thống kê có bn bộ phim đc đgia là R, PG, PG-13 ở các thể loại phim long - medium - short
-bảng thống kê theo chiều Horizontal : category, r, pg, pg-13 (category là chuỗi có sẵn trong table nên ploai theo CASE-WHEN)
+long: length>120
+ medium: 60 <=length<=120
+ short : length>120*/
SELECT 
CASE
	WHEN length>120 THEN 'long'
	WHEN length BETWEEN 60 AND 120  THEN 'medium'
	ELSE 'short'
END AS category,
SUM(CASE
	WHEN rating= 'R' THEN 1 ELSE 0
END) AS r,
SUM(CASE
	WHEN rating= 'PG' THEN 1 ELSE 0
END) AS pg,
SUM(CASE
	WHEN rating= 'PG-13' THEN 1 ELSE 0
END) AS pg_13
FROM film
GROUP BY category

--
















