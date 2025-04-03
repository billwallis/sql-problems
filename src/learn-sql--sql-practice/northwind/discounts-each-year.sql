/* https://www.sql-practice.com/ */

/* Solution */
select
    year(orders.order_date) as order_year,
    round(sum(order_details.quantity * products.unit_price * order_details.discount), 2) as discount_amount
from orders
    inner join order_details
        using (order_id)
    inner join products
        using (product_id)
group by order_year
order by order_year desc
;
