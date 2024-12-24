/*
    https://adventofsql.com/challenges/20
    https://adventofsql.com/challenges/20/data
*/
drop schema if exists day_20 cascade;
create schema day_20;
use day_20;


/* Create tables */
create sequence day_20.web_requests__pk start 1;
create table day_20.web_requests (
    request_id int primary key default nextval('day_20.web_requests__pk'),
    url text not null
);


/* Sample data */
insert into day_20.web_requests (url)
values
    ('http://example.com/page?param1=value1¶m2=value2'),
    ('https://shop.example.com/items?item=toy&color=red&size=small&ref=google&utm_source=advent-of-sql'),
    ('http://news.example.org/article?id=123&source=rss&author=jdoe&utm_source=advent-of-sql'),
    ('https://travel.example.net/booking?dest=paris&date=2024-12-19&class=business'),
    ('http://music.example.com/playlist?genre=pop&duration=long&listener=guest&utm_source=advent-of-sql')
;
