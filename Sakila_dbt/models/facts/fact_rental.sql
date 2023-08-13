{{ config(materialized='incremental',unique_key='rental_id') }}

select 
r.*,
f.film_id,
store.store_id,
case 	when r.return_date is null 
			then '0'
		when r.return_date is not null 
			then '1'
		else 'null'
		end as flag_return,
extract(day from age(return_date,rental_date)*24)+ extract(hour from age(return_date,rental_date)) as total_rent_hours,
'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}'::timestamp as dbt_time
from rental r
left join inventory i 
	on i.inventory_id  =r.inventory_id 
left join film f
	on f.film_id =i.film_id
left join staff
	on staff.staff_id = r.staff_id
left join store
	on store.manager_staff_id =staff.staff_id