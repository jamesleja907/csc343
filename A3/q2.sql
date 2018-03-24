set search_path to carschema;
drop table if exists q1 cascade;

create table q2(
  customer_email VARCHAR(50)
);


create view complete_res as
  select res_id, email, status
  from Reservation join Cust_res on reservation.id = cust_res.res_num
  where status = 'Completed';

create view multiple_res as
  select c1.email, count(*)
  from complete_res c1, complete_res c2
  where c1.res_id =c2.res_id and c1.email != c2.email
  group by c1.email;

create view top as
  select *
  from multiple_res
  where not exists(
    select *
    from multiple_res m1
    where m1.count > count
  );

create view non_top as
  select *
  from (multiple_res) except (top);

create view num_two as
  select *
  from non_top
  where not exists(
    select *
    from non_top n1
    where n1.count > count
  );

create view top_two as
  select *
  from (top) union (num_two)
  order by count;

create view result as
  select case when(select count(*) from multiple_res = 0) then
   complete_res.email else top_two.email end as email
   from complete_res, multiple_res;

insert into q2 select * from result;
