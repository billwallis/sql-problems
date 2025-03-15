/* https://platform.stratascratch.com/coding/2029-the-most-popular-client_id-among-users-using-video-and-voice-calls */

/* Sample data */
create table fact_events (
    id int,
    time_id date,
    user_id text,
    customer_id text,
    client_id text,
    event_type text,
    event_id int

);
insert into fact_events
values
    (1, '2020-02-28', '3668-QPYBK', 'Sendit',    'desktop', 'message sent',        3),
    (2, '2020-02-28', '7892-POOKP', 'Connectix', 'mobile',  'file received',       2),
    (3, '2020-04-03', '9763-GRSKD', 'Zoomit',    'desktop', 'video call received', 7),
    (4, '2020-04-02', '9763-GRSKD', 'Connectix', 'desktop', 'video call received', 7),
    (5, '2020-02-06', '9237-HQITU', 'Sendit',    'desktop', 'video call received', 7)
;


/* Solution */
select client_id
from fact_events
group by client_id, user_id
having 100.0 * count(*) filter (
    where event_type in (
        'video call received',
        'video call sent',
        'voice call received',
        'voice call sent'
    )
) / count(*) > 50
order by count(*) over (partition by client_id) desc
limit 1
;
