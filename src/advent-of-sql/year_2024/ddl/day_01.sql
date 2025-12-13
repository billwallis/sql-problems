/*
    https://adventofsql.com/challenges/1
    https://adventofsql.com/challenges/1/data
*/
drop schema if exists day_01 cascade;
create schema day_01;
use day_01;


/* Create tables */
create table day_01.children (
    child_id int primary key,
    name varchar(100),
    age int
);
create table day_01.wish_lists (
    list_id int primary key,
    child_id int,
    wishes json,
    submitted_date date
);
create table day_01.toy_catalogue (
    toy_id int primary key,
    toy_name varchar(100),
    category varchar(50),
    difficulty_to_make int
);


/* Sample data */
insert into day_01.children
values
    (1, 'Tommy', 8),
    (2, 'Sally', 7),
    (3, 'Bobby', 9)
;

insert into day_01.wish_lists
values
    (1, 1, '{"first_choice": "bike", "second_choice": "blocks", "colors": ["red", "blue"]}', '2024-11-01'),
    (2, 2, '{"first_choice": "doll", "second_choice": "books", "colors": ["pink", "purple"]}', '2024-11-02'),
    (3, 3, '{"first_choice": "blocks", "second_choice": "bike", "colors": ["green"]}', '2024-11-03')
;

insert into day_01.toy_catalogue
values
    (1, 'bike', 'outdoor', 3),
    (2, 'blocks', 'educational', 1),
    (3, 'doll', 'indoor', 2),
    (4, 'books', 'educational', 1)
;
