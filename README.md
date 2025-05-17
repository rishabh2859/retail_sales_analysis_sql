# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
DROP DATABASE IF EXISTS sql_project_1;
CREATE DATABASE sql_project_1;
USE sql_project_1;
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. #Q1-All columns for sales made on 2022-11-05
```sql
SELECT * FROM retail_sales WHERE sale_date='2022-11-05';
```

2. #Q2-All transactions of category clothing on 2022-11 and quantity>=4
```sql
SELECT* FROM retail_sales WHERE category='Clothing' AND quantity>=4 AND month(sale_date)=11 AND year(sale_date)=2022;
```

3. #Q3 Total sales and total orders of each category
```sql
SELECT category,SUM(total_sale)as net_sales,COUNT(*) from retail_sales group by 1;
```

4. #Q4 Average age of beauty category
```sql
SELECT round(avg(age),2)as average_age from retail_sales where category='Beauty';
```

5.#Q5 all transcations where total_sale>=1000
```sql
SELECT * from retail_sales where total_sale>=1000;
```

6. #Q6find out total transactions made by each gender in each category
```sql
SELECT category,gender,count(*) from retail_sales group by 1,2 order by 1;
```

7.#Q7find average sales in each month and find best selling month
```sql
SELECT monthname(sale_date) as month,round(avg(total_sale),2) as avg_sales
from retail_sales group by month(sale_date),monthname(sale_date) order by avg_sales desc
LIMIT 1;
```

8. #Q8Top 5 customers based on highest total sales
```sql
SELECT customer_id,sum(total_sale) from retail_sales group by 1 order by 2 desc
LIMIT 5;
```

9. #Q9Number of unique customers who purchased items from each category
```sql
SELECT category,count(distinct customer_id) from retail_sales group by 1 order by 1;
```

10. #Q10create each shift and number of orders morning<12 ,afternoon 12-15,evening >15
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Rishabh Kapoor(NSUT)

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!



 I look forward to connecting with you!
