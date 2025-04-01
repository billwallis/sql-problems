/* https://quip.com/2gwZArKuWk7W */

/* Sample data */
create or replace table tree (
    node int,
    parent int,
);
insert into tree
values
    (1, 2),
    (2, 5),
    (3, 5),
    (4, 3),
    (5, null),
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with

roots as (
    select node, 'Root' as label
    from tree
    where parent is null
),

leaves as (
    select node, 'Leaf' as label
    from tree as l
        anti join tree as r
            on l.node = r.parent
)

select
    node,
    coalesce(
        roots.label,
        leaves.label,
        'Inner'
    ) as label
from tree
    left join roots
        using (node)
    left join leaves
        using (node)
order by node
;
