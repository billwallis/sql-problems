/* https://datalemur.com/sql-game/level5.html */

/*
    Hmm, not totally sure I get the recommended solution.
*/
/* Solution */
with interactions as (
    select
        456 as player_id,
        case when player1_id = 456
            then player2_id
            else player1_id
        end as friend_id,
        count(*) as number_of_interactions
    from daily_interactions
    where 0=1
        or player1_id = 456
        or player2_id = 456
    group by player_id, friend_id
)

select
    player_456.first_name as player_456_name,
    friend.first_name as friend_name,
    interactions.number_of_interactions
from interactions
    inner join player as player_456
        on interactions.player_id = player_456.id
    inner join player as friend
        on  interactions.friend_id = friend.id
        and friend.status = 'alive'
order by interactions.number_of_interactions desc
limit 1
;
