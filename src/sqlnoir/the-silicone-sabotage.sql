
/* Incident report */
select *
from incident_reports
where location like '%QuantumTech%'
;


/* Witness statements */
select *
from witness_statements
where statement like '%server%'
;


/* Computer access logs (Helsinki) */
select *
from computer_access_logs
where server_location = 'Helsinki'
;


/* Employees in all access logs (computer access in Helsinki) */
select
    employee_id,
    access_date,
    computer_access_logs.server_location,
    computer_access_logs.access_time as server_access_time,
    keycard_access_logs.keycard_code,
    keycard_access_logs.access_time as keycard_access_time,
    facility_access_logs.facility_name,
    facility_access_logs.access_time as facility_access_time
from computer_access_logs
    inner join keycard_access_logs
        using (employee_id, access_date)
    inner join facility_access_logs
        using (employee_id, access_date)
where computer_access_logs.server_location = 'Helsinki'
order by
    server_access_time,
    keycard_access_time,
    facility_access_time
;


/* Email logs (employee 99) */
select *
from email_logs
where 0=1
    or sender_employee_id = 99
    or recipient_employee_id = 99
order by id
;


/* Email logs (employee 263) */
select *
from email_logs
where 0=1
    or sender_employee_id = 263
    or recipient_employee_id = 263
order by id
;


/* Facility access logs around (F18, 19890421 09:00) */
select *
from facility_access_logs
where 1=1
    and access_date = 19890421
    and facility_name = 'Facility 18'
order by access_time
;


/* Employee records (employee 297) */
select *
from employee_records
where id = 297
;
