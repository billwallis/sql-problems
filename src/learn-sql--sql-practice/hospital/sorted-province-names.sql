/* https://www.sql-practice.com/ */

/* Solution */
select province_name
from province_names
order by case when province_name = 'Ontario' then '' else province_name end
;
