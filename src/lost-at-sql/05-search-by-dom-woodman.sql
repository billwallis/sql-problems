/* https://lost-at-sql.therobinlord.com/challenge-page/search */

/*
    No matter what I do, I can't get an accepted solution.
*/
/* Solution */
with

clicks_and_keywords as (
    select
        path,
        dt >= date(max_dt, '-1 day') as recent_flag,
        sum(clicks) as total_clicks,
        count(distinct query) as unique_keywords
    from (
        select
            *,
            date(substring(pt, 1, 10)) as dt,
            max(date(substring(pt, 1, 10))) over (partition by path) as max_dt
        from search_data
    )
    where dt >= date(max_dt, '-3 days')
    group by path, recent_flag
),

paths as (select distinct path from search_data),
most_recent as (select * from clicks_and_keywords where recent_flag),
prior as (select * from clicks_and_keywords where not recent_flag)

select
    path,
    (
        coalesce(most_recent.total_clicks, 0)
        - coalesce(prior.total_clicks, 0)
    ) as diff_total_clicks,
    (
        coalesce(most_recent.unique_keywords, 0)
        - coalesce(prior.unique_keywords, 0)
    ) as diff_unique_keywords
from paths
    full join most_recent
        using (path)
    full join prior
        using (path)
order by diff_total_clicks desc
;
