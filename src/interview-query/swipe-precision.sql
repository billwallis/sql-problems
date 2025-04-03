/* https://www.interviewquery.com/questions/swipe-precision */

/* Solution (PostgreSQL) */
with variant_swipes as (
    select
        user_id,
        variants.variant,
        count(*) as total_swipes,
        /*
            The DDL says that `is_right_swipe` is a boolean, but it's
            actually an integer 🙄
        */
--         count(*) filter (where is_right_swipe) as right_swipes,
        count(*) filter (where is_right_swipe = 1) as right_swipes,
        case
            when count(*) < 10  then 0
            when count(*) < 50  then 10
            when count(*) < 100 then 50
                                else 100
        end as swipe_threshold
    from swipes
        inner join variants
            using (user_id)
    group by
        user_id,
        variants.variant
)

select
    avg(right_swipes) as mean_right_swipes,
    count(*) as num_users,
    swipe_threshold,
    variant
from variant_swipes
group by
    swipe_threshold,
    variant
;
