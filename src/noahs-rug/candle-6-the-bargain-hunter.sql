/* Solution */
with bargain_hunter as (
    from (
        select
            any_value(orders.customerid) as customerid,
            (
                any_value(orders.total)
                < sum(orders_items.qty * products.wholesale_cost)
            ) as below_cost_flag,
        from orders
            inner join orders_items
                using (orderid)
            inner join products
                using (sku)
        group by orders.orderid
    )
    select customerid
    group by customerid
    order by count(*) filter (below_cost_flag) desc
    limit 1
)

select phone, customerid
from customers
    semi join bargain_hunter
        using (customerid)
;
