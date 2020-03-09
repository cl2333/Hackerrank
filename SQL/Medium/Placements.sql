SELECT s.name
FROM friends f
	JOIN students s ON f.id = s.id
	JOIN packages p1 ON f.id = p1.id
	JOIN packages p2 ON f.friend_id = p2.id
WHERE p1.salary < p2.salary
ORDER BY p2.salary