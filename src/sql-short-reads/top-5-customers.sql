/* https://sqlshortreads.com/sql-practice-problems/hard/ */


/* Sample output */
with sample(
    customer_id,
    customer_name,
    order_total,
    order_total_sequence
) as (
              select '148', 'Steenburgen, Gustav', '144054.8', '1' from dual
    union all select '101', 'Welles, Constantin', '82445.6', '2' from dual
    union all select '144', 'Landis, Sivaji', '71173', '3' from dual
    union all select '149', 'Rampling, Markus', '60065', '4' from dual
    union all select '104', 'Sutherland, Harrison', '46257', '5' from dual
)

select *
from sample
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
The recommended solution joins before aggregating, which is typically a
bad idea for performance.

This is **not** a hard question.
*/

/* Solution */
with top_customers as (
    select
        customer_id,
        sum(order_total) as order_total,
        dense_rank() over (order by sum(order_total) desc) as customer_rank
    from orders
    where extract(year from cast(substr(orders.order_date, 1, 10) as date)) = 2008 /* Just because mine is saved as text locally */
    group by customer_id
)

select
    customer_id,
    customers.cust_last_name || ', ' || customers.cust_first_name as customer_name,
    top_customers.order_total,
    top_customers.customer_rank as order_total_sequence
from top_customers
    inner join customers using (customer_id)
where top_customers.customer_rank <= 5
order by top_customers.order_total desc
;
