use day_04;

/* Official shifts */
from official_shifts;

/* Last-minute signups */
from last_minute_signups;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with

roles(task, role) as (
    values
        ('stage_setup',        'Stage Setup'),
        ('cocoa_station',      'Cocoa Station'),
        ('hot_cocoa_station',  'Cocoa Station'),
        ('parking',            'Parking Support'),
        ('parking_support',    'Parking Support'),
        ('choir',              'Choir Assistant'),
        ('choir_assistant',    'Choir Assistant'),
        ('shovel',             'Snow Shoveling'),
        ('snow_shoveling',     'Snow Shoveling'),
        ('handwarmers',        'Handwarmer Handout'),
        ('handwarmer_handout', 'Handwarmer Handout'),
),
shifts(slot, shift_time) as (
    values
        ('10am',     '10:00 AM'),
        ('10:00 AM', '10:00 AM'),
        ('2pm',      '2:00 PM'),
        ('2:00 PM',  '2:00 PM'),
        ('noon',     '12:00 PM'),
        ('12:00 PM', '12:00 PM'),
),

signups as (
    select
        volunteer_name,
        lower(assigned_task).regexp_replace('[^A-Za-z]+', '_', 'g') as task,
        time_slot.lower().replace(' ', '') as slot,
    from last_minute_signups
),

volunteers(volunteer_name, slot, task) as (
        select volunteer_name, shift_time,  role
        from official_shifts
    union all
        select volunteer_name, slot, task,
        from signups
)

select
    volunteers.volunteer_name,
    shifts.shift_time,
    string_agg(distinct roles.role, ', ') as role,
from volunteers
    left join shifts
        using (slot)
    left join roles
        using (task)
group by
    volunteers.volunteer_name,
    shifts.shift_time
order by
    volunteers.volunteer_name,
    shifts.shift_time
;
