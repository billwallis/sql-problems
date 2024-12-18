/*
    https://adventofsql.com/challenges/18
    https://adventofsql.com/challenges/18/data
*/
drop schema if exists day_18 cascade;
create schema day_18;
use day_18;


/* Create tables */
create table day_18.staff (
    staff_id int primary key,
    staff_name varchar(100) not null,
    manager_id int,
    -- foreign key (manager_id) references day_18.staff(staff_id)
);


/* Sample data */
insert into day_18.staff
values
    (1, 'Santa Claus', NULL),                -- CEO level
    (2, 'Head Elf Operations', 1),           -- Department Head
    (3, 'Head Elf Logistics', 1),            -- Department Head
    (4, 'Senior Toy Maker', 2),              -- Team Lead
    (5, 'Senior Gift Wrapper', 2),           -- Team Lead
    (6, 'Inventory Manager', 3),             -- Team Lead
    (7, 'Junior Toy Maker', 4),              -- Staff
    (8, 'Junior Gift Wrapper', 5),           -- Staff
    (9, 'Inventory Clerk', 6),               -- Staff
    (10, 'Apprentice Toy Maker', 7)          -- Entry Level
;
