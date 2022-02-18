-- MODULE 7 CHALLENGE 

-- Make a new table with the employees who are about to retire and their titles.

--DROP TABLE retirement_titles;
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	titles.title,
	titles.from_date,
	titles.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles
ON (e.emp_no = titles.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

-- Get the information of people who are about to retire and their current role.

--DROP TABLE unique_titles;
SELECT DISTINCT ON (rt.emp_no) emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no ASC, rt.to_date DESC;
--SELECT * from unique_titles;

-- Get the count of retiring employees per title and sort it in descending order.

-- DROP TABLE retiring_titles;
SELECT COUNT (DISTINCT ut.emp_no),
	ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT DESC;
--SELECT * from retiring_titles;

-- We make a table of employees eligible for a mentorship and their titles.

--DROP TABLE mentorship_eligibility;
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	titles.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles
ON (de.emp_no = titles.emp_no)
WHERE (titles.to_date = '9999-01-01' AND de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC;
--SELECT * FROM mentorship_eligibility;