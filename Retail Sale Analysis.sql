--CREATE DATABASE
CREATE DATABASE retail_sales_project;

-- CREATE TABLE
CREATE TABLE retail_sales
(
    transactions_id   INT PRIMARY KEY,
    sale_date         DATE,
    sale_time         TIME,
    customer_id       INT,
    gender            VARCHAR(15),
    age               INT,
    category          VARCHAR(15),    
    quantity          FLOAT, 
    price_per_unit    FLOAT,    
    cogs              FLOAT,
    total_sale        FLOAT
);

SELECT * FROM retail_sales;

-- DATA CLEANING
--FIND NULL VALUES
SELECT * FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_DATE IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
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

--DELETE NULL VALUES
DELETE  FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_DATE IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
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

/*Data Exploration */

-- HOW MANY RECORD WE HAVE ?
SELECT COUNT(*) FROM retail_sales;

--HOW MANY UNIQUE CATEGORY WE HAVE ?
SELECT DISTINCT category FROM retail_sales;

/* Data Analysis & Business Key Problems & Answers */

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is  4 in the month of Nov-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND quantity = 4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category,
	SUM(total_sale) AS net_sale,
	COUNT(total_sale) AS total_orders
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT category,
	ROUND(AVG(age),2)
FROM retail_sales
WHERE category ='Beauty'
GROUP BY category;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category,gender, COUNT(transactions_id) AS transactions
FROM retail_sales
GROUP BY gender,category
ORDER BY 1

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT
    year,
    month,
    avg_sale
FROM (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY year, month
) AS t1
WHERE rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id,SUM(total_sale) AS sum_of_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY sum_of_sale DESC LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category,
	COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(SELECT *,
	CASE 
	WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
	END AS shift
FROM retail_sales
)
SELECT shift,COUNT(*) AS number_orders
FROM hourly_sale
GROUP BY shift;

--END OF PROJECT
