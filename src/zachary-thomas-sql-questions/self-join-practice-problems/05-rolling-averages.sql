/* https://quip.com/2gwZArKuWk7W */

/* Sample data (fabricated) */
create or replace table signups (
    date date,
    sign_ups int,
);
insert into signups
    from generate_series(
        '2018-01-01'::date,
        '2018-12-31'::date,
        interval '1 day'
    ) as gs(dt)
    select
        dt,
        round(100 * random()),
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
    I'm getting annoyed.

    Window functions, once again, make more sense here!

    Of the 5 questions so far, 3 are better solved with window functions.

    Also, nitpick: why call the table "signups", but the column "sign_ups"?
    Please, be consistent :(
*/

/* Solution */
select
    date,
    sign_ups,
    avg(sign_ups) over (order by date rows 6 preceding) as weekly_rolling_average,
from signups
order by date
;
