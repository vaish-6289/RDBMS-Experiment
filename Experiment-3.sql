-- TABLE CREATING 

-- Create the Department table
CREATE TABLE IF NOT EXISTS Department ( 
  dept_id INT PRIMARY KEY, 
  dept_name VARCHAR(50) NOT NULL, 
  location VARCHAR(50)
); 

-- Create the employees table
CREATE TABLE IF NOT EXISTS employees ( 
  emp_id INT PRIMARY KEY, 
  emp_name VARCHAR(50) NOT NULL, 
  gender CHAR(1), salary DECIMAL(10,2), 
  hire_date DATE, 
  dept_id INT, 
  FOREIGN KEY (dept_id) 
  REFERENCES Department(dept_id) 
);

-- Create the Project table
CREATE TABLE IF NOT EXISTS Project ( 
  project_id INT PRIMARY KEY, 
  project_name VARCHAR(100) NOT NULL, 
  budget DECIMAL(12,2), 
  dept_id INT, 
  FOREIGN KEY (dept_id) 
  REFERENCES Department(dept_id) 
); 

-- Create the Employee_Project table
CREATE TABLE IF NOT EXISTS Employee_Project ( 
  emp_id INT, 
  project_id INT, 
  hours_worked INT, 
  PRIMARY KEY (emp_id, project_id), 
  FOREIGN KEY (emp_id) 
  REFERENCES employees(emp_id), 
  FOREIGN KEY (project_id) 
  REFERENCES Project(project_id) 
); 

-- Create the salaries table
CREATE TABLE salaries (
  employee_id INT PRIMARY KEY,
  amount DECIMAL(10, 2) NOT NULL,
  from_date DATE,
  to_date DATE,
  FOREIGN KEY (employee_id) REFERENCES employees(emp_id) 
);

-- INSERTING DEPARTMENTS 
INSERT INTO Department (dept_id, dept_name, location) 
VALUES 
(1, 'Development', 'Delhi'), 
(2, 'Human Resources', 'Mumbai'), 
(3, 'Accounting', 'Bangalore'), 
(4, 'Sales', 'Pune'), 
(5, 'Innovation', 'Hyderabad'); 

-- INSERTING 30 EMPLOYEES 
INSERT INTO employees 
(emp_id, emp_name, gender, salary, hire_date, dept_id) 
VALUES 
(101, 'Aarush Khanna', 'M', 78000, '2021-01-15', 1), 
(102, 'Ishita Roy', 'F', 69000, '2022-03-10', 1), 
(103, 'Vivaan Sinha', 'M', 84000, '2020-07-20', 1), 
(104, 'Myra Joshi', 'F', 74000, '2021-11-05', 1), 
(105, 'Reyansh Kapoor', 'M', 97000, '2019-06-18', 1), 
(106, 'Anika Bhatia', 'F', 66000, '2023-01-12', 1), 
(107, 'Kabir Malhotra', 'M', 57000, '2022-05-15', 2), 
(108, 'Aadhya Menon', 'F', 64000, '2021-09-22', 2), 
(109, 'Vihaan Arora', 'M', 60000, '2020-04-11', 2), 
(110, 'Kiara Saxena', 'F', 69000, '2023-02-19', 2), 
(111, 'Advait Rao', 'M', 62000, '2022-08-01', 2), 
(112, 'Saanvi Desai', 'F', 73000, '2019-12-10', 2), 
(113, 'Dhruv Mehta', 'M', 90000, '2020-01-25', 3), 
(114, 'Navya Pillai', 'F', 94000, '2019-08-14', 3), 
(115, 'Arnav Kulkarni', 'M', 78000, '2021-06-30', 3), 
(116, 'Tara Chawla', 'F', 87000, '2022-10-17', 3), 
(117, 'Ishaan Nair', 'M', 75000, '2023-03-21', 3), 
(118, 'Riddhi Shah', 'F', 92000, '2020-11-09', 3), 
(119, 'Krish Bansal', 'M', 72000, '2021-02-28', 4), 
(120, 'Avni Khurana', 'F', 68000, '2022-04-15', 4), 
(121, 'Rudra Mishra', 'M', 76000, '2020-09-12', 4), 
(122, 'Pari Anand', 'F', 83000, '2019-07-07', 4), 
(123, 'Yuvaan Sethi', 'M', 71000, '2023-01-05', 4), 
(124, 'Diya Oberoi', 'F', 79000, '2021-12-18', 4), 
(125, 'Atharv Reddy', 'M', 99000, '2018-05-20', 5), 
(126, 'Meher Kaur', 'F', 93000, '2020-03-16', 5), 
(127, 'Shaurya Das', 'M', 89000, '2021-10-08', 5), 
(128, 'Zoya Fernandes', 'F', 95000, '2019-11-25', 5), 
(129, 'Ayaan Thakur', 'M', 81000, '2022-07-14', 5), 
(130, 'Vanya Kapoor', 'F', 98000, '2023-02-02', 5); 

-- INSERTING 8 PROJECTS 
INSERT INTO Project (project_id, project_name, budget, dept_id) VALUES 
(201, 'Smart Web Portal', 550000, 1), 
(202, 'Cloud Infrastructure', 800000, 1), 
(203, 'Staff Development Program', 300000, 2), 
(204, 'Budget Forecasting System', 650000, 3), 
(205, 'Online Sales Campaign', 480000, 4), 
(206, 'Customer Insights Study', 400000, 4), 
(207, 'Predictive Analytics Platform', 950000, 5), 
(208, 'Cybersecurity Framework', 1100000, 5); 

-- ASSIGNING EMPLOYEES TO PROJECTS 
INSERT INTO Employee_Project (emp_id, project_id, hours_worked) 
VALUES 
(101, 201, 120), 
(102, 201, 100), 
(103, 202, 150), 
(104, 202, 110), 
(105, 201, 130), 
(106, 202, 90), 
(107, 203, 100), 
(108, 203, 120), 
(109, 203, 80), 
(110, 203, 110), 
(111, 203, 90), 
(112, 203, 130), 
(113, 204, 140), 
(114, 204, 150), 
(115, 204, 120), 
(116, 204, 135), 
(117, 204, 100), 
(118, 204, 145), 
(119, 205, 110), 
(120, 205, 100), 
(121, 206, 120), 
(122, 205, 140), 
(123, 206, 90), 
(124, 206, 130), 
(125, 207, 160), 
(126, 207, 140), 
(127, 208, 150), 
(128, 208, 160), 
(129, 207, 120), 
(130, 208, 135); 

-- INSERTING INTO salaries
INSERT INTO salaries (employee_id, amount, from_date, to_date) 
VALUES 
(101, 78000.00, '2021-01-15', '9999-12-31'), 
(102, 69000.00, '2022-03-10', '9999-12-31'), 
(103, 84000.00, '2020-07-20', '9999-12-31'), 
(104, 74000.00, '2021-11-05', '9999-12-31'), 
(105, 97000.00, '2019-06-18', '9999-12-31'), 
(106, 66000.00, '2023-01-12', '9999-12-31'), 
(107, 57000.00, '2022-05-15', '9999-12-31'), 
(108, 64000.00, '2021-09-22', '9999-12-31'), 
(109, 60000.00, '2020-04-11', '9999-12-31'), 
(110, 69000.00, '2023-02-19', '9999-12-31'), 
(111, 62000.00, '2022-08-01', '9999-12-31'), 
(112, 73000.00, '2019-12-10', '9999-12-31'), 
(113, 90000.00, '2020-01-25', '9999-12-31'), 
(114, 94000.00, '2019-08-14', '9999-12-31'), 
(115, 78000.00, '2021-06-30', '9999-12-31'), 
(116, 87000.00, '2022-10-17', '9999-12-31'), 
(117, 75000.00, '2023-03-21', '9999-12-31'), 
(118, 92000.00, '2020-11-09', '9999-12-31'), 
(119, 72000.00, '2021-02-28', '9999-12-31'), 
(120, 68000.00, '2022-04-15', '9999-12-31'), 
(121, 76000.00, '2020-09-12', '9999-12-31'), 
(122, 83000.00, '2019-07-07', '9999-12-31'), 
(123, 71000.00, '2023-01-05', '9999-12-31'), 
(124, 79000.00, '2021-12-18', '9999-12-31'), 
(125, 99000.00, '2018-05-20', '9999-12-31'), 
(126, 93000.00, '2020-03-16', '9999-12-31'), 
(127, 89000.00, '2021-10-08', '9999-12-31'), 
(128, 95000.00, '2019-11-25', '9999-12-31'), 
(129, 81000.00, '2022-07-14', '9999-12-31'), 
(130, 98000.00, '2023-02-02', '9999-12-31');

SELECT * FROM Department;
SELECT * FROM employees;
SELECT * FROM Project;
SELECT * FROM salaries;
SELECT * FROM Employee_Project;

-- SELECTION
SELECT 
  e.emp_id, 
  e.emp_name, 
  s.amount AS salary 
FROM employees e 
JOIN salaries s 
ON e.emp_id = s.employee_id 
WHERE s.amount > 80000.00;

-- PROJECTION
SELECT 
  e.emp_name, 
  s.amount AS salary 
FROM employees e 
JOIN salaries s 
ON e.emp_id = s.employee_id;

-- AGGREGATE FUNCTIONS 
SELECT 
COUNT(DISTINCT employee_id) AS total_employees, 
SUM(amount) AS total_salary, 
AVG(amount) AS average_salary, 
MAX(amount) AS highest_salary, 
MIN(amount) AS lowest_salary 
FROM salaries; 

-- GROUP BY 
SELECT dept_id, 
COUNT(*) AS employee_count 
FROM employees 
GROUP BY dept_id; 

-- GROUP BY WITH JOIN 
SELECT d.dept_name, 
AVG(s.amount) AS average_salary 
FROM Department d 
JOIN employees e 
ON d.dept_id = e.dept_id 
JOIN salaries s 
ON e.emp_id = s.employee_id 
GROUP BY d.dept_name; 

-- HAVING 
SELECT d.dept_name, 
AVG(s.amount) AS average_salary 
FROM Department d 
JOIN employees e 
ON d.dept_id = e.dept_id 
JOIN salaries s 
ON e.emp_id = s.employee_id 
GROUP BY d.dept_name 
HAVING AVG(s.amount) > 75000; 

-- CASE EXPRESSIONS 
SELECT 
e.emp_name, 
s.amount AS salary, 
CASE 
WHEN s.amount >= 90000 THEN 'High Salary' 
WHEN s.amount >= 70000 THEN 'Medium Salary' 
ELSE 'Low Salary' 
END AS salary_category 
FROM employees e 
JOIN salaries s 
ON e.emp_id = s.employee_id;

-- COMPLETE EMPLOYEE-DEPARTMENT REPORT 
SELECT 
p.project_id, 
p.project_name, 
d.dept_name, 
p.budget 
FROM project p 
JOIN Department d 
ON p.dept_id = d.dept_id 
ORDER BY p.budget DESC;

-- PROJECT DETAILS 
SELECT 
p.project_name, 
d.dept_name, 
p.budget 
FROM project p 
JOIN Department d 
ON p.dept_id = d.dept_id 
ORDER BY p.budget DESC;

-- EMPLOYEES WORKING ON PROJECTS 
SELECT 
e.emp_name, 
p.project_name, 
ep.hours_worked 
FROM employee_project ep 
JOIN employees e 
ON ep.emp_id = e.emp_id 
JOIN project p 
ON ep.project_id = p.project_id 
ORDER BY ep.hours_worked DESC;