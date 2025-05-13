-- 1. Compare avg salary with each employee’s salary .
use gfg;
select * from sample_data;

select *,(select round(avg(salary),2)
           from  sample_data) as avg_salary
from sample_data;
-- or 
select *, avg(salary) over() 
from sample_data;

-- 2. Compare avg salary of each country with each of its employee.

select *, avg(salary) over(partition by country) 'avg_Salary_by_country'
from sample_Data;


-- 3. Show each employee’s name, salary , department and the total salary of their department.

select *, sum(salary) over(partition by department) 'total_Salary_by_department'
from sample_Data;


-- 4. Count the number of employees in each department with the whole data.

select *, count(*) over(partition by department) 'total_employee'
from sample_Data;

-- 5. Display the minimum salary and maximum salary in each department alongside each employee details.
select *, min(salary) over(partition by department) 'min_salary'
from sample_Data;

select *, max(salary) over(partition by department) 'max_salary'
from sample_Data;

-- 6. Assign a unique number to employees within each department, ordered by salary.
select * , row_number() over(partition by department) 
from sample_data;

-- 6. Rank employees within each department by their age
select * , row_number() over(partition by department order by age) 
from sample_data;

-- 7. Assign dense ranks to employees within each department by their salary.
select * , row_number() over(partition by department order by age) 
from sample_data;

-- 8. Divide employees into 2 buckets (groups) within each department based on their salary.
with cte as (
select *, ntile(2) over (partition by department order by salary desc) as salary_bucket
from sample_data)
select * ,
case
    when salary_bucket=1 then 'high salary'
    when salary_bucket=2 then 'low salary'
end as salary_group 
from cte;

-- 9. Determine each employee's salary and identify the salary of the employee earning just below them.
select *, lead(salary) over() as salary_below
from sample_data;

-- 10. Determine each employee's salary and identify the salary of the employee earning just above them.
select *, lag(salary) over() as salary_below
from sample_data;

-- 11. Display the smallest salary in each department.
select department , min(salary)
from sample_data
group by department;

select * , min(salary) over(partition by department) as min_salary
from sample_data;

-- 12. Displays the highest salary in each department.
select * , max(salary) over(partition by department) as min_salary
from sample_data;

-- 13. What is the sum salary of all employees in each department and salaries should be in increasing order within department?
use gfg;
select department, sum(salary) as total_salary
from sample_data
group by department
order by total_salary;

select * , sum(salary) over(partition by department ) as total_salary
from sample_data
order by total_salary;

-- 14. What is the cumulative salary (running total) of employees in each department?
select * , sum(salary) over(partition by department order by salary) as total_salary
from sample_data;

-- 15. What is the forward-looking cumulative salary for employees in each department?
select * , sum(salary) over(partition by department order by salary desc ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as forward_cumulative_salary
from sample_data;

-- 16. What is the average salary of employees within a 1-row range (1 preceding and 1 following) for each department?
select * , avg(salary) over(ROWS BETWEEN 1 preceding AND 1 FOLLOWING) as avg_salary
from sample_data;

-- 17. Find the Next Highest Salary for Each Employee in Each Department
select * , lead(salary) over(partition by department order by salary ) as next_highest_salary
from sample_data;

-- 18. Calculate a cumulative salary sum by department and country
select * , sum(salary) over(partition by department,country order by salary  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) as cumulative_salary
from sample_data;

-- 19. Calculate the percentage of total salary contributed by each employee in their department
select *, round((salary/(sum(salary) over(partition by department)))*100,2) as percentage_contribution
from sample_data;


-- 20. Identify the oldest employee in each department
select * , max(age) over(partition by department) 
from sample_data;

-- 21. Identify employees whose salaries are greater than the average salary of all employees in their country
select * 
from sample_data s1
where salary >
(select avg(salary)
from sample_data s2
group by country
having s1.country=s2.country
);

-- 22. Find the second highest salary in each department

WITH RankedSalaries AS (SELECT *,
						ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
                        FROM sample_data)
SELECT id, name, age, salary, department, country
FROM RankedSalaries
WHERE salary_rank = 2;

-- 23. Calculate the difference between the current and previous employee's salary (ordered by salary) in each department

select *,salary-lag(salary) over(order by salary) as salary_difference
from sample_data;

-- 23. Identify employees whose salaries are in the top 3 within their country
with cte as(
select *, row_number() over(partition by country order by salary desc) as row_num
from sample_data
)
select * from cte
where row_num in(1,2,3);
-- or
select * from 
(
select *, row_number() over(partition by country order by salary desc) as row_num
from sample_data
) ranked
where row_num<=3;

-- 24. Find the ratio of each employee's salary to the highest salary in their department
select *,salary, salary/ max(salary) over(partition by department) as salary_ratio
from sample_Data;

-- 25. Find the employee with the highest salary in each department, but include ties
use gfg;
select * from
(select *, rank() over(partition by department order by salary desc) as ranks
from sample_data) as table_1
where ranks=1;

-- 26. Identify employees whose salaries are in the top 50% within their department
select * from
(select *, ntile(2) over(partition by department order by salary desc) row_new
from sample_data) table1
where row_new=1;

-- or

with cte as (
select *, row_number() over(partition by department order by salary desc) as salary_rank,
count(*) over(partition by department)  total_employee
from sample_data)
select * from cte
where salary_rank<=total_employee/2;


-- 27. Identify employees whose salaries are in the top 10%
use gfg;

select * from
(select *, ntile(10) over(order by salary desc) row_new
from sample_data) table1
where row_new=1;

-- or

with cte as (
select *, row_number() over(order by salary desc) as salary_rank,
count(*) over() as total
from sample_data)
select * from cte
where salary_rank<=total*0.10;