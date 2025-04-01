/* https://quip.com/2gwZArKuWk7W */

/* Sample data */
create or replace table "table" (
    user int,
    class text,
);
insert into "table"
values
    (1, 'a'),
    (1, 'b'),
    (1, 'b'),
    (2, 'b'),
    (3, 'a'),
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
    Please don't use keywords like TABLE as object names :(
*/

/* Solution */
from (
    select
        user,
        count(*) filter (where class = 'a') as count_a,
        count(*) filter (where class = 'b') as count_b,
    from "table"
    group by user
)
select
    case when count_a > 0 and count_b = 0
        then 'a'
        else 'b'
    end as class,
    count(*),
group by class
order by class
;
