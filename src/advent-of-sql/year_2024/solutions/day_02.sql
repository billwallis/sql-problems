use day_02;

/* letters_a */
from letters_a;

/* letters_b */
from letters_b;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select string_agg(chr("value"), '' order by id) as solution
from (from letters_a union all from letters_b)
where "value" between ascii('a') and ascii('z')
   or "value" between ascii('A') and ascii('Z')
   or chr("value") in (' ', '!', ',', '.')
;
