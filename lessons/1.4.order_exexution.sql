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

EXPLAIN ANALYZE
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
┌─────────────────────────────────────┐
│┌───────────────────────────────────┐│
││    Query Profiling Information    ││
│└───────────────────────────────────┘│
└─────────────────────────────────────┘
EXPLAIN ANALYZE SELECT     cd.name AS company_name,     COUNT(jpf.job_id) AS job_postings_count FROM job_postings_fact AS jpf JOIN company_dim AS cd ON jpf.company_id = cd.company_id WHERE jpf.job_country LIKE '%United States%' GROUP BY cd.company_id, cd.name HAVING COUNT(jpf.job_id) > 3000 ORDER BY job_postings_count DESC LIMIT 10;
┌────────────────────────────────────────────────┐
│┌──────────────────────────────────────────────┐│
││              Total Time: 0.376s              ││
│└──────────────────────────────────────────────┘│
└────────────────────────────────────────────────┘
┌───────────────────────────┐
│           QUERY           │
└─────────────┬─────────────┘
┌─────────────┴─────────────┐
│         EXTENSION         │
│    ────────────────────   │
│          md_type:         │
│   HYBRID_STATS_COLLECTOR  │
│                           │
│                           │
│                           │
│           0 rows          │
│           0.00s           │
└─────────────┬─────────────┘
┌─────────────┴─────────────┐
│      EXPLAIN_ANALYZE      │
│    ────────────────────   │
│                           │
│           0 rows          │
│           0.00s           │
└─────────────┬─────────────┘
┌─────────────┴─────────────┐
│         EXTENSION         │
│    ────────────────────   │
│          md_type:         │
│       HYBRID_RUNNER       │
│                           │
│                           │
│                           │
│           0 rows          │
│           0.00s           │
└─────────────┬─────────────┘
┌─────────────┴─────────────┐
│         EXTENSION         │
│    ────────────────────   │
│          md_type:         │
│      DOWNLOAD_SOURCE      │
│                           │
│        bridge_id: 1       │
│                           │
│                           │
│                           │
│           8 rows          │
│           0.00s           │
└─────────────┬─────────────┘
┌─────────────┴─────────────┐
│         EXTENSION         │
│    ────────────────────   │
│          md_type:         │
│    BATCH_DOWNLOAD_SINK    │
│                           │
│        bridge_id: 1       │
│       parallel: true      │
│                           │
│                           │
│                           │
│           0 rows          │
│           0.00s           │
└─────────────┬─────────────┘
┌─────────────┴─────────────┐
│           TOP_N           │
│    ────────────────────   │
│          Top: 10          │
│                           │
│         Order By:         │
│   count(jpf.job_id) DESC  │
│                           │
│                           │
│                           │
│           8 rows          │
│           0.00s           │
└─────────────┬─────────────┘
┌─────────────┴─────────────┐
│         PROJECTION        │
│    ────────────────────   │
│             #1            │
│             #2            │
│                           │
│                           │
│                           │
│           8 rows          │
│           0.00s           │
└─────────────┬─────────────┘
┌─────────────┴─────────────┐
│           FILTER          │
│    ────────────────────   │
│   (count(job_id) > 3000)  │
│                           │
│                           │
│                           │
│           8 rows          │
│           0.00s           │
└─────────────┬─────────────┘
┌─────────────┴─────────────┐
│       HASH_GROUP_BY       │
│    ────────────────────   │
│          Groups:          │
│             #0            │
│             #1            │
│                           │
│   Aggregates: count(#2)   │
│                           │
│                           │
│                           │
│        57,752 rows        │
│           0.03s           │
└─────────────┬─────────────┘
┌─────────────┴─────────────┐
│         PROJECTION        │
│    ────────────────────   │
│         company_id        │
│            name           │
│           job_id          │
│                           │
│                           │
│                           │
│        464,483 rows       │
│           0.00s           │
└─────────────┬─────────────┘
┌─────────────┴─────────────┐
│         HASH_JOIN         │
│    ────────────────────   │
│      Join Type: INNER     │
│                           │
│        Conditions:        │
│  company_id = company_id  ├──────────────┐
│                           │              │
│                           │              │
│                           │              │
│        464,483 rows       │              │
│           0.06s           │              │
└─────────────┬─────────────┘              │
┌─────────────┴─────────────┐┌─────────────┴─────────────┐
│         TABLE_SCAN        ││         TABLE_SCAN        │
│    ────────────────────   ││    ────────────────────   │
│           Table:          ││           Table:          │
│ data_jobs.main.company_dim││       data_jobs.main      │
│                           ││     .job_postings_fact    │
│   Type: Sequential Scan   ││                           │
│                           ││   Type: Sequential Scan   │
│        Projections:       ││                           │
│         company_id        ││        Projections:       │
│            name           ││         company_id        │
│                           ││           job_id          │
│      Dynamic Filters:     ││                           │
│ optional: company_id>=4593││          Filters:         │
│  AND optional: company_id<││   contains(job_country,   │
│          =1620479         ││      'United States')     │
│                           ││                           │
│                           ││                           │
│                           ││                           │
│        215,940 rows       ││        464,483 rows       │
│           0.05s           ││           0.21s           │
└───────────────────────────┘└───────────────────────────┘ */