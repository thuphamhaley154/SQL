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


--SUBQUERIES IN SELECT  
--Add 1 trường thông tin nữa tên là 'cl1' và gtrị của cl1 đó tại all các bản ghi là 4 
SELECT * , 4 AS cl1 
FROM payment;
--add trường thông tin AVG(amount) 
SELECT *,
(select avg(amount) from payment)
FROM payment 
--Tính chênh lệch giữ avg và số tiền của mỗi hóa đơn
SELECT *,
(select avg(amount) from payment), --,miễn là kq trả ra trong câu lệnh truy vấn con chỉ là 1 gtri thôi
(select avg(amount) from payment) - amount 
FROM payment

--CHALLENGE: tìm chênh lệch giữa số tiền từng hóa đơn so với số tiền thanh toán lớn nhất mà ct nhận đc
SELECT payment_id, amount,
(SELECT MAX(amount) FROM payment) AS max_amount,
(SELECT MAX(amount) FROM payment) - amount AS difference 
FROM payment 


/*CORRELATED SUBQUERIES in WHERE/ in SELECT
+ in WHERE thường dùng cho các điều kiện LỌC 
+ in SELECT: ở phần hiển thị  */
  
--CORRELATED SUBQUERIES IN WHERE (truy vấn con tương quan)
--lấy ra thông tin KH từ table: customer có tổng hóa đơn >100$
--C1: 
SELECT a.customer_id,
SUM(b.amount) AS total_amount 
FROM customer AS a
JOIN payment AS b
ON a.customer_id=b.customer_id
GROUP BY a.customer_id 
HAVING SUM(b.amount)>100
--C2: sd SUBQUERY: b1: list ds KH có  tổng amount>100 ở bảng payment, b2: tìm những KH tương ứng ở bảng customer
SELECT customer_id,
SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount)>100;

SELECT * 
FROM customer 
WHERE customer_id IN (SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount)>100)
-- or có thể dùng '=' thay cho 'IN'
SELECT * 
FROM customer as a
WHERE customer_id = (SELECT customer_id
FROM payment as b 
WHERE a.customer_id= b.customer_id
GROUP BY customer_id
HAVING SUM(amount)>100)

--NOTE: CÓ THỂ THAY 'customer_id =' BẰNG lệnh 'EXISTS' - CHỈ CÓ sd Ở CORRELATED SUBQUERY  
SELECT * 
FROM customer as a
WHERE EXISTS(SELECT customer_id
FROM payment as b 
WHERE a.customer_id= b.customer_id
GROUP BY customer_id
HAVING SUM(amount)>100)

--CORRELATED SUBQUERIES IN SELECT 
--mã KH, tên KH, mã thanh toán, số tiền lớn nhất của từng KH

--SỐ tiền lớn nhất của từng KH=> gom nhóm theo KH, ko phải mã thanh toán  
SELECT customer_id FROM payment
MAX(amount)
GROUP BY customer_id;
--=>
SELECT a.customer_id, 
a.first_name || a.last_name,
b.payment_id,
(SELECT  MAX(amount) FROM payment -- xóa customer_id vì chỉ đc hiển thi 1 cột MAX thôi 
WHERE customer_id=a.customer_id --phải thêm lệnh WHERE nữa để SQL phân biệt MAX tương ứng với customer_id nào. 
GROUP BY customer_id)
FROM customer AS a
JOIN payment AS b 
ON a.customer_id=b.customer_id
GROUP BY  (a.customer_id, 
a.first_name || a.last_name,
b.payment_id)
ORDER BY customer_id;
--> KẾT QUẢ MAX phải CHỈ 1 GIÁ TRỊ lơn nhất cho từng KH 

--CHALLENGE 1: Liệt kê các khoản thanh toán với tổng số hóa đơn và tổng số tiền mỗi KH phải trả (COUNT) 
--payment_id, payment_date, 
--output: Tổng số hóa đơn theo từng KH 
SELECT customer_id,
COUNT (*) AS count_payment, --theo từng KH 
SUM (amount) as sum_amount  --tổng số tiền mỗi KH
FROM payment
GROUP BY customer_id --theo từng KH 
--C1: JOIN
SELECT a.*, b.sum_amount, b.count_payment
FROM payment AS a
JOIN (SELECT customer_id,
COUNT (*) AS count_payment, 
SUM(amount) as sum_amount  
FROM payment
GROUP BY customer_id) b 
ON a.customer_id=b.customer_id
--C2: 
SELECT a.*,
(SELECT 
COUNT (*)
FROM payment b
WHERE a.customer_id=b.customer_id
GROUP BY customer_id) AS count_payment, --do output chỉ ra 1 trường thôi, xóa các thông tin ko cần thiết 
(SELECT 
SUM(amount)
FROM payment b
WHERE a.customer_id=b.customer_id
GROUP BY customer_id) AS sum_amount
FROM payment a 

--CHALLENGE 2: lấy ds các film có chi phí thay thế lớn nhất trog mỗi loại rating. 
--Ngoài film_id, title, rating, chi phí thay thế(replacement_cost) cần thêm chi phí thay thế trung bình mỗi loại rating đó. 
SELECT film_id, title, rating, replacement_cost,
(SELECT AVG(replacement_cost) 
 FROM film a
 WHERE a.rating = b.rating 
GROUP BY rating) --chi phí thay thế trung bình mỗi loại rating
FROM film b 
--chỉ lấy ds các phim có chi phí thay thế lớn nhất (=>LỌC WHERE) trong từng loại rating=> gtri LN của replacement_cost trong rating
SELECT rating, MAX (replacement_cost)
FROM film
GROUP BY rating 
--> KQ
SELECT film_id, title, rating, replacement_cost,
(SELECT AVG(replacement_cost) 
 FROM film a
 WHERE a.rating = b.rating 
GROUP BY rating) 
FROM film b 
WHERE replacement_cost = (SELECT MAX (replacement_cost)
FROM film c
						  WHERE c.rating=b.rating 
GROUP BY rating)

--CTEs (bảng chứa dữ liệu tạm thời)
/*WITH tenbangtamthoi AS
(SELECT...FROM..)
SELECT * FROM tenbangtamthoi */

/*Tìm KH có nhiều hơn 30 hóa đơn
kq return có các thông tin: mã KH, tên KH, số lượng hóa đơn (COUNT), tổng số tiền, thời gian thuê TB. */
WITH 
twt_totalpayment AS 
(SELECT customer_id,
COUNT (payment_id) AS so_luong,
SUM(amount) AS so_tien
FROM payment
GROUP BY customer_id),
twt_avg_rentaltime AS
(SELECT customer_id, 
 AVG (return_date - rental_date) AS rental_time
 FROM rental
GROUP BY customer_id)

SELECT a.customer_id, a.first_name, b.so_luong,b.so_tien, c.rental_time
from customer as a
 JOIN twt_totalpayment AS b on b.customer_id=a.customer_id
 JOIN twt_avg_rentaltime AS c ON a.customer_id=c.customer_id
 --KH có nhiều hơn 30
 WHERE b.so_luong>30
 
 /*Tìm những hóa đơn có số tiền cao hơn 
 số tiền TB của KH đó chi tiêu trên mỗi hóa đơn,
 kết quả return gồm: mã KH, tên KH, số lượng hóa đơn(COUNT),số tiền, số tiền TB của KH đó */
 --vd: 5 hóa đơn, 100K =>tb 20K/đơn, với mỗi KH với hóa đơn nào >20k
WITH 
twt_soluong AS 
(SELECT customer_id,
COUNT (payment_id) AS so_luong
FROM payment
GROUP BY customer_id),
twt_avgamount AS 
(SELECT customer_id,
AVG(amount) AS avg_amount
FROM payment
GROUP BY customer_id)
 
SELECT a.customer_id, a.first_name, b.so_luong, d.amount, c.avg_amount 
FROM customer as a
JOIN twt_soluong AS b ON a.customer_id=b.customer_id
JOIN twt_avgamount AS c ON c.customer_id=a.customer_id
JOIN payment AS d ON d.customer_id= a.customer_id
WHERE d.amount>c.avg_amount
 
 
 
 



























