--SUBQUERIES & CTEs

--SUBQUERY IN WHERE: điều kiện lọc: cả hàm tổng hợp và hàm gốc ==> subquery. nếu SUBquery cần 1 kq nhất định, dùng dấu =; nếu 1 list thì dùng 'IN'
--Tìm những hóa đơn có số tiền > số tiền TB các hóa đơn
WHERE amount > (SELECT AVG(amount) FROM payment) 
