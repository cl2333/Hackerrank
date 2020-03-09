SELECT c.hacker_id, h.name, COUNT(*) AS cnt
FROM Hackers h
	JOIN Challenges c ON h.hacker_id = c.hacker_id
GROUP BY c.hacker_id, h.name
HAVING COUNT(*) = (
	SELECT COUNT(c1.challenge_id)
	FROM Challenges c1
	GROUP BY c1.hacker_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
)
OR COUNT(*) NOT IN (
	SELECT COUNT(c2.challenge_id)
	FROM challenges c2
	WHERE c2.hacker_id <> c.hacker_id
	GROUP BY c2.hacker_id
)
ORDER BY cnt DESC, h.hacker_id;