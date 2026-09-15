-- SQL Data Analysis Lab
-- Section 01: Joins
-- Database: MySQL / maven_advanced_sql
--
-- Practice implementation based on the course assignment set and reviewed
-- against the provided reference material. Published as study work, not as
-- an original production project.

USE maven_advanced_sql;

-- ============================================================
-- 1. BASIC JOINS
-- Business question:
-- Which products exist in the products table but have never appeared
-- in the orders table?
-- ============================================================

SELECT
    p.product_id,
    p.product_name
FROM products AS p
LEFT JOIN orders AS o
    ON p.product_id = o.product_id
WHERE o.product_id IS NULL
ORDER BY p.product_id;


-- Reverse check:
-- Find order rows whose product_id has no corresponding product record.
SELECT
    o.order_id,
    o.product_id
FROM orders AS o
LEFT JOIN products AS p
    ON o.product_id = p.product_id
WHERE p.product_id IS NULL;


-- ============================================================
-- 2. SELF JOIN
-- Business question:
-- Which different products are priced within $0.25 of each other?
-- ============================================================

SELECT
    p1.product_name AS product_1,
    p1.unit_price   AS price_1,
    p2.product_name AS product_2,
    p2.unit_price   AS price_2,
    ROUND(ABS(p1.unit_price - p2.unit_price), 2) AS price_difference
FROM products AS p1
INNER JOIN products AS p2
    ON p1.product_id <> p2.product_id
WHERE ABS(p1.unit_price - p2.unit_price) < 0.25
  -- Prevent mirrored duplicates such as A/B and B/A.
  AND p1.product_name < p2.product_name
ORDER BY price_difference, product_1, product_2;
