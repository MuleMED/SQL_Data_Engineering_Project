-- Joins

SELECT 
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location

FROM job_postings_fact AS jpf
JOIN company_dim AS cd
ON jpf.company_id = cd.company_id;

/*
┌────────┬─────────────────────┬────────────┬────────────────────────┬───────────────────┐
│ job_id │   job_title_short   │ company_id │      company_name      │   job_location    │
│ int32  │       varchar       │   int32    │        varchar         │      varchar      │
├────────┼─────────────────────┼────────────┼────────────────────────┼───────────────────┤
│   4593 │ Data Analyst        │       4593 │ Metasys Technologies   │ New York, NY      │
│   4594 │ Data Analyst        │       4594 │ Guidehouse             │ Washington, DC    │
│   4595 │ Data Analyst        │       4595 │ Protask                │ Fairfax, VA       │
│   4596 │ Senior Data Analyst │       4596 │ Atria Wealth Solutions │ Worcester, MA     │
│   4597 │ Data Analyst        │       4597 │ ICONMA, LLC            │ Sunnyvale, CA     │
│   4598 │ Data Analyst        │       4598 │ Aquent                 │ Torrance, CA      │
│   4599 │ Data Analyst        │       4599 │ Adyen                  │ San Francisco, CA │
│   4600 │ Data Analyst        │       4600 │ Albertsons Companies   │ Pleasanton, CA    │
│   4601 │ Senior Data Analyst │       4601 │ Panda Restaurant Group │ Rosemead, CA      │
│   4602 │ Business Analyst    │       4602 │ Diverse Lynx           │ Thousand Oaks, CA │
└────────┴─────────────────────┴────────────┴────────────────────────┴───────────────────┘
  10 rows                                                                      5 columns */

  
  SELECT 
    jpf.job_id,
    jpf.job_title_short,
    sd.skills,
    jpf.job_location
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
ON sjd.skill_id = sd.skill_id
limit 10;
/*
┌────────┬───────────────────────┬─────────┬────────────────┐
│ job_id │    job_title_short    │ skills  │  job_location  │
│ int32  │        varchar        │ varchar │    varchar     │
├────────┼───────────────────────┼─────────┼────────────────┤
│  68454 │ Senior Data Scientist │ java    │ London, UK     │
│  68454 │ Senior Data Scientist │ c#      │ London, UK     │
│  68454 │ Senior Data Scientist │ scala   │ London, UK     │
│  68455 │ Data Scientist        │ python  │ London, UK     │
│  68456 │ Senior Data Scientist │ python  │ Manchester, UK │
│  68456 │ Senior Data Scientist │ sql     │ Manchester, UK │
│  68457 │ Data Scientist        │ python  │ London, UK     │
│  68457 │ Data Scientist        │ sql     │ London, UK     │
│  68458 │ Data Scientist        │ r       │ Glasgow, UK    │
│  68459 │ Data Scientist        │ python  │ London, UK     │
└────────┴───────────────────────┴─────────┴────────────────┘
  10 rows                                         4 columns  */






