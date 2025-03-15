/* https://platform.stratascratch.com/coding/10284-popularity-percentage */

/* Sample data */
create table facebook_friends (
    user1 int,
    user2 int
);
insert into facebook_friends
values
    (2, 1),
    (1, 3),
    (4, 1),
    (1, 5)
;


/* Solution */
with friends(user_id, friend_id) as (
        select user1, user2 from facebook_friends
    union
        select user2, user1 from facebook_friends
)

select
    user_id,
    100.0 * count(*) / count(*) over () as popularity
from friends
group by user_id
order by user_id
;

/*
    Bruh seriously, this isn't "hard"  ¯\_(ツ)_/¯
*/
