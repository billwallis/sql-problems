/*
    https://adventofsql.com/challenges/11
    https://adventofsql.com/challenges/11/data
*/
drop schema if exists day_11 cascade;
create schema day_11;
use day_11;


/* Create tables */
create table day_11.TreeHarvests (
    field_name varchar(50),
    harvest_year int,
    season varchar(6),
    trees_harvested int
);


/* Sample data */
insert into day_11.TreeHarvests
values
    ('Rudolph Ridge', 2023, 'Spring', 150),
    ('Rudolph Ridge', 2023, 'Summer', 180),
    ('Rudolph Ridge', 2023, 'Fall', 220),
    ('Rudolph Ridge', 2023, 'Winter', 300),
    ('Dasher Dell', 2023, 'Spring', 165),
    ('Dasher Dell', 2023, 'Summer', 195),
    ('Dasher Dell', 2023, 'Fall', 210),
    ('Dasher Dell', 2023, 'Winter', 285)
;
