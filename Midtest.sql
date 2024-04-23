/*Câu hỏi 1:Question 1:Level: Basic
Topic: DISTINCT
Task: Tạo danh sách tất cả chi phí thay thế (replacement costs )  khác nhau của các film.
Question: Chi phí thay thế thấp nhất là bao nhiêu?
Answer: 9.99*/

/*Question 2:
Level: Intermediate
Topic: CASE + GROUP BY
Task: Viết một truy vấn cung cấp cái nhìn tổng quan về số lượng phim có chi phí thay thế trong các phạm vi chi phí sau
1.	low: 9.99 - 19.99
2.	medium: 20.00 - 24.99
3.	high: 25.00 - 29.99
Question: Có bao nhiêu phim có chi phí thay thế thuộc nhóm “low”?
Answer: 514*/


/*Question 3:
Level: c
Topic: JOIN
Task: Tạo danh sách các film_title  bao gồm tiêu đề (title), độ dài (length) và tên danh mục (category_name) được sắp xếp theo độ dài giảm dần. Lọc kết quả để chỉ các phim trong danh mục 'Drama' hoặc 'Sports'.
Question: Phim dài nhất thuộc thể loại nào và dài bao nhiêu?
Answer: Sports : 184

Question 4:
Level: Intermediate
Topic: JOIN & GROUP BY
Task: Đưa ra cái nhìn tổng quan về số lượng phim (tilte) trong mỗi danh mục (category).
Question:Thể loại danh mục nào là phổ biến nhất trong số các bộ phim?
Answer: Sports :74 titles


Question 5:
Level: Intermediate
Topic: JOIN & GROUP BY
Task:Đưa ra cái nhìn tổng quan về họ và tên của các diễn viên cũng như số lượng phim họ tham gia.
Question: Diễn viên nào đóng nhiều phim nhất?
Answer: Susan Davis : 54 movies


Question 6:
Level: Intermediate
Topic: LEFT JOIN & FILTERING
Task: Tìm các địa chỉ không liên quan đến bất kỳ khách hàng nào.
Question: Có bao nhiêu địa chỉ như vậy?
Answer: 4

Question 7:
Level: Intermediate
Topic: JOIN & GROUP BY
Task: Danh sách các thành phố và doanh thu tương ừng trên từng thành phố 
Question:Thành phố nào đạt doanh thu cao nhất?
Answer: Cape Coral : 221.55


Question 8:
Level: Intermediate 
Topic: JOIN & GROUP BY
Task: Tạo danh sách trả ra 2 cột dữ liệu: 
-	cột 1: thông tin thành phố và đất nước ( format: “city, country")
-	cột 2: doanh thu tương ứng với cột 1
Question: thành phố của đất nước nào đat doanh thu cao nhất
Answer: United States, Tallahassee : 50.85.

