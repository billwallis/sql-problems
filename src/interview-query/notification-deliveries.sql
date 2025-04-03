/* https://www.interviewquery.com/questions/notification-deliveries */

/* Solution (PostgreSQL) */
with pushes as (
    select
        user_id,
        count(*) as pushes
    from notification_deliveries
    where created_at <= (
        select conversion_date
        from users
        where notification_deliveries.user_id = users.id
    )
    group by user_id
)

select
    count(*) as frequency,
    coalesce(pushes, 0) as total_pushes
from users
    left join pushes
        on users.id = pushes.user_id
where users.conversion_date is not null
group by total_pushes
order by
    total_pushes desc,
    frequency desc
;
