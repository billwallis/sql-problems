/* https://leetcode.com/problems/human-traffic-of-stadium/ */
use leetcode;

/* Sample input */
create table stadium (
    id         int,
    visit_date date,
    people     int
);
truncate table stadium;
insert into stadium
values
    (1, '2017-01-01', 10),
    (2, '2017-01-02', 109),
    (3, '2017-01-03', 150),
    (4, '2017-01-04', 99),
    (5, '2017-01-05', 145),
    (6, '2017-01-06', 1455),
    (7, '2017-01-07', 199),
    (8, '2017-01-09', 188)
;

/* Sample output */
select *
from (values
    row(5, '2017-01-05', 145),
    row(6, '2017-01-06', 1455),
    row(7, '2017-01-07', 199),
    row(8, '2017-01-09', 188)
) as v(id, visit_date, people)
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select id, visit_date, people
from (
    select *, count(*) over (partition by group_id) as group_count
    from(
        select *, sum(group_start) over (order by id) as group_id
        from (
            select *, id != 1 + lag(id, 1, id) over (order by id) as group_start
            from stadium
            where people >= 100
        ) as group_starts
    ) as group_ids
) as group_counts
where group_count >= 3
order by visit_date
;
