/*EX1: Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) 
rounded down to the nearest integer. Note: CITY.CountryCode and COUNTRY.Code are matching key columns. 
https://www.hackerrank.com/challenges/average-population-of-each-continent/problem?isFullScreen=true */
Select Country.Continent, 
FLOOR(AVG(City.Population)) 
From CITY 
INNER JOIN COUNTRY 
ON CITY.CountryCode = COUNTRY.Code 
GROUP BY COUNTRY.Continent;

/*EX2: [TikTok SQL Interview Question] Write a query to find the activation rate. Round the percentage to 2 decimal places. 
https://datalemur.com/questions/signup-confirmation-rate */
SELECT 
  ROUND(CAST(COUNT(b.email_id) AS DECIMAL)
    /COUNT(DISTINCT a.email_id),2) AS confirm_rate
FROM emails AS a 
LEFT JOIN texts AS b 
  ON a.email_id = b.email_id
  AND b.signup_action = 'Confirmed';


/*EX3: Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped 
by age group. Round the percentage to 2 decimal places in the output. 
https://datalemur.com/questions/time-spent-snaps */
















