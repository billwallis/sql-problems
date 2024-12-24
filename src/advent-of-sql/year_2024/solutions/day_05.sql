use day_05;

/* toy_production */
from toy_production;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select
    production_date,
    toys_produced,
    lag(toys_produced) over (order by production_date) as previous_day_production,
    toys_produced - previous_day_production as production_change,
    100 * production_change / previous_day_production as production_change_percentage,
from toy_production
order by production_change_percentage desc
limit 1
;
