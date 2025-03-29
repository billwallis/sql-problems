/*
    https://8weeksqlchallenge.com/case-study-6/
*/
use clique_bait;

/*
    A. Enterprise Relationship Diagram

    Using the following DDL schema details to create an ERD for all the
    Clique Bait datasets.
*/

-- no, got tools for that


/*
    B. Digital Analysis

    Using the available datasets - answer the following questions using a
    single query for each one:

    1.  How many users are there?
    2.  How many cookies does each user have on average?
    3.  What is the unique number of visits by all users per month?
    4.  What is the number of events for each event type?
    5.  What is the percentage of visits which have a purchase event?
    6.  What is the percentage of visits which view the checkout page but do not have a purchase event?
    7.  What are the top 3 pages by number of views?
    8.  What is the number of views and cart adds for each product category?
    9.  What are the top 3 products by purchases?
*/

/* 1 */
select count(distinct user_id)
from users
;

/* 2 */
from (
    select count(*) as cookies
    from users
    group by user_id
)
select avg(cookies) as avg_cookies
;

/* 3 */
select
    date_trunc('month', event_time) as event_month,
    count(distinct visit_id) as visits,
from events
group by event_month
order by event_month
;

/* 4 */
select
    event_identifier.event_name,
    count(*) as events,
from events
    inner join event_identifier
        using (event_type)
group by event_identifier.event_name
order by event_identifier.event_name
;

/* 5 */
from (
    select
        visit_id,
        max(event_identifier.event_name = 'Purchase') as has_purchase_event,
    from events
        inner join event_identifier
            using (event_type)
    group by visit_id
)
select
    (100
        * count(*) filter (where has_purchase_event)
        / count(*)
    ) as purchase_event_percent
;

/* 6 */
from (
    select
        visit_id,
        max(event_identifier.event_name = 'Purchase') as has_purchase_event,
        max(1=1
            and event_identifier.event_name = 'Page View'
            and page_hierarchy.page_name = 'Checkout'
        ) as views_checkout_page,
    from events
        inner join event_identifier
            using (event_type)
        inner join page_hierarchy
            using (page_id)
    group by visit_id
)
select
    (100
        * count(*) filter (where views_checkout_page and not has_purchase_event)
        / count(*)
    ) as purchase_event_percent
;

/* 7 */
select
    page_hierarchy.page_name,
    count(*) as page_views,
from events
    inner join event_identifier
        using (event_type)
    inner join page_hierarchy
        using (page_id)
where event_identifier.event_name = 'Page View'
group by page_hierarchy.page_name
order by page_views desc
limit 3
;

/* 8 */
select
    page_hierarchy.product_category,
    count(*) filter (where event_identifier.event_name = 'Page View') as page_views,
    count(*) filter (where event_identifier.event_name = 'Add to Cart') as add_to_carts,
from events
    inner join event_identifier
        using (event_type)
    inner join page_hierarchy
        using (page_id)
where 1=1
    and event_identifier.event_name in ('Page View', 'Add to Cart')
    and page_hierarchy.product_category is not null
group by page_hierarchy.product_category
order by page_hierarchy.product_category
;

/* 9 */
from (
    select
        event_identifier.event_name,
        page_hierarchy.product_id,
        max(event_identifier.event_name = 'Purchase') over (
            partition by events.visit_id
        ) as purchase_flag,
    from events
        inner join event_identifier
            using (event_type)
        inner join page_hierarchy
            using (page_id)
    where event_identifier.event_name in ('Purchase', 'Add to Cart')
)
select
    product_id,
    count(*) as purchases,
where 1=1
    and purchase_flag
    and event_name = 'Add to Cart'
group by product_id
order by purchases desc
limit 3
;


/*
    C. Product Funnel Analysis

    Using a single SQL query - create a new output table which has the
    following details:

    - How many times was each product viewed?
    - How many times was each product added to cart?
    - How many times was each product added to a cart but not purchased (abandoned)?
    - How many times was each product purchased?

    Additionally, create another table which further aggregates the data for
    the above points but this time for each product category instead of
    individual products.

    Use your 2 new output tables - answer the following questions:

    1.  Which product had the most views, cart adds and purchases?
    2.  Which product was most likely to be abandoned?
    3.  Which product had the highest view to purchase percentage?
    4.  What is the average conversion rate from view to cart add?
    5.  What is the average conversion rate from cart add to purchase?
*/

create or replace table product_metrics as
    from (
        select
            event_identifier.event_name,
            page_hierarchy.product_id,
            max(event_identifier.event_name = 'Purchase') over (
                partition by events.visit_id
            ) as purchased,
        from events
            inner join event_identifier
                using (event_type)
            inner join page_hierarchy
                using (page_id)
        where event_identifier.event_name in (
            'Page View',
            'Add to Cart',
            'Purchase'
        )
        qualify page_hierarchy.product_id is not null
    )
    select
        product_id,
        count(*) filter (where event_name = 'Page View') as viewed,
        count(*) filter (where event_name = 'Add to Cart') as add_to_cart,
        count(*) filter (where event_name = 'Add to Cart' and not purchased) as add_to_cart_abandoned,
        count(*) filter (where event_name = 'Add to Cart' and purchased) as purchased,
    group by product_id
    order by product_id
;

create or replace table product_category_metrics as
    from (
        select
            event_identifier.event_name,
            page_hierarchy.product_category,
            max(event_identifier.event_name = 'Purchase') over (
                partition by events.visit_id
            ) as purchased,
        from events
            inner join event_identifier
                using (event_type)
            inner join page_hierarchy
                using (page_id)
        where event_identifier.event_name in (
            'Page View',
            'Add to Cart',
            'Purchase'
        )
        qualify page_hierarchy.product_category is not null
    )
    select
        product_category,
        count(*) filter (where event_name = 'Page View') as viewed,
        count(*) filter (where event_name = 'Add to Cart') as add_to_cart,
        count(*) filter (where event_name = 'Add to Cart' and not purchased) as add_to_cart_abandoned,
        count(*) filter (where event_name = 'Add to Cart' and purchased) as purchased,
    group by product_category
    order by product_category
;

/* 1 - 9 had most views, 7 had most cart adds and purchases */
select * exclude (add_to_cart_abandoned)
from product_metrics
qualify 0=1
    or 1 = rank() over (order by viewed desc)
    or 1 = rank() over (order by add_to_cart desc)
    or 1 = rank() over (order by purchased desc)
order by product_id
;

/* 2 */
select product_id, add_to_cart_abandoned
from product_metrics
order by add_to_cart_abandoned desc
limit 1
;

/* 3 */
select *, 100 * purchased / viewed as purchase_to_views
from product_metrics
order by purchase_to_views desc
limit 1
;

/* 4 */
select avg(100 * add_to_cart / viewed) as avg_conversion_rate
from product_metrics
;

/* 5 */
select avg(100 * purchased / add_to_cart) as avg_conversion_rate
from product_metrics
;


/*
    D. Campaigns Analysis

    Generate a table that has 1 single row for every unique visit_id record
    and has the following columns:

    - user_id
    - visit_id
    - visit_start_time: the earliest event_time for each visit
    - page_views: count of page views for each visit
    - cart_adds: count of product cart add events for each visit
    - purchase: 1/0 flag if a purchase event exists for each visit
    - campaign_name: map the visit to a campaign if the visit_start_time
      falls between the start_date and end_date
    - impression: count of ad impressions for each visit
    - click: count of ad clicks for each visit
    - (Optional column) cart_products: a comma separated text value with
      products added to the cart sorted by the order they were added to the
      cart (hint: use the sequence_number)

    Use the subsequent dataset to generate at least 5 insights for the
    Clique Bait team - bonus: prepare a single A4 infographic that the
    team can use for their management reporting sessions, be sure to
    emphasise the most important points from your findings.

    Some ideas you might want to investigate further include:

    - Identifying users who have received impressions during each campaign
      period and comparing each metric with other users who did not have an
      impression event
    - Does clicking on an impression lead to higher purchase rates?
    - What is the uplift in purchase rate when comparing users who click on
      a campaign impression versus users who do not receive an impression?
      What if we compare them with users who just an impression but do not click?
    - What metrics can you use to quantify the success or failure of each
      campaign compared to eachother?
*/

create or replace table view_metrics as
    from (
        select
            any_value(users.user_id) as user_id,
            events.visit_id,
            min(events.event_time) as visit_start_time,
            count(*) filter (where event_name = 'Page View') as page_views,
            count(*) filter (where event_name = 'Add to Cart') as cart_adds,
            max(event_identifier.event_name = 'Purchase') as purchase,
            count(*) filter (where event_name = 'Ad Impression') as impression,
            count(*) filter (where event_name = 'Ad Click') as click,
            string_agg(
                page_hierarchy.product_id,
                ',' order by events.sequence_number
            ) filter (where event_name = 'Add to Cart') as cart_products,
        from events
            inner join users
                using (cookie_id)
            inner join event_identifier
                using (event_type)
            inner join page_hierarchy
                using (page_id)
        group by events.visit_id
    ) as visits
        left join campaign_identifier
            on visits.visit_start_time between campaign_identifier.start_date
                                           and campaign_identifier.end_date
    select
        visits.user_id,
        visits.visit_id,
        visits.visit_start_time,
        visits.page_views,
        visits.cart_adds,
        visits.purchase,
        campaign_identifier.campaign_name,
        visits.impression,
        visits.click,
        visits.cart_products,
    order by visits.visit_id
;

-- not doing any investigation or infographics though, soz
