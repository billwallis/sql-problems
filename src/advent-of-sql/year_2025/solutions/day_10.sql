use day_10;

/* Deliveries */
from deliveries;

/* Misdelivered presents */
from misdelivered_presents;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
    DuckDB doesn't have data-modifying CTEs, so doing this the
    "old-fashioned" way 😋

    As for the author's solution, they should use some transaction control.
    That's more important than niche data-modifying CTEs in my opinion.
*/

/* Solution */
start transaction;

insert into misdelivered_presents(
    id,
    child_name,
    delivery_location,
    gift_name,
    scheduled_at,
    flagged_at,
    reason
)
select
    id,
    child_name,
    delivery_location,
    gift_name,
    scheduled_at,
    current_timestamp,
    'Invalid delivery location'
from deliveries
where delivery_location in (
    'Volcano Rim',
    'Drifting Igloo',
    'Abandoned Lighthouse',
    'The Vibes'
);
delete from deliveries
where delivery_location in (
    'Volcano Rim',
    'Drifting Igloo',
    'Abandoned Lighthouse',
    'The Vibes'
)
returning *
;

-- commit;
rollback;
