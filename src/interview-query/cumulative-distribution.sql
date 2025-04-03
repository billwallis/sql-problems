/* https://www.interviewquery.com/questions/cumulative-distribution */

/*
    Bruh I don't really understand the problem statement 😶

    What are "bin bucket class intervals"?

    Had to use the hints to understand what they wanted in this question.
*/
/* Solution (PostgreSQL) */
with user_frequency as (
    select
        users.id,
        coalesce(num_comments.frequency, 0) as frequency
    from users
        left join (
            select
                user_id,
                count(*) as frequency
            from comments
            group by user_id
        ) as num_comments
            on users.id = num_comments.user_id
)

select
    sum(count(*)) over (order by frequency) as cum_total,
    frequency
from user_frequency
group by frequency
order by frequency
;
