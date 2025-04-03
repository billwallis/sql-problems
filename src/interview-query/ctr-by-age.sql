/* https://www.interviewquery.com/questions/ctr-by-age */

/*
    The recommended solution could do with some refinement 😶
*/
/* Solution (PostgreSQL) */
select
    div(
        extract(year from age(
            search_events.search_time::date,
            users.birthdate
        )),
        10
    ) as age_group,
    (
        1.0
        * count(*) filter (where has_clicked)
        / count(*)
    )::numeric(8, 5) as ctr
from search_events
    inner join users
        on search_events.user_id = users.id
where extract(year from search_events.search_time) = 2021
group by age_group
order by ctr desc, age_group desc
limit 3
;
