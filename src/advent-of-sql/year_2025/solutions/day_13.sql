use day_13;

/* Travel manifests */
from travel_manifests;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
install webbed from community;
load webbed;

from (
    select
        *,
        xml_extract_elements(manifest_xml, '//manifest//passengers//passenger') as passengers,
    from travel_manifests
    where vehicle_id.starts_with('CARGO-')
)
select
    vehicle_id,
    departure_time,
    sum(length(passengers)) as passenger_count,
group by vehicle_id, departure_time
having passenger_count > 20
order by departure_time
;
