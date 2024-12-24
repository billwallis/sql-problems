/*
    https://adventofsql.com/challenges/23
    https://adventofsql.com/challenges/23/data
*/
drop schema if exists day_23 cascade;
create schema day_23;
use day_23;


/* Create tables */
create table day_23.sequence_table (
    id int primary key
);


/* Sample data */
insert into day_23.sequence_table (id)
values
    (1),
    (2),
    (3),
    (7),
    (8),
    (9),
    (11),
    (15),
    (16),
    (17),
    (22)
;
