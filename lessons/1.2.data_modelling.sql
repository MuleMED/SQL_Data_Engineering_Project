-- Inspecting the database tables and relationships

SELECT * 
FROM information_schema.tables 
WHERE table_schema = 'main';
/*┌───────────────────────┬──────────────┬──────────────────────┬───┬──────────┬───────────────┬───────────────┐
│     table_catalog     │ table_schema │      table_name      │ … │ is_typed │ commit_action │ TABLE_COMMENT │
│        varchar        │   varchar    │       varchar        │ … │ varchar  │    varchar    │    varchar    │
├───────────────────────┼──────────────┼──────────────────────┼───┼──────────┼───────────────┼───────────────┤
│ data_jobs             │ main         │ skills_dim           │ … │ NO       │ NULL          │ NULL          │
│ data_jobs             │ main         │ job_postings_fact    │ … │ NO       │ NULL          │ NULL          │
│ data_jobs             │ main         │ skills_job_dim       │ … │ NO       │ NULL          │ NULL          │
│ data_jobs             │ main         │ company_dim          │ … │ NO       │ NULL          │ NULL          │
│ md_information_schema │ main         │ databases            │ … │ NO       │ NULL          │ NULL          │
│ md_information_schema │ main         │ database_snapshots   │ … │ NO       │ NULL          │ NULL          │
│ md_information_schema │ main         │ owned_shares         │ … │ NO       │ NULL          │ NULL          │
│ md_information_schema │ main         │ query_history        │ … │ NO       │ NULL          │ NULL          │
│ md_information_schema │ main         │ recent_queries       │ … │ NO       │ NULL          │ NULL          │
│ md_information_schema │ main         │ roles                │ … │ NO       │ NULL          │ NULL          │
│ md_information_schema │ main         │ shared_with_me       │ … │ NO       │ NULL          │ NULL          │
│ md_information_schema │ main         │ storage_info         │ … │ NO       │ NULL          │ NULL          │
│ md_information_schema │ main         │ storage_info_history │ … │ NO       │ NULL          │ NULL          │
└───────────────────────┴──────────────┴──────────────────────┴───┴──────────┴───────────────┴───────────────┘
  13 rows                        use .last to show entire result                        13 columns (6 shown) */

-- Viewing each table sample data
SELECT *
FROM skills_dim
LIMIT 10;
/*
skill_id │   skills   │    type     │
│  int32   │  varchar   │   varchar   │
├──────────┼────────────┼─────────────┤
│        0 │ sql        │ programming │
│        1 │ python     │ programming │
│        2 │ r          │ programming │
│        3 │ go         │ programming │
│        4 │ matlab     │ programming │
│        5 │ crystal    │ programming │
│        6 │ javascript │ programming │
│        7 │ scala      │ programming │
│        8 │ sas        │ programming │
│        9 │ nosql      │ programming │
└──────────┴────────────┴─────────────┘ */

SELECT *
FROM company_dim
LIMIT 10;
/*
┌────────────┬────────────────────────┬─────────────────────────┬────────────────────────┬─────────────────────────┐
│ company_id │          name          │          link           │      link_google       │        thumbnail        │
│   int32    │        varchar         │         varchar         │        varchar         │         varchar         │
├────────────┼────────────────────────┼─────────────────────────┼────────────────────────┼─────────────────────────┤
│       4593 │ Metasys Technologies   │ NULL                    │ https://www.google.com │ NULL                    │
│            │                        │                         │ /search?gl=us&hl=en&q= │                         │
│            │                        │                         │ Metasys+Technologies&s │                         │
│            │                        │                         │ a=X&ved=0ahUKEwjNqO7e2 │                         │
│            │                        │                         │ KX8AhWJpXIEHTxXDe04ChC │                         │
│            │                        │                         │ YkAII7wo               │                         │
├────────────┼────────────────────────┼─────────────────────────┼────────────────────────┼─────────────────────────┤
│       4594 │ Guidehouse             │ NULL                    │ https://www.google.com │ https://encrypted-tbn0. │
│            │                        │                         │ /search?gl=us&hl=en&q= │ gstatic.com/images?q=tb │
│            │                        │                         │ Guidehouse&sa=X&ved=0a │ n:ANd9GcQbmcC-pbCuIfuWu │
│            │                        │                         │ hUKEwiosI_n2KX8AhUCm2o │ rdAt73eWsxsaGZKSeN2xwC8 │
│            │                        │                         │ FHWzsD2k4RhCYkAIIxA0   │ &s=0                    │
├────────────┼────────────────────────┼─────────────────────────┼────────────────────────┼─────────────────────────┤
│       4595 │ Protask                │ http://www.protaskinc.c │ https://www.google.com │ https://encrypted-tbn0. │
│            │                        │ om/                     │ /search?q=Protask&sa=X │ gstatic.com/images?q=tb │
│            │                        │                         │ &ved=0ahUKEwi_taTo2KX8 │ n:ANd9GcQqzAaX7nypw1nvK │
│            │                        │                         │ AhVPmmoFHX-lBPY4UBCYkA │ thg8zBA1mwakyH-vlIVjLlC │
│            │                        │                         │ IIzA0                  │ &s=0                    │
├────────────┼────────────────────────┼─────────────────────────┼────────────────────────┼─────────────────────────┤
│       4596 │ Atria Wealth Solutions │ http://www.atriawealth. │ https://www.google.com │ https://encrypted-tbn0. │
│            │                        │ com/                    │ /search?hl=en&gl=us&q= │ gstatic.com/images?q=tb │
│            │                        │                         │ Atria+Wealth+Solutions │ n:ANd9GcRWPMd1HioT6f6Ay │
│            │                        │                         │ &sa=X&ved=0ahUKEwja24T │ 00DqhVlCpTOaRY8d_I52yem │
│            │                        │                         │ q2KX8AhVdGVkFHTM4Bts4W │ 0lE&s                   │
│            │                        │                         │ hCYkAIIjg4             │                         │
├────────────┼────────────────────────┼─────────────────────────┼────────────────────────┼─────────────────────────┤
│       4597 │ ICONMA, LLC            │ http://www.iconma.com/  │ https://www.google.com │ https://encrypted-tbn0. │
│            │                        │                         │ /search?q=ICONMA,+LLC& │ gstatic.com/images?q=tb │
│            │                        │                         │ sa=X&ved=0ahUKEwjy6p3w │ n:ANd9GcSuUzhTtGXnUAQ50 │
│            │                        │                         │ 2KX8AhUwrHIEHRK5C_YQmJ │ iypDbcoyQHqRY1cfdFerX9s │
│            │                        │                         │ ACCLQO                 │ &s=0                    │
└────────────┴────────────────────────┴─────────────────────────┴────────────────────────┴─────────────────────────┘*/

SELECT *
FROM skills_job_dim
LIMIT 10;
/*
┌──────────┬────────┐
│ skill_id │ job_id │
│  int32   │ int32  │
├──────────┼────────┤
│        0 │   4593 │
│        0 │   4594 │
│        1 │   4594 │
│        2 │   4594 │
│        0 │   4595 │
│        0 │   4596 │
│        0 │   4597 │
│        1 │   4597 │
│        2 │   4599 │
│        1 │   4599 │
└──────────┴────────┘
       10 rows    */

SELECT *
FROM job_postings_fact
LIMIT 10;
/*
─────────┬────────────┬───────────────────────────┬───┬─────────────┬─────────────────┬─────────────────┐
│ job_id  │ company_id │      job_title_short      │ … │ salary_rate │ salary_year_avg │ salary_hour_avg │
│  int32  │   int32    │          varchar          │ … │   varchar   │     double      │     double      │
├─────────┼────────────┼───────────────────────────┼───┼─────────────┼─────────────────┼─────────────────┤
│  296745 │     296745 │ Data Scientist            │ … │ year        │        960000.0 │            NULL │
│ 1231950 │       8183 │ Data Scientist            │ … │ year        │        920000.0 │            NULL │
│  673003 │     673003 │ Senior Data Scientist     │ … │ year        │        890000.0 │            NULL │
│ 1575798 │     196988 │ Machine Learning Engineer │ … │ year        │        875000.0 │            NULL │
│ 1007105 │      16513 │ Data Scientist            │ … │ year        │        870000.0 │            NULL │
│  856772 │     856772 │ Data Scientist            │ … │ year        │        850000.0 │            NULL │
│ 1591743 │    1591743 │ Machine Learning Engineer │ … │ year        │        800000.0 │            NULL │
│ 1443865 │      13459 │ Senior Data Engineer      │ … │ year        │        800000.0 │            NULL │
│ 1574285 │       8183 │ Data Scientist            │ … │ year        │        680000.0 │            NULL │
│  142665 │     142665 │ Data Analyst              │ … │ year        │        650000.0 │            NULL │
└─────────┴────────────┴───────────────────────────┴───┴─────────────┴─────────────────┴─────────────────┘
  10 rows                      use .last to show entire result                      16 columns (6 shown) */