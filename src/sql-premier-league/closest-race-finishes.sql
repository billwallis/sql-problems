/* https://sqlpremierleague.com/solve/169 */


/* Sample data */
create table f1_circuits (
    circuit_id int,
    circuit_ref text,
    circuit_name text,
    location text,
    country text,
    latitude numeric(8, 5),
    longitude numeric(8, 5),
    altitude int,
    wikipedia_url text
);
insert into f1_circuits
values
    (1, 'albert_park', 'Albert Park Grand Prix Circuit', 'Melbourne',    'Australia', -37.8497,  144.968,  10, 'https://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit'),
    (2, 'sepang',      'Sepang International Circuit',   'Kuala Lumpur', 'Malaysia',    2.76083, 101.738,  18, 'https://en.wikipedia.org/wiki/Sepang_International_Circuit'),
    (3, 'bahrain',     'Bahrain International Circuit',  'Sakhir',       'Bahrain',    26.0325,   50.5106,  7, 'https://en.wikipedia.org/wiki/Bahrain_International_Circuit')
;

create table f1_races (
    race_id int,
    year int,
    round int,
    circuit_id int,
    race_name text,
    race_date date,
    race_time time,
    wikipedia_url text,
    fp1_date date,
    fp1_time time,
    fp2_date date,
    fp2_time time,
    fp3_date date,
    fp3_time time,
    quali_date date,
    quali_time time,
    sprint_date date,
    sprint_time time
);
insert into f1_races
values
    (1, 2009, 1,  1, 'Australian Grand Prix', '2009-03-29', '06:00:00', 'https://en.wikipedia.org/wiki/2009_Australian_Grand_Prix', null, null, null, null, null, null, null, null, null, null),
    (2, 2009, 2,  2, 'Malaysian Grand Prix',  '2009-04-05', '09:00:00', 'https://en.wikipedia.org/wiki/2009_Malaysian_Grand_Prix',  null, null, null, null, null, null, null, null, null, null),
    (3, 2009, 3, 17, 'Chinese Grand Prix',    '2009-04-19', '07:00:00', 'https://en.wikipedia.org/wiki/2009_Chinese_Grand_Prix',    null, null, null, null, null, null, null, null, null, null)
;

create table f1_results (
    result_id int,
    race_id int,
    driver_id int,
    constructor_id int,
    grid_position int,
    final_position int,
    position_text int,
    position_order int,
    points int,
    laps int,
    race_time text,
    milliseconds int,
    fastest_lap int,
    fastest_lap_rank int,
    fastest_lap_time text,
    fastest_lap_speed numeric(8, 3),
    status_id int
);
insert into f1_results
values
    (138, 24,  3, 3, 5, 10, 10, 10,  0, 70, '+54.749',     5838976, 14, 5, '1:17.977', 201.336, 1),
    (149, 25, 13, 6, 2,  1,  1,  1, 10, 70, '1:31:50.245', 5510245, 20, 2, '1:16.729', 206.956, 1),
    (150, 25,  8, 6, 1,  2,  2,  2,  8, 70, '+17.984',     5528229, 16, 1, '1:16.630', 207.224, 1)
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with time_diff as (
    select
        race_id,
        pos_2.milliseconds - pos_1.milliseconds as diff_ms
    from f1_results as pos_1
        inner join f1_results as pos_2
            using (race_id)
    where 1=1
        and pos_1.position_order = 1
        and pos_2.position_order = 2
)

select
    f1_circuits.circuit_name,
    avg(time_diff.diff_ms) / 1000 as avg_diff_sec
from f1_circuits
    inner join f1_races
        using (circuit_id)
    inner join time_diff
        using (race_id)
group by f1_circuits.circuit_name
order by avg_diff_sec
limit 1
;
