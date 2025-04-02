/* https://datalemur.com/sql-game/level6.html */

/*
    This is a pretty good question!
*/
/* Solution */
with joined as (
    select
        failure_incidents.failed_equipment_id as equipment_id,
        failure_incidents.failure_date,
        equipment.game_type,
        equipment.installation_date,
        equipment.supplier_id,
        suppliers.name as supplier_name
    from failure_incidents
        left join equipment
            on failure_incidents.failed_equipment_id = equipment.id
        left join suppliers
            on equipment.supplier_id = suppliers.id
)

select floor(avg(days_to_first_failure) / 365.2425) as avg_lifespan
from (
    select
        equipment_id,
        min(failure_date) - any_value(installation_date) as days_to_first_failure
    from joined
    where (game_type, supplier_id) in (
        select game_type, supplier_id
        from joined
        group by game_type, supplier_id
        order by
            sum(count(*)) over (partition by game_type) desc,
            count(*) desc
        limit 1
    )
    group by equipment_id
)
;
