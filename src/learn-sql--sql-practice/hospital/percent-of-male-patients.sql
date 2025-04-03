/* https://www.sql-practice.com/ */

/* Solution */
select round(100.0 * count(case when gender = 'M' then 1 end) / count(*), 2) || '%' as percent_of_male_patients
from patients
;
