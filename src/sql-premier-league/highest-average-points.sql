/* https://sqlpremierleague.com/solve/364 */


/* Sample data */
create table clubrankings (
    position int,
    club text,
    country text,
    participated int,
    titles int,
    played int,
    win int,
    draw int,
    loss int,
    goals_for int,
    goals_against int,
    pts int,
    goal_diff int
);
insert into clubrankings
values
    (1, 'Real Madrid CF',    'ESP', 53, 14, 476, 285, 81, 110, 1047, 521, 651, 526),
    (2, 'FC Bayern München', 'GER', 39,  6, 382, 229, 76,  77,  804, 373, 534, 431),
    (3, 'FC Barcelona',      'ESP', 33,  5, 339, 197, 76,  66,  667, 343, 470, 324)
;

create table countrymapping (
    country_code text,
    country_name text
);
insert into countrymapping
values
    ('ESP', 'Spain'),
    ('GER', 'Germany'),
    ('ENG', 'England')
;

create table countryrankings (
    rank int,
    country text,
    participated int,
    titles int,
    played int,
    win int,
    draw int,
    loss int,
    goals_for int,
    goals_against int,
    pts int,
    goal_diff int
);
insert into countryrankings
values
    (1, 'Spain',   152, 19, 1379, 717, 313, 349, 2476, 1492, 1747, 984),
    (2, 'England', 140, 15, 1278, 676, 280, 322, 2289, 1299, 1632, 990),
    (3, 'Germany', 171,  8, 1216, 573, 250, 393, 2128, 1589, 1396, 539)
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select
    countrymapping.country_name,
    avg(clubrankings.pts) as average_points
from countrymapping
    inner join clubrankings
        on countrymapping.country_code = clubrankings.country
group by countrymapping.country_name
order by average_points desc
limit 1
;
