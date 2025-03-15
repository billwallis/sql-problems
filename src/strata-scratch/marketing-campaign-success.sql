/* https://platform.stratascratch.com/coding/514-marketing-campaign-success-advanced */

/* Sample data */
create table marketing_campaign (
    user_id int,
    created_at date,
    product_id int,
    quantity int,
    price int
);
insert into marketing_campaign
values
    (10, '2019-01-01', 101, 3, 55),
    (10, '2019-01-02', 119, 5, 29),
    (10, '2019-03-31', 111, 2, 149),
    (25, '2019-01-22', 114, 2, 248),
    (25, '2019-01-22', 115, 2, 72),
    (25, '2019-01-24', 114, 5, 248),
    (25, '2019-01-27', 115, 1, 72)
;


/* Solution */
with first_day_products as (
    select distinct on (user_id)
        user_id,
        created_at,
        array_agg(product_id) as product_ids
    from marketing_campaign
    group by user_id, created_at
    order by user_id, created_at
)

select count(distinct user_id)
from first_day_products as o  /* outer */
where exists(
    select *
    from marketing_campaign as i  /* inner */
    where 1=1
        and o.user_id = i.user_id
        and o.created_at < i.created_at
        and i.product_id != all(o.product_ids)
);
