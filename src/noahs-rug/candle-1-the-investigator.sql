/* Solution */
with recursive

letters(letter, numbers) as (
    values
        ('a', '2'), ('b', '2'), ('c', '2'),
        ('d', '3'), ('e', '3'), ('f', '3'),
        ('g', '4'), ('h', '4'), ('i', '4'),
        ('j', '5'), ('k', '5'), ('l', '5'),
        ('m', '6'), ('n', '6'), ('o', '6'),
        ('p', '7'), ('q', '7'), ('r', '7'), ('s', '7'),
        ('t', '8'), ('u', '8'), ('v', '8'),
        ('w', '9'), ('x', '9'), ('y', '9'), ('z', '9'),
),

names as (
    from (
        from customers
        select
            customerid,
            phone,
            unnest(name.lower().split(' ')[2:]) as name,
    )
    select
        customerid,
        phone,
        generate_subscripts(name.split(''), 1) as i,
        unnest(name.split('')) as letter,
),

deconstruct as (
    select
        names.customerid,
        any_value(names.phone) as phone,
        string_agg(letters.numbers, '' order by names.i) as number,
    from names
        inner join letters
            using (letter)
    group by names.customerid,
)

select phone, customerid
from deconstruct
where phone.replace('-', '') = number
;
