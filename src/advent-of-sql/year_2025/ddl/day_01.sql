/*
    https://databaseschool.com/series/advent-of-sql/videos/309
    https://databaseschool.com/download/day-1-inserts
*/
drop schema if exists day_01 cascade;
create schema day_01;
use day_01;


drop table if exists wish_list cascade;
create sequence day_01.wish_list__pk start 1;
create table day_01.wish_list (
   id          bigint primary key default nextval('day_01.wish_list__pk'),
   child_name  text,
   raw_wish    text
);


/*
    The input is thousands of insert statements instead of a single
    multi-line insert statement 😭

    I needed to do some manual parsing to run this in a reasonable amount of
    time in DuckDB, but I haven't committed it here.
*/
