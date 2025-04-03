/* https://github.com/clrcrl/advanced-sql?tab=readme-ov-file#subscription-price-changes */

/* subscription_price_changes */
from subscription_price_changes;

/* rebillings */
from rebillings;

/* effective_subscription_changes */
from effective_subscription_changes;


/* Solution */
select
    rebillings.subscription_id,
    changes.price as new_price,
    changes.changed_at as changed_at,
    rebillings.rebilled_at as effective_at,
from rebillings
    asof inner join subscription_price_changes as changes
        on  rebillings.subscription_id = changes.subscription_id
        and rebillings.rebilled_at > changes.changed_at
where changes.changed_at >= rebillings.rebilled_at - interval '1 month'
order by rebillings.rebilling_id
;
