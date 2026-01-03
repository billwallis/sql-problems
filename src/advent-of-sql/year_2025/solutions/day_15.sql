use day_15;

/* System dispatches */
from system_dispatches;

/* Incoming dispatches */
from incoming_dispatches;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
start transaction;

insert into system_dispatches (system_id, dispatched_at, payload)
    select system_id, dispatched_at, payload
    from incoming_dispatches
    on conflict do nothing
;
from (
    from system_dispatches
    where payload->>'source' = 'primary'
    qualify 1 = row_number() over (
        partition by system_id
        order by dispatched_at desc
    )
)
select string_agg(marker_letter, '' order by dispatched_at)
;

-- commit;
rollback;
