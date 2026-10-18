/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 1) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    --ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((LN(COUNT(jpf.*)) * MEDIAN(jpf.salary_year_avg))/1000000, 2) AS optimal_score
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.salary_year_avg IS NOT NULL
    AND jpf.job_work_from_home = True 
GROUP BY
    sd.skills
HAVING 
    COUNT(sjd.job_id) >= 100
ORDER BY
    optimal_score DESC
LIMIT 20;

/*
Key Takeaways   
The key insights from the data are:
- Highest optimal score: Terraform — 0.97.
- Strong optimal score and frequency: Python (0.95; 1,133 occurrences)
- Highest frequency: SQL — 1,128 occurrences, with a 0.91 optimal score.
- Practical takeaway: Terraform, Python, SQL, AWS and Airflow are worth investigating because they combine competitive salaries with meaningful demand.

┌────────────┬───────────────┬──────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ optimal_score │
│  varchar   │    double     │    int64     │    double     │
├────────────┼───────────────┼──────────────┼───────────────┤
│ terraform  │      184000.0 │          193 │          0.97 │
│ python     │      135000.0 │         1133 │          0.95 │
│ sql        │      130000.0 │         1128 │          0.91 │
│ aws        │      137320.3 │          783 │          0.91 │
│ airflow    │      150000.0 │          386 │          0.89 │
│ spark      │      140000.0 │          503 │          0.87 │
│ snowflake  │      135500.0 │          438 │          0.82 │
│ kafka      │      145000.0 │          292 │          0.82 │
│ azure      │      128000.0 │          475 │          0.79 │
│ java       │      135000.0 │          303 │          0.77 │
│ scala      │      137290.5 │          247 │          0.76 │
│ git        │      140000.0 │          208 │          0.75 │
│ kubernetes │      150500.0 │          147 │          0.75 │
│ databricks │      132750.0 │          266 │          0.74 │
│ redshift   │      130000.0 │          274 │          0.73 │
│ gcp        │      136000.0 │          196 │          0.72 │
│ nosql      │      134415.0 │          193 │          0.71 │
│ hadoop     │      135000.0 │          198 │          0.71 │
│ pyspark    │      140000.0 │          152 │           0.7 │
│ mongodb    │      135750.0 │          136 │          0.67 │
└────────────┴───────────────┴──────────────┴───────────────┘
  20 rows                                         4 columns
  */