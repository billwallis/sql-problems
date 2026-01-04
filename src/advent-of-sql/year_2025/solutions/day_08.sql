use day_08;

/* Products */
from products;

/* Price changes */
from price_changes;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with product_changes as (
    select
        product_id,
        price as current_price,
        lead(price) over product_by_time as previous_price,
    from price_changes
    window product_by_time as (
        partition by product_id
        order by effective_timestamp desc
    )
    qualify 1 = row_number() over product_by_time
)

select
    products.product_name,
    product_changes.current_price,
    product_changes.previous_price,
    (0
        + product_changes.current_price
        - product_changes.previous_price
    ) as price_change,
from product_changes
    inner join products
        using (product_id)
order by products.product_name
;
