/* https://datalemur.com/sql-game/level1.html */

/* Solution */
select *
from player
where 1=1
    and status = 'alive'
    and debt > 400000000
    and (0=1
        or age > 65
        or (1=1
            and vice = 'Gambling'
            and not has_close_family
        )
    )
;
