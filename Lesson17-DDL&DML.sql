--DDL & DML
/* Các loại câu lệnh SQL
DQL(Data Query language): lệnh truy vấn
DDL (data definitine language): lệnh định nghĩa xây dựng và quản lý đối tượng trong database
DML ( data manipulation language): lệnh thay đổi giá trị dữ liệu trong bảng 
DCL (data control language): thao tác quản lý bảo mật dữ liệu và phân quyền đối tượng người dùng
TCL (Transaction control language) 
+ DDL: data structure:(ahg cấu trúc đtg) create, alter, drop 
+ DML: data itself:(thao tác trực tiếp lên đtg): insert, update, delete  
--Structured database SQL
+ Primary key
+ Foreign key
+ Data type
+ Constraints (ràng buộc): là những nguyên tắc đc áp dụng trên các cột dữ liệu, table.
đc sử dụng để kiểm tra tính hợp lệ của data đầu vào, đảm bảo tính chính xác, toàn vẹn của dữ liệu.
  ~loại ràng buộc: 
  - NOT NULL: sd để đảm bảo dữ liệu của cột ko đc nhận gtri NULL
  - DEFAULT: gán gtri mặc định trong trường hợp dữ liệu của cột ko đc nhập vào hay ko đc xác định
  - UNIQUE : sd để đảm bảo dữ liệu của cột là duy nhất, ko trùng lặp gtri trên cùng 1 cột 
  - PRIMARY KEY: dùng để thiết lập khóa chính trên bảng, xác đinh gtri trên tập các cột làm khóa chính phải là DUY NHẤT, 
ko đc trùng lặp. Việc khai báo ràng buộc primary key yêu cầu các cột phải NOT NULL
  - FOREIGN KEY: dùng để thiết lập khóa ngoại trên bảng, tham chiều đến bảng khác thông qua gtri của cột đc liên kết.
Gtri của cột đc liên kết phải là duy nhất trong bảng kia.
  - CHECK: bảo đảm tất cả gtri trong cột thỏa mãn đk nào đó. để ktra tính hợp lệ của dữ liệu */




-- DDL : CREAT, ALTER, DROP
--DDL
CREATE TABLE manager 
(manager_id INT PRIMARY KEY ,
user_name VARCHAR(20) UNIQUE,
first_name VARCHAR(50),
last_name VARCHAR(50) DEFAULT 'no info',
date_of_birth DATE,
address_id INT)

DROP TABLE manager -- để xóa bảng manager và CREAT lại nó

--query to return ds KH và corresponding address
--sau đó lưu thông tin đó vào table đặt tên là customer_info 
CREATE TABLE customer_info AS --tạo bảng vật lý 
(SELECT customer_id,
first_name ||last_name AS full_name,
email,
b.address
FROM customer AS a
JOIN address AS b ON a.address_id=b.address_id) 
SELECT * FROM customer_info 

--CREATE TEMPORARY TABLE: tương tự như trên 
CREATE TEMP TABLE Tmp_customer_info AS () 
--share với mn để cùng truy cập, xem 
CREATE GLOBAL TEMP TABLE Tmp_customer_info AS () 

--CREATE VIEW: khi muốn tạo 1 bảng mà sau đó nó có thể tự cập nhật lại new update về bảng 
CREATE VIEW Vcustomer_info AS
(SELECT customer_id,
first_name ||last_name AS full_name, email, b.address
FROM customer AS a
JOIN address AS b ON a.address_id=b.address_id) 
SELECT * FROM Vcustomer_info 

--nếu in case muốn thêm 1 câu lệnh mới như thêm a.active để query 
CREATE OR REPLACE VIEW Vcustomer_info AS
(SELECT customer_id,
first_name ||last_name AS full_name, email, b.address, a.active 
FROM customer AS a
JOIN address AS b ON a.address_id=b.address_id) 
SELECT * FROM Vcustomer_info 

DROP VIEW Vcustomer_info -- xóa câu lệnh 

/*CHALLENGE: Tạo View có tên movies_category hiển thị ds các film 
bao gồm title, length, category name được sắp xếp giảm dần theo length
-Lọc kq để chỉ những films trong danh mục 'Action' và 'Comedy' */
CREATE OR REPLACE VIEW movies_category AS
(SELECT a.title, a.length, c.name as category_name 
FROM film a
JOIN public.film_category b ON a.film_id=b.film_id 
JOIN public.category c ON b.category_id=c.category_id)

SELECT * FROM movies_category 
WHERE category_name IN ('Action', 'Comedy')

--DDL: ALTER TABLE: thay đổi cấu trúc đối tượng của bảng 
--ADD, DELETE columns
ALTER TABLE manager
DROP first_name -- xóa cột first_name 
--thêm 1 trường tt nào đó 
ALTER TABLE manager
ADD column first_name VARCHAR(50)
--RENAME columns: thay đổi tt cột nào đó trong bảng 
ALTER TABLE manager
RENAME column first_name TO ten_kh 
--ALTER datatypes 
ALTER TABLE manager 
ALTER COLUMN ten_kh TYPE text  

SELECT * FROM public.manager



--DML: INSERT, UPDATE, DELETE, TRUNCATE 
SELECT * FROM city 
WHERE CITY_ID=1000 
--INSERT: thêm 1 hoặc nhiều trường dữ liệu 
INSERT INTO city --nếu ko nói rõ trường nào, thì auto insert vào all các trường tt
VALUES (1000,'A',44,'2020-01-01 16:10:20'),
(1001,'B',33,'2020-02-01 16:10:20' )
--nếu insert chỉ 1 vài trường tt
INSERT INTO city (city, country_id)
VALUES ('C',55)
--==>check 
SELECT * FROM city 
WHERE city= 'C'

--UPDATE 
--DML: INSERT, UPDATE, DELETE, TRUNCATE 
--UPDATE : sửa dữ liệu 
SELECT * FROM city WHERE city_id=3

UPDATE city 
SET country_id=100 --setup trường mk muốn thay đổi tt 
WHERE city_id=3

/*CHALLENGE: 1.Update giá thuê film 0.99 thành 1.99
2. Điều chỉnh bảng customer như sau:
+Thêm cột initials (data type varchar(10))
+Update dữ liệu vào cột initials, vd: Frank Smith should be F.S */
UPDATE film
SET rental_rate=1.99
WHERE rental_rate =0.99
--CHECK
SELECT * FROM film WHERE rental_rate =0.99 --NO
--2,
ALTER TABLE customer 
ADD COLUMN initials VARCHAR(10);

UPDATE customer 
SET initials=LEFT(first_name,1) || '.'||LEFT(last_name,1)

SELECT * FROM customer 


--DELETE , TRUNCATE :xóa 1 hoặc all các dữ liệu trong 1 bảng nào đó 
INSERT INTO manager
VALUES(1,'HAPT','Tran','1997-01-01',20,'Ha'),
(2,'THUMP','Adam','1990-01-01',33,'Haley'),
(3,'GEOGE','Skem','2001-02-01',23,'Josh')

SELECT * FROM manager 

DELETE FROM manager 
WHERE manager_id=1; --xóa data theo dữ liệu đk 
--nếu muốn xóa the whole mà ko theo đk nào cả 
DELETE FROM manager  --xóa dần dần 
--or
TRUNCATE TABLE manager  -- xóa toàn bộ 

SELECT * FROM manager 


























