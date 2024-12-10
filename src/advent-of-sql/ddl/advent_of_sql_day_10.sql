create schema if not exists santa_workshop;
use santa_workshop;

/*
    https://adventofsql.com/challenges/10
    https://adventofsql.com/challenges/10/data
*/

-- Create tables
DROP TABLE IF EXISTS Drinks CASCADE;

create or replace sequence drinks_pk start 1;
CREATE TABLE Drinks (
    drink_id int PRIMARY KEY default nextval('drinks_pk'),
    drink_name VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    quantity INTEGER NOT NULL
);


-- Sample data
INSERT INTO Drinks (drink_name, date, quantity) VALUES
    ('Eggnog', '2024-12-24', 50),
    ('Eggnog', '2024-12-25', 60),
    ('Hot Cocoa', '2024-12-24', 75),
    ('Hot Cocoa', '2024-12-25', 80),
    ('Peppermint Schnapps', '2024-12-24', 30),
    ('Peppermint Schnapps', '2024-12-25', 40);
