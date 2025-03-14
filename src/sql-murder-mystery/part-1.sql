/*
    There's been a murder in SQL City on January 15th, 2018.

    Find out who did it!

    (Should take around 15 minutes, but give up to 20)
*/


/* Crime Scene Report */
select *
from crime_scene_report
where type = 'murder'
  and "date" = 20180115
  and city = 'SQL City'
;
/*
    Witness 1: lives at the last house on "Northwestern Dr"
    Witness 2: Annabel, lives somewhere on "Franklin Ave"
*/


/* Witnesses */
with cte_witnesses as (
    select
        id as person_id,
        name,
        address_street_name
    from person
    where address_street_name = 'Northwestern Dr'
       or (address_street_name = 'Franklin Ave' and "name" like 'Annabel%')
    order by
        address_street_name,
        /*
            With the LIMIT, this keeps the last house on Northwestern Dr because
            there is only one person on Franklin Ave called Annabel.
        */
        address_number desc
    limit 2
)

select
    cte_witnesses.person_id,
    cte_witnesses.name,
    cte_witnesses.address_street_name,
    interview.transcript
from interview
    inner join cte_witnesses using (person_id)
;
/*
Witness 1 (14887): lives at the last house on "Northwestern Dr"
----------
I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag.
The membership number on the bag started with "48Z". Only gold members have
those bags. The man got into a car with a plate that included "H42W".


Witness 2 (16371): Annabel, lives somewhere on "Franklin Ave"
----------
I saw the murder happen, and I recognized the killer from my gym when I was
working out last week on January the 9th.
*/


/* The murderer! */
select gfnm.name
from get_fit_now_member as gfnm
    inner join get_fit_now_check_in as gfnci
        on gfnm.id = gfnci.membership_id
    inner join person as p
        on gfnm.person_id = p.id
    inner join drivers_license as dl
        on p.license_id = dl.id
where gfnm.membership_status = 'gold'
  and gfnm.id like '48Z%'
  and gfnci.check_in_date = 20180109
  and dl.plate_number like '%H42W%'
;
