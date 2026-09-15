-- SQL Data Analysis Lab
-- Final Case Study: Baseball Analytics
-- Database: MySQL / maven_advanced_sql
--
-- This is a reviewed practice implementation based on the course final
-- assignment and reference material. The queries are organized as a study
-- case and are not presented as an independently created production dataset.

USE maven_advanced_sql;

-- ============================================================
-- PART I: SCHOOL ANALYSIS
-- ============================================================

-- 1. Number of player-producing schools by decade.
SELECT
    FLOOR(yearID / 10) * 10 AS decade,
    COUNT(DISTINCT schoolID) AS number_of_schools
FROM schools
GROUP BY FLOOR(yearID / 10) * 10
ORDER BY decade;


-- 2. Top five schools by number of distinct players produced.
SELECT
    sd.name_full AS school_name,
    COUNT(DISTINCT s.playerID) AS number_of_players
FROM schools AS s
LEFT JOIN school_details AS sd
    ON s.schoolID = sd.schoolID
GROUP BY s.schoolID, sd.name_full
ORDER BY number_of_players DESC
LIMIT 5;


-- 3. Top three player-producing schools in each decade.
-- DENSE_RANK is used so schools tied at the same player count keep the same rank.
WITH decade_school_counts AS (
    SELECT
        FLOOR(s.yearID / 10) * 10 AS decade,
        s.schoolID,
        sd.name_full AS school_name,
        COUNT(DISTINCT s.playerID) AS number_of_players
    FROM schools AS s
    LEFT JOIN school_details AS sd
        ON s.schoolID = sd.schoolID
    GROUP BY
        FLOOR(s.yearID / 10) * 10,
        s.schoolID,
        sd.name_full
),
ranked_schools AS (
    SELECT
        decade,
        school_name,
        number_of_players,
        DENSE_RANK() OVER (
            PARTITION BY decade
            ORDER BY number_of_players DESC
        ) AS school_rank
    FROM decade_school_counts
)
SELECT
    decade,
    school_name,
    number_of_players,
    school_rank
FROM ranked_schools
WHERE school_rank <= 3
ORDER BY decade DESC, school_rank, school_name;


-- ============================================================
-- PART II: SALARY ANALYSIS
-- ============================================================

-- 1. Top 20% of teams by average annual payroll.
WITH annual_team_spend AS (
    SELECT
        teamID,
        yearID,
        SUM(salary) AS annual_spend
    FROM salaries
    GROUP BY teamID, yearID
),
team_average_spend AS (
    SELECT
        teamID,
        AVG(annual_spend) AS average_annual_spend,
        NTILE(5) OVER (
            ORDER BY AVG(annual_spend) DESC
        ) AS spend_quintile
    FROM annual_team_spend
    GROUP BY teamID
)
SELECT
    teamID,
    ROUND(average_annual_spend / 1000000, 1) AS avg_spend_millions
FROM team_average_spend
WHERE spend_quintile = 1
ORDER BY average_annual_spend DESC;


-- 2. Cumulative team spending by year.
WITH annual_team_spend AS (
    SELECT
        teamID,
        yearID,
        SUM(salary) AS annual_spend
    FROM salaries
    GROUP BY teamID, yearID
)
SELECT
    teamID,
    yearID,
    ROUND(
        SUM(annual_spend) OVER (
            PARTITION BY teamID
            ORDER BY yearID
        ) / 1000000,
        1
    ) AS cumulative_spend_millions
FROM annual_team_spend
ORDER BY teamID, yearID;


-- 3. First year each team exceeded $1B in cumulative payroll.
WITH annual_team_spend AS (
    SELECT
        teamID,
        yearID,
        SUM(salary) AS annual_spend
    FROM salaries
    GROUP BY teamID, yearID
),
cumulative_spend AS (
    SELECT
        teamID,
        yearID,
        SUM(annual_spend) OVER (
            PARTITION BY teamID
            ORDER BY yearID
        ) AS cumulative_spend
    FROM annual_team_spend
),
first_billion AS (
    SELECT
        teamID,
        yearID,
        cumulative_spend,
        ROW_NUMBER() OVER (
            PARTITION BY teamID
            ORDER BY yearID
        ) AS row_num
    FROM cumulative_spend
    WHERE cumulative_spend > 1000000000
)
SELECT
    teamID,
    yearID,
    ROUND(cumulative_spend / 1000000000, 2) AS cumulative_spend_billions
FROM first_billion
WHERE row_num = 1
ORDER BY yearID, teamID;


-- ============================================================
-- PART III: PLAYER CAREER ANALYSIS
-- ============================================================

-- 1. Player age at debut, age at final game, and career length.
SELECT
    nameGiven AS player_name,
    TIMESTAMPDIFF(
        YEAR,
        CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE),
        debut
    ) AS starting_age,
    TIMESTAMPDIFF(
        YEAR,
        CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE),
        finalGame
    ) AS ending_age,
    TIMESTAMPDIFF(YEAR, debut, finalGame) AS career_length_years
FROM players
ORDER BY career_length_years DESC, player_name;


-- 2. Team associated with each player's debut and final seasons.
SELECT DISTINCT
    p.playerID,
    p.nameGiven AS player_name,
    start_salary.yearID AS starting_year,
    start_salary.teamID AS starting_team,
    end_salary.yearID AS ending_year,
    end_salary.teamID AS ending_team
FROM players AS p
INNER JOIN salaries AS start_salary
    ON p.playerID = start_salary.playerID
   AND YEAR(p.debut) = start_salary.yearID
INNER JOIN salaries AS end_salary
    ON p.playerID = end_salary.playerID
   AND YEAR(p.finalGame) = end_salary.yearID
ORDER BY player_name;


-- 3. Count players who started and ended on the same team
-- and whose salary-record career span exceeded ten years.
-- This COUNT is a small portfolio refinement: the reference query lists the
-- qualifying rows, while the assignment wording explicitly asks 'how many'.
WITH career_teams AS (
    SELECT DISTINCT
        p.playerID,
        start_salary.yearID AS starting_year,
        start_salary.teamID AS starting_team,
        end_salary.yearID AS ending_year,
        end_salary.teamID AS ending_team
    FROM players AS p
    INNER JOIN salaries AS start_salary
        ON p.playerID = start_salary.playerID
       AND YEAR(p.debut) = start_salary.yearID
    INNER JOIN salaries AS end_salary
        ON p.playerID = end_salary.playerID
       AND YEAR(p.finalGame) = end_salary.yearID
)
SELECT
    COUNT(DISTINCT playerID) AS long_career_same_team_players
FROM career_teams
WHERE starting_team = ending_team
  AND ending_year - starting_year > 10;


-- ============================================================
-- PART IV: PLAYER COMPARISON ANALYSIS
-- ============================================================

-- 1. Players sharing the same birthday between 1980 and 1990.
-- HAVING COUNT(*) > 1 is added to align the result with the question.
WITH player_birthdays AS (
    SELECT
        CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE) AS birthdate,
        nameGiven AS player_name
    FROM players
)
SELECT
    birthdate,
    GROUP_CONCAT(player_name ORDER BY player_name SEPARATOR ', ') AS players,
    COUNT(*) AS players_with_birthday
FROM player_birthdays
WHERE YEAR(birthdate) BETWEEN 1980 AND 1990
GROUP BY birthdate
HAVING COUNT(*) > 1
ORDER BY birthdate;


-- 2. Batting-side distribution by team.
-- Unique player/team combinations are created first so multi-year salary rows
-- do not inflate the denominator.
WITH unique_team_players AS (
    SELECT DISTINCT
        s.teamID,
        s.playerID,
        p.bats
    FROM salaries AS s
    LEFT JOIN players AS p
        ON s.playerID = p.playerID
)
SELECT
    teamID,
    ROUND(SUM(CASE WHEN bats = 'R' THEN 1 ELSE 0 END) / COUNT(playerID) * 100, 1) AS bats_right_pct,
    ROUND(SUM(CASE WHEN bats = 'L' THEN 1 ELSE 0 END) / COUNT(playerID) * 100, 1) AS bats_left_pct,
    ROUND(SUM(CASE WHEN bats = 'B' THEN 1 ELSE 0 END) / COUNT(playerID) * 100, 1) AS bats_both_pct
FROM unique_team_players
GROUP BY teamID
ORDER BY teamID;


-- 3. Decade-over-decade change in average player height and weight at debut.
WITH decade_measurements AS (
    SELECT
        FLOOR(YEAR(debut) / 10) * 10 AS decade,
        AVG(height) AS avg_height,
        AVG(weight) AS avg_weight
    FROM players
    WHERE debut IS NOT NULL
    GROUP BY FLOOR(YEAR(debut) / 10) * 10
)
SELECT
    decade,
    ROUND(avg_height, 2) AS avg_height,
    ROUND(avg_weight, 2) AS avg_weight,
    ROUND(avg_height - LAG(avg_height) OVER (ORDER BY decade), 2) AS height_change,
    ROUND(avg_weight - LAG(avg_weight) OVER (ORDER BY decade), 2) AS weight_change
FROM decade_measurements
ORDER BY decade;
