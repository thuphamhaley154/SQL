--INNER JOIN (table 1 INNER JOIN table2)
SELECT t1.*, t2.* --thể hiện tt của t1,t2 sau khi lấy t1 connect t2 thông qua(ON) key1(t1),key2(t2)
FROM table1 AS t1
INNER JOIN table2 AS t2
ON t1.key1=t2.key2 --ON thể hiện mqh giữa t1,t2 qua các keys

SELECT * FROM payment 
