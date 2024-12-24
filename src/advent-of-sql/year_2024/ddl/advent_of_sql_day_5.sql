/*
    https://adventofsql.com/challenges/5
    https://adventofsql.com/challenges/5/data
*/
drop schema if exists day_05 cascade;
create schema day_05;
use day_05;


/* Create tables */
create table day_05.toy_production (
    production_date date primary key,
    toys_produced integer
);


/* Sample data */
insert into day_05.toy_production
values
    ('2024-12-18', 500),
    ('2024-12-19', 550),
    ('2024-12-20', 525),
    ('2024-12-21', 600),
    ('2024-12-22', 580),
    ('2024-12-23', 620),
    ('2024-12-24', 610)
;
