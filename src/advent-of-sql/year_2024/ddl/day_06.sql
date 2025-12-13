/*
    https://adventofsql.com/challenges/6
    https://adventofsql.com/challenges/6/data
*/
drop schema if exists day_06 cascade;
create schema day_06;
use day_06;


/* Create tables */
create sequence day_06.children__pk start 1;
create table day_06.children (
    child_id int primary key default nextval('day_06.children__pk'),
    name varchar(100),
    age integer,
    city varchar(100)
);

create sequence day_06.gifts__pk start 1;
create table day_06.gifts (
    gift_id int primary key default nextval('day_06.gifts__pk'),
    name varchar(100),
    price decimal(10,2),
    child_id integer references day_06.children(child_id)
);


/* Sample data */
insert into day_06.children(name, age, city)
values
    ('Tommy', 8, 'London'),
    ('Sarah', 7, 'London'),
    ('James', 9, 'Paris'),
    ('Maria', 6, 'Madrid'),
    ('Lucas', 10, 'Berlin')
;

insert into day_06.gifts(name, price, child_id)
values
    ('Robot Dog', 45.99, 1),
    ('Paint Set', 15.50, 2),
    ('Gaming Console', 299.99, 3),
    ('Book Collection', 25.99, 4),
    ('Chemistry Set', 109.99, 5)
;
