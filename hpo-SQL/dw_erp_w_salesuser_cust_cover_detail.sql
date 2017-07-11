create table dw_erp_w_salesuser_cust_cover_detail
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name string comment '客户名称',
sales_id int comment '销售ID',
sales_name string comment '销售名称',
org_id int comment '组织ID',
org_name string comment '组织名称',
outer_behavior_cnt int comment '动态总数',
outer_behavior_sr_cnt int comment '精英动态数',
outer_behavior_jr_cnt int comment '白领动态数',
outer_behavior_fresh_cnt int comment '刷新动态数',
outer_behavior_cover_cnt int comment '覆盖次数',
outer_behavior_cover_valid_cnt int comment '有效覆盖次数',
creation_timestamp timestamp comment '时间戳'
) comment '外部动态客户覆盖明细-周'
partitioned by (p_date int);


alter table dw_erp_w_salesuser_cust_cover_detail add columns(
is_sr int comment '是否有精英动态',
is_jr int comment '是否有白领动态',
is_cover int comment '是否覆盖',
is_valid_cover int comment '是否有效覆盖'
);

alter table dw_erp_m_salesuser_cust_cover_detail add columns(
is_sr int comment '是否有精英动态',
is_jr int comment '是否有白领动态',
is_cover int comment '是否覆盖',
is_valid_cover int comment '是否有效覆盖'
);

insert overwrite table dw_erp_w_salesuser_cust_cover_detail partition(p_date = $date$)
select 
	$date$ as d_date,
	cust_behavior.customer_id,
	cust_behavior.customer_name,
	cust_behavior.sales_id,
	cust_behavior.sales_name,
	cust_behavior.org_id,
	cust_behavior.org_name,
	cust_behavior.outer_behavior_cnt,
	cust_behavior.outer_behavior_sr_cnt,
	cust_behavior.outer_behavior_jr_cnt,
	cust_behavior.outer_behavior_fresh_cnt,
	nvl(cover.outer_behavior_cover_cnt,0) as outer_behavior_cover_cnt,
	nvl(cover.outer_behavior_cover_valid_cnt,0) as outer_behavior_cover_valid_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp,
	case when cust_behavior.outer_behavior_sr_cnt > 0 then 1 else 0 end as is_sr,
	case when cust_behavior.outer_behavior_sr_cnt = 0 and  cust_behavior.outer_behavior_jr_cnt > 0 then 1 else 0 end as is_jr,
	case when nvl(cover.outer_behavior_cover_cnt,0) > 0  then 1 else 0 end as is_cover,
	case when nvl(cover.outer_behavior_cover_valid_cnt,0) > 0 then 1 else 0 end as is_valid_cover
from (
		select
			   cust.id as customer_id,
			   cust3.sales_id as sales_id,
			   cust.name as customer_name,
			   cust3.sales_name as sales_name,
			   cust3.org_id as org_id,
			   cust3.org_name as org_name,
			   case when sum(1) > 0 then 1 else 0 end as is_outer_active,
			   sum(outer_sr_job_cnt) + sum(outer_jr_job_cnt) as outer_behavior_cnt,
			   sum(outer_sr_job_cnt) as outer_behavior_sr_cnt,
			   sum(outer_jr_job_cnt) as outer_behavior_jr_cnt,
			   0 as outer_behavior_fresh_cnt
		from dw_erp_d_customer_behavior cust
		join dw_erp_d_customer_base base 
		on cust.id = base.id
		and base.p_date = $date$
		and base.company_certificate != ''
		and base.delete_flag = 0
		and base.ecomp_version in (0,1,4,5,6)
		and cust.sales_user_id is not null
		join  (
			  select customer_id,
					  cust2.sales_id,
					  salesuser.sales_name ,
					  salesuser.org_id ,
					  salesuser.org_name
			    from (
			   select
			    cust.id as customer_id,
			    cust.sales_user_id as sales_id,
			    row_number()over(distribute by id sort by p_date desc) as rn
			   from dw_erp_d_customer_behavior cust
			   where p_date between {{delta(date,-6)}} and $date$
			    ) cust2 
			    left join dw_erp_d_salesuser_act salesuser 
			    on cust2.sales_id = salesuser.sales_id
			    and salesuser.p_date = $date$ 
			   where rn = 1
			     and cust2.sales_id is not null 
			  ) cust3
		on cust.id = cust3.customer_id 
		where cust.p_date between {{delta(date,-6)}} and $date$
		group by cust.id,
				 cust3.sales_id,
				 cust.name,
				 cust3.sales_name,
				 cust3.org_id,
				 cust3.org_name
		) cust_behavior
left join 
(
 select call.customer_id,
		call.creator_id,
		sum(is_cover) as outer_behavior_cover_cnt,
		sum(is_valid_cover) as outer_behavior_cover_valid_cnt
  from (
   select customer_id,
   		  creator_id,
     case when time_long >= 10 then 1 else 0 end is_cover,
     case when time_long >= 45 then 1 else 0 end is_valid_cover   
     from call_record 
    where customer_id >0
     and call_type = 0
     and deleteflag = 0
     and call_date between {{delta(date,-6)}} and $date$
   ) call 
  group by call.customer_id,call.creator_id
) cover 
on cover.customer_id = cust_behavior.customer_id
and cover.creator_id = cust_behavior.sales_id;



create table dw_erp_w_salesuser_cust_cover_detail
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name varchar(100) comment '客户名称',
sales_id int comment '销售ID',
sales_name varchar(100) comment '销售名称',
org_id int comment '组织ID',
org_name varchar(100) comment '组织名称',
outer_behavior_cnt int comment '动态总数',
outer_behavior_sr_cnt int comment '精英动态数',
outer_behavior_jr_cnt int comment '白领动态数',
outer_behavior_fresh_cnt int comment '刷新动态数',
outer_behavior_cover_cnt int comment '覆盖次数',
outer_behavior_cover_valid_cnt int comment '有效覆盖次数',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,sales_id,customer_id)
) comment '外部动态客户覆盖明细-周';





create table dw_erp_m_salesuser_cust_cover_detail
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name string comment '客户名称',
sales_id int comment '销售ID',
sales_name string comment '销售名称',
org_id int comment '组织ID',
org_name string comment '组织名称',
outer_behavior_cnt int comment '动态总数',
outer_behavior_sr_cnt int comment '精英动态数',
outer_behavior_jr_cnt int comment '白领动态数',
outer_behavior_fresh_cnt int comment '刷新动态数',
outer_behavior_cover_cnt int comment '覆盖次数',
outer_behavior_cover_valid_cnt int comment '有效覆盖次数',
creation_timestamp timestamp comment '时间戳'
) comment '外部动态客户覆盖明细-月'
partitioned by (p_date int);


insert overwrite table dw_erp_m_salesuser_cust_cover_detail partition(p_date = $date$)
select 
	$date$ as d_date,
	cust_behavior.customer_id,
	cust_behavior.customer_name,
	cust_behavior.sales_id,
	cust_behavior.sales_name,
	cust_behavior.org_id,
	cust_behavior.org_name,
	cust_behavior.outer_behavior_cnt,
	cust_behavior.outer_behavior_sr_cnt,
	cust_behavior.outer_behavior_jr_cnt,
	cust_behavior.outer_behavior_fresh_cnt,
	nvl(cover.outer_behavior_cover_cnt,0) as outer_behavior_cover_cnt,
	nvl(cover.outer_behavior_cover_valid_cnt,0) as outer_behavior_cover_valid_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp,
	case when cust_behavior.outer_behavior_sr_cnt > 0 then 1 else 0 end as is_sr,
	case when cust_behavior.outer_behavior_sr_cnt = 0 and  cust_behavior.outer_behavior_jr_cnt > 0 then 1 else 0 end as is_jr,
	case when nvl(cover.outer_behavior_cover_cnt,0) > 0  then 1 else 0 end as is_cover,
	case when nvl(cover.outer_behavior_cover_valid_cnt,0) > 0 then 1 else 0 end as is_valid_cover
from (
		select
			   cust.id as customer_id,
			   cust3.sales_id as sales_id,
			   cust.name as customer_name,
			   cust3.sales_name as sales_name,
			   cust3.org_id as org_id,
			   cust3.org_name as org_name,
			   case when sum(1) > 0 then 1 else 0 end as is_outer_active,
			   sum(outer_sr_job_cnt) + sum(outer_jr_job_cnt) as outer_behavior_cnt,
			   sum(outer_sr_job_cnt) as outer_behavior_sr_cnt,
			   sum(outer_jr_job_cnt) as outer_behavior_jr_cnt,
			   0 as outer_behavior_fresh_cnt
		from dw_erp_d_customer_behavior cust
		join dw_erp_d_customer_base base 
		on cust.id = base.id
		and base.p_date = $date$
		and base.company_certificate != ''
		and base.delete_flag = 0
		and base.ecomp_version in (0,1,4,5,6)
		and cust.sales_user_id is not null 
		join  (
			  select customer_id,
					  cust2.sales_id ,
					  salesuser.sales_name ,
					  salesuser.org_id ,
					  salesuser.org_name
			    from (
			   select
			    cust.id as customer_id,
			    cust.sales_user_id as sales_id,
			    row_number()over(distribute by id sort by p_date desc) as rn
			   from dw_erp_d_customer_behavior cust
			   where p_date between {{date[:6]+'01'}} and $date$ 
			    ) cust2 
			    left join dw_erp_d_salesuser_act salesuser 
			    on cust2.sales_id = salesuser.sales_id
			    and salesuser.p_date = $date$ 
			   where rn = 1
			     and cust2.sales_id is not null
			  ) cust3
		on cust.id = cust3.customer_id 
		where cust.p_date between {{date[:6]+'01'}} and $date$
		group by cust.id,
				 cust3.sales_id,
				 cust.name,
				 cust3.sales_name,
				 cust3.org_id,
				 cust3.org_name
		) cust_behavior
left join 
(
 select call.customer_id,
		call.creator_id,
		sum(is_cover) as outer_behavior_cover_cnt,
		sum(is_valid_cover) as outer_behavior_cover_valid_cnt
  from (
   select customer_id,
   		  creator_id,
     case when time_long >= 10 then 1 else 0 end is_cover,
     case when time_long >= 45 then 1 else 0 end is_valid_cover   
     from call_record 
    where customer_id >0
     and call_type = 0
     and deleteflag = 0
     and call_date between {{date[:6]+'01'}} and $date$
   ) call 
  group by call.customer_id,call.creator_id
) cover 
on cover.customer_id = cust_behavior.customer_id
and cover.creator_id = cust_behavior.sales_id;

create table dw_erp_m_salesuser_cust_cover_detail
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name varchar(100) comment '客户名称',
sales_id int comment '销售ID',
sales_name varchar(100) comment '销售名称',
org_id int comment '组织ID',
org_name varchar(100) comment '组织名称',
outer_behavior_cnt int comment '动态总数',
outer_behavior_sr_cnt int comment '精英动态数',
outer_behavior_jr_cnt int comment '白领动态数',
outer_behavior_fresh_cnt int comment '刷新动态数',
outer_behavior_cover_cnt int comment '覆盖次数',
outer_behavior_cover_valid_cnt int comment '有效覆盖次数',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,sales_id,customer_id)
) comment '外部动态客户覆盖明细-月';




