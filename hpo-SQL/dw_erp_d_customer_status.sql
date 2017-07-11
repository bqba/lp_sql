create table if not exists dw_erp_d_customer_status 
( 
d_date int,
customer_id int,
customer_name string,
comp_industry_code string,
comp_industry_name string,
sales_id int,
sales_name string,
sales_group_id int,
sales_group_name string,
position_level string,
position_level_name string,
org_id int,
org_name string,
lpt_service_effect_date string,
lpt_service_expired_date string,
is_lpt_in_service int,
is_lpt_expire int,
is_lpt_break int,
creation_timestamp timestamp
)
partitioned by (p_date int);

insert overwrite table dw_erp_d_customer_status partition (p_date = $date$)
select 
			$date$ as d_date,
			cus.id as customer_id,
			cus.name as customer_name,
			cus.industry as comp_industry_code,
			nvl(dim_industry.d_main_industry,'未知') as comp_industry_name ,
			cus.sales_user_id as sales_id ,
			cus.sales_user_name as sales_name,
			nvl(sales.parent_salesuser_id,-1) as sales_group_id ,
			nvl(sales.parent_salesuser_name,'未知') as sales_group_name ,
			nvl(sales.position_level,'-1') as position_level,
			nvl(sales.position_level_name,'未知') as position_level_name,
			cus.sales_org_id as org_id,
			cus.sales_org_name as org_name,
			nvl(contract.lpt_service_effect_date, '1900-01-01') as lpt_service_effect_date,
			nvl(contract.lpt_service_expired_date,'1900-01-01') as lpt_service_expired_date,
			case when '$date$' between  regexp_replace(substr(lpt_service_effect_date,1,10),'-','')  and regexp_replace(substr(lpt_service_expired_date,1,10),'-','') then 1 else 0 end is_lpt_in_service , --是否合作中客户
			case when cal_days('$date$' ,regexp_replace(lpt_service_expired_date,'-','')) between 0 and 90  then 1 else 0 end as is_lpt_expire,--是否到期
			case when cal_days(regexp_replace(lpt_service_expired_date,'-',''),'$date$' ) between 0 and 90 then 1 else 0 end as is_lpt_break,--是否断约		
			from_unixtime(unix_timestamp()) as creation_timestamp
	from dw_erp_d_customer_base cus
	left outer join dim_industry 
	on cus.industry = dim_industry.d_ind_code
	inner join 
	(select  id, position_level,position_level_name,parent_salesuser_id,parent_salesuser_name
		from dw_erp_d_salesuser_base
	  where p_date = $date$) sales
	on cus.sales_user_id = sales.id
	inner join 
	(select customer_id,
				min(lpt_service_effect_date) lpt_service_effect_date,
				max(lpt_service_expired_date) lpt_service_expired_date
		 from dw_erp_d_contract_base
		  where p_date =  $date$
		  and subaction = 0
		  and status in (2,3)
		  and lpt_service_effect_date not in ('--','1900-01-01')
		  group by customer_id
	)  contract 
	on cus.id = contract.customer_id
   where p_date =  $date$
   ;

create table dw_erp_d_customer_status
( 
d_date int,
customer_id int,
customer_name varchar(200),
comp_industry_code varchar(20),
comp_industry_name varchar(50),
sales_id int,
sales_name varchar(50),
sales_group_id int,
sales_group_name varchar(50),
position_level varchar(50),
position_level_name varchar(50),
org_id int,
org_name varchar(200),
lpt_service_effect_date varchar(50),
lpt_service_expired_date varchar(50),
is_lpt_in_service int,
is_lpt_expire int,
is_lpt_break int,
creation_timestamp  timestamp default CURRENT_TIMESTAMP,
primary key(d_date,customer_id)
);