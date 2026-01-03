use day_11;

/* Behavior logs */
from behavior_logs;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select
    child_id,
    child_name,
    behavior_date,
    avg(score) over seven_day_rolling_avg as score_avg,
from behavior_logs
window seven_day_rolling_avg as (
    partition by child_id
    order by behavior_date
    rows 6 preceding
)
qualify 1=1
    and count(*) over seven_day_rolling_avg = 7
    and score_avg < 0
order by behavior_date, child_name
;
