/*
    https://adventofsql.com/challenges/16
    https://adventofsql.com/challenges/16/data
*/
drop schema if exists day_16 cascade;
create schema day_16;
use day_16;

install spatial;
load spatial;


/* Create tables */
create sequence day_16.sleigh_locations__pk start 1;
create table day_16.sleigh_locations (
    id int primary key default nextval('day_16.sleigh_locations__pk'),
    timestamp timestamp with time zone not null,
    coordinate geometry not null
);

create sequence day_16.areas__pk start 1;
create table day_16.areas (
    id int primary key default nextval('day_16.areas__pk'),
    place_name varchar(255) not null,
    polygon geometry not null
);


/* Sample data */
insert into day_16.sleigh_locations(timestamp, coordinate)
values
    ('2024-12-24 21:00:00+00', ST_Point(-73.985130, 40.758896)), -- Times Square, New York
    ('2024-12-24 22:00:00+00', ST_Point(-73.850272, 40.817577)), -- Albany, New York State
    ('2024-12-24 23:00:00+00', ST_Point(-118.243683, 34.052235)), -- Downtown Los Angeles
    ('2024-12-25 00:00:00+00', ST_Point(139.691706, 35.689487)), -- Tokyo
    ('2024-12-25 01:00:00+00', ST_Point(25.729066, 66.500000)) -- Rovaniemi, Lapland
;

insert into day_16.areas(place_name, polygon)
values
    ('New_York', ST_GeomFromText('POLYGON((-74.25909 40.477399, -73.700272 40.477399, -73.700272 40.917577, -74.25909 40.917577, -74.25909 40.477399))')),
    ('Los_Angeles', ST_GeomFromText('POLYGON((-118.668176 33.703652, -118.155289 33.703652, -118.155289 34.337306, -118.668176 34.337306, -118.668176 33.703652))')),
    ('Tokyo', ST_GeomFromText('POLYGON((138.941375 35.523222, 140.68074 35.523222, 140.68074 35.898782, 138.941375 35.898782, 138.941375 35.523222))')),
    ('Lapland', ST_GeomFromText('POLYGON((25.629066 66.450000, 25.829066 66.450000, 25.829066 66.550000, 25.629066 66.550000, 25.629066 66.450000))'))
;
