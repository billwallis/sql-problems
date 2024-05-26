/* https://sqlshortreads.com/sql-practice-problems/hard/ */


/* Sample output */
with sample(
    "Member ID",
    "Member Type ID",
    "Member Type",
    "Annual Member Cost",
    "Member Discount",
    "Purchase Count",
    "Amount Spent",
    "Amount Saved",
    "Next-tier Member Type",
    "Next-tier Annual Member Cost",
    "Next-tier Member Discount",
    "Next-tier Amount Saved",
    "Increased Savings Amount"
) as (
              select '1', '1', 'Free', '0', '0', '2', '17', '0', 'Bronze', '15', '.03', '.51', '.51' from dual
    union all select '10', '1', 'Free', '0', '0', '2', '19', '0', 'Bronze', '15', '.03', '.57', '.57' from dual
    union all select '25', '1', 'Free', '0', '0', '3', '25.5', '0', 'Bronze', '15', '.03', '.77', '.77' from dual
    union all select '35', '1', 'Free', '0', '0', '2', '9', '0', 'Bronze', '15', '.03', '.27', '.27' from dual
    union all select '48', '1', 'Free', '0', '0', '2', '35', '0', 'Bronze', '15', '.03', '1.05', '1.05' from dual
    union all select '51', '1', 'Free', '0', '0', '1', '17.5', '0', 'Bronze', '15', '.03', '.53', '.53' from dual
    union all select '54', '1', 'Free', '0', '0', '1', '14', '0', 'Bronze', '15', '.03', '.42', '.42' from dual
    union all select '57', '1', 'Free', '0', '0', '2', '27', '0', 'Bronze', '15', '.03', '.81', '.81' from dual
    union all select '61', '1', 'Free', '0', '0', '3', '38.5', '0', 'Bronze', '15', '.03', '1.16', '1.16' from dual
    union all select '63', '1', 'Free', '0', '0', '3', '30', '0', 'Bronze', '15', '.03', '.9', '.9' from dual
)

select *
from sample
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
I like this question, but I don't like adding "report friendly" names in
the SQL -- this is, in my experience, better done in the reporting tool
itself.

Like in a previous problem, the recommended solution joins before
aggregating which is typically worse for performance.
*/


/* Solution */
with

purchases as (
    select
        member_id,
        count(purchase_total) as purchase_volume,
        sum(purchase_total) as purchase_value
    from purchase
    group by member_id
),

membership as (
    select
        member_id,

        purchases.purchase_volume,
        purchases.purchase_value,

        member_type.member_type_id,
        member_type.description,
        member_type.discount,
        member_type.annual_cost,
        purchase_value * member_type.discount / (1 - member_type.discount) as amount_saved,

        next_member_type.description as next_description,
        next_member_type.discount as next_discount,
        next_member_type.annual_cost as next_annual_cost,
        purchase_value * next_member_type.discount / (1 - member_type.discount) as next_amount_saved
    from purchases
        inner join member using (member_id)
        inner join member_type
            on member.member_type_id = member_type.member_type_id
        /* This filters out the platinum customers */
        inner join member_type next_member_type
            on 1 + member_type.member_type_id = next_member_type.member_type_id
)

select
    member_id as "Member ID",
    member_type_id as "Member Type ID",
    description as "Member Type",
    annual_cost as "Annual Member Cost",
    discount as "Member Discount",
    purchase_volume as "Purchase Count",
    purchase_value as "Amount Spent",
    round(amount_saved, 2) as "Amount Saved",
    next_description as "Next-tier Member Type",
    next_annual_cost as "Next-tier Annual Member Cost",
    next_discount as "Next-tier Member Discount",
    round(next_amount_saved, 2) as "Next-tier Amount Saved",
    round(next_amount_saved, 2) - round(amount_saved, 2) as "Increased Savings Amount"
from membership
order by
    "Member Type ID",
    "Member ID"
;
