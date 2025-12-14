/*
    https://databaseschool.com/series/advent-of-sql/videos/315
    https://databaseschool.com/download/day-4-inserts
*/
drop schema if exists day_04 cascade;
create schema day_04;
use day_04;


create or replace table day_04.official_shifts (
    id int primary key,
    volunteer_name text,
    role text,
    shift_time text,
    age_group text,
    code text
);
create or replace table day_04.last_minute_signups (
    id int primary key,
    volunteer_name text,
    assigned_task text,
    time_slot text
);
