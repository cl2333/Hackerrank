SELECT id, age, coins, power
FROM (
	SELECT w.id AS id, p.age AS age, w.coins_needed AS coins, w.power AS power, rank() OVER (PARTITION BY p.age, w.power ORDER BY w.coins_needed ASC) AS ranking
	FROM wands w
		JOIN wands_property p ON w.code = p.code
	WHERE p.is_evil = 0
) s
WHERE ranking = 1
ORDER BY power DESC, age DESC;