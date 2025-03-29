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
            and year(orders.ordered) = 2017
            and products.desc ilike '%coffee%'
            -- and products.desc ilike '%bagel%'
    )
-- where name like 'J% P%'
where name like 'D% S%'  /* speedrun */
;
