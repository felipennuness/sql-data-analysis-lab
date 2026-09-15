-- SQL Data Analysis Lab
-- Section 04: SQL Functions
-- Database: MySQL / maven_advanced_sql
--
-- Practice implementation based on the course assignment set and reviewed
-- against the provided reference material.

USE maven_advanced_sql;

-- ============================================================
-- 1. NUMERIC FUNCTIONS
-- Group customers into $10 spending bands.
-- ============================================================
WITH customer_spend AS (
    SELECT
        o.customer_id,
        SUM(o.units * p.unit_price) AS total_spend
    FROM orders AS o
    LEFT JOIN products AS p
        ON o.product_id = p.product_id
    GROUP BY o.customer_id
),
spend_bins AS (
    SELECT
        customer_id,
        total_spend,
        FLOOR(total_spend / 10) * 10 AS spend_bin
    FROM customer_spend
)
SELECT
    spend_bin,
    COUNT(customer_id) AS number_of_customers
FROM spend_bins
GROUP BY spend_bin
ORDER BY spend_bin;


-- ============================================================
-- 2. DATETIME FUNCTIONS
-- Extract Q2 2024 orders and calculate an estimated ship date two days later.
-- ============================================================
SELECT
    order_id,
    order_date,
    DATE_ADD(order_date, INTERVAL 2 DAY) AS ship_date
FROM orders
WHERE YEAR(order_date) = 2024
  AND MONTH(order_date) BETWEEN 4 AND 6
ORDER BY order_date, order_id;


-- ============================================================
-- 3. STRING FUNCTIONS
-- Standardize factory names and create a composite factory-product key.
-- ============================================================
WITH cleaned_factory AS (
    SELECT
        factory,
        product_id,
        REPLACE(REPLACE(factory, "'", ''), ' ', '-') AS factory_clean
    FROM products
)
SELECT
    factory,
    product_id,
    factory_clean,
    CONCAT(factory_clean, '-', product_id) AS factory_product_id
FROM cleaned_factory
ORDER BY factory_clean, product_id;


-- ============================================================
-- 4. PATTERN / SUBSTRING HANDLING
-- Remove the label prefix from product names containing a hyphen.
-- ============================================================
SELECT
    product_name,
    CASE
        WHEN INSTR(product_name, '-') = 0 THEN product_name
        ELSE SUBSTR(product_name, INSTR(product_name, '-') + 2)
    END AS simplified_product_name
FROM products
ORDER BY product_name;


-- ============================================================
-- 5. NULL HANDLING
-- Replace missing divisions with both a generic label and the most common
-- non-null division for the same factory.
-- ============================================================
WITH division_counts AS (
    SELECT
        factory,
        division,
        COUNT(*) AS product_count
    FROM products
    WHERE division IS NOT NULL
    GROUP BY factory, division
),
ranked_divisions AS (
    SELECT
        factory,
        division,
        product_count,
        ROW_NUMBER() OVER (
            PARTITION BY factory
            ORDER BY product_count DESC, division
        ) AS division_rank
    FROM division_counts
),
top_division AS (
    SELECT
        factory,
        division
    FROM ranked_divisions
    WHERE division_rank = 1
)
SELECT
    p.product_name,
    p.factory,
    p.division,
    COALESCE(p.division, 'Other') AS division_with_generic_fallback,
    COALESCE(p.division, td.division) AS division_with_factory_fallback
FROM products AS p
LEFT JOIN top_division AS td
    ON p.factory = td.factory
ORDER BY p.factory, p.product_name;
