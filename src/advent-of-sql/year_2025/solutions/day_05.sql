use day_05;

/* Listening logs */
from listening_logs;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select
    user_name,
    artist,
    count(*) as total_listens,
from listening_logs
group by user_name, artist
qualify 3 >= dense_rank() over (
    partition by user_name
    order by total_listens desc
)
order by user_name, total_listens desc
;
