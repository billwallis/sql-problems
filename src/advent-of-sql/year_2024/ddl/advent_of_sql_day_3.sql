/*
    https://adventofsql.com/challenges/3
    https://adventofsql.com/challenges/3/data
*/
drop schema if exists day_03 cascade;
create schema day_03;
use day_03;


/* Create tables */
create table day_03.christmas_menus (
    id int primary key,
    menu_data varchar  /* XML */
);


/* Sample data */
insert into day_03.christmas_menus
values
(1, '<menu version="1.0">
    <dishes>
        <dish>
            <food_item_id>99</food_item_id>
        </dish>
        <dish>
            <food_item_id>102</food_item_id>
        </dish>
    </dishes>
    <total_count>80</total_count>
</menu>'),
(2, '<menu version="2.0">
    <total_guests>85</total_guests>
    <dishes>
        <dish_entry>
            <food_item_id>101</food_item_id>
        </dish_entry>
        <dish_entry>
            <food_item_id>102</food_item_id>
        </dish_entry>
    </dishes>
</menu>'),
(3, '<menu version="beta">
  <guestCount>15</guestCount>
  <foodList>
      <foodEntry>
          <food_item_id>102</food_item_id>
      </foodEntry>
  </foodList>
</menu>')
;
