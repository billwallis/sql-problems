/* https://sqlshortreads.com/sql-practice-problems/hard/ */


/* Sample output */
with sample(
    customer_id,
    order_id,
    order_date,
    line_item_id,
    unit_price,
    quantity,
    line_item_total,
    order_total
) as (
              select '119', '2372', '27-FEB-07 12.22.33.356789 AM', '1', '48', '6', '288', '16447.2' from dual
    union all select '119', '2372', '27-FEB-07 12.22.33.356789 AM', '2', '74', '2', '148', '16447.2' from dual
    union all select '119', '2372', '27-FEB-07 12.22.33.356789 AM', '3', '42', '7', '294', '16447.2' from dual
    union all select '119', '2372', '27-FEB-07 12.22.33.356789 AM', '4', '81', '10', '810', '16447.2' from dual
    union all select '119', '2372', '27-FEB-07 12.22.33.356789 AM', '5', '496', '13', '6448', '16447.2' from dual
    union all select '119', '2372', '27-FEB-07 12.22.33.356789 AM', '6', '17', '17', '289', '16447.2' from dual
    union all select '119', '2372', '27-FEB-07 12.22.33.356789 AM', '7', '15', '21', '315', '16447.2' from dual
    union all select '119', '2372', '27-FEB-07 12.22.33.356789 AM', '8', '30', '30', '900', '16447.2' from dual
    union all select '119', '2372', '27-FEB-07 12.22.33.356789 AM', '9', '54', '32', '1728', '16447.2' from dual
    union all select '119', '2372', '27-FEB-07 12.22.33.356789 AM', '10', '145.2', '36', '5227.2', '16447.2' from dual
)

select *
from sample
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
This is **not** a hard question at all.
*/


/* Solution */
with customer_orders as (
    select
        order_id,
        order_date,
        order_total,
        customer_id,
        count(*) over (partition by customer_id) as customer_order_count
    from orders
)

select
    customer_orders.customer_id,
    order_id,
    customer_orders.order_date,
    order_items.line_item_id,
    order_items.unit_price,
    order_items.quantity,
    order_items.unit_price * order_items.quantity as line_item_total,
    customer_orders.order_total
from customer_orders
    left join order_items using (order_id)
where customer_orders.customer_order_count = 1
order by
    customer_orders.customer_id,
    order_items.line_item_id
;
