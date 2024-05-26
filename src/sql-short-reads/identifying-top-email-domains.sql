/* https://sqlshortreads.com/sql-practice-problems/hard/ */


/* Sample output */
with sample(
    domain,
    email_count
) as (
              select 'DUNLIN.EXAMPLE.COM', '8' from dual
    union all select 'ANHINGA.EXAMPLE.COM', '7' from dual
)

select *
from sample
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
This is **not** hard.
*/


/* Solution */
with email_counts as (
    select
        substr(cust_email, 1 + instr(cust_email, '@')) as domain,
        count(*) as email_count,
        dense_rank() over (order by count(*) desc) as domain_rank
    from customers
    group by substr(cust_email, 1 + instr(cust_email, '@'))
)

select
    domain,
    email_count
from email_counts
where domain_rank <= 2
order by email_count desc
;
