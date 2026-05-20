# covid19-sql-analysis
Real-world COVID-19 global data analysis using SQL — death rates, recovery rates &amp; continent comparisons
# 🦠 COVID-19 Global Data Analysis — SQL

## 📌 Project Overview
Analyzed real-world COVID-19 data from 226 countries to uncover 
death rates, recovery rates, and continent-level comparisons.

## 🎯 Business Questions Answered
- Which countries had the highest number of cases?
- Which countries had the highest death rates?
- Which continent was most severely affected?
- Which countries had the best recovery rates?
- How did testing rates vary across continents?

## 🛠️ Tools Used
- SQL (SQLite)
- sqliteonline.com
- Dataset: Worldometer COVID-19 (Kaggle)

## 📊 Key Findings
- Yemen had the highest death rate at 18.18% due to collapsed healthcare
- South America had the highest continent death rate at 2.27%
- South America only performed 3.87 tests per case — many cases undetected
- Australia/Oceania had the lowest death rate at just 0.14%
- Europe had the most total cases — over 194 million
- Bhutan achieved 99.87% recovery rate

## 🧹 Data Cleaning Performed
- Identified NULL values across all 12 columns
- Used CAST to convert TEXT columns to numeric types
- Filtered header row from imported data
- Handled missing values using WHERE clause filters

## 💡 SQL Concepts Used
- CAST (data type conversion)
- Calculated columns (death rate, recovery rate)
- NULL handling and data cleaning
- GROUP BY with continent aggregations
- CTEs for multi-step analysis
- ROUND for decimal formatting
- Real dataset with 226 countries
