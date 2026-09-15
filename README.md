# SQL Data Analysis Lab

![Status](https://img.shields.io/badge/status-in%20progress-orange)
![SQL](https://img.shields.io/badge/SQL-Analytical%20Practice-336791)
![MySQL](https://img.shields.io/badge/MySQL-Analytics-4479A1)
![Analytics](https://img.shields.io/badge/focus-Data%20Analysis-1f4b99)

> Structured MySQL practice repository covering relational analysis, CTEs, window functions, data transformation, data-quality patterns, rolling calculations, and a final analytical case study.

## Overview

This repository organizes practical SQL studies from relational analysis through more advanced analytical techniques.

The public SQL files are **reviewed practice implementations based on the course exercise set and reference material**. They are published as study work, not as original production or client code.

The learning path covers:

1. **Joins & relational analysis**
2. **Subqueries & Common Table Expressions (CTEs)**
3. **Window functions**
4. **Numeric, date, string, pattern-matching, and NULL functions**
5. **Data-quality and analytical techniques**
6. **Final analytical case study**

See [Course & Portfolio Context](COURSE_CONTEXT.md).

## Learning path

### 1. Joins

Practice includes unmatched-record analysis and self joins for comparing rows from the same table.

**Topics:** `LEFT JOIN`, relational validation, unmatched records, self joins, pairwise comparisons.

[View notes →](01-joins/README.md)  
[View SQL →](01-joins/joins.sql)

### 2. Subqueries & CTEs

Practice includes scalar subqueries, derived tables, filters based on dynamic reference values, single CTEs, and multiple CTEs.

**Topics:** subqueries in `SELECT`, `FROM`, `WHERE`, `WITH`, multiple CTEs, readable multi-step analysis.

[View notes →](02-subqueries-ctes/README.md)  
[View SQL →](02-subqueries-ctes/subqueries_ctes.sql)

### 3. Window Functions

Practice includes transaction sequencing, ranking with ties, previous-row comparison, and percentile-style segmentation.

**Topics:** `ROW_NUMBER()`, `DENSE_RANK()`, `LAG()`, `NTILE()`, `PARTITION BY`, analytical ordering.

[View notes →](03-window-functions/README.md)  
[View SQL →](03-window-functions/window_functions.sql)

### 4. SQL Functions

Practice includes value transformation and standardization directly in SQL.

**Topics:** numeric functions, datetime functions, string manipulation, pattern handling, `COALESCE()`, ranking-assisted NULL replacement.

[View notes →](04-sql-functions/README.md)  
[View SQL →](04-sql-functions/sql_functions.sql)

### 5. Analytical Techniques

Practice combines SQL features into common data-quality and analytical patterns.

**Topics:** deduplication, max-value filtering, conditional aggregation, pivot-style summaries, cumulative totals, moving averages.

[View notes →](05-analytical-techniques/README.md)  
[View SQL →](05-analytical-techniques/analytical_techniques.sql)

## Final analytical case study

The final project uses a baseball dataset to combine multiple SQL techniques into a broader analytical exercise.

The analysis is organized into four areas:

- **School analysis** — player-producing schools across time and ranking analysis
- **Salary analysis** — team spending, percentiles, cumulative spending, and threshold analysis
- **Player career analysis** — debut/final-game age, career length, and team history
- **Player comparison analysis** — shared birthdays, batting-side distributions, and decade-over-decade physical trends

The reviewed implementation includes joins, CTEs, window functions, datetime functions, string aggregation, conditional aggregation, rolling calculations, ranking, and tie-aware analysis.

[View case-study notes →](final-case-study/README.md)  
[View SQL →](final-case-study/baseball_analysis.sql)

## Repository structure

```text
.
├── README.md
├── COURSE_CONTEXT.md
├── 01-joins/
│   ├── README.md
│   └── joins.sql
├── 02-subqueries-ctes/
│   ├── README.md
│   └── subqueries_ctes.sql
├── 03-window-functions/
│   ├── README.md
│   └── window_functions.sql
├── 04-sql-functions/
│   ├── README.md
│   └── sql_functions.sql
├── 05-analytical-techniques/
│   ├── README.md
│   └── analytical_techniques.sql
└── final-case-study/
    ├── README.md
    └── baseball_analysis.sql
```

## Portfolio integrity

The original study package contains both exercise files and instructor/reference solution files.

This repository does **not** publish those solution files verbatim as original personal work. Instead, it contains curated practice implementations organized, reviewed, simplified, and documented for learning purposes. Where the reference material itself identifies an inaccurate or weaker approach, the public version uses the corrected/tie-aware alternative.

The final case also includes a small number of clearly commented refinements where the implementation was aligned more closely with the wording of the analytical question.

## Current status

The first reviewed implementation is now available across all five study sections and the final case study. Future updates can add query-result screenshots, additional exercises, and independently designed SQL business cases.

---

**Portfolio project by Luiz Felipe Nunes — BI Developer | Qlik | SQL | Data Analytics**
