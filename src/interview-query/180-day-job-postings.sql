/* https://www.interviewquery.com/questions/180-day-job-postings */

/*
    Only MySQL is available for this question 😭
*/
/* Solution (MySQL) */
with recent_job_postings as (
    select *
    from job_postings as o
    where 1=1
        and date_posted >= (
            select date_add(max(date_posted), interval -180 day)
            from job_postings
        )
        and date_posted = (
            select max(date_posted)
            from job_postings as i
            where o.job_id = i.job_id
        )
)

select
    floor(
        10000.0
        * count(case when is_revoked then 1 end)
        / count(*)
    ) / 100 as percentage
from recent_job_postings
;


/* Solution (PostgreSQL) */
with recent_job_postings as (
    select distinct on (job_id) is_revoked
    from job_postings as o
    where date_posted >= (
      select max(date_posted) - interval '180 days'
      from job_postings
    )
    order by job_id, date_posted desc
)

select
    floor(
        10000.0
        * count(case when is_revoked then 1 end)
        / count(*)
    ) / 100 as percentage
from recent_job_postings
;
