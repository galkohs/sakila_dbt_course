{{ config(post_hook='insert into {{this}}(staff_id) VALUES (-1)') }}

select 
staff_id ,
first_name ,
last_name ,
email ,
case when active= true then 'yes'
  	when active= false then 'no'
	else null
end as activ_desc,
last_update ,
'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}'::timestamp as dbt_time
from public.staff