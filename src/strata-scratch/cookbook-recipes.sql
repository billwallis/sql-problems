/* https://platform.stratascratch.com/coding/2089-cookbook-recipes */

/* Sample data */
create table cookbook_titles (
    page_number int,
    title text

);
insert into cookbook_titles
values
    (1, 'Scrambled eggs'),
    (2, 'Fondue'),
    (3, 'Sandwich')
;


/* Solution */
with axis(n) as (
    select 2 * n
    from generate_series(
        0,
        (select max(page_number) / 2 from cookbook_titles)
    ) as gs(n)
)

select
    n as left_page_number,
    left_titles.title as left_title,
    right_titles.title as right_title
from axis
    left join cookbook_titles as left_titles
        on axis.n = left_titles.page_number
    left join cookbook_titles as right_titles
        on axis.n + 1 = right_titles.page_number
;
