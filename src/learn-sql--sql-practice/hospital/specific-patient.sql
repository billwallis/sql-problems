/* https://www.sql-practice.com/ */

/* Solution */
select *
from patients
where 1=1
    and substring(first_name, 3, 1) = 'r'
    and gender = 'F'
    and month(birth_date) in (2, 5, 12)
    and weight between 60 and 80
    and patient_id % 2 = 1
    and city = 'Kingston'
;
