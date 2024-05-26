/* https://sqlshortreads.com/sql-practice-problems/hard/ */


/* Sample output */
with sample(
    mentor_id,
    mentor_job_id,
    mentor_hire_date,
    mentee_id,
    mentee_job_id,
    mentee_hire_date
) as (
              select '102', 'AD_VP', '13-JAN-01', '101', 'AD_VP', '21-SEP-05' from dual
    union all select '109', 'FI_ACCOUNT', '16-AUG-02', '113', 'FI_ACCOUNT', '07-DEC-07' from dual
    union all select '105', 'IT_PROG', '25-JUN-05', '104', 'IT_PROG', '21-MAY-07' from dual
    union all select '115', 'PU_CLERK', '18-MAY-03', '119', 'PU_CLERK', '10-AUG-07' from dual
    union all select '145', 'SA_MAN', '01-OCT-04', '149', 'SA_MAN', '29-JAN-08' from dual
    union all select '156', 'SA_REP', '30-JAN-04', '167', 'SA_REP', '21-APR-08' from dual
    union all select '184', 'SH_CLERK', '27-JAN-04', '183', 'SH_CLERK', '03-FEB-08' from dual
    union all select '137', 'ST_CLERK', '14-JUL-03', '128', 'ST_CLERK', '08-MAR-08' from dual
    union all select '122', 'ST_MAN', '01-MAY-03', '124', 'ST_MAN', '16-NOV-07' from dual
)

select *
from sample
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
The recommended solution is, IMO, overcomplicated; their two CTEs can be
collapsed into a single CTE, as below.

This is _barely_ a hard question.
*/


/* Solution */
with mentor_mentee as (
    select
        employee_id,
        hire_date,
        job_id,
        row_number() over (partition by job_id order by hire_date) as mentor_flag,
        row_number() over (partition by job_id order by hire_date desc) as mentee_flag,
        count(*) over (partition by job_id) as employees_per_job
    from employees
)

select
    mentor.employee_id as mentor_id,
    mentor.job_id as mentor_job_id,
    mentor.hire_date as mentor_hire_date,
    mentee.employee_id as mentee_id,
    mentee.job_id as mentee_job_id,
    mentee.hire_date as mentee_hire_date
from mentor_mentee mentor
    inner join mentor_mentee mentee
        on  mentor.job_id = mentee.job_id
        and mentee.mentee_flag = 1
where 1=1
    and mentor.employees_per_job >= 2
    and mentor.mentor_flag = 1
order by mentor_job_id
;
