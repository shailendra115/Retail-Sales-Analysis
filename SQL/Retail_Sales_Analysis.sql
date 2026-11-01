-- ==========================================
-- STEP 28: CREATE RETAIL SALES DATABASE
-- ==========================================

CREATE DATABASE retail_sales_analysis;

USE retail_sales_analysis;

SHOW DATABASES;
-- ==========================================
-- STEP 30: VERIFY IMPORTED RETAIL DATA
-- ==========================================

USE retail_sales_analysis;

-- Check total number of records
SELECT COUNT(*) AS Total_Records
FROM retail_sales;

-- View first 10 records
SELECT *
FROM retail_sales
LIMIT 10;

-- ==========================================
-- STEP 31: REGION-WISE SALES AND PROFIT ANALYSIS
-- ==========================================

USE retail_sales_analysis;

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM retail_sales
GROUP BY Region
ORDER BY Total_Sales DESC;

-- ==========================================
-- STEP 32: CATEGORY-WISE SALES AND PROFIT ANALYSIS
-- ==========================================

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity
FROM retail_sales
GROUP BY Category
ORDER BY Total_Profit DESC;

-- ==========================================
-- STEP 33: TOP 10 PRODUCTS BY SALES
-- ==========================================

SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- ==========================================
-- STEP 34: DISCOUNT IMPACT ON PROFIT
-- ==========================================

SELECT
    Discount,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM retail_sales
GROUP BY Discount
ORDER BY Discount;

-- ==========================================
-- STEP 35: CUSTOMER SEGMENT ANALYSIS
-- ==========================================

SELECT
    Segment,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT `Order ID`) AS Total_Orders,
    SUM(Quantity) AS Total_Quantity
FROM retail_sales
GROUP BY Segment
ORDER BY Total_Sales DESC;

-- ==========================================
-- STEP 36: MONTHLY SALES AND PROFIT ANALYSIS
-- ==========================================

SELECT
    DATE_FORMAT(`Order Date`, '%Y-%m') AS Order_Month,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales
GROUP BY DATE_FORMAT(`Order Date`, '%Y-%m')
ORDER BY Order_Month;

-- ==========================================
-- STEP 37: CREATE BUSINESS PERFORMANCE VIEW
-- ==========================================

CREATE OR REPLACE VIEW vw_business_performance AS

SELECT
    Region,
    Category,
    Segment,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM retail_sales
GROUP BY
    Region,
    Category,
    Segment;
    
    
    SELECT *
FROM vw_business_performance;

-- ==========================================
-- STEP 38: CREATE PRODUCT PERFORMANCE VIEW
-- ==========================================

CREATE OR REPLACE VIEW vw_product_performance AS

SELECT
    Category,
    `Sub-Category`,
    `Product Name`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    ROUND(AVG(Discount), 2) AS Average_Discount
FROM retail_sales
GROUP BY
    Category,
    `Sub-Category`,
    `Product Name`;
    
    SELECT *
FROM vw_product_performance
LIMIT 10;