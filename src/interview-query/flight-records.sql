/* https://www.interviewquery.com/questions/flight-records */

/*
    Another one that isn't "hard" 🙄
*/
/* Solution (PostgreSQL) */
select *
from (
        select source_location, destination_location
        from flights
    union
        select destination_location, source_location
        from flights
) as all_flights(destination_one, destination_two)
where destination_one < destination_two
;
