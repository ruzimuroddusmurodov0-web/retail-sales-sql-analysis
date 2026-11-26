-- ============================================================================
-- FILE: 02_seed_data.sql
-- PROJECT: Sales & Customer Analytics (Oracle SH Sample Schema in PostgreSQL)
-- DESCRIPTION: Sample seed dataset (INSERT statements) so all 12 analytical 
--              queries can be tested immediately without downloading the full 
--              ~900k row Oracle SH dump.
-- ============================================================================

-- 1. Countries
INSERT INTO sh.countries (country_id, country_iso_code, country_name, country_subregion, country_subregion_id, country_region, country_region_id, country_total, country_total_id) VALUES
(52790, 'US', 'United States of America', 'Northern America', 52797, 'Americas', 52801, 'World total', 52806),
(52776, 'DE', 'Germany', 'Western Europe', 52799, 'Europe', 52803, 'World total', 52806),
(52789, 'GB', 'United Kingdom', 'Northern Europe', 52798, 'Europe', 52803, 'World total', 52806),
(52782, 'JP', 'Japan', 'Eastern Asia', 52793, 'Asia', 52802, 'World total', 52806),
(52772, 'CA', 'Canada', 'Northern America', 52797, 'Americas', 52801, 'World total', 52806);

-- 2. Customers
INSERT INTO sh.customers (cust_id, cust_first_name, cust_last_name, cust_gender, cust_year_of_birth, cust_marital_status, cust_street_address, cust_postal_code, cust_city, cust_city_id, cust_state_province, cust_state_province_id, country_id, cust_main_phone_number, cust_income_level, cust_credit_limit, cust_email, cust_total, cust_total_id, cust_valid) VALUES
(1001, 'Abigail', 'Ruddy', 'F', 1978, 'married', '655 Park Avenue', '10021', 'New York', 51765, 'NY', 52710, 52790, '212-555-0142', 'J: 190,000 - 249,999', 15000.00, 'abigail.ruddy@example.com', 'Customer total', 52772, 'A'),
(1002, 'Lukas', 'Weber', 'M', 1985, 'single', 'Berliner Strasse 42', '10115', 'Berlin', 51120, 'Berlin', 52610, 52776, '+49-30-555019', 'G: 130,000 - 149,999', 10000.00, 'lukas.weber@example.de', 'Customer total', 52772, 'A'),
(1003, 'Charlotte', 'Hughes', 'F', 1990, 'married', '14 Kensington High St', 'W8 4PT', 'London', 51480, 'Greater London', 52650, 52789, '+44-20-794601', 'L: 300,000 and above', 20000.00, 'c.hughes@example.co.uk', 'Customer total', 52772, 'A'),
(1004, 'Kenji', 'Takahashi', 'M', 1982, 'married', '2-11-3 Shibuya', '150-0002', 'Tokyo', 51910, 'Tokyo', 52740, 52782, '+81-3-5550188', 'H: 150,000 - 169,999', 12000.00, 'k.takahashi@example.jp', 'Customer total', 52772, 'A'),
(1005, 'Liam', 'Tremblay', 'M', 1994, 'single', '350 Rue Sainte-Catherine', 'H3B 1A1', 'Montreal', 51640, 'Quebec', 52690, 52772, '514-555-0177', 'C: 50,000 - 69,999', 5000.00, 'liam.tremblay@example.ca', 'Customer total', 52772, 'A');

-- 3. Products
INSERT INTO sh.products (prod_id, prod_name, prod_desc, prod_subcategory, prod_subcategory_id, prod_subcategory_desc, prod_category, prod_category_id, prod_category_desc, prod_weight_class, prod_unit_of_measure, prod_pack_size, supplier_id, prod_status, prod_list_price, prod_min_price, prod_total, prod_total_id, prod_valid) VALUES
(13, '5MP Telephoto Digital Camera', 'High-resolution 5MP digital camera with optical zoom', 'Cameras', 201, 'Digital Cameras', 'Photo', 20, 'Photography Equipment', 2, 'U', '1', 1, 'STATUS', 899.99, 750.00, 'Product total', 1, 'A'),
(14, '17" LCD w/built-in HDTV Tuner', '17-inch flat panel monitor with integrated HDTV tuner', 'Monitors', 202, 'Computer Monitors', 'Peripherals and Accessories', 21, 'Computer Peripherals', 4, 'U', '1', 1, 'STATUS', 1199.99, 999.99, 'Product total', 1, 'A'),
(18, 'Envoy Ambassador', 'High-performance enterprise laptop workstation', 'Portable PCs', 203, 'Notebooks and Laptops', 'Hardware', 22, 'Computer Hardware', 3, 'U', '1', 1, 'STATUS', 1499.99, 1299.99, 'Product total', 1, 'A'),
(24, 'Home Theatre Package with DVD-Audio/Video Play', 'Surround sound home theatre system with DVD player', 'Home Audio', 204, 'Home Audio Systems', 'Electronics', 23, 'Consumer Electronics', 5, 'U', '1', 1, 'STATUS', 599.99, 499.99, 'Product total', 1, 'A'),
(30, 'Standard Mouse', 'Ergonomic wired optical mouse', 'Accessories', 205, 'Input Devices', 'Peripherals and Accessories', 21, 'Computer Peripherals', 1, 'U', '1', 1, 'STATUS', 24.99, 19.99, 'Product total', 1, 'A'),
(45, 'Legacy CD-ROM Drive 4x', 'Discontinued optical drive (sample unsold product)', 'Storage', 206, 'Optical Storage', 'Hardware', 22, 'Computer Hardware', 2, 'U', '1', 1, 'STATUS', 49.99, 39.99, 'Product total', 1, 'A');

-- 4. Channels
INSERT INTO sh.channels (channel_id, channel_desc, channel_class, channel_class_id, channel_total, channel_total_id) VALUES
(2, 'Partners', 'Indirect', 12, 'Channel total', 1),
(3, 'Direct Sales', 'Direct', 13, 'Channel total', 1),
(4, 'Internet', 'Indirect', 12, 'Channel total', 1),
(9, 'Tele Sales', 'Direct', 13, 'Channel total', 1);

-- 5. Promotions (Note: promo_id = 999 represents "No Promotion")
INSERT INTO sh.promotions (promo_id, promo_name, promo_subcategory, promo_subcategory_id, promo_category, promo_category_id, promo_cost, promo_begin_date, promo_end_date, promo_total, promo_total_id) VALUES
(999, 'NO PROMOTION #', 'NO PROMOTION', 999, 'NO PROMOTION', 999, 0.00, '1998-01-01', '2025-12-31', 'Promo total', 1),
(33, 'Newspaper Ad #33', 'newspaper', 301, 'print media', 30, 12500.00, '2000-01-01', '2000-06-30', 'Promo total', 1),
(350, 'TV Commercial #350', 'TV', 302, 'broadcast', 31, 45000.00, '2001-01-01', '2001-12-31', 'Promo total', 1);

-- 6. Times
INSERT INTO sh.times (time_id, day_name, day_number_in_week, day_number_in_month, calendar_week_number, fiscal_week_number, calendar_month_number, fiscal_month_number, calendar_month_desc, fiscal_month_desc, days_in_cal_month, days_in_fis_month, end_of_cal_month, end_of_fis_month, calendar_month_name, fiscal_month_name, calendar_quarter_desc, fiscal_quarter_desc, days_in_cal_quarter, days_in_fis_quarter, end_of_cal_quarter, end_of_fis_quarter, calendar_quarter_number, fiscal_quarter_number, calendar_year, fiscal_year, days_in_cal_year, days_in_fis_year, end_of_cal_year, end_of_fis_year) VALUES
('1999-03-15', 'Monday', 1, 15, 11, 11, 3, 3, '1999-03', '1999-03', 31, 31, '1999-03-31', '1999-03-31', 'March', 'March', '1999-01', '1999-01', 90, 90, '1999-03-31', '1999-03-31', 1, 1, 1999, 1999, 365, 365, '1999-12-31', '1999-12-31'),
('2000-05-20', 'Saturday', 6, 20, 20, 20, 5, 5, '2000-05', '2000-05', 31, 31, '2000-05-31', '2000-05-31', 'May', 'May', '2000-02', '2000-02', 91, 91, '2000-06-30', '2000-06-30', 2, 2, 2000, 2000, 366, 366, '2000-12-31', '2000-12-31'),
('2000-11-10', 'Friday', 5, 10, 45, 45, 11, 11, '2000-11', '2000-11', 30, 30, '2000-11-30', '2000-11-30', 'November', 'November', '2000-04', '2000-04', 92, 92, '2000-12-31', '2000-12-31', 4, 4, 2000, 2000, 366, 366, '2000-12-31', '2000-12-31'),
('2001-04-12', 'Thursday', 4, 12, 15, 15, 4, 4, '2001-04', '2001-04', 30, 30, '2001-04-30', '2001-04-30', 'April', 'April', '2001-02', '2001-02', 91, 91, '2001-06-30', '2001-06-30', 2, 2, 2001, 2001, 365, 365, '2001-12-31', '2001-12-31'),
('2001-09-18', 'Tuesday', 2, 18, 38, 38, 9, 9, '2001-09', '2001-09', 30, 30, '2001-09-30', '2001-09-30', 'September', 'September', '2001-03', '2001-03', 92, 92, '2001-09-30', '2001-09-30', 3, 3, 2001, 2001, 365, 365, '2001-12-31', '2001-12-31');

-- 7. Sales Fact Records
INSERT INTO sh.sales (prod_id, cust_id, time_id, channel_id, promo_id, quantity_sold, amount_sold) VALUES
(18, 1001, '1999-03-15', 3, 999, 2, 2999.98),
(13, 1002, '1999-03-15', 4, 999, 1, 899.99),
(14, 1001, '2000-05-20', 3, 33,  3, 3599.97),
(18, 1003, '2000-05-20', 2, 999, 2, 2999.98),
(24, 1004, '2000-11-10', 4, 33,  2, 1199.98),
(30, 1005, '2000-11-10', 9, 999, 5, 124.95),
(14, 1003, '2001-04-12', 3, 350, 4, 4799.96),
(18, 1001, '2001-04-12', 4, 350, 3, 4499.97),
(13, 1004, '2001-09-18', 2, 999, 2, 1799.98),
(24, 1002, '2001-09-18', 3, 999, 3, 1799.97);
