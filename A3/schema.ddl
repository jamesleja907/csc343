--Schema for rental car database

-- What constraints from the domain could not be enforced?
-- -- Checking whether the number of drivers for a reservation is less than or equal to the
--    capacity of the reservation's car could not be enforced by simple check constraints.
--    To do so would require a subquery with multiple tables (Model, Car, Customer_res) 
--    and would therefore need a trigger to be enforced.
--
-- -- A trigger would also be needed to enforce the constraint that a single car
--    cannot have overlapping reservation times.

-- What constraints that could have been enforced but were not? Why?
--  -- We could have further enforced the fact that a car must be picked up and dropped
--     off at the same location. This is implicit in our schema, since a car has a 
--     foreign key constraint referencing a rental station code. We could have added
--     a constraint that a car's station_code could not by updated, but this would restrict
--     the rental company from moving a car to a new location. We could also have enforced
--     this constraint by adding extraneous attributes (pickup_location, dropoff_location)
--     to the customer_res table, or by creating another table, but we felt this was bad design.
--
--  --
drop schema if exists carschema cascade;
create schema carschema;
set search_path to carschema;

create type Res_status as ENUM(
  'Ongoing', 'Completed', 'Cancelled', 'Confirmed'
);

Create Table Customer(
  name varchar(50) not null,
  age INT not null
  check (age >= 18),
  email varchar(50) primary key
);

create Table Model(
  id INT primary key,
  name varchar(50) Not Null,
  v_type varchar(50) Not null,
  model_num INT,
  capacity INT,
  unique(name, model_num)
);

create Table Rentalstation(
  code INT primary key,
  name varchar(100),
  address varchar(100),
  area_code varchar(10),
  city varchar (50)
);

Create Table Car(
  id INT primary key,
  license_num varchar(20) Not null unique,
  station_code INT References Rentalstation(code),
  model_id INT References Model(id)
);


Create Table Reservation(
  id INT primary key,
  from_date Timestamp NOT Null,
  to_date Timestamp NOT Null,
  car_id INT References Car(id) NOT Null,
  old_res_id INT default null,
  status res_status NOT NUll,
  check ((date_part('day', to_date - from_date)*24 +
          date_part('hour', to_date - from_date)) >= 2)
);

create table Customer_res(
  email varchar References Customer(email),
  res_num INT References Reservation(id)
);
