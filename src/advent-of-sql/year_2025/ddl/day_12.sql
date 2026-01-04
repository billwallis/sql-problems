/*
    https://databaseschool.com/series/advent-of-sql/videos/323
    https://databaseschool.com/download/day-12-inserts
*/
drop schema if exists day_12 cascade;
create schema day_12;
use day_12;


create or replace table day_12.archive_records (
    id int primary key,
    title text,
    description text
);
