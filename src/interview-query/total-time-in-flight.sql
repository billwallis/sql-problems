/* https://www.interviewquery.com/questions/total-time-in-flight */

/* Solution (PostgreSQL) */
with flight_parts as (
    select
        flights.plane_id,
        flights.flight_start,
        flights.flight_end,
        /*
            Since the flights are in the same timezone, we can assume that
            no flight exceeds 24 hours, so does not cover more than two
            distinct dates.
        */
        case when gs.part = 0
            then least(flights.flight_end, (flights.flight_start::date + interval '1 day')) - flights.flight_start
            else flights.flight_end - greatest(flights.flight_start, date_trunc('day', flights.flight_end))
        end as part_interval,
        case when gs.part = 0
            then flights.flight_start::date
            else flights.flight_end::date
        end as calendar_day
    from flights
        cross join generate_series(
            0,
            extract(day from flights.flight_end) - extract(day from flights.flight_start)
        ) as gs(part)
    order by
        flights.plane_id,
        flights.flight_start
)

select
    calendar_day,
    plane_id,
    sum(floor(extract(epoch from part_interval) / 60)) as time_in_min
from flight_parts
where part_interval > interval '0 seconds'
group by plane_id, calendar_day
order by plane_id, calendar_day
;
