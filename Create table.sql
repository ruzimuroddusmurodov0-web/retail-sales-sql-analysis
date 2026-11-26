-- ============================================================================
-- FILE: 01_schema_ddl.sql
-- PROJECT: Sales & Customer Analytics (Oracle SH Sample Schema in PostgreSQL)
-- DESCRIPTION: Creates the `sh` schema and all 7 star-schema tables (6 dimensions + 1 fact)
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS sh;

-- 1. Dimension Table: Countries
CREATE TABLE IF NOT EXISTS sh.countries (
    country_id           INTEGER PRIMARY KEY,
    country_iso_code     CHAR(2) NOT NULL,
    country_name         VARCHAR(40) NOT NULL,
    country_subregion    VARCHAR(30) NOT NULL,
    country_subregion_id INTEGER NOT NULL,
    country_region       VARCHAR(20) NOT NULL,
    country_region_id    INTEGER NOT NULL,
    country_total        VARCHAR(11) NOT NULL,
    country_total_id     INTEGER NOT NULL
);

-- 2. Dimension Table: Customers
CREATE TABLE IF NOT EXISTS sh.customers (
    cust_id                 INTEGER PRIMARY KEY,
    cust_first_name         VARCHAR(20) NOT NULL,
    cust_last_name          VARCHAR(40) NOT NULL,
    cust_gender             CHAR(1) NOT NULL,
    cust_year_of_birth      SMALLINT NOT NULL,
    cust_marital_status     VARCHAR(20),
    cust_street_address     VARCHAR(40) NOT NULL,
    cust_postal_code        VARCHAR(10) NOT NULL,
    cust_city               VARCHAR(30) NOT NULL,
    cust_city_id            INTEGER NOT NULL,
    cust_state_province     VARCHAR(40) NOT NULL,
    cust_state_province_id  INTEGER NOT NULL,
    country_id              INTEGER NOT NULL REFERENCES sh.countries(country_id),
    cust_main_phone_number  VARCHAR(25) NOT NULL,
    cust_income_level       VARCHAR(30),
    cust_credit_limit       NUMERIC(10, 2),
    cust_email              VARCHAR(50),
    cust_total              VARCHAR(14) NOT NULL,
    cust_total_id           INTEGER NOT NULL,
    cust_src_id             INTEGER,
    cust_eff_from           DATE,
    cust_eff_to             DATE,
    cust_valid              VARCHAR(1)
);

-- 3. Dimension Table: Products
CREATE TABLE IF NOT EXISTS sh.products (
    prod_id                 INTEGER PRIMARY KEY,
    prod_name               VARCHAR(50) NOT NULL,
    prod_desc               VARCHAR(4000) NOT NULL,
    prod_subcategory        VARCHAR(50) NOT NULL,
    prod_subcategory_id     INTEGER NOT NULL,
    prod_subcategory_desc   VARCHAR(2000) NOT NULL,
    prod_category           VARCHAR(50) NOT NULL,
    prod_category_id        INTEGER NOT NULL,
    prod_category_desc      VARCHAR(2000) NOT NULL,
    prod_weight_class       SMALLINT NOT NULL,
    prod_unit_of_measure    VARCHAR(20),
    prod_pack_size          VARCHAR(30) NOT NULL,
    supplier_id             INTEGER NOT NULL,
    prod_status             VARCHAR(20) NOT NULL,
    prod_list_price         NUMERIC(8, 2) NOT NULL,
    prod_min_price          NUMERIC(8, 2) NOT NULL,
    prod_total              VARCHAR(13) NOT NULL,
    prod_total_id           INTEGER NOT NULL,
    prod_src_id             INTEGER,
    prod_eff_from           DATE,
    prod_eff_to             DATE,
    prod_valid              VARCHAR(1)
);

-- 4. Dimension Table: Channels
CREATE TABLE IF NOT EXISTS sh.channels (
    channel_id          INTEGER PRIMARY KEY,
    channel_desc        VARCHAR(20) NOT NULL,
    channel_class       VARCHAR(20) NOT NULL,
    channel_class_id    INTEGER NOT NULL,
    channel_total       VARCHAR(13) NOT NULL,
    channel_total_id    INTEGER NOT NULL
);

-- 5. Dimension Table: Promotions
CREATE TABLE IF NOT EXISTS sh.promotions (
    promo_id                INTEGER PRIMARY KEY,
    promo_name              VARCHAR(30) NOT NULL,
    promo_subcategory       VARCHAR(30) NOT NULL,
    promo_subcategory_id    INTEGER NOT NULL,
    promo_category          VARCHAR(30) NOT NULL,
    promo_category_id       INTEGER NOT NULL,
    promo_cost              NUMERIC(10, 2) NOT NULL,
    promo_begin_date        DATE NOT NULL,
    promo_end_date          DATE NOT NULL,
    promo_total             VARCHAR(15) NOT NULL,
    promo_total_id          INTEGER NOT NULL
);

-- 6. Dimension Table: Times
CREATE TABLE IF NOT EXISTS sh.times (
    time_id                     DATE PRIMARY KEY,
    day_name                    VARCHAR(9) NOT NULL,
    day_number_in_week          SMALLINT NOT NULL,
    day_number_in_month         SMALLINT NOT NULL,
    calendar_week_number        SMALLINT NOT NULL,
    fiscal_week_number          SMALLINT NOT NULL,
    calendar_month_number       SMALLINT NOT NULL,
    fiscal_month_number         SMALLINT NOT NULL,
    calendar_month_desc         VARCHAR(8) NOT NULL,
    fiscal_month_desc           VARCHAR(8) NOT NULL,
    days_in_cal_month           INTEGER NOT NULL,
    days_in_fis_month           INTEGER NOT NULL,
    end_of_cal_month            DATE NOT NULL,
    end_of_fis_month            DATE NOT NULL,
    calendar_month_name         VARCHAR(9) NOT NULL,
    fiscal_month_name           VARCHAR(9) NOT NULL,
    calendar_quarter_desc       CHAR(7) NOT NULL,
    fiscal_quarter_desc         CHAR(7) NOT NULL,
    days_in_cal_quarter         INTEGER NOT NULL,
    days_in_fis_quarter         INTEGER NOT NULL,
    end_of_cal_quarter          DATE NOT NULL,
    end_of_fis_quarter          DATE NOT NULL,
    calendar_quarter_number     SMALLINT NOT NULL,
    fiscal_quarter_number       SMALLINT NOT NULL,
    calendar_year               SMALLINT NOT NULL,
    fiscal_year                 SMALLINT NOT NULL,
    days_in_cal_year            INTEGER NOT NULL,
    days_in_fis_year            INTEGER NOT NULL,
    end_of_cal_year             DATE NOT NULL,
    end_of_fis_year             DATE NOT NULL
);

-- 7. Fact Table: Sales
CREATE TABLE IF NOT EXISTS sh.sales (
    prod_id         INTEGER NOT NULL REFERENCES sh.products(prod_id),
    cust_id         INTEGER NOT NULL REFERENCES sh.customers(cust_id),
    time_id         DATE NOT NULL REFERENCES sh.times(time_id),
    channel_id      INTEGER NOT NULL REFERENCES sh.channels(channel_id),
    promo_id        INTEGER NOT NULL REFERENCES sh.promotions(promo_id),
    quantity_sold   NUMERIC(10, 2) NOT NULL,
    amount_sold     NUMERIC(10, 2) NOT NULL
);

-- Performance Indexes on Foreign Keys
CREATE INDEX IF NOT EXISTS idx_sales_prod_id ON sh.sales(prod_id);
CREATE INDEX IF NOT EXISTS idx_sales_cust_id ON sh.sales(cust_id);
CREATE INDEX IF NOT EXISTS idx_sales_time_id ON sh.sales(time_id);
CREATE INDEX IF NOT EXISTS idx_sales_channel_id ON sh.sales(channel_id);
CREATE INDEX IF NOT EXISTS idx_sales_promo_id ON sh.sales(promo_id);
```[cite: 4]

Barcha 7 ta jadval (`countries`, `customers`, `products`, `channels`, `promotions`, `times`, `sales`) va ular orasidagi `FOREIGN KEY` bog‘lanishlari tayyor.