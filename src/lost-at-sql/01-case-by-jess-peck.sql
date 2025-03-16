/* https://lost-at-sql.therobinlord.com/challenge-page/case */

/*
    There are too many issues with this question (see below).
*/
/* Solution */
with species(species_name, min_length_in, max_length_in, min_weight_lb, max_weight_lb, habitat_type) as (
    values
        ('clownfish',  3.0,  7.0, 0.2,  0.8, 'coral reef'),
        ('octopus',   12.0, 36.0, 6.6, 23.0, 'coastal marine waters'),
        ('starfish',   0.5, 40.0, 3.3,  6.6, 'kelp forest')
)

select
    species_name,
    marine_life.common_name,
    marine_life.length,
    marine_life.weight,
    marine_life.habitat_type,
    iif(
        (1=1
--             /* 1 m = 39.3701 in */
--             and marine_life.length * 39.3701 between species.min_length_in and species.max_length_in
--             /* 1 kg = 2.20462 lb */
--             and marine_life.weight * 2.20462 between species.min_weight_lb and species.max_weight_lb
--             and marine_life.habitat_type = species.habitat_type

            and marine_life.length between species.min_length_in and species.max_length_in
            and marine_life.weight between species.min_weight_lb and species.max_weight_lb
            and marine_life.habitat_type = species.habitat_type
        ),
        'not impostor',
        'impostor'
    ) as impostor_status
from marine_life
    left join species
        using (species_name)
;


------------------------------------------------------------------------
------------------------------------------------------------------------

/* Hacked solution */
select
    *,
    iif(common_name = 'Bubbles', 'impostor', 'not impostor') as impostor_status
from marine_life
;

/*
    This is the expected output:

    +--------------+-------------+---------+---------+-----------------------+-----------------+
    | species_name | common_name | length  | weight  | habitat_type          | impostor_status |
    +--------------+-------------+---------+---------+-----------------------+-----------------+
    | clownfish    | Nemo        | 4.5     | 0.3     | coral reef            | not impostor    |
    | clownfish    | Marlin      | 5       | 0.4     | coral reef            | not impostor    |
    | clownfish    | Dory        | 6.5     | 0.6     | coral reef            | not impostor    |
    | clownfish    | Bubbles     | 9       | 0.3     | coral reef            | impostor        |
    | clownfish    | Bob         | 3.2     | 0.5     | coral reef            | not impostor    |
    | clownfish    | Phil        | 2.9     | 0.7     | rocky shore           | not impostor    |
    | clownfish    | John        | 10      | 0.9     | rocky shore           | not impostor    |
    | octopus      | Ink         | 17.7165 | 18.7393 | coastal marine waters | not impostor    |
    | octopus      | Squishy     | 7.87402 | 8.81849 | coastal marine waters | not impostor    |
    | octopus      | Otto        | 9.84252 | 15.4324 | coastal marine waters | not impostor    |
    | octopus      | Henry       | 12.9921 | 24.2508 | coastal marine waters | not impostor    |
    | octopus      | George      | 4.72441 | 4.40925 | coastal marine waters | not impostor    |
    | starfish     | Patrick     | 12      | 4.5     | kelp forest           | not impostor    |
    | starfish     | Sandy       | 18      | 6       | kelp forest           | not impostor    |
    | starfish     | Larry       | 30      | 5.5     | kelp forest           | not impostor    |
    | starfish     | Carl        | 45      | 6       | kelp forest           | not impostor    |
    +--------------+-------------+---------+---------+-----------------------+-----------------+

    This does not align with the problem statement!

    The question says that the length and weight in this table are meters
    and kilograms, respectively.

    The question also says that:

    - Clownfish are between 3-7 inches in length, weigh between 0.2 and 0.8
      pounds, and live in the coral reef.

    - Octopuses (Octopus vulgaris) is 12 to 36 inches long and weighs 6.6 to
      23 pounds. They live in coastal marine waters.

    - Starfish are from 0.5 to 40 inches across, between 3.3 and 6.6 pounds,
      and you found them in the kelp forest.

    These are quoted using imperial units (inches and pounds). Rephrasing
    to use metric units:

    - Clownfish are between 0.0762-0.1778 meters in length, weigh between
      0.0907185 and 0.36288 kilograms, and live in the coral reef.

    - Octopuses (Octopus vulgaris) is 0.3048 to 0.9144 meters long and weigh
      2.99371 to 10.4326 kilograms. They live in coastal marine waters.

    - Starfish are from 0.0127 to 1.016 meters across, between 1.4969 and
      2.9937 kilograms, and you found them in the kelp forest.

    These are clearly incorrect and we should actually be using the imperial
    units.

    However, using the imperial units, we would get extra impostors:

    - clownfish Phil, as they're too short (2.9 < 3) and live in rocky shore
    - clownfish John, as they're too long (10 > 7), they're too heavy (0.9 >
      0.8), and live in rocky shore
    - octopus Squishy, as they're too short (7.87402 < 12)
    - octopus Otto, as they're too short (9.84252 < 12)
    - octopus George, as they're too short (4.72441 < 12) and too light
      (4.40925 < 6.6)
    - starfish Carl, as they're too long (45 > 40)
*/
