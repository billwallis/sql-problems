use day_22;

/* elves */
from elves;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select count(*)
from elves
where split(skills, ',').list_contains('SQL')
;
