---DATA_CLEANING
-- 1 Check the dataset
SELECT *
FROM online_retail;
-- 2 Check missing values
-- Missing customer ID
SELECT COUNT(*)
FROM online_retail
WHERE customerid IS NULL;
-- Missing Description
SELECT *
FROM online_retail
WHERE description IS NULL;
-- 3 Remove rows with missing Description
-- (important for customer analysis)
DELETE FROM online_retail
WHERE description IS NULL;
-- 4 Remove rows without customer ID
-- (important for customer analysis)
DELETE FROM online_retail
WHERE customerid IS NULL;
-- 5 Remove cancelled transactions
-- INVOICE numbers starting WITH C
DELETE FROM online_retail
WHERE invoiceno LIKE 'C%';

-- 6 Remove invalid quantities
DELETE FROM online_retail
WHERE quantity <=0;

-- 7 Remove invalid prices
DELETE FROM online_retail
WHERE unitprice <=0;

-- 8 Check duplicates
SELECT			
	invoiceno,
	stockcode,
	description,
	quantity,
	invoicedate,
	unitprice,
	customerid,
	country,
	COUNT(*)
FROM online_retail
GROUP BY
	invoiceno,
	stockcode,
	description,
	quantity,
	invoicedate,
	unitprice,
	customerid,
	country
HAVING COUNT(*)	>1;
-- 9 create Revenue column
ALTER TABLE online_retail
ADD COLUMN revenue DECIMAL(10,2);
-- 10 calculate Revenue
UPDATE online_retail
SET revenue =quantity *unitprice;


SELECT *
FROM online_retail
LIMIT 10 ;

--Remove duplicates
CREATE TABLE retail_clean AS
SELECT DISTINCT *
FROM online_retail;

SELECT*
FROM online_retail

SELECT *
FROM retail_clean