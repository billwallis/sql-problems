/* https://platform.stratascratch.com/coding/10319-monthly-percentage-difference */

/* Sample data */
create table sf_transactions (
    id int,
    created_at date,
    value int,
    purchase_id int
);
insert into sf_transactions
values
    (1, '2019-01-01', 172692, 43),
    (2, '2019-01-05', 177194, 36),
    (3, '2019-02-09', 109513, 30),
    (4, '2019-02-13', 164911, 30),
    (5, '2019-03-17', 198872, 39)
;


/* Solution */
select
    to_char(created_at, 'YYYY-MM') as cohort,
    -100 + (
        100.0
        * sum(value)
        / lag(sum(value)) over (order by to_char(created_at, 'YYYY-MM'))
    )::numeric(6, 2) as revenue_diff
from sf_transactions
group by cohort
order by cohort
;

/*
    Bruh c'mon, this isn't "hard"
*/
