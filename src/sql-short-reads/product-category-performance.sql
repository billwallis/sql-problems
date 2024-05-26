/* https://sqlshortreads.com/sql-practice-problems/hard/ */


/* Sample output */
with sample(
    category_id,
    category_description,
    order_count
) as (
              select '19', 'miscellaneous hardware (cables, screws, power supplies …)', '102' from dual
    union all select '16', 'keyboards, mouses, mouse pads', '48' from dual
    union all select '39', 'miscellaneous office supplies', '44' from dual
    union all select '15', 'processors, sound and video cards, network cards, motherboards', '42' from dual
    union all select '32', 'office supplies for daily use (pencils, erasers, staples, …)', '34' from dual
    union all select '14', 'memory components/upgrades', '13' from dual
    union all select '24', 'operating systems', '12' from dual
    union all select '31', 'capitalizable assets (desks, chairs, phones …)', '9' from dual
    union all select '17', 'other peripherals (CD-ROM, DVD, tape cartridge drives, …)', '8' from dual
    union all select '13', 'harddisks', '8' from dual
)

select *
from sample
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
This is **not** a hard question; you just need to know the table
relationships and `DENSE_RANK`.
*/


/* Solution */
with category_counts as (
    select
        category_id,
        max(categories_tab.category_description) as category_description,
        count(*) as order_count,
        dense_rank() over (order by count(*)) as category_rank_lower,
        dense_rank() over (order by count(*) desc) as category_rank_upper
    from orders
        inner join order_items         using (order_id)
        inner join product_information using (product_id)
        inner join categories_tab      using (category_id)
    where extract(year from cast(substr(orders.order_date, 1, 10) as date)) = 2007  /* Just because mine is saved as text locally */
    group by category_id
)

select
    category_id,
    category_description,
    order_count
from category_counts
where 0=1
    or category_rank_lower <= 5
    or category_rank_upper <= 5
order by
    order_count desc,
    category_id
;
