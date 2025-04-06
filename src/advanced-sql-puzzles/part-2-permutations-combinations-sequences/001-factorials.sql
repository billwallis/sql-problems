with recursive factorials(number, factorial) as (
        select 1, 1
    union all
        select
            factorials.number + 1 as number_,
            factorials.factorial * number_,
        from factorials
        where number_ <= 10
)

from factorials
;
