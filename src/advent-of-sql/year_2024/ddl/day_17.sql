/*
    https://adventofsql.com/challenges/17
    https://adventofsql.com/challenges/17/data
*/
drop schema if exists day_17 cascade;
create schema day_17;
use day_17;


/* Create tables */
create table day_17.Workshops (
  workshop_id int primary key,
  workshop_name varchar(100),
  timezone varchar(50),
  business_start_time time,
  business_end_time time
);


/* Sample data */
insert into day_17.Workshops
values
    (1, 'North Pole HQ', 'UTC', '09:00', '17:00'),
    (2, 'London Workshop', 'Europe/London', '09:00', '17:00'),
    (3, 'New York Workshop', 'America/New_York', '09:00', '17:00')
;
