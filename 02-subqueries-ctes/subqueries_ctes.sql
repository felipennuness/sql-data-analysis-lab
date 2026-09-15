-- SQL Data Analysis Lab
-- Section 02: Subqueries & CTEs
-- Database: MySQL / maven_advanced_sql
--
-- Practice implementation based on the course assignment set and reviewed
-- against the provided reference material.

USE maven_advanced_sql;

-- ============================================================
-- 1. SUBQUERY IN SELECT
-- Compare each product price with the overall average unit price.
-- ============================================================
SELECT
    product_id,
    product_name,
    unit_price,
    (SELECT AVG(unit_price) FROM products) AS avg_unit_price,
    ROUND(unit_price - (SELECT AVG(unit_price) FROM products), 2) AS diff_from_average
FROM products
ORDER BY unit_price DESC;


-- ============================================================
-- 2. SUBQUERY IN FROM
-- Show every product together with the number of products produced
-- by its factory.
-- ============================================================
SELECT
    product_list.factory,
    product_list.product_name,
    factory_counts.num_products
FROM (
    SELECT
        factory,
        product_name
    FROM products
) AS product_list
LEFT JOIN (
    SELECT
        factory,
        COUNT(product_id) AS num_products
    FROM products
    GROUP BY factory
) AS factory_counts
    ON product_list.factory = factory_counts.factory
ORDER BY product_list.factory, product_list.product_name;


-- ============================================================
-- 3. SUBQUERY IN WHERE
-- Return products cheaper than every product made by Wicked Choccy's.
-- ============================================================
SELECT
    product_id,
    product_name,
    factory,
    unit_price
FROM products
WHERE unit_price < ALL (
    SELECT unit_price
    FROM products
    WHERE factory = 'Wicked Choccy''s'
)
ORDER BY unit_price;


-- ============================================================
-- 4. CTE
-- Count how many orders exceeded $200 in total value.
-- ============================================================
WITH order_totals AS (
    SELECT
        o.order_id,
        SUM(o.units * p.unit_price) AS total_amount_spent
    FROM orders AS o
    LEFT JOIN products AS p
        ON o.product_id = p.product_id
    GROUP BY o.order_id
    HAVING SUM(o.units * p.unit_price) > 200
)
SELECT
    COUNT(*) AS orders_over_200
FROM order_totals;


-- ============================================================
-- 5. MULTIPLE CTEs
-- Rewrite the factory/product-count analysis using named CTEs.
-- ============================================================
WITH product_list AS (
    SELECT
        factory,
        product_name
    FROM products
),
factory_counts AS (
    SELECT
        factory,
        COUNT(product_id) AS num_products
    FROM products
    GROUP BY factory
)
SELECT
    product_list.factory,
    product_list.product_name,
    factory_counts.num_products
FROM product_list
LEFT JOIN factory_counts
    ON product_list.factory = factory_counts.factory
ORDER BY product_list.factory, product_list.product_name;
