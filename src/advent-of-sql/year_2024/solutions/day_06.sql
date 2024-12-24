use day_06;

/* children */
from children;

/* gifts */
from gifts;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
from children
    inner join (
        select child_id, price
        from gifts
        qualify price > avg(price) over ()
    ) as over_avg_gifts
        using (child_id)
select children.name
order by over_avg_gifts.price
limit 1
;

/* Solution */
select children.name
from gifts left join children using (child_id)
qualify gifts.price > avg(gifts.price) over ()
order by gifts.price
limit 1
;
