create schema if not exists santa_workshop;
use santa_workshop;

/*
    https://adventofsql.com/challenges/4
    https://adventofsql.com/challenges/4/data
*/

-- Create tables
DROP TABLE IF EXISTS toy_production CASCADE;

CREATE TABLE toy_production (
  toy_id int PRIMARY KEY,
  toy_name VARCHAR(100),
  previous_tags TEXT[],
  new_tags TEXT[]
);


-- Sample data
INSERT INTO toy_production VALUES
(1, 'Robot', ARRAY['fun', 'battery'], ARRAY['smart', 'battery', 'educational', 'scientific']),
(2, 'Doll', ARRAY['cute', 'classic'], ARRAY['cute', 'collectible', 'classic']),
(3, 'Puzzle', ARRAY['brain', 'wood'], ARRAY['educational', 'wood', 'strategy']);
