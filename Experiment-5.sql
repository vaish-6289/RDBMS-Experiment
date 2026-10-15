-- EXP-5

-- DEPARTMENT SALARY SUMMARY VIEW 
CREATE VIEW 
Department_Salary_Summary AS SELECT 
d.dept_id, 
d.dept_name, 
COUNT(e.emp_id) AS total_employees, 
SUM(e.salary) AS total_salary, 
AVG(e.salary) AS average_salary, 
MAX(e.salary) AS highest_salary, 
MIN(e.salary) AS lowest_salary 
FROM Department d LEFT JOIN employees e 
ON d.dept_id = e.dept_id 
GROUP BY d.dept_id, d.dept_name; 

SELECT * FROM Department_Salary_Summary;

-- Find departments with an average salary greater than ₹75,000
SELECT 
dept_name, average_salary 
FROM Department_Salary_Summary 
WHERE average_salary > 75000; 

-- EMPLOYEE HIERARCHY 
ALTER TABLE employees 
ADD manager_id INT NULL; 

ALTER TABLE employees 
ADD CONSTRAINT fk_employee_manager FOREIGN KEY (manager_id) 
REFERENCES employees(emp_id);

-- INSERT EMPLOYEE HIERARCHY

-- Update Manager IDs 
UPDATE employees 
SET manager_id = NULL 
WHERE emp_id IN (105, 112, 114, 122, 125); 

-- IT 
UPDATE employees 
SET manager_id = 105 
WHERE emp_id IN (103, 104); 

UPDATE employees
SET manager_id = 103 
WHERE emp_id IN (101, 102); 

UPDATE employees
SET manager_id = 104 
WHERE emp_id = 106; 

-- HR 
UPDATE employees
SET manager_id = 105 
WHERE emp_id IN (103, 104);

UPDATE employees 
SET manager_id = 103 
WHERE emp_id IN (101, 102);

-- Finance 
UPDATE employees 
SET manager_id = 112 
WHERE emp_id IN (107, 108); 

UPDATE employees 
SET manager_id = 107 
WHERE emp_id = 109;

UPDATE employees 
SET manager_id = 108 
WHERE emp_id IN (110, 111);

-- Marketing 
UPDATE employees
SET manager_id = 112 
WHERE emp_id IN (107, 108);

UPDATE employees 
SET manager_id = 107 
WHERE emp_id = 109;

UPDATE employees 
SET manager_id = 108 
WHERE emp_id IN (110, 111);

-- Research 
UPDATE employees 
SET manager_id = 125 
WHERE emp_id IN (126, 127, 128);

UPDATE employees 
SET manager_id = 126 
WHERE emp_id = 129;

UPDATE employees 
SET manager_id = 128 
WHERE emp_id = 13;

-- EMPLOYEE HIERARCHY VIEW 
CREATE VIEW Employee_Hierarchy AS SELECT 
e.emp_id, 
e.emp_name AS employee_name, e.manager_id, 
m.emp_name AS manager_name, e.salary, 
e.dept_id FROM employees e 
LEFT JOIN employees m 
ON e.manager_id = m.emp_id; 

SELECT * FROM Employee_Hierarchy; 

-- UPDATE THROUGH THE VIEW 
UPDATE employees SET salary = 78000 
WHERE emp_id = 101; 

SELECT * FROM employees WHERE emp_id = 1 ;

-- TEST NON-UPDATABILITY OF DEPARTMENT SALARY VIEW 
UPDATE Department_Salary_Summary 
SET average_salary = 80000 
WHERE dept_id = 1; 

-- 3. RECURSIVE CTE (Full Hierarchy)
WITH RECURSIVE EmployeeChain AS ( 
    -- Anchor member 
    SELECT 
        emp_id, 
        emp_name, 
        manager_id, 
        0 AS level, 
        CAST(emp_name AS CHAR(500)) AS reporting_chain
    FROM employees
    WHERE manager_id IS NULL 
    
    UNION ALL 
    
    -- Recursive member 
    SELECT 
        e.emp_id, 
        e.emp_name, 
        e.manager_id, 
        ec.level + 1, 
        CONCAT(ec.reporting_chain, ' -> ', e.emp_name) 
    FROM employees e 
    INNER JOIN EmployeeChain ec ON e.manager_id = ec.emp_id 
) 
SELECT emp_id, emp_name, manager_id, level, reporting_chain 
FROM EmployeeChain 
ORDER BY reporting_chain;

-- RECURSIVE CTE FOR ONE EMPLOYEE (Bottom-Up Manager Chain)
WITH RECURSIVE ReportingChain AS ( 
    -- Anchor Member: Start with the specific employee (e.g., ID 101)
    SELECT 
        emp_id, 
        emp_name, 
        manager_id, 
        0 AS level 
    FROM employees 
    WHERE emp_id = 101 
    
    UNION ALL 
    
-- Recursive Member: Find the manager of the person in the previous step
    SELECT 
        e.emp_id, 
        e.emp_name, 
        e.manager_id, 
        rc.level + 1 
    FROM employees e 
    INNER JOIN ReportingChain rc 
        ON e.emp_id = rc.manager_id  
) 
SELECT 
    emp_id, 
    emp_name, 
    manager_id, 
    level 
FROM ReportingChain;

