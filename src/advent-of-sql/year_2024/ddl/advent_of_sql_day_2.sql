/*
    https://adventofsql.com/challenges/2
    https://adventofsql.com/challenges/2/data
*/
drop schema if exists day_02 cascade;
create schema day_02;
use day_02;


/* Create tables */
create table day_02.letters_a (
    id int primary key,
    value integer
);
create table day_02.letters_b (
    id int primary key,
    value integer
);


/* Sample data */
insert into day_02.letters_a
values
    (1, 68),    -- D
    (2, 101),   -- e
    (3, 33),    -- ! (noise)
    (4, 97),    -- a
    (5, 114),   -- r
    (6, 32),    -- (space)
    (7, 83),    -- S
    (8, 35),    -- # (noise)
    (9, 97),    -- a
    (10, 110),  -- n
    (11, 116),  -- t
    (12, 97),   -- a
    (13, 44),   -- ,
    (14, 32),   -- (space)
    (15, 73),   -- I
    (16, 42),   -- * (noise)
    (17, 32),   -- (space)
    (18, 119),  -- w
    (19, 111),  -- o
    (20, 117),  -- u
    (21, 108),  -- l
    (22, 100)   -- d
;

insert into day_02.letters_b
values
    (23, 32),   -- (space)
    (24, 36),   -- $ (noise)
    (25, 108),  -- l
    (26, 105),  -- i
    (27, 107),  -- k
    (28, 101),  -- e
    (29, 32),   -- (space)
    (30, 97),   -- a
    (31, 32),   -- (space)
    (32, 80),   -- P
    (33, 111),  -- o
    (34, 37),   -- % (noise)
    (35, 110),  -- n
    (36, 121),  -- y
    (37, 32),   -- (space)
    (38, 102),  -- f
    (39, 111),  -- o
    (40, 114),  -- r
    (41, 32),   -- (space)
    (42, 67),   -- C
    (43, 104),  -- h
    (44, 38),   -- & (noise)
    (45, 114),  -- r
    (46, 105),  -- i
    (47, 115),  -- s
    (48, 116),  -- t
    (49, 109),  -- m
    (50, 97),   -- a
    (51, 115),  -- s
    (52, 44),   -- ,
    (53, 32),   -- (space)
    (54, 76),   -- L
    (55, 111),  -- o
    (56, 118),  -- v
    (57, 101),  -- e
    (58, 32),   -- (space)
    (59, 83),   -- S
    (60, 117),  -- u
    (61, 64),   -- @ (noise)
    (62, 115),  -- s
    (63, 105),  -- i
    (64, 101)  -- e
;
