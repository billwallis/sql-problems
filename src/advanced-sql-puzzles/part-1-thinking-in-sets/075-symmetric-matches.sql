with

/* Data */
boxes(box, length, width, height) as (
    values
        ('A', 10, 25, 15),
        ('B', 15, 10, 25),
        ('C', 10, 15, 25),
        ('D', 20, 30, 30),
        ('E', 30, 30, 20),
)

/* Solution */
select
    box,
    dense_rank() over (
        order by list_sort([length, width, height])
    ) as grouping_id,
from boxes
;
