use day_07;

/* Passengers */
from passengers;

/* Cocoa cars */
from cocoa_cars;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with

stocked_cars as (
    from (
        from cocoa_cars
        qualify 3 >= dense_rank() over (
            order by total_stock desc
        )
    )
    select
        car_id,
        unnest(available_mixins) as mixin,
),

passenger_mixins as (
    from passengers
    select
        passenger_id,
        passenger_name,
        car_id,
        unnest(favorite_mixins) as mixin,
)

select
    passenger_mixins.passenger_name,
    list(distinct stocked_cars.car_id).list_sort() as car_id,
from passenger_mixins
    inner join stocked_cars
        using (mixin)
group by passenger_mixins.passenger_name
order by passenger_mixins.passenger_name
;


/* Solution (alternative) */
with stocked_cars as (
    from cocoa_cars
    qualify 3 >= dense_rank() over (
        order by total_stock desc
    )
)

select
    passengers.passenger_name,
    list(distinct stocked_cars.car_id).list_sort() as car_id,
from passengers
    inner join stocked_cars
        on passengers.favorite_mixins.list_has_any(stocked_cars.available_mixins)
group by passengers.passenger_name
order by passengers.passenger_name
;
