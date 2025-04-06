with recursive

/* Data */
orders(customer_id, order_id, delivery_state, amount) as (
    values
        (1001, 1, 'CA', 340),
        (1001, 2, 'TX', 950),
        (1001, 3, 'TX', 670),
        (1001, 4, 'TX', 860),
        (2002, 5, 'WA', 320),
        (3003, 6, 'CA', 650),
        (3003, 7, 'CA', 830),
        (4004, 8, 'TX', 120),
)

/* Solution */
from orders as tx
    semi join orders as ca
        on  tx.customer_id = ca.customer_id
        and ca.delivery_state = 'CA'
where tx.delivery_state = 'TX'
;
