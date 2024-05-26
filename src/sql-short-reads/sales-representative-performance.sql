/* https://sqlshortreads.com/sql-practice-problems/hard/ */


/* Sample output */
with sample(
    sales_rep_id,
    order_year,
    order_count
) as (
              select '156', '2007', '2' from dual
    union all select '155', '2007', '3' from dual
    union all select '158', '2007', '3' from dual
    union all select '153', '2007', '5' from dual
    union all select '160', '2007', '5' from dual
    union all select '163', '2007', '6' from dual
    union all select '159', '2007', '7' from dual
    union all select '154', '2007', '8' from dual
    union all select '161', '2007', '8' from dual
    union all select '158', '2008', '1' from dual

)

select *
from sample
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
Another one that is **not** hard, and is _barely_ even medium.
*/


/* Solution */
select
    sales_rep_id,
    extract(year from cast(substr(orders.order_date, 1, 10) as date)) as order_year,  /* Just because mine is saved as text locally */
    count(*) as order_count
from orders
where 1=1
    and extract(year from cast(substr(orders.order_date, 1, 10) as date)) in (2007, 2008)
    and sales_rep_id is not null
group by
    sales_rep_id,
    extract(year from cast(substr(orders.order_date, 1, 10) as date))
order by
    order_year,
    order_count,
    sales_rep_id
;
