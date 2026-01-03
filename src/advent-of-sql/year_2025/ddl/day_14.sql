/*
    https://databaseschool.com/series/advent-of-sql/videos/325
    https://databaseschool.com/download/day-14-inserts
*/
drop schema if exists day_14 cascade;
create schema day_14;
use day_14;


create or replace table day_14.mountain_network (
    id integer primary key,
    from_node text,
    to_node text,
    node_type text,  /* 'Lift' or 'Trail' */
    difficulty text  /* Only applicable for trails: 'green', 'blue', 'black', 'double_black' */
);
