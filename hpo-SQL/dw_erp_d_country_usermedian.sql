create table if not exists dw_erp_d_country_usermedian
(
	d_date int,
	position_channel string,
	med_call_rec_cnt int,
	med_call_time_long float,
	med_visit_cus_cnt int,
	med_input_cus_cnt int
)
partitioned by  (p_date int);

insert overwrite table dw_erp_d_country_usermedian partition (p_date = $date$)
select 
	$date$ as d_date,
	position_channel,
	avg(call_rec_cnt) as med_call_rec_cnt,
	avg(call_time_long) as med_call_time_long,
	avg(visit_cus_cnt)  as med_visit_cus_cnt,
	avg(input_cus_cnt) as med_input_cus_cnt
from  dw_erp_d_salesuser_act
where p_date = $date$
and is_sales_agent = 1
group by position_channel;



insert overwrite table dw_erp_d_country_usermedian partition (p_date = $date$)
select 
$date$ as d_date,
nvl(plevel_enum.enum_name,'未知') position_channel,
nvl(d_act.med_call_rec_cnt,0) as  med_call_rec_cnt,
nvl(round(d_act.med_call_time_long,2),0) as med_call_time_long,
nvl(m_act.med_visit_cus_cnt,0) as med_visit_cus_cnt,
nvl(m_act.med_input_cus_cnt,0) as med_input_cus_cnt
from 
(select position_channel,
			percentile(cast(call_rec_cnt as bigint),0.5)  as med_call_rec_cnt ,
			percentile_approx(cast(call_time_long as double),0.5) as med_call_time_long
from  dw_erp_d_salesuser_act
where p_date = $date$
and is_sales_agent = 1
group by position_channel) d_act
full join 
(
	select position_channel,
			percentile(cast(visit_cus_cnt as bigint),0.5) as med_visit_cus_cnt,
			percentile(cast(input_cus_cnt as bigint),0.5) as med_input_cus_cnt
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




create table dw_erp_d_country_usermedian
(
	d_date int  comment '统计日期',
	position_channel varchar(30)  comment '销售岗位通道',
	med_call_rec_cnt int comment '通话记录条数平均数',
	med_call_time_long float comment '有效通话时长平均数',
	med_visit_cus_cnt int comment '拜访客户数平均数' ,
	med_input_cus_cnt int comment '新增输入客户数平均数' ,
	primary key (d_date,position_channel)
);

alter table dw_erp_d_country_usermedian drop primary key;
alter table dw_erp_d_country_usermedian add primary key(d_date,position_channel);