create or replace table employee_pay_record (
    employee_id integer not null,
    fiscal_year integer not null,
    start_date date not null,
    end_date date not null check (end_date >= start_date),
    pay_rate numeric(18, 3) not null check (pay_rate >= 0),
    primary key (employee_id, fiscal_year),
);

/*
    I missed the following checks:

    - the start date is on January 1st
    - the end date is on December 31st
    - the years of the start and end dates match the fiscal year

    ...because in the UK, the fiscal year runs from April 6th one year to
    April 5th of the following year, and I didn't want to make any
    assumptions about how fiscal years work in other countries in the DDL.

    I'd rather leave fiscal year business logic in the application layer.
*/
