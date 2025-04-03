/* https://www.interviewquery.com/questions/annual-retention */

/* Solution (PostgreSQL) */
with

subscriptions as (
    select
        status,

        extract(year from created_at::timestamp)::int as created_year,
        extract(year from last_updated::timestamp)::int as updated_year,

        lag(extract(year from created_at::timestamp)::int) over (
            partition by user_id, product
            order by created_at
        ) as prev_subscription_year,
        lag(status) over (
            partition by user_id, product
            order by created_at
        ) as prev_subscription_status
    from annual_payments
),

year_end_stats as (
    select
        created_year,
        sum((0=1
            or status = 'paid'
            or (status = 'refunded' and updated_year > created_year)
        )::int) as active,
        sum((1=1
            and prev_subscription_year is not null
            and prev_subscription_year + 1 = created_year
            and status = 'paid'
            and prev_subscription_status = 'paid'
        )::int) as renewed
    from subscriptions
    group by created_year
)

select
    coalesce(1.0 * current_year.renewed / previous_year.active, 0)::numeric(4, 2) as percentage_renewed,
    current_year.created_year as year
from year_end_stats as current_year
    left join year_end_stats as previous_year
        on current_year.created_year - 1 = previous_year.created_year
order by year
;
