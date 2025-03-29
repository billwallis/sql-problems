/*
    https://8weeksqlchallenge.com/case-study-3/
*/
use foodie_fi;

/*
    A. Customer Journey

    Based off the 8 sample customers provided in the sample from the
    subscriptions table, write a brief description about each customer’s
    onboarding journey.

    Try to keep it as short as possible - you may also want to run some sort
    of join to make your explanations a bit easier!
*/
from plans;
from subscriptions;

/*
    cba right now
*/


/*
    B. Data Analysis Questions

    1.  How many customers has Foodie-Fi ever had?
    2.  What is the monthly distribution of trial plan start_date values for
        our dataset - use the start of the month as the group by value
    3.  What plan start_date values occur after the year 2020 for our
        dataset? Show the breakdown by count of events for each plan_name
    4.  What is the customer count and percentage of customers who have
        churned rounded to 1 decimal place?
    5.  How many customers have churned straight after their initial free
        trial - what percentage is this rounded to the nearest whole number?
    6.  What is the number and percentage of customer plans after their
        initial free trial?
    7.  What is the customer count and percentage breakdown of all 5
        plan_name values at 2020-12-31?
    8.  How many customers have upgraded to an annual plan in 2020?
    9.  How many days on average does it take for a customer to an annual
        plan from the day they join Foodie-Fi?
    10. Can you further breakdown this average value into 30 day periods
        (i.e. 0-30 days, 31-60 days etc)
    11. How many customers downgraded from a pro monthly to a basic monthly
        plan in 2020?
*/

/* 1 */
select count(distinct customer_id) as total_customers
from subscriptions
;

/* 2 */
select
    date_trunc('month', start_date) as start_month,
    count(*) as plans,
from subscriptions
where plan_id = (
    select plan_id
    from plans
    where plan_name = 'trial'
)
group by start_month
order by start_month
;

/* 3 */
select
    date_trunc('month', subscriptions.start_date) as start_month,
    any_value(plans.plan_name) as plan_name,
    count(*) as plans,
from subscriptions
    inner join plans
        using (plan_id)
where subscriptions.start_date >= '2021-01-01'
group by start_month, subscriptions.plan_id
order by start_month, subscriptions.plan_id
;

/* 4 - not sure about what's expected here */
with current_state as (
    from (
        from subscriptions
        qualify 1 = row_number() over (
            partition by customer_id
            order by start_date desc
        )
    )
        inner join plans
            using (plan_id)
)

select
    count(*) filter (where plan_name = 'churn') as churned_customers,
    100 * churned_customers / sum(count(*)) over () as churned_customers_percent,
from current_state
;

/* 5 */
with

sub_ranks as (
    from subscriptions
        inner join plans
            using (plan_id)
    select
        subscriptions.customer_id,
        plans.plan_name,
        row_number() over (
            partition by subscriptions.customer_id
            order by subscriptions.start_date
        ) as sub_rank,
)

from (
    select
        trials.customer_id as trials_customer_id,
        churned.customer_id as churned_customer_id,
    from sub_ranks as trials
        left join sub_ranks as churned
            on  trials.customer_id = churned.customer_id
            and churned.plan_name = 'churn'
            and churned.sub_rank = 2
    where 1=1
        and trials.plan_name = 'trial'
        and trials.sub_rank = 1
)
select
    count(*) filter (where churned_customer_id is not null) as churned_customers,
    100 * churned_customers / sum(count(*)) over () as churned_customers_percent,
;

/* 6 */
with

sub_ranks as (
    from subscriptions
        inner join plans
            using (plan_id)
    select
        subscriptions.customer_id,
        plans.plan_name,
        row_number() over (
            partition by subscriptions.customer_id
            order by subscriptions.start_date
        ) as sub_rank,
)

from (
    select
        first_plan.customer_id,
        second_plan.plan_name,
    from sub_ranks as first_plan
        left join sub_ranks as second_plan
            on  first_plan.customer_id = second_plan.customer_id
            and second_plan.sub_rank = 2
    where 1=1
        and first_plan.plan_name = 'trial'
        and first_plan.sub_rank = 1
)
select
    plan_name,
    count(*) as customers,
    100 * customers / sum(count(*)) over () as customers_percent,
group by plan_name
order by plan_name
;

/* 7 */
from (
    from subscriptions
    where start_date <= '2020-12-31'
    qualify 1 = row_number() over (
        partition by customer_id
        order by start_date desc
    )
)
    inner join plans
        using (plan_id)
select
    plans.plan_name,
    count(*) as customers,
    100 * customers / sum(count(*)) over () as customers_percent,
group by plans.plan_name
order by plans.plan_name
;

/* 8 */
select count(distinct customer_id)
from subscriptions
where 1=1
    and year(start_date) = 2020
    and plan_id = (
        select plan_id
        from plans
        where plan_name = 'pro annual'
    )
;

/* 9 */
with start_dates as (
    select
        customer_id,
        min(start_date) as start_date,
    from subscriptions
    group by customer_id
)

select
    avg(subscriptions.start_date - start_dates.start_date) as avg_days
from start_dates
    asof inner join subscriptions
        on  start_dates.customer_id = subscriptions.customer_id
        and subscriptions.plan_id = (
            select plan_id
            from plans
            where plan_name = 'pro annual'
        )
        and start_dates.start_date <= subscriptions.start_date
;

/* 10 */
with

start_dates as (
    select
        customer_id,
        min(start_date) as start_date,
    from subscriptions
    group by customer_id
),

day_diffs as (
    select
        subscriptions.start_date - start_dates.start_date as day_diff,
        floor(day_diff / 30) * 30 as bucket,
    from start_dates
        asof inner join subscriptions
            on  start_dates.customer_id = subscriptions.customer_id
            and subscriptions.plan_id = (
                select plan_id
                from plans
                where plan_name = 'pro annual'
            )
            and start_dates.start_date <= subscriptions.start_date
)

from day_diffs
select
    bucket,
    avg(day_diff) as avg_days,
group by bucket
order by bucket
;

/* 11 */
with subscription_plans as (
    select
        subscriptions.customer_id,
        plans.plan_name,
        subscriptions.start_date,
        lag(plans.plan_name) over customer_over_time as prev_plan_name,
        lag(subscriptions.start_date) over customer_over_time as prev_start_date,
    from subscriptions
        inner join plans
            using (plan_id)
    window customer_over_time as (
        partition by subscriptions.customer_id
        order by subscriptions.start_date
    )
)

select count(*)
from subscription_plans
where 1=1
    and year(start_date) = 2020
    and plan_name = 'basic monthly'
    and prev_plan_name = 'pro monthly'
;


/*
    C. Challenge Payment Question

    The Foodie-Fi team wants you to create a new payments table for the year
    2020 that includes amounts paid by each customer in the subscriptions
    table with the following requirements:

    - monthly payments always occur on the same day of month as the original
      start_date of any monthly paid plan
    - upgrades from basic to monthly or pro plans are reduced by the current
      paid amount in that month and start immediately
    - upgrades from pro monthly to pro annual are paid at the end of the
      current billing period and also starts at the end of the month period
    - once a customer churns they will no longer make payments
*/
create or replace table payments as
with

plan_details as (
    select
        subscriptions.customer_id,
        plans.plan_name,
        plans.price,
        subscriptions.start_date,
        -1 + lead(subscriptions.start_date, 1, '2021-12-31') over customer_over_time as end_date,
        case
            when plans.plan_name in ('basic monthly', 'pro monthly')
                then 'month'
            when plans.plan_name = 'pro annual'
                then 'year'
        end as payment_schedule,
        coalesce(date_diff(payment_schedule, start_date, end_date), 0) as payments,
    from subscriptions
        inner join plans
            using (plan_id)
    window customer_over_time as (
        partition by subscriptions.customer_id
        order by subscriptions.start_date
    )
),

payment_details as (
    select
        row_number() over (
            partition by plan_details.customer_id
            order by plan_details.start_date
        ) as payment_number,
        plan_details.customer_id,
        plan_details.plan_name,
        plan_details.price as payment_amount,
        plan_details.payment_schedule,
        plan_details.start_date,
        plan_details.end_date,
        (gs.n = 0) as change_flag,
        (
            plan_details.start_date
            + if(
                plan_details.payment_schedule = 'month',
                to_months(gs.n::int),
                to_years(gs.n::int)
            )
        )::date as payment_date,
    from plan_details
        cross join lateral (
            from generate_series(0, plan_details.payments)
        ) as gs(n)
    where 1=1
        and year(payment_date) = 2020
        and payment_date between start_date and end_date
),

payment_contributions as (
    select
        payment_number,
        customer_id,
        plan_name,
        payment_amount,
        change_flag,
        payment_date,
        lag(payment_schedule) over customer_over_time as prev_payment_schedule,
        lag(payment_date) over customer_over_time as prev_payment_date,
        lag(payment_amount) over customer_over_time as prev_payment_amount,
        payment_date - prev_payment_date as days_contributed,
        extract(
            days from (
                prev_payment_date
                + if(
                    prev_payment_schedule = 'month',
                    interval '1 month',
                    interval '1 year'
                )
            ) - prev_payment_date
        ) as days_total,
        coalesce(
            if(
                change_flag,
                prev_payment_amount * (1 - days_contributed / days_total),
                null
            ),
            0
        ) as upgrade_contribution,
    from payment_details
    window customer_over_time as (
        partition by customer_id
        order by start_date
    )
)

select
    customer_id,
    plan_name,
    payment_number,
    payment_date,
    (payment_amount - upgrade_contribution)::numeric(5, 2) as payment_amount,
from payment_contributions
order by customer_id, payment_number
;

from payments
;


/*
    D. Outside The Box Questions

    The following are open ended questions which might be asked during a
    technical interview for this case study - there are no right or wrong
    answers, but answers that make sense from both a technical and a
    business perspective make an amazing impression!

    1.  How would you calculate the rate of growth for Foodie-Fi?
    2.  What key metrics would you recommend Foodie-Fi management to track
        over time to assess performance of their overall business?
    3.  What are some key customer journeys or experiences that you would
        analyse further to improve customer retention?
    4.  If the Foodie-Fi team were to create an exit survey shown to
        customers who wish to cancel their subscription, what questions
        would you include in the survey?
    5.  What business levers could the Foodie-Fi team use to reduce the
        customer churn rate? How would you validate the effectiveness of
        your ideas?
*/
