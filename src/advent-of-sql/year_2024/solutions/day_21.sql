use day_21;

/* sales */
from sales;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
select
    extract('year' from sale_date) as year_,
    extract('quarter' from sale_date) as quarter_,
from sales
group by year_, quarter_
order by sum(amount) / lag(sum(amount)) over (order by year_, quarter_) desc
limit 1
;
