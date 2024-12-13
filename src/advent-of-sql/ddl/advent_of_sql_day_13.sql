create schema if not exists santa_workshop;
use santa_workshop;

/*
    https://adventofsql.com/challenges/13
    https://adventofsql.com/challenges/13/data
*/

-- Create tables
DROP TABLE IF EXISTS contact_list;

create sequence contact_list__pk start 1;
CREATE TABLE contact_list (
    id int PRIMARY KEY default nextval('contact_list__pk'),
    name VARCHAR(100) NOT NULL,
    email_addresses TEXT[] NOT NULL
);


-- Sample data
INSERT INTO contact_list (name, email_addresses) VALUES
('Santa Claus',
 ARRAY['santa@northpole.com', 'kringle@workshop.net', 'claus@giftsrus.com']),
('Head Elf',
 ARRAY['supervisor@workshop.net', 'elf1@northpole.com', 'toys@workshop.net']),
('Grinch',
 ARRAY['grinch@mountcrumpit.com', 'meanie@whoville.org']),
('Rudolph',
 ARRAY['red.nose@sleigh.com', 'rudolph@northpole.com', 'flying@reindeer.net']);
