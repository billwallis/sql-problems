/* https://www.sql-practice.com/ */

/* Solution */
select
    patient_id,
    weight,
    height,
    (weight / (height * height / 10000.0)) >= 30 as isobese
from patients
order by patient_id
;
