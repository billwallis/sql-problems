with recursive permutations(max_number, number, permutation) as (
        select 3, 1, '1'
    union all
        select
            permutations.max_number,
            permutations.number + 1 as next_number,
            concat(
                permutations.permutation,
                operations.op,
                next_number
            ),
        from permutations
            cross join (values (''), ('+'), ('-')) as operations(op)
        where next_number <= max_number
)

select
    permutation,
    (regexp_extract_all(permutation, '[+-]?\d+')::int[]).list_sum() as sum,
from permutations
where max_number = number
;

/*
    This is a hacky solution, and I'm not happy with it.
*/


------------------------------------------------------------------------
------------------------------------------------------------------------

with recursive permutations(number, permutation, term, sum) as (
        select 3, '3', 3, 0
    union all
        select
            permutations.number - 1 as next_number,
            concat(
                next_number,
                operations.op,
                permutations.permutation
            ),
            case operations.op
                when ''  then concat(next_number, permutations.term)::int
                when '+' then permutations.term::int
                when '-' then permutations.term::int
            end as term_,
            case operations.op
                when ''  then permutations.sum
                when '+' then permutations.sum + term_
                when '-' then permutations.sum - term_
            end,
        from permutations
            cross join (values (''), ('+'), ('-')) as operations(op)
        where next_number > 0
)

from permutations
where number = 1
;
