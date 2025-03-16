/* https://lost-at-sql.therobinlord.com/challenge-page/identify */

/* Solution */
with old as (
    select
        id_number,
        occupation,
        first_name || ' ' || last_name as Full_Name
    from old_database
)

select
    start_dates.employment_start_date,
    old.Full_Name,  /* Why is this case-sensitive?! :( */
    new_database.occupation as latest_occupation,
    old.occupation as previous_occupation
from start_dates
    full join new_database
        using (id_number, date_of_birth)
    full join old
        on new_database.full_name = old.full_name
where 1=1
    and start_dates.employed_or_departed = 'Employed'
    and new_database.occupation != old.occupation
;
