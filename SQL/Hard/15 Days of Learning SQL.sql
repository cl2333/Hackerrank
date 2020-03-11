SELECT s4.submission_date,
         s2.hacker_cnt,
         h.hacker_id,
        h.name
FROM 
    (SELECT submission_date,
         count(distinct hacker_id) AS hacker_cnt
    FROM 
        (SELECT *,
         dense_rank()
            OVER (order by submission_date) AS date_rank, dense_rank()
            OVER (partition by hacker_id
        ORDER BY  submission_date) AS hacker_rank
        FROM submissions) s1
        WHERE date_rank = hacker_rank
        GROUP BY  submission_date ) s2
    JOIN 
    (SELECT hacker_id,
        submission_date,
        rank()
        OVER (partition by submission_date
    ORDER BY  sub_cnt desc, hacker_id) AS cnt_rank
    FROM 
        (SELECT hacker_id,
         submission_date,
         count(*) AS sub_cnt
        FROM submissions
        GROUP BY  hacker_id, submission_date ) s3 ) s4
        ON s2. submission_date=s4.submission_date
        AND s4.cnt_rank=1
LEFT JOIN hackers h
    ON s4.hacker_id=h.hacker_id
ORDER BY  s4.submission_date