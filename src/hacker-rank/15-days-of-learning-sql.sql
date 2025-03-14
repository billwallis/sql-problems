/* https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem */

/* Sample data */
drop table hackers;
create table hackers (
    hacker_id integer,
    name      varchar(20)
);
insert into hackers
values
    (15758, 'Rose'),
    (20703, 'Angela'),
    (36396, 'Frank'),
    (38289, 'Patrick'),
    (44065, 'Lisa'),
    (53473, 'Kimberly'),
    (62529, 'Bonnie'),
    (79722, 'Michael')
;


drop table submissions;
create table submissions (
    submission_date date,
    submission_id   integer,
    hacker_id       integer,
    score           integer
);
insert into submissions
values
    ('2016-03-01',  8494, 20703,  0),
    ('2016-03-01', 22403, 53473, 15),
    ('2016-03-01', 23965, 79722, 60),
    ('2016-03-01', 30173, 36396, 70),
    ('2016-03-02', 34928, 20703,  0),
    ('2016-03-02', 38740, 15758, 60),
    ('2016-03-02', 42769, 79722, 25),
    ('2016-03-02', 44364, 79722, 60),
    ('2016-03-03', 45440, 20703,  0),
    ('2016-03-03', 49050, 36396, 70),
    ('2016-03-03', 50273, 79722,  5),
    ('2016-03-04', 50344, 20703,  0),
    ('2016-03-04', 51360, 44065, 90),
    ('2016-03-04', 54404, 53473, 65),
    ('2016-03-04', 61533, 79722, 45),
    ('2016-03-05', 72852, 20703,  0),
    ('2016-03-05', 74546, 38289,  0),
    ('2016-03-05', 76487, 62529,  0),
    ('2016-03-05', 82439, 36396, 10),
    ('2016-03-05', 90006, 36396, 40),
    ('2016-03-06', 90404, 20703,  0)
;


/* Sample output */
values
    /* submission_date, unique_hackers, hacker_id, name */
    ('2016-03-01', 4, 20703, 'Angela'),
    ('2016-03-02', 2, 79722, 'Michael'),
    ('2016-03-03', 2, 20703, 'Angela'),
    ('2016-03-04', 2, 20703, 'Angela'),
    ('2016-03-05', 1, 36396, 'Frank'),
    ('2016-03-06', 1, 20703, 'Angela')
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with

axis as (
    select distinct submission_date
    from submissions
),

daily_hacker_submissions as (
    select
        submission_date,
        hacker_id,
        count(*) as submissions,
        (
            dense_rank() over (order by submission_date)
            - row_number() over (partition by hacker_id order by submission_date)
        ) as streak_id,  /* zero-indexed from the first submission date */
        row_number() over (
            partition by submission_date
            order by count(*) desc, hacker_id
        ) as hacker_rank
    from submissions
    group by
        submission_date,
        hacker_id
),

streaking_hackers as (
    select
        submission_date,
        count(distinct hacker_id) as distinct_hackers
    from daily_hacker_submissions
    where streak_id = 0
    group by submission_date
)

select
    streaking_hackers.submission_date,
    streaking_hackers.distinct_hackers,
    daily_hacker_submissions.hacker_id,
    hackers.name
from axis
    left join streaking_hackers
        on axis.submission_date = streaking_hackers.submission_date
    left join daily_hacker_submissions
        on  streaking_hackers.submission_date = daily_hacker_submissions.submission_date
        and daily_hacker_submissions.hacker_rank = 1
    left join hackers
        on daily_hacker_submissions.hacker_id = hackers.hacker_id
order by submission_date
;
