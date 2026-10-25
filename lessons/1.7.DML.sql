-- .read lessons/1.7.DML.sql

-- CTA
CREATE OR REPLACE TABLE staging.job_postings_flat AS
SELECT 
jpf.job_id,
jpf.job_title_short,
jpf.job_title,
jpf.job_location,
jpf.job_via,
jpf.job_posted_date,
jpf.job_no_degree_mention,
jpf.job_country,
jpf.salary_rate,
jpf.salary_year_avg,
jpf.salary_hour_avg,
cd.name AS company_name

FROM data_jobs.job_postings_fact AS jpf
JOIN data_jobs.company_dim AS cd
ON jpf.company_id = cd.company_id;

SELECT
    COUNT(*) AS total_jobs
    FROM staging.job_postings_flat;

SELECT
     *
    FROM staging.job_postings_flat
    LIMIT 10;

-- VIEW
CREATE OR REPLACE VIEW staging.priority_jobs_flat_view AS
SELECT jpf.*
FROM staging.job_postings_flat as jpf
JOIN staging.priority_roles as pr 
ON jpf.job_title_short = pr.role_name
WHERE pr.priority_lvl = 1;

SELECT *
FROM staging.priority_jobs_flat_view
LIMIT 10;

SELECT COUNT(*) AS View_priority_jobs_flat_Total
FROM staging.priority_jobs_flat_view;

SELECT 
job_title_short,
COUNT(*) total_demand
FROM staging.priority_jobs_flat_view
GROUP BY job_title_short
ORDER BY COUNT(*) DESC;

-- Temporary Table
CREATE OR REPLACE TEMPORARY TABLE priority_jobs_flat_view_temp AS
SELECT
*
FROM staging.priority_jobs_flat_view
WHERE job_title_short = 'Software Engineer';

SELECT COUNT(*) AS Temporary_priority_jobs_flat_view_Table
FROM priority_jobs_flat_view_temp;

TRUNCATE TABLE staging.job_postings_flat;

INSERT INTO staging.job_postings_flat
SELECT 
jpf.job_id,
jpf.job_title_short,
jpf.job_title,
jpf.job_location,
jpf.job_via,
jpf.job_posted_date,
jpf.job_no_degree_mention,
jpf.job_country,
jpf.salary_rate,
jpf.salary_year_avg,
jpf.salary_hour_avg,
cd.name AS company_name

FROM data_jobs.job_postings_fact AS jpf
JOIN data_jobs.company_dim AS cd
ON jpf.company_id = cd.company_id
WHERE jpf.job_posted_date >= '2024-01-01';

FROM data_jobs.job_postings_fact AS jpf
JOIN data_jobs.company_dim AS cd
ON jpf.company_id = cd.company_id;

SELECT
    COUNT(*) AS total_jobs
    FROM staging.job_postings_flat;

SELECT
     *
    FROM staging.job_postings_flat
    LIMIT 10;
