/*
    https://adventofsql.com/challenges/4
    https://adventofsql.com/challenges/4/data
*/
drop schema if exists day_04 cascade;
create schema day_04;
use day_04;


/* Create tables */
create table day_04.toy_production (
    toy_id int primary key,
    toy_name varchar(100),
    previous_tags text[],
    new_tags text[]
);


/* Sample data */
insert into day_04.toy_production
values
    (1, 'Robot', array['fun', 'battery'], array['smart', 'battery', 'educational', 'scientific']),
    (2, 'Doll', array['cute', 'classic'], array['cute', 'collectible', 'classic']),
    (3, 'Puzzle', array['brain', 'wood'], array['educational', 'wood', 'strategy'])
;
