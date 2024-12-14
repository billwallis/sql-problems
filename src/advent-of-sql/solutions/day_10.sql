use day_10;

/* Drinks */
from Drinks;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select "date"
from Drinks
group by "date", drink_name
having (drink_name, sum(quantity)) in (
    ('Hot Cocoa', 38),
    ('Peppermint Schnapps', 298),
    ('Eggnog', 198),
)
qualify 3 = count(*) over (partition by "date")
limit 1
;
