/* https://www.interviewquery.com/questions/ad-engagement-analysis-for-qualified-users */

/*
    How is "total_qualified_impressions" defined? 🙄
*/
/* Solution (PostgreSQL) */
with

last_48_hours as (
    select *
    from ad_interactions
    where created_at >= (
        select max(created_at) - interval '48 hours'
        from ad_interactions
    )
),

clicks_and_impressions as (
    select
        ad_type_id,
        count(*) filter (where interaction_type = 'click') as clicks,
        count(distinct user_id) filter (where interaction_type = 'impression') as impressions
    from last_48_hours
    where user_id in (
        select user_id
        from last_48_hours
        where interaction_type = 'impression'
        group by user_id
        having count(distinct ad_type_id) >= 3
    )
    group by ad_type_id
)

select
    ad_types.name as ad_name,
    round(100.0 * aggs.clicks / nullif(aggs.impressions, 0), 2) as engagement_rate,
    coalesce(aggs.impressions, 0) as total_qualified_impressions
from ad_types
    left join clicks_and_impressions as aggs
        on ad_types.id = aggs.ad_type_id
order by
    engagement_rate desc nulls last,
    total_qualified_impressions desc
;
