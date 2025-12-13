/*
    https://adventofsql.com/challenges/14
    https://adventofsql.com/challenges/14/data
*/
drop schema if exists day_14 cascade;
create schema day_14;
use day_14;


/* Create tables */
create table day_14.SantaRecords (
    record_id int primary key,
    record_date date,
    cleaning_receipts json
);


/* Sample data */
insert into day_14.SantaRecords
values
(1, '2024-11-25', '[
    {
        "receipt_id": "R120",
        "garment": "hat",
        "color": "red",
        "cost": 15.99,
        "drop_off": "2024-11-25",
        "pickup": "2024-11-27"
    },
    {
        "receipt_id": "R121",
        "garment": "mittens",
        "color": "white",
        "cost": 12.99,
        "drop_off": "2024-11-25",
        "pickup": "2024-11-27"
    }
]'),
(2, '2024-12-01', '[
    {
        "receipt_id": "R122",
        "garment": "suit",
        "color": "red",
        "cost": 25.99,
        "drop_off": "2024-12-01",
        "pickup": "2024-12-03"
    },
    {
        "receipt_id": "R123",
        "garment": "boots",
        "color": "black",
        "cost": 18.99,
        "drop_off": "2024-12-01",
        "pickup": "2024-12-03"
    }
]'),
(3, '2024-12-10', '[
    {
        "receipt_id": "R124",
        "garment": "suit",
        "color": "green",
        "cost": 29.99,
        "drop_off": "2024-12-10",
        "pickup": "2024-12-12"
    },
    {
        "receipt_id": "R125",
        "garment": "scarf",
        "color": "green",
        "cost": 10.99,
        "drop_off": "2024-12-10",
        "pickup": "2024-12-12"
    }
]')
;
