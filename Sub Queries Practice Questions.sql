use gfg;
select * from restaurants;
--  SINGLE ROW SUB QUERY------>
-- 1. Find the name of rest. with the highest cost.
select * from restaurants
where cost=(select max(cost) from restaurants);
-- 2. Find the country where the highest-paid employee works.
select city from restaurants
where cost=(select max(cost) from restaurants);

-- 3. Find the details of employees earning more than the average salary of the entire company.
select * from restaurants
where cost>(select avg(cost) from restaurants);
-- 4. List the names of employees who are in the same department as the employee named ‘Person 6”.
select * from sample_data
where department=(select department from sample_data
                   where Name='Person_6');



-- 5. Find the name and department of the employee with the second-highest salary.
select name,department
from sample_data
order by salary
limit 1,1;


-- 6. Find the name of the employee who is the oldest and earning above average salary.
select * from sample_data
where age=(select max(age) 
            from sample_data 
            where salary>(select avg(salary) from sample_data));

-- 7. Find employees who are in the same department as the youngest employee.(Multi row subqueries)
select * 
from sample_data
where department in(select department
                   from sample_data
                   where age=(select min(age) from sample_data));
                     
--  MULTI ROW SUB QUERY------>
-- 1.Find employees whose age matches the ages of employees in the 'HR' department.
select * from sample_data
where age in (select age from sample_data
               where department='hr');
                     
-- 2. Find employees who belong to departments which has average salary greater than $75,000.
select * from sample_data
where department in (select department from sample_Data
                        group by department
                   having avg(salary)>75000);


-- 3. List employees working in departments with fewer than 10 employees.
select * from sample_data 
where department in (select department 
from sample_data
group by department
having count(*)<10);


--  SCALER SUB QUERIES------>
-- 1. Displays each employee's name along with the average salary of all employees.
select *, (select avg(salary) from sample_data) from sample_data; 

-- 2. Display each employee’s salary as a percentage of the company's total salary expense.
select *,(salary/(select sum(salary) from sample_data))*100 as percentage 
from sample_Data;


-- 3. Display each employee’s salary and compare(maximum salary - person’s salary ) it to the company’s maximum salary.
select *,(select max(salary) from sample_data)-salary as comparison
from sample_Data;

-- Display each employee’s salary as a percentage of their department's total salary expense.
select *,salary/(select max(salary) from sample_Data s2 
                  group by department
                  having s1.department=s2.department)*100 as percentage
from sample_data s1;


--  CORRELATED SUB QUERIES------>
-- 1. Find the maximum earning employee in each department
select * from sample_data s1
where salary=(select max(salary) from sample_data s2 group by department 
                 having s1.department=s2.department);


-- 2. Find the employees whose salary is higher than the average salary in their department.
select * from sample_data s1
where salary>(select avg(salary) from sample_data s2 group by department 
                 having s1.department=s2.department);

-- 3. Identify employees who are older than the average age of employees in their country.
select * from sample_data s1
where age>(select avg(age) from sample_data s2 group by country 
                 having s1.country=s2.country);
-- 4. Find the youngest employee in each department
select * from sample_data s1
where age=(select min(age) from sample_data s2 group by department 
                 having s1.department=s2.department);


-- 5. Most expensive department in a particular country
select * from sample_data s1
where salary=(select max(salary) from sample_data s2 group by department 
                 having s1.department=s2.department);