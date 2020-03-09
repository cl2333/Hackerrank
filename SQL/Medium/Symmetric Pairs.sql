SELECT X, Y
FROM Functions
WHERE x = y
GROUP BY x, y
HAVING COUNT(*) > 1
UNION
SELECT f1.x, f1.y
FROM Functions f1
	JOIN Functions f2
	ON f1.x = f2.y
		AND f1.y = f2.x
WHERE f1.x <> f1.y
	AND f1.x < f2.x
ORDER BY 1