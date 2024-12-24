use day_13;

/* contact_list */
from contact_list;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
from (
    from contact_list
    select split(unnest(email_addresses), '@')[-1] as domain
)
group by domain
order by count(*) desc
limit 1
;
