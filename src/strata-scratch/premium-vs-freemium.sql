/* https://platform.stratascratch.com/coding/10300-premium-vs-freemium */

/* Sample data */
create table ms_user_dimension (
    user_id int,
    acc_id int
);
insert into ms_user_dimension
values
    (1, 700),
    (2, 701),
    (3, 702),
    (4, 703),
    (5, 704)
;

create table ms_acc_dimension (
    acc_id int,
    paying_customer text
);
insert into ms_acc_dimension
values
    (700, 'no'),
    (701, 'yes'),
    (702, 'no'),
    (703, 'no'),
    (704, 'no')
;

create table ms_download_facts (
    date date,
    user_id int,
    downloads int
);
insert into ms_download_facts
values
    ('2020-08-24', 1, 6),
    ('2020-08-22', 2, 6),
    ('2020-08-18', 3, 2),
    ('2020-08-24', 4, 4),
    ('2020-08-19', 5, 7)
;


/* Solution */
select
    fct.date,
    coalesce(sum(fct.downloads) filter (where acc.paying_customer = 'no'),  0) as non_paying_downloads,
    coalesce(sum(fct.downloads) filter (where acc.paying_customer = 'yes'), 0) as paying_downloads
from ms_download_facts as fct
    left join ms_user_dimension
        using (user_id)
    left join ms_acc_dimension as acc
        using (acc_id)
group by fct.date
having (
    coalesce(sum(fct.downloads) filter (where acc.paying_customer = 'no'), 0)
    > coalesce(sum(fct.downloads) filter (where acc.paying_customer = 'yes'), 0)
)
order by fct.date
;
