/*
    https://adventofsql.com/challenges/19
    https://adventofsql.com/challenges/19/data
*/
drop schema if exists day_19 cascade;
create schema day_19;
use day_19;


/* Create tables */
create sequence day_19.employees__pk start 1;
create table day_19.employees (
    employee_id int primary key default nextval('day_19.employees__pk'),
    name varchar(100) not null,
    salary decimal(10, 2) not null,
    year_end_performance_scores integer[] not null
);


/* Sample data */
insert into day_19.employees(name, salary, year_end_performance_scores)
values
    ('Alice Johnson', 75000.00, array[85, 90, 88, 92]),
    ('Bob Smith', 68000.00, array[78, 82, 80, 81]),
    ('Charlie Brown', 72000.00, array[91, 89, 94, 96]),
    ('Dana White', 64000.00, array[70, 75, 73, 72]),
    ('Eliot Green', 70000.00, array[88, 85, 90, 87])
;
