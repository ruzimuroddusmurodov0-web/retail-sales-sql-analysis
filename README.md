# Sales & Customer Analytics with PostgreSQL (`SH` Schema)

## Project Overview
This project presents an end-to-end SQL data analysis of retail sales, customer credit profiles, promotional efficiency, and year-over-year revenue dynamics using the **Sales History (`sh`)** schema in **PostgreSQL**. The queries are designed to answer key business and banking-oriented analytical questions—ranging from revenue concentration and channel performance to customer credit limit alignment.

---

## Repository Structure
* `README.md` — Project documentation, schema overview, and key analytical findings.
* `01_schema_ddl.sql` — DDL script creating the `sh` schema, 7 star-schema tables (`PRIMARY KEY` / `FOREIGN KEY` constraints), and performance indexes.
* `02_seed_data.sql` — Sample `INSERT` dataset allowing immediate execution and testing of all analytical queries.
* `03_sales_analytics.sql` — 12 structured SQL queries addressing core business KPIs and analytical questions.

---

## Database Schema
The analysis utilizes a Star Schema architecture centered around the `sh.sales` fact table connected to six dimension tables:
* `sh.sales` — Core transaction records (`amount_sold`, `quantity_sold`)
* `sh.products` — Product catalog, subcategories, and categories
* `sh.customers` — Customer demographics, income tiers, and credit limits
* `sh.countries` — Geographic regions, subregions, and countries
* `sh.channels` — Sales distribution channels (Direct Sales, Internet, Partners, Tele Sales)
* `sh.promotions` — Marketing campaigns and promotion flags (`promo_id = 999` denotes non-promotional sales)
* `sh.times` — Calendar dates, quarters, and fiscal/calendar years

---

## Business Questions & Analytical Techniques

| # | Business Question | Key SQL Techniques |
|---|---|---|
| 1 | **General KPIs:** Total transactions, revenue, units sold, and average ticket size | `COUNT`, `SUM`, `AVG`, `ROUND` |
| 2 | **Channel Share:** Revenue contribution (%) by each sales channel | `JOIN`, `GROUP BY`, `SUM() OVER ()` |
| 3 | **Annual Dynamics:** Total revenue trend across calendar years | `JOIN`, `GROUP BY`, `ORDER BY` |
| 4 | **Top 10 Products:** Highest revenue-generating products and categories | `JOIN`, `GROUP BY`, `LIMIT` |
| 5 | **Top 10 Countries:** Geographical revenue distribution | Multi-table `JOIN`, `GROUP BY`, `LIMIT` |
| 6 | **Category × Channel Matrix:** Cross-sectional performance by category and channel | 3-table `JOIN`, Multi-column `GROUP BY` |
| 7 | **Promotion Impact:** Revenue split between promotional and regular sales | `JOIN`, `CASE WHEN` |
| 8 | **Credit Risk Alignment:** Customer count and average credit limit by income level | `GROUP BY`, `COUNT`, `AVG` |
| 9 | **Inventory Audit:** Detecting unsold ("dead stock") products | `LEFT JOIN ... WHERE IS NULL`, `UNION ALL` |
| 10 | **Above-Average Markets:** Countries outperforming the global country average | `CTE (WITH)`, Scalar Subquery |
| 11 | **Category Leaders:** Top 3 products within each product category | `RANK() OVER (PARTITION BY ...)` |
| 12 | **YoY Growth:** Annual revenue growth/decline percentage | `LAG() OVER (ORDER BY ...)` |

---

## Key Analytical Insights
* **100% Catalog Utilization:** All 72 products registered in the full `sh.products` catalog have recorded sales transactions (`0` unsold items).
* **Channel Concentration:** Using window functions (`SUM() OVER ()`), revenue share per channel was calculated without losing row-level detail.
* **Credit Limit Alignment:** Evaluating `cust_credit_limit` across `cust_income_level` tiers provides a foundation for banking credit-scoring and risk alignment checks.
* **YoY Tracking:** Applying `LAG()` enabled direct year-over-year percentage growth tracking to spot expansion and contraction periods.

---

## Tools & Environment
* **Database:** PostgreSQL
* **SQL Client:** DBeaver

