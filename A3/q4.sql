set search_path to carschema;
drop table if exists q4 cascade;

create table q4(customer_email VARCHAR(50));


create view less_than30 as
  select *
  from customer
  where age < 30;

create view less_thirty_res as
  select less_than30.email, reservation.id, reservation.old_res_id, reservation.from_date,
  reservation.status
  from less_than30 join customer_res on less_than30.email = customer_res.email
  join reservation on reservation.id = customer_res.res_num;

create view all_changers as
  select c1.*
  from less_thirty_res c1, less_thirty_res c2
  where c1.email = c2.email and c2.id = c1.old_res_id;

create view changes_with_month as
  select all_changers.*, cast(extract(month from(age(from_date))) as int) as month_diff
  from all_changers;

create view recent_changes as
  select *
  from changes_with_month
  where month_diff < 18;

create view customer_changes as
  select email, count(*) as num_changes
  from recent_changes
  group by email;

create view result4 as
  select email as customer_email
  from customer_changes
  where num_changes >= 2;

insert into q4 select * from result4;
