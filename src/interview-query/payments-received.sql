/* https://www.interviewquery.com/questions/payments-received */

/* Solution (PostgreSQL) */
with successful_payments(user_id, payment_dt, amount_cents) as (
        select sender_id, created_at::date, amount_cents
        from payments
        where payment_state = 'success'
    union all
        select recipient_id, created_at::date, amount_cents
        from payments
        where payment_state = 'success'
)

select count(*) as num_customers
from (
    select user_id
    from successful_payments
        inner join users
            on successful_payments.user_id = users.id
    where 1=1
        and date_trunc('month', users.created_at) = '2020-01-01'::date
        and successful_payments.payment_dt between users.created_at::date
                                               and (users.created_at + interval '30 days')::date
    group by user_id
    having sum(amount_cents) > 10000
) as t
;
