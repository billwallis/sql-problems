
/* Crime scene report */
select *
from crime_scene
where location = 'Fontainebleau Hotel'
;


/* First guest (famous actor) */
select *
from guest
where occupation = 'Actor'
;

/* Second guest (woman, consultant for big company, first name ends with "an") */
select *
from guest
where 1=1
    and occupation = 'Consultant'
    and name like '%an %'
;


/* Witness statements */
select *
from witness_statements
where guest_id in (43, 129, 164, 189, 192, 116)
order by guest_id, id
;


/* First suspect (invitation ending with "-R", navy suit and a white tie) */
select *
from guest
    inner join attire_registry
        on guest.id = attire_registry.guest_id
where 1=1
    and guest.invitation_code like '%-R'
    and attire_registry.note like '%navy suit%'
    and attire_registry.note like '%white tie%'
;

/* Second suspect (marina, dock 3) */
select *
from marina_rentals
where 1=1
    and dock_number = 3
    and rental_date = 19870520
;


/* Final interviews */
select *
from final_interviews
where guest_id = 105
;
