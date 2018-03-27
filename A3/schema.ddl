--Schema for rental car database

-- What constraints from the domain could not be enforced?
-- -- Checking whether the number of drivers is less than or equal to the
--    capacity of the car could not be enforced by simple check constraints.
--    To do so would require multiple tables and would need a trigger to be enforced.
-- -- Adding a constraint to check if reservation dates and times overlap also
--    could not be enforced by simple check constraints and would require a trigger.
-- -- Constraining the changed reservations to one time.
--
-- -- As well, a trigger would be needed to enforce the constraint that a car
--    cannot have an overlapping reservation dates.
--What constraints that could have been enforced but were not? Why?
--  -- We could have enforced the fact that a car must be picked up and dropped
--     off at the same location, however this is implicit in the schema, since
--     a car has a foreign key constraint referencing a rental station code.
--     To enforce this constraint we would have to add extraneous attributes and
--     another table which would be a bad design.
--
--  --
drop schema if exists carschema cascade;
create schema carschema;
set search_path to carschema;

--
create type Res_status as ENUM(
  'Ongoing', 'Completed', 'Cancelled', 'Confirmed'
);

Create Table Customer(
  name varchar(50) not null,
  age INT not null
  check (age >= 18),
  email varchar(50) primary key
);

-- Model includes a primary key id, name, vehicle type v_type, model number, and
-- capacity. We assumed that model name and number combination would be unique.
-- As well, we check to ensure that the capacity is at least 2 which is the
-- smallest capacity a car could have. 
create Table Model(
  id INT primary key,
  name varchar(50) Not Null,
  v_type varchar(50) Not null,
  model_num INT,
  capacity INT,
  check (capacity >= 2),
  unique(name, model_num)
);

-- Rentalstation has a primary key 'code', name, address, area_code, and city.
-- the code is referenced by car, this implicitly constrains a car to be picked
-- up and dropped off at the same location.
create Table Rentalstation(
  code INT primary key,
  name varchar(100),
  address varchar(100),
  area_code varchar(10),
  city varchar (50)
);

-- Table Car includes a unique car id which its primary key, license_num which we
--  assume to be unique together with a station_code as license numbers could potentiall
-- be the same in different provinces. The station code is a foreign key
-- constraint from the table Rentalstation, and model_id is a foreign
-- key constriant from Model.
Create Table Car(
  id INT primary key,
  license_num varchar(20) Not null,
  station_code INT References Rentalstation(code),
  model_id INT References Model(id),
  unique(license_num, station_code)
);

--The reservation table includes a unique id that is the table's primary key,
-- a from_date and to_date corresponding to the start and end days and times
-- of a reservation, along with a car id that which is a foreign key constraint
-- from the Car Table. As well, there is a check to ensure that a reservation is
-- at least 2 hours in length. While not a requirement in the handout, we felt it
-- reasonable to include as a rental company would not want to rent a car out for
-- less time.
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

-- The table Customer_res connects a customer's email with a reservation id with
-- the combination of the two being the table's primary key.
create table Customer_res(
  email varchar References Customer(email),
  res_num INT References Reservation(id),
  primary key (email, res_num)
);
