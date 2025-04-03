/* https://www.interviewquery.com/questions/user-system-response-times */

/*
    Only MySQL is available for this question 😭

    Another one that is not a "hard" question at all 🙄
*/
/* Solution (MySQL) */
with messages as (
    select
        message_type,
        interview_id,
        timestampdiff(
            second,
            lag(created_at) over (
                partition by interview_id
                order by created_at
            ),
            created_at
        ) as response_time
    from conversation_messages
)

select
    interviews.user_id,
    avg(response_time) as response_times
from interviews
    inner join messages
        on  interviews.id = messages.interview_id
        and messages.message_type = 'user'
group by interviews.user_id
order by interviews.user_id
;
