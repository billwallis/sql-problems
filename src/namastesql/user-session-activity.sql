/* https://www.namastesql.com/coding-problem/118-user-session-activity */

/*
    The schema is misaligned: the problem says that the user ID column
    is `user_id`, but the actual table has `userid` instead.
*/

/* Sample data */
create table events (
    user_id    int,
    event_type varchar,
    event_time timestamp
);
insert into events
values
    (1, 'click',  '2023-09-10 09:00:00'),
    (1, 'click',  '2023-09-10 10:00:00'),
    (1, 'scroll', '2023-09-10 10:20:00'),
    (2, 'click',  '2023-09-10 09:00:00'),
    (2, 'scroll', '2023-09-10 09:20:00'),
    (2, 'click',  '2023-09-10 10:30:00')
;


/* Solution */
with sessions as (
    select
        *,
        sum(new_session::int) over (
            partition by user_id
            order by event_time
        ) as session_id
    from (
        select
            user_id,
            event_type,
            event_time,
            case when interval '30 minutes' >= event_time - lag(event_time) over (
                partition by user_id order by event_time
            )
                then false
                else true
            end as new_session
        from events
    ) as _
)

select
    user_id,
    session_id,
    min(event_time) as session_start_time,
    max(event_time) as session_end_time,
    extract(minute from max(event_time) - min(event_time)) as session_duration,
    count(*) as event_count
from sessions
group by user_id, session_id
order by user_id, session_id
;
