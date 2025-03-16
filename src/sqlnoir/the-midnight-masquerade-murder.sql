
/* Crime scene report */
select *
from crime_scene
where location like '%Coconut Grove%'
;


/* Witness statements */
select *
from witness_statements
where crime_scene_id = 75
;


/* Hotel check-ins */
select *
from hotel_checkins
where 1=1
    and hotel_name = 'The Grand Regency'
    and room_number = 707
    and check_in_date = 19871030
;


/* Phone records */
select *
from phone_records
where call_date = 19871030
;
select *
from phone_records
where 0=1
    or caller_id = 58
    or recipient_id = 58
;


/* Hotel check-ins */
select *
from hotel_checkins
where person_id in (11, 58, 133)
;


/* Surveillance records */
select *
from surveillance_records
where hotel_checkin_id = 119
;


/* People */
select *
from person
where 0=1
    or id in (11, 58, 133)
    or occupation = 'Carpenter'
;


/* Interviews */
select *
from final_interviews
where person_id in (
    select id
    from person
    where 0=1
        or id in (11, 58, 133)
        or occupation = 'Carpenter'
);
