
/* Crime scene report */
select *
from crime_scene
where location = 'West Hollywood Records'
;


/* Witness reports */
select *
from witnesses
where crime_scene_id = 65
;


/* Suspects */
select *
from suspects
where 1=1
    and bandana_color = 'red'
    and accessory = 'gold watch'
;


/* Interviews */
select *
from interviews
where suspect_id in (35, 44, 97)
;
