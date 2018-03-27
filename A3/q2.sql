set search_path to carschema;
drop table if exists q2 cascade;

create table q2(
  email VARCHAR(50),
  num_shared_reservations int
);

-- look for all reservations that are not cancelled, not just completed
create view complete_res as
  select res_num, email, status
  from Reservation join Customer_res on reservation.id = customer_res.res_num
  where status != 'Cancelled';

-- get all the reservations where a customer is the only driver
create view single_res as select * from complete_res c1
  where not exists(select * from complete_res c2
    where c1.res_num = c2.res_num and c1.email != c2.email);

-- get all reservations with multiple drivers
create view multiple_res as (select * from complete_res) except (select * from single_res);

-- get the number of times a customer has made a reservation with multiple drivers
create view multiple_count as select email, count(*) from multiple_res group by email;

-- rank the result by count, breaking ties by order of email ascending
create view multiple_rank as select email, count, row_number() over(order by count desc, email) as rank
  from multiple_count;

-- select the two customers who have made the most reservations with other drivers
create view result2 as select email, count as num_shared_reservations 
  from multiple_rank where rank = 1 or rank = 2 
  order by num_shared_reservations desc, email;

--insert into q2 select * from result2;
