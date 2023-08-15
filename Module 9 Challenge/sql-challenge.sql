CREATE TABLE employees (
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE NOT NULL
);

CREATE TABLE salaries (
	emp_no INT PRIMARY KEY NOT NULL,
	salary INT NOT NULL
);

-- List the employee number, last name, first name, sex, and salary of each employee.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no=salaries.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date FROM employees WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.

CREATE TABLE dept_manager (
	dept_no VARCHAR(25) NOT NULL,
	emp_no INT(25) PRIMARY KEY NOT NULL
);

CREATE TABLE departments (
	dept_no VARCHAR(10) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(10) NOT NULL
);

SELECT dept_manager.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM employees
JOIN dept_manager
  ON employees.emp_no=dept_manager.emp_no
JOIN departments 
  ON dept_manager.dept_no=departments.dept_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT employees.emp_no, dept_emp.dept_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
  ON employees.emp_no=dept_emp.emp_no
JOIN departments 
  ON dept_emp.dept_no=departments.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex FROM employees WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.

SELECT dept_emp.emp_no, employees.last_name, employees.first_name 
FROM dept_emp
JOIN employees
ON employees.emp_no=dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no=departments.dept_no
WHERE dept_name = 'Sales';


-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT departments.dept_name, dept_emp.emp_no, employees.last_name, employees.first_name 
FROM dept_emp
JOIN employees
ON employees.emp_no=dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no=departments.dept_no
WHERE dept_name = 'Sales' OR dept_name ='Development';

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
ORDER BY COUNT(*) DESC;