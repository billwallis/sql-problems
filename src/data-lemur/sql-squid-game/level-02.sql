/* https://datalemur.com/sql-game/level2.html */

/* Solution */
select
    floor(0.9 * count(*)) as wanted,
    floor(0.9 * count(*)) <= (select amount from rations)
from player
where 1=1
    and status = 'alive'
    and not isinsider
;
