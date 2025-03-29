/* https://sqlpremierleague.com/solve/190 */


/* Sample data */
create table nba_game_details (
    game_id int,
    team_id int,
    player_id int,
    start_position text,
    minutes text,
    fgm int,  /* field goals made */
    fga int,  /* field goals attempted */
    fg_pct numeric(5, 3),
    fg3m int,  /* 3-point field goals made */
    fg3a int,  /* 3-point field goals attempted */
    fg3_pct numeric(5, 3),
    ftm int,  /* free throws made */
    fta int,  /* free throws attempted */
    ft_pct numeric(5, 3),
    oreb int,  /* offensive rebounds */
    dreb int,  /* defensive rebounds */
    reb int,  /* rebounds */
    ast int,  /* assists */
    stl int,  /* steals */
    blk int,  /* blocks */
    turnover int,
    pf int,  /* personal fouls */
    pts int,  /* points */
    plus_minus numeric(5, 2)
);
insert into nba_game_details
values
    (21400097, 1610612747, 202325, 'F', '35:28', 2,  6, 0.333, 1, 2, 0.500, 0, 0, 0.000, 0, 3, 3, 0, 1, 0, 0, 1,  5, 7.00),
    (21400097, 1610612747,   2430, 'F', '30:14', 7, 11, 0.636, 0, 0, 0.000, 2, 2, 1.000, 0, 5, 5, 1, 1, 0, 2, 5, 16, 5.00),
    (21400097, 1610612747, 201941, 'C', '29:38', 6, 12, 0.500, 0, 0, 0.000, 0, 0, 0.000, 2, 4, 6, 7, 0, 0, 1, 4, 12, 4.00)
;

create table nba_games (
    game_id int,
    game_date date,
    game_status text,
    home_team_id int,
    visitor_team_id int,
    season int,
    home_team_points int,
    away_team_points int,
    home_fg_pct numeric(5, 3),
    home_ft_pct numeric(5, 3),
    home_fg3_pct numeric(5, 3),
    home_assists int,
    home_rebounds int,
    away_fg_pct numeric(5, 3),
    away_ft_pct numeric(5, 3),
    away_fg3_pct numeric(5, 3),
    away_assists int,
    away_rebounds int,
    home_team_wins int
);
insert into nba_games
values
    (22200477, '2022-12-22', 'Final', 1610612740, 1610612759, 2022, 126, 117, 0.484, 0.926, 0.382, 25, 46, 0.478, 0.815, 0.321, 23, 44, 1),
    (22200478, '2022-12-22', 'Final', 1610612762, 1610612764, 2022, 120, 112, 0.488, 0.952, 0.457, 16, 40, 0.561, 0.765, 0.333, 20, 37, 1),
    (22200466, '2022-12-21', 'Final', 1610612739, 1610612749, 2022, 114, 106, 0.482, 0.786, 0.313, 22, 37, 0.470, 0.682, 0.433, 20, 46, 1)
;

create table nba_players (
    player_id int,
    player_name text,
    team_id int,
    season int
);
insert into nba_players
values
    (1626220, 'Royce O''Neale',   1610612762, 2019),
    ( 202711, 'Bojan Bogdanovic', 1610612762, 2019),
    ( 203497, 'Rudy Gobert',      1610612762, 2019)
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with most_triple_doubles as (
    select
        nba_games.season,
        nba_game_details.player_id,
        count(*) as total_triple_doubles
    from nba_games
        left join nba_game_details
            using (game_id)
    where 1=1
        and nba_game_details.pts >= 10
        and nba_game_details.reb >= 10
        and nba_game_details.ast >= 10
    group by
        nba_games.season,
        nba_game_details.player_id
    order by total_triple_doubles desc
    limit 1
)

select
    nba_players.player_name,
    most_triple_doubles.season,
    most_triple_doubles.total_triple_doubles
from most_triple_doubles
    left join nba_players
        using (player_id)
;
