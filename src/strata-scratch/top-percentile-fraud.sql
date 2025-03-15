/* https://platform.stratascratch.com/coding/10303-top-percentile-fraud */

/* Sample data */
create table fraud_score (
    policy_num text,
    state text,
    claim_cost int,
    fraud_score numeric
);
insert into fraud_score
values
    ('ABCD1001', 'CA', 4113, 0.61),
    ('ABCD1002', 'CA', 3946, 0.16),
    ('ABCD1003', 'CA', 4335, 0.01),
    ('ABCD1004', 'CA', 3967, 0.14),
    ('ABCD1005', 'CA', 1599, 0.89)
;


/* Solution */
with percentiles as (
    select
        state,
        percentile_cont(0.05) within group (order by fraud_score desc) as percentile
    from fraud_score
    group by state
)

select fraud_score.*
from fraud_score
    left join percentiles
        using (state)
where fraud_score.fraud_score >= percentiles.percentile
order by fraud_score.policy_num
;

/*
    I really hope the premium ones are harder 😶
*/
