create table q(
	id integer,
	user_id integer,
	total integer,
	created timestamp
)

select * from q

create temporary table w0 as
select user_id, min(DATE_PART('week', created)) as first_week from q
group by user_id
order by user_id

create temporary table all_week as 
select user_id, DATE_PART('week',created) as login_week from q
group by user_id, login_week
order by user_id, login_week

select * from all_week
select * from w0

create temporary table week_diff as
select a.user_id, a.login_week, b.first_week, a.login_week - b.first_week as week_number 
from all_week a
inner join w0 b
on a.user_id = b.user_id

select first_week,week_number from week_diff
order by week_number

select first_week,
	SUM(CASE WHEN week_number = 0 THEN 1 ELSE 0 END) AS week_0,
	SUM(CASE WHEN week_number = 1 THEN 1 ELSE 0 END) AS week_1,
	SUM(CASE WHEN week_number = 2 THEN 1 ELSE 0 END) AS week_2,
	SUM(CASE WHEN week_number = 3 THEN 1 ELSE 0 END) AS week_3,
	SUM(CASE WHEN week_number = 4 THEN 1 ELSE 0 END) AS week_4,
	SUM(CASE WHEN week_number = 5 THEN 1 ELSE 0 END) AS week_5,
	SUM(CASE WHEN week_number = 6 THEN 1 ELSE 0 END) AS week_6,
	SUM(CASE WHEN week_number = 7 THEN 1 ELSE 0 END) AS week_7,
	SUM(CASE WHEN week_number = 8 THEN 1 ELSE 0 END) AS week_8,
	SUM(CASE WHEN week_number = 9 THEN 1 ELSE 0 END) AS week_9,
	SUM(CASE WHEN week_number = 10 THEN 1 ELSE 0 END) AS week_10

from week_diff
group by first_week
order by first_week

