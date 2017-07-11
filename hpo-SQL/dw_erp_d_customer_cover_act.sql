create table dw_erp_d_customer_cover_act
(
d_date	int	comment '统计日期',
customer_id	int	comment '客户ID',
customer_name	string	comment '客户名称',
salesuser_id	int	comment '销售ID',
salesuser_name	string	comment '销售名称',
org_id	int	comment '组织ID',
org_name	string	comment '组织名称',
is_valid_cover	int	comment '当天是否有效沟通',
is_cover	int	comment '当天是否沟通',
valid_cover_cnt	int	comment '当天有效沟通次数',
cover_cnt	int	comment '当天沟通次数',
valid_cover_timelong	float	comment '当天有效沟通时长',
cover_timelong	float	comment '当天沟通时长',
7day_is_valid_cover	int	comment '7天内是否有效沟通',
7day_is_cover	int	comment '7天内是否沟通',
7day_valid_cover_cnt	int	comment '7天有效沟通次数',
7day_cover_cnt	int	comment '7天沟通次数',
7day_valid_cover_timelong	float	comment '7天有效沟通时长',
7day_cover_timelong	float	comment '7天沟通时长',
14day_is_valid_cover	int	comment '14天内是否有效沟通',
14day_is_cover	int	comment '14天内是否沟通',
14day_valid_cover_cnt	int	comment '14天有效沟通次数',
14day_cover_cnt	int	comment '14天沟通次数',
14day_valid_cover_timelong	float	comment '14天有效沟通时长',
14day_cover_timelong	float	comment '14天沟通时长',
30day_is_valid_cover	int	comment '30天内是否有效沟通',
30day_is_cover	int	comment '30天内是否沟通',
30day_valid_cover_cnt	int	comment '30天有效沟通次数',
30day_cover_cnt	int	comment '30天沟通次数',
30day_valid_cover_timelong	float	comment '30天有效沟通时长',
30day_cover_timelong	float	comment '30天沟通时长',
lockday_is_valid_cover	int	comment '锁定至今是否有效沟通',
lockday_is_cover	int	comment '锁定至今是否沟通',
lockday_valid_cover_cnt	int	comment '锁定至今有效沟通次数',
lockday_cover_cnt	int	comment '锁定至今沟通次数',
lockday_valid_cover_timelong	float	comment '锁定至今有效沟通时长',
lockday_cover_timelong	float	comment '锁定至今沟通时长',
creation_timestamp timestamp comment '时间戳'
) comment '客户电话日覆盖明细'
partitioned by (p_date int);

alter table dw_erp_d_customer_cover_act add columns(last_cover_date string comment '最后沟通日期',last_valid_cover_date comment '最后有效沟通日期') cascade;

insert into dw_erp_d_customer_cover_act partition (p_date = $date$)
select 
$date$ as d_date,
customer.customer_id,
customer.customer_name,
customer.salesuser_id,
customer.salesuser_name,
customer.org_id,
customer.org_name,
nvl(call.is_valid_cover,0) as is_valid_cover,
nvl(call.is_cover,0) as is_cover,
nvl(call.valid_cover_cnt,0) as valid_cover_cnt,
nvl(call.cover_cnt,0) as cover_cnt,
nvl(call.valid_cover_timelong,0) as valid_cover_timelong,
nvl(call.cover_timelong,0) as cover_timelong,
nvl(call.7day_is_valid_cover,0) as 7day_is_valid_cover,
nvl(call.7day_is_cover,0) as 7day_is_cover,
nvl(call.7day_valid_cover_cnt,0) as 7day_valid_cover_cnt,
nvl(call.7day_cover_cnt,0) as 7day_cover_cnt,
nvl(call.7day_valid_cover_timelong,0) as 7day_valid_cover_timelong,
nvl(call.7day_cover_timelong,0) as 7day_cover_timelong,
nvl(call.14day_is_valid_cover,0) as 14day_is_valid_cover,
nvl(call.14day_is_cover,0) as 14day_is_cover,
nvl(call.14day_valid_cover_cnt,0) as 14day_valid_cover_cnt,
nvl(call.14day_cover_cnt,0) as 14day_cover_cnt,
nvl(call.14day_valid_cover_timelong,0) as 14day_valid_cover_timelong,
nvl(call.14day_cover_timelong,0) as 14day_cover_timelong,
nvl(call.30day_is_valid_cover,0) as 30day_is_valid_cover,
nvl(call.30day_is_cover,0) as 30day_is_cover,
nvl(call.30day_valid_cover_cnt,0) as 30day_valid_cover_cnt,
nvl(call.30day_cover_cnt,0) as 30day_cover_cnt,
nvl(call.30day_valid_cover_timelong,0) as 30day_valid_cover_timelong,
nvl(call.30day_cover_timelong,0) as 30day_cover_timelong,
nvl(customer.lockday_is_valid_cover,0) as lockday_is_valid_cover,
nvl(customer.lockday_is_cover,0) as lockday_is_cover,
nvl(customer.lockday_valid_cover_cnt,0) as lockday_valid_cover_cnt,
nvl(customer.lockday_cover_cnt,0) as lockday_cover_cnt,
nvl(customer.lockday_valid_cover_timelong,0) as lockday_valid_cover_timelong,
nvl(customer.lockday_cover_timelong,0) as lockday_cover_timelong,
from_unixtime(unix_timestamp()) as creation_timestamp,
nvl(customer.last_cover_date,'0') as last_cover_date,
nvl(customer.last_valid_cover_date,'0') as last_valid_cover_date
from (
select
	base.id as customer_id,
	base.name as customer_name,
	base.sales_user_id as salesuser_id,
	base.sales_user_name as salesuser_name,
	base.sales_org_id as org_id,
	base.sales_org_name as org_name,
	case when count(case when call_record.call_date between substr(regexp_replace(base.last_lock_time,'-',''),1,8) and $date$ and timelong >45 then customer_id else null end) > 0 then 1 else 0 end as lockday_is_valid_cover,
	case when count(case when call_record.call_date between substr(regexp_replace(base.last_lock_time,'-',''),1,8) and $date$ and timelong >10 then customer_id else null end) > 0 then 1 else 0 end as lockday_is_cover,
	count(case when call_record.call_date between substr(regexp_replace(base.last_lock_time,'-',''),1,8) and $date$ and timelong >45 then customer_id else null end) as lockday_valid_cover_cnt,
	count(case when call_record.call_date between substr(regexp_replace(base.last_lock_time,'-',''),1,8) and $date$ and timelong >10 then customer_id else null end) as lockday_cover_cnt,
	sum(case when call_record.call_date between substr(regexp_replace(base.last_lock_time,'-',''),1,8) and $date$ and timelong >45 then timelong  else 0 end) as lockday_valid_cover_timelong,
	sum(case when call_record.call_date between substr(regexp_replace(base.last_lock_time,'-',''),1,8) and $date$ and timelong >10 then timelong  else 0 end) as lockday_cover_timelong,
	max(case when timelong >10 then concat(substr(call_date,1,4),'-',substr(call_date,5,2),'-',substr(call_date,7,2)) else null end) as last_cover_date,
	max(case when timelong >45 then concat(substr(call_date,1,4),'-',substr(call_date,5,2),'-',substr(call_date,7,2)) else null end) as last_valid_cover_date
from dw_erp_d_customer_base base
left join dw_erp_a_call_record call_record 
on base.id = call_record.customer_id
and base.sales_user_id = call_record.creator_id
where base.p_date = $date$
group by base.id,
		 base.name,
		 base.sales_user_id,
		 base.sales_user_name,
		 base.sales_org_id,
		 base.sales_org_name
) customer 
left join 
(
select 
	customer_id,creator_id,
	case when count(case when call_date = $date$ and timelong >10 then customer_id else null end) > 0 then 1 else 0 end as is_cover,
	case when count(case when call_date = $date$ and timelong >45 then customer_id else null end) > 0 then 1 else 0 end as is_valid_cover,
	count(case when call_date = $date$ and timelong >45 then customer_id else null end) as valid_cover_cnt,
	count(case when call_date = $date$ and timelong >10 then customer_id else null end) as cover_cnt,
	sum(case when call_date = $date$ and timelong >45 then timelong  else 0 end) as valid_cover_timelong,
	sum(case when call_date = $date$ and timelong >10 then timelong  else 0 end) as cover_timelong,
	case when count(case when call_date between {{delta(date,-6)}} and $date$ and timelong >10 then customer_id else null end) > 0 then 1 else 0 end as 7day_is_valid_cover,
	case when count(case when call_date between {{delta(date,-6)}} and $date$ and timelong >45 then customer_id else null end) > 0 then 1 else 0 end as 7day_is_cover,
	count(case when call_date between {{delta(date,-6)}} and $date$ and timelong >45 then customer_id else null end) as 7day_valid_cover_cnt,
	count(case when call_date between {{delta(date,-6)}} and $date$ and timelong >10 then customer_id else null end) as 7day_cover_cnt,
	sum(case when call_date between {{delta(date,-6)}} and $date$ and timelong >45 then timelong  else 0 end) as 7day_valid_cover_timelong,
	sum(case when call_date between {{delta(date,-6)}} and $date$ and timelong >10 then timelong  else 0 end) as 7day_cover_timelong,
	case when count(case when call_date between {{delta(date,-13)}} and $date$ and timelong >10 then customer_id else null end) > 0 then 1 else 0 end as 14day_is_valid_cover,
	case when count(case when call_date between {{delta(date,-13)}} and $date$ and timelong >45 then customer_id else null end) > 0 then 1 else 0 end as 14day_is_cover,
	count(case when call_date between {{delta(date,-13)}} and $date$ and timelong >45 then customer_id else null end) as 14day_valid_cover_cnt,
	count(case when call_date between {{delta(date,-13)}} and $date$ and timelong >10 then customer_id else null end) as 14day_cover_cnt,
	sum(case when call_date between {{delta(date,-13)}} and $date$ and timelong >45 then timelong  else 0 end) as 14day_valid_cover_timelong,
	sum(case when call_date between {{delta(date,-13)}} and $date$ and timelong >10 then timelong  else 0 end) as 14day_cover_timelong,
	case when count(case when call_date between {{delta(date,-29)}} and $date$ and timelong >10 then customer_id else null end) > 0 then 1 else 0 end as 30day_is_valid_cover,
	case when count(case when call_date between {{delta(date,-29)}} and $date$ and timelong >45 then customer_id else null end) > 0 then 1 else 0 end as 30day_is_cover,
	count(case when call_date between {{delta(date,-29)}} and $date$ and timelong >45 then customer_id else null end) as 30day_valid_cover_cnt,
	count(case when call_date between {{delta(date,-29)}} and $date$ and timelong >10 then customer_id else null end) as 30day_cover_cnt,
	sum(case when call_date between {{delta(date,-29)}} and $date$ and timelong >45 then timelong  else 0 end) as 30day_valid_cover_timelong,
	sum(case when call_date between {{delta(date,-29)}} and $date$ and timelong >10 then timelong  else 0 end) as 30day_cover_timelong
from dw_erp_a_call_record
where customer_id <> 0 
and call_date between {{delta(date,-29)}} and $date$
and p_date between {{delta(date,-29)}} and $date$
group by customer_id,creator_id
) call 
on customer.customer_id = call.customer_id
and customer.salesuser_id = call.creator_id;





insert into dw_erp_d_customer_cover_act partition (p_date = $date$)
select 
$date$ as d_date,
customer.customer_id,
customer.customer_name,
customer.salesuser_id,
customer.salesuser_name,
customer.org_id,
customer.org_name,
nvl(call.is_valid_cover,0) as is_valid_cover,
nvl(call.is_cover,0) as is_cover,
nvl(call.valid_cover_cnt,0) as valid_cover_cnt,
nvl(call.cover_cnt,0) as cover_cnt,
nvl(call.valid_cover_timelong,0) as valid_cover_timelong,
nvl(call.cover_timelong,0) as cover_timelong,
nvl(call.7day_is_valid_cover,0) as 7day_is_valid_cover,
nvl(call.7day_is_cover,0) as 7day_is_cover,
nvl(call.7day_valid_cover_cnt,0) as 7day_valid_cover_cnt,
nvl(call.7day_cover_cnt,0) as 7day_cover_cnt,
nvl(call.7day_valid_cover_timelong,0) as 7day_valid_cover_timelong,
nvl(call.7day_cover_timelong,0) as 7day_cover_timelong,
nvl(call.14day_is_valid_cover,0) as 14day_is_valid_cover,
nvl(call.14day_is_cover,0) as 14day_is_cover,
nvl(call.14day_valid_cover_cnt,0) as 14day_valid_cover_cnt,
nvl(call.14day_cover_cnt,0) as 14day_cover_cnt,
nvl(call.14day_valid_cover_timelong,0) as 14day_valid_cover_timelong,
nvl(call.14day_cover_timelong,0) as 14day_cover_timelong,
nvl(call.30day_is_valid_cover,0) as 30day_is_valid_cover,
nvl(call.30day_is_cover,0) as 30day_is_cover,
nvl(call.30day_valid_cover_cnt,0) as 30day_valid_cover_cnt,
nvl(call.30day_cover_cnt,0) as 30day_cover_cnt,
nvl(call.30day_valid_cover_timelong,0) as 30day_valid_cover_timelong,
nvl(call.30day_cover_timelong,0) as 30day_cover_timelong,
nvl(customer.lockday_is_valid_cover,0) as lockday_is_valid_cover,
nvl(customer.lockday_is_cover,0) as lockday_is_cover,
nvl(customer.lockday_valid_cover_cnt,0) as lockday_valid_cover_cnt,
nvl(customer.lockday_cover_cnt,0) as lockday_cover_cnt,
nvl(customer.lockday_valid_cover_timelong,0) as lockday_valid_cover_timelong,
nvl(customer.lockday_cover_timelong,0) as lockday_cover_timelong,
from_unixtime(unix_timestamp()) as creation_timestamp,
nvl(customer.last_cover_date,'0') as last_cover_date,
nvl(customer.last_valid_cover_date,'0') as last_valid_cover_date
from (
select
	base.id as customer_id,
	base.name as customer_name,
	base.sales_user_id as salesuser_id,
	base.sales_user_name as salesuser_name,
	base.sales_org_id as org_id,
	base.sales_org_name as org_name,
	case when count(case when call_record.call_date between substr(regexp_replace(base.last_lock_time,'-',''),1,8) and $date$ and time_long>45 then customer_id else null end) > 0 then 1 else 0 end as lockday_is_valid_cover,
	case when count(case when call_record.call_date between substr(regexp_replace(base.last_lock_time,'-',''),1,8) and $date$ and time_long>10 then customer_id else null end) > 0 then 1 else 0 end as lockday_is_cover,
	count(case when call_record.call_date between substr(regexp_replace(base.last_lock_time,'-',''),1,8) and $date$ and time_long>45 then customer_id else null end) as lockday_valid_cover_cnt,
	count(case when call_record.call_date between substr(regexp_replace(base.last_lock_time,'-',''),1,8) and $date$ and time_long>10 then customer_id else null end) as lockday_cover_cnt,
	sum(case when call_record.call_date between substr(regexp_replace(base.last_lock_time,'-',''),1,8) and $date$ and time_long>45 then time_long else 0 end) as lockday_valid_cover_timelong,
	sum(case when call_record.call_date between substr(regexp_replace(base.last_lock_time,'-',''),1,8) and $date$ and time_long>10 then time_long else 0 end) as lockday_cover_timelong,
	max(case when time_long>10 then concat(substr(call_date,1,4),'-',substr(call_date,5,2),'-',substr(call_date,7,2)) else null end) as last_cover_date,
	max(case when time_long>45 then concat(substr(call_date,1,4),'-',substr(call_date,5,2),'-',substr(call_date,7,2)) else null end) as last_valid_cover_date
from dw_erp_d_customer_base base
left join call_record 
on base.id = call_record.customer_id
and base.sales_user_id = call_record.creator_id
where base.p_date = $date$
group by base.id,
		 base.name,
		 base.sales_user_id,
		 base.sales_user_name,
		 base.sales_org_id,
		 base.sales_org_name
) customer 
left join 
(
select 
	customer_id,creator_id,
	case when count(case when call_date = $date$ and time_long>10 then customer_id else null end) > 0 then 1 else 0 end as is_cover,
	case when count(case when call_date = $date$ and time_long>45 then customer_id else null end) > 0 then 1 else 0 end as is_valid_cover,
	count(case when call_date = $date$ and time_long>45 then customer_id else null end) as valid_cover_cnt,
	count(case when call_date = $date$ and time_long>10 then customer_id else null end) as cover_cnt,
	sum(case when call_date = $date$ and time_long>45 then time_long else 0 end) as valid_cover_timelong,
	sum(case when call_date = $date$ and time_long>10 then time_long else 0 end) as cover_timelong,
	case when count(case when call_date between {{delta(date,-6)}} and $date$ and time_long>10 then customer_id else null end) > 0 then 1 else 0 end as 7day_is_valid_cover,
	case when count(case when call_date between {{delta(date,-6)}} and $date$ and time_long>45 then customer_id else null end) > 0 then 1 else 0 end as 7day_is_cover,
	count(case when call_date between {{delta(date,-6)}} and $date$ and time_long>45 then customer_id else null end) as 7day_valid_cover_cnt,
	count(case when call_date between {{delta(date,-6)}} and $date$ and time_long>10 then customer_id else null end) as 7day_cover_cnt,
	sum(case when call_date between {{delta(date,-6)}} and $date$ and time_long>45 then time_long else 0 end) as 7day_valid_cover_timelong,
	sum(case when call_date between {{delta(date,-6)}} and $date$ and time_long>10 then time_long else 0 end) as 7day_cover_timelong,
	case when count(case when call_date between {{delta(date,-13)}} and $date$ and time_long>10 then customer_id else null end) > 0 then 1 else 0 end as 14day_is_valid_cover,
	case when count(case when call_date between {{delta(date,-13)}} and $date$ and time_long>45 then customer_id else null end) > 0 then 1 else 0 end as 14day_is_cover,
	count(case when call_date between {{delta(date,-13)}} and $date$ and time_long>45 then customer_id else null end) as 14day_valid_cover_cnt,
	count(case when call_date between {{delta(date,-13)}} and $date$ and time_long>10 then customer_id else null end) as 14day_cover_cnt,
	sum(case when call_date between {{delta(date,-13)}} and $date$ and time_long>45 then time_long else 0 end) as 14day_valid_cover_timelong,
	sum(case when call_date between {{delta(date,-13)}} and $date$ and time_long>10 then time_long else 0 end) as 14day_cover_timelong,
	case when count(case when call_date between {{delta(date,-29)}} and $date$ and time_long>10 then customer_id else null end) > 0 then 1 else 0 end as 30day_is_valid_cover,
	case when count(case when call_date between {{delta(date,-29)}} and $date$ and time_long>45 then customer_id else null end) > 0 then 1 else 0 end as 30day_is_cover,
	count(case when call_date between {{delta(date,-29)}} and $date$ and time_long>45 then customer_id else null end) as 30day_valid_cover_cnt,
	count(case when call_date between {{delta(date,-29)}} and $date$ and time_long>10 then customer_id else null end) as 30day_cover_cnt,
	sum(case when call_date between {{delta(date,-29)}} and $date$ and time_long>45 then time_long else 0 end) as 30day_valid_cover_timelong,
	sum(case when call_date between {{delta(date,-29)}} and $date$ and time_long>10 then time_long else 0 end) as 30day_cover_timelong
from call_record
where deleteflag = 0
and customer_id <> 0 
and call_date between {{delta(date,-29)}} and $date$
group by customer_id,creator_id
) call 
on customer.customer_id = call.customer_id
and customer.salesuser_id = call.creator_id



select sales_id,sales_name,position_id,position_name,org_id,org_name,cust.name ,call.call_date,call.cover_cnt
from dw_erp_d_salesuser_act act 
left join 
(select creator_id,customer_id,count(1) as cover_cnt,max(call_date) as call_date
from call_record
where call_date between 20170201 and 20170215
and deleteflag = 0
and customer_id <> 0 
and call_type = 0 
and time_long > 10
group by creator_id,customer_id) call 
on act.sales_id = call.creator_id
left join dw_erp_d_customer_base cust 
on call.customer_id = cust.id 
and cust.p_date = 20170215
join dim_org 
on act.org_id = dim_org.d_org_id
and dim_org.branch_id = 10174
where p_date = 20170215 
and is_work_on = 1
and is_sales_agent = 1;

select sales_id,sales_name,position_id,position_name,act.org_id,act.org_name,cust.name ,call.call_date,call.cover_cnt
from dw_erp_d_salesuser_act act 
left join 
(select creator_id,customer_id,count(1) as cover_cnt,max(call_date) as call_date
from call_record
where call_date between 20170201 and 20170215
and deleteflag = 0
and customer_id <> 0 
and call_type = 0 
and time_long > 10
group by creator_id,customer_id) call 
on act.sales_id = call.creator_id
left join dw_erp_d_customer_base cust 
on call.customer_id = cust.id 
and cust.p_date = 20170215
join dim_org 
on act.org_id = dim_org.d_org_id
and dim_org.branch_id = 10174
where act.p_date = 20170215 
and is_work_on = 1
and is_sales_agent = 1
and sales_id in (30843,28640);

select sales_id,sales_name,position_id,position_name,org_id,org_name,call.cust_cnt
from dw_erp_d_salesuser_act act 
left join 
(select creator_id,count(distinct customer_id) as cust_cnt 
from call_record
where call_date between 20170201 and 20170215
and deleteflag = 0
and customer_id <> 0 
and call_type = 0 
and time_long > 10
group by creator_id) call 
on act.sales_id = call.creator_id
where p_date = 20170131 
and is_work_on = 1
and is_sales_agent = 1
and sales_id in (30843,28640);