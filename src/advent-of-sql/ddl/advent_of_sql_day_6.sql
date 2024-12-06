create schema if not exists santa_workshop;
use santa_workshop;

/*
    https://adventofsql.com/challenges/6
    https://adventofsql.com/challenges/6/data
*/

-- Create tables
DROP TABLE IF EXISTS santa_workshop.gifts CASCADE;
DROP TABLE IF EXISTS santa_workshop.children CASCADE;

create sequence children__pk start 1;
CREATE TABLE santa_workshop.children (
    child_id int PRIMARY KEY default nextval('children__pk'),
    name VARCHAR(100),
    age INTEGER,
    city VARCHAR(100)
);

create sequence gifts__pk start 1;
CREATE TABLE santa_workshop.gifts (
    gift_id int PRIMARY KEY default nextval('gifts__pk'),
    name VARCHAR(100),
    price DECIMAL(10,2),
    child_id INTEGER REFERENCES santa_workshop.children(child_id)
);


-- Sample data
INSERT INTO children (name, age, city) VALUES
    ('Tommy', 8, 'London'),
    ('Sarah', 7, 'London'),
    ('James', 9, 'Paris'),
    ('Maria', 6, 'Madrid'),
    ('Lucas', 10, 'Berlin');

INSERT INTO gifts (name, price, child_id) VALUES
    ('Robot Dog', 45.99, 1),
    ('Paint Set', 15.50, 2),
    ('Gaming Console', 299.99, 3),
    ('Book Collection', 25.99, 4),
    ('Chemistry Set', 109.99, 5);
