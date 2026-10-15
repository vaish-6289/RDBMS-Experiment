-- INNER JOIN 
SELECT 
e.emp_id, 
e.emp_name, 
d.dept_name 
FROM employees e 
INNER JOIN Department d 
ON e.dept_id = d.dept_id;

-- LEFT JOIN 
SELECT 
d.dept_id, 
d.dept_name, 
e.emp_name 
FROM Department d 
LEFT JOIN employees e 
ON d.dept_id = e.dept_id; 

-- 3-WAY JOIN 
SELECT 
e.emp_name, 
d.dept_name, 
p.project_name 
FROM employees e 
JOIN Department d 
ON e.dept_id = d.dept_id 
JOIN Employee_Project ep 
ON e.emp_id = ep.emp_id 
JOIN Project p 
ON ep.project_id = p.project_id; 

SELECT 
e.emp_name, 
d.dept_name, 
e.salary 
FROM employees e 
JOIN Department d 
ON e.dept_id = d.dept_id 
JOIN Project p 
ON d.dept_id = p.dept_id;

-- CORRELATED SUBQUERY 
SELECT 
e.emp_id, e.emp_name, e.salary, e.dept_id 
FROM employees e 
WHERE e.salary > 
( 
  SELECT AVG(e2.salary) 
  FROM employees e2 
  WHERE e2.dept_id = e.dept_id 
);

-- EXISTS 
SELECT 
e.emp_id, 
e.emp_name 
FROM Employee e 
WHERE EXISTS 
( 
  SELECT 1 
  FROM Employee_Project ep 
  WHERE ep.emp_id = e.emp_id 
); 

-- SIMULATED INTERSECT 
SELECT 
e.emp_id, 
e.emp_name 
FROM employees e 
WHERE e.dept_id = 1 
AND EXISTS 
( 
  SELECT 1 FROM Employee_Project ep 
  WHERE ep.emp_id = e.emp_id 
  AND ep.project_id = 201 
); 

-- SIMULATED EXCEPT 
SELECT e.emp_id, e.emp_name FROM employees e 
WHERE e.dept_id = 1 
AND NOT EXISTS ( 
SELECT 1 
FROM Employee_Project ep WHERE ep.emp_id = e.emp_id 
AND ep.project_id = 201 
); 

-- COMPARING EXECUTION PLANS USING INNER JOIN 
SELECT 
e.emp_id, 
e.emp_name, 
d.dept_name 
FROM employees e 
INNER JOIN Department d 
ON e.dept_id = d.dept_id; 

-- LEFT JOIN 
SELECT 
d.dept_name, e.emp_name 
FROM Department d LEFT JOIN employees e 
ON d.dept_id = e.dept_id;

-- CORRELATED SUBǪUERY 
 SELECT 
e.emp_name, e.salary 
FROM employees e 
WHERE e.salary > 
( 
SELECT AVG(e2.salary) 
FROM employees e2 
WHERE e2.dept_id = e.dept_id 
); 

-- EXISTS 
SELECT 
e.emp_id, e.emp_name 
FROM employees e 
WHERE EXISTS 
( 
SELECT 1 
FROM Employee_Project ep 
WHERE ep.emp_id = e.emp_id 
); 
