use santa_workshop;

/* children */
select * from children;

/* wish_lists */
select * from wish_lists;

/* toy_catalogue */
select * from toy_catalogue;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with

gift_complexity(difficulty_to_make, gift_complexity) as (
    values
        (1, 'Simple Gift'),
        (2, 'Moderate Gift'),
        (3, 'Complex Gift'),
),

workshops(category, workshop_assignment) as (
    values
        ('outdoor', 'Outside Workshop'),
        ('educational', 'Learning Workshop'),
        ('all other types', 'General Workshop'),
),

wishes as (
    select
        child_id,
        wishes->>'first_choice' as primary_wish,
        wishes->>'second_choice' as backup_wish,
        wishes->'colors'->>0 as favorite_color,
        len((wishes->'colors')::varchar[]) as color_count,
    from wish_lists
    -- qualify 1 = row_number() over (partition by child_id order by submitted_date desc)
),

child_wishes as (
    select
        child_id,
        children.name,
        wishes.primary_wish,
        wishes.backup_wish,
        wishes.favorite_color,
        wishes.color_count,
        toy_catalogue.category,
        toy_catalogue.difficulty_to_make,
    from children
        inner join wishes
            using (child_id)
        left join toy_catalogue
            on wishes.primary_wish = toy_catalogue.toy_name
),

solution as (
    select
        child_wishes.child_id,
        child_wishes.name,
        child_wishes.primary_wish,
        child_wishes.backup_wish,
        child_wishes.favorite_color,
        child_wishes.color_count,
        child_wishes.difficulty_to_make,
        gift_complexity.gift_complexity,
        child_wishes.category,
        coalesce(workshops.workshop_assignment, 'General Workshop') as workshop_assignment,
    from child_wishes
        asof left join gift_complexity
            using (difficulty_to_make)
        left join workshops
            using (category)
)

select
    *,
    format(
        '{:s},{:s},{:s},{:s},{:d},{:s},{:s}',
        name,
        primary_wish,
        backup_wish,
        favorite_color,
        color_count,
        gift_complexity,
        workshop_assignment
    ) as solution_line
from solution
order by name
limit 10
;
