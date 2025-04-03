/* https://www.interviewquery.com/questions/subscription-retention */

/* Solution (PostgreSQL) */
with

plan_durations as (
    select
        user_id,
        plan_id,
        date_trunc('month', start_date)::date as start_month,
        (
            extract(month from coalesce(end_date, '9999-12-31'))
            - extract(month from start_date)
        ) as month_duration
    from subscriptions
),

plan_cohorts as (
    select
        plan_id,
        start_month,
        count(*) as users
    from plan_durations
    group by plan_id, start_month
    order by plan_id, start_month
),

axis as (
    select
        plans.plan_id,
        plans.start_month,
        gs.n as num_month
    from generate_series(1, 3) as gs(n)
        cross join (
            select distinct plan_id, start_month
            from plan_cohorts
        ) as plans
)

select
    axis.num_month,
    axis.plan_id,
    (
        1.0
        * count(plan_durations.user_id)
        /* No ANY_VALUE in PostgreSQL 14.3 😭 */
        / max(plan_cohorts.users)
    )::numeric(4, 2) as retained,
    axis.start_month
from axis
    left join plan_cohorts
        using (plan_id, start_month)
    left join plan_durations
        on  plan_cohorts.plan_id = plan_durations.plan_id
        and plan_cohorts.start_month = plan_durations.start_month
        and axis.num_month <= plan_durations.month_duration
group by
    axis.start_month,
    axis.plan_id,
    axis.num_month
order by
    start_month,
    plan_id,
    num_month
;
