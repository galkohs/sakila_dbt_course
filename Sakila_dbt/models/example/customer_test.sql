{{config(materialized='table', alias= 'cust_alias', schema = 'new') }}

SELECT
*
from {{ ref('hello_world') }}
where customer_id <= {{var('cust_id')}}