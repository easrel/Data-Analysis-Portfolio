SELECT * FROM employees;

1.) --Display the minimum salary.
SELECT MIN(salary) AS minimum_salary FROM employees;


--2.) Display the highest salary.
SELECT MAX(salary) AS maxium_salary FROM employees;


--3.) Display the total salary of all employees.
SELECT SUM(salary) AS total_salary FROM employees;


--4.) Display the average salary of all employees.
SELECT AVG(salary) AS average_salary FROM employees;


--5.) Issue a query to count the number of row in the employee table. The result should be just one row.
SELECT COUNT(*) AS no_of_records FROM employees;


--6.) Issue a query to count the number of employees that make commission. The result should be just one row.
SELECT COUNT(*) AS commision_employees FROM employees
WHERE commission_pct IS NOT NULL;


--7.) Issue a query to count the number of employees’ first name column. The result should be just one row.
SELECT COUNT(first_name) AS first_name FROM employees;


--8.) Display all employees that make less than Peter Hall.
 SELECT first_name, last_name, salary FROM employees
 WHERE salary < (SELECT salary FROM employees WHERE first_name = 'Peter' AND last_name = 'Hall');


--9.) Display all the employees in the same department as Lisa Ozer

SELECT first_name, last_name, department_id FROM employees
WHERE department_id = (SELECT department_id FROM employees
WHERE first_name = 'Lisa' AND last_name = 'Ozer');

--10.) Display all the employees in the same department as Martha Sullivan and that make more than TJ Olson.
SELECT first_name, last_name, department_id, salary FROM employees
WHERE department_id = (SELECT department_id FROM employees WHERE first_name = 'Martha' AND last_name = 'Sullivan')
AND salary > (SELECT salary FROM employees WHERE first_name = 'TJ' AND last_name = 'Olson');

--11.) Display all the departments that exist in the departments table that are not in the employees table. Do not use a where clause
SELECT department_id FROM departments
EXCEPT
SELECT department_id FROM employees;

--12.) Display all the departments that exist in department tables that are also in the employees table. Do not use a where clause.
SELECT department_id FROM departments
INTERSECT
SELECT department_id FROM employees;
--13.) Display all the departments name, street address, postal code, city and state of each department.
--Use the departments and locations table for this query.
SELECT d.department_name, l.street_address, l.postal_code, l.city, l.state_province FROM departments d
JOIN locations l ON d.location_id = l.location_id;

--14.) Display the first name and salary of all the employees in the Accounting departments.
SELECT e.first_name, e.salary, d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE department_name = 'Accounting';


--15.) Display all the last name of all the employees whose department location id are 1700 and 1800
SELECT * FROM employees;
SELECT * FROM departments;
SELECT e.last_name, d.location_id FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.location_id = 1700 OR location_id = 1800;

--16.) Display the phone number of all the employees in the Marketing department.

SELECT e.phone_number, d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'marketing';

--17.) Display all the employees in the Shipping and Marketing departments who make more than 3100.
SELECT e.first_name, e.last_name, e.salary, d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name IN ('shipping', 'Marketing')
AND e.salary > 3100;
 
--18.) Display the last name and salary of the employees that makes the least in each department.
SELECT DISTINCT e.last_name, MIN(e.salary) AS minimum_salary, COUNT(d.department_id) AS department_id FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY last_name;
 

--19.) Display all the employees who were hired before Tayler Fox
SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date < (SELECT hire_date FROM employees WHERE first_name = 'Tayler' AND last_name = 'Fox');

--20.) Display names and salary of the employees in executive department.
SELECT e.first_name, e.last_name, e.salary, d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Executive';

--21.) Display the employees whose job ID is the same as that of employee 141
SELECT first_name, last_name, job_id FROM employees
WHERE job_id = (SELECT job_id FROM employees WHERE employee_id = 141);



--22.) For each employee, display the employee number, last name, salary,
--and salary increased by 15% and expressed as a whole number. Label the column New Salary.
SELECT employee_id, last_name, salary, (salary * 1.15) AS new_salary FROM employees;


--23.) Display the names and hire dates for all employees who were hire d before their managers,
--along with their manager’s names and hire dates. Label the columns Employee, Emp
--Hired, Manager, and Mgr Hired, respectively.
SELECT e.first_name emp_first_name, e.last_name emp_last_name, e.hire_date emp_hire_date, m.first_name, m.last_name,
m.hire_date manager_hire_date
FROM employees e JOIN employees m ON e.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date;

--24.) Display all the employees and their salaries that make more than Abel.
SELECT first_name, last_name, salary FRom employees
WHERE salary > (SELECT salary FROM employees WHERE first_name = 'Abel' OR last_name = 'Abel');


--25.) Create a query that displays the employees’ last names and commission amounts. If an
--employee does not earn commission, put “no commission”. Lable the column COMM.
SELECT last_name, ISNULL(CONVERT(VARCHAR(50),commission_pct), 'no_commission') COMM FROM employees;


--26.) Create a unique listing of all jobs that are in department 80. Include the location of department in the output.
SELECT DISTINCT e.job_id, e.department_id, d.location_id FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id  = 80;


--27.) Write a query to display the employee last name, department name, location ID, and city of all employees who earn a commission
SELECT e.last_name, e.commission_pct, d.department_name, l.location_id, l.city FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE commission_pct IS NOT NULL;


--28.) Create a query to display the name and hire date of any employee hired after employee Davies. 
SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date > (SELECT hire_date FROM employees WHERE first_name = 'Davies' OR last_name = 'Davies');

--31.) Display the highest, lowest, sum, and average salary of all employees.
--Label the columns MAXIMUM, MINIMUM, SUM and AVERAGE, respectively. Round up the result to the nearest whole number.
SELECT CEILING(ROUND(MAX(salary), 0)) AS 'MAXIMUM', CEILING(ROUND(MIN(salary), 0)) AS 'MINIMUM',
CEILING(ROUND(SUM(salary), 0)) AS 'SUM',
CEILING(ROUND(AVG(salary), 0)) AS 'AVERAGE' FROM employees;

SELECT CEILING(5.3);
SELECT FLOOR(5.3);
--32.) Display the MINIMUN, MAXIMUM, SUM AND AVERAGE salary of each job type.
SELECT job_id, MIN(salary) minimum_salary, MAX(salary) AS maximum_salary, SUM(salary) AS total_salary,
AVG(salary) AS average_salary FROM employees
GROUP BY job_id ORDER BY total_salary DESC;

--33.) Display all the employees and their managers from the employees table.
SELECT e.first_name emp_first_name, e.last_name emp_last_name, m.first_name manager_first_name,
m.last_name manager_last_name FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;

--34.) Determine the number of manager without listing them. Label the column NUMBER of manager.
--Hint: use manger_id column to determine the number of managers.
SELECT COUNT(DISTINCT manager_id) numbers_of_managers FROM employees;


--35.) Write a query that displays the difference between the HIGHEST AND LOWEST salaries. Label the column DIFFERENCE.
SELECT MAX(salary) - MIN(salary) 'difference' FROM employees;

--36.) Display the sum salary of all employees in each department.
SELECT SUM(salary) total_salary, first_name, last_name, department_id FROM employees
GROUP BY first_name, last_name, department_id;



--37.) Write a query to display each department's name, location, number of employees,
--and the average salary of employees in the department. Label the column NAME, LOCATION, NUMBER OF PEOPLE, respectively.
SELECT d.department_name name_of_department, d.location_id 'location', COUNT(e.employee_id) no_of_employees, SUM(e.salary) FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name, d.location_id;


--38.) Write a query to display the last name and hire date of employee in the same department as Zlotkey. Exclude Zlotkey.
SELECT last_name, hire_date, department_id FROM employees
WHERE department_id = (select department_id FROM employees WHERE last_name = 'Zlotkey')
AND last_name != 'Zlotkey';
--39.) Create a query to display the employee number and last name of all employees who earns more than the average salary.
--Sort the result in ascending order of salary.
SELECT employee_id, last_name FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);


--40.) Write a query that displays the employee number and last names of all employees who work in a department
--with any employees whose last name contains a letter U.
SELECT employee_id, last_name, department_id FROM employees
WHERE department_id IN (SELECT department_id FROM employees WHERE last_name LIKE '%U%');



--41.) Display the last name, department number and job id of all employees whose department location ID is 1700
SELECT e.last_name, e.department_id, e.job_id, d.location_id FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE location_id = 1700;


--42.) Display the last name and salary of every employee who reports to Partners.
SELECT * FROM employees
SELECT * FROM departments
SELECT * FROM locations
--43.) Display the department number, last name, job ID of every employee in Executive department.
SELECT e.department_id, e.last_name, e.job_id, d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE department_name = 'Executive';


--44.) Display all last name, their department name and id from employees and department tables.
SELECT e.last_name, d.department_name, e.employee_id FROM employees e
JOIN departments d ON e.department_id = d.department_id;
--45.) Display all the last name department name, id and location from employees, department and locations tables. Put it in a temporary table.
SELECT e.last_name, d.department_name, e.employee_id, l.location_id FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;



--46.)Find the employee who earn the same salary as the minimum salary for each department.
SELECT first_name, last_name, department_id, MIN(salary) min_salary FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees)
GROUP BY first_name, last_name, department_id;

SELECT MIN(salary) FROM employees;

--CASE WHEN
--Write a query to display salary level of each employee such that from 2000-4800 is Low salary
--from 500-10500 is medium salary and other are high
SELECT first_name, last_name,
           CASE
		   WHEN salary BETWEEN 2000 AND 4800 THEN 'low salary'
		   WHEN salary BETWEEN 5000 AND 10500 THEN 'Medium Salary'
		   ELSE 'High salary'
		   END AS 'Salary level'
FROM employees;
--write a query to display how old an employee has been working where 2001-2003 is old employee
--2004-2006 are intermediate while others are new
SELECT first_name, last_name, YEAR(hire_date) AS hire_year,
       CASE
	   WHEN YEAR(hire_date) BETWEEN '2001' AND '2003' THEN 'old employee'
	   WHEN YEAR(hire_date) BETWEEN '2004' AND '2006' THEN 'intermediate employee'
	   ELSE 'new employee'
	   END AS 'experience level'
FROM employees;

--DATE FUNCTION
--Display the hire_date, hire_day,hire_month(name), hire_year, hire_day_month
SELECT hire_date, FORMAT(hire_date, 'dddd') hire_day, DATENAME(MONTH, hire_date), YEAR(hire_date) hire_year FROM employees;

--STRINGS FUNCTIONS
--CONCATENATE
SELECT CONCAT(first_name, ' ', last_name) AS full_name, salary, hire_date FROM employees
WHERE salary > 8000;

SELECT first_name+ ' ' +last_name AS full_name, salary, hire_date FROM employees
WHERE salary > 8000;

--UPPER & LOWER CASE
SELECT first_name, UPPER(last_name) AS full_name, salary, hire_date FROM employees
WHERE salary > 8000;

--LEFT & RIGHT
SELECT RIGHT(first_name, 3) FROM employees;
SELECT LEFT(first_name, 3) FROM employees;

--Display employees full name, email by combining first 3 letters of their last name @gmail.com
SELECT CONCAT(first_name, ' ' , last_name) AS full_name,
        LEFT(last_name,3)+'@gmail.com' emp_email, salary FROM employees;


--SUBSTRING FUNCTION
SELECT phone_number, SUBSTRING(phone_number,5,3) code FROM employees;

--REPLACE
SELECT REPLACE(hire_date, '-', '/') hired_date FROM employees;

SELECT * FROM students;

--47, Write a query to determine who earns more than Mr. Tobias:

SELECT first_name, last_name, salary FROM employees
WHERE salary > (SELECT salary FROM employees WHERE first_name = 'Tobias' OR last_name = 'Tobias');




 SELECT * FROM employees;
 SELECT * FROM departments
 SELECT * FROM locations

 --49.) Find the job with the highest average salary.
 SELECT TOP 1 job_id, AVG(salary) highest_average_salary FROM employees
 GROUP BY job_id;

 --47.) Write a query to determine who earns more than Mr. Tobias:

 SELECT first_name, last_name, salary FROM employees
 WHERE salary > (SELECT salary FROM employees WHERE first_name = 'Tobias' OR last_name = 'Tobias');

 SELECT first_name, last_name, salary FROM employees
 WHERE first_name = 'Tobias' OR last_name = 'Tobias';

 --50.) Find the employees that make more than Taylor and are in department 80. 
 SELECT first_name, last_name, department_id, salary FROM employees
 WHERE salary > (SELECT salary FROM employees WHERE first_name = 'Taylor' OR last_name = 'Taylor'
 AND department_id IN (80));

 SELECT first_name, last_name, department_id FROM employees
 WHERE department_id = 80;

 --51.) Display all department names and their full street address.
 SELECT * FROM departments;
 SELECT * FROM locations;

 SELECT d.department_name, l.street_address, l.city, l.postal_code FROM departments d
 JOIN locations l ON d.location_id = l.location_id;

 --52.) Write a query to display the number of people with the same job

 SELECT job_id, COUNT(*) counts FROM employees GROUP BY job_id;

 --53.) Display the full name, department and salary of all employees who make the least in each department.
 SELECT first_name, last_name, salary AS min_salary, department_id FROM employees
 WHERE salary IN (SELECT MIN(salary) FROM employees GROUP BY department_id)

 --54.) Display the full name and salary of the employee that makes the most in departments 50 and 80.



 