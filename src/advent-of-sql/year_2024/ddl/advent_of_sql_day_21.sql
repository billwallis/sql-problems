/*
    https://adventofsql.com/challenges/21
    https://adventofsql.com/challenges/21/data
*/
drop schema if exists day_21 cascade;
create schema day_21;
use day_21;


/* Create tables */
create sequence day_21.sales__pk start 1;
create table day_21.sales (
    id int primary key default nextval('day_21.sales__pk'),
    sale_date date not null,
    amount decimal(10, 2) not null
);


/* Sample data */
insert into day_21.sales(sale_date, amount)
values
    ('2024-01-10', 3500.25),
    ('2023-01-15', 1500.50),
    ('2023-04-20', 2000.00),
    ('2023-07-12', 2500.75),
    ('2023-10-25', 3000.00),
;
