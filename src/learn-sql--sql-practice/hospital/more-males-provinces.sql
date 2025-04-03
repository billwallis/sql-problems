/* https://www.sql-practice.com/ */

/* Solution */
select province_name
from patients
    inner join province_names
        using (province_id)
group by province_name
having count(case when gender = 'M' then 1 end) > count(case when gender = 'F' then 1 end)
order by province_name
;
