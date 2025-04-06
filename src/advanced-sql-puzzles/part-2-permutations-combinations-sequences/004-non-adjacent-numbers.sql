with recursive

inputs(n) as (
    from generate_series(1, 4)
),

permutations(number, permutation) as (
        select n, [n]
        from inputs
    union all
        select
            inputs.n,
            permutations.permutation.list_append(inputs.n),
        from permutations
            inner join inputs
                on  not permutations.permutation.list_contains(inputs.n)
                and abs(permutations.number - inputs.n) > 1
)

select permutation
from permutations
qualify len(permutation) = max(len(permutation)) over ()
;
