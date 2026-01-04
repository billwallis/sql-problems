/*
    https://databaseschool.com/series/advent-of-sql/videos/322
    https://databaseschool.com/download/day-11-inserts
*/
drop schema if exists day_11 cascade;
create schema day_11;
use day_11;


create or replace table day_11.behavior_logs (
    id int primary key,
    child_id int,
    child_name text,
    behavior_date date,
    score int
);
