/*
    https://adventofsql.com/challenges/10
    https://adventofsql.com/challenges/10/data
*/
drop schema if exists day_10 cascade;
create schema day_10;
use day_10;


/* Create tables */
create sequence day_10.Drinks__pk start 1;
create table day_10.Drinks (
    drink_id int primary key default nextval('day_10.Drinks__pk'),
    drink_name varchar(50) not null,
    date date not null,
    quantity integer not null
);


/* Sample data */
insert into day_10.Drinks(drink_name, date, quantity)
values
    ('Eggnog', '2024-12-24', 50),
    ('Eggnog', '2024-12-25', 60),
    ('Hot Cocoa', '2024-12-24', 75),
    ('Hot Cocoa', '2024-12-25', 80),
    ('Peppermint Schnapps', '2024-12-24', 30),
    ('Peppermint Schnapps', '2024-12-25', 40)
;
