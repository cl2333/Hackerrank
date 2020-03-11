set @r1=0,
         @r2=0,
         @r3=0,
         @r4=0;SELECT min(Doctor),
         min(Professor),
         min(Singer),
         min(Actor) from( select
    CASE
    WHEN Occupation='Doctor' THEN(@r1:=@r1+1)
    WHEN Occupation='Professor' THEN
    (@r2:=@r2+1)
    WHEN Occupation='Singer' THEN
    (@r3:=@r3+1)
    WHEN Occupation='Actor' THEN
    (@r4:=@r4+1)
    END AS RowNumber,
    CASE
    WHEN Occupation='Doctor' THEN
    Name
    END AS Doctor,
    CASE
    WHEN Occupation='Professor' THEN
    Name
    END AS Professor,
    CASE
    WHEN Occupation='Singer' THEN
    Name
    END AS Singer,
    CASE
    WHEN Occupation='Actor' THEN
    Name
    END AS Actor
FROM OCCUPATIONS
ORDER BY  Name) Temp
GROUP BY  RowNumber;


SELECT MIN(doctor), MIN(professor)
	, MIN(singer), MIN(actor)
FROM (
	SELECT CASE 
			WHEN occupation = 'Doctor' THEN name
		END AS doctor
		, CASE 
			WHEN occupation = 'Professor' THEN name
		END AS professor
		, CASE 
			WHEN occupation = 'Actor' THEN name
		END AS actor
		, CASE 
			WHEN occupation = 'Singer' THEN name
		END AS singer, row_number() OVER (PARTITION BY occupation ORDER BY name) AS ranking
	FROM occupations
) s
GROUP BY ranking
ORDER BY 1, 2, 3, 4;

SELECT [Doctor] ,
         [Professor],
         [Singer],
         [Actor]
FROM 
    (SELECT occupation,
         name,
         row_number()
        OVER (partition by occupation
    ORDER BY  name) rn
    FROM occupations ) AS temp pivot ( min(name) for occupation IN ([Doctor],[Professor],[Singer],[Actor])) AS pvt