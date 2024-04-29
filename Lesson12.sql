--SUBQUERIES (truy vấn con trong 1 truy vấn) & CTEs

--SUBQUERY IN WHERE: điều kiện lọc: cả hàm tổng hợp và hàm gốc ==> subquery. | Nếu SUBquery cần 1 kq nhất định, dùng dấu =; nếu 1 list thì dùng 'IN'
--Tìm những hóa đơn có số tiền > số tiền TB các hóa đơn
SELECT AVG(amount) FROM payment ;
SELECT * FROM payment 
WHERE amount > (SELECT AVG(amount) FROM payment) 

--Tìm những hóa đơn của KH có tên Adam, 
SELECT customer_id FROM customer --B1: tìm mã KH của ông Adam
WHERE first_name = 'ADAM';
SELECT * FROM payment 
WHERE customer_id IN (SELECT customer_id FROM customer -- Nếu SUBquery cần 1 kq nhất định, dùng dấu =; nếu 1 list thì dùng 'IN'
WHERE first_name = 'ADAM')

--CHALLENGE 1: Tìm những phim có thời lượng > thời lượng Trung bình các BỘ phim
SELECT film_id, title
FROM film 
WHERE length > (SELECT AVG(length) FROM film)
--CHALLENGE 2: Tìm những phim có ở STORE 2 ít nhất 3 lần. Output: film_id, title 
SELECT film_id, title 
FROM film 
WHERE film_id IN (SELECT film_id FROM public.inventory
WHERE store_id = 2 
GROUP BY film_id   
HAVING COUNT (*) >=3)

SELECT film_id FROM public.inventory
WHERE store_id = 2 
GROUP BY film_id  --ít nhất 3 lần, lọc theo đk tổng hợp =>HAVING 
HAVING COUNT (*) >=3

--CHALLENGE 3: Tìm những KH đến từ Califorlia và đã chi tiêu nhiều hơn 100$. 
SELECT customer_id, first_name, last_name, email
FROM customer 
WHERE customer_id IN (SELECT customer_id FROM public.payment
GROUP BY customer_id  --GROUP BY theo từng KH
HAVING SUM(amount) >100 )
--tổng chi tiêu chưa có=>tìm , tổng chi tiêu=>lọc theo đk tổng hợp HAVING 
SELECT customer_id FROM public.payment
GROUP BY customer_id  --GROUP BY theo từng KH
HAVING SUM(amount) >100 

--SUBQUERIES IN FROM 
-- Tìm những KH có nhiều hơn 30 hóa đơn 
--C1:
SELECT customer_id,
COUNT (payment_id) as so_luong --đếm số lượng hóa đơn 
FROM payment
GROUP BY customer_id
HAVING COUNT (payment_id)>30
--C2: 
select * from
(SELECT customer_id,
COUNT (payment_id) as so_luong 
FROM payment
GROUP BY customer_id) AS new_table 
WHERE so_luong>30
--Tìm thêm tên của các KH
select customer.first_name, new_table.so_luong from
(SELECT customer_id,
COUNT (payment_id) as so_luong 
FROM payment
GROUP BY customer_id) AS new_table 
INNER JOIN customer ON new_table.customer_id=customer.customer_id
WHERE so_luong>30


