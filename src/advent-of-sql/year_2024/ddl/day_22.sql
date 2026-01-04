/*
    https://adventofsql.com/challenges/22
    https://adventofsql.com/challenges/22/data
*/
drop schema if exists day_22 cascade;
create schema day_22;
use day_22;


/* Create tables */
create sequence day_22.elves__pk start 1;
create table day_22.elves (
    id int primary key default nextval('day_22.elves__pk'),
    elf_name varchar(255) not null,
    skills text not null
);


/* Sample data */
insert into day_22.elves(elf_name, skills)
values
    ('Eldrin', 'Elixir,Python,C#,JavaScript,MySQL'),  -- 4 programming skills
    ('Faenor', 'C++,Ruby,Kotlin,Swift,Perl'),         -- 5 programming skills
    ('Luthien', 'PHP,TypeScript,Go,SQL')              -- 4 programming skills
;
