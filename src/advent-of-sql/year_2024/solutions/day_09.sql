use day_09;

/* training_sessions */
from training_sessions;

/* reindeers */
from reindeers;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
from (
    select reindeer_id, avg(speed_record) as avg_speed
    from training_sessions
    group by reindeer_id, exercise_name
) left join reindeers using (reindeer_id)
select
    reindeer_name,
    round(max(avg_speed), 2) as max_avg_speed
where reindeer_name != 'Rudolph'
group by reindeer_name
order by max_avg_speed desc
limit 3
;
