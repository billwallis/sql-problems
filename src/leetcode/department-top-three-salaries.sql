/* https://leetcode.com/problems/department-top-three-salaries/ */
use leetcode;

/* Sample input */
create table employee (
    id           int,
    name         varchar(50),
    salary       int,
    departmentId int
);
truncate table employee;
insert into employee
values
    (1, 'Joe',   85000, 1),
    (2, 'Henry', 80000, 2),
    (3, 'Sam',   60000, 2),
    (4, 'Max',   90000, 1),
    (5, 'Janet', 69000, 1),
    (6, 'Randy', 85000, 1),
    (7, 'Will',  70000, 1)
;

create table department (
    id   int,
    name varchar(50)
);
truncate table department;
insert into department
values
    (1, 'IT'),
    (2, 'Sales')
;

/* Sample output */
select *
from (values
    row('IT',    'Max',   90000),
    row('IT',    'Joe',   85000),
    row('IT',    'Randy', 85000),
    row('IT',    'Will',  70000),
    row('Sales', 'Henry', 80000),
    row('Sales', 'Sam',   60000)
) as v(Department, Employee, Salary)
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select
    Department,
    Employee,
    Salary
from (
    select
        department.name as Department,
        employee.name as Employee,
        employee.salary as Salary,
        dense_rank() over (
            partition by employee.departmentId
            order by employee.salary desc
        ) as salary_rank
    from employee
        inner join department
            on employee.departmentId = department.id
) as ranked
where salary_rank <= 3
;
