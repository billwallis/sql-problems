use santa_workshop;

/* contact_list */
select * from contact_list;

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
