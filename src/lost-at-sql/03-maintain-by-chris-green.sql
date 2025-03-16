/* https://lost-at-sql.therobinlord.com/challenge-page/maintain */

/* Solution */
select
    replace(lower(vent), '0', '') as nice_vent,
    count(*) as times_checked
from vent_maintenance
group by nice_vent
having times_checked < 10
order by nice_vent
;
