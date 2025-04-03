/* https://www.interviewquery.com/questions/rolling-bank-transactions */

/*
    Are deposits positive or negative? Please be clear 🙄

    This is also absolutely **not** a "hard" question.
*/
/* Solution (PostgreSQL) */
with daily_deposits as (
    select
        created_at::date as dt,
        sum(transaction_value) as transaction_value
    from bank_transactions
    where transaction_value >= 0
    group by created_at::date
)

select
    dt,
    avg(transaction_value) over (
        order by dt rows 2 preceding
    ) as rolling_three_day
from daily_deposits
order by dt
;
