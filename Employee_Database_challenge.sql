
-- DELIVERABLE 1
DROP TABLE retirement_titles;
-- Create new table for retiring employees
SELECT e.emp_no, e.first_name, e.last_name, f.title, f.from_date, f.to_date 
INTO retirement_titles
FROM employees AS e, titles AS f 
WHERE f.emp_no = e.emp_no 
	AND (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

-- Check the table
SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
-- create a Unique Titles table that contains the employee number, 
-- first and last name, and most recent title.
DROP TABLE unique_titles;
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles 
FROM retirement_titles
WHERE to_date='9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

SELECT * FROM unique_titles;

-- create a Retiring Titles table that contains the number of titles 
-- filled by employees who are retiring
DROP TABLE retiring_titles;
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT * FROM retiring_titles;

-- DELIVERABLE 2
--Mentorship Eligibility table
DROP TABLE mentorship_table;
SELECT DISTINCT ON(e.emp_no)e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_table
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
			INNER JOIN titles AS t
				ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;
SELECT * FROM mentorship_table;