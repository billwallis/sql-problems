-- password: 5777


/* DuckDB on the extracted CSVs */
create or replace table customers as
    from 'src/noahs-rug/data/standard/noahs-customers.csv'
;
create or replace table orders as
    from 'src/noahs-rug/data/standard/noahs-orders.csv'
;
create or replace table orders_items as
    from 'src/noahs-rug/data/standard/noahs-orders_items.csv'
;
create or replace table products as
    from 'src/noahs-rug/data/standard/noahs-products.csv'
;

/* speedrun */
create or replace table customers as
    from 'src/noahs-rug/data/speedrun/noahs-customers.csv'
;
create or replace table orders as
    from 'src/noahs-rug/data/speedrun/noahs-orders.csv'
;
create or replace table orders_items as
    from 'src/noahs-rug/data/speedrun/noahs-orders_items.csv'
;
create or replace table products as
    from 'src/noahs-rug/data/speedrun/noahs-products.csv'
;
