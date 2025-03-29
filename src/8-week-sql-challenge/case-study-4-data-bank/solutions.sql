/*
    https://8weeksqlchallenge.com/case-study-4/
*/
use data_bank;

/*
    A. Customer Nodes Exploration

    1.  How many unique nodes are there on the Data Bank system?
    2.  What is the number of nodes per region?
    3.  How many customers are allocated to each region?
    4.  How many days on average are customers reallocated to a different
        node?
    5.  What is the median, 80th and 95th percentile for this same
        reallocation days metric for each region?
*/

/* 1 */
select count(distinct node_id) as distinct_nodes
from customer_nodes
;

/* 2 */
select
    regions.region_name,
    count(*) as nodes,
from regions
    inner join customer_nodes
        using (region_id)
group by regions.region_name
order by regions.region_name
;

/* 3 */
select
    regions.region_name,
    count(distinct customer_id) as customers,
from regions
    inner join customer_nodes
        using (region_id)
group by regions.region_name
order by regions.region_name
;

/* 4 - not sure I'm understanding this one correctly */
select avg(end_date - start_date) as avg_days
from customer_nodes
where end_date != '9999-12-31'
;

/* 5 - not sure I'm understanding this one correctly */
from (
    select
        regions.region_name,
        customer_nodes.end_date - customer_nodes.start_date as day_diff
    from regions
        inner join customer_nodes
            using (region_id)
    where customer_nodes.end_date != '9999-12-31'
)
select
    region_name,
    percentile_cont(0.50) within group (order by day_diff) as percentile_median,
    percentile_cont(0.80) within group (order by day_diff) as percentile_80th,
    percentile_cont(0.95) within group (order by day_diff) as percentile_95th,
group by region_name
order by region_name
;


/*
    B. Customer Transactions

    1.  What is the unique count and total amount for each transaction type?
    2.  What is the average total historical deposit counts and amounts for
        all customers?
    3.  For each month - how many Data Bank customers make more than 1
        deposit and either 1 purchase or 1 withdrawal in a single month?
    4.  What is the closing balance for each customer at the end of the month?
    5.  What is the percentage of customers who increase their closing
        balance by more than 5%?
*/

/* 1 */
select
    txn_type,
    count(*) as unique_count,
    sum(txn_amount) as total_amount,
from customer_transactions
group by txn_type
order by txn_type
;

/* 2 - don't totally understand this one */
select
    count(*) as total_deposits,
    avg(txn_amount) as avg_amount,
from customer_transactions
where txn_type = 'deposit'
;

/* 3 */
from (
    select
        date_trunc('month', txn_date) as txn_month,
        customer_id,
    from customer_transactions
    group by txn_month, customer_id
    having 1=1
        and 2 <= count(*) filter (where txn_type = 'deposit')
        and 1 <= count(*) filter (where txn_type in ('purchase', 'withdrawal'))
)
select txn_month, count(*) as customers
group by txn_month
order by txn_month
;

/* 4 - which month? I'll do all of them */
with

months as (
    select
        strftime(n, '%Y-%m') as txn_month,
        (n + interval '1 month -1 day')::date as month_end,
    from generate_series(
        (select date_trunc('month', min(txn_date)) from customer_transactions),
        (select date_trunc('month', max(txn_date)) from customer_transactions),
        interval '1 month'
    ) as gs(n)
),

balances as (
    from (
        select
            customer_id,
            txn_date,
            if(txn_type = 'deposit', txn_amount, -txn_amount) as txn_amount,
        from customer_transactions
    )
    select
        customer_id,
        txn_date as balance_date,
        sum(txn_amount) over (
            partition by customer_id
            order by txn_date
        ) as balance,
)

select
    customers.customer_id,
    months.txn_month,
    balances.balance,
from months
    cross join (
        select distinct customer_id
        from customer_transactions
    ) as customers
    asof left join balances
        on  customers.customer_id = balances.customer_id
        and months.month_end >= balances.balance_date
order by
    customers.customer_id,
    months.txn_month
;

/* 5 -- gonna assume they mean the latest month vs the previous month */
with

months as (
    from (
            select date_trunc('month', max(txn_date)) as dt
            from customer_transactions
        union all
            select date_trunc('month', max(txn_date)) - interval '1 month'
            from customer_transactions
    )
    select
        strftime(dt, '%Y-%m') as txn_month,
        (dt + interval '1 month -1 day')::date as month_end,
),

balances as (
    from (
        select
            customer_id,
            txn_date,
            if(txn_type = 'deposit', txn_amount, -txn_amount) as txn_amount,
        from customer_transactions
    )
    select
        customer_id,
        txn_date as balance_date,
        sum(txn_amount) over (
            partition by customer_id
            order by txn_date
        ) as balance,
),

month_end_balances as (
    select
        customers.customer_id,
        months.txn_month,
        balances.balance,
        lag(balances.balance) over (
            partition by customers.customer_id
            order by months.txn_month
        ) as prev_balance,
        (1=1
            and balances.balance > prev_balance
            and 0.05 <= 1 - (prev_balance / balances.balance)
        ) as increased_by_5plus_pct,
    from months
        cross join (
            select distinct customer_id
            from customer_transactions
        ) as customers
        asof left join balances
            on  customers.customer_id = balances.customer_id
            and months.month_end >= balances.balance_date
    qualify 1 = row_number() over (
        partition by customers.customer_id
        order by months.txn_month desc
    )
)

select
    (
        100
        * count(*) filter (where increased_by_5plus_pct)
        / count(*)
    )::numeric(8, 4) as increased_by_5plus_pct
from month_end_balances
;


/*
    C. Data Allocation Challenge

    To test out a few different hypotheses - the Data Bank team wants to run
    an experiment where different groups of customers would be allocated
    data using 3 different options:

    - Option 1: data is allocated based off the amount of money at the end
      of the previous month
    - Option 2: data is allocated on the average amount of money kept in the
      account in the previous 30 days
    - Option 3: data is updated real-time

    For this multi-part challenge question - you have been requested to
    generate the following data elements to help the Data Bank team estimate
    how much data will need to be provisioned for each option:

    - running customer balance column that includes the impact each transaction
    - customer balance at the end of each month
    - minimum, average and maximum values of the running balance for each customer

    Using all of the data available - how much data would have been required
    for each option on a monthly basis?
*/

-- cba, pretty much all done above


/*
    D. Extra Challenge

    Data Bank wants to try another option which is a bit more difficult to
    implement - they want to calculate data growth using an interest
    calculation, just like in a traditional savings account you might have
    with a bank.

    If the annual interest rate is set at 6% and the Data Bank team wants to
    reward its customers by increasing their data allocation based off the
    interest calculated on a daily basis at the end of each day, how much
    data would be required for this option on a monthly basis?

    Special notes:

    - Data Bank wants an initial calculation which does not allow for
      compounding interest, however they may also be interested in a daily
      compounding interest calculation so you can try to perform this
      calculation if you have the stamina!
*/

-- don't really understand the question, skipping


/*
    Extension Request

    The Data Bank team wants you to use the outputs generated from the above
    sections to create a quick Powerpoint presentation which will be used as
    marketing materials for both external investors who might want to buy
    Data Bank shares and new prospective customers who might want to bank
    with Data Bank.

    Using the outputs generated from the customer node questions, generate a
    few headline insights which Data Bank might use to market it’s
    world-leading security features to potential investors and customers.

    With the transaction analysis - prepare a 1 page presentation slide
    which contains all the relevant information about the various options
    for the data provisioning so the Data Bank management team can make an
    informed decision.
*/

-- not doing slides, no thanks
