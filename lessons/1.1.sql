select 4*2 as result;
/*
┌────────┐
│ result │
│ int32  │
├────────┤
│      8 │
└────────┘
*/

-- Working with the Jobs Dataset

SELECT
    *
FROM 
    job_postings_fact  -- Navigate to the job_postings_fact table in the database
LIMIT 10;


-- DISTINCT 
SELECT DISTINCT 
job_title_short
FROM job_postings_fact;

/*
┌───────────────────────────┐
│      job_title_short      │
│          varchar          │
├───────────────────────────┤
│ Senior Data Analyst       │
│ Machine Learning Engineer │
│ Cloud Engineer            │
│ Data Analyst              │
│ Software Engineer         │
│ Senior Data Engineer      │
│ Data Engineer             │
│ Senior Data Scientist     │
│ Business Analyst          │
│ Data Scientist            │
└───────────────────────────┘
           10 rows  
*/

-- single comment
/* Multiple comments
SELECT 
    count(column_name) FILTER (WHERE column_name IS NOT NULL) AS not_null_count,
    count(column_name) FILTER (WHERE column_name IS NULL) AS null_count
FROM table_name;
*/

SELECT 
COUNT(*) FILTER (WHERE job_work_from_home = FALSE ) AS no_remote_jobs,
COUNT(*) FILTER (WHERE job_work_from_home = TRUE ) AS remote_jobs
FROM job_postings_fact;
/*
┌────────────────┬─────────────┐
│ no_remote_jobs │ remote_jobs │
│     int64      │    int64    │
├────────────────┼─────────────┤
│        1471398 │      144532 │
└────────────────┴─────────────┘
*/


--- Where => to filter specific items

SELECT 
  job_title_short,
  job_location,
  salary_year_avg
FROM 
  job_postings_fact
WHERE 
  salary_year_avg = 100000
LIMIT 10;
/*
┌─────────────────────┬────────────────┬─────────────────┐
│   job_title_short   │  job_location  │ salary_year_avg │
│       varchar       │    varchar     │     double      │
├─────────────────────┼────────────────┼─────────────────┤
│ Data Analyst        │ Milwaukee, WI  │        100000.0 │
│ Data Analyst        │ Chicago, IL    │        100000.0 │
│ Data Scientist      │ United States  │        100000.0 │
│ Data Scientist      │ Anywhere       │        100000.0 │
│ Senior Data Analyst │ Anywhere       │        100000.0 │
│ Data Analyst        │ Milwaukee, WI  │        100000.0 │
│ Data Analyst        │ Sunnyvale, CA  │        100000.0 │
│ Data Analyst        │ Long Beach, CA │        100000.0 │
│ Business Analyst    │ Miami, FL      │        100000.0 │
│ Data Analyst        │ United States  │        100000.0 │
└─────────────────────┴────────────────┴─────────────────┘
  10 rows    */