/* https://platform.stratascratch.com/coding/2053-retention-rate */

/* Sample data */
create table sf_events (
    record_date date,
    account_id text,
    user_id text

);
insert into sf_events
values
    ('2021-01-01', 'A1', 'U1'),
    ('2021-01-01', 'A1', 'U2'),
    ('2021-01-06', 'A1', 'U3'),
    ('2021-01-02', 'A1', 'U1'),
    ('2020-12-24', 'A1', 'U2'),
    ('2020-12-08', 'A1', 'U1'),
    ('2020-12-09', 'A1', 'U1'),
    ('2021-01-10', 'A2', 'U4'),
    ('2021-01-11', 'A2', 'U4'),
    ('2021-01-12', 'A2', 'U4')
;


/* Solution */
with

cohorts as (
    select distinct
        to_char(record_date, 'YYYY-MM') as cohort,
        account_id,
        user_id,
        exists(
            select *
            from sf_events as i  /* inner */
            where 1=1
                and o.user_id = i.user_id
                and o.account_id = i.account_id
                and date_trunc('month', o.record_date) < date_trunc('month', i.record_date)
        ) as retained
    from sf_events as o  /* outer */
),

monthly_retention as (
    select
        cohort,
        account_id,
        1.0 * count(*) filter (where retained) / count(*) as retention_rate
    from cohorts
    group by cohort, account_id
)

select
    account_id,
    coalesce(1.0 * jan_2021.retention_rate / nullif(dec_2020.retention_rate, 0), 0) as ratio
from (select * from monthly_retention where cohort = '2020-12') as dec_2020
    full join (select * from monthly_retention where cohort = '2021-01') as jan_2021
        using (account_id)
order by account_id
;
