/*
    https://8weeksqlchallenge.com/case-study-2/
*/
use pizza_runner;

/*
    A. Pizza Metrics

    1.  How many pizzas were ordered?
    2.  How many unique customer orders were made?
    3.  How many successful orders were delivered by each runner?
    4.  How many of each type of pizza was delivered?
    5.  How many Vegetarian and Meatlovers were ordered by each customer?
    6.  What was the maximum number of pizzas delivered in a single order?
    7.  For each customer, how many delivered pizzas had at least 1 change
        and how many had no changes?
    8.  How many pizzas were delivered that had both exclusions and extras?
    9.  What was the total volume of pizzas ordered for each hour of the day?
    10. What was the volume of orders for each day of the week?
*/
create or replace macro nullify(col) as
    if(lower(trim(col)) in ('', 'null'), null, col)
;

/* 1 */
select count(*)
from customer_orders
;

/* 2 */
select count(distinct order_id)
from customer_orders
;

/* 3 */
select count(*)
from runner_orders
where nullif(pickup_time, 'null') is not null
;

/* 4 */
select count(distinct pizza_id)
from customer_orders
;

/* 5 */
select
    pizza_names.pizza_name,
    count(*) as times_ordered,
from pizza_names
    inner join customer_orders
        using (pizza_id)
group by pizza_names.pizza_name
order by pizza_names.pizza_name
;

/* 6 */
from (
    select order_id, count(*) as pizzas_ordered
    from customer_orders
    group by order_id
)
select max(pizzas_ordered) as max_pizzas_ordered
;

/* 7 */
with delivered_pizzas as (
    select
        order_id,
        customer_id,
        pizza_id,
        nullify(exclusions) as exclusions,
        nullify(extras) as extras,
    from customer_orders
        semi join runner_orders
            on  customer_orders.order_id = runner_orders.order_id
            and nullif(runner_orders.pickup_time, 'null') is not null
)

select
    customer_id,
    count(*) filter (where coalesce(exclusions, extras) is not null) as with_changes,
    count(*) filter (where coalesce(exclusions, extras) is     null) as without_changes,
from delivered_pizzas
group by customer_id
order by customer_id
;

/* 8 */
with delivered_pizzas as (
    select
        order_id,
        customer_id,
        pizza_id,
        nullify(exclusions) as exclusions,
        nullify(extras) as extras,
    from customer_orders
        semi join runner_orders
            on  customer_orders.order_id = runner_orders.order_id
            and nullif(runner_orders.pickup_time, 'null') is not null
)

select count(*)
from delivered_pizzas
where 1=1
    and exclusions is not null
    and extras is not null
;

/* 9 (option 1) - not sure what the expected output of this is */
with

axis(order_hour) as (
    select orders.order_date + to_hours(gs.h),
    from generate_series(0, 23) as gs(h)
        cross join (
            select distinct order_time::date
            from customer_orders
        ) as orders(order_date)
),

orders as (
    select
        date_trunc('hour', order_time) as order_hour,
        count(*) as total_pizzas,
    from customer_orders
    group by order_hour
)

select
    order_hour,
    coalesce(total_pizzas, 0) as total_pizzas,
from axis
    left join orders
        using (order_hour)
order by order_hour
;

/* 9 (option 2) - not sure what the expected output of this is */
select
    extract(hour from order_time) as order_hour,
    count(*) as total_pizzas,
from customer_orders
group by order_hour
order by order_hour
;

/* 10 - not sure what the expected output of this is */
select
    extract(dow from order_time) as _dow,
    case _dow
        when 0 then 'Sunday'
        when 1 then 'Monday'
        when 2 then 'Tuesday'
        when 3 then 'Wednesday'
        when 4 then 'Thursday'
        when 5 then 'Friday'
        when 6 then 'Saturday'
    end as order_dow,
    count(*) as total_pizzas,
from customer_orders
group by _dow
order by _dow
;


/*
    B. Runner and Customer Experience

    1.  How many runners signed up for each 1 week period? (i.e. week starts
        2021-01-01)
    2.  What was the average time in minutes it took for each runner to
        arrive at the Pizza Runner HQ to pickup the order?
    3.  Is there any relationship between the number of pizzas and how long
        the order takes to prepare?
    4.  What was the average distance travelled for each customer?
    5.  What was the difference between the longest and shortest delivery
        times for all orders?
    6.  What was the average speed for each runner for each delivery and do
        you notice any trend for these values?
    7.  What is the successful delivery percentage for each runner?
*/

/* 1 */
select
    date_trunc('week', registration_date) + 4 as registration_week,
    count(*) as runners,
from runners
group by registration_week
order by registration_week
;

/* 2 */
with orders as (
    select distinct order_id, order_time
    from customer_orders
)

select
    runner_orders.runner_id,
    avg(extract('minute' from nullify(runner_orders.pickup_time)::timestamp - orders.order_time)) as avg_minutes,
from runner_orders
    inner join orders
        using (order_id)
group by runner_orders.runner_id
order by runner_orders.runner_id
;

/* 3 */
with orders as (
    select
        order_id,
        any_value(order_time) as order_time,
        count(*) as number_of_pizzas,
    from customer_orders
    group by order_id
)

select
    orders.number_of_pizzas,
    avg(extract('minute' from nullify(runner_orders.pickup_time)::timestamp - orders.order_time)) as avg_minutes,
from orders
    inner join runner_orders
        using (order_id)
group by orders.number_of_pizzas
order by orders.number_of_pizzas
;
-- Yes: more pizzas => more time

/* 4 */
with

order_distances as (
    select
        order_id,
        distance.replace('km', '').trim().nullif('null')::numeric(5, 2) as distance,
    from runner_orders
),

orders as (
    select distinct
        order_id,
        customer_id,
    from customer_orders
)

select
    orders.customer_id,
    avg(order_distances.distance) as avg_kms,
from orders
    inner join order_distances
        using (order_id)
group by orders.customer_id
order by orders.customer_id
;

/* 5 */
with delivery_times as (
    select
        duration
            .replace('minutes', '')
            .replace('minute', '')
            .replace('mins', '')
            .trim()::int
        as duration,
    from runner_orders
    where duration != 'null'
)

select max(duration) - min(duration) as duration_diff
from delivery_times
;

/* 6 */
with delivery_times as (
    select
        runner_id,
        duration
            .replace('minutes', '')
            .replace('minute', '')
            .replace('mins', '')
            .trim()::int
        as duration,
    from runner_orders
    where duration != 'null'
)

select
    runner_id,
    avg(duration) as avg_duration,
from delivery_times
group by runner_id
order by runner_id
;
-- Runner 2 is almost x2 the speed of runner 3

/* 7 */
select
    runner_id,
    100 * count(*) filter (where duration != 'null') / count(*) as success_percentage,
from runner_orders
group by runner_id
order by runner_id
;


/*
    C. Ingredient Optimisation

    1.  What are the standard ingredients for each pizza?
    2.  What was the most commonly added extra?
    3.  What was the most common exclusion?
    4.  Generate an order item for each record in the customers_orders table
        in the format of one of the following:
        - Meat Lovers
        - Meat Lovers - Exclude Beef
        - Meat Lovers - Extra Bacon
        - Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
    5.  Generate an alphabetically ordered comma separated ingredient list
        for each pizza order from the customer_orders table and add a 2x in
        front of any relevant ingredients
        - For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"
    6.  What is the total quantity of each ingredient used in all delivered
        pizzas sorted by most frequent first?
*/
create or replace macro set_remove(list_org, list_rem) as
    if(
        list_rem is null or list_rem = [],
        list_org,
        list_filter(list_org, x -> not list_contains(list_rem, x))
    )
;

/* 1 */
from (
    select
        pizza_names.pizza_name,
        unnest(split(pizza_recipes.toppings, ', ')) as topping_id,
    from pizza_names
        inner join pizza_recipes
            using (pizza_id)
) as toppings
    inner join pizza_toppings
        using (topping_id)
select
    pizza_name,
    topping_name
order by all
;

/* 2 */
with extras(topping_id) as (
    select unnest(split(nullify(extras), ', ')),
    from customer_orders
)

select any_value(topping_name) as most_popular_extra
from extras
    inner join pizza_toppings
        using (topping_id)
group by topping_id
order by count(*) desc
limit 1
;

/* 3 */
with exclusions(topping_id) as (
    select unnest(split(nullify(exclusions), ', ')),
    from customer_orders
)

select any_value(topping_name) as most_popular_exclusion
from exclusions
    inner join pizza_toppings
        using (topping_id)
group by topping_id
order by count(*) desc
limit 1
;

/* 4 */
with

orders as (
    select
        order_id,
        pizza_id,
        row_number() over () as row_id,
        nullify(exclusions) as exclusions,
        nullify(extras) as extras,
    from customer_orders
),

exclusions as (
    from (
        select
            row_id,
            unnest(split(exclusions, ', ')) as topping_id,
        from orders
    )
        inner join pizza_toppings
            using (topping_id)
    select
        row_id,
        'Exclude ' || string_agg(topping_name, ', ') as exclusions,
    group by row_id
),

extras as (
    from (
        select
            row_id,
            unnest(split(extras, ', ')) as topping_id,
        from orders
    )
        inner join pizza_toppings
            using (topping_id)
    select
        row_id,
        'Extra ' || string_agg(topping_name, ', ') as extras,
    group by row_id
)

select
    orders.order_id,
    orders.pizza_id,
    concat_ws(' - ',
        pizza_names.pizza_name,
        exclusions.exclusions,
        extras.extras
    ) as order_item,
from orders
    inner join pizza_names
        using (pizza_id)
    left join exclusions
        using (row_id)
    left join extras
        using (row_id)
order by orders.order_id
;

/* 6 */
with

orders as (
    select
        row_number() over () as row_id,
        customer_orders.order_id,
        pizza_names.pizza_name,
        nullify(customer_orders.exclusions).split(', ') as exclusions,
        nullify(customer_orders.extras).split(', ') as extras,
        toppings.toppings,
    from customer_orders
        inner join pizza_names
            using (pizza_id)
        inner join (
            select
                pizza_id,
                toppings.split(', ') as toppings,
            from pizza_recipes
        ) as toppings
            using (pizza_id)
),

toppings as (
    from (
        select
            row_id,
            order_id,
            pizza_name,
            unnest(set_remove(toppings, exclusions).list_concat(extras)) as topping_id,
        from orders
    )
        left join pizza_toppings
            using (topping_id)
)

from (
    from toppings
    select
        row_id,
        topping_name,
        count(*) as topping_count,
        any_value(order_id) as order_id,
        any_value(pizza_name) as pizza_name,
        if(topping_count = 1, '', topping_count || 'x') || topping_name as topping_name_adj,
    group by row_id, topping_name
)
select
    row_id,
    any_value(order_id) as order_id,
    concat(
        any_value(pizza_name),
        ': ',
        string_agg(
            topping_name_adj,
            ', ' order by topping_name
        )
    ) as pizza_name,
group by row_id
order by row_id
;

/* 6 */
with

orders as (
    select
        row_number() over () as row_id,
        customer_orders.order_id,
        pizza_names.pizza_name,
        nullify(customer_orders.exclusions).split(', ') as exclusions,
        nullify(customer_orders.extras).split(', ') as extras,
        toppings.toppings,
    from customer_orders
        inner join pizza_names
            using (pizza_id)
        inner join (
            select
                pizza_id,
                toppings.split(', ') as toppings,
            from pizza_recipes
        ) as toppings
            using (pizza_id)
        natural semi join (
            select order_id
            from runner_orders
            where nullif(runner_orders.pickup_time, 'null') is not null
        )
),

toppings as (
    from (
        select
            row_id,
            order_id,
            pizza_name,
            unnest(set_remove(toppings, exclusions).list_concat(extras)) as topping_id,
        from orders
    )
        left join pizza_toppings
            using (topping_id)
)

from toppings
select
    topping_name,
    count(*) as topping_count,
group by topping_name
order by topping_count desc
;


/*
    D. Pricing and Ratings

    1.  If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there
        were no charges for changes - how much money has Pizza Runner made
        so far if there are no delivery fees?
    2.  What if there was an additional $1 charge for any pizza extras?
        - Add cheese is $1 extra
    3.  The Pizza Runner team now wants to add an additional ratings system
        that allows customers to rate their runner, how would you design an
        additional table for this new dataset - generate a schema for this
        new table and insert your own data for ratings for each successful
        customer order between 1 to 5.
    4.  Using your newly generated table - can you join all of the
        information together to form a table which has the following
        information for successful deliveries?
        - customer_id
        - order_id
        - runner_id
        - rating
        - order_time
        - pickup_time
        - Time between order and pickup
        - Delivery duration
        - Average speed
        - Total number of pizzas
    5.  If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with
        no cost for extras and each runner is paid $0.30 per kilometre
        traveled - how much money does Pizza Runner have left over after
        these deliveries?
*/

/* 1 */
with pizza_cost(pizza_name, cost) as (
    values
        ('Meatlovers', 12),
        ('Vegetarian', 10),
)

select sum(pizza_cost.cost) as revenue
from customer_orders
    inner join pizza_names
        using (pizza_id)
    inner join pizza_cost
        using (pizza_name)
;

/* 2 */
with pizza_cost(pizza_name, cost) as (
    values
        ('Meatlovers', 12),
        ('Vegetarian', 10),
)

select sum(pizza_cost.cost + if(nullify(extras) is null, 0, 1)) as revenue
from customer_orders
    inner join pizza_names
        using (pizza_id)
    inner join pizza_cost
        using (pizza_name)
;

/* 3 */
create or replace table runner_ratings (
    order_id int,
    runner_id int,
    rating int
);
insert into runner_ratings
    select
        order_id,
        runner_id,
        ceil(random() * 5)
    from runner_orders
;

/* 4 */
with

deliveries as (
    select
        order_id,
        runner_id,
        nullify(pickup_time)::timestamp as pickup_time,
        duration
            .replace('minutes', '')
            .replace('minute', '')
            .replace('mins', '')
            .trim()::int
        as duration,
        distance
            .replace('km', '')
            .trim()
            .nullif('null')::numeric(5, 2)
        as distance,
    from runner_orders
    where duration != 'null'
),

orders as (
    select
        customer_id,
        order_id,
        any_value(order_time) as order_time,
        count(*) as total_pizzas,
    from customer_orders
    group by
        order_id,
        customer_id
)

select
    orders.customer_id,
    orders.order_id,
    deliveries.runner_id,
    runner_ratings.rating,
    orders.order_time,
    deliveries.pickup_time,
    deliveries.pickup_time - orders.order_time as prep_time,
    deliveries.duration,
    deliveries.distance / deliveries.duration as avg_speed,
    orders.total_pizzas,
from orders
    inner join deliveries
        using (order_id)
    inner join runner_ratings
        using (runner_id, order_id)
;

/* 5 */
with

deliveries as (
    select
        order_id,
        distance
            .replace('km', '')
            .trim()
            .nullif('null')::numeric(5, 2)
        as distance,
    from runner_orders
    where duration != 'null'
),

pizza_cost(pizza_name, cost) as (
    values
        ('Meatlovers', 12),
        ('Vegetarian', 10),
),

orders as (
    select
        order_id,
        sum(pizza_cost.cost) as revenue,
    from customer_orders
        inner join pizza_names
            using (pizza_id)
        inner join pizza_cost
            using (pizza_name)
    group by order_id
)


select sum(revenue) - sum(distance * 0.30) as profit
from orders
    inner join deliveries
        using (order_id)
;


/*
    E. Bonus Questions

    If Danny wants to expand his range of pizzas - how would this impact the
    existing data design? Write an INSERT statement to demonstrate what
    would happen if a new Supreme pizza with all the toppings was added to
    the Pizza Runner menu?
*/
insert into pizza_names
values
    (3, 'Supreme pizza')
;
insert into pizza_recipes
    select
        3,
        string_agg(topping_id, ', ' order by topping_id),
    from pizza_toppings
;
