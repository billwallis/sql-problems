use day_12;

/* Archive records */
from archive_records;


------------------------------------------------------------------------
------------------------------------------------------------------------

/*
    The requirement "most relevant archived records" is ambiguous, what does
    it mean to be more relevant?!

    Also, the author's `limit 5` picks some rows non-deterministically since
    many records have the same search rank. They should handle same-score
    results deterministically.
*/

/* Solution (naive) */
from (
    select
        *,
        title ilike '%fly%' or title ilike '%flight%' as in_title,
        description ilike '%fly%' or description ilike '%flight%' as in_description,
    from archive_records
)
where in_title or in_description
order by
    case
        when in_title and in_description
            then 0
        when in_title
            then 1
        when in_description
            then 2
    end,
    id desc  /* Just for determinism */
limit 5
;

/* Solution (full text search) */
pragma create_fts_index(
    'day_12.archive_records',
    'id',
    'title',
    'description',
    overwrite=1
);
from (
    from (
        select
            *,
            fts_day_12_archive_records.match_bm25(
                id,
                'fly',
                fields := 'title'
            ) AS score_title_fly,
            fts_day_12_archive_records.match_bm25(
                id,
                'flight',
                fields := 'title'
            ) AS score_title_flight,
            fts_day_12_archive_records.match_bm25(
                id,
                'fly',
                fields := 'description'
            ) AS score_desc_fly,
            fts_day_12_archive_records.match_bm25(
                id,
                'flight',
                fields := 'description'
            ) AS score_desc_flight,
        from archive_records
    )
    select
        *,
        (0
            + coalesce(score_title_fly, 0)
            + coalesce(score_title_flight, 0)
        ) as score_title,
        (0
            + coalesce(score_desc_fly, 0)
            + coalesce(score_desc_flight, 0)
        ) as score_desc,
        score_title + score_desc as total_score,
    where total_score > 0
)
select
    id,
    title,
    description,
    total_score
order by
    case
        when score_title > 0 and score_desc > 0
            then 0
        when score_title > 0
            then 1
        when score_desc > 0
            then 2
    end,
    total_score desc
limit 5
;
