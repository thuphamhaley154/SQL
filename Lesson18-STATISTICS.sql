--BASIC STATISTICS & DETECT OUTLINER

/* I. Các khái niệm cơ bản trong thống kê
II. Phân phối chuẩn
3. Z-score
4. Ứng dụngt tìm và xử lí dữ liệu ngoại lai (OUTLIER) */

/* 1. Thống kê mô tả với Thống kê suy luận
1. Thống kê mô tả : trình bày kq của mk dưới dạng table, biểu đồ, dashboard từ tập dữ liệ ban đầu để đưa ra 1 kq nào 
có 2 thước đo chính : 
- Trung bình, Trung vị, Yếu vị
- Khoảng, Phương sai, Độ lệch chuẩn

**Thống kê suy luận: chọn 1 mẫu trong 1 tổng thể, rồi tính toán số liệu mẫu đó rồi SUY ĐOÁN ra kq gần đúng cho tổng thể
bao gồm các giả thuyết thử nghiệm và ước tính phát sinh. Phương pháp: tương quan, hồi quy

2. Tổng thể và Mẫu, Thống kê và tham số
- Tổng thể (Population): bao gồm all các đtg ngcuu
- Mẫu (sample): là tập con lấy ra từ tổng thể

+ Thống kê: mô tả cho Mẫu
  - Trung bình (X), Độ lệch chuẩn (S), cỡ mẫu (n) 
  - Thống kê thường được dùng để ước lượng thổng thể
+ Tham số: mô tả cho Tổng thể
  - Trung bình(μ), Độ lệch chuẩn (σ -SD-standard deviation), cỡ mẫu (N) 
  - Tham số tổng thể thường KO BIẾT 


3. Trung bình (Mean), Trung vị(Median), Yếu vị (Mode) 
- Mean = tổng (gtri quan sát của mẫu OR tổng thể) / cỡ mẫu của mẫu OR tổng thể
- Trung vị: Là điểm trong phân phối đánh dấu phân vị thứ 50. Tức 50% số quan sát nằm trên Trung vị và 50% dưới trung vị
Cách tìm số trung vị: 
   - Sắp xếp từ nhỏ đến lướn
   - Nếu số lượng lẻ: số chính giữa là số median
   - Nếu số lượng chắn: tính TB cộng 2 số giữa
- Yếu vị: là quan sát xảy ra THƯỜNG xuyên nhất OR có tần suất cao nhất
          1 mẫu có thể có 1 hoặc nhiều yếu vị



4. Khoảng (Range), Phương sai(Variance-thước đo độ phân tán), Độ lệch chuẩn (SD)
đo Độ phân tán: Tb các khoảng cách, sự cách xa nhau hơn hay gần hơn. 
- Phương sai:
σ mũ 2 : phương sai tổng thể = (TỔNG (các gtri quan sát trong tổng thể - μ gtri TB của tổng thể) ) / Cỡ mẫu của tổng thể (số qsat của tổng thể) 
s mũ 2 : phương sai mẫu = (TỔNG (các gtri quan sát trong Mẫu - X gtri TB của Mẫu) ) / Cỡ mẫu của Mẫu(số qsat của mẫu)
- Độ lệch chuẩn: căn bậc hai của (Phương sai)
- Khoảng: sự khác biệt gtri quan sát Lớn nhất Và Nhỏ nhất
  + Khoảng phân vị: 
    - IQR: hiệu số giữa phân vị thứ 3 (Q3=75%) và phân vị thứ nhất (Q1=25%)
    - Phân vị thứ 2 (Q2=50%), trung vị)
  + Percentile ( Bách phân vị): thứ p là data mà tại đó p% data nhỏ hơn và (100-p)% data lớn hơn
    Percentile thứ 50 là trung vị
    Cách tìm: percentile thứ p
              - xếp từ nhỏ --> lớn
              - nhân p% với số lượng số và làm tròn lên số nguyên Lớn nhất
              - Đếm từ trái sang phải tìm số nguyên
  + Quartile ( tứ phân vị) : là các vtri Q1, Q2,Q3 
    Q1: Percentile thứ 25
    Q2: Percentile thứ 50 (trung vị) 
    Q3: Percentile thứ 75 
    Khoảng Tứ phân vị (Interquartile Range (IQR)): IQR=Q3-Q1

BOX Plot: tính Quartile Q1(25) , Q2(50), Q3(75)  


II/ Phân phối chuẩn (Normal Distribution) 
- là sự phân bố dữ liệu mà ở đó gtri tập trung nhiều nhất ở khoảng giữa và cac gtri còn lại rải đều đối xứng về phía các cực trị 
- Đặc điểm: có tính đối xứng; trung bình, trung vị, yếu vị ở cùng 1 điểm 
- quy tăc 3σ: sd . Đo lường dựa vào Độ lệch chuẩn

Z-score 
- Chuẩn hóa: đưa cac sgtri của quan sát khác nhau về cùng 1 thang điểm
- Điểm Z: là pp chuẩn hóa = cách chuyển gtri ban đầu sang thang điểm ĐỘ lêch chuẩn
      z=(gtri qsat X-TB )/ SD 
  Điểm Z: - dùng dể tính % của phân vị
          - so sánh 2 quan sát có thang điểm khác nhau
          - xác định gtri ngoại lai
  web chuyển đổi điểm Z: https://measuringu.com/calculators/pcalcz/
                       quy tắc; 68, 95, 99.7. Tức (-1;1): gtri 68%, (-2;2), (-3,3) 



III/ Phương pháp tìm OUTLIER

1. Sd Boxplot: sd Quartile (Q1,Q2,Q3)

OUTLIER-- Min(Q1-1.5*IQR) ---Q1 ---median --- Q3 --- MAX(Q3+1.5*IQR) --OUTLIER 
 (IQR=Q3-Q1)
Gtri nào nằm ngoài MIN-MAXlaf OUTLIER 


2. Sd Z-score = (X-TB)/SD 
|Z|>3 Loại 
|Z|>2 cân nhắc, tùy trương hợp 

SELECT * FROM user_data
--- sd Boxplot/IQR tìm ra OUTLIER
--B1: Tính: Q1, Q3, IQR
--B2: xác đinh MIN=Q1-1.5*IQR; MAX= Q3+1.5*IQR
WITH  twt_minmax_value as 
(SELECT Q1-1.5*IQR AS min_value,
Q3+1.5*IQR AS max_value
FROM (SELECT 
percentile_cont(0.25) WITHIN  GROUP(ORDER BY users) AS Q1,
percentile_cont(0.75) WITHIN  GROUP(ORDER BY users) AS Q3,
percentile_cont(0.75) WITHIN  GROUP(ORDER BY users) - percentile_cont(0.25) WITHIN  GROUP(ORDER BY users) AS IQR  
FROM user_data) AS a)
--B3: xác định outlier <min OR  >max 
SELECT * FROM user_data 
WHERE users< (select min_value FROM twt_minmax_value)
OR users>(SELECT max_value FROM twt_minmax_value)

-- CÁCH 2: sd Z-SCORE = (users-avg)/sd
SELECT AVG(users),
stddev(users)
FROM user_data,

WITH cte AS 
(SELECT data_date, users, 
(SELECT AVG(users)
FROM user_data) AS avg,
(SELECT stddev(users)
FROM user_data) as stddev
FROM user_data)

, twt_outlier as(
SELECT data_date, users, (users-avg)/stddev as z_score 
FROM cte 
WHERE abs((users-avg)/stddev )>3)

--để xử lý outlier: 1 xóa, 2 thay bằng gtri mới:vd: gtri TB 
UPDATE user_data
SET USERS=(SELECT AVG(users)
FROM user_data)
WHERE USERS IN (SELECT users FROM twt_outlier)



--C2: xóa nó
DELETE FROM user_data
WHERE users in (SELECT users FROM twt_outlier); 


IV/ 
	
	
	
	




*/
















