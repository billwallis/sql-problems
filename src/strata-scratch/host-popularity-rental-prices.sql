/* https://platform.stratascratch.com/coding/9632-host-popularity-rental-prices */

/* Sample data */
create table airbnb_host_searches (
    id int,
    price numeric,
    property_type text,
    room_type text,
    amenities text,
    accommodates int,
    bathrooms int,
    bed_type text,
    cancellation_policy text,
    cleaning_fee boolean,
    city text,
    host_identity_verified text,
    host_response_rate text,
    host_since date,
    neighbourhood text,
    number_of_reviews int,
    review_scores_rating numeric,
    zipcode int,
    bedrooms int,
    beds int
);
insert into airbnb_host_searches
values
    ( 8284881, 621.46, 'House',     'Entire home/apt', '{TV,"Cable TV",Internet,"Wireless Internet","Air conditioning",Pool,Kitchen,"Free parking on premises",Gym,"Hot tub","Indoor fireplace",Heating,"Family/kid friendly",Washer,Dryer,"Smoke detector","Carbon monoxide detector","First aid kit","Safety card","Fire extinguisher",Essentials,Shampoo,"24-hour check-in",Hangers,"Hair dryer",Iron,"Laptop friendly workspace"}', 8, 3, 'Real Bed', 'strict',   true,  'LA',  'f', '100%', '2016-11-01', 'Pacific Palisades', 1, null, 90272, 4, 6),
    ( 8284882, 621.46, 'House',     'Entire home/apt', '{TV,"Cable TV",Internet,"Wireless Internet","Air conditioning",Pool,Kitchen,"Free parking on premises",Gym,"Hot tub","Indoor fireplace",Heating,"Family/kid friendly",Washer,Dryer,"Smoke detector","Carbon monoxide detector","First aid kit","Safety card","Fire extinguisher",Essentials,Shampoo,"24-hour check-in",Hangers,"Hair dryer",Iron,"Laptop friendly workspace"}', 8, 3, 'Real Bed', 'strict',   true,  'LA',  'f', '100%', '2016-11-01', 'Pacific Palisades', 1, null, 90272, 4, 6),
    ( 9479348, 598.90, 'Apartment', 'Entire home/apt', '{"Wireless Internet","Air conditioning",Kitchen,Heating,"Smoke detector","Carbon monoxide detector",Essentials,Shampoo,Hangers,Iron,"translation missing: en.hosting_amenity_49","translation missing: en.hosting_amenity_50"}',                                                                                                                                                7, 2, 'Real Bed', 'strict',   false, 'NYC', 'f', '100%', '2017-07-03', 'Hell''s Kitchen',   1, 60,   10036, 3, 4),
    ( 8596057, 420.47, 'House',     'Private room',    '{"Wireless Internet","Air conditioning",Pool,Kitchen,"Free parking on premises",Breakfast,"Family/kid friendly",Washer,Dryer,Essentials,Shampoo,Hangers,"Hair dryer","Self Check-In","Doorman Entry"}',                                                                                                                                                                         1, 2, 'Real Bed', 'flexible', false, 'LA',  'f', '100%', '2016-04-20', null,                0, null, 91748, 1, 1),
    (11525500, 478.75, 'Apartment', 'Entire home/apt', '{"Wireless Internet","Air conditioning",Heating,Washer,Dryer,Essentials,"Laptop friendly workspace",Microwave,Refrigerator,Dishwasher,"Dishes and silverware","Cooking basics",Oven,Stove,"Host greets you"}',                                                                                                                                                                  2, 1, 'Real Bed', 'flexible', true,  'NYC', 'f', '100%', '2017-10-07', 'Williamsburg',      2, 100,  11206, 1, 1)
;


/* Solution */
with

host_popularity(from_reviews, to_reviews, popularity_rating) as (
    values
        ( 0,   0, 'New'),
        ( 1,   5, 'Rising'),
        ( 6,  15, 'Trending Up'),
        (16,  40, 'Popular'),
        (41, 999, 'Hot')
),

all_searches as (
    select distinct on (
        searches.price,
        searches.room_type,
        searches.host_since,
        searches.zipcode,
        searches.number_of_reviews
    )
        host_popularity.popularity_rating,
        searches.price
    from airbnb_host_searches as searches
        left join host_popularity
            on searches.number_of_reviews between host_popularity.from_reviews
                                              and host_popularity.to_reviews
)

select
    popularity_rating,
    min(price) as min_price,
    avg(price) as avg_price,
    max(price) as max_price
from all_searches
group by popularity_rating
order by min_price
;
