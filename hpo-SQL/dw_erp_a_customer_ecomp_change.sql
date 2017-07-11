create table dw_erp_a_customer_ecomp_change
(customer_id int comment '客户ID',
 customer_name string comment '客户名称',
 old_ecomp_id int comment '更新前ecomp_id',
 new_ecomp_id int comment '更新后ecomp_id', 
 change_date int comment '更新日期',
 creation_timestamp timestamp comment ' 时间戳 '
 );

select customer_id,customer_name,count(distinct ecomp_id) as ecomp_cnt
from dw_erp_d_customer_base 
where p_date >=20160101
and ecomp_id <> 0
group by customer_id,customer_name
having ecomp_cnt > 1


select id,name,ecomp_id,min(p_date) as b_date,max(p_date) as e_date
from dw_erp_d_customer_base 
join (select 6340667 as customer_id from dummy) muti_cust
on id = muti_cust.customer_id
where p_date >=20161201
and ecomp_id <> 0
group by id,name,ecomp_id


insert overwrite table dw_erp_a_customer_ecomp_change
select tp.id,cust.name,old_ecomp_id,ecomp_id,start_date as change_date,current_timestamp
from (
select id,
	   ecomp_id,
	   start_date,
	   lag(ecomp_id,1,0) over(distribute by id sort by start_date) as old_ecomp_id,
	   row_number()over(distribute by id sort by start_date) as rn 
from temp_mancj_20170309105707
) tp 
left join dw_erp_d_customer_base_new cust 
on tp.id = cust.id
where rn > 1 ;