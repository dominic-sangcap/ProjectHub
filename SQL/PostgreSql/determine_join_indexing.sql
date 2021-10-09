-- creating table
DROP TABLE IF EXISTS public.sensor_msmt;
CREATE TABLE public.sensor_msmt (
   sensor_id        int not null,
   msmt_date        date not null,
   temperature      int,
   humidity         int
) PARTITION BY RANGE (msmt_date);

-- creating partitions
CREATE TABLE public.sensor_msmtt_y2021m01 PARTITION OF public.sensor_msmt
    FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');

CREATE TABLE public.sensor_msmtt_y2021m02 PARTITION OF public.sensor_msmt
    FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');

-- inserting data into table
insert into public.sensor_msmt
	-- testing generating big data
	(with sensors_datetimes as
		(select * from
			(SELECT
			  *
			FROM
			  generate_series(1,100)) as t1,
			(SELECT
			  *
			FROM
			  generate_series('2021-01-01 00:00'::timestamp,
							  '2021-02-15 00:00'::timestamp,
							  '1 minutes')) as t2
		)
	select
		sd.*,
		floor(random()*30) as tempature,
		floor(random()*80) as humidity
	from 
		sensors_datetimes sd
	)
-- testing explain qeury
explain select 
	*
from 
	public.sensor_msmt
where 
	sensor_id between 10 and 20;

-- create index
create index idx_sensor_msmt_id on public.sensor_msmt(sensor_id);

-- create table with indexes
create table public.sensors as
	(with sensor_ids as 
		(select i from generate_series(1, 100) as i)
	select
		i as id, 'Sensor ' || i::text as sensor_name
	from 
		sensor_ids)
		
-- explain on two tables join, determining type of join
explain select 
	s.sensor_name,
	sm.msmt_date,
	sm.temperature,
	sm.humidity
from 
	public.sensor_msmt as sm
left join
	public.sensors as s 
on 
	sm.sensor_id = s.id
-- adding in where clause changes type of join of tables
-- changes from hash join into nested loops
where 
	s.id = 30
	
	


