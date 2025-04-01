/* https://quip.com/2gwZArKuWk7W */

/* Sample data (fabricated) */
create or replace table logins (
    user_id int,
    date date,
);
insert into logins
    with

    users(user_id) as (
        from generate_series(1, 100)
    ),
    dates(dt) as (
        from generate_series(
            '2025-01-01'::date,
            '2025-12-31'::date,
            interval '1 day'
        )
    )

    from (
        from users, dates
        select
            user_id,
            dt,
            random() as r,
    )
    select
        user_id,
        dt,
    where case
        when user_id < 40 then r < 0.30
        when user_id < 70 then r < 0.10
                          else r < 0.01
    end
    order by dt, user_id
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution (part 1) */
with monthly_logins as (
    select distinct
        date_trunc('month', date) as login_month,
        user_id,
    from logins
)

select
    login_month,
    count(*) as retained_users,
from monthly_logins as this_month
    semi join monthly_logins as last_month
        on  this_month.user_id = last_month.user_id
        and this_month.login_month - interval '1 month' = last_month.login_month
group by login_month
order by login_month
;

/*
    The recommended part 2 solution is wrong -- it should use B.DATE for the
    MONTH_TIMESTAMP calculation, not A.DATE
*/
/* Solution (part 2) */
with monthly_logins as (
    select distinct
        date_trunc('month', date) as login_month,
        user_id,
    from logins
)

select
    login_month,
    count(*) as churned_users,
from monthly_logins as last_month
    anti join monthly_logins as this_month
        on  last_month.user_id = this_month.user_id
        and last_month.login_month + interval '1 month' = this_month.login_month
group by login_month
order by login_month
;

/*
    The recommended part 3 solution is absolutely wrong! It doesn't include
    the USER_ID in the GROUP BY so the HAVING doesn't apply per-user, and it
    is missing another GROUP BY after this one to roll it up to the monthly
    grain.

    Who reviewed these?!
*/
/* Solution (part 3) */
with monthly_logins as (
    select distinct
        date_trunc('month', date) as login_month,
        user_id,
    from logins
)

select
    login_month,
    count(*) as reactivated_users,
from monthly_logins as this_month
where 1=1
    and not exists(
        from monthly_logins as last_month
        where 1=1
            and this_month.user_id = last_month.user_id
            and this_month.login_month - interval '1 month' = last_month.login_month
    )
    and exists(
        from monthly_logins as earlier_months
        where 1=1
            and this_month.user_id = earlier_months.user_id
            and this_month.login_month - interval '1 month' > earlier_months.login_month
    )
group by login_month
order by login_month
;
