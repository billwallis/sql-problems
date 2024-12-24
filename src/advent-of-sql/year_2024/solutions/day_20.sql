use day_20;

/* employees */
from web_requests;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
from (
    from web_requests
    select url, split(split(url, '?')[-1], '&') as params
)
select url
where params.list_contains('utm_source=advent-of-sql')
order by
    params.list_transform(p -> p.split('=')[1]).list_unique() desc,
    url
limit 1
;
