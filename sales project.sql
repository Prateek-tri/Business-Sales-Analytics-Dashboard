USE sales_project;
CREATE TABLE Superstoree (
    RowID INT,
    OrderID VARCHAR(20),
    OrderDate DATE,
    ShipDate DATE,
    ShipMode VARCHAR(30),
    CustomerID VARCHAR(20),
    CustomerName VARCHAR(100),
    Segment VARCHAR(20),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    PostalCode VARCHAR(20),
    Region VARCHAR(20),
    ProductID VARCHAR(30),
    Category VARCHAR(30),
    SubCategory VARCHAR(40),
    ProductName VARCHAR(255),
    Sales DECIMAL(12,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(12,2)
);

DESCRIBE superstore_raw;

-- showing 10 rows
SELECT *
FROM superstore_raw
LIMIT 10;

-- total no of rows
SELECT COUNT(*)
FROM superstore_raw;

-- Check missing value 
SELECT
    SUM(CASE WHEN `Row ID` IS NULL THEN 1 ELSE 0 END) AS RowID_Missing,
    SUM(CASE WHEN `Order ID` IS NULL THEN 1 ELSE 0 END) AS OrderID_Missing,
    SUM(CASE WHEN `Order Date` IS NULL THEN 1 ELSE 0 END) AS OrderDate_Missing,
    SUM(CASE WHEN `Ship Date` IS NULL THEN 1 ELSE 0 END) AS ShipDate_Missing,
    SUM(CASE WHEN `Ship Mode` IS NULL THEN 1 ELSE 0 END) AS ShipMode_Missing,
    SUM(CASE WHEN `Customer ID` IS NULL THEN 1 ELSE 0 END) AS CustomerID_Missing,
    SUM(CASE WHEN `Customer Name` IS NULL THEN 1 ELSE 0 END) AS CustomerName_Missing,
    SUM(CASE WHEN Segment IS NULL THEN 1 ELSE 0 END) AS Segment_Missing,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country_Missing,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS City_Missing,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Missing,
    SUM(CASE WHEN `Postal Code` IS NULL THEN 1 ELSE 0 END) AS PostalCode_Missing,
    SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS Region_Missing,
    SUM(CASE WHEN `Product ID` IS NULL THEN 1 ELSE 0 END) AS ProductID_Missing,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS Category_Missing,
    SUM(CASE WHEN `Sub-Category` IS NULL THEN 1 ELSE 0 END) AS SubCategory_Missing,
    SUM(CASE WHEN `Product Name` IS NULL THEN 1 ELSE 0 END) AS ProductName_Missing,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Sales_Missing,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Quantity_Missing,
    SUM(CASE WHEN Discount IS NULL THEN 1 ELSE 0 END) AS Discount_Missing,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS Profit_Missing
FROM superstore_raw;

-- Count unique orders.
SELECT COUNT(DISTINCT `Order ID`) AS TotalOrders
FROM superstore_raw;
-- Know customer base size
SELECT COUNT(DISTINCT `Customer ID`) AS TotalCustomers
FROM superstore_raw;

-- Region Check - Verify category consistency
SELECT Region, COUNT(*) AS Records
FROM superstore_raw
GROUP BY Region;

-- Check product categories.
SELECT DISTINCT Category
FROM superstore_raw;

-- sub-categories
SELECT COUNT(DISTINCT `Sub-Category`) AS SubCategories
FROM superstore_raw;

-- Date Range - Understand time period.
SELECT
MIN(`Order Date`) AS StartDate,
MAX(`Order Date`) AS EndDate
FROM superstore_raw;

-- Discount Range
SELECT
MIN(Discount) AS MinDiscount,
MAX(Discount) AS MaxDiscount
FROM superstore_raw;

-- Sales Range
SELECT
MIN(Sales) AS MinSales,
MAX(Sales) AS MaxSales
FROM superstore_raw;

-- Find losses and high-profit orders.
SELECT
MIN(Profit) AS MinProfit,
MAX(Profit) AS MaxProfit
FROM superstore_raw;

-- Top 10 Most Expensive Orders
SELECT
`Order ID`,
Sales
FROM superstore_raw
ORDER BY Sales DESC
LIMIT 10;

-- Find data quality issues.
SELECT
SUM(CASE WHEN `Postal Code` IS NULL THEN 1 ELSE 0 END) AS PostalCodeMissing
FROM superstore_raw;

-- Verify total sales remain unchanged.
SELECT ROUND(SUM(Sales),2) AS TotalSales
FROM superstore_raw;

-- Verify total profit remains unchanged.
SELECT ROUND(SUM(Profit),2) AS TotalProfit
FROM superstore_raw;

-- Verify total units sold remain unchanged.
SELECT SUM(Quantity) AS TotalUnits
FROM superstore_raw;

-- Shipping Rule Validation - Ship Date ≥ Order Date
SELECT COUNT(*) AS InvalidRows
FROM superstore_raw
WHERE `Ship Date` < `Order Date`;

-- Create Customer Dimension
CREATE TABLE Dim_Customer AS
SELECT DISTINCT
    `Customer ID`,
    `Customer Name`,
    Segment
FROM superstore_raw;
SELECT * FROM Dim_Customer;

-- All unique products are stored once
CREATE TABLE Dim_Product AS
SELECT DISTINCT
    `Product ID`,
    `Product Name`,
    Category,
    `Sub-Category`
FROM superstore_raw;
SELECT * FROM Dim_Product;

-- Stores location information separately.
CREATE TABLE Dim_Geography AS
SELECT DISTINCT
	`Postal Code`,
    City,
    State,
    Region,
    Country
FROM superstore_raw;
SELECT * FROM Dim_Geography;

-- Check the date format
DESCRIBE superstore_raw;
SELECT `Order Date`, `Ship Date`
FROM superstore_raw
LIMIT 10;

DROP TABLE IF EXISTS Dim_Date;
-- -- Create Date Dimension
CREATE TABLE Dim_Date AS
SELECT DISTINCT
    STR_TO_DATE(`Order Date`, '%m/%d/%Y') AS OrderDate,
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Year,
    QUARTER(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Quarter,
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Month,
    MONTHNAME(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS MonthName
FROM superstore_raw;
SELECT * FROM Dim_Date;

-- This becomes the central table
CREATE TABLE Fact_Sales AS
SELECT
    `Row ID`,
    `Order ID`,
    `Order Date`,
    `Customer ID`,
    `Product ID`,
    `Postal Code`,
    Sales,
    Quantity,
    Discount,
    Profit
FROM superstore_raw;
SELECT * FROM Fact_Sales;

SHOW TABLES;
SELECT * FROM dim_date LIMIT 10;

-- Verify Fact Table
SELECT * FROM fact_sales LIMIT 10;

-- Verify Record Counts
SELECT COUNT(*) FROM fact_sales;
SELECT COUNT(*) FROM dim_customer;
SELECT COUNT(*) FROM dim_product;
SELECT COUNT(*) FROM dim_geography;
SELECT COUNT(*) FROM dim_date;

SELECT * FROM dim_date LIMIT 5;

-- confirm the duplicates
SELECT `Product ID`, COUNT(*) AS cnt
FROM dim_product
GROUP BY `Product ID`
HAVING COUNT(*) > 1;

CREATE TABLE dim_product AS
SELECT DISTINCT
    `Product ID`,
    `Product Name`,
    Category,
    `Sub-Category`
FROM superstore_raw;