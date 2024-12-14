/*
    https://adventofsql.com/challenges/7
    https://adventofsql.com/challenges/7/data
*/
drop schema if exists day_07 cascade;
create schema day_07;
use day_07;


/* Create tables */
create sequence day_07.workshop_elves__pk start 1;
create table day_07.workshop_elves (
    elf_id int primary key default nextval('day_07.workshop_elves__pk'),
    elf_name varchar(100) not null,
    primary_skill varchar(50) not null,
    years_experience integer not null
);


/* Sample data */
insert into day_07.workshop_elves(elf_name, primary_skill, years_experience)
values
    ('Tinker', 'Toy Making', 150),
    ('Sparkle', 'Gift Wrapping', 75),
    ('Twinkle', 'Toy Making', 90),
    ('Holly', 'Cookie Baking', 200),
    ('Jolly', 'Gift Wrapping', 85),
    ('Berry', 'Cookie Baking', 120),
    ('Star', 'Toy Making', 95)
;
