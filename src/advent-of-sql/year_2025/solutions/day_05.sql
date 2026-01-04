use day_05;

/* Listening logs */
from listening_logs;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
    The author doesn't handle `total_listens` duplicates 😭

    Not handling the duplicates appropriately is not a trivial thing to
    omit: in the real world, I encounter bugs often as a result of people
    not handling these correctly.
*/

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
