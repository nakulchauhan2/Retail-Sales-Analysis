# 🛍️ Retail Sales Analysis – SQL Project

This project showcases a comprehensive SQL-driven analysis of retail sales data. It covers everything from database setup and data cleaning to answering key business questions using structured SQL queries. Ideal for data analysts and learners looking to build a solid SQL portfolio project.

---

## 📌 Project Objectives

- 🗂️ Set up a PostgreSQL database and retail sales table
- 🧹 Clean data by identifying and removing null/missing records
- 🔍 Perform Exploratory Data Analysis (EDA) using SQL
- 📊 Solve real business problems through SQL queries

---

## 🏗️ Project Structure

### 1. Database Setup
- Create a database: `retail_sales_project`
- Create a table: `retail_sales` with appropriate columns for transaction ID, sale date, time, customer ID, category, sales amount, etc.
```sql
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
```

### 2. Data Cleaning
- Identify rows with `NULL` values in key columns
- Delete all incomplete or missing records for clean analysis
```sql
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
```
-DELETE NULL VALUES
```sql DELETE  FROM retail_sales
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
```
### 3. Data Exploration
- Count total records and unique categories
- Preview sales data and customer demographics
```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;
```
---

## 🔎 Business Questions Answered

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
```sql
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is  4 in the month of Nov-2022
```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND quantity = 4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
```

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
```sql
SELECT category,
	SUM(total_sale) AS net_sale,
	COUNT(total_sale) AS total_orders
FROM retail_sales
GROUP BY category;
```

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
```sql
SELECT category,
	ROUND(AVG(age),2)
FROM retail_sales
WHERE category ='Beauty'
GROUP BY category;
```

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
```sql
SELECT category,gender, COUNT(transactions_id) AS transactions
FROM retail_sales
GROUP BY gender,category
ORDER BY 1
```

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
```sql
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
```

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
```sql
SELECT customer_id,SUM(total_sale) AS sum_of_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY sum_of_sale DESC LIMIT 5;
```

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
```sql
SELECT category,
	COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
```sql
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
```
All queries are well-commented and documented in the provided SQL script.

---

## Findings
- Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
- Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.
---

## Reports
---
- Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.
- Trend Analysis: Insights into sales trends across different months and shifts.
- Customer Insights: Reports on top customers and unique customer counts per category.
---

## Conclusion
- This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
---

## 📌 Author

**Nakul Chauhan**  

---

