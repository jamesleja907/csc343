set search_path to carschema;
drop table if exists q1 cascade;


create table q1(
  customer_email VARCHAR(50),
  res_to_cancel_ratio float
);

--Get table of customer reservations
create view cust_res as select customer.id as customer_id, email, reservation.id as res_id,
   res_status, old_res_id
  from customer join customer_res on customer.email = customer_res.email
  join reservation on customer_res = reservation.id;

--Get table of customers that have Completed reservations
create view completed as select customer_id, email, count(*) as completed_res
  from cust_res
  where res_status = 'Completed'
  group by customer_id;

create view cancelled as select customer_id, email, count(*) as cancelled_res
  from cust_res
  -- need to not count changed reservations
  where res_status = 'Cancelled' and  not exists(
    select *
    from cust_res c1
    where c1.old_res_id = res_id)
  group by customer_id;

create view cancel_ratio as
  select  customer_id, email, case when (completed_res is null) then cancelled_res
  when (cancelled_res is null) then completed_res
  else cast(cancelled as float)/cast(completed as float) end as ratio
  from cancelled natural full join completed
  order by ratio desc;

create view max_ratio as
  select customer_id, email, ratio
  from cancel_ratio
  where not exists(
    select *
    from ratio r1
    where r1.ratio > ratio
  );

create view left_overs as
  select *
  from (cancel_ratio) except (max_ratio)

create view number_two as
  select customer_id, emial, ratio
  from left_overs
  where not exists(
    select *
    from left_overs l1
    where l1.ratio > ratio
  );

  create view result as
    select *
    from (max_ratio) union (number_two)
    order by ratio desc, email;

  insert into q1 select * from result;
