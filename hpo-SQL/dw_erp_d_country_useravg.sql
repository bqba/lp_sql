create table if not exists dw_erp_d_country_useravg
(
	d_date int,
	position_channel string,
	avg_call_rec_cnt int,
	avg_call_time_long float,
	avg_visit_cus_cnt int,
	avg_input_cus_cnt int
)
partitioned by  (p_date int);

insert overwrite table dw_erp_d_country_useravg partition (p_date = $date$)
select 
	$date$ as d_date,
	position_channel,
	sum(case when is_work_on = 1 then call_rec_cnt else 0 end)/sum(is_work_on) as avg_call_rec_cnt,
	round(sum(case when is_work_on = 1 then call_time_long else cast(0 as float) end)/sum(is_work_on) ,2) as avg_call_time_long,
	sum(case when is_work_on = 1 then visit_cus_cnt_m else 0 end) /sum(is_work_on)  as avg_visit_cus_cnt,
	sum(case when is_work_on = 1 then input_cus_cnt_m else 0 end) /sum(is_work_on) as avg_input_cus_cnt
from  dw_erp_d_salesuser_act
where p_date = $date$
and is_sales_agent = 1
group by position_channel;






















insert overwrite table dw_erp_d_country_useravg partition (p_date = $date$)
select 
$date$ as d_date,
nvl(d_act.position_channel,m_act.position_channel) position_channel,
nvl(d_act.avg_call_rec_cnt,0) as  avg_call_rec_cnt,
nvl(round(d_act.avg_call_time_long,2),0) as avg_call_time_long,
nvl(m_act.avg_visit_cus_cnt,0) as avg_visit_cus_cnt,
nvl(m_act.avg_input_cus_cnt,0) as avg_input_cus_cnt
from 
(select position_channel,
			avg(call_rec_cnt) as avg_call_rec_cnt,
			avg(call_time_long) as avg_call_time_long
from  dw_erp_d_salesuser_act
where p_date = $date$
and is_sales_agent = 1
group by position_channel) d_act
full join 
(
	select position_channel,
			avg(visit_cus_cnt)  as avg_visit_cus_cnt,
			avg(input_cus_cnt) as avg_input_cus_cnt
	from (select    sales_id,position_channel,
							avg(visit_cus_cnt) as visit_cus_cnt,
							avg(input_cus_cnt) as input_cus_cnt
				from  dw_erp_d_salesuser_act
				where floor(p_date/100) = floor($date$/100)
				and is_sales_agent = 1
				group by sales_id,position_channel
			)  dw_erp_d_salesuser_act
	group by position_channel
) m_act
on d_act.position_channel= m_act.position_channel;




insert overwrite table dw_erp_d_country_useravg partition (p_date = $date$)
select 
$date$ as d_date,
nvl(plevel_enum.enum_name,'未知') position_channel,
nvl(d_act.avg_call_rec_cnt,0) as  avg_call_rec_cnt,
nvl(round(d_act.avg_call_time_long,2),0) as avg_call_time_long,
nvl(m_act.avg_visit_cus_cnt,0) as avg_visit_cus_cnt,
nvl(m_act.avg_input_cus_cnt,0) as avg_input_cus_cnt
from 
(select position_channel,
			percentile(cast(call_rec_cnt as bigint),0.5)  as avg_call_rec_cnt ,
			percentile_approx(cast(call_time_long as double),0.5) as avg_call_time_long
from  dw_erp_d_salesuser_act
where p_date = $date$
and is_sales_agent = 1
group by position_channel) d_act
full join 
(
	select position_channel,
			percentile(cast(visit_cus_cnt as bigint),0.5) as avg_visit_cus_cnt,
			percentile(cast(input_cus_cnt as bigint),0.5) as avg_input_cus_cnt
	from (select    sales_id,position_channel,
							sum(visit_cus_cnt) as visit_cus_cnt,
							sum(input_cus_cnt) as input_cus_cnt
				from  dw_erp_d_salesuser_act
				where floor(p_date/100) = floor($date$/100)
				and is_sales_agent = 1
				group by sales_id,position_channel
			)  dw_erp_d_salesuser_act
	group by position_channel
) m_act
on d_act.position_channel= m_act.position_channel
left outer join pub_enum_list plevel_enum
on plevel_enum.enum_type = 'position_channel'
and plevel_enum.src_table = 'portal_position'
and plevel_enum.is_default = '1'
and d_act.position_channel = plevel_enum.enum_code;

create table dw_erp_d_country_useravg
(
	d_date int  comment '统计日期',
	position_channel varchar(30)  comment '销售岗位通道',
	avg_call_rec_cnt int comment '通话记录条数平均数',
	avg_call_time_long float comment '有效通话时长平均数',
	avg_visit_cus_cnt int comment '拜访客户数平均数' ,
	avg_input_cus_cnt int comment '新增输入客户数平均数' ,
	primary key (d_date,position_channel)
);