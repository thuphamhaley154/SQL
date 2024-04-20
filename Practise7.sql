/*EX1: Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. 
If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID*/
SELECT Name
FROM STUDENTS
WHERE Marks >75
ORDER BY RIGHT (Name,3),  ID ASC

/*EX2: This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase. Return the result table ordered by user_id.*/
SELECT user_id,
CONCAT (UPPER (LEFT(name,1)), LOWER(RIGHT(name,LENGTH(name)-1))) AS name
--CONCAT (UPPER(LEFT(name,1)), LOWER(SUBSTRING(name FROM 2)) ) AS name
FROM Users
ORDER BY user_id;
--SUBsTRING ('learn data' FROM 3 for 5) => arn d
--= SUBSTRING ('learn data',3,5) => arn d
-- SUBSTRING ('learn data',3) => arn data -- đc hiểu là lấy từ 3 trở đi 


