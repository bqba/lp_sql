create table dw_erp_w_salesuser_cust_act(
d_date int comment '统计日期',
sales_id int comment '销售顾问主键',
sales_name string comment '销售顾问姓名',
entrydate string comment '入职日期',
formaldate string comment '转正日期',
position_id int comment '岗位主键',
position_name string comment '岗位名称',
position_channel string comment '岗位渠道',
position_channel_name string comment '岗位渠道名称',
position_level string comment '岗位级别',
org_id int comment '组织主键',
org_name string comment '组织名称',
repertory_industry string comment '深耕行业',
parent_salesuser_id int comment '汇报对象主键',
parent_salesuser_name string comment '汇报对象名称',
parent_salesuser_id_list string comment '汇报对象及所有上级列表',
grade int comment '级次',
is_sales_agent int comment '是否基础销售',
is_work_on int comment '是否在岗',
outer_behavior_cust_cnt int comment '动态客户数量',
outer_behavior_cust_sr_cnt int comment '精英动态客户数量',
outer_behavior_cust_jr_cnt int comment '白领动态客户数量',
outer_behavior_cust_cover_cnt int comment '动态客户覆盖数',
outer_behavior_cust_sr_cover_cnt int comment '精英动态客户覆盖数',
outer_behavior_cust_jr_cover_cnt int comment '白领动态客户覆盖数',
outer_behavior_cust_cover_valid_cnt int comment '动态客户有效覆盖数',
outer_behavior_cust_sr_cover_valid_cnt int comment '精英动态客户有效覆盖数',
outer_behavior_cust_jr_cover_valid_cnt int comment '白领动态客户有效覆盖数',
outer_behavior_cust_link_cnt int comment '动态客户有联系方式客户量',
outer_behavior_cust_sr_link_cnt int comment '精英动态客户有联系方式客户量',
outer_behavior_cust_jr_link_cnt int comment '白领动态客户有联系方式客户量',
outer_behavior_cust_link_add_cnt int comment '动态客户联系方式数量',
outer_behavior_cust_sr_link_add_cnt int comment '精英动态客户联系方式数量',
outer_behavior_cust_jr_link_add_cnt int comment '白领动态客户联系方式数量',
creation_timestamp timestamp comment '时间戳'
) comment '销售顾问客户覆盖周表'
partitioned by (p_date int);

create table dw_erp_w_salesuser_cust_act(
d_date int comment '统计日期',
sales_id int comment '销售顾问主键',
sales_name varchar(100) comment '销售顾问姓名',
entrydate varchar(100) comment '入职日期',
formaldate varchar(100) comment '转正日期',
position_id int comment '岗位主键',
position_name varchar(100) comment '岗位名称',
position_channel varchar(100) comment '岗位渠道',
position_channel_name varchar(100) comment '岗位渠道名称',
position_level varchar(100) comment '岗位级别',
org_id int comment '组织主键',
org_name varchar(100) comment '组织名称',
repertory_industry varchar(100) comment '深耕行业',
parent_salesuser_id int comment '汇报对象主键',
parent_salesuser_name varchar(100) comment '汇报对象名称',
parent_salesuser_id_list varchar(100) comment '汇报对象及所有上级列表',
grade int comment '级次',
is_sales_agent int comment '是否基础销售',
is_work_on int comment '是否在岗',
outer_behavior_cust_cnt int comment '动态客户数量',
outer_behavior_cust_sr_cnt int comment '精英动态客户数量',
outer_behavior_cust_jr_cnt int comment '白领动态客户数量',
outer_behavior_cust_cover_cnt int comment '动态客户覆盖数',
outer_behavior_cust_sr_cover_cnt int comment '精英动态客户覆盖数',
outer_behavior_cust_jr_cover_cnt int comment '白领动态客户覆盖数',
outer_behavior_cust_cover_valid_cnt int comment '动态客户有效覆盖数',
outer_behavior_cust_sr_cover_valid_cnt int comment '精英动态客户有效覆盖数',
outer_behavior_cust_jr_cover_valid_cnt int comment '白领动态客户有效覆盖数',
outer_behavior_cust_link_cnt int comment '动态客户有联系方式客户量',
outer_behavior_cust_sr_link_cnt int comment '精英动态客户有联系方式客户量',
outer_behavior_cust_jr_link_cnt int comment '白领动态客户有联系方式客户量',
outer_behavior_cust_link_add_cnt int comment '动态客户联系方式数量',
outer_behavior_cust_sr_link_add_cnt int comment '精英动态客户联系方式数量',
outer_behavior_cust_jr_link_add_cnt int comment '白领动态客户联系方式数量',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,sales_id,position_channel)
) comment '销售顾问客户覆盖周表';

insert overwrite table dw_erp_w_salesuser_cust_act_pre partition(p_date=$date$)
select
	$date$ as d_date,
	nvl(base.id,-1) as sales_id,
	nvl(base.name,'未知') as sales_name,
	nvl(base.entrydate,'1900-01-01') as entrydate,
	nvl(base.formaldate,'1900-01-01')  as formaldate,
	nvl(base.position_id,-1) as  position_id,
	nvl(base.position_name ,'未知') as position_name,
	nvl(base.position_channel,'-1') as position_channel ,
	case base.position_channel when 'A0000484' then 's' 
							   when 'A0000485' then 'ss'
							   when 'A0000486' then 'ka'
							   when 'A0000821' then 'js'
	else '未知' end as position_channel_name ,
	nvl(base.position_level ,'-1')  as position_level,
	nvl(base.org_id,-1)  as org_id,
	nvl(regexp_replace(base.org_name,'	',' ') ,'未知') as org_name,
	nvl(base.repertory_industry ,'-1')  as repertory_industry,
	nvl(base.parent_salesuser_id,-1)  as parent_salesuser_id,
	nvl(base.parent_salesuser_name ,'未知') as parent_salesuser_name,
	nvl(base.parent_salesuser_id_list ,'-1') as parent_salesuser_id_list,
	nvl(base.grade,-1) as grade ,
	nvl(base.is_sales_agent,-1) as is_sales_agent,
	nvl(base.is_work_on,-1) as is_work_on,
	nvl(behavior_main.outer_behavior_cust_cnt,0) as outer_behavior_cust_cnt,
	nvl(behavior_main.outer_behavior_cust_sr_cnt,0) as outer_behavior_cust_sr_cnt,
	nvl(behavior_main.outer_behavior_cust_jr_cnt,0) as outer_behavior_cust_jr_cnt,
	nvl(behavior_main.outer_behavior_cust_cover_cnt,0) as outer_behavior_cust_cover_cnt,
	nvl(behavior_main.outer_behavior_cust_sr_cover_cnt,0) as outer_behavior_cust_sr_cover_cnt,
	nvl(behavior_main.outer_behavior_cust_jr_cover_cnt,0) as outer_behavior_cust_jr_cover_cnt,
	nvl(behavior_main.outer_behavior_cust_cover_valid_cnt,0) as outer_behavior_cust_cover_valid_cnt,
	nvl(behavior_main.outer_behavior_cust_sr_cover_valid_cnt,0) as outer_behavior_cust_sr_cover_valid_cnt,
	nvl(behavior_main.outer_behavior_cust_jr_cover_valid_cnt,0) as outer_behavior_cust_jr_cover_valid_cnt,
	nvl(behavior_main.outer_behavior_cust_link_cnt,0) as outer_behavior_cust_link_cnt,
	nvl(behavior_main.outer_behavior_cust_sr_link_cnt,0) as outer_behavior_cust_sr_link_cnt,
	nvl(behavior_main.outer_behavior_cust_jr_link_cnt,0) as outer_behavior_cust_jr_link_cnt,
	nvl(behavior_main.outer_behavior_cust_link_add_cnt,0) as outer_behavior_cust_link_add_cnt,
	nvl(behavior_main.outer_behavior_cust_sr_link_add_cnt,0) as outer_behavior_cust_sr_link_add_cnt,
	nvl(behavior_main.outer_behavior_cust_jr_link_add_cnt,0) as outer_behavior_cust_jr_link_add_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp
from 
(select sales_id as id ,
		sales_name as name ,
		entrydate ,
		formaldate ,
		position_id ,
		position_name ,
		position_channel ,
		position_level ,
		org_id ,
		org_name ,
		repertory_industry ,
		parent_salesuser_id ,
		parent_salesuser_name ,
		parent_salesuser_id_list ,
		grade ,
 		is_work_on,is_sales_agent,
		all_income_m
   from  dw_erp_d_salesuser_act
  where p_date = $date$
) base 
left join 
(
select 
 	cust3.sales_user_id,
 	sum(is_outer_active) as outer_behavior_cust_cnt,
	sum(is_sr) as outer_behavior_cust_sr_cnt,
	sum(is_jr) as outer_behavior_cust_jr_cnt,
	sum(nvl(is_cover,0)) as outer_behavior_cust_cover_cnt,
	sum(case when is_sr = 1 then nvl(is_cover,0) else 0 end) as outer_behavior_cust_sr_cover_cnt,
	sum(case when is_jr = 1 then nvl(is_cover,0) else 0 end) as outer_behavior_cust_jr_cover_cnt,
	sum(nvl(is_valid_cover,0)) as outer_behavior_cust_cover_valid_cnt,
	sum(case when is_sr = 1 then nvl(is_valid_cover,0) else 0 end) as outer_behavior_cust_sr_cover_valid_cnt,
	sum(case when is_jr = 1 then nvl(is_valid_cover,0) else 0 end) as outer_behavior_cust_jr_cover_valid_cnt,
	sum(nvl(is_link,0)) as outer_behavior_cust_link_cnt,
	sum(case when is_sr = 1 then nvl(is_link,0) else 0 end) as outer_behavior_cust_sr_link_cnt,
	sum(case when is_jr = 1 then nvl(is_link,0) else 0 end) as outer_behavior_cust_jr_link_cnt,
	sum(nvl(is_add,0)) as outer_behavior_cust_link_add_cnt,
	sum(case when is_sr = 1 then nvl(is_add,0) else 0 end) as outer_behavior_cust_sr_link_add_cnt,
	sum(case when is_jr = 1 then nvl(is_add,0) else 0 end) as outer_behavior_cust_jr_link_add_cnt 	
from (
select
	cust.id as customer_id,
	base.sales_user_id,
	case when sum(1) > 0 then 1 else 0 end as is_outer_active,
	case when sum(is_outer_active_sr) > 0 then 1 else 0 end as is_sr,
	case when sum(is_outer_active_sr) = 0 and sum(1) > 0 then 1 else 0 end as is_jr
from dw_erp_d_customer_behavior cust
join dw_erp_d_customer_base base 
on cust.id = base.id
and base.p_date = $date$
and base.company_certificate != ''
and base.delete_flag = 0
and base.ecomp_version in (0,1,4,5,6)
where cust.p_date between {{delta(date,-6)}} and $date$
group by cust.id,base.sales_user_id
) behavior
left join 
(  select call.customer_id,call.creator_id
		   case when sum(is_cover) > 0 then 1 else 0 end is_cover,
		   case when sum(is_valid_cover) > 0 then 1 else 0 end is_valid_cover
	 from (
		 select customer_id,creator_id,
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
on behavior.customer_id = cover.customer_id
and behavior.sales_user_id = cover.creator_id
left join 
(
	select customer_id,
			case when sum(is_add) > 0 then 1 else 0 end as is_add,
			case when sum(is_link) > 0 then 1 else 0 end as is_link
	  from 
	(select linkman_id,
		   customer_id,
		   case when substr(regexp_replace(createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ then 1 else 0 end as is_add,
		   1 as is_link 
	  from linkman
	 where substr(regexp_replace(createtime,'-',''),1,8) <= $date$
	 ) linkman 
	 group by customer_id
) link 
on behavior.customer_id = link.customer_id
group by behavior.sales_user_id
) behavior_main
on base.id = behavior_main.sales_user_id;



create table dw_erp_m_salesuser_cust_act(
d_date int comment '统计日期',
sales_id int comment '销售顾问主键',
sales_name string comment '销售顾问姓名',
entrydate string comment '入职日期',
formaldate string comment '转正日期',
position_id int comment '岗位主键',
position_name string comment '岗位名称',
position_channel string comment '岗位渠道',
position_channel_name string comment '岗位渠道名称',
position_level string comment '岗位级别',
org_id int comment '组织主键',
org_name string comment '组织名称',
repertory_industry string comment '深耕行业',
parent_salesuser_id int comment '汇报对象主键',
parent_salesuser_name string comment '汇报对象名称',
parent_salesuser_id_list string comment '汇报对象及所有上级列表',
grade int comment '级次',
is_sales_agent int comment '是否基础销售',
is_work_on int comment '是否在岗',
outer_behavior_cust_cnt int comment '动态客户数量',
outer_behavior_cust_sr_cnt int comment '精英动态客户数量',
outer_behavior_cust_jr_cnt int comment '白领动态客户数量',
outer_behavior_cust_cover_cnt int comment '动态客户覆盖数',
outer_behavior_cust_sr_cover_cnt int comment '精英动态客户覆盖数',
outer_behavior_cust_jr_cover_cnt int comment '白领动态客户覆盖数',
outer_behavior_cust_cover_valid_cnt int comment '动态客户有效覆盖数',
outer_behavior_cust_sr_cover_valid_cnt int comment '精英动态客户有效覆盖数',
outer_behavior_cust_jr_cover_valid_cnt int comment '白领动态客户有效覆盖数',
outer_behavior_cust_link_cnt int comment '动态客户有联系方式客户量',
outer_behavior_cust_sr_link_cnt int comment '精英动态客户有联系方式客户量',
outer_behavior_cust_jr_link_cnt int comment '白领动态客户有联系方式客户量',
outer_behavior_cust_link_add_cnt int comment '动态客户联系方式数量',
outer_behavior_cust_sr_link_add_cnt int comment '精英动态客户联系方式数量',
outer_behavior_cust_jr_link_add_cnt int comment '白领动态客户联系方式数量',
creation_timestamp timestamp comment '时间戳'
) comment '销售顾问客户覆盖月表'
partitioned by (p_date int);

create table dw_erp_m_salesuser_cust_act(
d_date int comment '统计日期',
sales_id int comment '销售顾问主键',
sales_name varchar(100) comment '销售顾问姓名',
entrydate varchar(100) comment '入职日期',
formaldate varchar(100) comment '转正日期',
position_id int comment '岗位主键',
position_name varchar(100) comment '岗位名称',
position_channel varchar(100) comment '岗位渠道',
position_channel_name varchar(100) comment '岗位渠道名称',
position_level varchar(100) comment '岗位级别',
org_id int comment '组织主键',
org_name varchar(100) comment '组织名称',
repertory_industry varchar(100) comment '深耕行业',
parent_salesuser_id int comment '汇报对象主键',
parent_salesuser_name varchar(100) comment '汇报对象名称',
parent_salesuser_id_list varchar(100) comment '汇报对象及所有上级列表',
grade int comment '级次',
is_sales_agent int comment '是否基础销售',
is_work_on int comment '是否在岗',
outer_behavior_cust_cnt int comment '动态客户数量',
outer_behavior_cust_sr_cnt int comment '精英动态客户数量',
outer_behavior_cust_jr_cnt int comment '白领动态客户数量',
outer_behavior_cust_cover_cnt int comment '动态客户覆盖数',
outer_behavior_cust_sr_cover_cnt int comment '精英动态客户覆盖数',
outer_behavior_cust_jr_cover_cnt int comment '白领动态客户覆盖数',
outer_behavior_cust_cover_valid_cnt int comment '动态客户有效覆盖数',
outer_behavior_cust_sr_cover_valid_cnt int comment '精英动态客户有效覆盖数',
outer_behavior_cust_jr_cover_valid_cnt int comment '白领动态客户有效覆盖数',
outer_behavior_cust_link_cnt int comment '动态客户有联系方式客户量',
outer_behavior_cust_sr_link_cnt int comment '精英动态客户有联系方式客户量',
outer_behavior_cust_jr_link_cnt int comment '白领动态客户有联系方式客户量',
outer_behavior_cust_link_add_cnt int comment '动态客户联系方式数量',
outer_behavior_cust_sr_link_add_cnt int comment '精英动态客户联系方式数量',
outer_behavior_cust_jr_link_add_cnt int comment '白领动态客户联系方式数量',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,sales_id,position_channel)
) comment '销售顾问客户覆盖月表';


insert overwrite table dw_erp_m_salesuser_cust_act partition(p_date=$date$)
select
	$date$ as d_date,
	nvl(base.id,-1) as sales_id,
	nvl(base.name,'未知') as sales_name,
	nvl(base.entrydate,'1900-01-01') as entrydate,
	nvl(base.formaldate,'1900-01-01')  as formaldate,
	nvl(base.position_id,-1) as  position_id,
	nvl(base.position_name ,'未知') as position_name,
	nvl(base.position_channel,'-1') as position_channel ,
	case base.position_channel when 'A0000484' then 's' 
							   when 'A0000485' then 'ss'
							   when 'A0000486' then 'ka'
							   when 'A0000821' then 'js'
	else '未知' end as position_channel_name ,
	nvl(base.position_level ,'-1')  as position_level,
	nvl(base.org_id,-1)  as org_id,
	nvl(regexp_replace(base.org_name,'	',' ') ,'未知') as org_name,
	nvl(base.repertory_industry ,'-1')  as repertory_industry,
	nvl(base.parent_salesuser_id,-1)  as parent_salesuser_id,
	nvl(base.parent_salesuser_name ,'未知') as parent_salesuser_name,
	nvl(base.parent_salesuser_id_list ,'-1') as parent_salesuser_id_list,
	nvl(base.grade,-1) as grade ,
	nvl(base.is_sales_agent,-1) as is_sales_agent,
	nvl(base.is_work_on,-1) as is_work_on,
	nvl(behavior_main.outer_behavior_cust_cnt,0) as outer_behavior_cust_cnt,
	nvl(behavior_main.outer_behavior_cust_sr_cnt,0) as outer_behavior_cust_sr_cnt,
	nvl(behavior_main.outer_behavior_cust_jr_cnt,0) as outer_behavior_cust_jr_cnt,
	nvl(behavior_main.outer_behavior_cust_cover_cnt,0) as outer_behavior_cust_cover_cnt,
	nvl(behavior_main.outer_behavior_cust_sr_cover_cnt,0) as outer_behavior_cust_sr_cover_cnt,
	nvl(behavior_main.outer_behavior_cust_jr_cover_cnt,0) as outer_behavior_cust_jr_cover_cnt,
	nvl(behavior_main.outer_behavior_cust_cover_valid_cnt,0) as outer_behavior_cust_cover_valid_cnt,
	nvl(behavior_main.outer_behavior_cust_sr_cover_valid_cnt,0) as outer_behavior_cust_sr_cover_valid_cnt,
	nvl(behavior_main.outer_behavior_cust_jr_cover_valid_cnt,0) as outer_behavior_cust_jr_cover_valid_cnt,
	nvl(behavior_main.outer_behavior_cust_link_cnt,0) as outer_behavior_cust_link_cnt,
	nvl(behavior_main.outer_behavior_cust_sr_link_cnt,0) as outer_behavior_cust_sr_link_cnt,
	nvl(behavior_main.outer_behavior_cust_jr_link_cnt,0) as outer_behavior_cust_jr_link_cnt,
	nvl(behavior_main.outer_behavior_cust_link_add_cnt,0) as outer_behavior_cust_link_add_cnt,
	nvl(behavior_main.outer_behavior_cust_sr_link_add_cnt,0) as outer_behavior_cust_sr_link_add_cnt,
	nvl(behavior_main.outer_behavior_cust_jr_link_add_cnt,0) as outer_behavior_cust_jr_link_add_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp
from 
(select sales_id as id ,
		sales_name as name ,
		entrydate ,
		formaldate ,
		position_id ,
		position_name ,
		position_channel ,
		position_level ,
		org_id ,
		org_name ,
		repertory_industry ,
		parent_salesuser_id ,
		parent_salesuser_name ,
		parent_salesuser_id_list ,
		grade ,
 		is_work_on,is_sales_agent,
		all_income_m
   from  dw_erp_d_salesuser_act
  where p_date = $date$
) base 
left join 
(
select 
 	cust3.sales_user_id,
 	sum(is_outer_active) as outer_behavior_cust_cnt,
	sum(is_sr) as outer_behavior_cust_sr_cnt,
	sum(is_jr) as outer_behavior_cust_jr_cnt,
	sum(nvl(is_cover,0)) as outer_behavior_cust_cover_cnt,
	sum(case when is_sr = 1 then nvl(is_cover,0) else 0 end) as outer_behavior_cust_sr_cover_cnt,
	sum(case when is_jr = 1 then nvl(is_cover,0) else 0 end) as outer_behavior_cust_jr_cover_cnt,
	sum(nvl(is_valid_cover,0)) as outer_behavior_cust_cover_valid_cnt,
	sum(case when is_sr = 1 then nvl(is_valid_cover,0) else 0 end) as outer_behavior_cust_sr_cover_valid_cnt,
	sum(case when is_jr = 1 then nvl(is_valid_cover,0) else 0 end) as outer_behavior_cust_jr_cover_valid_cnt,
	sum(nvl(is_link,0)) as outer_behavior_cust_link_cnt,
	sum(case when is_sr = 1 then nvl(is_link,0) else 0 end) as outer_behavior_cust_sr_link_cnt,
	sum(case when is_jr = 1 then nvl(is_link,0) else 0 end) as outer_behavior_cust_jr_link_cnt,
	sum(nvl(is_add,0)) as outer_behavior_cust_link_add_cnt,
	sum(case when is_sr = 1 then nvl(is_add,0) else 0 end) as outer_behavior_cust_sr_link_add_cnt,
	sum(case when is_jr = 1 then nvl(is_add,0) else 0 end) as outer_behavior_cust_jr_link_add_cnt 	
from (
select
	cust.id as customer_id,
	case when sum(1) > 0 then 1 else 0 end as is_outer_active,
	case when sum(is_outer_active_sr) > 0 then 1 else 0 end as is_sr,
	case when sum(is_outer_active_sr) = 0 and sum(1) > 0 then 1 else 0 end as is_jr
from dw_erp_d_customer_behavior cust
join dw_erp_d_customer_base base 
on cust.id = base.id
and base.p_date = $date$
and base.company_certificate != ''
and base.delete_flag = 0
and base.ecomp_version in (0,1,4,5,6)
where cust.p_date between {{date[:6]+'01'}} and $date$
group by cust.id
) behavior
left join 
(  select call.customer_id,
		   case when sum(is_cover) > 0 then 1 else 0 end is_cover,
		   case when sum(is_valid_cover) > 0 then 1 else 0 end is_valid_cover
	 from (
		 select customer_id,creator_id,
		 		case when time_long >= 10 then 1 else 0 end is_cover,
		 		case when time_long >= 45 then 1 else 0 end is_valid_cover			
		   from call_record 
		  where customer_id >0
		  	and call_type = 0
		  	and deleteflag = 0
			and call_date between {{delta(date,-6)}} and $date$
	 	) call 
	join 
	(
		select customer_id,sales_user_id
		  from (
			select
				cust.id as customer_id,
				cust.sales_user_id,
				row_number()over(distribute by id sort by p_date desc) as rn
			from dw_erp_d_customer_behavior cust
			where p_date between {{date[:6]+'01'}} and $date$
		  ) cust2 
		 where rn = 1
	 ) cust3
	 on call.customer_id = cust3.customer_id
	 and call.creator_id = cust3.sales_user_id
	 group by call.customer_id
) cover 
on behavior.customer_id = cover.customer_id
left join 
(
	select customer_id,
			case when sum(is_add) > 0 then 1 else 0 end as is_add,
			case when sum(is_link) > 0 then 1 else 0 end as is_link
	  from 
	(select linkman_id,
		   customer_id,
		   case when substr(regexp_replace(createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$ then 1 else 0 end as is_add,
		   1 as is_link 
	  from linkman
	 where substr(regexp_replace(createtime,'-',''),1,8) <= $date$
	 ) linkman 
	 group by customer_id
) link 
on behavior.customer_id = link.customer_id
join 
(
	select customer_id,sales_user_id
	  from (
		select
			cust.id as customer_id,
			cust.sales_user_id,
			row_number()over(distribute by id sort by p_date desc) as rn
		from dw_erp_d_customer_behavior cust
		where p_date between {{date[:6]+'01'}} and $date$
	  ) cust2 
	 where rn = 1
 ) cust3
on behavior.customer_id = cust3.customer_id
group by cust3.sales_user_id
) behavior_main
on base.id = behavior_main.sales_user_id;