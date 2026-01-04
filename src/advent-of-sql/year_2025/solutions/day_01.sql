use day_01;

/* Wish List */
from wish_list;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select
    raw_wish.trim().lower() as wish,
    count(*) as count,
from wish_list
group by wish
order by count desc
;
