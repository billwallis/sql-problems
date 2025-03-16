/* https://www.namastesql.com/coding-problem/76-amazon-notifications */

/* Sample data */
create table notifications (
    notification_id int,
    product_id      text,
    delivered_at    timestamp
);
insert into notifications
values
    (1, 'p1', '2024-01-01 08:00:00'),
    (2, 'p2', '2024-01-01 10:30:00'),
    (3, 'p3', '2024-01-01 11:30:00')
;

create table purchases (
    user_id            int,
    product_id         text,
    purchase_timestamp timestamp
);
insert into purchases
values
    (1, 'p1', '2024-01-01 09:00:00'),
    (2, 'p2', '2024-01-01 09:00:00'),
    (3, 'p2', '2024-01-01 09:30:00'),
    (3, 'p1', '2024-01-01 10:20:00')
;


/* Solution */
with notification_boundaries as (
    select
        notification_id,
        product_id,
        delivered_at,
        least(
            lead(delivered_at) over (order by notification_id),
            delivered_at + interval '2 hours'
        ) as upper_bound
    from notifications
)

select
    nb.notification_id,
    count(*) filter (where nb.product_id  = purchases.product_id) as same_product_purchases,
    count(*) filter (where nb.product_id != purchases.product_id) as diff_product_purchases
from notification_boundaries as nb
    left join purchases
        on purchases.purchase_timestamp between nb.delivered_at
                                            and nb.upper_bound
group by nb.notification_id
order by nb.notification_id
;
