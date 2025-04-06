with

/* Data */
cart_1(item) as (values ('Sugar'), ('Bread'), ('Juice'), ('Soda'), ('Flour')),
cart_2(item) as (values ('Sugar'), ('Bread'), ('Butter'), ('Cheese'), ('Fruit'))

/* Solution */
select
    cart_1.item as item_cart_1,
    cart_2.item as item_cart_2,
from cart_1
    full join cart_2
        using (item)
;
