/* https://quip.com/2gwZArKuWk7W */

/* Sample data */
create or replace table salaries (
    depname text,
    empno int,
    salary int,
);
insert into salaries
values
    ('develop',   11, 5200),
    ('develop',   7,  4200),
    ('develop',   9,  4500),
    ('develop',   8,  6000),
    ('develop',   10, 5200),
    ('personnel', 5,  3500),
    ('personnel', 2,  3900),
    ('sales',     3,  4800),
    ('sales',     1,  5000),
    ('sales',     4,  4800),
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution (part 1) */
select
    *,
    round(avg(salary) over (partition by depname)) as avg_salary,
from salaries
order by all
;

/* Solution (part 2) */
select
    *,
    rank() over (
        partition by depname
        order by salary desc
    ) as salary_rank,
from salaries
order by all
;
