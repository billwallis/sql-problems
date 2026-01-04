use day_02;

/* Snowball categories */
from snowball_categories;

/* Snowball inventory */
from snowball_inventory;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select category_name, sum(quantity) as quantity
from snowball_inventory
    semi join snowball_categories as sc(_, category_name)
        using (category_name)
where quantity > 0
group by category_name
order by quantity
;
