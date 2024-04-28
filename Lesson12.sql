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
