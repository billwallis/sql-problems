/* https://sqlshortreads.com/sql-practice-problems/hard/ */


/* Sample output */
with sample(
    order_mode,
    order_year,
    mode_count,
    order_count,
    percent_of_total
) as (
              select 'online', '2006', '2', '16', '12.5' from dual
    union all select 'online', '2007', '20', '69', '28.99' from dual
    union all select 'online', '2008', '10', '19', '52.63' from dual
)

select *
from sample
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
This is another one where the recommended solution is overcomplicated;
they have two CTEs with a join. The below is a single CTE with no joins.

The recommended solution is also missing the orders for 2004.

This is **not** a hard question.
*/


/* Solution */
with agg as (
    select
        extract(year from cast(substr(orders.order_date, 1, 10) as date)) as order_year,  /* Just because mine is saved as text locally */
        sum(case when order_mode = 'online' then 1 else 0 end) as mode_count,
        count(*) as order_count
    from orders
    group by extract(year from cast(substr(orders.order_date, 1, 10) as date))
)

select
    'online' as order_mode,
    order_year,
    mode_count,
    order_count,
    round(100.0 * mode_count / order_count, 2) as percent_of_total
from agg
order by order_year
;
