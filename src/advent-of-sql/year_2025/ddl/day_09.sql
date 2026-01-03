/*
    https://databaseschool.com/series/advent-of-sql/videos/320
    https://databaseschool.com/download/day-9-inserts
*/
drop schema if exists day_09 cascade;
create schema day_09;
use day_09;


create or replace table day_09.orders (
    id int primary key,
    customer_id int,
    created_at timestamp,
    order_data json
);
