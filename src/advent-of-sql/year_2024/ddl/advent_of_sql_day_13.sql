/*
    https://adventofsql.com/challenges/13
    https://adventofsql.com/challenges/13/data
*/
drop schema if exists day_13 cascade;
create schema day_13;
use day_13;


/* Create tables */
create sequence day_13.contact_list__pk start 1;
create table day_13.contact_list (
    id int primary key default nextval('day_13.contact_list__pk'),
    name varchar(100) not null,
    email_addresses text[] not null
);


/* Sample data */
insert into day_13.contact_list(name, email_addresses)
values
    ('Santa Claus', array['santa@northpole.com', 'kringle@workshop.net', 'claus@giftsrus.com']),
    ('Head Elf', array['supervisor@workshop.net', 'elf1@northpole.com', 'toys@workshop.net']),
    ('Grinch', array['grinch@mountcrumpit.com', 'meanie@whoville.org']),
    ('Rudolph', array['red.nose@sleigh.com', 'rudolph@northpole.com', 'flying@reindeer.net'])
;
