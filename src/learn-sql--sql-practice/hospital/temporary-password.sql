/* https://www.sql-practice.com/ */

/* Solution */
select
    patient_id,
    patient_id || length(last_name) || substring(birth_date, 1, 4) as temp_password
from patients
where patient_id in (
    select patient_id
    from admissions
)
order by patient_id
;
