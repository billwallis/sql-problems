/* https://quip.com/2gwZArKuWk7W */

/* Sample data */
create or replace table state_streams (
    state text,
    total_streams int,
);
insert into state_streams
values
    ('NC', 34569),
    ('SC', 33999),
    ('CA', 98324),
    ('MA', 19345),
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution (part 1) */
select
    l.state as state_a,
    r.state as state_b,
from state_streams as l
    inner join state_streams as r
        on  abs(l.total_streams - r.total_streams) < 1000
        and l.total_streams != r.total_streams
order by all
;

/* Solution (part 2) */
select
    l.state as state_a,
    r.state as state_b,
from state_streams as l
    inner join state_streams as r
        on  abs(l.total_streams - r.total_streams) < 1000
        and l.state < r.state
order by all
;
