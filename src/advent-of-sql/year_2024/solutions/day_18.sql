use day_18;

/* staff */
from staff;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with recursive hierarchy(staff_id, level) as (
        select staff_id, 1
        from staff
        where manager_id is null
    union all
        select staff.staff_id, hierarchy.level + 1,
        from hierarchy
            inner join staff
                on hierarchy.staff_id = staff.manager_id
)

select staff_id
from hierarchy
where level = (
    select level
    from hierarchy
    group by level
    order by count(*) desc, level
    limit 1
)
order by staff_id
limit 1
;
