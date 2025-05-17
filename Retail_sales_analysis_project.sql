DROP DATABASE IF EXISTS sql_project_1;
CREATE DATABASE sql_project_1;
USE sql_project_1;
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
      transaction_id INT PRIMARY KEY,
      sale_date DATE,
      sale_time TIME,
      customer_id INT,
      gender varchar(25),
      age INT,
      category varchar(25),
      quantity INT,
      price_per_unit FLOAT,
      cogs FLOAT,
      total_sale FLOAT
);
SET GLOBAL local_infile = 1;
TRUNCATE TABLE retail_sales;

LOAD DATA LOCAL INFILE '/Users/mac/Desktop/Retail-Sales-Analysis-SQL-Project--P1/SQL - Retail Sales Analysis_utf .csv'
INTO TABLE retail_sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(transaction_id, sale_date, sale_time, customer_id, gender, age, category, quantity, price_per_unit, cogs, total_sale)
SET
  age = NULLIF(age, ''),
  quantity = NULLIF(quantity, ''),
  price_per_unit = NULLIF(price_per_unit, ''),
  cogs = NULLIF(cogs, ''),
  total_sale = NULLIF(total_sale, '');



SELECT * FROM retail_sales;
SELECT * FROM retail_sales 
WHERE transaction_id is NULL
 OR 
 sale_date is NULL
 OR 
 sale_time is NULL
 OR 
 customer_id is NULL
 OR 
 gender is NULL
 OR 
 age is NULL
 OR 
 category is NULL
 OR 
 quantity is NULL
 OR 
 price_per_unit is NULL
 OR 
 cogs is NULL
 OR 
 total_sale is NULL;
 SET SQL_SAFE_UPDATES = 0;
 DELETE  FROM retail_sales
 WHERE sale_date is NULL
 OR 
 sale_time is NULL
 OR 
 customer_id is NULL
 OR 
 gender is NULL
 OR 
 age is NULL
 OR 
 category is NULL
 OR 
 quantity is NULL
 OR 
 price_per_unit is NULL
 OR 
 cogs is NULL
 OR 
 total_sale is NULL
;
SELECT * FROM retail_sales;
#total sales
SELECT COUNT(*) as total_sales FROM retail_sales;
#total customers
SELECT COUNT(DISTINCT customer_id) as total_customers FROM retail_sales;
#categories
SELECT DISTINCT category as categories FROM retail_sales;
#Q1-All columns for sales made on 2022-11-05
SELECT * FROM retail_sales WHERE sale_date='2022-11-05';
#Q2-All transactions of category clothing on 2022-11 and quantity>=4
SELECT* FROM retail_sales WHERE category='Clothing' AND quantity>=4 AND month(sale_date)=11 AND year(sale_date)=2022;
#Q3 Total sales and total orders of each category
SELECT category,SUM(total_sale)as net_sales,COUNT(*) from retail_sales group by 1;
#Q4 Average age of beauty category
SELECT round(avg(age),2)as average_age from retail_sales where category='Beauty';
#Q5 all transcations where total_sale>=1000
SELECT * from retail_sales where total_sale>=1000;
#Q6find out total transactions made by each gender in each category
SELECT category,gender,count(*) from retail_sales group by 1,2 order by 1;
#Q7find average sales in each month and find best selling month
SELECT monthname(sale_date) as month,round(avg(total_sale),2) as avg_sales
from retail_sales group by month(sale_date),monthname(sale_date) order by avg_sales desc
LIMIT 1;
#Q8Top 5 customers based on highest total sales
SELECT customer_id,sum(total_sale) from retail_sales group by 1 order by 2 desc
LIMIT 5;
#Q9Number of unique customers who purchased items from each category
SELECT category,count(distinct customer_id) from retail_sales group by 1 order by 1;
#Q10create each shift and number of orders morning<12 ,afternoon 12-15,evening >15
WITH hourly_sale
as(
SELECT *,
CASE 
WHEN hour(sale_time)<12 THEN 'Morning'
WHEN hour(sale_time) between 12 and 15 then 'Afternoon'
ELSE 'evening'
END as shift
from retail_sales)
SELECT shift,count(transaction_id) as shift_sales from hourly_sale group by 1;
#end of project