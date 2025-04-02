/* https://datalemur.com/sql-game/level8.html */

/*
    The problem statement is not clear enough again! In particular, it just
    says:

    > display the information for the player with...

    ...but it doesn't say explicitly that it wants only their ID, first
    name, last name, and hesitation time. Missing any of these, or including
    any extra columns, causes the solution to be incorrect.

    Additionally, I don't necessarily agree with the recommended solution
    again:

    - The "hesitation time" isn't defined. The recommended solution uses the
      `last_moved_time_seconds` column as the hesitation time, but it isn't
      made clear anywhere that that is how hesitation time is defined.

    - Similarly, the recommended solution doesn't seem to account for the
      following constraint:

      > ...the game that has the highest average hesitation time **before a
        push occurred**

      Instead, the recommended solution just takes the average of all
      hesitation times, not the average hesitation time **before a push
      occurred**.

    - The recommended solution uses the `glass_bridge` table, but that seems
      completely pointless.

    This question needs more clarity.
*/
/* Solution */
select
    game_id,
    id,
    first_name,
    last_name
from player
where 1=1
    and death_description ilike '%push%'
    and game_id = (
        select game_id
        from player
        where death_description ilike '%push%'
        group by game_id
        order by avg(last_moved_time_seconds) desc
        limit 1
    )
order by last_moved_time_seconds desc
limit 1
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Alternative solution (incorrect) */
with games as (
    select
        id,
        first_name,
        last_name,
        game_id,
        last_moved_time_seconds,
        coalesce(death_description ilike '%push%', false) as pushed_flag,
        last_moved_time_seconds - lag(last_moved_time_seconds, 1, 0) over (
            partition by game_id
            order by last_moved_time_seconds
        ) as hesitation_time,
        (
            min(last_moved_time_seconds)
            filter (where death_description ilike '%push%')
            over (partition by game_id)
        ) as first_push_time_seconds
    from player
)

select
    game_id,
    id,
    first_name,
    last_name
from games
where game_id = (
    select game_id
    from games
    where last_moved_time_seconds <= first_push_time_seconds
    group by game_id
    order by avg(hesitation_time) desc
    limit 1
)
order by
    pushed_flag desc, /* true > false, so pushed first */
    hesitation_time desc
limit 1
;
