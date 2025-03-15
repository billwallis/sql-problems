/* https://platform.stratascratch.com/coding/10046-top-5-states-with-5-star-businesses */

/* Sample data */
create table yelp_business (
    business_id text,
    name text,
    neighborhood text,
    address text,
    city text,
    state text,
    postal_code text,
    latitude numeric,
    longitude numeric,
    stars numeric,
    review_count int,
    is_open int,
    categories text
);
insert into yelp_business
values
    ('G5ERFWvPfHy7IDAUYlWL2A', 'All Colors Mobile Bumper Repair', null,        '7137 N 28th Ave',              'Phoenix',        'AZ', 85051, 33.45, 112.07,  1,  4, 1, 'Auto Detailing;Automotive'),
    ('0jDvRJS-z9zdMgOUXgr6rA', 'Sunfare',                         null,        '811 W Deer Valley Rd',         'Phoenix',        'AZ', 85027, 33.68, 112.08,  5, 27, 1, 'Personal Chefs;Food;Gluten-Free;Food Delivery Services;Event Planning & Services;Restaurants'),
    ('6HmDqeNNZtHMK0t2glF_gg', 'Dry Clean Vegas',                 'Southeast', '2550 Windmill Ln, Ste 100',    'Las Vegas',      'NV', 89123, 36.04, 115.12,  1,  4, 1, 'Dry Cleaning & Laundry;Laundry Services;Local Services;Dry Cleaning'),
    ('pbt3SBcEmxCfZPdnmU9tNA', 'The Cuyahoga Room',               null,        '740 Munroe Falls Ave',         'Cuyahoga Falls', 'OH', 44221, 41.14,  81.47,  1,  3, 0, 'Wedding Planning;Caterers;Event Planning & Services;Venues & Event Spaces'),
    ('CX8pfLn7Bk9o2-8yDMp_2w', 'The UPS Store',                   null,        '4815 E Carefree Hwy, Ste 108', 'Cave Creek',     'AZ', 85331, 33.80, 111.98, 1.5, 5, 1, 'Notaries;Printing Services;Local Services;Shipping Centers')
;


/* Solution */
with reviews_by_state as (
    select
        state,
        count(*) as n_businesses,
        dense_rank() over (
            order by count(*) desc
        ) as state_rank
    from yelp_business
    where stars = 5
    group by state
)

select state, n_businesses
from reviews_by_state
where state_rank <= 5
;

/*
    This isn't "hard"  ¯\_(ツ)_/¯
*/
