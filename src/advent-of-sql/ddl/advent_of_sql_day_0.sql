create or replace schema santa_workshop;
use santa_workshop;

/*
    https://adventofsql.com/challenges/example
*/

-- Drop tables if they exist
DROP TABLE IF EXISTS santa_workshop.ChristmasList;
DROP TABLE IF EXISTS santa_workshop.Children;
DROP TABLE IF EXISTS santa_workshop.Gifts;
DROP TABLE IF EXISTS santa_workshop.Reindeer;

-- Create tables
CREATE TABLE santa_workshop.Children (
    child_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    country VARCHAR(50),
    naughty_nice_score INT,
    letter_sent_date DATE
);

CREATE TABLE santa_workshop.Gifts (
    gift_id INT PRIMARY KEY,
    gift_name VARCHAR(100),
    weight_kg DECIMAL(5,2),
    production_time_hours INT,
    magic_dust_required INT
);

CREATE TABLE santa_workshop.ChristmasList (
    list_id INT PRIMARY KEY,
    child_id INT,
    gift_id INT,
    year INT,
    was_delivered BOOLEAN,
    delivery_order INT,
    FOREIGN KEY (child_id) REFERENCES santa_workshop.Children(child_id),
    FOREIGN KEY (gift_id) REFERENCES santa_workshop.Gifts(gift_id)
);

CREATE TABLE santa_workshop.Reindeer (
    reindeer_id INT PRIMARY KEY,
    name VARCHAR(50),
    max_weight_capacity_kg INT,
    assigned_region VARCHAR(50)
);

-- Add more children across 10 new cities
INSERT INTO santa_workshop.Children VALUES
-- London, UK (6 children)
(1, 'Tommy', 'London', 'UK', 95, '2023-11-15'),
(2, 'Sarah', 'London', 'UK', 88, '2023-11-14'),
(3, 'James', 'London', 'UK', 92, '2023-11-16'),
(4, 'Emma', 'London', 'UK', 85, '2023-11-15'),
(5, 'Louis', 'London', 'UK', 90, '2023-11-17'),
(6, 'Oliver', 'London', 'UK', 87, '2023-11-18'),

-- Manchester, UK (5 children)
(7, 'Harry', 'Manchester', 'UK', 91, '2023-11-15'),
(8, 'Sophie', 'Manchester', 'UK', 89, '2023-11-14'),
(9, 'William', 'Manchester', 'UK', 94, '2023-11-16'),
(10, 'Lucy', 'Manchester', 'UK', 86, '2023-11-15'),
(11, 'George', 'Manchester', 'UK', 93, '2023-11-17'),

-- Birmingham, UK (5 children)
(12, 'Charlie', 'Birmingham', 'UK', 84, '2023-11-15'),
(13, 'Emily', 'Birmingham', 'UK', 88, '2023-11-14'),
(14, 'Jack', 'Birmingham', 'UK', 92, '2023-11-16'),
(15, 'Lily', 'Birmingham', 'UK', 87, '2023-11-15'),
(16, 'Oscar', 'Birmingham', 'UK', 89, '2023-11-17'),

-- Paris, France (6 children)
(17, 'Lucas', 'Paris', 'France', 88, '2023-11-15'),
(18, 'Emma', 'Paris', 'France', 91, '2023-11-14'),
(19, 'Louis', 'Paris', 'France', 87, '2023-11-16'),
(20, 'Chloe', 'Paris', 'France', 92, '2023-11-15'),
(21, 'Hugo', 'Paris', 'France', 89, '2023-11-17'),
(22, 'Lea', 'Paris', 'France', 90, '2023-11-18'),

-- Lyon, France (5 children)
(23, 'Thomas', 'Lyon', 'France', 93, '2023-11-15'),
(24, 'Alice', 'Lyon', 'France', 88, '2023-11-14'),
(25, 'Jules', 'Lyon', 'France', 91, '2023-11-16'),
(26, 'Louise', 'Lyon', 'France', 89, '2023-11-15'),
(27, 'Gabriel', 'Lyon', 'France', 92, '2023-11-17'),

-- Berlin, Germany (6 children)
(28, 'Max', 'Berlin', 'Germany', 94, '2023-11-15'),
(29, 'Sophie', 'Berlin', 'Germany', 89, '2023-11-14'),
(30, 'Leon', 'Berlin', 'Germany', 92, '2023-11-16'),
(31, 'Emma', 'Berlin', 'Germany', 91, '2023-11-15'),
(32, 'Paul', 'Berlin', 'Germany', 88, '2023-11-17'),
(33, 'Marie', 'Berlin', 'Germany', 93, '2023-11-18'),

-- Munich, Germany (5 children)
(34, 'Felix', 'Munich', 'Germany', 90, '2023-11-15'),
(35, 'Anna', 'Munich', 'Germany', 87, '2023-11-14'),
(36, 'Lukas', 'Munich', 'Germany', 91, '2023-11-16'),
(37, 'Laura', 'Munich', 'Germany', 88, '2023-11-15'),
(38, 'David', 'Munich', 'Germany', 89, '2023-11-17'),

-- Rome, Italy (6 children)
(39, 'Marco', 'Rome', 'Italy', 95, '2023-11-15'),
(40, 'Sofia', 'Rome', 'Italy', 92, '2023-11-14'),
(41, 'Leonardo', 'Rome', 'Italy', 88, '2023-11-16'),
(42, 'Giulia', 'Rome', 'Italy', 91, '2023-11-15'),
(43, 'Alessandro', 'Rome', 'Italy', 89, '2023-11-17'),
(44, 'Valentina', 'Rome', 'Italy', 93, '2023-11-18'),

-- Milan, Italy (5 children)
(45, 'Francesco', 'Milan', 'Italy', 90, '2023-11-15'),
(46, 'Aurora', 'Milan', 'Italy', 87, '2023-11-14'),
(47, 'Lorenzo', 'Milan', 'Italy', 91, '2023-11-16'),
(48, 'Martina', 'Milan', 'Italy', 89, '2023-11-15'),
(49, 'Matteo', 'Milan', 'Italy', 88, '2023-11-17'),

-- Madrid, Spain (7 children)
(50, 'Pablo', 'Madrid', 'Spain', 93, '2023-11-15'),
(51, 'Lucia', 'Madrid', 'Spain', 90, '2023-11-14'),
(52, 'Daniel', 'Madrid', 'Spain', 88, '2023-11-16'),
(53, 'Sara', 'Madrid', 'Spain', 91, '2023-11-15'),
(54, 'Diego', 'Madrid', 'Spain', 89, '2023-11-17'),
(55, 'Carmen', 'Madrid', 'Spain', 92, '2023-11-18'),
(56, 'Javier', 'Madrid', 'Spain', 90, '2023-11-19'),

-- Barcelona, Spain (6 children)
(57, 'Marc', 'Barcelona', 'Spain', 91, '2023-11-15'),
(58, 'Ana', 'Barcelona', 'Spain', 88, '2023-11-14'),
(59, 'Carlos', 'Barcelona', 'Spain', 92, '2023-11-16'),
(60, 'Marina', 'Barcelona', 'Spain', 89, '2023-11-15'),
(61, 'Alex', 'Barcelona', 'Spain', 90, '2023-11-17'),
(62, 'Elena', 'Barcelona', 'Spain', 87, '2023-11-18'),

-- Amsterdam, Netherlands (5 children)
(63, 'Lars', 'Amsterdam', 'Netherlands', 94, '2023-11-15'),
(64, 'Eva', 'Amsterdam', 'Netherlands', 91, '2023-11-14'),
(65, 'Jan', 'Amsterdam', 'Netherlands', 89, '2023-11-16'),
(66, 'Lisa', 'Amsterdam', 'Netherlands', 92, '2023-11-15'),
(67, 'Tim', 'Amsterdam', 'Netherlands', 90, '2023-11-17'),

-- Rotterdam, Netherlands (5 children)
(68, 'Daan', 'Rotterdam', 'Netherlands', 88, '2023-11-15'),
(69, 'Sophie', 'Rotterdam', 'Netherlands', 91, '2023-11-14'),
(70, 'Thomas', 'Rotterdam', 'Netherlands', 89, '2023-11-16'),
(71, 'Anna', 'Rotterdam', 'Netherlands', 87, '2023-11-15'),
(72, 'Max', 'Rotterdam', 'Netherlands', 90, '2023-11-17');

INSERT INTO santa_workshop.Gifts VALUES
(1, 'Toy Train', 2.5, 4, 30),
(2, 'Teddy Bear', 0.5, 2, 15),
(3, 'Bicycle', 8.0, 6, 45),
(4, 'Video Game', 0.2, 1, 10),
(5, 'Art Set', 1.0, 3, 20),
(6, 'Lego Set', 1.5, 3, 25),
(7, 'Doll House', 3.0, 5, 35),
(8, 'Robot Kit', 1.2, 4, 28),
(9, 'Board Game', 0.8, 2, 18),
(10, 'Science Kit', 1.3, 3, 22);

-- Update ChristmasList to include all children
INSERT INTO santa_workshop.ChristmasList VALUES
(1, 1, 1, 2023, TRUE, 1),
(2, 2, 2, 2023, TRUE, 2),
(3, 3, 3, 2023, TRUE, 3),
(4, 4, 4, 2023, TRUE, 4),
(5, 5, 5, 2023, TRUE, 5),
(6, 6, 6, 2023, TRUE, 6),
(7, 7, 7, 2023, TRUE, 7),
(8, 8, 8, 2023, TRUE, 8),
(9, 9, 9, 2023, TRUE, 9),
(10, 10, 10, 2023, TRUE, 10),
(11, 11, 1, 2023, TRUE, 11),
(12, 12, 2, 2023, TRUE, 12),
(13, 13, 3, 2023, TRUE, 13),
(14, 14, 4, 2023, TRUE, 14),
(15, 15, 5, 2023, TRUE, 15),
(16, 16, 6, 2023, TRUE, 16),
(17, 17, 7, 2023, TRUE, 17),
(18, 18, 8, 2023, TRUE, 18),
(19, 19, 9, 2023, TRUE, 19),
(20, 20, 10, 2023, TRUE, 20),
(21, 21, 1, 2023, TRUE, 21),
(22, 22, 2, 2023, TRUE, 22),
(23, 23, 3, 2023, TRUE, 23),
(24, 24, 4, 2023, TRUE, 24),
(25, 25, 5, 2023, TRUE, 25),
(26, 26, 6, 2023, TRUE, 26),
(27, 27, 7, 2023, TRUE, 27),
(28, 28, 8, 2023, TRUE, 28),
(29, 29, 9, 2023, TRUE, 29),
(30, 30, 10, 2023, TRUE, 30),
(31, 31, 1, 2023, TRUE, 31);


INSERT INTO santa_workshop.Reindeer VALUES
(1, 'Dasher', 500, 'Europe'),
(2, 'Dancer', 450, 'Asia'),
(3, 'Prancer', 480, 'Americas'),
(4, 'Vixen', 460, 'Europe'),
(5, 'Comet', 490, 'Asia');
