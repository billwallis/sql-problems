/* https://www.hackerrank.com/challenges/interviews/problem */

/* Sample data */
drop table contests;
create table contests (
    contest_id integer,
    hacker_id  integer,
    name       varchar(max)
);
insert into contests
values
    (66406, 17973, 'Rose'),
    (66556, 79153, 'Angela'),
    (94828, 80275, 'Frank')
;


drop table colleges;
create table colleges (
    college_id integer,
    contest_id integer
);
insert into colleges
values
    (11219, 66406),
    (32473, 66556),
    (56685, 94828)
;


drop table challenges;
create table challenges (
    challenge_id integer,
    college_id   integer
);
insert into challenges
values
    (18765, 11219),
    (47127, 11219),
    (60292, 32473),
    (72974, 56685)
;


drop table view_stats;
create table view_stats (
    challenge_id       integer,
    total_views        integer,
    total_unique_views integer
);
insert into view_stats
values
    (47127, 26, 19),
    (47127, 15, 14),
    (18765, 43, 10),
    (18765, 72, 13),
    (75516, 35, 17),
    (60292, 11, 10),
    (72974, 41, 15),
    (75516, 75, 11)
;


drop table submission_stats;
create table submission_stats (
    challenge_id               integer,
    total_submissions          integer,
    total_accepted_submissions integer
);
insert into submission_stats
values
    (75516, 34, 12),
    (47127, 27, 10),
    (47127, 56, 18),
    (75516, 74, 12),
    (75516, 83,  8),
    (72974, 68, 24),
    (72974, 82, 14),
    (47127, 28, 11)
;


/* Sample output */
select *
from (
    values
        (66406, 17973, 'Rose',   111, 39, 156, 56),
        (66556, 79153, 'Angela',   0,  0,  11, 10),
        (94828, 80275, 'Frank',  150, 38,  41, 15)
) as solution(contest_id, hacker_id, name, total_submissions, total_accepted_submissions, total_views, total_unique_views)
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with

total_view_stats as (
    select
        challenge_id,
        sum(total_views) as total_views,
        sum(total_unique_views) as total_unique_views
    from view_stats
    group by challenge_id
),

total_submission_stats as (
    select
        challenge_id,
        sum(total_submissions) as total_submissions,
        sum(total_accepted_submissions) as total_accepted_submissions
    from submission_stats
    group by challenge_id
),

contest_stats as (
    select
        colleges.contest_id,
        sum(coalesce(total_view_stats.total_views, 0)) as total_views,
        sum(coalesce(total_view_stats.total_unique_views, 0)) as total_unique_views,
        sum(coalesce(total_submission_stats.total_submissions, 0)) as total_submissions,
        sum(coalesce(total_submission_stats.total_accepted_submissions, 0)) as total_accepted_submissions
    from colleges
        left join challenges
            on colleges.college_id = challenges.college_id
        left join total_view_stats
            on challenges.challenge_id = total_view_stats.challenge_id
        left join total_submission_stats
            on challenges.challenge_id = total_submission_stats.challenge_id
    group by colleges.contest_id
)

select
    contests.contest_id,
    contests.hacker_id,
    contests.name,
    contest_stats.total_submissions,
    contest_stats.total_accepted_submissions,
    contest_stats.total_views,
    contest_stats.total_unique_views
from contests
    left join contest_stats
        on contests.contest_id = contest_stats.contest_id
where not (1=1
    and contest_stats.total_submissions = 0
    and contest_stats.total_accepted_submissions = 0
    and contest_stats.total_views = 0
    and contest_stats.total_unique_views = 0
)
order by contest_id
;
