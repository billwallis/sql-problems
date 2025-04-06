with recursive permutations(number, permutation) as (
        select 3, []::int[]
    union all
        select distinct
            permutations.number,
            permutations.permutation.list_append(gs.n) as permutation_,
        from permutations
            inner join generate_series(1, permutations.number) as gs(n)
                on not permutations.permutation.list_contains(gs.n)
        where len(permutation_) <= 3
)

from permutations
where number = len(permutation)
order by permutation
;
