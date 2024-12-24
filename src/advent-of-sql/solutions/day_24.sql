use day_24;

/* users */
from users;

/* songs */
from songs;

/* user_plays */
from user_plays;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
from user_plays inner join songs using (song_id)
select songs.song_title
group by songs.song_title
order by
    count(*) desc,
    sum((0=1
        or user_plays.duration is null
        or user_plays.duration != coalesce(songs.song_duration, user_plays.duration)
    )::int)
limit 1
;
