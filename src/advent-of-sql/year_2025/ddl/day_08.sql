/*
    https://databaseschool.com/series/advent-of-sql/videos/319
    https://databaseschool.com/download/day-8-inserts
*/
drop schema if exists day_08 cascade;
create schema day_08;
use day_08;


create or replace table day_08.products (
    product_id int primary key,
    product_name text
);
create or replace table day_08.price_changes (
    id int primary key,
    product_id int,
    price numeric(10,2),
    effective_timestamp timestamp
);
