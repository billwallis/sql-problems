/* https://www.interviewquery.com/questions/paired-products */

/*
    No transaction ID? Poor data model 👀

    The problem statement should clarify that the result set _also_ needs to
    be sorted by `p1`!
*/
/* Solution (PostgreSQL) */
with transaction_products as (
    select
        rank() over (
            order by
                transactions.user_id,
                transactions.created_at
        ) as transaction_id,
        products.name as product_name
    from transactions
        inner join products
            on transactions.product_id = products.id
)

select
    t1.product_name as p1,
    t2.product_name as p2,
    count(*) as qty
from transaction_products as t1
    inner join transaction_products as t2
        on  t1.transaction_id = t2.transaction_id
        and t1.product_name < t2.product_name
group by p1, p2
order by qty desc, p1
limit 5
;
