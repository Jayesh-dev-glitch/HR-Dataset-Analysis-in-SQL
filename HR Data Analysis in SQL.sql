create database hrproject;
use hrproject;
select *from employees;

-- Total Employees
select count(*) as total_employees
from employees;
 
-- Total Old Employees
SELECT COUNT(*) AS Total_Old_Employees
FROM employees
WHERE DateofTermination != '';

-- Total Current Employees
SELECT COUNT(*) AS Total_Current_Employees
FROM employees
WHERE DateofTermination = '';

-- Average salary
select avg(salary) as avg_salary
from employees;

-- Average Age
SELECT AVG(TIMESTAMPDIFF(YEAR, STR_TO_DATE(DOB, '%d-%m-%Y'), CURDATE())) AS Avg_Age
FROM employees;

-- Average Years in Company
SELECT AVG(TIMESTAMPDIFF(YEAR, STR_TO_DATE(DateofHire, '%d-%m-%Y'), CURDATE())) AS Avg_Years_in_Company
FROM employees;

-- Adding New Column for Employee Current Status
ALTER TABLE employees
ADD EmployeeCurrentStatus INT;

-- Updating values for New Column
SET SQL_SAFE_UPDATES=0;
UPDATE employees
SET EmployeeCurrentStatus = CASE    
      WHEN DateofTermination= '' THEN 1    
       ELSE 0
END;

-- Calculate Attrition Rate based on custom EmpStatusID values
SELECT     
         (CAST(COUNT(CASE WHEN EmployeeCurrentStatus = 0 THEN 1 END) AS FLOAT) / COUNT(*)) * 100 AS Attrition_Rate
FROM employees;

-- get Column Names and Data Types
DESCRIBE employees;
or
show columns from employee;

-- Print 1st 5 Rows
SELECT *
FROM employees
LIMIT 5;

-- Print last 5 Rows
SELECT *
FROM employees
ORDER BY EmpID DESC
LIMIT 5;

-- Changing Data Type of Salary
ALTER TABLE employees
MODIFY COLUMN Salary DECIMAL(10, 2);

-- Formatting columns for proper dates
-- Convert all date columns in proper dates
UPDATE employees
SET DOB = STR_TO_DATE(DOB, '%d-%m-%Y');
UPDATE employees
SET DateofHire = STR_TO_DATE(DateofHire, '%Y-%m-%d');
UPDATE employees
SET LastPerformanceReview_Date = STR_TO_DATE(LastPerformanceReview_Date, '%d-%m-%Y');

-- Alter table 
ALTER TABLE employees
MODIFY COLUMN DOB DATE,
MODIFY COLUMN DateofHire DATE,
MODIFY COLUMN LastPerformanceReview_Date DATE;

-- Read columns to check changes
select dob,dateofhire,dateoftermination,lastperformancereview_date
from employees;
describe employees;

-- Fill empty values in date of termination  
SET SQL_SAFE_UPDATES=0;
update employees
set dateoftermination="CurrentlyWorking"
where dateoftermination is null or dateoftermination= '';

-- count of each unique value in the MaritalDesc
select maritaldesc,count(*) as count
from employees
group by maritaldesc
order by count desc; 

-- count of each unique value in the department
select department,count(*) as count
from employees
group by department
order by count desc; 

-- count of each unique value in the positions
select position,count(*) as count
from employees
group by position
order by count desc; 

-- count of each unique value in the manager
select managername,count(*) as count
from employees
group by managername
order by count desc; 

-- Salary distribution by employees 
select case
when salary <30000 then '<30k'
when salary between 30000 and 49999 then '30k-49k'
when salary between 50000 and 69999 then '50k-69k'
when salary between 70000 and 89999 then '70k-89k'
when salary>=90000 then '90k and above'
end as salary_range,
count(*) as frequency 
from employees
group by salary_range
order by frequency,salary_range desc;

-- Performance score  
select performancescore,count(*) as count
from employees
group by performancescore
order by count,performancescore desc;

-- Average salary by department 
select department,avg(salary) as averagesalary
from employees
group by department
order by averagesalary desc; 

-- Count Termination by cause 
select termreason,count(*) as count
from employees
where termreason is not null
group by termreason
order by count desc; 

-- Employee count of state 
select state,count(*) as count
from employees
group by state
order by count desc; 

-- gender distribution 
select sex,count(*) as count
from employees
group by sex
order by count desc;

-- add a new column age
alter table employees
add column age int;

set sql_safe_updates=0;
-- update the age column with calculated age
update employees 
set age=timestampdiff(year,dob,curdate()); 

-- Age distribution 
select case
when age <20 then '<20'
when age between 20 and 29 then '20-29'
when age between 30 and 39 then '30-39'
when age between 40 and 49 then '40-49'
when age between 50 and 59 then '50-59'
when age>=60 then '60 and above'
end as age_range,
count(*) as count 
from employees
group by age_range;

-- Absences by department 
select department,sum(absences) as totalabsences
from employees
group by department
order by totalabsences desc;

-- Salary distribution by gender 
select sex,sum(salary) as totalsalary
from employees
group by sex
order by totalsalary desc;

-- Count of employees terminated as per marital status
select maritaldesc,count(*) as terminatedcount
from employees
where termd=1
group by maritaldesc
order by terminatedcount desc;

-- Average absence by performance score
select performancescore,avg(absences) as averageabsences
from employees
group by performancescore
order by performancescore;

-- Employee count by recruitment score 
select recruitmentsource,count(*) as employeecount
from employees
group by recruitmentsource
order by employeecount desc;


 