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

create view single_res as select * from complete_res c1
  where not exists(select * from complete_res c2
    where c1.res_num = c2.res_num and c1.email != c2.email);

create view multiple_res as (select * from complete_res) except (select * from single_res);

create view multiple_count as select email, count(*) from multiple_res group by email;

create view multiple_rank as select email, count, row_number() over(order by count desc, email) as multiple_rank
  from multiple_count;

create view result2 as select email, count as num_shared_reservations 
  from multiple_rank where rank = 1 or rank = 2 
  order by num_shared_reservations desc, email

-- create view top as
--   select *
--   from multiple_res
--   where not exists(
--     select *
--     from multiple_res m1
--     where m1.count > count
--   );

-- create view non_top as
--   select *
--   from (multiple_res) except (top);

-- create view num_two as
--   select *
--   from non_top
--   where not exists(
--     select *
--     from non_top n1
--     where n1.count > count
--   );

-- create view top_two as
--   select *
--   from (top) union (num_two)
--   order by count;

-- create view result as
--   select case when(select count(*) from multiple_res = 0) then
--    complete_res.email else top_two.email end as email
--    from complete_res, multiple_res;

insert into q2 select * from result;
