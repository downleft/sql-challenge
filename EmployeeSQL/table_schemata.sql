-- Create Departments Table
CREATE TABLE departments (
	dept_no VARCHAR(4) PRIMARY KEY,
	dept_name VARCHAR(30) NOT NULL
);

-- Create Titles Table
CREATE TABLE titles (
	title_id VARCHAR(5) PRIMARY KEY,
	title VARCHAR(30) NOT NULL
);

-- Create Employees Table
CREATE TABLE employees (
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR(5) NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id),
	birth_date DATE,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	sex VARCHAR(1),
	hire_date DATE	
);

-- Create Department Employees Table
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

-- Create Department Manager Table
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

-- Salaries
CREATE TABLE salaries (
	emp_no INT PRIMARY KEY,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL
);

-- Departments: Import departments.csv and Confirm data correctly imported
SELECT * FROM departments;

-- Titles: Import titles.csv and Confirm data correctly imported
SELECT * FROM titles;

-- Employees: Import employees.csv and Confirm data correctly imported
SELECT * FROM employees;

-- Department Employees: Import dept_emp.csv and Confirm data correctly imported
SELECT * FROM dept_emp;

-- Department Managers: Import dept_manager.csv and Confirm data correctly imported into dept_manager table
SELECT * FROM dept_manager;

-- Salaries: Import salaries.csv and Confirm data correctly imported into salaries table
SELECT * FROM salaries;

-- Data Analysis
-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e 
INNER JOIN salaries AS s ON 
s.emp_no = e.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
-- date_part function notation from https://www.postgresqltutorial.com/postgresql-date-functions/postgresql-date_part/
SELECT first_name, last_name, hire_date
FROM employees
WHERE date_part('year', hire_date) = 1986;

-- 3. List the manager of each department along with their department number, department name, 
-- employee number, last name, and first name.
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager AS dm
INNER JOIN departments AS d ON 
dm.dept_no = d.dept_no
INNER JOIN employees AS e ON
dm.emp_no = e.emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, 
-- last name, first name, and department name.
SELECT de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de ON
de.emp_no = e.emp_no
INNER JOIN departments AS d ON 
d.dept_no = de.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and 
-- whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT d.dept_name, de.emp_no, e.last_name, e.first_name
FROM employees AS e
INNER JOIN dept_emp AS de ON 
de.emp_no = e.emp_no
INNER JOIN departments AS d ON
de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name.
SELECT d.dept_name, de.emp_no, e.last_name, e.first_name
FROM employees AS e
INNER JOIN dept_emp AS de ON 
de.emp_no = e.emp_no
INNER JOIN departments AS d ON
de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, 
-- how many employees share each last name).
SELECT last_name, COUNT(last_name) AS "name count"
FROM employees
GROUP BY last_name
ORDER BY "name count" DESC