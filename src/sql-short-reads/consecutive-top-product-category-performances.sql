/* https://sqlshortreads.com/sql-practice-problems/hard/ */


/* Sample output */
with sample(
    reporting_month,
    product_category,
    total_sale
) as (
              select '01-MAR-23', 'Hardware', '10107952' from dual
    union all select '01-APR-23', 'Hardware', '9981157' from dual
    union all select '01-AUG-23', 'Software', '9848671' from dual
    union all select '01-SEP-23', 'Software', '9532093' from dual
    union all select '01-NOV-23', 'Office Supplies', '9474652' from dual
    union all select '01-DEC-23', 'Office Supplies', '10441283' from dual
)

select *
from sample
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
This is more like it!

However, I don't think the recommended solution is correct for the given
requirements. The requirements state that:

> An instance is defined by a product category generating the most sales
> in a specific month and the following month.

The recommended solution is showing the specific month _and_ the
following month in the output, even if the following month is not an
"instance" itself as defined above.
*/


/* Solution */
with

monthly_sales as (
    select
        product_category,
        min(report_date) as reporting_month,
        sum(total_sale) as total_sale,
        dense_rank() over (
            partition by extract(month from report_date)
            order by sum(total_sale) desc
        ) as sale_rank
    from north_america_sale
    group by
        product_category,
        extract(month from report_date)
),

consecutive_instances as (
    select
        product_category,
        reporting_month,
        total_sale,
        sale_rank,
        case when (1=1
            and sale_rank = 1
            and 1 = lead(sale_rank, 1, 0) over (
                partition by product_category
                order by reporting_month
            )
        )
            then 1
            else 0
        end as consecutive_flag
    from monthly_sales
)

select
    reporting_month,
    product_category,
    total_sale
from consecutive_instances
where consecutive_flag = 1
order by
    reporting_month,
    product_category
;
