# drop the event table if it exists, then recreate it

DROP TABLE IF EXISTS event;

CREATE TABLE event
(
  event_id  int not null auto_increment,
  pet_id int not null,
  date      DATE,
  type      VARCHAR(15),
  remark    VARCHAR(255), 
  foreign   key(pet_id) references pet(pet_id), 
  primary   key(event_id)
);
