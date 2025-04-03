/* https://www.interviewquery.com/questions/best-performing-advertisers */

/*
    This question should clarify whether weeks start on a Sunday or Monday!

    For example, the date 2021-08-01 is a Sunday. MySQL uses Sunday as the
    week-start day, whereas PostgreSQL uses Monday as the week-start day:

    MySQL (8.0.35)

        select
            week(cast('2021-07-31' as date)),  -- 30
            week(cast('2021-08-01' as date)),  -- 31
            week(cast('2021-08-02' as date))   -- 31

    PostgreSQL (14.3)

        select
            extract('week' from '2021-07-31'::date),  -- 30
            extract('week' from '2021-08-01'::date),  -- 30
            extract('week' from '2021-08-02'::date)   -- 31

    The result set implies that Sunday should be used as the week-start day,
    but the question does not clarify that at all!
*/
/* Solution (PostgreSQL) */
with advertiser_revenue as (
    select
        advertiser_id,
        transaction_date,
        /* No ANY_VALUE in PostgreSQL 14.3 😭 */
        max(transaction_week) as transaction_week,
        sum(amount) as revenue,
        rank() over (
            partition by advertiser_id
            order by sum(amount) desc
        ) as daily_revenue_rank,
        sum(sum(amount)) over (
            partition by
                advertiser_id,
                max(transaction_week)
        ) as weekly_revenue
    from (
        select
            *,
            /* Shift to use Sunday as the week-start day */
            date_trunc('week', transaction_date + interval '1 day')::date as transaction_week
        from revenue
    ) as r
    group by
        advertiser_id,
        transaction_date
)

select
    advertisers.advertiser_name,
    advertiser_revenue.transaction_date,
    advertiser_revenue.revenue as amount
from advertiser_revenue
    inner join advertisers
        using (advertiser_id)
where 1=1
    and advertiser_revenue.daily_revenue_rank <= 3
    and advertiser_revenue.advertiser_id in (
        select advertiser_id
        from advertiser_revenue
        where weekly_revenue = (
            select max(weekly_revenue)
            from advertiser_revenue
        )
    )
order by amount desc
;
