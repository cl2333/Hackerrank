SELECT c.company_code, c.founder, lead_cnt, senior_cnt, manager_cnt
	, emp_cnt
FROM company c
	JOIN (
		SELECT COUNT(DISTINCT Lead_Manager_code) AS lead_cnt, company_code
		FROM Lead_Manager
		GROUP BY company_code
	) l
	ON c.company_code = l.company_code
	JOIN (
		SELECT COUNT(DISTINCT senior_Manager_code) AS senior_cnt, company_code
		FROM senior_Manager
		GROUP BY company_code
	) s
	ON c.company_code = s.company_code
	JOIN (
		SELECT COUNT(DISTINCT Manager_code) AS manager_cnt, company_code
		FROM Manager
		GROUP BY company_code
	) m
	ON c.company_code = m.company_code
	JOIN (
		SELECT COUNT(DISTINCT employee_code) AS emp_cnt, company_code
		FROM employee
		GROUP BY company_code
	) e
	ON c.company_code = e.company_code
ORDER BY c.company_code;