-- Create Departments Table
CREATE TABLE departments (
	dept_no VARCHAR(4) PRIMARY KEY,
	dept_name VARCHAR(30)
);

CREATE TABLE titles (
	title_id VARCHAR(5) PRIMARY KEY,
	title VARCHAR(30)
);

CREATE TABLE employees (
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR(5),
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id),
	birth_date DATE,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	sex VARCHAR(1),
	hire_date DATE	
);

-- Create Department Employees Table
CREATE TABLE dept_emp (
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(4),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

-- Create Department Manager Table
CREATE TABLE dept_manager (
	dept_no VARCHAR(4),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

-- Salaries
CREATE TABLE salaries (
	emp_no INT PRIMARY KEY,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT
);

-- Confirm data correctly imported into departments table
SELECT * FROM departments;

-- Confirm data correctly imported into titles table
SELECT * FROM titles;

-- Confirm data correctly imported into employees table
SELECT * FROM employees;

-- Confirm data correctly imported into dept_emp table
SELECT * FROM dept_emp;

-- Confirm data correctly imported into dept_manager table
SELECT * FROM dept_manager;

-- Confirm data correctly imported into salaries table
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
WHERE date_part('year', hire_date) = 1986

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager AS dm
INNER JOIN departments AS d ON 
dm.dept_no = d.dept_no
INNER JOIN employees AS e ON
dm.emp_no = e.emp_no