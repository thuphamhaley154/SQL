/*Hãy làm sạch dữ liệu theo hướng dẫn sau:
1)	Chuyển đổi kiểu dữ liệu phù hợp cho các trường ( sử dụng câu lệnh ALTER) 
2)	Check NULL/BLANK (‘’)  ở các trường: ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE.
3)	Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME . 
Chuẩn hóa CONTACTLASTNAME, CONTACTFIRSTNAME theo định dạng chữ cái đầu tiên viết hoa, chữ cái tiếp theo viết thường. 
Gợi ý: ( ADD column sau đó UPDATE)
4)	Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là Qúy, tháng, năm được lấy ra từ ORDERDATE 
5)	Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED và hãy chọn cách xử lý cho bản ghi đó (2 cách) ( Không chạy câu lệnh trước khi bài được review)
6)	Sau khi làm sạch dữ liệu, hãy lưu vào bảng mới  tên là SALES_DATASET_RFM_PRJ_CLEAN */
SELECT * FROM sales_dataset_rfm_prj
/*Hãy làm sạch dữ liệu theo hướng dẫn sau:
1)	Chuyển đổi kiểu dữ liệu phù hợp cho các trường ( sử dụng câu lệnh ALTER) 
2)	Check NULL/BLANK (‘’)  ở các trường: ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE.
3)	Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME . 
Chuẩn hóa CONTACTLASTNAME, CONTACTFIRSTNAME theo định dạng chữ cái đầu tiên viết hoa, chữ cái tiếp theo viết thường. 
Gợi ý: ( ADD column sau đó UPDATE)
4)	Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là Qúy, tháng, năm được lấy ra từ ORDERDATE 
5)	Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED và hãy chọn cách xử lý cho bản ghi đó (2 cách) ( Không chạy câu lệnh trước khi bài được review)
6)	Sau khi làm sạch dữ liệu, hãy lưu vào bảng mới  tên là SALES_DATASET_RFM_PRJ_CLEAN */

--1)Chuyển đổi kiễu dữ liệu
ALTER TABLE sales_dataset_rfm_prj
--Cho các cột số 
--ALTER COLUMN ordernumber TYPE integer USING ordernumber::integer,
ALTER COLUMN quantityordered TYPE integer USING (trim(quantityordered)::integer),
ALTER COLUMN priceeach TYPE numeric USING (trim(priceeach)::numeric),
ALTER COLUMN orderlinenumber TYPE integer USING (trim(orderlinenumber)::integer),
ALTER COLUMN sales TYPE numeric USING (trim(sales)::numeric),
ALTER COLUMN msrp TYPE numeric USING (trim(msrp)::numeric),
-- Chuyển đổi kiểu dữ liệu cho các cột ngày tháng
ALTER COLUMN orderdate TYPE date USING (trim(orderdate)::date),
-- Chuyển đổi kiểu dữ liệu cho các cột văn bản
ALTER COLUMN status TYPE varchar USING trim(status),
ALTER COLUMN productline TYPE varchar USING trim(productline),
ALTER COLUMN productcode TYPE varchar USING trim(productcode),
ALTER COLUMN customername TYPE varchar USING trim(customername),
ALTER COLUMN phone TYPE varchar USING trim(phone),
ALTER COLUMN addressline1 TYPE varchar USING trim(addressline1),
ALTER COLUMN addressline2 TYPE varchar USING trim(addressline2),
ALTER COLUMN city TYPE varchar USING trim(city),
ALTER COLUMN state TYPE varchar USING trim(state),
ALTER COLUMN postalcode TYPE varchar USING trim(postalcode),
ALTER COLUMN country TYPE varchar USING trim(country),
ALTER COLUMN territory TYPE varchar USING trim(territory),
ALTER COLUMN contactfullname TYPE varchar USING trim(contactfullname),
ALTER COLUMN dealsize TYPE varchar USING trim(dealsize);







