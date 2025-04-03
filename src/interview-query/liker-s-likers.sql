/* https://www.interviewquery.com/questions/liker-s-likers */

/*
    Another not "hard" one -- this is just a simpler version of the "John's
    New Best Friend" question 🙄

    Nitpick, but using "count" and "user" as the result set column names is
    a bit crap.
*/
/* Solution (PostgreSQL) */
select
    count(distinct likers_likes.liker_id) as count,
    likes.liker_id as user
from likes
    inner join likes as likers_likes
        on likes.liker_id = likers_likes.user_id
group by likes.liker_id
;
