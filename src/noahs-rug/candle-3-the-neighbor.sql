/* Solution */
with the_contractor as (
    from customers
    -- where customerid = 1475  /* from candle 2 */
    where customerid = 5745  /* speedrun */
)

select phone, customerid
from customers
    semi join the_contractor
        using (citystatezip)
    natural semi join (
        select orders.customerid
        from orders
            inner join orders_items
                using (orderid)
            inner join products
                using (sku)
    )
where 1=1
    -- /* Year of the Rabbit (2023, 2011, 1999, 1987, 1975, ...) */
    -- and birthdate.year() % 12 = 7
    -- /* Cancer (June 21 - July 22) */
    -- and case birthdate.month()
    --     when 6 then birthdate.day() >= 21
    --     when 7 then birthdate.day() <= 22
    -- end

    /* speedrun */
    /* Year of the Goat (1931, 1943, 1955, 1967, 1979, 1991, 2003, 2015, 2027, ...) */
    and birthdate.year() % 12 = 11
    /* Libra (September 23 - October 22) */
    and case birthdate.month()
        when  9 then birthdate.day() >= 23
        when 10 then birthdate.day() <= 22
    end
;
