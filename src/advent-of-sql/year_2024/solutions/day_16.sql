use day_16;

/* sleigh_locations */
from sleigh_locations;

/* areas */
from areas;


------------------------------------------------------------------------
------------------------------------------------------------------------

install spatial;
load spatial;

/* Solution */
select areas.place_name
from sleigh_locations as sl
    left join areas
        on areas.polygon.st_contains(sl.coordinate)
window places as (partition by areas.place_name)
order by max(sl.timestamp) over places - min(sl.timestamp) over places desc
limit 1
;
