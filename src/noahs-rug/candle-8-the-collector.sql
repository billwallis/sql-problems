/* Solution */
with the_collector as (
    from orders
        inner join orders_items
            using (orderid)
        inner join products
            on  orders_items.sku = products.sku
            and products.sku like 'COL%'
    select
        customerid,
        count(*) as order_count
    group by customerid
    order by order_count desc
    limit 1
)

select phone, customerid
from customers
    semi join the_collector
        using (customerid)
;
