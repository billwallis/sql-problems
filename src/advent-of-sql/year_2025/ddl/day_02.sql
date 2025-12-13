/*
    https://databaseschool.com/series/advent-of-sql/videos/313
    https://databaseschool.com/download/day-2-inserts
*/
drop schema if exists day_02 cascade;
create schema day_02;
use day_02;


create or replace table day_02.snowball_categories (
    id int primary key,
    official_category text
);
create or replace table day_02.snowball_inventory (
    id int primary key,
    batch_id text,
    category_name text,
    quantity int,
    status text
);
