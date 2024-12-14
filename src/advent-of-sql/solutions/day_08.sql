use day_08;

/* staff */
from staff;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with recursive hierarchy as (
        select distinct manager_id, 1 as i
        from staff
        where manager_id is not null
    union all
        select staff.staff_id, hierarchy.i + 1,
        from hierarchy
            inner join staff
                using (manager_id)
)

select max(i)
from hierarchy
;
