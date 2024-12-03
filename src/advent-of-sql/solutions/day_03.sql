use santa_workshop;

/* christmas_menus */
select * from christmas_menus;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with food_items(food_item_id) as (
    select unnest(regexp_extract_all(menu_data, '.*<food_item_id>(\d+)</food_item_id>.*', 1))
    from christmas_menus
    where 78 < coalesce(
        regexp_extract_all(menu_data, '.*<total_present>(\d+)</total_present>.*', 1)[1],
        regexp_extract_all(menu_data, '.*<total_guests>(\d+)</total_guests>.*', 1)[1],
        regexp_extract_all(menu_data, '.*<total_count>(\d+)</total_count>.*', 1)[1]
    )::int
)

select food_item_id
from food_items
group by food_item_id
order by count(*) desc
limit 1
;
