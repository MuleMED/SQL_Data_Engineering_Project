-- Subquery

SELECT *
FROM (SELECT
    job_title_short,
    COUNT(*) AS total_demand
    FROM job_postings_fact
    GROUP BY job_title_short
    ORDER BY COUNT(*) DESC) AS subquery
WHERE total_demand > 100000;
--limit 10;


-- CTEs

WITH job_demand AS (
    SELECT
        job_title_short,
        COUNT(*) AS total_demand
    FROM job_postings_fact
    GROUP BY job_title_short
    ORDER BY COUNT(*) DESC
)
SELECT *
FROM job_demand
WHERE total_demand > 100000;

--  Scenario 1 – Subquery in `SELECT`
-- Show each job’s salary next to the overall market median:
SELECT 
    job_title_short,
    salary_year_avg,
    (SELECT
     median(salary_year_avg) 
     FROM job_postings_fact) AS overall_median_salary
FROM job_postings_fact;


-- Scenario 2 – Subquery in FROM
-- Stage only jobs that are remote before aggregating to determine the remote median salary per job
SELECT 
    job_title_short,
    median(salary_year_avg) AS median_salary,
    (SELECT
     median(salary_year_avg) 
     FROM job_postings_fact
     WHERE job_work_from_home = TRUE) AS overall_median_salary
FROM (
  SELECT
    job_title_short,
    salary_year_avg
  FROM job_postings_fact
  WHERE job_work_from_home = TRUE
) AS clean_jobs
GROUP BY job_title_short;

-- Scenario 3 – Subquery in HAVING
-- Keep only job titles whose median salary is above the overall median:
SELECT
  job_title_short,
  MEDIAN(salary_year_avg) AS median_salary,
  (
    SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
  ) AS overall_median_salary
FROM (
  SELECT
    job_title_short,
    salary_year_avg
  FROM job_postings_fact
  WHERE job_work_from_home = TRUE
) AS clean_jobs
GROUP BY job_title_short
HAVING median_salary > overall_median_salary;

-- CTE Example
-- Compare how much more (or less) remote roles pay compared to onsite roles for each job title.
-- Use a CTE to calculate the median salary by title and work arrangement, then compare those medians.

WITH median_salaries AS (
  SELECT
    job_title_short,
    job_work_from_home,
    MEDIAN(salary_year_avg) AS median_salary
  FROM job_postings_fact
  GROUP BY job_title_short, job_work_from_home
)
SELECT
  remote.job_title_short,
  remote.median_salary AS remote_median_salary,
  onsite.median_salary AS onsite_median_salary,
  remote.median_salary - onsite.median_salary AS salary_difference
FROM median_salaries AS remote
JOIN median_salaries AS onsite
  ON remote.job_title_short = onsite.job_title_short
  AND remote.job_work_from_home = TRUE
  AND onsite.job_work_from_home = FALSE
ORDER BY salary_difference DESC;
