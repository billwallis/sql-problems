/* https://www.sql-practice.com/ */

/* Solution */
select
    admission_date,
    count(*) as admission_day,
    count(*) - lag(count(*)) over (order by admission_date) as admission_count_changes
from admissions
group by admission_date
order by admission_date
;
