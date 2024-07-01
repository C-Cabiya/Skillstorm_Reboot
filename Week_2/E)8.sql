USE hr_db

SELECT employee_id, department_name, average.salary, avg_dept_salary
FROM(SELECT
		employee_id,
		department_id,
		salary,
		CAST(AVG(salary) OVER (PARTITION BY department_id) AS decimal(18,2)) avg_dept_salary
	FROM employees) AS average JOIN departments ON departments.department_id = average.department_id
WHERE average.salary > average.avg_dept_salary

SELECT employee_id, 
	department_name, 
	salary,
	SUM(e.salary) OVER (PARTITION BY d.department_id ORDER BY salary )
FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE department_name = 'Finance' OR department_name = 'IT'
ORDER BY d.department_name

SELECT * FROM(
SELECT employee_id, department_id,
	dense_rank() OVER (
		PARTITION BY department_id
		ORDER BY department_id, salary DESC
	) [Dense Rank]
	FROM employees
	WHERE department_id IS NOT NULL) AS dense
WHERE dense.[Dense Rank] <=3 

USE retail_db
GO
