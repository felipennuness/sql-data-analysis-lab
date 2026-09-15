# Final Case Study — Baseball Data Analysis

## Overview

The final SQL project combines the techniques practiced throughout the lab in a broader analytical case based on baseball data.

The reviewed implementation is organized around schools, team salaries, player careers, and player characteristics.

## Part I — School Analysis

Questions covered:

- How many player-producing schools existed in each decade?
- Which schools produced the most distinct players?
- Which schools ranked in the top three within each decade?

Main techniques:

- Numeric functions
- Joins
- Aggregation
- CTEs
- `DENSE_RANK()`

## Part II — Salary Analysis

Questions covered:

- Which teams fall in the top 20% for average annual spending?
- How does cumulative team spending evolve over time?
- In which year did each team first exceed $1B in cumulative payroll?

Main techniques:

- Aggregation
- `NTILE()`
- Window functions
- Cumulative calculations
- CTEs
- Threshold filtering

## Part III — Player Career Analysis

Questions covered:

- What were players' ages at debut and final game?
- How long did each career last?
- Which teams correspond to starting and ending seasons?
- How many long-career players started and ended with the same team?

Main techniques:

- Datetime functions
- Joins
- Derived metrics
- CTEs
- Conditional filtering

## Part IV — Player Comparison Analysis

Questions covered:

- Which players share a birthday?
- What percentage of players on each team bat right, left, or both?
- How did average player height and weight change by decade?

Main techniques:

- `GROUP_CONCAT()`
- Deduplication before aggregation
- Conditional aggregation
- Pivot-style summaries
- `LAG()`
- Window functions

## Review notes

The implementation is based on the course assignment and reference solution set rather than being presented as an independently designed production project.

Two small refinements are explicitly documented in the SQL file:

- the same-team / long-career question returns an actual count because the assignment asks "how many";
- the shared-birthday query filters to birthdays with more than one player so the output matches the wording of the analytical question.

The decade school ranking also uses the tie-aware `DENSE_RANK()` alternative mentioned in the reference notes.

## SQL

[View `baseball_analysis.sql`](baseball_analysis.sql)
