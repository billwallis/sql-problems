/*
    https://databaseschool.com/series/advent-of-sql/videos/324
    https://databaseschool.com/download/day-13-inserts
*/
drop schema if exists day_13 cascade;
create schema day_13;
use day_13;


create or replace table day_13.travel_manifests (
    manifest_id int primary key,
    vehicle_id text,
    departure_time timestamp,
    manifest_xml varchar  /* XML */
);
