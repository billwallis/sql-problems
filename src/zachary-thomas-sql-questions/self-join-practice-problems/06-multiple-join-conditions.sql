/* https://quip.com/2gwZArKuWk7W */

/* Sample data */
create or replace table emails (
    id int,
    subject text,
    "from" text,
    "to" text,
    "timestamp" timestamp,
);
insert into emails
values
    (1, 'Yosemite', 'zach@g.com',   'thomas@g.com', '2018-01-02 12:45:03'),
    (2, 'Big Sur',  'sarah@g.com',  'thomas@g.com', '2018-01-02 16:30:01'),
    (3, 'Yosemite', 'thomas@g.com', 'zach@g.com',   '2018-01-02 16:35:04'),
    (4, 'Running',  'jill@g.com',   'zach@g.com',   '2018-01-03 08:12:45'),
    (5, 'Yosemite', 'zach@g.com',   'thomas@g.com', '2018-01-03 14:02:01'),
    (6, 'Yosemite', 'thomas@g.com', 'zach@g.com',   '2018-01-03 15:01:05'),
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
    Please don't use keywords like FROM, TO, TIMESTAMP as object names :(
*/

/* Solution */
select
    zach_emails.id,
    reply_email.timestamp - zach_emails.timestamp as response_time,
from emails as zach_emails
    asof inner join emails as reply_email
        on  zach_emails.subject = reply_email.subject
        and zach_emails.timestamp < reply_email.timestamp
where zach_emails.to = 'zach@g.com'
;
