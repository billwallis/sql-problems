/*
    https://adventofsql.com/challenges/24
    https://adventofsql.com/challenges/24/data
*/
drop schema if exists day_24 cascade;
create schema day_24;
use day_24;


/* Create tables */
create table day_24.users (
    user_id int primary key,
    username varchar(255) not null
);
create table day_24.songs (
    song_id int primary key,
    song_title varchar(255) not null,
    song_duration int  -- Duration in seconds, can be null if unknown
);
create table day_24.user_plays (
    play_id int primary key,
    user_id int,
    song_id int,
    play_time date,
    duration int,  -- Duration in seconds, can be null
    foreign key (user_id) references day_24.users(user_id),
    foreign key (song_id) references day_24.songs(song_id)
);


/* Sample data */
insert into day_24.users
values
    (1, 'alice'),
    (2, 'bob'),
    (3, 'carol')
;
insert into day_24.songs
values
    (1, 'Jingle Bells', 180),
    (2, 'Silent Night', null),  -- NULL duration
    (3, 'Deck the Halls', 150)
;
insert into day_24.user_plays
values
    (1, 1, 1, '2024-12-22', 180),  -- Full play
    (2, 2, 1, '2024-12-22', 100),  -- Skipped
    (3, 3, 2, '2024-12-22', null), -- NULL duration (unknown play)
    (4, 1, 2, '2024-12-23', 180),  -- Valid duration, but song duration unknown
    (5, 2, 2, '2024-12-23', null), -- NULL duration
    (6, 3, 3, '2024-12-23', 150),  -- Full play
    -- Additional plays with NULLs and shorter durations
    (7, 1, 3, '2024-12-23', 150),  -- Full play
    (8, 2, 3, '2024-12-22', 140),  -- Skipped
    (9, 3, 1, '2024-12-23', null), -- NULL duration
    (10, 1, 3, '2024-12-22', null) -- NULL duration
;
