-- EXP-6

-- Safely replace the procedure when this file is run again.
DROP PROCEDURE IF EXISTS transfer_employee;

DELIMITER //
CREATE PROCEDURE transfer_employee(
  IN p_emp_id INT,
  IN p_new_dept_id INT
)
BEGIN
  DECLARE v_employee_count INT DEFAULT 0;
  DECLARE v_department_count INT DEFAULT 0;
  DECLARE v_current_dept INT DEFAULT NULL;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  START TRANSACTION;

  SELECT COUNT(*)
  INTO v_employee_count
  FROM employees
  WHERE emp_id = p_emp_id;

  SELECT COUNT(*)
  INTO v_department_count
  FROM Department
  WHERE dept_id = p_new_dept_id;

  IF v_employee_count = 0 THEN
    ROLLBACK;
    SELECT 'Error: Employee does not exist.' AS message;
  ELSEIF v_department_count = 0 THEN
    ROLLBACK;
    SELECT 'Error: Department does not exist.' AS message;
  ELSE
    SELECT dept_id
    INTO v_current_dept
    FROM employees
    WHERE emp_id = p_emp_id;

    IF v_current_dept = p_new_dept_id THEN
      ROLLBACK;
      SELECT 'Error: Employee is already in this department.' AS message;
    ELSE
      UPDATE employees
      SET dept_id = p_new_dept_id
      WHERE emp_id = p_emp_id;

      COMMIT;
      SELECT 'Employee transferred successfully.' AS message;
    END IF;
  END IF;
END //
DELIMITER ;

-- Initial verification check
SELECT e.emp_id, e.emp_name, d.dept_name 
FROM employees e 
JOIN Department d ON e.dept_id = d.dept_id 
WHERE e.emp_id = 101;

-- Test valid execution
CALL transfer_employee(101, 3);

-- Verify successful execution updates
SELECT e.emp_id, e.emp_name, d.dept_name 
FROM employees e 
JOIN Department d ON e.dept_id = d.dept_id 
WHERE e.emp_id = 101;

-- Test edge case: employee does not exist
CALL transfer_employee(999, 3);

-- Test edge case: department does not exist
CALL transfer_employee(101, 99);

-- Test edge case: same department transfer
CALL transfer_employee(101, 3);

DELIMITER //

-- BEFORE INSERT TRIGGER
DROP TRIGGER IF EXISTS validate_employee_salary //
CREATE TRIGGER validate_employee_salary
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary IS NULL OR NEW.salary < 15000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be NULL and must be at least 15000';
    END IF;
END //

-- BEFORE UPDATE TRIGGER
DROP TRIGGER IF EXISTS validate_employee_salary_update //
CREATE TRIGGER validate_employee_salary_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 15000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be at least 15000';
    END IF;
END //

DELIMITER ;

-- Reset the test employee so this section can be rerun safely.
DELETE FROM employees WHERE emp_id = 131;

-- Insert a valid test employee.
INSERT INTO employees (emp_id, emp_name, gender, salary, hire_date, dept_id)
VALUES (131, 'Test Employee', 'M', 30000, '2026-09-25', 1);

-- Verify entry
SELECT emp_id, emp_name, salary 
FROM employees 
WHERE emp_id = 131;

-- Verify the valid salary remains unchanged.
SELECT emp_id, emp_name, salary
FROM employees
WHERE emp_id = 131;

-- Create Audit Table
CREATE TABLE IF NOT EXISTS Salary_Audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action VARCHAR(30)
);

DELIMITER //

-- Fixed: Changed inner curly braces `{}` to regular SQL parentheses `()`
DROP TRIGGER IF EXISTS salary_audit_trigger //
CREATE TRIGGER salary_audit_trigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO Salary_Audit (emp_id, old_salary, new_salary, action)
        VALUES (NEW.emp_id, OLD.salary, NEW.salary, 'SALARY UPDATED');
    END IF;
END //

DELIMITER ;

-- Test audit trigger changes
UPDATE employees SET salary = 35000 WHERE emp_id = 131;
SELECT * FROM Salary_Audit;

-- Test multiple salary changes
UPDATE employees SET salary = 40000 WHERE emp_id = 131;
UPDATE employees SET salary = 45000 WHERE emp_id = 131;

SELECT audit_id, emp_id, old_salary, new_salary, action 
FROM Salary_Audit 
WHERE emp_id = 131;

-- Test edge case: salary remains unchanged (No new audit line should generate)
UPDATE employees SET salary = 45000 WHERE emp_id = 131;

-- View all existing triggers
SHOW TRIGGERS;

-- Show procedures in the active database, then return a visible final result.
SHOW PROCEDURE STATUS WHERE Db = DATABASE();

SELECT emp_id, emp_name, salary, dept_id
FROM employees
WHERE emp_id IN (101, 131)
ORDER BY emp_id;


