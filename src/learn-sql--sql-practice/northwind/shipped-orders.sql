/* https://www.sql-practice.com/ */

/*
    This also needs to be sorted by the calculated `shipped` column.
*/
/* Solution */
with employee_orders as (
    select
        employee_id,
        case
            when shipped_date is null
                then 'Not Shipped'
            when shipped_date <= required_date
                then 'On Time'
            when shipped_date > required_date
                then 'Late'
        end as shipped,
        count(*) as num_orders
    from orders
    group by employee_id, shipped
)

select
    employees.first_name,
    employees.last_name,
    employee_orders.num_orders,
    employee_orders.shipped
from employee_orders
    inner join employees
        using (employee_id)
order by
    employees.last_name,
    employees.first_name,
    employee_orders.num_orders desc,
    employee_orders.shipped desc
;
