/*
    https://8weeksqlchallenge.com/case-study-1/
*/
use dannys_diner;


/*
    Questions

    1.  What is the total amount each customer spent at the restaurant?
    2.  How many days has each customer visited the restaurant?
    3.  What was the first item from the menu purchased by each customer?
    4.  What is the most purchased item on the menu and how many times was
        it purchased by all customers?
    5.  Which item was the most popular for each customer?
    6.  Which item was purchased first by the customer after they became a
        member?
    7.  Which item was purchased just before the customer became a member?
    8.  What is the total items and amount spent for each member before they
        became a member?
    9.  If each $1 spent equates to 10 points and sushi has a 2x points
        multiplier - how many points would each customer have?
    10. In the first week after a customer joins the program (including
        their join date) they earn 2x points on all items, not just sushi -
        how many points do customer A and B have at the end of January?

    11. Bonus: Join All The Things
    12. Bonus: Rank All The Things
*/

/* 1 */
select
    sales.customer_id,
    sum(menu.price) as total_spent,
from sales
    inner join menu
        using (product_id)
;

/* 2 */
select
    customer_id,
    count(distinct order_date) as total_days,
from sales
group by customer_id
order by customer_id
;

/* 3 */
select
    sales.customer_id,
    menu.product_name,
from sales
    inner join menu
        using (product_id)
qualify 1 = row_number() over (
    partition by sales.customer_id
    order by sales.order_date  /* and row ID? */
);

/* 4 */
select
    menu.product_name,
    count(*) as times_purchased,
from menu
    inner join sales
        using (product_id)
group by menu.product_name
order by times_purchased desc
limit 1
;

/* 5 */
select
    sales.customer_id,
    menu.product_name,
    count(*) as times_purchased,
from sales
    inner join menu
        using (product_id)
group by sales.customer_id, menu.product_name
qualify 1 = row_number() over (
    partition by sales.customer_id
    order by times_purchased desc
)
order by sales.customer_id
;

/* 6 */
select
    members.customer_id,
    members.join_date,
    sales.order_date,
    menu.product_name,
from members
    /* Excludes customer C since they're not a member */
    asof inner join sales
        on  members.customer_id = sales.customer_id
        and members.join_date <= sales.order_date
    inner join menu
        using (product_id)
;

/* 7 */
select
    members.customer_id,
    members.join_date,
    sales.order_date,
    menu.product_name,
from members
    /* Excludes customer C since they're not a member */
    asof inner join sales
        on  members.customer_id = sales.customer_id
        and members.join_date > sales.order_date
    inner join menu
        using (product_id)
;

/* 8 */
select
    members.customer_id,
    count(*) as items_purchased,
    sum(menu.price) as amount_spent,
from members
    /* Excludes customer C since they're not a member */
    inner join sales
        on  members.customer_id = sales.customer_id
        and members.join_date > sales.order_date
    inner join menu
        using (product_id)
group by members.customer_id
order by members.customer_id
;

/* 9 */
select
    sales.customer_id,
    10 * sum(if(menu.product_name = 'sushi', menu.price * 2, menu.price)) as points,
from sales
    inner join menu
        using (product_id)
group by sales.customer_id
order by sales.customer_id
;

/* 10 */
select
    members.customer_id,
    10 * sum(if(
        sales.order_date between members.join_date
                             and members.join_date + interval '1 week',
        menu.price * 2,
        menu.price
    )) as points,
from members
    inner join sales
        using (customer_id)
    inner join menu
        using (product_id)
where sales.order_date < '2021-02-01'
group by members.customer_id
order by members.customer_id
;

/* 11 */
select
    sales.customer_id,
    sales.order_date,
    menu.product_name,
    menu.price,
    if(sales.order_date >= members.join_date, 'Y', 'N') as member,
from sales
    inner join menu
        using (product_id)
    left join members
        using (customer_id)
order by
    members.customer_id,
    sales.order_date
;

/* 12 */
select
    sales.customer_id,
    sales.order_date,
    menu.product_name,
    menu.price,
    if(sales.order_date >= members.join_date, 'Y', 'N') as member,
    if(
        member != 'Y',
        null,
        rank() over (
            partition by sales.customer_id, member
            order by sales.order_date
        )
    ) as ranking,
from sales
    inner join menu
        using (product_id)
    left join members
        using (customer_id)
order by
    members.customer_id,
    sales.order_date
;
