/*
    https://databaseschool.com/series/advent-of-sql/videos/314
    https://databaseschool.com/download/day-3-inserts
*/
drop schema if exists day_03 cascade;
create schema day_03;
use day_03;


create or replace table day_03.hotline_messages (
    id int primary key,
    caller_name text,
    transcript text,
    tag text,
    status text
);
