/* https://sqlshortreads.com/sql-practice-problems/hard/ */


/* Sample output */
with sample(
    employee_id,
    employee_name,
    job_title,
    hire_date,
    employment_duration,
    salary,
    inconsistency_flag,
    salary_sequence_desc
) as (
              select '206', 'Gietz, William', 'Public Accountant', '07-JUN-02', '20.93', '8300', '1', '1' from dual
    union all select '205', 'Higgins, Shelley', 'Accounting Manager', '07-JUN-02', '20.93', '12008', '1', '1' from dual
    union all select '200', 'Whalen, Jennifer', 'Administration Assistant', '17-SEP-03', '19.65', '4400', '1', '1' from dual
    union all select '100', 'King, Steven', 'President', '17-JUN-03', '19.9', '24000', '1', '1' from dual
    union all select '102', 'De Haan, Lex', 'Administration Vice President', '13-JAN-01', '22.33', '17000', '1', '1' from dual
    union all select '101', 'Kochhar, Neena', 'Administration Vice President', '21-SEP-05', '17.64', '17000', '1', '1' from dual
    union all select '109', 'Faviet, Daniel', 'Accountant', '16-AUG-02', '20.74', '9000', '1', '1' from dual
    union all select '110', 'Chen, John', 'Accountant', '28-SEP-05', '17.62', '8200', '1', '2' from dual
    union all select '111', 'Sciarra, Ismael', 'Accountant', '30-SEP-05', '17.62', '7700', '0', '4' from dual
    union all select '112', 'Urman, Jose Manuel', 'Accountant', '07-MAR-06', '17.18', '7800', '1', '3' from dual
)

select *
from sample
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
This is a good question: it requires you think analytically rather than
just technically.

My approach flags the employees exactly inversely to the recommended
solution, so I'll claim that it's still correct ;)

I flag employees that are paid less than they should be, whereas the
recommended solution flags employees that are paid more than they should
be.

However, the recommended solution flags employees that are the only ones
in their jobs, which I think are false-positives.
*/


/* Solution */
with employment_duration as (
    select
        job_id,

        employees.employee_id,
        employees.last_name || ', ' || employees.first_name as employee_name,
        employees.hire_date,
        employees.salary,
        jobs.job_title,
        max(employees.hire_date) over (partition by job_id) - employees.hire_date as employment_duration
    from employees
        left join jobs using (job_id)
)

select
    employee_id,
    employee_name,
    job_title,
    hire_date,
    employment_duration,
    salary,
    case when salary >= lag(salary, 1, 0) over (partition by job_id order by employment_duration)
        then 0
        else 1
    end as inconsistency_flag
from employment_duration
order by job_id, employment_duration desc
;
