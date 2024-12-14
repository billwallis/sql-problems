use day_11;

/* TreeHarvests */
from TreeHarvests;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with season_order(season, season_order) as (
    values
        ('Spring', 1),
        ('Summer', 2),
        ('Fall',   3),
        ('Winter', 4),
)

from TreeHarvests
    inner join season_order
        using (season)
select round(avg(TreeHarvests.trees_harvested) over (
    partition by TreeHarvests.field_name
    order by TreeHarvests.harvest_year, season_order.season_order
    rows 2 preceding
), 2) as three_season_moving_avg
order by three_season_moving_avg desc
limit 1
;
