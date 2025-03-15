/* https://www.hackerrank.com/challenges/print-prime-numbers/problem */

/* Sample input: <=10 */

/* Sample output */
select '2&3&5&7'
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with

divisors(d) as (
        select 2
    union all
        select d + 1
        from divisors
        where d < sqrt(1000)
),

numbers(n, is_prime) as (
        select 1, 0
    union all
        select
            numbers.n + 1,
            iif(not exists(
                select *
                from divisors
                where 1=1
                    and numbers.n >= divisors.d
                    and (numbers.n + 1) % divisors.d = 0
            ), 1, 0)
        from numbers
--         where numbers.n < 10
        where numbers.n < 1000
)

select string_agg(n, '&') within group (order by n)
from numbers
where is_prime = 1
option (maxrecursion 1000)
;
