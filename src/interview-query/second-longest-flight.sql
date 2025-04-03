/* https://www.interviewquery.com/questions/second-longest-flight */

/*
    Bruh seriously, just because a solution uses a window function does not
    automatically make it a "hard" question 😤
*/
/* Solution (PostgreSQL) */
select
    destination_location,
    flight_end,
    flight_start,
    id,
    source_location
from (
    select
        *,
        rank() over (
            partition by
                least(destination_location, source_location),
                greatest(destination_location, source_location)
            order by extract(minutes from flight_end - flight_start) desc
        ) as duration_rank
    from flights
) as flight_durations
where duration_rank = 2
;
