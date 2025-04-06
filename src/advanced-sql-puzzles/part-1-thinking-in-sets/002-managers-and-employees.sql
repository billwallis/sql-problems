with recursive

/* Data */
employees(employee_id, manager_id, job_title) as (
    values
        (1001, null, 'President'),
        (2002, 1001, 'Director'),
        (3003, 1001, 'Office Manager'),
        (4004, 2002, 'Engineer'),
        (5005, 2002, 'Engineer'),
        (6006, 2002, 'Engineer'),
),

/* Solution */
hierarchy as (
        select
            employee_id,
            manager_id,
            job_title,
            0 as depth,
        from employees
        where manager_id is null
    union all
        select
            employees.employee_id,
            employees.manager_id,
            employees.job_title,
            hierarchy.depth + 1,
        from employees
            inner join hierarchy
                on employees.manager_id = hierarchy.employee_id
)

from hierarchy
;
