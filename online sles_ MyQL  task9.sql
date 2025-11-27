CREATE DATABASE online_retail_db;

USE online_retail_db;
-- Table Creation 

CREATE TABLE online_retail (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID VARCHAR(20),
    Country VARCHAR(50)
);

select *from online_retail;
-- 
SELECT
    EXTRACT(YEAR FROM UnitPrice) AS year,
    EXTRACT(MONTH FROM UnitPrice) AS month,
    SUM(UnitPrice * Quantity) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM online_retail
GROUP BY year, month
ORDER BY year, month;

-- Country-wise Revenue
SELECT
    Country,
    SUM(UnitPrice * Quantity) AS total_revenue
FROM online_retail
GROUP BY Country
ORDER BY total_revenue DESC;

-- Top 10 Customers by Spending
SELECT 
    CustomerID,
    SUM(UnitPrice * Quantity) AS total_spent
FROM online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_spent asc
LIMIT 10;

-- Daily Sales Trend (Revenue per Day)
SELECT
    DATE(InvoiceDate) AS sale_date,
    SUM(UnitPrice * Quantity) AS daily_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM online_retail
GROUP BY sale_date
ORDER BY sale_date;

-- Hourly Sales Trend (Revenue by Hour of Day)
SELECT
    HOUR(InvoiceDate) AS hour_of_day,
    SUM(UnitPrice * Quantity) AS hourly_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM online_retail
GROUP BY hour_of_day
ORDER BY hour_of_day;

--
SELECT
    DAYNAME(InvoiceDate) AS weekday,
    HOUR(InvoiceDate) AS hour_of_day,
    SUM(UnitPrice * Quantity) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM online_retail
GROUP BY weekday, hour_of_day
ORDER BY 
    FIELD(weekday, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'),
    hour_of_day;

-- Total Canceled Orders Count
SELECT 
    COUNT(DISTINCT InvoiceNo) AS canceled_orders
FROM online_retail
WHERE InvoiceNo LIKE 'C%';

-- otal Revenue Lost from Cancellations
SELECT
    SUM(UnitPrice * Quantity) AS revenue_lost
FROM online_retail
WHERE InvoiceNo LIKE 'C%';

-- Daily Trend of Cancellations
SELECT
    DATE(InvoiceDate) AS cancel_date,
    COUNT(DISTINCT InvoiceNo) AS total_canceled_orders,
    SUM(UnitPrice * Quantity) AS revenue_lost
FROM online_retail
WHERE InvoiceNo LIKE 'C%'
GROUP BY cancel_date
ORDER BY cancel_date;

-- ustomer Who Canceled the Most Orders
SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS canceled_orders
FROM online_retail
WHERE InvoiceNo LIKE 'C%'
  AND CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY canceled_orders DESC
LIMIT 1;

select * from online_retail;

