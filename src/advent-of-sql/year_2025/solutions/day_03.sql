use day_03;

/* Hotline messages */
from hotline_messages;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
begin transaction;

update hotline_messages
set status = 'approved'
where 1=1
    and transcript ilike '%sorry%'
    and status is null
returning *
;

delete from hotline_messages
where 0=1
    or tag in (
        'penguin prank',
        'time-loop advisory',
        'possible dragon',
        'nonsense alert'
    )
    or caller_name = 'Test Caller'
returning *
;

select
    count(*) filter (where status = 'approved') as approved,
    count(*) filter (where status is null) as needs_review,
from hotline_messages
;

-- commit;
rollback;
