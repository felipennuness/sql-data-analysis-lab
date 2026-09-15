-- SQL Data Analysis Lab
-- Section 05: Analytical Techniques
-- Database: MySQL / maven_advanced_sql
--
-- Practice implementation based on the course assignment set and reviewed
-- against the provided reference material.

USE maven_advanced_sql;

-- ============================================================
-- 1. DUPLICATE DETECTION / DEDUPLICATION
-- Keep the latest row for each student name according to the highest id.
-- ============================================================
WITH ranked_students AS (
    SELECT
        id,
        student_name,
        email,
        ROW_NUMBER() OVER (
            PARTITION BY student_name
            ORDER BY id DESC
        ) AS row_num
    FROM students
)
SELECT
    id,
    student_name,
    email
FROM ranked_students
WHERE row_num = 1
ORDER BY id;


-- ============================================================
-- 2. MAX-VALUE FILTERING
-- Return each student's highest grade and the class(es) where it occurred.
-- DENSE_RANK preserves ties.
-- ============================================================
WITH ranked_grades AS (
    SELECT
        s.id,
        s.student_name,
        sg.class_name,
        sg.final_grade,
        DENSE_RANK() OVER (
            PARTITION BY s.id
            ORDER BY sg.final_grade DESC
        ) AS grade_rank
    FROM students AS s
    LEFT JOIN student_grades AS sg
        ON s.id = sg.student_id
)
SELECT
    id,
    student_name,
    class_name,
    final_grade
FROM ranked_grades
WHERE grade_rank = 1
ORDER BY id, class_name;


-- ============================================================
-- 3. PIVOT-STYLE ANALYSIS
-- Average final grade by department and grade level.
-- ============================================================
SELECT
    sg.department,
    ROUND(AVG(CASE WHEN s.grade_level = 9  THEN sg.final_grade END)) AS freshman,
    ROUND(AVG(CASE WHEN s.grade_level = 10 THEN sg.final_grade END)) AS sophomore,
    ROUND(AVG(CASE WHEN s.grade_level = 11 THEN sg.final_grade END)) AS junior,
    ROUND(AVG(CASE WHEN s.grade_level = 12 THEN sg.final_grade END)) AS senior
FROM students AS s
LEFT JOIN student_grades AS sg
    ON s.id = sg.student_id
WHERE sg.department IS NOT NULL
GROUP BY sg.department
ORDER BY sg.department;


-- ============================================================
-- 4. ROLLING CALCULATIONS
-- Calculate monthly sales, cumulative sales, and a six-month moving average.
-- ============================================================
WITH monthly_sales AS (
    SELECT
        YEAR(o.order_date) AS year_num,
        MONTH(o.order_date) AS month_num,
        SUM(o.units * p.unit_price) AS total_sales
    FROM orders AS o
    LEFT JOIN products AS p
        ON o.product_id = p.product_id
    GROUP BY YEAR(o.order_date), MONTH(o.order_date)
)
SELECT
    year_num,
    month_num,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        SUM(total_sales) OVER (
            ORDER BY year_num, month_num
        ),
        2
    ) AS cumulative_sales,
    ROUND(
        AVG(total_sales) OVER (
            ORDER BY year_num, month_num
            ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS six_month_moving_average
FROM monthly_sales
ORDER BY year_num, month_num;
