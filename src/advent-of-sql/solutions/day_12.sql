use day_12;

/* gifts */
from gifts;

/* gift_requests */
from gift_requests;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
from (
    select
        gift_id,
        percent_rank() over (order by count(*)) as percentile,
    from gift_requests
    group by gift_id
) left join gifts using (gift_id)

select
    gift_name,
    round(percentile, 2),
qualify 2 = dense_rank() over (order by percentile desc)
order by percentile desc, gift_name
limit 1
;
