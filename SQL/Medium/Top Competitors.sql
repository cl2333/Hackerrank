SELECT h.hacker_id, h.name
FROM Submissions s
	JOIN Hackers h ON s.hacker_id = h.hacker_id
	JOIN Challenges c ON s.challenge_id = c.challenge_id
	JOIN Difficulty d ON c.difficulty_level = d.difficulty_level
WHERE d.score = s.score
GROUP BY h.hacker_id, h.name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC, h.hacker_id;