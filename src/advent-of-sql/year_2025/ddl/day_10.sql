/*
    https://databaseschool.com/series/advent-of-sql/videos/321
    https://databaseschool.com/download/day-10-inserts
*/
drop schema if exists day_10 cascade;
create schema day_10;
use day_10;


create or replace table day_10.deliveries (
    id int primary key,
    child_name text,
    delivery_location text,
    gift_name text,
    scheduled_at timestamp
);
create or replace table day_10.misdelivered_presents (
    id int primary key,
    child_name text,
    delivery_location text,
    gift_name text,
    scheduled_at timestamp,
    flagged_at timestamp,
    reason text
);
