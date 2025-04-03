/* https://github.com/clrcrl/advanced-sql?tab=readme-ov-file#apportioning-payments */

/* payments */
from payments;

/* inbound_payment_states */
from inbound_payment_states;


/* Solution */
with

payment_amounts as (
    select
        payments.*,
        totals.payout_amount::int as total_payout_amount,
        totals.refund_amount::int as total_refund_amount,
    from payments
        left join (
            select
                task_id,
                sum(amount) filter (where payment_type = 'payout'),
                sum(amount) filter (where payment_type = 'refund'),
            from payments
            group by task_id
        ) as totals(task_id, payout_amount, refund_amount)
            using (task_id)
),

attribution as (
    select
        task_id,
        payment_id as inbound_payment_id,
        amount as inbound_amount,

        total_payout_amount - sum(amount) over (
            partition by task_id
            order by payment_id
        ) as remaining_payout_amount,
        total_refund_amount - sum(amount) over (
            partition by task_id
            order by payment_id desc
        ) as remaining_refund_amount,

        /*
            If `remaining_X_amount` is null then there is nothing to
            attribute, so set 0.

            Otherwise, if `remaining_X_amount` is non-negative then the
            current row's entire inbound amount is covered by the payout/
            refund, so set the current row's inbound amount.

            Otherwise, the `remaining_X_amount` is negative so the current
            row's inbound amount is either partially covered or not covered
            at all:

            - The inbound amount is partially covered when:

                  abs(remaining_X_amount) < inbound_amount

              ...in which case, the covered amount is the difference between
              the inbound amount and the remaining amount.

            - Otherwise, `abs(remaining_X_amount) > inbound_amount` and the
              inbound amount is not covered at all.

            These cases can be simplified to:

                greatest(inbound_amount + remaining_X_amount, 0)
        */
        case
            when remaining_payout_amount is null
                then 0
            when remaining_payout_amount >= 0
                then inbound_amount
                else greatest(inbound_amount + remaining_payout_amount, 0)
        end as payout_amount,
        case
            when remaining_refund_amount is null
                then 0
            when remaining_refund_amount >= 0
                then inbound_amount
                else greatest(inbound_amount + remaining_refund_amount, 0)
        end as refund_amount,

    from payment_amounts
    where payment_type = 'inbound'
)

select
    task_id,
    inbound_payment_id,
    inbound_amount,
    payout_amount::int as payout_amount,
    refund_amount::int as refund_amount,
from attribution
order by inbound_payment_id
;
