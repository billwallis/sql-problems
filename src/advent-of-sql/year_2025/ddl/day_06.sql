/*
    https://databaseschool.com/series/advent-of-sql/videos/317
    https://databaseschool.com/download/day-6-inserts
*/
drop schema if exists day_06 cascade;
create schema day_06;
use day_06;


create or replace table day_06.families (
    id int primary key,
    family_name text
);
create or replace table day_06.deliveries_assigned (
    id int primary key,
    family_id int,
    gift_date date,
    gift_name text
);
