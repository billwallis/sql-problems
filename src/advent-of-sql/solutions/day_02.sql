use santa_workshop;

/* letters_a */
select * from letters_a;

/* letters_b */
select * from letters_b;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select string_agg(chr("value"), '' order by id) as solution
from (from letters_a union all from letters_b)
where "value" between ascii('a') and ascii('z')
   or "value" between ascii('A') and ascii('Z')
   or chr("value") in (' ', '!', ',', '.')
;
