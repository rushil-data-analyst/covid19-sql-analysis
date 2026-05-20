-- ================================================
-- PROJECT: COVID-19 Global Data Analysis
-- Author: Rushil Beladiya
-- Date: May 2026
-- Dataset: Worldometer COVID-19 (Kaggle, 226 countries)
-- Tools: SQLite / sqliteonline.com
-- ================================================

-- ---- DATA EXPLORATION ----
-- Preview the dataset
SELECT * FROM worldometer_coronavirus_summary_data LIMIT 5;

-- ---- DATA CLEANING CHECK ----
-- Check NULL values across all columns
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN c1 IS NULL OR c1 = '' THEN 1 ELSE 0 END) AS null_country,
    SUM(CASE WHEN c2 IS NULL OR c2 = '' THEN 1 ELSE 0 END) AS null_continent,
    SUM(CASE WHEN c3 IS NULL OR c3 = '' THEN 1 ELSE 0 END) AS null_confirmed,
    SUM(CASE WHEN c4 IS NULL OR c4 = '' THEN 1 ELSE 0 END) AS null_deaths,
    SUM(CASE WHEN c5 IS NULL OR c5 = '' THEN 1 ELSE 0 END) AS null_recovered,
    SUM(CASE WHEN c6 IS NULL OR c6 = '' THEN 1 ELSE 0 END) AS null_active,
    SUM(CASE WHEN c7 IS NULL OR c7 = '' THEN 1 ELSE 0 END) AS null_serious,
    SUM(CASE WHEN c8 IS NULL OR c8 = '' THEN 1 ELSE 0 END) AS null_cases_per_1m,
    SUM(CASE WHEN c9 IS NULL OR c9 = '' THEN 1 ELSE 0 END) AS null_deaths_per_1m,
    SUM(CASE WHEN c10 IS NULL OR c10 = '' THEN 1 ELSE 0 END) AS null_tests,
    SUM(CASE WHEN c11 IS NULL OR c11 = '' THEN 1 ELSE 0 END) AS null_tests_per_1m,
    SUM(CASE WHEN c12 IS NULL OR c12 = '' THEN 1 ELSE 0 END) AS null_population
FROM worldometer_coronavirus_summary_data
WHERE c1 != 'country';

-- ---- ANALYSIS 1: Top 10 Most Affected Countries ----
SELECT 
    c1 AS country,
    CAST(c3 AS INTEGER) AS total_confirmed,
    CAST(c4 AS REAL) AS total_deaths,
    CAST(c12 AS INTEGER) AS population
FROM worldometer_coronavirus_summary_data
WHERE c1 != 'country'
ORDER BY CAST(c3 AS INTEGER) DESC
LIMIT 10;

-- ---- ANALYSIS 2: Death Rate per Country ----
SELECT 
    c1 AS country,
    CAST(c3 AS INTEGER) AS total_confirmed,
    CAST(c4 AS REAL) AS total_deaths,
    ROUND(CAST(c4 AS REAL) / CAST(c3 AS REAL) * 100, 2) AS death_rate_percent
FROM worldometer_coronavirus_summary_data
WHERE c1 != 'country'
AND c3 != '' AND c3 IS NOT NULL
AND c4 != '' AND c4 IS NOT NULL
ORDER BY death_rate_percent DESC
LIMIT 10;

-- ---- ANALYSIS 3: Total Cases & Deaths by Continent ----
SELECT 
    c2 AS continent,
    SUM(CAST(c3 AS INTEGER)) AS total_cases,
    SUM(CAST(c4 AS REAL)) AS total_deaths,
    ROUND(SUM(CAST(c4 AS REAL)) / 
          SUM(CAST(c3 AS REAL)) * 100, 2) AS death_rate_percent
FROM worldometer_coronavirus_summary_data
WHERE c1 != 'country'
AND c2 != '' AND c2 IS NOT NULL
GROUP BY c2
ORDER BY total_cases DESC;

-- ---- ANALYSIS 4: Countries with Highest Recovery Rate ----
SELECT 
    c1 AS country,
    CAST(c3 AS INTEGER) AS total_confirmed,
    CAST(c5 AS REAL) AS total_recovered,
    ROUND(CAST(c5 AS REAL) / CAST(c3 AS REAL) * 100, 2) AS recovery_rate_percent
FROM worldometer_coronavirus_summary_data
WHERE c1 != 'country'
AND c5 != '' AND c5 IS NOT NULL
AND c3 != '' AND c3 IS NOT NULL
ORDER BY recovery_rate_percent DESC
LIMIT 10;

-- ---- ANALYSIS 5: Continent Testing Rate (CTE) ----
WITH continent_stats AS (
    SELECT 
        c2 AS continent,
        SUM(CAST(c3 AS INTEGER)) AS total_cases,
        SUM(CAST(c4 AS REAL)) AS total_deaths,
        SUM(CAST(c10 AS REAL)) AS total_tests,
        COUNT(c1) AS total_countries
    FROM worldometer_coronavirus_summary_data
    WHERE c1 != 'country'
    AND c2 != '' AND c2 IS NOT NULL
    GROUP BY c2
)
SELECT 
    continent,
    total_countries,
    total_cases,
    total_deaths,
    total_tests,
    ROUND(total_tests * 1.0 / total_cases, 2) AS tests_per_case
FROM continent_stats
ORDER BY tests_per_case DESC;