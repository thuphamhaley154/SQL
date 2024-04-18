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
--












