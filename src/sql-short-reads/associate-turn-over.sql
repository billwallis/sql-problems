/* https://sqlshortreads.com/sql-practice-problems/hard/ */


/* Sample output */
with sample(
    employee_id,
    first_name,
    last_name,
    hire_date,
    job_title,
    salary,
    min_salary,
    max_salary,
    new_salary,
    percent_increase
) as (
              select '132', 'TJ', 'Olson', '10-Apr-07', 'Stock Clerk', '2100', '2008', '5000', '3504', '66.85714286' from dual
    union all select '107', 'Diana', 'Lorentz', '7-Feb-07', 'Programmer', '4200', '4000', '10000', '7000', '66.66666667' from dual
    union all select '191', 'Randall', 'Perkins', '19-Dec-07', 'Shipping Clerk', '2500', '2500', '5500', '4000', '60' from dual
    union all select '182', 'Martha', 'Sullivan', '21-Jun-07', 'Shipping Clerk', '2500', '2500', '5500', '4000', '60' from dual
    union all select '119', 'Karen', 'Colmenares', '10-Aug-07', 'Purchasing Clerk', '2500', '2500', '5500', '4000', '60' from dual
    union all select '128', 'Steven', 'Markle', '8-Mar-08', 'Stock Clerk', '2200', '2008', '5000', '3504', '59.27272727' from dual
    union all select '136', 'Hazel', 'Philtanker', '6-Feb-08', 'Stock Clerk', '2200', '2008', '5000', '3504', '59.27272727' from dual
    union all select '198', 'Donald', 'OConnell', '21-Jun-07', 'Shipping Clerk', '2600', '2500', '5500', '4000', '53.84615385' from dual
    union all select '199', 'Douglas', 'Grant', '13-Jan-08', 'Shipping Clerk', '2600', '2500', '5500', '4000', '53.84615385' from dual
    union all select '118', 'Guy', 'Himuro', '15-Nov-06', 'Purchasing Clerk', '2600', '2500', '5500', '4000', '53.84615385' from dual
)

select *
from sample
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
There is some ambiguity in the requirements:

> The new salary should be the salary required to bring the employee's
> salary to the midpoint value for the job.

This, to me, is the difference between the employee's current salary
and the midpoint value for the job. However, the "new salary" is
actually just the midpoint value for the job.

A clearer requirement (for me) would have been:

> The new salary should be the midpoint salary value for the job.


This is absolutely **not** a hard question.
*/


/* Solution */
select
    employees.employee_id,
    employees.first_name,
    employees.last_name,
    employees.hire_date,
    jobs.job_title,
    employees.salary,
    jobs.min_salary,
    jobs.max_salary,
--     ((jobs.max_salary + jobs.min_salary) / 2) - employees.salary as new_salary,
    (jobs.max_salary + jobs.min_salary) / 2 as new_salary,
    100.0 * (((jobs.max_salary + jobs.min_salary) / 2) - employees.salary) / salary as percent_increase
from employees
    left join jobs using (job_id)
where employees.salary < (jobs.max_salary + jobs.min_salary) / 2
order by percent_increase desc
;
