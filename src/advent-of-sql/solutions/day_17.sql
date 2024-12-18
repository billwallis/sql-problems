use day_17;

/* Workshops */
from Workshops;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select strftime(max(timezone(timezone, '2024-12-25'::date + business_start_time)), '%H:%M:%S')
from Workshops
;
