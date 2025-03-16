/* https://www.namastesql.com/coding-problem/125-project-budget */

/* Sample data */
create table employees (
    id     int,
    name   varchar,
    salary int
);
insert into employees
values
    (1, 'Alice',   100000),
    (2, 'Bob',     120000),
    (3, 'Charlie', 90000),
    (4, 'David',   110000)
;

create table projects (
    id         int,
    title      varchar,
    start_date date,
    end_date   date,
    budget     int
);
insert into projects
values
    (1, 'Website Redesign', '2024-01-15', '2024-07-15',  50000),
    (2, 'App Development',  '2024-02-01', '2024-05-31', 100000)
;

create table project_employees (
    project_id  int,
    employee_id int
);
insert into project_employees
values
    (1, 1),
    (2, 2),
    (2, 3),
    (2, 4)
;


/* Solution */
with project_cost as (
    select
        projects.title,
        projects.budget,
        projects.end_date - projects.start_date as duration_days,
        (
            select sum(employees.salary)
            from employees
                inner join project_employees
                    on employees.id = project_employees.employee_id
            where projects.id = project_employees.project_id
        ) as yearly_cost
    from projects
)

select
    title,
    budget,
    case when budget > (yearly_cost * duration_days / 365.0)
        then 'within budget'
        else 'overbudget'
    end as label
from project_cost
order by title
;
