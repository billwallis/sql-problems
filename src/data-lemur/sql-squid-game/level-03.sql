/* https://datalemur.com/sql-game/level3.html */

/*
    The problem statement is not clear enough. The statement:

    > "Analyze the average completion times..."

    ...does not tell me to average the average completion times given there
    is already an "average completion time" column in the data 🤔
*/
/* Solution */
with

extreme_months as (
    select
        month,
        avg_temperature = min(avg_temperature) over () as is_min_temp,
        avg_temperature = max(avg_temperature) over () as is_max_temp
    from monthly_temperatures
),

last_20_years as (
    select
        shape,
        average_completion_time,
        extract(month from date) as month
    from honeycomb_game
    where date >= current_date - interval '20 years'
)

select
    month,
    shape,
    avg(average_completion_time) as avg_time
from last_20_years
where month in (
    select month
    from extreme_months
    where is_min_temp or is_max_temp
)
group by month, shape
order by avg_time
;
