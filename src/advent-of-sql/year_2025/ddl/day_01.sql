/*
    https://databaseschool.com/series/advent-of-sql/videos/309
    https://databaseschool.com/download/day-1-inserts
*/
drop schema if exists day_01 cascade;
create schema day_01;
use day_01;


-- Advent of SQL - Day 1 Data
--
-- This file creates and populates the wish_list table
-- for day 1 of the Advent of SQL challenge by Database School.
--
-- Usage: Run this file in any SQL client (TablePlus, pgAdmin, etc.)


drop table if exists wish_list cascade;
create sequence day_01.wish_list__pk start 1;
create table day_01.wish_list (
   id          bigint primary key default nextval('day_01.wish_list__pk'),
   child_name  text,
   raw_wish    text
);
