/* https://datalemur.com/sql-game/level9.html */

/*
    I don't like that the recommended solution hard-codes values that are
    derived from the initial logs 😠

    Other than that, this question is good.
*/
/* Solution */
with deviated_guards as (
    select
        guard.id as guard_id,
        logs.door_location,
        most_recent_squid_game.start_time,
        most_recent_squid_game.end_time
    from guard
        inner join daily_door_access_logs as logs
            on  guard.id = logs.guard_id
            and guard.assigned_post != logs.door_location
            and logs.access_time between guard.shift_start and guard.shift_end
        inner join (
            select start_time, end_time
            from game_schedule
            where type = 'Squid Game'
            order by date desc
            limit 1
        ) as most_recent_squid_game
            on  guard.shift_start <= most_recent_squid_game.start_time
            and guard.shift_end >= most_recent_squid_game.end_time
)

select
    guard_id,
    access_time
from daily_door_access_logs as logs
where exists(
    select *
    from deviated_guards
    where 1=1
        and logs.guard_id != deviated_guards.guard_id
        and logs.door_location = deviated_guards.door_location
        and logs.access_time between deviated_guards.start_time
                                 and deviated_guards.end_time
);
