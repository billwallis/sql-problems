/* Solution */
select phone, customerid
from customers
    natural semi join (
        select orders.customerid
        from orders
            inner join orders_items
                using (orderid)
            inner join products
                using (sku)
        where 1=1
            and orders.ordered::time <= '05:00:00'::time
            and orders_items.qty > 1
            and products.desc ilike '%bagel%'
    )
;
