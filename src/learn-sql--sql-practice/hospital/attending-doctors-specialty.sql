/* https://www.sql-practice.com/ */

/* Solution */
select
    patients.patient_id,
    patients.first_name,
    patients.last_name,
    doctors.specialty as attending_doctor_specialty
from patients
    inner join admissions
        using (patient_id)
    inner join doctors
        on admissions.attending_doctor_id = doctors.doctor_id
where 1=1
    and admissions.diagnosis = 'Epilepsy'
    and doctors.first_name = 'Lisa'
order by patients.patient_id
;
