/* https://www.interviewquery.com/questions/trial-test-analysis */

/*
    Only MySQL is available for this question 😭

    As mentioned in the comments, the problem statement is incorrect (again)
    🙄 It says that:

    > For control group: Count as converted if they subscribed anytime after
      entering the experiment

    ...but the expected result set implies that this _should_ say:

    > For control group: Count as converted if they subscribed anytime after
      entering the experiment AND haven’t cancelled

    Problem statement confusion aside, this is not a "hard" problem at all.
*/
/* Solution (MySQL) */
with experiment_subscription as (
    select
        ab_tests.variant,
        case ab_tests.variant
            when 'control'
                then (1=1
                    and subscriptions.created_at is not null
                    and subscriptions.created_at > ab_tests.created_at
                    and subscriptions.cancelled_at is not null
                )
            when 'trial'
                then (1=1
                    and subscriptions.created_at is not null
                    and subscriptions.created_at > ab_tests.created_at
                    and (0=1
                        or subscriptions.cancelled_at is null
                        or 7 <= datediff(subscriptions.cancelled_at, subscriptions.created_at)
                    )
                )
        end as converted_flag
    from ab_tests
        left join subscriptions
            using (user_id)
)

select
    variant,
    round(100.0 * sum(converted_flag) / count(*), 2) as conversion_rate,
    count(*) as total_users
from experiment_subscription
group by variant
;
