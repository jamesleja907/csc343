set search_path to carschema;
drop table if exists q3 cascade;


create table q3(name VARCHAR(50));

-- Get all car ids rented in Toronto in 2017
create view TO_seventeen as
  select reservation.id as res_id, reservation.car_id, car.model_id
  from Reservation join Car on reservation.car_id = car.id
  join Rentalstation on car.station_code = Rentalstation.code
  where Rentalstation.city = 'Toronto' and extract(year from from_date) = 2017
   and extract(year from to_date) = 2017
   and reservation.status = 'Completed';

-- Get the number of models rented in Toronto in 2017
create view num_models as
  select model_id, count(*)
  from TO_seventeen
  group by model_id;

-- Get the names of the models rented
create view popular_models as
  select model.name, count
  from num_models join model on num_models.model_id = model.id;

-- rank the models rented in toronto by # times rented, breaking ties by name
create view model_ranks as
  select name, count, row_number() over (order by count desc, name) as rank
  from popular_models;

-- get the most popular model rented in Toronto in 2017
create view result3 as
  select name
  from model_ranks
  where rank = 1;

select * from result3;
--insert into q3 select * from result3;
