/*
https://sqlshortreads.com/sql-practice-problems/

The tables below are taken from the link above; these are the tables
used in these exercises.
*/

EXEC DBMS_RANDOM.SEED(42);

CREATE TABLE north_america_sale AS
    WITH north_america_sale (report_date, product_category, total_sale) AS (
        SELECT
            daily_sale.report_date,
            data_template.product_category,
            daily_sale.total_sale
        FROM (
            SELECT
               'Software' AS category_1,
               'Hardware' AS category_2,
               'Office Supplies' AS category_3
            FROM
                dual
        )
        UNPIVOT (
            product_category FOR category_column IN (
                "CATEGORY_1", "CATEGORY_2", "CATEGORY_3"
            )
        ) data_template
        CROSS JOIN (
        SELECT
            TO_DATE('2023-01-01', 'YYYY-MM-DD') AS report_date,
            FLOOR(DBMS_RANDOM.VALUE(100000, 500000)) AS total_sale
        FROM
            dual
        ) daily_sale
        UNION ALL
        SELECT
            north_america_sale.report_date + INTERVAL '1' DAY,
            north_america_sale.product_category,
            FLOOR(DBMS_RANDOM.VALUE(100000, 500000))
        FROM
            north_america_sale
        WHERE
            north_america_sale.report_date < TO_DATE('2023-12-31', 'YYYY-MM-DD')
    )
    SELECT
        north_america_sale.report_date,
        north_america_sale.product_category,
        north_america_sale.total_sale
    FROM
        north_america_sale
;


CREATE TABLE europe_sale AS
    WITH europe_sale (report_date, product_category, total_sale) AS (
        SELECT
            daily_sale.report_date,
            data_template.product_category,
            daily_sale.total_sale
        FROM (
            SELECT
               'Software' AS category_1,
               'Hardware' AS category_2,
               'Office Supplies' AS category_3
            FROM
                dual
        )
        UNPIVOT (
            product_category FOR category_column IN (
                "CATEGORY_1", "CATEGORY_2", "CATEGORY_3"
            )
        ) data_template
        CROSS JOIN (
        SELECT
            TO_DATE('2023-01-01', 'YYYY-MM-DD') AS report_date,
            FLOOR(DBMS_RANDOM.VALUE(100000, 500000)) AS total_sale
        FROM
            dual
        ) daily_sale
        UNION ALL
        SELECT
            europe_sale.report_date + INTERVAL '1' DAY,
            europe_sale.product_category,
            FLOOR(DBMS_RANDOM.VALUE(100000, 500000))
        FROM
            europe_sale
        WHERE
            europe_sale.report_date < TO_DATE('2023-12-31', 'YYYY-MM-DD')
    )
    SELECT
        europe_sale.report_date,
        europe_sale.product_category,
        europe_sale.total_sale
    FROM
        europe_sale
;
