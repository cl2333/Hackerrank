SELECT start_date, MIN(end_date)
FROM (
	SELECT start_date
	FROM projects
	WHERE start_date NOT IN (
		SELECT end_date
		FROM projects
	)
) s, (
		SELECT end_date
		FROM projects
		WHERE end_date NOT IN (
			SELECT start_date
			FROM projects
		)
	) e
WHERE start_date < end_date
GROUP BY start_date
ORDER BY datediff(MIN(end_date), start_date) ASC, start_date ASC