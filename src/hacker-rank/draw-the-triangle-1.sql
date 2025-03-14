/* https://www.hackerrank.com/challenges/draw-the-triangle-1/problem */

/* Sample input: 5 */

/* Sample output */
values
    ('* * * * *'),
    ('* * * *'),
    ('* * *'),
    ('* *'),
    ('*')
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with triangle(image, n) as (
        select cast('*' as varchar(max)), 1
    union all
        select concat(image, ' *'), n + 1
        from triangle
        -- where n < 5
        where n < 20
)

select image
from triangle
order by n desc
;
