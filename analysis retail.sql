SELECT*
FROM retail_clean;
-- Data_analysis
--BUSINESSES QUESTIONS
--1) Revenue Drivers
--Is revenue growth by customers purchasing more products ,or by purchasing higher priced products?
SELECT 
	TO_CHAR(invoicedate,'Month') AS Month,
	SUM(revenue) AS total_revenue,
	AVG(quantity) AS arg_quantity,
	AVG(unitprice)  AS arg_unitprice
FROM retail_clean 
GROUP BY Month 
ORDER BY Month DESC ;

-- 2) Geographic Performance
-- Which countries generate the highest and lowest revenue ?
SELECT country ,SUM(revenue) AS total_revenue
FROM retail_clean 
GROUP BY country 
ORDER BY total_revenue DESC ;

-- 3) Customer Value
-- Who are the top customers,and what percentage of total revenue do they contribute ?
SELECT 
customerid,SUM(revenue) AS total_revenue ,
	ROUND(
	SUM(revenue)*100/(SELECT SUM(revenue)  FROM retail_clean ) ,2
	) AS revenue_percentage
FROM retail_clean 
GROUP BY customerid
ORDER BY total_revenue DESC;

-- 4)Market Efficiency 
-- Which country generates the highest revenue despite having the fewest customers ?
SELECT country ,SUM(revenue) AS total_revenue ,COUNT(DISTINCT customerid) AS total_customers
FROM retail_clean 
WHERE  TRIM(country) <>  'United Kingdom'
GROUP BY country 
ORDER BY total_revenue DESC ,
total_customers ASC
LIMIT 1;

-- 5) Demand Trend
-- How do products demand change monthly and yearly ?
SELECT EXTRACT(year FROM invoicedate) AS Year,
TO_CHAR(invoicedate,'Month') AS Month,SUM(quantity) AS total_quantity
FROM retail_clean 
GROUP BY Month,Year 
ORDER BY Year DESC,total_quantity DESC,Month ;

-- 6 ) If our top performing country dissapear tomorrow,how much revenue would the business loose ,and which country
-- is most capable of replacing that revenue ?
--STEP 1 FIND the top performing country 
SELECT  country ,SUM(revenue) AS total_revenue
FROM retail_clean 
GROUP BY country 
ORDER BY total_revenue DESC
LIMIT 1;
-- STEP 2 FIND THE COUNTRY MOST REPLACING IT
SELECT  country ,SUM(revenue) AS total_revenue
FROM retail_clean 
GROUP BY country 
ORDER BY total_revenue DESC
LIMIT 2;



	


	