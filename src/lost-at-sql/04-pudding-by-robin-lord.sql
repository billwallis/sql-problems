/* https://lost-at-sql.therobinlord.com/challenge-page/pudding */

/*
    The problem asks for SNR_MANAGER_ID but the SQL snippet asks for
    SENIOR_MANAGER_ID, please be consistent :(

    I also got the "correct" answer by accident with a logical error in my
    solution, but the answer that I think is correct is not accepted by the
    site.
*/
/* Solution */
with recursive

staff as (
        select
            person_id as snr_manager_id,
            person_id as managee_id
        from crew
        where person_seniority = 'senior manager'
    union all
        select
            staff.snr_manager_id,
            crew.person_id
        from staff
            inner join crew
                on staff.managee_id = crew.manager_id
),

pudding_thiefs(managee_id, thief_rank) as (
    select
        staff_id,
        rank() over (order by count(distinct date(timestamp)) desc)
    from (
        select
            food_taken.timestamp,
            food_taken.staff_id,
            food_left.number_left,
            count(*) over (
                partition by
                    food_taken.staff_id,
                    date(food_taken.timestamp)
            ) as puddings_taken,
            1 = rank() over (
                partition by date(food_taken.timestamp)
                order by food_taken.timestamp desc
            ) as took_last
        from food_taken
            left join food
                using (meal, food_id)
            left join food_left
                on  date(food_taken.timestamp) = food_left.date
                and food.food = food_left.food
        where 1=1
            and food.food = 'pudding'
            and food_left.number_left = 0
    )
    where 1=1
        and puddings_taken = 2
        and took_last
    group by staff_id
)

select
    staff.snr_manager_id,
    count(*) as offender_count
from pudding_thiefs
    left join staff
        using (managee_id)
where pudding_thiefs.thief_rank <= 5
group by staff.snr_manager_id
order by
    offender_count desc,
    snr_manager_id
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
    Since it's not clarified in the problem statement, I'm assuming that the
    figures in the `food_left` table are food left _at the end of the day_,
    not the available number of items at the start of the day.

    Additionally, I'm assuming that a single entry in the `food_taken` table
    only counts as a single food item taken. Therefore, the number of
    puddings available at the start of a given day would be their number
    remaining in the `food_left` table, plus the number of pudding rows in
    the `food_taken` table for the day.

    There are places where multiple people seem to take the final puddings
    at the same time, and it's not clear how these cases are supposed to be
    handled -- and no matter what I do, my solution is not accepted.
*/

/* Pudding helpings */
drop view if exists pudding_helpings;
create view pudding_helpings as
    select
        datetime(food_taken.timestamp) as meal_ts,
        food_taken.meal,
        food_taken.staff_id,
        food_left.number_left + count(*) over (
            partition by date(food_taken.timestamp)
            order by food_taken.timestamp
            groups between current row and unbounded following
            exclude group
        ) as puddings_left,
        count(*) over (
            partition by food_taken.staff_id, date(food_taken.timestamp)
            order by food_taken.timestamp
        ) as staff_pudding_helping
    from food_taken
        left join food
            using (meal, food_id)
        left join food_left
            on  date(food_taken.timestamp) = food_left.date
            and food.food = food_left.food
    where food.food = 'pudding'
    order by meal_ts
;


/* Senior managers */
drop view if exists senior_managers;
create view senior_managers as
    with recursive staff as (
            select
                person_id as snr_manager_id,
                person_id as staff_id
            from crew
            where person_seniority = 'senior manager'
        union all
            select
                staff.snr_manager_id,
                crew.person_id
            from staff
                inner join crew
                    on staff.staff_id = crew.manager_id
    )

    select
        staff_id,
        snr_manager_id
    from staff
    order by staff_id
;


/* Pudding offenders, as per problem statement */
select
    meal_ts,
    staff_id,
    snr_manager_id,
    count(*) over (partition by staff_id) as staff_count,
    count(*) over (partition by snr_manager_id) as manager_count
from pudding_helpings
    inner join senior_managers
        using (staff_id)
where 1=1
    /* None left after their second helping */
    and pudding_helpings.puddings_left = 0
    and pudding_helpings.staff_pudding_helping = 2
order by pudding_helpings.meal_ts
;


/* Pudding offenders, including more than 2 helpings */
select
    meal_ts,
    staff_id,
    snr_manager_id,
    count(*) over (partition by staff_id) as staff_count,
    count(*) over (partition by snr_manager_id) as manager_count
from pudding_helpings
    inner join senior_managers
        using (staff_id)
where 1=1
    /* None left after their second _or more_ helping */
    and pudding_helpings.puddings_left = 0
    and pudding_helpings.staff_pudding_helping >= 2
order by pudding_helpings.meal_ts
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Puddings taken and left per day (for validation) */
with pudding_taken as (
    select
        date(food_taken.timestamp) as meal_date,
        count(*) as puddings_taken
    from food_taken
        inner join food
            using (meal, food_id)
    where food.food = 'pudding'
    group by date(food_taken.timestamp)
)

select
    pudding_taken.meal_date,
    pudding_taken.puddings_taken,
    food_left.number_left
from pudding_taken
    inner join food_left
        on  pudding_taken.meal_date = food_left.date
        and food_left.food = 'pudding'
order by pudding_taken.meal_date
;
