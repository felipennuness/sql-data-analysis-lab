# 03 — Window Functions

## Scope

This section focuses on analytical calculations that preserve row-level detail while adding sequencing, ranking, comparisons, and distribution metrics.

## Concepts practiced

- `ROW_NUMBER()`
- `DENSE_RANK()`
- Tie-aware ranking
- `LAG()`
- `NTILE()`
- `PARTITION BY`
- Window ordering

## Practice questions

The reviewed SQL file includes examples such as:

- Numbering customer transactions in sequence
- Ranking products within each order while preserving ties
- Returning the second-highest quantity level in each order
- Comparing each customer order with the previous order
- Identifying the top 1% of customers by total spend

## Implementation note

The course reference material explicitly notes that an `NTH_VALUE()` approach for the second-most-popular product can be inaccurate when ties exist. The public practice file therefore uses the `DENSE_RANK()` alternative.

## SQL

[View `window_functions.sql`](window_functions.sql)

The file is published as reviewed course-based practice, not as original production code.
