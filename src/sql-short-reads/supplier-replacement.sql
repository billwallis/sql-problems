/* https://sqlshortreads.com/sql-practice-problems/hard/ */


/* Sample output */
with sample(
    supplier_id,
    product_count
) as (
              select '103089', '10' from dual
    union all select '103080', '7' from dual
    union all select '103093', '6' from dual
    union all select '103088', '4' from dual
    union all select '103086', '3' from dual
    union all select '103082', '3' from dual
    union all select '103094', '2' from dual
    union all select '103096', '1' from dual
    union all select '103087', '1' from dual
    union all select '103083', '1' from dual
)

select *
from sample
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
This is **not** hard, and this is _barely_ even medium.
*/


/* Solution */
select
    supplier_id,
    count(*) as product_count
from product_information
    inner join categories_tab using (category_id)
where 1=1
    and product_information.supplier_id != 103092
    and substr(categories_tab.category_name, 1, 8) = 'software'
group by supplier_id
order by product_count desc
;
