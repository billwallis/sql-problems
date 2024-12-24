use day_15;

/* sleigh_locations */
from sleigh_locations;

/* areas */
from areas;


------------------------------------------------------------------------
------------------------------------------------------------------------

install spatial;
load spatial;

/* Solution */
select place_name
from areas
where polygon.st_contains((
    select max_by(coordinate, timestamp)
    from sleigh_locations
))
;
