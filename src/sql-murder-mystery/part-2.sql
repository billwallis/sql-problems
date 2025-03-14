/*
    The murderer was hired -- gasp!

    Find out who hired them!

    (Should take around 5 minutes, but give up to 10)
*/


/* The real villain! */
with cte_event_checkins as (
    select
        person_id,
        count(*)
    from facebook_event_checkin
    where event_name = 'SQL Symphony Concert'
      and "date" like '201712%'
    group by person_id
    having count(*) = 3
)

select p.name
from person as p
    inner join cte_event_checkins as cec
        on p.id = cec.person_id
    inner join drivers_license as dl
        on p.license_id = dl.id
;
