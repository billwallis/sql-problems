/* https://quip.com/2gwZArKuWk7W */

/* Sample data (fabricated) */
create or replace table sessions (
    session_id int,
    length_seconds int,
);
insert into sessions
    from generate_series(1, 100) as gs(n)
    select n, 50 * random()
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
    The solution is missing the FROM clause 😶
*/

/* Solution */
from (
    from sessions
    select
        length_seconds,
        (floor(length_seconds / 5) * 5)::int as bucket_lower,
        format('{}-{}', bucket_lower, bucket_lower + 5) as bucket,
)
select bucket, count(*)
group by bucket
order by any_value(bucket_lower)
;
