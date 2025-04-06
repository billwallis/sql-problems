with

/* Data */
batch_starts(batch, batch_start) as (
    values
        ('A', 1),
        ('A', 5),
),
batch_lines(batch, line, syntax) as (
    values
        ('A', 1, 'SELECT *'),
        ('A', 2, 'FROM Account;'),
        ('A', 3, 'GO'),
        ('A', 4, ''),
        ('A', 5, 'TRUNCATE TABLE Accounts;'),
        ('A', 6, 'GO'),
)

/* Solution */
select
    batch_starts.batch,
    batch_starts.batch_start,
    batch_lines.line as batch_end,
from batch_starts
    asof left join batch_lines
        on  batch_starts.batch = batch_lines.batch
        and batch_lines.syntax = 'GO'
        and batch_starts.batch_start <= batch_lines.line
order by
    batch_starts.batch,
    batch_starts.batch_start
;
