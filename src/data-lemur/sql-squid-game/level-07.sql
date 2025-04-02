/* https://datalemur.com/sql-game/level7.html */

/*
    Hmm, I don't agree with the recommended solution for a few reasons (due
    to ambiguity in the problem statement).

    - The "last seen in room" time according to the recommended solution is
      the time where `room.isvacant` is `true`. This doesn't seem right to
      me: if the room was vacant, then they weren't seen in the room!

      However, given that there's only one row per room in the `room` table,
      there are no corresponding `room.isvacant = false` rows for us to get
      the "last seen in room" time from, so this is the best we can do.

    - The "time range from first to last detection of any guard" time
      according to the recommended solution is just using motion in the
      outside cameras. The problem statement doesn't make it explicit that
      this should only consider outside cameras. We could also consider the
      room check times.

    - The recommended solution directly joins onto the `camera` table
      without guaranteeing that there are no duplicates. If a guard was
      spotted outside multiple times, the recommended solution would break.

    This has the potential to be a good question, but isn't quite there yet.
*/
/* Solution */
with last_spotted as (
    select distinct on (guard_spotted_id)
        guard_spotted_id,
        movement_detected_time,
        location
    from camera
    where movement_detected
    order by
        guard_spotted_id,
        movement_detected_time desc
)

select
    guard.id as guard_number,
    guard.code_name,
    guard.status,
    room.last_check_time as last_seen_in_room_time,
    last_spotted.movement_detected_time as spotted_outside_room_time,
    last_spotted.location as spotted_outside_room_location,
    last_spotted.movement_detected_time - room.last_check_time as time_between_room_and_outside,
    (
        select max(movement_detected_time) - min(movement_detected_time)
        from camera
        where movement_detected_time is not null
    ) as detection_time_range
from guard
    inner join room
        on  guard.assigned_room_id = room.id
        and room.isvacant
    left join last_spotted
        on guard.id = last_spotted.guard_spotted_id
order by guard_number
;
