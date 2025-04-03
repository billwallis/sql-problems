/* https://www.interviewquery.com/questions/sequentially-fill-in-integers */

/*
    Is this for real? 😶
*/
/* Solution (PostgreSQL) */
select tbl_numbers.int_numbers as seq_numbers
from tbl_numbers
    cross join generate_series(1, tbl_numbers.int_numbers)
;
