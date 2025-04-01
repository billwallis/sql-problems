/* https://quip.com/2gwZArKuWk7W */

/* Sample data (fabricated) */
create or replace table transactions (
    date date,
    cash_flow int,
);
insert into transactions
    from generate_series(
        '1960-01-01'::date,
        '2049-12-31'::date,
        interval '1 day'
    ) as gs(dt)
    select
        dt,
        round(-500 + 1000 * random()),
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
    Again, window functions make more sense here!

    You _could_ do it with a self-join, but that's never the right way to
    think about this kind of operation -- and even the recommended solutions
    say that the window function way is better!

    Also, there's a syntax error in the solution -- there should not be a B
    after JOIN.
*/

/* Solution */
select
    date,
    sum(cash_flow) over (order by date) as cumulative_cf,
from transactions
order by date
;
