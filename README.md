# Business-Sales-Analytics-Dashboard
Interactive Business Sales Analytics Dashboard built using SQL and Power BI. Includes data cleaning, KPI analysis, DAX measures, and interactive visualizations for business decision making
## Project Overview

This project is an end-to-end Business Intelligence solution developed using SQL and Power BI.

The objective is to help business stakeholders monitor sales performance, identify profitable products and regions, analyze monthly sales trends, and support data-driven decision-making through an interactive dashboard.

The project follows the complete analytics workflow from data exploration and cleaning to dashboard development and business insights.

## Business Problem

Business leaders often struggle to obtain a unified view of organizational sales performance.

Without a centralized dashboard, it becomes difficult to:

Monitor sales performance
Compare regional performance
Identify top-performing products
Analyze profitability
Track sales trends over time

This project solves the problem by creating an interactive Power BI dashboard.

## Objectives
Analyze overall sales performance
1. Monitor monthly sales trends
2. Compare regional sales
3. Identify top-selling products
4. Analyze category-wise performance
5. Measure business profitability
6. Create interactive filters for better analysis

# Dataset

The project uses a Superstore Sales Dataset containing transactional sales records.

## Dataset includes
1. Order Date
2. Ship Date
3. Customer
4. Product
5. Category
6. Sub-Category
7. Segment
8. Region
9. State
10. Sales
11. Quantity
12. Discount
13. Profit

## Technologies Used
- SQL (MySQL)
- Power BI
- DAX
- Power Query
- Microsoft Excel

## Project Workflow
1. Data Collection
Imported Superstore Sales Dataset.

2. Data Cleaning using SQL
Performed:
- Checked missing values
- Verified data types
- Removed duplicates
- Verified data quality
- Checked minimum and maximum sales
- Profit validation

Example SQL operations:
- DESCRIBE Table
- COUNT()
- MIN()
- MAX()
- SUM()
- CASE WHEN
- NULL validation

3. Data Modeling
Created relationships between tables inside Power BI.
- Date hierarchy
- Region analysis
- Product analysis
- Category analysis

4. DAX Measures

Created important KPIs including:

- Total Sales
- Total Profit
- Total Quantity
- Profit Margin %

Additional measures can include:
- Average Order Value
- Sales Growth
- Year-over-Year Sales
- Month-over-Month Sales

## Dashboard KPIs

✔ Total Sales
✔ Total Profit
✔ Total Quantity Sold
✔ Profit Margin %

## Dashboard Visualizations
The dashboard includes:

- KPI Cards
- Monthly Sales Trend
- Sales by Product
- Sales by Region
- Sales by Category
- Sales by State
- Profit by Region
- Matrix Summary
- Interactive Slicers

## Dashboard Features
Interactive filters:
- Year
- Region
- Category
- Segment
- Dynamic filtering across all visuals.

## Key Insights
Some business insights generated from the dashboard include:

- Monthly sales fluctuate significantly with peak performance in November.
- Technology category contributes the highest revenue.
- Top-selling products generate a major portion of total sales.
- Regional analysis identifies strong and weak performing markets.
- Profitability varies across categories and regions.

## Business Impact
The dashboard enables management to:
- Monitor overall business performance
- Identify profitable products
- Improve inventory planning
- Track sales trends
- Support strategic decision-making
- Improve regional sales performance
