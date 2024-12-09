create schema if not exists santa_workshop;
use santa_workshop;

/*
    https://adventofsql.com/challenges/9
    https://adventofsql.com/challenges/9/data
*/

-- Create tables
DROP TABLE IF EXISTS santa_workshop.training_sessions CASCADE;
DROP TABLE IF EXISTS santa_workshop.reindeers CASCADE;

create or replace sequence reindeers__pk start 1;
CREATE TABLE santa_workshop.reindeers (
    reindeer_id INTEGER PRIMARY KEY default nextval('reindeers__pk'),
    reindeer_name VARCHAR(50) NOT NULL,
    years_of_service INTEGER NOT NULL,
    speciality VARCHAR(100)
);

create or replace sequence training_sessions__pk start 1;
CREATE TABLE santa_workshop.training_sessions (
    session_id int PRIMARY KEY default nextval('training_sessions__pk'),
    reindeer_id INTEGER,
    exercise_name VARCHAR(100) NOT NULL,
    speed_record DECIMAL(5,2) NOT NULL,
    session_date DATE NOT NULL,
    weather_conditions VARCHAR(50),
    FOREIGN KEY (reindeer_id) REFERENCES santa_workshop.reindeers(reindeer_id)
);


-- Sample data
INSERT INTO santa_workshop.reindeers (reindeer_name, years_of_service, speciality) VALUES
    ('Dasher', 287, 'Sprint Master'),
    ('Dancer', 283, 'Agility Expert'),
    ('Prancer', 275, 'High-Altitude Specialist'),
    ('Comet', 265, 'Long-Distance Expert'),
    ('Rudolf', 152, 'Night Navigation');

INSERT INTO santa_workshop.training_sessions (reindeer_id, exercise_name, speed_record, session_date, weather_conditions) VALUES
    (1, 'Sprint Start', 88.5, '2024-11-15', 'Snowy'),
    (1, 'High-Speed Turn', 92.3, '2024-11-20', 'Clear'),
    (1, 'Rooftop Landing', 85.7, '2024-11-25', 'Windy'),
    (2, 'Sprint Start', 90.1, '2024-11-15', 'Snowy'),
    (2, 'High-Speed Turn', 94.8, '2024-11-20', 'Clear'),
    (2, 'Rooftop Landing', 89.2, '2024-11-25', 'Windy'),
    (3, 'Sprint Start', 87.3, '2024-11-15', 'Snowy'),
    (3, 'High-Speed Turn', 91.5, '2024-11-20', 'Clear'),
    (3, 'Rooftop Landing', 88.9, '2024-11-25', 'Windy'),
    (4, 'Sprint Start', 89.7, '2024-11-15', 'Snowy'),
    (4, 'High-Speed Turn', 93.2, '2024-11-20', 'Clear'),
    (4, 'Rooftop Landing', 87.8, '2024-11-25', 'Windy'),
    (5, 'Sprint Start', 86.9, '2024-11-15', 'Snowy'),
    (5, 'High-Speed Turn', 90.8, '2024-11-20', 'Clear'),
    (5, 'Rooftop Landing', 88.1, '2024-11-25', 'Windy');
