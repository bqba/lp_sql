task_hpo_d_salesuser_kpi_hd

华北：李冬杰 lidj@liepin.com ; wangxr@liepin.com		
华东：颜爱芳 tracy.yan@liepin.com ; wangxr@liepin.com		
华南：廖辉 hui.liao@liepin.com ; wangxr@liepin.com		
西南：王建伟 wangjwcd@liepin.com ; wangxr@liepin.com

华东区销售KPI邮件发送

select
'日期',
'销售ID',
'销售姓名',
'销售团队',
'客户覆盖数',
'客户覆盖次数',
'有效沟通电话个数',
'有效沟通电话时长(分钟)',
'有效沟通客户数',
'有效沟通率',
'注册新客户数量'
from dummy;

select 
act.d_date,
act.sales_id,
act.sales_name,
act.org_name,
nvl(cover.cover_cus_cnt,0 ) as cover_cus_cnt,
nvl(cover.cover_cus_rec_cnt,0 ) as cover_cus_rec_cnt,
nvl(cover.valid_call_rec_cnt,0 ) as valid_call_rec_cnt,
nvl(cover.valid_call_time_long,0 ) as valid_call_time_long,
nvl(cover.valid_cover_cus_cnt,0 ) as valid_cover_cus_cnt,
nvl(round(cover.valid_cover_cus_cnt / cover.cover_cus_cnt,4),0) as valid_cover_ratio,
nvl(act.input_cus_cnt,0) as input_cus_cnt
from dw_erp_d_salesuser_act act
left join (
	select 	creator_id,				
				count(distinct case when time_long > 10 then customer_id else null end) as cover_cus_cnt,
				count(case when time_long > 10 then id else null end) as cover_cus_rec_cnt,
				count(case when time_long > 45 and begin_time >='080000' and end_time <='200000' then id else null end) valid_call_rec_cnt,
				sum(case when time_long > 45 and begin_time >='080000' and end_time <='200000' and time_long/60 > 30 then 30.00 
				 		 when time_long > 45 and begin_time >='080000' and end_time <='200000' and time_long/60 <= 30 then round(time_long/60 ,2) 
				 		 else 0 end ) as valid_call_time_long,
				count(distinct case when time_long > 45 and begin_time >='080000' and end_time <='200000' then customer_id else null end) as valid_cover_cus_cnt
	  from call_record 
	where  customer_id >0
		and call_date='$date$'
	group by creator_id
) cover 
on act.sales_id = cover.creator_id
join dim_org 
on act.org_id = dim_org.d_org_id 
and dim_org.area_name = '西南区' -- 华东区，华南区，西南区
where act.p_date = $date$
and (act.is_work_on = 1 or nvl(cover.cover_cus_cnt,0 ) > 0 or input_cus_cnt > 0);




select
'日期',
'销售ID',
'销售姓名',
'销售团队',
'客户覆盖数',
'客户覆盖次数',
'有效沟通电话个数',
'有效沟通电话时长(分钟)',
'有效沟通客户数',
'有效沟通率',
'注册新客户数量'
from dummy;



select
'日期',
'销售ID',
'销售姓名',
'销售团队',
'客户覆盖数',
'客户覆盖次数',
'有效沟通电话个数',
'有效沟通电话时长(分钟)',
'有效沟通客户数',
'有效沟通率',
'注册新客户数量'
from dummy;

select 
act.d_date,
act.sales_id,
act.sales_name,
act.org_name,
nvl(cover.cover_cus_cnt,0 ) as cover_cus_cnt,
nvl(cover.cover_cus_rec_cnt,0 ) as cover_cus_rec_cnt,
nvl(cover.valid_call_rec_cnt,0 ) as valid_call_rec_cnt,
nvl(cover.valid_call_time_long,0 ) as valid_call_time_long,
nvl(cover.valid_cover_cus_cnt,0 ) as valid_cover_cus_cnt,
nvl(round(cover.valid_cover_cus_cnt / cover.cover_cus_cnt,4),0) as valid_cover_ratio,
nvl(rl.input_cus_cnt_m,0) as input_cus_cnt_m
from dw_erp_d_salesuser_act act
left join (
	select 	creator_id,				
				count(distinct case when time_long > 10 then customer_id else null end) as cover_cus_cnt,
				count(case when time_long > 10 then id else null end) as cover_cus_rec_cnt,
				count(case when time_long > 45 and begin_time >='080000' and end_time <='200000' then id else null end) valid_call_rec_cnt,
				sum(case when time_long > 45 and begin_time >='080000' and end_time <='200000' and time_long/60 > 30 then 30.00 
				 		 when time_long > 45 and begin_time >='080000' and end_time <='200000' and time_long/60 <= 30 then round(time_long/60 ,2) 
				 		 else 0 end ) as valid_call_time_long,
				count(distinct case when time_long > 45 and begin_time >='080000' and end_time <='200000' then customer_id else null end) as valid_cover_cus_cnt
	  from call_record 
	where  customer_id >0
		and call_date between {{date[:6]+'01'}} and $date$
	group by creator_id
) cover 
on act.sales_id = cover.creator_id
left join fact_h_erp_a_salesuser_real rl 
on act.sales_id = rl.sales_id
and rl.d_date = $date$
join dim_org 
on act.org_id = dim_org.d_org_id 
and dim_org.area_name = '华北区' -- 华东区，华南区，西南区
where act.p_date = $date$
and (act.is_work_on = 1 or nvl(cover.cover_cus_cnt,0 ) > 0 or nvl(rl.input_cus_cnt_m,0) > 0);




create table fact_h_erp_d_customer_cover
(
	d_date int comment ' 统计日期 ',
	sales_id int comment ' 销售顾问主键 ',
	sales_name string comment ' 销售顾问姓名 ',
	org_id int comment ' 组织主键 ',
	org_name string comment ' 组织名称 ',	
	cover_cus_cnt int comment ' 覆盖客户数 ',
	cover_cus_rec_cnt int comment ' 覆盖客户次数 ',
	valid_call_rec_cnt int comment ' 有效沟通电话个数 ',
	valid_call_time_long float comment ' 有效沟通电话时长 ',
	valid_cover_cus_cnt int comment ' 有效沟通客户数 ',	
	valid_cover_ratio float comment ' 有效沟通率 ',	
	input_cus_cnt int comment ' 注册新客户数量 ',	
	mtd_cover_cus_cnt int comment ' 月累计覆盖客户数 ',
	mtd_cover_cus_rec_cnt int comment ' 月累计覆盖客户次数 ',
	mtd_valid_call_rec_cnt int comment ' 月累计有效沟通电话个数 ',
	mtd_valid_call_time_long float comment ' 月累计有效沟通电话时长 ',
	mtd_valid_cover_cus_cnt int comment ' 月累计有效沟通客户数 ',
	mtd_valid_cover_ratio float comment ' 月累计有效沟通率 ',		
	mtd_input_cus_cnt int comment ' 月累计注册新客户数量 ',		
  	creation_timestamp timestamp comment '时间戳'
) comment '销售客户覆盖统计报表'
partitioned by (p_date int);

create table fact_h_erp_d_customer_cover
(
	d_date int comment ' 统计日期 ',
	sales_id int comment ' 销售顾问主键 ',
	sales_name varchar(50) comment ' 销售顾问姓名 ',
	org_id int comment ' 组织主键 ',
	org_name varchar(300) comment ' 组织名称 ',	
	cover_cus_cnt int comment ' 覆盖客户数 ',
	cover_cus_rec_cnt int comment ' 覆盖客户次数 ',
	valid_call_rec_cnt int comment ' 有效沟通电话个数 ',
	valid_call_time_long float comment ' 有效沟通电话时长 ',
	valid_cover_cus_cnt int comment ' 有效沟通客户数 ',	
	valid_cover_ratio float comment ' 有效沟通率 ',	
	input_cus_cnt int comment ' 注册新客户数量 ',	
	mtd_cover_cus_cnt int comment ' 月累计覆盖客户数 ',
	mtd_cover_cus_rec_cnt int comment ' 月累计覆盖客户次数 ',
	mtd_valid_call_rec_cnt int comment ' 月累计有效沟通电话个数 ',
	mtd_valid_call_time_long float comment ' 月累计有效沟通电话时长 ',
	mtd_valid_cover_cus_cnt int comment ' 月累计有效沟通客户数 ',
	mtd_valid_cover_ratio float comment ' 月累计有效沟通率 ',		
	mtd_input_cus_cnt int comment ' 月累计注册新客户数量 ',		
  	creation_timestamp timestamp default current_timestamp comment '时间戳',
  	primary key(d_date,sales_id)
) comment '销售客户覆盖统计报表';

insert overwrite table fact_h_erp_d_customer_cover partition (p_date = $date$)
select 
act.d_date,
act.sales_id,
act.sales_name,
act.org_id,
act.org_name,
nvl(cover.cover_cus_cnt,0 ) as cover_cus_cnt,
nvl(cover.cover_cus_rec_cnt,0 ) as cover_cus_rec_cnt,
nvl(cover.valid_call_rec_cnt,0 ) as valid_call_rec_cnt,
nvl(cover.valid_call_time_long,0 ) as valid_call_time_long,
nvl(cover.valid_cover_cus_cnt,0 ) as valid_cover_cus_cnt,
nvl(round(cover.valid_cover_cus_cnt / cover.cover_cus_cnt,4),0) as valid_cover_ratio,
nvl(rl.input_cus_cnt,0) as input_cus_cnt,
nvl(cover.mtd_cover_cus_cnt,0 ) as mtd_cover_cus_cnt,
nvl(cover.mtd_cover_cus_rec_cnt,0 ) as mtd_cover_cus_rec_cnt,
nvl(cover.mtd_valid_call_rec_cnt,0 ) as mtd_valid_call_rec_cnt,
nvl(cover.mtd_valid_call_time_long,0 ) as mtd_valid_call_time_long,
nvl(cover.mtd_valid_cover_cus_cnt,0 ) as mtd_valid_cover_cus_cnt,
nvl(round(cover.mtd_valid_cover_cus_cnt / cover.mtd_cover_cus_cnt,4),0) as mtd_valid_cover_ratio,
nvl(rl.input_cus_cnt_m,0) as mtd_input_cus_cnt,
current_timestamp as creation_timestamp
from dw_erp_d_salesuser_act act
left join (
	select 	creator_id,		
				count(distinct case when call_date = $date$ and time_long > 10 then customer_id else null end) as cover_cus_cnt,
				count(case when call_date = $date$ and time_long > 10 then id else null end) as cover_cus_rec_cnt,
				count(case when call_date = $date$ and time_long > 45 and begin_time >='080000' and end_time <='200000' then id else null end) as valid_call_rec_cnt,
				sum(case when call_date = $date$ and time_long > 45 and begin_time >='080000' and end_time <='200000' and time_long/60 > 30 then 30.00 
				 		 when call_date = $date$ and time_long > 45 and begin_time >='080000' and end_time <='200000' and time_long/60 <= 30 then round(time_long/60 ,2) 
				 		 else 0 end ) as valid_call_time_long,
				count(distinct case when call_date = $date$ and time_long > 45 and begin_time >='080000' and end_time <='200000' then customer_id else null end) as valid_cover_cus_cnt,

				count(distinct case when time_long > 10 then customer_id else null end) as mtd_cover_cus_cnt,
				count(case when time_long > 10 then id else null end) as mtd_cover_cus_rec_cnt,
				count(case when time_long > 45 and begin_time >='080000' and end_time <='200000' then id else null end) as mtd_valid_call_rec_cnt,
				sum(case when time_long > 45 and begin_time >='080000' and end_time <='200000' and time_long/60 > 30 then 30.00 
				 		 when time_long > 45 and begin_time >='080000' and end_time <='200000' and time_long/60 <= 30 then round(time_long/60 ,2) 
				 		 else 0 end ) as mtd_valid_call_time_long,
				count(distinct case when time_long > 45 and begin_time >='080000' and end_time <='200000' then customer_id else null end) as mtd_valid_cover_cus_cnt
	  from call_record 
	where  customer_id >0
		and call_date between {{date[:6]+'01'}} and $date$
	group by creator_id
) cover 
on act.sales_id = cover.creator_id
left join fact_h_erp_a_salesuser_real rl 
on act.sales_id = rl.sales_id
and rl.d_date = $date$
join dim_org 
on act.org_id = dim_org.d_org_id 
where act.p_date = $date$
and (act.is_work_on = 1 or nvl(cover.cover_cus_cnt,0 ) > 0 or nvl(rl.input_cus_cnt_m,0) > 0);