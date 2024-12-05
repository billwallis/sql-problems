create schema if not exists santa_workshop;
use santa_workshop;

/*
    https://adventofsql.com/challenges/5
    https://adventofsql.com/challenges/5/data
*/

-- Create tables
DROP TABLE IF EXISTS toy_production CASCADE;

CREATE TABLE toy_production (
    production_date DATE PRIMARY KEY,
    toys_produced INTEGER
);


-- Sample data
INSERT INTO toy_production (production_date, toys_produced) VALUES
('2024-12-18', 500),
('2024-12-19', 550),
('2024-12-20', 525),
('2024-12-21', 600),
('2024-12-22', 580),
('2024-12-23', 620),
('2024-12-24', 610);
