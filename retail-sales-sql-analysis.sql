
-- ============================================================================
-- PROJECT: Sales & Customer Analytics (Oracle SH Sample Schema in PostgreSQL)
-- AUTHOR: Data Analytics Portfolio
-- DATABASE: PostgreSQL (DBeaver)
-- ============================================================================

-- ===== 1. General KPIs =====
-- Question: What is the total number of sales records, total revenue, total units sold, and average sale amount?
-- Goal: Get a high-level overview of overall sales volume.
-- Method: COUNT, SUM, AVG

SELECT 
    COUNT(*) AS total_transactions,
    SUM(s.amount_sold) AS total_revenue,
    SUM(s.quantity_sold) AS total_units_sold,
    ROUND(AVG(s.amount_sold), 1) AS avg_sale_amount
FROM sh.sales s;


-- ===== 2. Revenue and Share by Channel =====
-- Question: How much revenue does each sales channel generate, and what percentage of total revenue does it represent?
-- Goal: Identify which channels drive the core of the business.
-- Method: JOIN, GROUP BY, Window Function (SUM OVER)

SELECT 
    channel_desc,
    channel_revenue,
    SUM(channel_revenue) OVER () AS total_revenue,
    ROUND(channel_revenue * 100.0 / SUM(channel_revenue) OVER (), 1) AS revenue_share_pct
FROM (
    SELECT 
        c.channel_desc,
        SUM(s.amount_sold) AS channel_revenue
    FROM sh.sales s 
    JOIN sh.channels c ON s.channel_id = c.channel_id 
    GROUP BY c.channel_id, c.channel_desc
) AS t
ORDER BY channel_revenue DESC;


-- ===== 3. Revenue by Year =====
-- Question: How has sales revenue changed over the years?
-- Goal: Observe revenue dynamics and annual trends.
-- Method: JOIN, GROUP BY

SELECT 
    t.calendar_year,
    SUM(s.amount_sold) AS annual_revenue
FROM sh.sales s 
JOIN sh.times t ON s.time_id = t.time_id 
GROUP BY t.calendar_year 
ORDER BY t.calendar_year DESC;


-- ===== 4. Top 10 Best-Selling Products =====
-- Question: Which 10 products generated the highest revenue, and which categories do they belong to?
-- Goal: Identify primary revenue-generating products.
-- Method: JOIN, GROUP BY, ORDER BY, LIMIT

SELECT 
    p.prod_id,
    p.prod_name,
    p.prod_category,
    SUM(s.amount_sold) AS total_revenue
FROM sh.sales s 
JOIN sh.products p ON s.prod_id = p.prod_id 
GROUP BY p.prod_id, p.prod_name, p.prod_category 
ORDER BY total_revenue DESC 
LIMIT 10;


-- ===== 5. Top 10 Countries by Revenue =====
-- Question: Which 10 countries generated the highest revenue?
-- Goal: Understand the geographical distribution of revenue.
-- Method: 3-table JOIN, GROUP BY, LIMIT

SELECT 
    c2.country_id,
    c2.country_name,
    SUM(s.amount_sold) AS total_revenue
FROM sh.sales s 
JOIN sh.customers c ON s.cust_id = c.cust_id 
JOIN sh.countries c2 ON c.country_id = c2.country_id 
GROUP BY c2.country_id, c2.country_name 
ORDER BY total_revenue DESC 
LIMIT 10;


-- ===== 6. Category and Channel Breakdown =====
-- Question: How much revenue did each product category generate through each sales channel?
-- Goal: Determine which categories perform best in specific channels.
-- Method: 3-table JOIN, multi-column GROUP BY

SELECT 
    c.channel_id,
    c.channel_desc,
    p.prod_category,
    SUM(s.amount_sold) AS total_revenue
FROM sh.sales s 
JOIN sh.products p ON s.prod_id = p.prod_id 
JOIN sh.channels c ON s.channel_id = c.channel_id 
GROUP BY c.channel_id, c.channel_desc, p.prod_category 
ORDER BY total_revenue DESC;


-- ===== 7. Promotional vs. Non-Promotional Sales =====
-- Question: How much revenue comes from promotional sales versus non-promotional sales?
-- Goal: Evaluate the financial impact and share of promotions.
-- Method: JOIN, CASE (promo_id = 999 indicates "No Promotion")

SELECT 
    CASE 
        WHEN p.promo_id = 999 THEN 'Non-Promotional Sales'
        ELSE 'Promotional Sales'
    END AS sales_type,
    SUM(s.amount_sold) AS total_revenue
FROM sh.sales s 
JOIN sh.promotions p ON s.promo_id = p.promo_id 
GROUP BY CASE 
    WHEN p.promo_id = 999 THEN 'Non-Promotional Sales'
    ELSE 'Promotional Sales'
END
ORDER BY total_revenue DESC;


-- ===== 8. Income Level and Credit Limit Analysis =====
-- Question: What is the customer count and average credit limit across each customer income level?
-- Goal: Assess whether credit limits align with customer income tiers (from a banking risk perspective).
-- Method: GROUP BY, COUNT, AVG

SELECT 
    c.cust_income_level,
    COUNT(*) AS customer_count,
    ROUND(AVG(c.cust_credit_limit), 0) AS avg_credit_limit
FROM sh.customers c 
GROUP BY c.cust_income_level 
ORDER BY c.cust_income_level DESC;


-- ===== 9. Unsold Products (Dead Stock Check) =====
-- Question: Are there any products that have never been sold?
-- Goal: Identify stagnant or non-performing inventory in the catalog.
-- Method: LEFT JOIN and IS NULL, UNION ALL

-- 9.1. List of unsold products (LEFT JOIN + IS NULL)
SELECT 
    p.prod_id,
    p.prod_name,
    p.prod_category
FROM sh.products p
LEFT JOIN sh.sales s ON p.prod_id = s.prod_id
WHERE s.prod_id IS NULL;

-- 9.2. Catalog vs. sold product count comparison (UNION ALL)
SELECT 
    'all_products' AS metric_type,
    COUNT(*) AS product_count
FROM sh.products p 
UNION ALL 
SELECT 
    'sold_products' AS metric_type,
    COUNT(DISTINCT prod_id) AS product_count 
FROM sh.sales s;


-- ===== 10. Countries Above Average Revenue =====
-- Question: Which countries generated revenue higher than the overall country average?
-- Goal: Isolate top-performing priority markets.
-- Method: CTE (WITH), Subquery

WITH country_revenue AS (      
    SELECT 
        c2.country_name,
        SUM(s.amount_sold) AS total_revenue
    FROM sh.sales s 
    JOIN sh.customers c ON s.cust_id = c.cust_id 
    JOIN sh.countries c2 ON c.country_id = c2.country_id 
    GROUP BY c2.country_name
)
SELECT 
    country_name,
    total_revenue 
FROM country_revenue 
WHERE total_revenue > (SELECT AVG(total_revenue) FROM country_revenue)
ORDER BY total_revenue DESC;


-- ===== 11. Top 3 Products per Category =====
-- Question: What are the top 3 revenue-generating products within each product category?
-- Goal: Identify category leaders.
-- Method: Window Function RANK() OVER (PARTITION BY ...)

SELECT 
    t.prod_id,
    t.prod_name,
    t.prod_category,
    t.total_revenue,
    t.rnk 
FROM (
    SELECT 
        p.prod_id,
        p.prod_name,
        p.prod_category,
        SUM(s.amount_sold) AS total_revenue,
        RANK() OVER (PARTITION BY p.prod_category ORDER BY SUM(s.amount_sold) DESC) AS rnk 
    FROM sh.sales s 
    JOIN sh.products p ON s.prod_id = p.prod_id 
    GROUP BY p.prod_category, p.prod_id, p.prod_name
) AS t 
WHERE t.rnk <= 3
ORDER BY t.prod_category, t.rnk;


-- ===== 12. Year-over-Year (YoY) Revenue Growth =====
-- Question: By what percentage did revenue change each year compared to the previous year?
-- Goal: Identify periods of growth and decline.
-- Method: Window Function LAG() OVER (ORDER BY ...)

SELECT 
    calendar_year,
    annual_revenue,
    prev_year_revenue,
    ROUND((annual_revenue - prev_year_revenue) * 100.0 / prev_year_revenue, 1) AS yoy_growth_pct
FROM (	   
    SELECT 
        t.calendar_year,
        SUM(s.amount_sold) AS annual_revenue,
        LAG(SUM(s.amount_sold)) OVER (ORDER BY t.calendar_year ASC) AS prev_year_revenue
    FROM sh.sales s 
    JOIN sh.times t ON s.time_id = t.time_id 
    GROUP BY t.calendar_year
) AS annual_stats
ORDER BY calendar_year DESC;
