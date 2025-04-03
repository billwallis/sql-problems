/* https://www.interviewquery.com/questions/notification-type-conversion */

/*
    Only MySQL is available for this question 😭

    The notification logic and definition of "conversion" isn't clear enough
    here and, as others have mentioned in the comments, the third test case
    is definitely wrongly stored:

    - There are only 8 events in the `notifications` table
    - The expected output is:

        | notification_type | conversion_rate |
        |-------------------+-----------------|
        | new_feature       | 0.667           |
        | promotion         | 0.250           |
        | reminder          | 0.333           |

      ...whose corresponding fractions would be:

        • new_feature = 2/3
        • promotion   = 1/4
        • reminder    = 1/3

      ...which would imply a total notification count of 10 (3 + 4 + 3).

    - But 8 != 10, so the test case solution is using a different number of
      events.
*/
/* Solution (MySQL) */
with

user_notifications as (
    select
        notifications.id as notification_id,
        notifications.type as notification_type,
        notification_events.user_id,
        notifications.product_id,
        notifications.dispatched_at,
        notification_events.clicked_at,
        lead(dispatched_at, 1, '9999-12-31 23:59:59') over (
            partition by notification_events.user_id
            order by notifications.id
        ) as disappeared_at
    from notifications
        left join notification_events
            on notifications.id = notification_events.notification_id
),

conversions as (
    select
        id,
        (
            select notification_id
            from user_notifications as events
            where 1=1
                and purchases.user_id = events.user_id
                and purchases.product_id = events.product_id
                and purchases.purchased_at >= events.clicked_at
#                 and purchases.purchased_at between events.dispatched_at
#                                                and events.disappeared_at
            order by events.clicked_at desc
            limit 1
        ) as attributing_notification_id
    from purchases
)

select
    user_notifications.notification_type,
    count(conversions.attributing_notification_id) / count(*) as conversion_rate
from user_notifications
    left join conversions
        on user_notifications.notification_id = conversions.attributing_notification_id
group by user_notifications.notification_type
order by user_notifications.notification_type
;
