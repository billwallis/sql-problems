/* https://www.interviewquery.com/questions/johns-new-best-friend */

/*
    Only MySQL is available for this question 😭
*/
/* Solution (MySQL) */
with

mutual_friends(user_id, points) as (
    select mutuals.friend_id, 3
    from friends
        inner join friends as mutuals
            on friends.friend_id = mutuals.user_id
            and mutuals.friend_id != friends.user_id
    where friends.user_id = 3
),

mutual_pages(user_id, points) as (
    select mutuals.user_id, 2
    from likes
        inner join likes as mutuals
            on likes.page_id = mutuals.page_id
            and mutuals.user_id != likes.user_id
    where likes.user_id = 3
),

excluded(user_id) as (
        select friend_id
        from friends
        where user_id = 3
    union all
        select blocked_id
        from blocks
        where user_id = 3
)

select
    users.name as potential_friend_name,
    (0
        + coalesce(mutual_friends.points, 0)
        + coalesce(mutual_pages.points, 0)
    ) as friendship_points
from users
    left join mutual_friends
        using (user_id)
    left join mutual_pages
        using (user_id)
where users.user_id not in (
    select user_id
    from excluded
)
order by friendship_points desc
limit 1
;
