use day_14;

/* Mountain network */
from mountain_network;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with recursive paths(current_node, path) as (
        select 'Jake''s Lift', ['Jake''s Lift']
    union all
        select
            mountain_network.to_node,
            paths.path.list_append(mountain_network.to_node),
        from paths
            inner join mountain_network
                on  paths.current_node = mountain_network.from_node
                and not paths.path.list_contains(mountain_network.to_node)
)

select path
from paths
where current_node = 'Maverick'
;
