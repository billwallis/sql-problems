/* https://www.interviewquery.com/questions/first-touch-attribution */

/*
    Why doesn't PostgreSQL have QUALIFY 😭
*/
/* Solution (PostgreSQL) */
select channel, user_id
from (
    select distinct on (user_sessions.user_id)
        max(attribution.conversion) over (
            partition by user_sessions.user_id
        ) as conversion,
        attribution.channel,
        user_sessions.user_id
    from attribution
        left join user_sessions
            using (session_id)
    order by
        user_sessions.user_id,
        user_sessions.created_at
) as first_touch
where conversion = 1
;
