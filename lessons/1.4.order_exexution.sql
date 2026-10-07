/*
Fnd the top 10 companies with the most job postings. 
They must be >3000 postings.
Limit to the US only.
*/

SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS job_postings_count
FROM job_postings_fact AS jpf
JOIN company_dim AS cd
ON jpf.company_id = cd.company_id
WHERE jpf.job_country LIKE '%United States%'
GROUP BY cd.company_id, cd.name
HAVING COUNT(jpf.job_id) > 3000
ORDER BY job_postings_count DESC
LIMIT 10;
/*
┌─────────────────────┬────────────────────┐
│    company_name     │ job_postings_count │
│       varchar       │       int64        │
├─────────────────────┼────────────────────┤
│ beBee Careers       │              10507 │
│ Capital One         │               5765 │
│ Dice                │               5491 │
│ Booz Allen Hamilton │               4156 │
│ Insight Global      │               3757 │
│ Walmart             │               3391 │
│ Jobs via Dice       │               3312 │
│ SynergisticIT       │               3258 │
└─────────────────────┴────────────────────┘ */