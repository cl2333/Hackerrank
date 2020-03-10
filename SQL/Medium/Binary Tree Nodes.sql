SELECT N
	, IF(P IS NULL, 'Root', IF(B.N IN (
		SELECT P
		FROM BST
	), 'Inner', 'Leaf'))
FROM BST B
ORDER BY N;