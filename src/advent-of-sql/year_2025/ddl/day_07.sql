/*
    https://databaseschool.com/series/advent-of-sql/videos/318
    https://databaseschool.com/download/day-7-inserts
*/
drop schema if exists day_07 cascade;
create schema day_07;
use day_07;


create or replace table day_07.passengers (
    passenger_id int primary key,
    passenger_name text,
    favorite_mixins text[],
    car_id int
);
create or replace table day_07.cocoa_cars (
    car_id int primary key,
    available_mixins text[],
    total_stock int
);
