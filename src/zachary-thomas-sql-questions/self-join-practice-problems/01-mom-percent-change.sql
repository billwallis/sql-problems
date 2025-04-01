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

/*
    Hmm, window functions make more sense here IMO.

    "But what if a month is missing?"

    Then either:

    - Create a date axis before using the window function
    - Use RANGE INTERVAL '1 MONTH' PRECEDING
*/

/* Solution */
from (
    select
        date_trunc('month', date) as login_month,
        count(distinct user_id) as active_users,
    from logins
    group by login_month
)
select
    login_month,
    active_users,
    100 * (-1 + (
        active_users / lag(active_users) over (order by login_month)
    ))::numeric(8, 4) as mau_rate_mom,
order by login_month
;
