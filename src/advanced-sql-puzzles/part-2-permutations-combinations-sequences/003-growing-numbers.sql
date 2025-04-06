with recursive permutations(number, i, permutation) as (
        select 5, 1, '1'
    union all
        select
            permutations.number,
            permutations.i + 1 as i_,
            permutations.permutation || i_,
        from permutations
        where i_ <= number
)

select permutation
from permutations
order by permutation
;
