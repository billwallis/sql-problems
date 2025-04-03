/* https://www.interviewquery.com/questions/page-recommendations */

/*
    Not sure this one is "hard" tbh 🤷‍♂️
*/
/* Solution (PostgreSQL) */
with recommendation_users as (
    select
        recommendations.page_id,
        users.postal_code,
        count(*) as users,
        sum(count(*)) over (partition by recommendations.page_id) as total_users
    from recommendations
        inner join users
            on recommendations.user_id = users.id
    group by
        recommendations.page_id,
        users.postal_code
)

select
    page_id as page,
    postal_code,
    coalesce(
        1.0 * recommendation_users.users / recommendation_users.total_users,
        0
    ) as percentage
from page_sponsorships
    left join recommendation_users
        using (page_id, postal_code)
;
