/* https://www.interviewquery.com/questions/cumulative-reset */

/*
    Hmm, this shouldn't be a "hard" question 🤔
*/
/* Solution (PostgreSQL) */
select
    created_at::date as date,
    sum(count(*)) over (
        partition by date_trunc('month', created_at::date)
        order by created_at::date
    ) as monthly_cumulative
from users
group by date
order by date
;
