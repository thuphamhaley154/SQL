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
ALTER COLUMN ordernumber TYPE integer USING ordernumber::integer,
ALTER COLUMN quantityordered TYPE integer USING (trim(quantityordered)::integer),
ALTER COLUMN priceeach TYPE numeric USING (trim(priceeach)::numeric),
ALTER COLUMN orderlinenumber TYPE integer USING (trim(orderlinenumber)::integer),
ALTER COLUMN sales TYPE numeric USING (trim(sales)::numeric),
ALTER COLUMN msrp TYPE numeric USING (trim(msrp)::numeric),
-- Chuyển đổi kiểu dữ liệu cho các cột ngày tháng
ALTER COLUMN orderdate TYPE date USING to_date(orderdate, 'MM/DD/YYYY'),
-- Chuyển đổi kiểu dữ liệu cho các cột văn bản : VARCHAR 

--2) Check NULL/BLANK (‘’)  ở các trường: ordernumber, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE.
SELECT * FROM sales_dataset_rfm_prj
WHERE ordernumber IS NULL OR ordernumber = ''
   OR quantityordered IS NULL OR quantityordered = ''
   OR priceeach IS NULL OR priceeach = ''
   OR orderlinenumber IS NULL OR orderlinenumber = ''
   OR sales IS NULL OR sales = ''
   OR orderdate IS NULL OR orderdate = '';


/*3)	Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME . 
Chuẩn hóa CONTACTLASTNAME, CONTACTFIRSTNAME theo định dạng chữ cái đầu tiên viết hoa, chữ cái tiếp theo viết thường. 
Gợi ý: ( ADD column sau đó UPDATE)*/
ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN contactlastname VARCHAR,
ADD COLUMN contactfirstname VARCHAR;
UPDATE sales_dataset_rfm_prj
SET contactlastname = INITCAP(SPLIT_PART(contactfullname, ' ', 2)),
    contactfirstname = INITCAP(SPLIT_PART(contactfullname, ' ', 1));


--4)Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là Qúy, tháng, năm được lấy ra từ ORDERDATE 
-- Thêm cột QTR_ID, MONTH_ID, YEAR_ID
ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN qtr_id INTEGER,
ADD COLUMN month_id INTEGER,
ADD COLUMN year_id INTEGER;
-- Cập nhật giá trị cho các cột này
UPDATE sales_dataset_rfm_prj
SET qtr_id = EXTRACT(QUARTER FROM orderdate),
    month_id = EXTRACT(MONTH FROM orderdate),
    year_id = EXTRACT(YEAR FROM orderdate);


--5)Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED và hãy chọn cách xử lý cho bản ghi đó (2 cách) ( Không chạy câu lệnh trước khi bài được review)
--Tìm các giá trị ngoại lai cho cột QUANTITYORDERED
WITH quantiles AS (SELECT 
        percentile_cont(0.25) WITHIN GROUP (ORDER BY quantityordered) AS q1,
        percentile_cont(0.75) WITHIN GROUP (ORDER BY quantityordered) AS q3
                 FROM sales_dataset_rfm_prj)
SELECT *,
CASE 
    WHEN quantityordered < q1 - 1.5 * (q3 - q1) THEN 'outlier'
    WHEN quantityordered > q3 + 1.5 * (q3 - q1) THEN 'outlier'
    ELSE 'normal'
END AS status
FROM sales_dataset_rfm_prj, quantiles;
--Thay thế giá trị outlier bằng giá trị trung bình:
UPDATE sales_dataset_rfm_prj
SET quantityordered = (SELECT AVG(quantityordered) FROM sales_dataset_rfm_prj)
WHERE quantityordered < (SELECT q1 - 1.5 * (q3 - q1) FROM quantiles)
   OR quantityordered > (SELECT q3 + 1.5 * (q3 - q1) FROM quantiles);

--6)Sau khi làm sạch dữ liệu, hãy lưu vào bảng mới  tên là SALES_DATASET_RFM_PRJ_CLEAN
-- Tạo bảng mới và sao chép dữ liệu vào bảng mới
CREATE TABLE sales_dataset_rfm_prj_clean AS
SELECT * FROM sales_dataset_rfm_prj;



