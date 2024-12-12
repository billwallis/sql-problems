create schema if not exists santa_workshop;
use santa_workshop;

/*
    https://adventofsql.com/challenges/12
    https://adventofsql.com/challenges/12/data
*/

-- Create tables
DROP TABLE santa_workshop.gift_requests CASCADE;
DROP TABLE santa_workshop.gifts CASCADE;

create sequence gifts__pk start 1;
CREATE TABLE santa_workshop.gifts (
    gift_id int PRIMARY KEY default nextval('gifts__pk'),
    gift_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2)
);

create sequence gift_requests__pk start 1;
CREATE TABLE santa_workshop.gift_requests (
    request_id int PRIMARY KEY default nextval('gift_requests__pk'),
    gift_id INT,
    request_date DATE,
    FOREIGN KEY (gift_id) REFERENCES santa_workshop.Gifts(gift_id)
);


-- Sample data
INSERT INTO santa_workshop.gifts VALUES
(1, 'Robot Kit', 89.99),
(2, 'Smart Watch', 149.99),
(3, 'Teddy', 199.99),
(4, 'Hat', 59.99);

INSERT INTO santa_workshop.gift_requests VALUES
(1, 1, '2024-12-25'),
(2, 1, '2024-12-25'),
(3, 1, '2024-12-25'),
(4, 2, '2024-12-25'),
(5, 2, '2024-12-25'),
(6, 2, '2024-12-25'),
(7, 3, '2024-12-25'),
(8, 3, '2024-12-25'),
(9, 3, '2024-12-25'),
(10, 3, '2024-12-25'),
(11, 4, '2024-12-25'),
(12, 4, '2024-12-25'),
(13, 4, '2024-12-25'),
(14, 4, '2024-12-25'),
(15, 4, '2024-12-25');
