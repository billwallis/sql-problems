
/* Crime scene report */
select *
from crime_scene
where location = 'Blue Note Lounge'
;


/* Suspects */
select *
from suspects
where 1=1
    and attire = 'trench coat'
    and scar = 'left cheek'
;


/* Interviews */
select *
from interviews
where suspect_id in (3, 183)
;
