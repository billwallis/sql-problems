/*
    https://adventofsql.com/challenges/12
    https://adventofsql.com/challenges/12/data
*/
drop schema if exists day_12 cascade;
create schema day_12;
use day_12;


/* Create tables */
create sequence day_12.gifts__pk start 1;
create table day_12.gifts (
    gift_id int primary key default nextval('day_12.gifts__pk'),
    gift_name varchar(100) not null,
    price decimal(10,2)
);

create sequence day_12.gift_requests__pk start 1;
create table day_12.gift_requests (
    request_id int primary key default nextval('day_12.gift_requests__pk'),
    gift_id int,
    request_date date,
    foreign key (gift_id) references day_12.gifts(gift_id)
);


/* Sample data */
insert into day_12.gifts
values
    (1, 'Robot Kit', 89.99),
    (2, 'Smart Watch', 149.99),
    (3, 'Teddy', 199.99),
    (4, 'Hat', 59.99)
;

insert into day_12.gift_requests
values
    (1, 1, '2024-12-25'),
    (2, 1, '2024-12-25'),
    (3, 1, '2024-12-25'),
    (4, 2, '2024-12-25'),
    (5, 2, '2024-12-25'),
    (6, 2, '2024-12-25'),
    (7, 3, '2024-12-25'),
    (8, 3, '2024-12-25'),
    (9, 3, '2024-12-25'),
    (10, 3, '2024-12-25'),
    (11, 4, '2024-12-25'),
    (12, 4, '2024-12-25'),
    (13, 4, '2024-12-25'),
    (14, 4, '2024-12-25'),
    (15, 4, '2024-12-25')
;
