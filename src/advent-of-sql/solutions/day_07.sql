use day_07;

/* workshop_elves */
from workshop_elves;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Solution */
with years_exp as (
    select
        *,
        years_experience = max(years_experience) over skills as senior_flag,
        years_experience = min(years_experience) over skills as junior_flag,
    from workshop_elves
    window skills as (partition by primary_skill)
)

select
    senior_elf.elf_id as elf_1_id,
    junior_elf.elf_id as elf_2_id,
    skills.primary_skill as shared_skill,
from (select distinct primary_skill from workshop_elves) as skills
    inner join years_exp as senior_elf
        on  skills.primary_skill = senior_elf.primary_skill
        and senior_elf.senior_flag
    inner join years_exp as junior_elf
        on  skills.primary_skill = junior_elf.primary_skill
        and junior_elf.junior_flag
qualify 1 = row_number() over (
    partition by skills.primary_skill
    order by senior_elf.elf_id, junior_elf.elf_id
)
order by shared_skill
limit 3
;
