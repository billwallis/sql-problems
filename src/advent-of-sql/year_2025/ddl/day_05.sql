/*
    https://databaseschool.com/series/advent-of-sql/videos/316
    https://databaseschool.com/download/day-5-inserts
*/
drop schema if exists day_05 cascade;
create schema day_05;
use day_05;


create or replace table day_05.listening_logs (
    id integer primary key,
    user_name text,
    artist text,
    played_at timestamp,
    content_type text
);
