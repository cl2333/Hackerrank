SELECT c1.contest_id,
        c1.hacker_id,
        c1.name,
         sum(s.total_submissions_sum),
         sum(s.total_accepted_submissions_sum),
         sum(v.total_views_sum),
        sum(v.total_unique_views_sum)
FROM contests c1
JOIN Colleges c2
    ON c1.contest_id=c2.contest_id
JOIN challenges c3
    ON c2.college_id=c3.college_id
LEFT JOIN 
    (SELECT challenge_id,
        sum(total_submissions) AS total_submissions_sum,
         sum(total_accepted_submissions) AS total_accepted_submissions_sum
    FROM submission_stats
    GROUP BY  challenge_id) s
    ON s.challenge_id = c3. challenge_id
LEFT JOIN 
    (SELECT challenge_id,
        sum(total_views) AS total_views_sum,
         sum(total_unique_views) AS total_unique_views_sum
    FROM View_Stats
    GROUP BY  challenge_id) v
    ON v.challenge_id = c3. challenge_id
GROUP BY  c1.contest_id,c1.hacker_id,c1.name
HAVING sum(s.total_submissions_sum) > 0
        OR sum(s.total_accepted_submissions_sum) >0
        OR sum(v.total_views_sum) >0
        OR sum(v.total_unique_views_sum) >0
ORDER BY  c1.contest_id;