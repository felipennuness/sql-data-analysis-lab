-- SQL Data Analysis Lab
-- Section 03: Window Functions
-- Database: MySQL / maven_advanced_sql
--
-- Practice implementation based on the course assignment set and reviewed
-- against the provided reference material.

USE maven_advanced_sql;

-- ============================================================
-- 1. ROW_NUMBER
-- Number each transaction in chronological transaction order per customer.
-- ============================================================
SELECT
    customer_id,
    order_id,
    order_date,
    transaction_id,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY transaction_id
    ) AS transaction_number
FROM orders
ORDER BY customer_id, transaction_id;


-- ============================================================
-- 2. DENSE_RANK
-- Rank products inside each order from highest to lowest unit quantity.
-- Ties receive the same rank without gaps.
-- ============================================================
SELECT
    order_id,
    product_id,
    units,
    DENSE_RANK() OVER (
        PARTITION BY order_id
        ORDER BY units DESC
    ) AS product_rank
FROM orders
ORDER BY order_id, product_rank, product_id;


-- ============================================================
-- 3. SECOND-HIGHEST QUANTITY PER ORDER
-- DENSE_RANK is used instead of NTH_VALUE because ties matter here.
-- ============================================================
WITH ranked_products AS (
    SELECT
        order_id,
        product_id,
        units,
        DENSE_RANK() OVER (
            PARTITION BY order_id
            ORDER BY units DESC
        ) AS product_rank
    FROM orders
)
SELECT
    order_id,
    product_id,
    units
FROM ranked_products
WHERE product_rank = 2
ORDER BY order_id, product_id;


-- ============================================================
-- 4. LAG
-- For each customer, compare the total units in each order with the
-- immediately preceding order.
-- ============================================================
WITH order_units AS (
    SELECT
        customer_id,
        order_id,
        MIN(transaction_id) AS first_transaction_id,
        SUM(units) AS total_units
    FROM orders
    GROUP BY customer_id, order_id
),
with_previous AS (
    SELECT
        customer_id,
        order_id,
        total_units,
        LAG(total_units) OVER (
            PARTITION BY customer_id
            ORDER BY first_transaction_id
        ) AS prior_units
    FROM order_units
)
SELECT
    customer_id,
    order_id,
    total_units,
    prior_units,
    total_units - prior_units AS change_in_units
FROM with_previous
ORDER BY customer_id, order_id;


-- ============================================================
-- 5. NTILE
-- Identify the top 1% of customers by total spend.
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
spend_percentile AS (
    SELECT
        customer_id,
        total_spend,
        NTILE(100) OVER (
            ORDER BY total_spend DESC
        ) AS spend_percentile
    FROM customer_spend
)
SELECT
    customer_id,
    ROUND(total_spend, 2) AS total_spend
FROM spend_percentile
WHERE spend_percentile = 1
ORDER BY total_spend DESC;
