
/* Crime scene report */
select *
from crime_scene
where location = 'Coral Bay Marina'
;


/* Person 1 */
select *
from person
where address like '3__ Ocean Drive'
;


/* Person 2 */
select *
from person
where name like '%ul %ez'
;


/* Interviews */
select *
from interviews
where person_id in (101, 102)
;


/* Hotel check-ins */
select *
from hotel_checkins
where 1=1
    and check_in_date = 19860813
    and hotel_name like '%Sunset%'
;


/* Surveillance records */
select *
from surveillance_records
where 1=1
    and suspicious_activity is not null
    and hotel_checkin_id in (
        select id
        from hotel_checkins
        where 1=1
            and check_in_date = 19860813
            and hotel_name like '%Sunset%'
    )
;


/* People */
select *
from person
where id in (6, 8)
;


/* Confessions */
select *
from confessions
where person_id in (6, 8)
;
