create schema if not exists santa_workshop;
use santa_workshop;

/*
    https://adventofsql.com/challenges/7
    https://adventofsql.com/challenges/7/data
*/

-- Create tables
DROP TABLE IF EXISTS workshop_elves CASCADE;

create or replace sequence workshop_elves__pk start 1;
CREATE or replace TABLE workshop_elves (
    elf_id int PRIMARY KEY default nextval('workshop_elves__pk'),
    elf_name VARCHAR(100) NOT NULL,
    primary_skill VARCHAR(50) NOT NULL,
    years_experience INTEGER NOT NULL
);


-- Sample data
INSERT INTO workshop_elves (elf_name, primary_skill, years_experience) VALUES
    ('Tinker', 'Toy Making', 150),
    ('Sparkle', 'Gift Wrapping', 75),
    ('Twinkle', 'Toy Making', 90),
    ('Holly', 'Cookie Baking', 200),
    ('Jolly', 'Gift Wrapping', 85),
    ('Berry', 'Cookie Baking', 120),
    ('Star', 'Toy Making', 95);
