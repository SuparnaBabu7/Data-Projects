--Select only top 1 record from employee table 
select top 1 * from dbo.emp_details;

--Select only bottom 1 record from employee table 
select top 1 * from dbo.emp_details order  by emp_id desc;

--How to select random records from table?
select * from dbo.emp_details where emp_id % 2 = 1;  -- displaying alternative rows from table (odd rows)
select * from dbo.emp_details where emp_id % 2 != 1; -- displaying alternative rows from table (even rows)

--write a query to get "first_name" in  uppercase as "first_name_upper"?
select upper(first_name) as first_name_upper from dbo.emp_details;

--write a query to get "first_name" in  uppercase as "first_name_lower"?
select lower(first_name) as first_name_lower from dbo.emp_details;

--create a new column "full_name" by combining "first_name" & "last_name" with space as a seperator?
alter table dbo.emp_details add full_name VARCHAR(255);
update dbo.emp_details set full_name = first_name + ' ' + last_name

--add "Hello" to first_name and display result
select 'Hello ' + first_name as greeting from dbo.emp_details;

--select the employee details of whose first_name is Malli
select * from dbo.emp_details where first_name = 'Malli';

--select the employee details of whose first_name present in ("Malli","Meena", "Anjali")
select * from dbo.emp_details where first_name in('Malli','Meena','Anjali');

--select the employee details of whose first_name not present in ("Malli","Meena", "Anjali")
select * from dbo.emp_details where first_name not in ('Malli','Meena','Anjali');

--select the employee details of whose first_name starts with "v"
select * from dbo.emp_details where first_name like 'V%'; 

--select the employee details of whose first_name ends with "i"
select * from dbo.emp_details where first_name like '%i';

--select the employee details of whose first_name contains "o"
select * from dbo.emp_details where first_name like '%o%';

--select the employee details of whose first_name start with any single character between 'M-v'
select * from dbo.emp_details where first_name like '[M-v]%';

--select the employee details of whose first_name not start with any single character between 'M-v'
select * from dbo.emp_details where first_name not like '[M-v]%';

--select the employee details of whose first_name start with 'M' and contain 5 letters
select * from dbo.emp_details where first_name like 'M%' and len(first_name) = 5;

--write a query to get all unique values of "department" from the employee table?
select distinct(department) from dbo.emp_details;

--Query to check the total records present in the table
select count(*) as ttl_records from dbo.emp_details;

--write down the query to first letter of a Name in Upper Case and all other letter in Lower case

--Write down the query to display all employee name in one cell seperated by ',' ex: "Vikas, nikita, Ashish, Nikhil, anish" ***
select STRING_AGG(first_name, ', ') as first_name_1 from dbo.emp_details;

--write a query to get the lowest salary from employee table?
select min(salary) as lowest_salary from dbo.emp_details;

--write a query to get the highest salary from employee table?
select max(salary) as highest_salary from dbo.emp_details;

--write a query to get the highest salary from employee table?
select avg(salary) as avg_salary from dbo.emp_details;

--write a query to get the highest salary - lowset salary as diff_salary from employee table?
select (max(salary) - min (salary)) as diff_salary from dbo.emp_details;

--write a query to get the % of difference between highest salary and lowset salary  from employee table?
select round((max(salary) - min(salary)) / max(salary) * 100,2) from dbo.emp_details; 

--select first_name from the employee table after removing white spaces from right side
select rtrim(first_name) as fst_name from dbo.emp_details; 

--select first_name from the employee table after removing white spaces from left side
select ltrim(first_name) as fst_name from dbo.emp_details;

--select first_name from the employee table after removing white spaces from both left side and right side
select trim(first_name) as fst_name from dbo.emp_details; 

--Query to check no.of records present in a table where employees having 50k salary
select count(*) as no_of_records from dbo.emp_details where salary = 50000;

--find the most recently employee hired in each department  
select full_name,department from(
select *, row_number() over(partition by department order by joining_date desc)as rnk from dbo.emp_details) a where rnk = 1;

--Display first_name and gender as M/F (if male then M, if female then F)
select first_name,
       case when gender = 'Male' then 'M' else 'F'  end as gender_n 
       from dbo.emp_details; 

--Display first_name, salary, and a salary category (if salary is below 50,000 categorize as 'Low' between 50,000 and 60,000 as medium and above 60,000 as High
select first_name,salary,
       case when salary < 50000 then 'Low'
            when salary >=50000 and salary <= 60000 then 'Medium'
            else 'High' end as salary_category 
from dbo.emp_details; 

--Display first_name, department and department classification (if department is IT display Technical, if HR display Human Resources , if Finance display Accounting Otherwise display Other)
select first_name,department,
       case when department = 'IT' then 'Technincal'
            when department = 'HR' then 'Human Resources'
            when department = 'Finance' then 'Accounting'
            else 'Others' end as department_classification
from dbo.emp_details;

--Display first_name, salary, and eligibility for salary raise (if salary is less than 50,000 mark as 'Eligible for raise' otherwise 'Not eligible')
select first_name,salary,
       case when salary < 50000 then 'Eligible_for_raise' 
       else 'Not_eligible' end as salaray_raise_eligibility
from dbo.emp_details;

--Display first_name,joining_date and employement  status (If joining date is before '2022-01-01' mark as 'Experienced' other wise 'New Hire'
select first_name,joining_date,
       case when joining_date < '2022-01-01' then 'Expereinced'
       else 'New_Hire' end as employment_status 
from dbo.emp_details;

--Display first_name, salary, and bonus amount ( if salary is above 60000 add 10% bonus, if between 50000 and 60000 add 7% otherwise 5%)
select first_name,salary,
       case when salary >= 60000 then (salary * 0.1)
            when salary >= 50000 and salary < 60000 then (salary * 0.07)
            else (salary * 0.05) end as bonus_amount
from dbo.emp_details;

--Display first_name, salary and seniority level (if salary is greater than 60000 classify as 'Senior' between 50000 and 60000 as 'Mid-Level' below 50,000 as Junior
select first_name,salary,
       case when salary >= 60000 then 'Senior'
            when salary >= 50000 and salary < 60000 then 'Mid-Level'
            else 'Junior' end as senority_level
from dbo.emp_details;

--Display first_name, department,salalry and job level for IT employees (if department is IT and salary is greater than 55000 mark as senior IT employee other wise Others
select first_name,department, salary,
       case when salary > 55000 then 'Senior IT Employee'
       else 'Others' end as Job_level
from dbo.emp_details where department = 'IT'; 

--Display first_name, joining_date, and Joiner status (If employee joined after '2024-01-01' label as 'Recent Joiner' otherwise 'Long-Term Employee'
select first_name,joining_date,
       case when joining_date > '2024-01-01' then 'Recent Joiner'
       else 'Long-Term Employee' end as Joiner_status
from dbo.emp_details; 

--Display first_name, joining_date, leave entitlement (if joined before '2021-01-01' assign '10Days Leave' between '2021-01-01' and '2023-01-01'  assign '20days Leave' otherwise '25Days leve'
select first_name, joining_date,
       case when joining_date < '2021-01-01' then '10 Days Leave'
            when joining_date between '2021-01-01'  and '2023-01-01' then '20 Days Leave'
            else '25 Days Leave' end as leave_entitlement 
from dbo.emp_details; 

--Display first_name,salary,department, and promotion eligibility (if salary is above 60000 and department is IT mark as 'Promotion Eligible' other wise 'Not Eligible'
select first_name, salary, department,
       case when salary > 60000 then 'Promotion Eligible' 
            else 'Not Eligible' end as promotion_eligibility
from dbo.emp_details where department = 'IT';

--Display first_name,salary and overtime pay eligibilty (if salary is below 50,000 mark as 'Eligible for Overtime Pay' otherwise 'Not Eligible'
select first_name,salary,
       case when salary < 50000 then 'Eligible for Overtime Pay' 
       else 'Not Eligible' end as 'Pay Eligibility' 
from dbo.emp_details; 
 
 --Display first_name, department, salary and job title( if department is 'HR' and salary is above 60,000 mark as HR executive if department is 'Finance' and salary is above 55000 mark as 'Finance Manager' other wise 'regular Employee'
select first_name,department,salary,
        case when department = 'HR' and salary > 60000 then 'HR Executive' 
             when department = 'Finance' and salary > 55000 then 'Finance Manager'
             else 'Regular Employee' end as Job_title
from dbo.emp_details;

--Display first_name,salary and Salary copmarison to the company average (if salary is above the company average salary marks as 'Above Average' otherwise 'Below Average'
select first_name,salary,
       case when salary > (select avg(salary) from dbo.emp_details) then 'Above Average'
       else 'Below Average' end as Salary_copmarison_to_the_company_average 
from dbo.emp_details;

--Write the query to get the department and department wise total(sum) salary, display it in ascending and descending order according to salary. 
select department, sum(salary) as ttl_salary from dbo.emp_details group by department order by ttl_salary; --asc order
select department, sum(salary) as ttl_salary from dbo.emp_details group by department order by ttl_salary desc;

--Write down the query to fetch Project name assign to more than one Employee
select project_name, count(emp_id_no) as empcount from dbo.project_details group by project_name having count(emp_id_no) >1;

--Write the query to get the department, total no. of departments, total(sum) salary  with respect to department from "employee table" table. 
select department, count(department) as deptcount, sum(salary) as ttlsalary from dbo.emp_details group by department;

--Get the department-wise salary details from the "employee table" table: 
   -- What is the average salary? (Order by salary ascending)
      select department, avg(salary) as avgsalary from dbo.emp_details group by department order by avgsalary; 
   --What is the maximum salary? (Order by salary ascending) 
      select department, max(salary) as maxsalary from dbo.emp_details group by department order by maxsalary; 

--Display department-wise employee count and categorize based on size. (If a department has more than 5 employees, label it as 'Large'; between 3 and 5 as 'Medium'; otherwise,'Small')
select department, count(emp_id) as empcount,
        case when count(emp_id) > 5 then 'Large'
             when count(emp_id) between 3 and 5 then 'Medium'
             else 'Small' end as emp_category
from  dbo.emp_details group by department;

--Display department-wise average salary and classify pay levels. (If the average salary in a department is above 60,000, label it as 'High Pay'; between 50,000 and 60,000 as 'Medium Pay'; otherwise, 'Low Pay').
select department, avg(salary) as avgslaary,
       case when avg(salary) > 60000 then 'High Pay'
            when avg(salary) between 50000 and 60000 then 'Medium Pay'
            else 'Low Pay' end as salary_category
from dbo.emp_details group by department; 

--Display department, gender, and count of employees in each category. (Group by department and gender, showing total employees in each combination)
select department,gender, count(emp_id) as empcount from dbo.emp_details group by department,gender order by department;

--Display the number of employees who joined each year and categorize hiring trends. (If a year had more than 5 hires, mark as 'High Hiring'; 3 to 5 as 'Moderate Hiring'; otherwise,'Low Hiring') 
select year(joining_date) as joining_year, count(emp_id) as  empcount,
       case when count(emp_id) > 5 then 'High Hiring'
            when count(emp_id) between 3 and 5 then 'Moderate Hiring'
            else 'Low Hiring' end as Hiring_category
from dbo.emp_details group by year(joining_date);

--Display department-wise highest salary and classify senior roles. (If the highest salary in a department is above 70,000, label as 'Senior Leadership'; otherwise, 'Mid-Level')
select department, sum(salary) as ttlsalary, 
       case when sum(salary) > 70000 then 'Senior Leadership'
       else 'Mid-Level' end as salary_group
from dbo.emp_details group by department;

--Display department-wise count of employees earning more than 60,000. (Group employees by department and count those earning above 60,000, labeling departments with more than 2 such employees as 'High-Paying Team')
select department, count(emp_id) as empcount, sum(salary) as ttlsalary, 
       case when sum(salary) > 60000 then 'High-Paying Team'
       end as paying_category
from dbo.emp_details group by department having count(emp_id) > 2 ;

--Query to extract the below things from joining_date column. 
  --(Year, Month, Day, Current Date) 
  select year(joining_date) as year, month(joining_date) as month, day(joining_date) as day, getdate()
  from dbo.emp_details ;

--Create two new columns that calculate the difference between joining_date and the  current date. One column should show the difference in months, and the other should  show the difference in days?
select datediff(month, joining_date, getdate()) as no_of_months_diff,
       datediff(day, joining_date, getdate()) as no_of_days_diff
from dbo.emp_details;

--Get all employee details from the employee table whose joining year is 2020.
select * from dbo.emp_details where year(joining_date) = 2020;

--Get all employee details from the employee table whose joining month is Feb
select * from dbo.emp_details where month(joining_date) = 2;

--Get all employee details from employee table whose joining date between "2021-01-01"  and "2021-12-01"
select * from dbo.emp_details where joining_date between '2021-01-01'  and '2021-12-01';

--Get the employee name and project name from the "employee table" and  "ProjectDetail" for employees who have been assigned a project, sorted by first name.
select e.full_name,p.project_name 
from dbo.emp_details e inner join dbo.project_details p 
on e.emp_id = p.emp_id_no 
order by first_name;

--Get the employee name and project name from the "employee table" and  "ProjectDetail" for employees who have been not assigned a project, sorted by first name.
select e.full_name,p.project_name --,p.project_id
from dbo.emp_details e left join dbo.project_details p 
on e.emp_id = p.emp_id_no
where project_name is null 
order by first_name; 

--Get the employee name and project name from the "employee table" and  "ProjectDetail" for all If employee has not assigned a project, display "No Project Assigned",sorted by first name.
select e.full_name,
case when p.project_name is null then 'No Project Assigned'
else p.project_name end as project_name
from emp_details e left join project_details p 
on e.emp_id = p.emp_id_no 
order by first_name; 

-- Get all project names from the "Project Details" table, even if they are not linked to any employee, sorted by first name from the "employee table" and  "ProjectDetail"
select p.project_name,e.full_name 
from dbo.project_details p left join dbo.emp_details e 
on p.emp_id_no = e.emp_id
order by first_name; 

--Find project names from the "Project Details" table, that not have been assigned to any employee, from the "employee table" and  "ProjectDetail"
select p.project_name from 
project_details p left join emp_details e
on p.emp_id_no = e.emp_id 
where e.full_name is null;

--Get the employee name for employee names who are assigned to more than one project
select e.full_name,count(p.project_name) as projcount
from emp_details e inner join project_details p 
on e.emp_id = p.emp_id_no
group by e.full_name
having count(p.project_name) >1 

--Get the project name and the employee names of employees working on projects that have more than one employee assigned.
select p.project_name,count(e.full_name) as empcount
from project_details p inner join emp_details e 
on p.emp_id_no = e.emp_id 
group by p.project_name
having count(e.full_name) > 1

--Assign row number to each employee within their department based on salary in descending order
select full_name,department, row_number() over(partition by department order by salary desc) as rownumber
from dbo.emp_details;

--Rank employees with in each department based on salary using rank
select department,full_name, rank() over(partition by department order by salary desc) as emprank
from dbo.emp_details;

----Rank employees with in each department based on salary using rank 
select department,full_name, dense_rank() over(partition by department order by salary desc) as emprnk 
from dbo.emp_details; 

--Find the highest paid employee in each department using rank
with cte as(
select department,full_name, rank() over(partition by department order by salary desc) as emprnk
from dbo.emp_details) 
select * from cte where emprnk = 1

--Find the second highest paid employee in each department using rank 
with cte as(
select department,full_name,rank() over(partition by department order by salary desc) as emprnk
from dbo.emp_details)
select * from cte where emprnk = 2 

--Rank employees based on their years of experience with in each department

select department,full_name, rank() over(partition by department order by datediff(year,joining_date,getdate()) desc) as exprank
from dbo.emp_details

--Find the employee with the earliest join date in each department using RNK()
with cte as(
select department,full_name, rank() over(partition by department order by min(joining_date)) as earliestjoindaternk 
from dbo.emp_details  group by department,full_name) 
select * from cte where earliestjoindaternk  = 1

--Find the employees who earn more than the average salary of their department.
with cte as 
(select emp_id,full_name,department,salary,
row_number() over(partition by department order by salary desc) as rnk, avg(salary) over(partition by department) as avg_salary
from dbo.emp_details as emp where salary > (
select  avg(salary) from dbo.emp_details where department = emp.department)
) select full_name,department,salary,avg_salary from cte where rnk = 1 

--Rank each employees within each job title in every departmnet based on salary
select full_name,job_title,department,salary, 
row_number() over(partition by job_title, department order by salary desc) as rnk 
from dbo.emp_details;

--Find the top 3 highest paid employees in each department
with cte as (
select full_name,department,salary,
row_number() over(partition by department order by salary desc) as rnk 
from dbo.emp_details)
select full_name,department,salary from cte where rnk <= 3;

--Find the employees who belongs to the top 10% earners within their department using PECENT_Rank()?
with cte as (
select full_name,department,salary,
percent_rank() over(partition by department order by salary desc) as pct_rnk 
from dbo.emp_details) 
select full_name,department,salary from cte where pct_rnk < 0.1;

--Assigne row numbers to employees based on their joining year using PARTITION BY YERA(Join_date)?
select full_name,year(joining_date), 
row_number() over(partition by year(joining_date) order by full_name) as rnk from dbo.emp_details;

--Rank the employees based on the number of projects handled within each department?
select full_name,department,count(project_id) as proj_count, 
row_number() over(partition by department order by count(project_id) desc) as rnk from 
(select e.full_name,e.emp_id,e.department,p.project_id,p.project_name 
from dbo.emp_details e join dbo.project_details p 
on e.emp_id = p.emp_id_no ) a group by full_name,department -- as a group by full_name; 

--Find the employees who are the only ones in their department(department with only one employee)
select department,count(full_name) as cnt from dbo.emp_details group by department having count(full_name) =1 ;

--Find the highest paid employees in each job role within department
with cte as(
select full_name,job_title,department,salary,
row_number() over(partition by job_title,department order by salary desc) as rnk 
from dbo.emp_details) 
select * from cte where rnk = 1;

--FInd the employees who have been working in the company the longest in each department.
with cte as(
select full_name,department,datediff(day,joining_date,getdate()) as no_of_days_diff,
row_number() over(partition by department order by datediff(day,joining_date,getdate()) desc) as rnk 
from dbo.emp_details) 
select full_name,department,no_of_days_diff from cte where rnk = 1
