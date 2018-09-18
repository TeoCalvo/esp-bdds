# drop the pet table if it exists, then recreate it

DROP TABLE IF EXISTS pet;

CREATE TABLE pet
(
  pet_id int not null auto_increment, 
  name    VARCHAR(20),
  owner   VARCHAR(20),
  species VARCHAR(20),
  sex     CHAR(1),
  birth   DATE,
  death   DATE,
  primary key(pet_id)
);
