/* Solution */
select any_value(phone) as phone, customers.customerid
from customers
    inner join orders
        using (customerid)
    inner join orders_items
        using (orderid)
    inner join products
        using (sku)
where 1=1
    -- and customers.citystatezip like 'Staten Island%'  /* commented out for speedrun */
    and products.desc like '%Senior Cat Food%'
group by customers.customerid
order by count(*) desc
limit 1
;
