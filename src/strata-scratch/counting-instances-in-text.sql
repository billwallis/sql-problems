/* https://platform.stratascratch.com/coding/9814-counting-instances-in-text */

/* Sample data */
create table google_file_store (
    filename text,
    contents text
);
insert into google_file_store
values
    ('draft1.txt', 'The stock exchange predicts a bull market which would make many investors happy.'),
    ('trades.log', 'b be bea bear bears b bu bul bull bulls')
;


/* Solution */
select
    unnest(regexp_matches(contents, '\y(bear|bull)\y', 'g')) as word,
    count(*)
from google_file_store
group by word
;

/*
    Uhm, why is this in the "hard" section?!
*/
