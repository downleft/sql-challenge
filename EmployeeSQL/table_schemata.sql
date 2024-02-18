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