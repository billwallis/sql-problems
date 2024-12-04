use santa_workshop;

/* toy_production */
select * from toy_production;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select
    toy_id,
    len(list_filter(new_tags, tag -> not list_contains(previous_tags, tag))) as added_tags,
    len(list_intersect(previous_tags, new_tags)) as unchanged_tags,
    len(list_filter(previous_tags, tag -> not list_contains(new_tags, tag))) as removed_tags,
from toy_production
order by added_tags desc
limit 1
;
