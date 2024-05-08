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















