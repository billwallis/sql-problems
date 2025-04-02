/* https://datalemur.com/sql-game/level4.html */

/*
    Bruh the only time "age" is an acceptable column is when it's a computed
    column 😭

    The recommended solution has `WHERE status = 'alive' AND team_id IS NOT
    NULL`, but neither of these are specified anywhere in the problem
    statement.
*/
/* Solution */
select
    team_id,
    avg(age) as avg_age,
    case
        when avg(age) <  40 then 'Fit'
        when avg(age) <= 50 then 'Grizzled'
                            else 'Elderly'
    end as age_group,
    rank() over (order by avg(age) desc) as age_rank
from player
group by team_id
having count(*) = 10
order by avg(age) desc
;
