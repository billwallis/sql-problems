/* https://leetcode.com/problems/trips-and-users/ */
use leetcode;

/* Sample input */
create table trips (
    id         int,
    client_id  int,
    driver_id  int,
    city_id    int,
    status     varchar(50),
    request_at date
);
truncate table trips;
insert into trips
values
    ( 1, 1, 10,  1, 'completed',           '2013-10-01'),
    ( 2, 2, 11,  1, 'cancelled_by_driver', '2013-10-01'),
    ( 3, 3, 12,  6, 'completed',           '2013-10-01'),
    ( 4, 4, 13,  6, 'cancelled_by_client', '2013-10-01'),
    ( 5, 1, 10,  1, 'completed',           '2013-10-02'),
    ( 6, 2, 11,  6, 'completed',           '2013-10-02'),
    ( 7, 3, 12,  6, 'completed',           '2013-10-02'),
    ( 8, 2, 12, 12, 'completed',           '2013-10-03'),
    ( 9, 3, 10, 12, 'completed',           '2013-10-03'),
    (10, 4, 13, 12, 'cancelled_by_driver', '2013-10-03')
;

create table users (
    users_id int,
    banned   varchar(50),
    role     varchar(50)
);
truncate table users;
insert into users
values
    ( 1, 'No',  'client'),
    ( 2, 'Yes', 'client'),
    ( 3, 'No',  'client'),
    ( 4, 'No',  'client'),
    (10, 'No',  'driver'),
    (11, 'No',  'driver'),
    (12, 'No',  'driver'),
    (13, 'No',  'driver')
;

/* Sample output */
select *
from (values
    row('2013-10-01', 0.33),
    row('2013-10-02', 0.00),
    row('2013-10-03', 0.50)
) as v(Day, `Cancellation Rate`)
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select
    request_at as Day,
    round(
        count(case when left(status, 9) = 'cancelled' then 1 end) / count(*),
        2
    ) as `Cancellation Rate`
from trips
where 1=1
    and request_at between '2013-10-01' and '2013-10-03'
    and not exists (
        select *
        from users
        where 1=1
            and users.banned = 'Yes'
            and (0=1
                or (trips.client_id = users.users_id and users.role = 'client')
                or (trips.driver_id = users.users_id and users.role = 'driver')
            )
    )
group by request_at
order by Day
;
