create schema if not exists santa_workshop;
use santa_workshop;

/*
    https://adventofsql.com/challenges/11
    https://adventofsql.com/challenges/11/data
*/

-- Create tables
DROP TABLE IF EXISTS TreeHarvests;
CREATE TABLE IF NOT EXISTS TreeHarvests (
    field_name VARCHAR(50),
    harvest_year INT,
    season VARCHAR(6),
    trees_harvested INT
);


-- Sample data
INSERT INTO TreeHarvests VALUES
('Rudolph Ridge', 2023, 'Spring', 150),
('Rudolph Ridge', 2023, 'Summer', 180),
('Rudolph Ridge', 2023, 'Fall', 220),
('Rudolph Ridge', 2023, 'Winter', 300),
('Dasher Dell', 2023, 'Spring', 165),
('Dasher Dell', 2023, 'Summer', 195),
('Dasher Dell', 2023, 'Fall', 210),
('Dasher Dell', 2023, 'Winter', 285);
