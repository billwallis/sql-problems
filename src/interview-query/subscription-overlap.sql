/* https://www.interviewquery.com/questions/subscription-overlap */

/*
    Hmm, not "hard" 🤷‍♂️
*/
/* Solution (PostgreSQL) */
select
    exists(
        select *
        from subscriptions as i
        where 1=1
            and o.user_id != i.user_id
            and o.end_date >= i.start_date
            and o.start_date <= i.end_date
    ) as overlap,
    user_id
from subscriptions as o
;
