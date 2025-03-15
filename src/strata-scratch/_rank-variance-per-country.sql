/* https://platform.stratascratch.com/coding/2007-rank-variance-per-country */

/*
    This is a premium question, so I can't verify my solution.
*/


/* Solution */
with country_comments as (
    select
        to_char(fb_comments_count.created_at, 'YYYY-MM') as comment_month,
        fb_active_users.country,
        sum(fb_comments_count.number_of_comments) as number_of_comments,
        dense_rank() over (
            partition by to_char(fb_comments_count.created_at, 'YYYY-MM')
            order by sum(fb_comments_count.number_of_comments) desc
        ) as country_rank
    from fb_comments_count
        /* Purposefully drop unmatched rows */
        inner join fb_active_users
            using (user_id)
    where fb_comments_count.created_at between '2019-12-01' and '2020-01-31'
    group by
        to_char(fb_comments_count.created_at, 'YYYY-MM'),
        fb_active_users.country
)

select jan_2020.country
from country_comments as jan_2020
    left join country_comments as dec_2019
        on  jan_2020.country = dec_2019.country
        and dec_2019.comment_month = '2019-12'
where 1=1
    and jan_2020.comment_month = '2020-01'
    and jan_2020.country_rank > dec_2019.country_rank
;
