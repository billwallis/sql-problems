use day_23;

/* sequence_table */
from sequence_table;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with series(id) as (
    from generate_series(
        (select min(id) from sequence_table),
        (select max(id) from sequence_table)
    )
)

from (
    from (
        from series anti join sequence_table using (id)
        select *, id - 1 != lag(id, 1, -1) over (order by id) as group_start_flag
    )
    select *, sum(group_start_flag::int) over (order by id) as group_id
)
select string_agg(id, ',' order by id)
group by group_id
order by group_id
;
