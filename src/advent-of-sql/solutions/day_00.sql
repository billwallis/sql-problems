use santa_workshop;

/* Children */
select * from Children;

/* ChristmasList */
select * from ChristmasList;

/* Gifts */
select * from Gifts;

/* Reindeer */
select * from Reindeer;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with

children_with_delivered_gifts as (
    select *
    from Children
    where exists(
        select *
        from ChristmasList
            inner join Gifts
                using (gift_id)
        where 1=1
            and ChristmasList.child_id = Children.child_id
            and ChristmasList.was_delivered
    )
    qualify count(*) over (partition by country, city) >= 5
),

city_scores as (
    select
        country,
        city,
        avg(naughty_nice_score) as avg_score
    from children_with_delivered_gifts
    group by all
)

select
    *,
    rank() over (partition by country, city order by avg_score desc) as city_rank
from city_scores
qualify city_rank <= 3
order by
    avg_score desc,
    country,
    city
;
