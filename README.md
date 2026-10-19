# SQL Data Engineering Projects

A collection of hands on **SQL and Data Engineering projects** focused on data analysis, ETL, data warehousing, dimensional modeling and data marts.

## Project Overview

This repository covers an end-to-end workflow from **raw job-market data to analytics-ready datasets**, including SQL analysis, ETL pipelines, star schema design, data warehouses, and data marts.

## Table of Contents

- [Lessons](./lessons)
- [Resources](./resources)
- [Projects](./projects)
  - [Project 1: Exploratory Data Analysis](./projects/1_EDA)
  - [Project 2: Data Warehouse & Mart Build](./projects/2_WH_Mart_Build/data-warehouse--mart-build)
  - [Project 3: Flat to Warehouse Build](./projects/3_Flat_to_WH_Build/flat-to-warehouse-build)
- [How to Run](#getting-started)

## Lessons

- SQL fundamentals
- Data exploration
- Joins & aggregations
- CTEs & window functions
- Data cleaning & transformation
- Data modeling
- ETL
- Data warehousing

## Getting Started

Prerequisites

- DuckDB CLI or MotherDuck Account

- SQL client or IDE (VS Code with SQL extensions, DBeaver, etc.)

Running the Queries

Clone the repository:
```text
git clone https://github.com/MuleMED/SQL_Data_Engineering_Project.git
cd SQL_Data_Engineering_Project
```

Navigate into any project folder (e.g., cd 1_EDA) and execute the SQL scripts using DuckDB:

```text
duckdb md:data_jobs.db < 01_top_demanded_skills.sql

```
