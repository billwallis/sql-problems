/* Solution */
with

the_bargain_hunter as (
    from customers
    -- where customerid = 4167  /* from candle 6 */
    where customerid = 8884  /* speedrun */
),

orders_with_items as (
    from (
        select
            orders.orderid,
            orders.customerid,
            orders.ordered,
            products.desc,
            products.desc.regexp_extract(
                '([A-Za-z ]+) \(([A-Za-z ]+)\)',
                ['name', 'colour']
            ) as item,
        from orders
            inner join orders_items
                using (orderid)
            inner join products
                using (sku)
    )
    where item.name != ''
),

the_meet_cute as (
    select meet_cute.customerid
    from orders_with_items as bargain_hunter
        inner join orders_with_items as meet_cute
            on  bargain_hunter.orderid != meet_cute.orderid
            and meet_cute.ordered between bargain_hunter.ordered - interval '10 minutes'
                                      and bargain_hunter.ordered + interval '10 minutes'
    where 1=1
        and bargain_hunter.customerid = (
            select customerid
            from the_bargain_hunter
        )
        and bargain_hunter.item.name = meet_cute.item.name
        and bargain_hunter.item.colour != meet_cute.item.colour
)

select phone, customerid
from customers
    semi join the_meet_cute
        using (customerid)
;
