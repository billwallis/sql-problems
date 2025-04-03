/* https://www.sql-practice.com/ */

/*
    > All patients with an even patient_id have insurance.

    Bit of a weird coincidence, but sure 😉
*/
/* Solution */
select
    has_insurance,
    sum(cost) as cost_after_insurance
from (
    select
        case when patient_id % 2 = 0 then 'Yes' else 'No' end as has_insurance,
        case when patient_id % 2 = 0 then 10    else 50   end as cost
    from admissions
)
group by has_insurance
order by has_insurance
;
