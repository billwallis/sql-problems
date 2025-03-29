/*
    https://8weeksqlchallenge.com/case-study-8/
*/
use fresh_segments;

/*
    A. Data Exploration and Cleansing

    1.  Update the fresh_segments.interest_metrics table by modifying the
        month_year column to be a date data type with the start of the month
    2.  What is count of records in the fresh_segments.interest_metrics for
        each month_year value sorted in chronological order (earliest to
        latest) with the null values appearing first?
    3.  What do you think we should do with these null values in the
        fresh_segments.interest_metrics
    4.  How many interest_id values exist in the fresh_segments.interest_metrics
        table but not in the fresh_segments.interest_map table? What about
        the other way around?
    5.  Summarise the id values in the fresh_segments.interest_map by its
        total record count in this table
    6.  What sort of table join should we perform for our analysis and why?
        Check your logic by checking the rows where interest_id = 21246 in
        your joined output and include all columns from fresh_segments.interest_metrics
        and all columns from fresh_segments.interest_map except from the id column.
    7.  Are there any records in your joined table where the month_year
        value is before the created_at value from the fresh_segments.interest_map
        table? Do you think these values are valid and why?
*/

/* 1 */
start transaction;
    update interest_metrics
    set month_year = month_year.strptime('%m-%Y')::date
    where month_year is not null
    ;
    alter table interest_metrics
    alter month_year type date
    ;
    from interest_metrics;
commit;

/* 2 */
select
    month_year,
    count(*) as counts,
from interest_metrics
group by month_year
order by month_year nulls first
;

/* 3 */
-- you tell me bro

/* 4a */
select count(distinct interest_id)
from interest_metrics
    anti join interest_map
        on interest_metrics.interest_id = interest_map.id
;

/* 4b */
select count(distinct id)
from interest_map
    anti join interest_metrics
        on interest_map.id = interest_metrics.interest_id
;

/* 5 - what? what table? */
select count(*) as records,
from interest_map
;

/* 6 - what? */
from interest_map where id = 21246;
from interest_metrics where interest_id = 21246;

/* 7 */
-- I'm lost, not sure what the context is supposed to be at this point


/*
    B. Interest Analysis

    1.  Which interests have been present in all month_year dates in our dataset?
    2.  Using this same total_months measure - calculate the cumulative
        percentage of all records starting at 14 months - which total_months
        value passes the 90% cumulative percentage value?
    3.  If we were to remove all interest_id values which are lower than the
        total_months value we found in the previous question - how many
        total data points would we be removing?
    4.  Does this decision make sense to remove these data points from a
        business perspective? Use an example where there are all 14 months
        present to a removed interest example for your arguments - think
        about what it means to have less months present from a segment
        perspective.
    5.  After removing these interests - how many unique interests are
        there for each month?
*/

/* 1 */
select distinct interest_id
from interest_metrics
group by interest_id
having count(distinct month_year) = (
    select count(distinct month_year)
    from interest_metrics
)
order by interest_id
;

/* 2 - what is total_months? Define it first pls, smh */
-- I really don't understand this question

/* 3 */
-- Didn't do 2, so can't do 3

/* 4 */
-- Didn't do 3, so can't do 4

/* 5 */
-- Didn't do 4, so can't do 5


/*
    C. Segment Analysis

    1.  Using our filtered dataset by removing the interests with less than
        6 months worth of data, which are the top 10 and bottom 10 interests
        which have the largest composition values in any month_year? Only
        use the maximum composition value for each interest but you must
        keep the corresponding month_year
    2.  Which 5 interests had the lowest average ranking value?
    3.  Which 5 interests had the largest standard deviation in their
        percentile_ranking value?
    4.  For the 5 interests found in the previous question - what was
        minimum and maximum percentile_ranking values for each interest and
        its corresponding year_month value? Can you describe what is
        happening for these 5 interests?
    5.  How would you describe our customers in this segment based off their
        composition and ranking values? What sort of products or services
        should we show to these customers and what should we avoid?
*/

/* 1 */
select
    interest_metrics.month_year,
    interest_metrics.interest_id,
    interest_map.interest_name,
    interest_metrics.composition,
from interest_metrics
    inner join interest_map
        on interest_metrics.interest_id = interest_map.id
where 6 <= datediff('month', interest_map.created_at, interest_metrics.month_year)
qualify 0=1
    or 10 >= rank() over (order by interest_metrics.composition)  /* bottom 10 */
    or 10 >= rank() over (order by interest_metrics.composition desc)  /* top 10 */
order by interest_metrics.composition
;

/* 2 */
select
    interest_metrics.interest_id,
    any_value(interest_map.interest_name) as interest_name,
    avg(interest_metrics.ranking) as avg_ranking,
from interest_metrics
    inner join interest_map
        on interest_metrics.interest_id = interest_map.id
group by interest_metrics.interest_id
qualify 5 >= rank() over (order by avg_ranking)
order by avg_ranking
;

/* 3 */
select
    interest_metrics.interest_id,
    any_value(interest_map.interest_name) as interest_name,
    stddev(interest_metrics.percentile_ranking) as ranking_stddev,
from interest_metrics
    inner join interest_map
        on interest_metrics.interest_id = interest_map.id
group by interest_metrics.interest_id
qualify 5 >= rank() over (order by ranking_stddev desc)
order by ranking_stddev desc
;

/* 4 */
select
    interest_metrics.interest_id,
    any_value(interest_map.interest_name) as interest_name,
    stddev(interest_metrics.percentile_ranking) as ranking_stddev,
    min(interest_metrics.percentile_ranking) as ranking_min,
    min_by(interest_metrics.month_year, interest_metrics.percentile_ranking) as ranking_min_month_year,
    max(interest_metrics.percentile_ranking) as ranking_max,
    max_by(interest_metrics.month_year, interest_metrics.percentile_ranking) as ranking_max_month_year,
from interest_metrics
    inner join interest_map
        on interest_metrics.interest_id = interest_map.id
group by interest_metrics.interest_id
qualify 5 >= rank() over (order by ranking_stddev desc)
order by ranking_stddev desc
;

/* 5 */
-- skip


/*
    D. Index Analysis

    The index_value is a measure which can be used to reverse calculate the
    average composition for Fresh Segments’ clients.

    Average composition can be calculated by dividing the composition column
    by the index_value column rounded to 2 decimal places.

    1.  What is the top 10 interests by the average composition for each month?
    2.  For all of these top 10 interests - which interest appears the most often?
    3.  What is the average of the average composition for the top 10
        interests for each month?
    4.  What is the 3 month rolling average of the max average composition
        value from September 2018 to August 2019 and include the previous
        top ranking interests in the same output shown below.
    5.  Provide a possible reason why the max average composition might
        change from month to month? Could it signal something is not quite
        right with the overall business model for Fresh Segments?
*/

/* 1 */
select
    month_year,
    interest_id,
    composition / index_value as average_composition,
from interest_metrics
qualify 10 >= rank() over (
    partition by month_year
    order by average_composition desc
)
order by
    month_year,
    average_composition desc
;

/* 2 */
from (
    select
        month_year,
        interest_id,
        composition / index_value as average_composition,
    from interest_metrics
    qualify 10 >= rank() over (
        partition by month_year
        order by average_composition desc
    )
)
select
    interest_id,
    count(*) as occurrences,
group by interest_id
order by occurrences desc
limit 1
;

/* 3 */
from (
    select
        month_year,
        interest_id,
        composition / index_value as average_composition,
    from interest_metrics
    qualify 10 >= rank() over (
        partition by month_year
        order by average_composition desc
    )
)
select
    month_year,
    avg(average_composition) as avg_average_composition,
group by month_year
order by month_year
;

/* 4 */
from (
    select
        month_year,
        interest_id,
        round(composition / index_value, 2)::numeric(6, 2) as max_index_composition,
    from interest_metrics
    qualify 1 = rank() over (
        partition by month_year
        order by max_index_composition desc
    )
) as compositions
    inner join interest_map
        on compositions.interest_id = interest_map.id
select
    compositions.month_year,
    interest_map.interest_name,
    compositions.max_index_composition,
    (avg(compositions.max_index_composition) over (
        month_year_asc rows 2 preceding
    ))::numeric(6, 2) as "3_month_moving_avg",
    format('{}: {}',
        lag(interest_map.interest_name) over month_year_asc,
        lag(compositions.max_index_composition) over month_year_asc
    ) as "1_month_ago",
    format('{}: {}',
        lag(interest_map.interest_name, 2) over month_year_asc,
        lag(compositions.max_index_composition, 2) over month_year_asc
    ) as "2_month_ago",
window month_year_asc as (order by month_year)
qualify 3 = count(*) over (month_year_asc rows 2 preceding)
order by compositions.month_year
;

/* 5 */
-- shrug
