with recursive

/* Data */
temperature_data(temp_id, temp_value) as (
    values
        (1, 52),
        (2, null),
        (3, null),
        (4, 65),
        (5, null),
        (6, 72),
        (7, null),
        (8, 70),
        (9, null),
        (10, 75),
        (11, null),
        (12, 80)
)

/* Solution */
select
    temp_id,
    coalesce(
        temp_value,
        greatest(
            last_value(temp_value ignore nulls) over (
                order by temp_id
                rows between unbounded preceding and current row
            ),
            first_value(temp_value ignore nulls) over (
                order by temp_id
                rows between current row and unbounded following
            )
        )
    ) as temp_value
from temperature_data
order by temp_id
;
