use day_19;

/* employees */
from employees;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
from (
    from employees
    select
        salary,
        year_end_performance_scores[-1] as last_perf,
        if(last_perf > avg(last_perf) over (), 0.15 * salary, 0) as bonus,
)
select sum(salary + bonus)
;
