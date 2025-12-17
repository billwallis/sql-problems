use day_06;

/* Families */
from families;

/* Deliveries assigned */
from deliveries_assigned;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select
    gs.gift_date::date as unassigned_date,
    families.family_name as "name",
from families
    cross join generate_series(
        '2025-12-15'::date,
        '2025-12-31'::date,
        interval '1 day'
    ) as gs(gift_date)
    anti join deliveries_assigned
        on  families.id = deliveries_assigned.family_id
        and gs.gift_date::date = deliveries_assigned.gift_date
order by unassigned_date, "name"
;
