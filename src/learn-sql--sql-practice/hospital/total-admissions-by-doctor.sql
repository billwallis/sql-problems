/* https://www.sql-practice.com/ */

/* Solution */
with doctor_admissions as (
    select
        attending_doctor_id as doctor_id,
        year(admission_date) as selected_year,
        count(*) as total_admissions
    from admissions
    group by doctor_id, selected_year
)

select
    doctor_id,
    doctors.first_name || ' ' || doctors.last_name as doctor_name,
    doctors.specialty,
    doctor_admissions.selected_year,
    doctor_admissions.total_admissions
from doctors
    inner join doctor_admissions
        using (doctor_id)
order by doctor_id
;
