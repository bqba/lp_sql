insert overwrite table dw_erp_d_gcdc_customer_package partition(p_date = $date$)
select 
    customer_id,pack_customerid,
	current_timestamp as creation_timestamp
from (
select 
	distinct customer_id,
	regexp_replace(customer_ids,'\t','') as pack_customerid
from (select split(customer_ids,',') as customers ,customer_ids
		from rsc_customer_package
		where deleteflag = 0
	 ) package 
lateral view explode(customers) subview as customer_id
where regexp_replace(customer_id,'\t','') <> ''
) t 




select 
    customer_id,pack_customerid,
	current_timestamp as creation_timestamp
from (
select 
	distinct customer_id,
	regexp_replace(customer_ids,'\t','') as pack_customerid
from (select split(customer_ids,',') as customers
		from rsc_customer_package
		where deleteflag = 0
	 ) package 
lateral view explode(customers) subview as customer_id
where regexp_replace(customer_id,'\t','') <> ''
) t 