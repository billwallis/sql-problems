use day_09;

/* Orders */
from orders;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select
    customer_id,
    id as order_id,
    created_at,
    (order_data->>'$.shipping.method')::text as shipping_method,
    (order_data->>'$.gift.wrapped')::bool as is_gift_wrapped,
    (order_data->>'$.risk.flag')::text as risk_flag,
from orders
qualify 1 = rank() over (
    partition by customer_id
    order by created_at desc
)
order by created_at desc
;
