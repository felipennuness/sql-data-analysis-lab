# SQL Data Analysis Lab

![Status](https://img.shields.io/badge/status-in%20progress-orange)
![SQL](https://img.shields.io/badge/SQL-Advanced%20Practice-336791)
![MySQL](https://img.shields.io/badge/MySQL-Analytics-4479A1)
![Analytics](https://img.shields.io/badge/focus-Data%20Analysis-1f4b99)

> Structured SQL practice repository focused on analytical problem solving with MySQL. This portfolio case documents the concepts practiced and will progressively include my own query implementations and analytical case-study work.

## Overview

This repository organizes practical SQL studies from foundational relational analysis through more advanced analytical techniques.

The learning path covers:

1. **Joins & relational analysis**
2. **Subqueries & Common Table Expressions (CTEs)**
3. **Window functions**
4. **Numeric, date, string, pattern-matching, and NULL functions**
5. **Data-quality and analytical techniques**
6. **Final analytical case study**

The goal is not to publish course answer keys. The repository is structured to document the skills practiced and progressively add independently understood and implemented SQL queries.

See [Course & Portfolio Context](COURSE_CONTEXT.md).

## Learning path

### 1. Joins

Topics practiced:

- Basic joins
- LEFT / RIGHT join reasoning
- Identifying unmatched records
- Self joins
- Comparing rows within the same table

[View section →](01-joins/README.md)

### 2. Subqueries & CTEs

Topics practiced:

- Subqueries in `SELECT`
- Subqueries in `FROM`
- Subqueries in `WHERE`
- Common Table Expressions
- Multiple CTEs
- Breaking complex analysis into readable steps

[View section →](02-subqueries-ctes/README.md)

### 3. Window Functions

Topics practiced:

- `ROW_NUMBER()`
- `RANK()` / `DENSE_RANK()`
- First / last / nth-value concepts
- `LEAD()` / `LAG()`
- `NTILE()`
- Partitioning and ordering analytical windows

[View section →](03-window-functions/README.md)

### 4. SQL Functions

Topics practiced:

- Numeric functions
- Datetime functions
- String functions
- Pattern matching
- NULL handling

[View section →](04-sql-functions/README.md)

### 5. Analytical Techniques

Topics practiced:

- Duplicate-value analysis
- Min / max filtering
- Pivot-style analysis with conditional aggregation
- Rolling and cumulative calculations

[View section →](05-analytical-techniques/README.md)

## Final analytical case study

The final project uses a baseball dataset to combine multiple SQL techniques into a broader analytical exercise.

The analysis is organized into four areas:

- **School analysis** — player-producing schools across time and ranking analysis
- **Salary analysis** — team spending, percentiles, cumulative spending, and threshold analysis
- **Player career analysis** — debut/final-game age, career length, and team history
- **Player comparison analysis** — shared birthdays, batting-side distributions, and decade-over-decade physical trends

Techniques used across the case include joins, CTEs, window functions, datetime functions, string aggregation, conditional aggregation, rolling calculations, and ranking.

[View final case-study scope →](final-case-study/README.md)

## Repository structure

```text
.
├── README.md
├── COURSE_CONTEXT.md
├── 01-joins/
│   └── README.md
├── 02-subqueries-ctes/
│   └── README.md
├── 03-window-functions/
│   └── README.md
├── 04-sql-functions/
│   └── README.md
├── 05-analytical-techniques/
│   └── README.md
└── final-case-study/
    └── README.md
```

## Portfolio integrity

The study package used as a reference includes both exercise files and solution files. **Course solution files are intentionally not published in this repository as personal work.**

As this lab evolves, the public SQL files will contain only queries that are reviewed, understood, and documented as part of my own practice.

## Next step

The next milestone is to add SQL implementations section by section, beginning with joins and moving through the final analytical case study.

---

**Portfolio project by Luiz Felipe Nunes — BI Developer | Qlik | SQL | Data Analytics**
