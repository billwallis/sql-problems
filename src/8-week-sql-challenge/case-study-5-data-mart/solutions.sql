/*
    https://8weeksqlchallenge.com/case-study-5/
*/
use data_mart;

/*
    A. Data Cleansing Steps

    In a single query, perform the following operations and generate a new
    table in the data_mart schema named clean_weekly_sales:

    - Convert the week_date to a DATE format
    - Add a week_number as the second column for each week_date value, for
      example any value from the 1st of January to 7th of January will be 1,
      8th to 14th will be 2 etc
    - Add a month_number with the calendar month for each week_date value as
      the 3rd column
    - Add a calendar_year column as the 4th column containing either 2018,
      2019 or 2020 values
    - Add a new column called age_band after the original segment column
      using the following mapping on the number inside the segment value

        | segment | age_band     |
        |---------+--------------|
        | 1       | Young Adults |
        | 2       | Middle Aged  |
        | 3 or 4  | Retirees     |

    - Add a new demographic column using the following mapping for the first
      letter in the segment values:

        | segment | demographic |
        |---------+-------------|
        | C       | Couples     |
        | F       | Families    |

    - Ensure all null string values with an "unknown" string value in the
      original segment column as well as the new age_band and demographic columns

    - Generate a new avg_transaction column as the sales value divided by
      transactions rounded to 2 decimal places for each record
*/
create or replace macro nullify(col) as
    if(lower(trim(col)) in ('', 'null'), null, col)
;

create or replace table clean_weekly_sales as
    from (
        from weekly_sales
        select * replace (
            week_date.strptime('%d/%-m/%y')::date as week_date,
            nullify(segment) as segment,
        )
    )
    select
        week_date,
        1 + (-1 + week_date.strftime('%j')::int) // 7 as week_number,
        month(week_date) as month_number,
        year(week_date) as year_number,
        region,
        platform,
        segment,
        case segment[2]
            when '1' then 'Young Adults'
            when '2' then 'Middle Aged'
            when '3' then 'Retirees'
            when '4' then 'Retirees'
        end as age_band,
        case segment[1]
            when 'C' then 'Couples'
            when 'F' then 'Families'
        end as demographic,
        customer_type,
        transactions,
        sales,
        round(sales / transactions, 2) as avg_transaction,
;


/*
    B. Data Exploration

    1.  What day of the week is used for each week_date value?
    2.  What range of week numbers are missing from the dataset?
    3.  How many total transactions were there for each year in the dataset?
    4.  What is the total sales for each region for each month?
    5.  What is the total count of transactions for each platform
    6.  What is the percentage of sales for Retail vs Shopify for each month?
    7.  What is the percentage of sales by demographic for each year in the dataset?
    8.  Which age_band and demographic values contribute the most to Retail sales?
    9.  Can we use the avg_transaction column to find the average transaction
        size for each year for Retail vs Shopify? If not - how would you
        calculate it instead?
*/

/* 1 - depends on the year? */
select
    year(dt) as year_numbers,
    extract(dow from dt) as day_of_week,
from generate_series(
    (select date_trunc('year', min(week_date)) from clean_weekly_sales),
    (select date_trunc('year', max(week_date)) from clean_weekly_sales),
    interval '1 year'
) as gs(dt)
;

/* 2 */
with expected_weeks as (
    select distinct
        year(dt) as year_number,
        1 + (-1 + dt.strftime('%j')::int) // 7 as week_number,
    from generate_series(
        (select date_trunc('year', min(week_date)) from clean_weekly_sales),
        (select date_trunc('year', max(week_date)) + interval '1 year -1 day' from clean_weekly_sales),
        interval '1 day'
    ) as gs(dt)
)

from expected_weeks
    anti join clean_weekly_sales
        using (year_number, week_number)
order by all
;

/* 3 */
select
    year_number,
    sum(transactions) as total_transactions,
from clean_weekly_sales
group by year_number
order by year_number
;

/* 4 */
select
    year_number,
    month_number,
    sum(sales) as total_sales,
from clean_weekly_sales
group by year_number, month_number
order by year_number, month_number
;

/* 5 */
select
    platform,
    sum(transactions) as total_transactions,
from clean_weekly_sales
group by platform
order by platform
;

/* 6 */
select
    year_number,
    month_number,
    100 * sum(sales) filter (where platform = 'Retail') / sum(sales) as retail_perc,
    100 * sum(sales) filter (where platform = 'Shopify') / sum(sales) as shopify_perc,
from clean_weekly_sales
group by year_number, month_number
order by year_number, month_number
;

/* 7 */
select
    year_number,
    100 * sum(sales) filter (where demographic = 'Couples') / sum(sales) as couples_perc,
    100 * sum(sales) filter (where demographic = 'Families') / sum(sales) as families_perc,
from clean_weekly_sales
group by year_number
order by year_number
;

/* 8 */
select age_band, demographic
from clean_weekly_sales
where 1=1
    and platform = 'Retail'
    -- and age_band is not null
    -- and demographic is not null
group by age_band, demographic
order by sum(sales) desc
limit 1
;

/* 9 */
select
    platform,
    round(sum(sales) / sum(transactions), 2) as avg_transaction,
from clean_weekly_sales
group by platform
order by platform
;


/*
    C. Before & After Analysis

    This technique is usually used when we inspect an important event and
    want to inspect the impact before and after a certain point in time.

    Taking the week_date value of 2020-06-15 as the baseline week where the
    Data Mart sustainable packaging changes came into effect.

    We would include all week_date values for 2020-06-15 as the start of the
    period after the change and the previous week_date values would be before

    Using this analysis approach - answer the following questions:

    1.  What is the total sales for the 4 weeks before and after 2020-06-15?
        What is the growth or reduction rate in actual values and percentage
        of sales?
    2.  What about the entire 12 weeks before and after?
    3.  How do the sale metrics for these 2 periods before and after compare
        with the previous years in 2018 and 2019?
*/

/* 1 */
with baseline_week as (
    select week_number
    from clean_weekly_sales
    where week_date = '2020-06-15'
)

from (
    select
        case when clean_weekly_sales.week_number < baseline_week.week_number
            then 'before'
            else 'after'
        end as week_period,
        sales,
    from clean_weekly_sales
        cross join baseline_week
    where 1=1
        /* requirements don't say which side this is, so ignoring it */
        and clean_weekly_sales.week_number != baseline_week.week_number
        and clean_weekly_sales.week_number between baseline_week.week_number - 4
                                               and baseline_week.week_number + 4
)
select
    sum(sales) filter (where week_period = 'before') as before,
    sum(sales) filter (where week_period = 'after') as after,
    after - before as growth_value,
    100 * growth_value / before as growth_percentage,
;

/* 2 */
with baseline_week as (
    select week_number
    from clean_weekly_sales
    where week_date = '2020-06-15'
)

from (
    select
        case when clean_weekly_sales.week_number < baseline_week.week_number
            then 'before'
            else 'after'
        end as week_period,
        clean_weekly_sales.sales,
    from clean_weekly_sales
        cross join baseline_week
    where 1=1
        /* requirements don't say which side this is, so ignoring it */
        and clean_weekly_sales.week_number != baseline_week.week_number
        and clean_weekly_sales.week_number between baseline_week.week_number - 12
                                               and baseline_week.week_number + 12
)
select
    sum(sales) filter (where week_period = 'before') as before,
    sum(sales) filter (where week_period = 'after') as after,
    after - before as growth_value,
    100 * growth_value / before as growth_percentage,
;

/* 3 - comparing like-for-like periods? or comparing all of 2018/2019? */
with

baseline_week as (
    select distinct
        week_number,
        week_number - 4 as from_week__4,
        week_number + 4 as to_week__4,
        week_number - 12 as from_week__12,
        week_number + 12 as to_week__12,
    from clean_weekly_sales
    where week_date = '2020-06-15'
),

week_numbers as (
    select
        clean_weekly_sales.year_number,
        clean_weekly_sales.week_number,
        clean_weekly_sales.sales,

        clean_weekly_sales.week_number < baseline_week.week_number as before,
        clean_weekly_sales.week_number > baseline_week.week_number as after,

        (
            clean_weekly_sales.week_number between baseline_week.from_week__4
                                               and baseline_week.to_week__4
        ) as _4_week,
        (
            clean_weekly_sales.week_number between baseline_week.from_week__12
                                               and baseline_week.to_week__12
        ) as _12_week,
    from clean_weekly_sales
        inner join baseline_week
            on clean_weekly_sales.week_number between baseline_week.from_week__12
                                                  and baseline_week.to_week__12
    /* requirements don't say which side this is, so ignoring it */
    where clean_weekly_sales.week_number != baseline_week.week_number
)

from week_numbers
select
    year_number,
    sum(sales) filter (where before and _4_week) as before__4_week,
    sum(sales) filter (where after and _4_week) as after__4_week,
    sum(sales) filter (where before and _12_week) as before__12_week,
    sum(sales) filter (where after and _12_week) as after__12_week,
    after__4_week - before__4_week as growth_value__4_week,
    100 * growth_value__4_week / before__4_week as growth_percentage__4_week,
    after__12_week - before__12_week as growth_value__12_week,
    100 * growth_value__12_week / before__12_week as growth_percentage__12_week,
group by year_number
order by year_number
;


/*
    D. Bonus Question

    Which areas of the business have the highest negative impact in sales
    metrics performance in 2020 for the 12 week before and after period?

    - region
    - platform
    - age_band
    - demographic
    - customer_type

    Do you have any further recommendations for Danny’s team at Data Mart or
    any interesting insights based off this analysis?
*/

with baseline_week as (
    select week_number
    from clean_weekly_sales
    where week_date = '2020-06-15'
)

from (
    select
        case when clean_weekly_sales.week_number < baseline_week.week_number
            then 'before'
            else 'after'
        end as week_period,
        clean_weekly_sales.region,
        clean_weekly_sales.platform,
        clean_weekly_sales.age_band,
        clean_weekly_sales.demographic,
        clean_weekly_sales.customer_type,
        clean_weekly_sales.sales,
    from clean_weekly_sales
        cross join baseline_week
    where 1=1
        /* requirements don't say which side this is, so ignoring it */
        and clean_weekly_sales.week_number != baseline_week.week_number
        and clean_weekly_sales.week_number between baseline_week.week_number - 12
                                               and baseline_week.week_number + 12
)
select
    region,
    platform,
    age_band,
    demographic,
    customer_type,
    sum(sales) filter (where week_period = 'before') as before,
    sum(sales) filter (where week_period = 'after') as after,
    after - before as growth_value,
    100 * growth_value / before as growth_percentage,
group by
    region,
    platform,
    age_band,
    demographic,
    customer_type
order by growth_value
limit 10  /* top 10 offenders */
;
