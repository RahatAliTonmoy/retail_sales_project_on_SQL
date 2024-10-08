CREATE DATABASE retail_sales_project;
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
transactions_id	INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,	
gender VARCHAR(15),	
age INT,
category VARCHAR(20),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT);

-- Data Cleaning
SELECT * FROM retail_sales
LIMIT 10;
SELECT COUNT(*) FROM retail_sales;

ALTER TABLE retail_sales
RENAME quantiy TO quantity;

SELECT * FROM retail_sales;

SELECT * FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

DELETE FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

--Data Exploration

--How many total sales do we have?

SELECT COUNT(*) AS total_sale FROM retail_sales;

--How many unique customers do we have?

SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales;

--Distinct Categories
SELECT DISTINCT category FROM retail_sales;

--Data Analysis On Business Key Problems & Plausible Solution

--Q1: Write a sql query to retrieve all the column for sales made on '2022-11-05'

SELECT * FROM retail_sales
WHERE sale_date='2022-11-05';

--Q2: Write a sql query to retrieve all the transactions where the category is 'clothing' and the quantity sold is more than 3 in the month of nov 2022
SELECT category, SUM(quantity) FROM retail_sales
WHERE category='Clothing' GROUP BY 1;

SELECT * FROM retail_sales
WHERE category='Clothing' 
AND TO_Char(sale_date,'yyyy-mm') ='2022-10' 
AND quantity>=3;

--Q3:Write a sql query to calculate total_sales for each category.

SELECT category, SUM(total_sale) AS net_sales, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

--Q4:Write a sql query to find the average age of customers who purchase from the beauty category
SELECT category, ROUND(AVG(age),2) AS avg_age
FROM retail_sales
GROUP BY 1;

--Q5:Write a sql query to find all the transactions where total_sales greater than 1500
SELECT * FROM retail_sales
WHERE total_sale>=1500;

--Q5:Write a sql query to find all the transactions (transaction_id) made by each gender in each category
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY 1,2;

--Q6:Write a sql query to calculate average sales for each month, find out the
-- each best selling month each year
select * from retail_sales;

SELECT * FROM
(
	SELECT  EXTRACT(YEAR FROM sale_date) AS year,
			EXTRACT(MONTH FROM sale_date) AS month,
			AVG(total_sale) AS avg_sale,
			RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC ) AS rank
	FROM retail_sales
	GROUP BY 1,2
)
WHERE rank=1;

--Q7:Write a sql query to find out the top 5 customers based on highest total_sales


SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY total_sales DESC
LIMIT 5;

--Q7:Write a sql query to find the unique customers who purchase from each category

SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;

--Q10: Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shifts
FROM retail_sales
)

SELECT shifts, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shifts;

--END OF THE PROJECT