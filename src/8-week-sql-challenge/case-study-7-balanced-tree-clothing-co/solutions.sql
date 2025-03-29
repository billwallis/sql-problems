/*
    https://8weeksqlchallenge.com/case-study-7/
*/
use balanced_tree;


/*
    A. High Level Sales Analysis

    1.  What was the total quantity sold for all products?
    2.  What is the total generated revenue for all products before discounts?
    3.  What was the total discount amount for all products?
*/

/* 1 */
select sum(qty) as total_quantity_sold
from sales
;

/* 2 */
select sum(price * qty) as total_generated_revenue
from sales
;

/* 3 */
select sum(discount * qty) as total_discount_amount
from sales
;


/*
    B. Transaction Analysis

    1.  How many unique transactions were there?
    2.  What is the average unique products purchased in each transaction?
    3.  What are the 25th, 50th and 75th percentile values for the revenue per transaction?
    4.  What is the average discount value per transaction?
    5.  What is the percentage split of all transactions for members vs non-members?
    6.  What is the average revenue for member transactions and non-member transactions?
*/

/* 1 */
select count(distinct txn_id) as unique_transactions
from sales
;

/* 2 */
from (
    select
        txn_id,
        count(distinct prod_id) as unique_products,
    from sales
    group by txn_id
)
select avg(unique_products) as avg_unique_products
;

/* 3 */
from (
    select
        txn_id,
        sum(discount * qty) as revenue,
    from sales
    group by txn_id
)
select
    percentile_cont(0.25) within group (order by revenue) as percentile_25,
    percentile_cont(0.50) within group (order by revenue) as percentile_50,
    percentile_cont(0.75) within group (order by revenue) as percentile_75,
;

/* 4 */
from (
    select
        txn_id,
        sum(discount * qty) as discount,
    from sales
    group by txn_id
)
select avg(discount) as avg_discount
;

/* 5 */
select
    (100
        * count(distinct txn_id) filter (where member)
        / count(distinct txn_id)
    ) as member_txns_pct,
    (100
        * count(distinct txn_id) filter (where not member)
        / count(distinct txn_id)
    ) as non_member_txns_pct,
from sales
;

/* 6 */
select
    member,
    avg(qty * price) as avg_revenue,
from sales
group by member
order by member
;


/*
    C. Product Analysis

    1.  What are the top 3 products by total revenue before discount?
    2.  What is the total quantity, revenue and discount for each segment?
    3.  What is the top selling product for each segment?
    4.  What is the total quantity, revenue and discount for each category?
    5.  What is the top selling product for each category?
    6.  What is the percentage split of revenue by product for each segment?
    7.  What is the percentage split of revenue by segment for each category?
    8.  What is the percentage split of total revenue by category?
    9.  What is the total transaction “penetration” for each product? (hint:
        penetration = number of transactions where at least 1 quantity of a
        product was purchased divided by total number of transactions)
    10. What is the most common combination of at least 1 quantity of any 3
        products in a 1 single transaction?
*/

/* 1 */
from (
    select
        prod_id as product_id,
        sum(qty * price) as revenue,
    from sales
    group by prod_id
    order by revenue desc
    limit 3
) natural inner join product_details
select
    product_name,
    revenue
;

/* 2 */
select
    product_details.segment_name,
    sum(sales.qty) as quantity,
    sum(sales.qty * sales.price) as revenue,
    sum(sales.qty * sales.discount) as discount,
from sales
    inner join product_details
        on sales.prod_id = product_details.product_id
group by product_details.segment_name
order by product_details.segment_name
;

/* 3 */
select
    product_details.segment_name,
    any_value(product_details.product_name) as product_name,
    sum(sales.qty) as quantity,
from sales
    inner join product_details
        on sales.prod_id = product_details.product_id
group by
    product_details.segment_name,
    product_details.product_id
qualify 1 = rank() over (
    partition by product_details.segment_name
    order by quantity desc
)
order by product_details.segment_name
;

/* 4 */
select
    product_details.category_name,
    sum(sales.qty) as quantity,
    sum(sales.qty * sales.price) as revenue,
    sum(sales.qty * sales.discount) as discount,
from sales
    inner join product_details
        on sales.prod_id = product_details.product_id
group by product_details.category_name
order by product_details.category_name
;

/* 5 */
select
    product_details.category_name,
    any_value(product_details.product_name) as product_name,
    sum(sales.qty) as quantity,
from sales
    inner join product_details
        on sales.prod_id = product_details.product_id
group by
    product_details.category_name,
    product_details.product_id
qualify 1 = rank() over (
    partition by product_details.category_name
    order by quantity desc
)
order by product_details.category_name
;

/* 6 */
select
    product_details.segment_name,
    any_value(product_details.product_name) as product_name,
    sum(sales.qty * sales.price) as revenue,
    (100
        * revenue
        / sum(revenue) over (
            partition by product_details.segment_name
        )
    ) as revenue_proportion,
from sales
    inner join product_details
        on sales.prod_id = product_details.product_id
group by
    product_details.segment_name,
    product_details.product_id
order by
    product_details.segment_name,
    product_details.product_id
;

/* 7 */
select
    product_details.category_name,
    any_value(product_details.product_name) as product_name,
    sum(sales.qty * sales.price) as revenue,
    (100
        * revenue
        / sum(revenue) over (
            partition by product_details.category_name
        )
    ) as revenue_proportion,
from sales
    inner join product_details
        on sales.prod_id = product_details.product_id
group by
    product_details.category_name,
    product_details.product_id
order by
    product_details.category_name,
    product_details.product_id
;

/* 8 */
select
    product_details.category_name,
    sum(sales.qty * sales.price) as revenue,
    (100 * revenue / sum(revenue) over ()) as revenue_proportion,
from sales
    inner join product_details
        on sales.prod_id = product_details.product_id
group by product_details.category_name
order by product_details.category_name
;

/* 9 */
select
    product_name,
    (100
        * (
            select count(distinct txn_id)
            from sales
            where product_details.product_id = sales.prod_id
        )
        / (
            select count(distinct txn_id)
            from sales
        )
    )::numeric(8, 4) as transaction_penetration,
from product_details
;

/* 10 */
with

large_sales as (
    select distinct
        sales.txn_id,
        product_details.product_name,
    from sales
        inner join product_details
            on sales.prod_id = product_details.product_id
    qualify 3 <= count(distinct sales.prod_id) over (
        partition by sales.txn_id
    )
),

triplets as (
    select
        t1.txn_id,
        [
            t1.product_name,
            t2.product_name,
            t3.product_name,
        ] as products,
    from large_sales as t1
        inner join large_sales as t2
            on  t1.txn_id = t2.txn_id
            and t1.product_name < t2.product_name
        inner join large_sales as t3
            on  t2.txn_id = t3.txn_id
            and t2.product_name < t3.product_name
)

select products, count(*) as occurances
from triplets
group by products
order by occurances desc
limit 1
;


/*
    D. Reporting Challenge

    Write a single SQL script that combines all of the previous questions
    into a scheduled report that the Balanced Tree team can run at the
    beginning of each month to calculate the previous month’s values.

    Imagine that the Chief Financial Officer (which is also Danny) has asked
    for all of these questions at the end of every month.

    He first wants you to generate the data for January only - but then he
    also wants you to demonstrate that you can easily run the same analysis
    for February without many changes (if at all).

    Feel free to split up your final outputs into as many tables as you need
    - but be sure to explicitly reference which table outputs relate to
    which question for full marks :)
*/

-- no


/*
    E. Bonus Challenge

    Use a single SQL query to transform the product_hierarchy and
    product_prices datasets to the product_details table.

    Hint: you may want to consider using a recursive CTE to solve this problem!
*/

select
    prices.product_id,
    prices.price,
    format(
        '{} {} - {}',
        style.level_text,
        segment.level_text,
        category.level_text
    ) as product_name,
    category.id as category_id,
    segment.id as segment_id,
    style.id as style_id,
    category.level_text as category_name,
    segment.level_text as segment_name,
    style.level_text as style_name,
from product_prices as prices
    inner join product_hierarchy as style
        on  prices.id = style.id
        and style.level_name = 'Style'
    inner join product_hierarchy as segment
        on  style.parent_id = segment.id
        and segment.level_name = 'Segment'
    inner join product_hierarchy as category
        on  segment.parent_id = category.id
        and category.level_name = 'Category'
;
