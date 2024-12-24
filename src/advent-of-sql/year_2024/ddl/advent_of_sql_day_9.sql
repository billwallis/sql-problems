/*
    https://adventofsql.com/challenges/9
    https://adventofsql.com/challenges/9/data
*/
drop schema if exists day_09 cascade;
create schema day_09;
use day_09;


/* Create tables */
create sequence day_09.reindeers__pk start 1;
create table day_09.reindeers (
    reindeer_id integer primary key default nextval('day_09.reindeers__pk'),
    reindeer_name varchar(50) not null,
    years_of_service integer not null,
    speciality varchar(100)
);

create sequence day_09.training_sessions__pk start 1;
create table day_09.training_sessions (
    session_id int primary key default nextval('day_09.training_sessions__pk'),
    reindeer_id integer,
    exercise_name varchar(100) not null,
    speed_record decimal(5,2) not null,
    session_date date not null,
    weather_conditions varchar(50),
    foreign key (reindeer_id) references day_09.reindeers(reindeer_id)
);


/* Sample data */
insert into day_09.reindeers(reindeer_name, years_of_service, speciality)
values
    ('Dasher', 287, 'Sprint Master'),
    ('Dancer', 283, 'Agility Expert'),
    ('Prancer', 275, 'High-Altitude Specialist'),
    ('Comet', 265, 'Long-Distance Expert'),
    ('Rudolf', 152, 'Night Navigation')
;

insert into day_09.training_sessions(reindeer_id, exercise_name, speed_record, session_date, weather_conditions)
values
    (1, 'Sprint Start', 88.5, '2024-11-15', 'Snowy'),
    (1, 'High-Speed Turn', 92.3, '2024-11-20', 'Clear'),
    (1, 'Rooftop Landing', 85.7, '2024-11-25', 'Windy'),
    (2, 'Sprint Start', 90.1, '2024-11-15', 'Snowy'),
    (2, 'High-Speed Turn', 94.8, '2024-11-20', 'Clear'),
    (2, 'Rooftop Landing', 89.2, '2024-11-25', 'Windy'),
    (3, 'Sprint Start', 87.3, '2024-11-15', 'Snowy'),
    (3, 'High-Speed Turn', 91.5, '2024-11-20', 'Clear'),
    (3, 'Rooftop Landing', 88.9, '2024-11-25', 'Windy'),
    (4, 'Sprint Start', 89.7, '2024-11-15', 'Snowy'),
    (4, 'High-Speed Turn', 93.2, '2024-11-20', 'Clear'),
    (4, 'Rooftop Landing', 87.8, '2024-11-25', 'Windy'),
    (5, 'Sprint Start', 86.9, '2024-11-15', 'Snowy'),
    (5, 'High-Speed Turn', 90.8, '2024-11-20', 'Clear'),
    (5, 'Rooftop Landing', 88.1, '2024-11-25', 'Windy')
;
