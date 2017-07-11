CREATE TABLE dw_erp_d_gcdcnewp_plan(
  task_id int COMMENT ' 任务ID ', 
  userc_id int COMMENT ' 经理人ID ', 
  name string COMMENT ' 经理人姓名 ', 
  title string COMMENT ' 经理人当前职位名称 ', 
  industry string COMMENT ' 目前行业 ', 
  resume_status int COMMENT ' 经理人简历状态，1:无简历，2:简历不完整，低于60％，3:简历完整 ', 
  account_status int COMMENT ' 经理人账号状态，1:无账号，2:有账号 ', 
  task_receive_status int COMMENT ' 任务领取状态，0:未领取，1:已领取', 
  userc_dq string COMMENT ' 拉新活动地区，BI数据则是经理人所在地区 ', 
  task_source string COMMENT ' 经理人来源，1:H5拉新，2:Excel人工，3:BI数据，4:APP地推上传，5:二维码全员拉新，6:品牌H5拉新 ', 
  task_creator_id int COMMENT ' 任务当前维护人员ID ', 
  task_org_id int COMMENT ' 任务所在部门 ', 
  task_createtime string COMMENT ' 任务创建时间 ', 
  callplan_id int COMMENT ' 拨打计划ID ', 
  callplan_calltime string COMMENT ' 计划拨打时间 ', 
  callplan_finishtime string COMMENT ' 拨打计划拉新成功时间 ', 
  callplan_status int COMMENT ' 拨打计划任务状态，1:再次沟通，2:等待更新，3:新任务，4:拉新成功，5:拉入黑名单 ', 
  callplan_industry string COMMENT ' 拨打计划经理人行业 ', 
  callplan_industry_name string COMMENT ' 拨打计划经理人行业名称 ', 
  callplan_dq string COMMENT ' 拨打计划活动地区或经理人地区 ', 
  callplan_dq_name string COMMENT ' 拨打计划活动地区或经理人地区名称 ', 
  callplan_creator_id int COMMENT ' 拨打计划当前维护人员ID ', 
  callplan_creator_name string COMMENT ' 拨打计划当前维护人员姓名 ', 
  callplan_org_id int COMMENT ' 拨打计划所在部门 ', 
  callplan_org_name string COMMENT ' 拨打计划所在部门名称 ', 
  callplan_createtime string COMMENT ' 拨打计划创建时间 ', 
  activity_id int COMMENT ' 活动ID ', 
  activity_name string COMMENT ' 活动名称 ', 
  activity_dq string COMMENT ' 活动地区 ', 
  activity_type int COMMENT ' 活动类型，1:市场活动，2:品牌活动，3:BI线上流量，4:销售活动，5:线上BD活动 ', 
  activity_date string COMMENT ' 活动日期 ', 
  activity_mscid string COMMENT ' 媒体码 ', 
  activity_creator_id int COMMENT ' 活动当前维护人员ID ', 
  activity_org_id int COMMENT ' 活动所在部门 ', 
  activity_createtime string COMMENT ' 活动创建时间 ', 
  creation_timestamp timestamp COMMENT ' 时间戳 ')
PARTITIONED BY (p_date int);

alter table dw_erp_d_gcdcnewp_plan change activity_type activity_type int COMMENT ' 活动类型 新(1:BI线上流量，2:市场活动流量) 旧(1:市场活动，2:品牌活动，3:BI线上流量，4:销售活动，5:线上BD活动)' cascade; 
alter table dw_erp_d_gcdcnewp_plan change callplan_status callplan_status int COMMENT ' 状态：1:再次沟通，2:等待更新，3:新任务，4:拉新成功，5:拉入黑名单 6:初级简历预估' cascade; 

insert overwrite table dw_erp_d_gcdcnewp_plan partition (p_date = $date$)
	select 
		-1 as task_id,
		callplan.user_id as userc_id,
		'未知' as name,
		'999' as title,
		'999' as industry,
		-1 as resume_status,
		-1 as account_status,
		-1 as task_receive_status,
		'999' as userc_dq,
		'-1' as task_source,
		-1 as task_creator_id,
		-1 as task_org_id,
		'1900-01-01 00:00:00' as task_createtime,
		nvl(callplan.id,-1)  as callplan_id ,
		nvl(concat(substr(callplan.calltime,1,4),'-',substr(callplan.calltime,5,2),'-',substr(callplan.calltime,7,2)),'1900-01-01')  as callplan_calltime ,
		nvl(concat(substr(callplan.finishtime,1,4),'-',substr(callplan.finishtime,5,2),'-',substr(callplan.finishtime,7,2)),'1900-01-01')  as callplan_finishtime ,
		nvl(callplan.status,-1)  as callplan_status ,
		nvl(callplan.industry,'999') as callplan_industry,
		nvl(dim_industry.d_sub_industry,'未知') as callplan_industry_name,		
		nvl(callplan.dq,'999') as callplan_dq,
		nvl(dim_dq.d_ch_area,'未知') as callplan_dq_name,
		nvl(callplan.creator_id,-1)  as callplan_creator_id ,
		nvl(base.name,'未知')  as callplan_creator_name ,
		nvl(callplan.org_id,-1)  as callplan_org_id ,
		nvl(dim_org.org_name,'未知')  as callplan_org_name ,
		nvl(callplan.createtime,'1900-01-01 00:00:00')  as callplan_createtime ,
		-1 as activity_id ,
		'未知' as activity_name ,
		'999' as activity_dq ,
		nvl(callplan.source,'-1') as activity_type , --活动类型转换与老数据保持一致
		'1900-01-01' as activity_date ,
		'-1' as activity_mscid ,
		-1  as activity_creator_id ,
		-1 as activity_org_id ,
		'1900-01-01 00:00:00' as activity_createtime ,
		from_unixtime(unix_timestamp()) as creation_timestamp
	from promotion_callplan callplan
	inner join 
	(select id,name,org_id,org_name
	   from dw_erp_d_salesuser_base
	   where p_date = $date$) base
	on callplan.creator_id = base.id
	inner join dim_org
	on callplan.org_id = dim_org.d_org_id
	left outer join dim_industry 
	on callplan.industry = dim_industry.d_ind_code	
	left outer join dim_dq 
	on dim_dq.d_code=callplan.dq
	where callplan.deleteflag = 0;

insert overwrite table dw_erp_d_gcdcnewp_plan partition (p_date)
	select 
		-1 as task_id,
		callplan.user_id as userc_id,
		'未知' as name,
		'999' as title,
		'999' as industry,
		-1 as resume_status,
		-1 as account_status,
		-1 as task_receive_status,
		'999' as userc_dq,
		'-1' as task_source,
		-1 as task_creator_id,
		-1 as task_org_id,
		'1900-01-01 00:00:00' as task_createtime,
		nvl(callplan.id,-1)  as callplan_id ,
		nvl(concat(substr(callplan.calltime,1,4),'-',substr(callplan.calltime,5,2),'-',substr(callplan.calltime,7,2)),'1900-01-01')  as callplan_calltime ,
		nvl(concat(substr(callplan.finishtime,1,4),'-',substr(callplan.finishtime,5,2),'-',substr(callplan.finishtime,7,2)),'1900-01-01')  as callplan_finishtime ,
		nvl(callplan.status,-1)  as callplan_status ,
		nvl(callplan.industry,'999') as callplan_industry,
		nvl(dim_industry.d_sub_industry,'未知') as callplan_industry_name,		
		nvl(callplan.dq,'999') as callplan_dq,
		nvl(dim_dq.d_ch_area,'未知') as callplan_dq_name,
		nvl(callplan.creator_id,-1)  as callplan_creator_id ,
		nvl(base.name,'未知')  as callplan_creator_name ,
		nvl(callplan.org_id,-1)  as callplan_org_id ,
		nvl(dim_org.org_name,'未知')  as callplan_org_name ,
		nvl(callplan.createtime,'1900-01-01 00:00:00')  as callplan_createtime ,
		-1 as activity_id ,
		'未知' as activity_name ,
		'999' as activity_dq ,
		nvl(callplan.source,'-1') as activity_type , --活动类型转换与老数据保持一致
		'1900-01-01' as activity_date ,
		'-1' as activity_mscid ,
		-1  as activity_creator_id ,
		-1 as activity_org_id ,
		'1900-01-01 00:00:00' as activity_createtime ,
		from_unixtime(unix_timestamp()) as creation_timestamp,
		callplan.p_date
	from recovery.promotion_callplan_history_20170401_20170410 callplan
	inner join 
	(select id,name,org_id,org_name
	   from dw_erp_d_salesuser_base
	   where p_date = 20170412) base
	on callplan.creator_id = base.id
	inner join dim_org
	on callplan.org_id = dim_org.d_org_id
	left outer join dim_industry 
	on callplan.industry = dim_industry.d_ind_code	
	left outer join dim_dq 
	on dim_dq.d_code=callplan.dq
	where callplan.deleteflag = 0;


insert overwrite table dw_erp_d_gcdcnewp_plan partition (p_date = $date$)
	select 
		-1 as task_id,
		callplan.user_id as userc_id,
		'未知' as name,
		'999' as title,
		'999' as industry,
		-1 as resume_status,
		-1 as account_status,
		-1 as task_receive_status,
		'999' as userc_dq,
		'-1' as task_source,
		-1 as task_creator_id,
		-1 as task_org_id,
		'1900-01-01 00:00:00' as task_createtime,
		nvl(callplan.id,-1)  as callplan_id ,
		nvl(concat(substr(callplan.calltime,1,4),'-',substr(callplan.calltime,5,2),'-',substr(callplan.calltime,7,2)),'1900-01-01')  as callplan_calltime ,
		nvl(concat(substr(callplan.finishtime,1,4),'-',substr(callplan.finishtime,5,2),'-',substr(callplan.finishtime,7,2)),'1900-01-01')  as callplan_finishtime ,
		nvl(callplan.status,-1)  as callplan_status ,
		nvl(callplan.industry,'999') as callplan_industry,
		nvl(dim_industry.d_sub_industry,'未知') as callplan_industry_name,		
		nvl(callplan.dq,'999') as callplan_dq,
		nvl(dim_dq.d_ch_area,'未知') as callplan_dq_name,
		nvl(callplan.creator_id,-1)  as callplan_creator_id ,
		nvl(base.name,'未知')  as callplan_creator_name ,
		nvl(callplan.org_id,-1)  as callplan_org_id ,
		nvl(dim_org.org_name,'未知')  as callplan_org_name ,
		nvl(callplan.createtime,'1900-01-01 00:00:00')  as callplan_createtime ,
		-1 as activity_id ,
		'未知' as activity_name ,
		'999' as activity_dq ,
		nvl(case callplan.source when 1 then 3 when 2 then 1 end,'-1') as activity_type , --活动类型转换与老数据保持一致
		'1900-01-01' as activity_date ,
		'-1' as activity_mscid ,
		-1  as activity_creator_id ,
		-1 as activity_org_id ,
		'1900-01-01 00:00:00' as activity_createtime ,
		from_unixtime(unix_timestamp()) as creation_timestamp
	from promotion_callplan callplan
	inner join 
	(select id,name,org_id,org_name
	   from dw_erp_d_salesuser_base
	   where p_date = $date$) base
	on callplan.creator_id = base.id
	inner join dim_org
	on callplan.org_id = dim_org.d_org_id
	left outer join dim_industry 
	on callplan.industry = dim_industry.d_ind_code	
	left outer join dim_dq 
	on dim_dq.d_code=callplan.dq
	where callplan.deleteflag = 0;

CREATE TABLE fact_h_gcdc_d_newpull_cdc(
  d_date int COMMENT ' 统计日期 ', 
  gcdc_id int COMMENT ' gcdc顾问 ', 
  gcdc_name string COMMENT ' gcdc顾问名称 ', 
  org_id int COMMENT ' 所属部门 ', 
  org_name string COMMENT ' 所属部门名称 ', 
  call_c_cnt int COMMENT ' 已覆盖人数 ', 
  call_rec_cnt int COMMENT ' 已覆盖次数 ', 
  no_finish_task_c_cnt int COMMENT ' 未覆盖人数 ', 
  valid_call_c_cnt int COMMENT ' 有效覆盖人数 ', 
  valid_call_rec_cnt int COMMENT ' 有效覆盖次数 ', 
  finish_res_c_cnt int COMMENT ' 在线完成数 ', 
  finish_biz_res_cnt int COMMENT ' 商业简历完善数 ', 
  finish_level6_res_cnt int COMMENT ' 6级简历的数量 ', 
  finish_level5_res_cnt int COMMENT ' 5级简历的数量 ', 
  finish_level4_res_cnt int COMMENT ' 4级简历的数量 ', 
  finish_level3_res_cnt int COMMENT ' 3级简历的数量 ', 
  finish_level2_res_cnt int COMMENT ' 2级简历的数量 ', 
  finish_level1_res_cnt int COMMENT ' 1级简历的数量 ', 
  finish_task_c_cnt int COMMENT ' 当天领取任务的覆盖数 ', 
  call_plan_c_cnt int COMMENT ' 今日待沟通总数 ', 
  mtd_call_c_cnt int COMMENT '月累计已覆盖人数', 
  mtd_call_rec_cnt int COMMENT '月累计已覆盖次数', 
  mtd_no_finish_task_c_cnt int COMMENT '月累计未覆盖人数', 
  mtd_valid_call_c_cnt int COMMENT '月累计有效覆盖人数', 
  mtd_valid_call_rec_cnt int COMMENT '月累计有效覆盖次数', 
  mtd_finish_res_c_cnt int COMMENT '月累计在线完成数', 
  mtd_finish_biz_res_cnt int COMMENT '月累计商业简历完善数', 
  mtd_finish_level6_res_cnt int COMMENT '月累计6级简历的数量', 
  mtd_finish_level5_res_cnt int COMMENT '月累计5级简历的数量', 
  mtd_finish_level4_res_cnt int COMMENT '月累计4级简历的数量', 
  mtd_finish_level3_res_cnt int COMMENT '月累计3级简历的数量', 
  mtd_finish_level2_res_cnt int COMMENT '月累计2级简历的数量', 
  mtd_finish_level1_res_cnt int COMMENT '月累计1级简历的数量', 
  mtd_finish_task_c_cnt int COMMENT '月累计当天领取任务的覆盖数', 
  mtd_call_plan_c_cnt int COMMENT '月累计今日待沟通总数', 
  creation_timestamp timestamp COMMENT ' 时间戳 ')
PARTITIONED BY ( p_date int);

insert overwrite table fact_h_gcdc_d_newpull_cdc partition(p_date = $date$)
select
	$date$ as d_date,
	nvl(fact.creator_id,-1) as gcdc_id,
	nvl(base.name,'未知') as gcdc_name,
	nvl(base.org_id,-1) as org_id,
	nvl(base.org_name,'未知') as org_name,
	sum(call_c_cnt) as call_c_cnt,
	sum(call_rec_cnt) as call_rec_cnt,
	sum(no_finish_task_c_cnt) as no_finish_task_c_cnt,	
	sum(valid_call_c_cnt) as valid_call_c_cnt,
	sum(valid_call_rec_cnt) as valid_call_rec_cnt,
	sum(finish_res_c_cnt) as finish_res_c_cnt  ,
	sum(finish_biz_res_cnt) as finish_biz_res_cnt  ,	
	sum(finish_level6_res_cnt) as finish_level6_res_cnt ,
	sum(finish_level5_res_cnt) as finish_level5_res_cnt ,
	sum(finish_level4_res_cnt) as finish_level4_res_cnt ,
	sum(finish_level3_res_cnt) as finish_level3_res_cnt ,
	sum(finish_level2_res_cnt) as finish_level2_res_cnt ,
	sum(finish_level1_res_cnt) as finish_level1_res_cnt ,
	sum(finish_task_c_cnt) as finish_task_c_cnt,
	sum(call_plan_c_cnt) as call_plan_c_cnt,
	sum(mtd_call_c_cnt) as mtd_call_c_cnt,
	sum(mtd_call_rec_cnt) as mtd_call_rec_cnt,
	sum(mtd_no_finish_task_c_cnt) as mtd_no_finish_task_c_cnt,	
	sum(mtd_valid_call_c_cnt) as mtd_valid_call_c_cnt,	
	sum(mtd_valid_call_rec_cnt) as mtd_valid_call_rec_cnt,	
	sum(mtd_finish_res_c_cnt) as mtd_finish_res_c_cnt  ,
	sum(mtd_finish_biz_res_cnt) as mtd_finish_biz_res_cnt  ,	
	sum(mtd_finish_level6_res_cnt) as mtd_finish_level6_res_cnt ,
	sum(mtd_finish_level5_res_cnt) as mtd_finish_level5_res_cnt ,
	sum(mtd_finish_level4_res_cnt) as mtd_finish_level4_res_cnt ,
	sum(mtd_finish_level3_res_cnt) as mtd_finish_level3_res_cnt ,
	sum(mtd_finish_level2_res_cnt) as mtd_finish_level2_res_cnt ,
	sum(mtd_finish_level1_res_cnt) as mtd_finish_level1_res_cnt ,
	sum(mtd_finish_task_c_cnt) as mtd_finish_task_c_cnt,
	sum(mtd_call_plan_c_cnt) as mtd_call_plan_c_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp
from (
select 
	plan.callplan_creator_id as creator_id,
	0 as valid_call_rec_cnt,
	0 as valid_call_c_cnt,
	0 as call_c_cnt,
	0 as call_rec_cnt,
	count(case when is_call_plan_c_cnt = 1 and track.track_day is null and callplan_finishtime <> $date$ then plan.callplan_id else null end ) as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	count(case when is_call_plan_c_cnt = 1 and track.track_day is not null then track.user_id else null end ) as finish_task_c_cnt,
	count(case when is_call_plan_c_cnt = 1 then plan.callplan_id else null end ) as call_plan_c_cnt,
	0 as mtd_valid_call_rec_cnt,
	0 as mtd_valid_call_c_cnt,
	0 as mtd_call_c_cnt,
	0 as mtd_call_rec_cnt,
	0 as mtd_no_finish_task_c_cnt,	
	0 as mtd_finish_res_c_cnt  ,
	0 as mtd_finish_level6_res_cnt ,
	0 as mtd_finish_level5_res_cnt ,
	0 as mtd_finish_level4_res_cnt ,
	0 as mtd_finish_level3_res_cnt ,
	0 as mtd_finish_level2_res_cnt ,
	0 as mtd_finish_level1_res_cnt ,
	0 as mtd_finish_biz_res_cnt  ,
	count(case when plan.is_mtd_call_plan_c_cnt = 1 then track.user_id else null end ) as mtd_finish_task_c_cnt,
	count(case when plan.is_mtd_call_plan_c_cnt = 1 then plan.callplan_id else null end ) as mtd_call_plan_c_cnt
from 
(select	callplan_id,
		callplan_creator_id ,
		callplan_creator_name ,
		callplan_createtime ,
		regexp_replace(callplan_finishtime,'-','') as callplan_finishtime,
		cast(substr(regexp_replace(callplan_createtime,'-',''),1,8) as int) as callplan_date,
		case when substr(regexp_replace(callplan_createtime,'-',''),1,8) = '$date$' then 1 else 0 end as is_call_plan_c_cnt,
		1 as is_mtd_call_plan_c_cnt,
		userc_id
 from dw_erp_d_gcdcnewp_plan 
where p_date = $date$
  and substr(regexp_replace(callplan_createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
) plan
left join 
(	select user_id,substr(regexp_replace(min(createtime),'-',''),1,8) as  track_day
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
	group by user_id
) track 
on plan.userc_id = track.user_id
group by plan.callplan_creator_id
union all 
select callplan_creator_id as creator_id,
	0 as valid_call_rec_cnt,
	0 as valid_call_c_cnt,
	0 as call_c_cnt,
	0 as call_rec_cnt,
	0 as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	0 as finish_task_c_cnt,
	0 as call_plan_c_cnt,
	0 as mtd_valid_call_rec_cnt,
	0 as mtd_valid_call_c_cnt,
	0 as mtd_call_c_cnt,
	0 as mtd_call_rec_cnt,
	count(callplan_id) as mtd_no_finish_task_c_cnt,	
	0 as mtd_finish_res_c_cnt  ,
	0 as mtd_finish_level6_res_cnt ,
	0 as mtd_finish_level5_res_cnt ,
	0 as mtd_finish_level4_res_cnt ,
	0 as mtd_finish_level3_res_cnt ,
	0 as mtd_finish_level2_res_cnt ,
	0 as mtd_finish_level1_res_cnt ,
	0 as mtd_finish_biz_res_cnt  ,
	0 as mtd_finish_task_c_cnt,
	0 as mtd_call_plan_c_cnt	   
from (
	select 
	callplan_creator_id,
	callplan_id,
	callplan_status,
	row_number()over(partition by callplan_id order by p_date) rn 
	from dw_erp_d_gcdcnewp_plan
	where substr(regexp_replace(callplan_createtime,'-',''),1,8) = p_date
	and substr(regexp_replace(callplan_createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
	and p_date between concat(substr('$date$',1,6),'01') and '$date$'
) plan 
where rn = 1
and callplan_status in (1,2,3)
group by callplan_creator_id

union all 

select 
	track.creator_id as creator_id,
	sum(case when track_day = $date$ and nvl(call_date,0) =  $date$ then is_valid else 0 end) as valid_call_rec_cnt,
	count(distinct case when track_day = $date$ and nvl(call_date,0) = $date$ and is_valid = 1 then track.user_id else null end ) as  valid_call_c_cnt,
	count(distinct case when track_day = $date$ then track.user_id else null end ) as  call_c_cnt,
	sum(case when track_day = $date$ then 1 else 0 end) as call_rec_cnt,
	0 as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	0 as finish_task_c_cnt,
	0 as call_plan_c_cnt,
	sum(nvl(is_valid,0)) as  mtd_valid_call_rec_cnt,
	count(distinct case when nvl(is_valid,0) = 1 then track.user_id else null end ) as  mtd_valid_call_c_cnt,
	count(distinct track.user_id) as  mtd_call_c_cnt,	
	sum(1) as  mtd_call_rec_cnt,
	0 as mtd_no_finish_task_c_cnt,	
	0 as mtd_finish_res_c_cnt  ,
	0 as mtd_finish_level6_res_cnt ,
	0 as mtd_finish_level5_res_cnt ,
	0 as mtd_finish_level4_res_cnt ,
	0 as mtd_finish_level3_res_cnt ,
	0 as mtd_finish_level2_res_cnt ,
	0 as mtd_finish_level1_res_cnt ,
	0 as mtd_finish_biz_res_cnt  ,
	0 as mtd_finish_task_c_cnt,
	0 as mtd_call_plan_c_cnt
from 
(	select id,uuid,substr(regexp_replace(createtime,'-',''),1,8) as  track_day,creator_id,user_id
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
) track 
left join 
(		 select uuid,case when sum(time_long) >60 then 1 else 0 end as is_valid,substr(regexp_replace(call_date,'-',''),1,8) as call_date
		   from call_record 
		where deleteflag  = 0
			and substr(regexp_replace(call_date,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and '$date$'
			and time_long > 0
		  group by uuid,substr(regexp_replace(call_date,'-',''),1,8)
) call_record 
on track.uuid = call_record.uuid
group by track.creator_id
union all 
select creator_id,
		0 as valid_call_rec_cnt,
		0 as valid_call_c_cnt,
		0 as call_c_cnt,
		0 as call_rec_cnt,
		0 as no_finish_task_c_cnt,	
		sum(case when track_day = $date$ then finish_res_c_cnt else 0 end)  as finish_res_c_cnt,
		sum(case when track_day = $date$ then finish_level6_res_cnt else 0 end)  as finish_level6_res_cnt,
		sum(case when track_day = $date$ then finish_level5_res_cnt else 0 end)  as finish_level5_res_cnt,
		sum(case when track_day = $date$ then finish_level4_res_cnt else 0 end)  as finish_level4_res_cnt,
		sum(case when track_day = $date$ then finish_level3_res_cnt else 0 end)  as finish_level3_res_cnt,
		sum(case when track_day = $date$ then finish_level2_res_cnt else 0 end)  as finish_level2_res_cnt,
		sum(case when track_day = $date$ then finish_level1_res_cnt else 0 end)  as finish_level1_res_cnt,
		sum(case when track_day = $date$ then finish_biz_res_cnt else 0 end)  as finish_biz_res_cnt,
		0 as finish_task_c_cnt,
		0 as call_plan_c_cnt,
		0 as mtd_valid_call_rec_cnt,
		0 as mtd_valid_call_c_cnt,
		0 as mtd_call_c_cnt,
		0 as mtd_call_rec_cnt,
		0 as mtd_no_finish_task_c_cnt,	
		sum(finish_res_c_cnt)  as mtd_finish_res_c_cnt,
		sum(finish_level6_res_cnt)  as mtd_finish_level6_res_cnt,
		sum(finish_level5_res_cnt)  as mtd_finish_level5_res_cnt,
		sum(finish_level4_res_cnt)  as mtd_finish_level4_res_cnt,
		sum(finish_level3_res_cnt)  as mtd_finish_level3_res_cnt,
		sum(finish_level2_res_cnt)  as mtd_finish_level2_res_cnt,
		sum(finish_level1_res_cnt)  as mtd_finish_level1_res_cnt,
		sum(finish_biz_res_cnt)  as mtd_finish_biz_res_cnt,
		0 as mtd_finish_task_c_cnt,
		0 as mtd_call_plan_c_cnt	
from (
	select 
		user_id,org_id,
		creator_id,substr(regexp_replace(createtime,'-',''),1,8) as  track_day,
		case when instr(combine(cast(action_type as string)) ,4) >0 then 1 else 0 end  as finish_res_c_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt
	from promotion_callplan_log
	where substr(regexp_replace(createtime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and '$date$'
	group by user_id,org_id,creator_id,substr(regexp_replace(createtime,'-',''),1,8)
)  m_log
where finish_res_c_cnt > 0 
group by creator_id
) fact 
left join 
(select id,
		name,
		org_id,
		org_name
	from dw_erp_d_salesuser_base 
	where p_date = $date$
) base
on fact.creator_id = base.id
group by fact.creator_id,
base.name,
base.org_id,
base.org_name;


insert overwrite table fact_h_gcdc_d_newpull_org partition(p_date = $date$)
select
	$date$ as d_date,
	nvl(fact.org_id,-1) as org_id,
	nvl(base.org_name,'未知') as org_name,
	sum(call_c_cnt) as call_c_cnt,
	sum(call_rec_cnt) as call_rec_cnt,
	sum(no_finish_task_c_cnt) as no_finish_task_c_cnt,	
	sum(valid_call_c_cnt) as valid_call_c_cnt,	
	sum(valid_call_rec_cnt) as valid_call_rec_cnt,
	sum(finish_res_c_cnt) as finish_res_c_cnt  ,	
	sum(finish_biz_res_cnt) as finish_biz_res_cnt  ,
	sum(finish_level6_res_cnt) as finish_level6_res_cnt ,
	sum(finish_level5_res_cnt) as finish_level5_res_cnt ,
	sum(finish_level4_res_cnt) as finish_level4_res_cnt ,
	sum(finish_level3_res_cnt) as finish_level3_res_cnt ,
	sum(finish_level2_res_cnt) as finish_level2_res_cnt ,
	sum(finish_level1_res_cnt) as finish_level1_res_cnt ,
	sum(finish_task_c_cnt) as finish_task_c_cnt,
	sum(call_plan_c_cnt) as call_plan_c_cnt,
	sum(mtd_call_c_cnt) as mtd_call_c_cnt,
	sum(mtd_call_rec_cnt) as mtd_call_rec_cnt,
	sum(mtd_no_finish_task_c_cnt) as mtd_no_finish_task_c_cnt,	
	sum(mtd_valid_call_c_cnt) as mtd_valid_call_c_cnt,		
	sum(mtd_valid_call_rec_cnt) as mtd_valid_call_rec_cnt,
	sum(mtd_finish_res_c_cnt) as mtd_finish_res_c_cnt  ,
	sum(mtd_finish_biz_res_cnt) as mtd_finish_biz_res_cnt  ,
	sum(mtd_finish_level6_res_cnt) as mtd_finish_level6_res_cnt ,
	sum(mtd_finish_level5_res_cnt) as mtd_finish_level5_res_cnt ,
	sum(mtd_finish_level4_res_cnt) as mtd_finish_level4_res_cnt ,
	sum(mtd_finish_level3_res_cnt) as mtd_finish_level3_res_cnt ,
	sum(mtd_finish_level2_res_cnt) as mtd_finish_level2_res_cnt ,
	sum(mtd_finish_level1_res_cnt) as mtd_finish_level1_res_cnt ,
	sum(mtd_finish_task_c_cnt) as mtd_finish_task_c_cnt,
	sum(mtd_call_plan_c_cnt) as mtd_call_plan_c_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp
from (
select 
	plan.callplan_org_id as org_id,
	0 as valid_call_rec_cnt,
	0 as valid_call_c_cnt,
	0 as call_c_cnt,
	0 as call_rec_cnt,
	count(case when is_call_plan_c_cnt = 1 and track.track_day is null and callplan_finishtime <> $date$ then plan.callplan_id else null end ) as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	count(case when is_call_plan_c_cnt = 1 and track.track_day is not null then track.user_id else null end ) as finish_task_c_cnt,
	count(case when is_call_plan_c_cnt = 1 then plan.callplan_id else null end ) as call_plan_c_cnt,
	0 as mtd_valid_call_rec_cnt,
	0 as mtd_valid_call_c_cnt,
	0 as mtd_call_c_cnt,
	0 as mtd_call_rec_cnt,
	0 as mtd_no_finish_task_c_cnt,	
	0 as mtd_finish_res_c_cnt  ,
	0 as mtd_finish_level6_res_cnt ,
	0 as mtd_finish_level5_res_cnt ,
	0 as mtd_finish_level4_res_cnt ,
	0 as mtd_finish_level3_res_cnt ,
	0 as mtd_finish_level2_res_cnt ,
	0 as mtd_finish_level1_res_cnt ,
	0 as mtd_finish_biz_res_cnt  ,
	count(case when plan.is_mtd_call_plan_c_cnt = 1 then track.user_id else null end ) as mtd_finish_task_c_cnt,
	count(case when plan.is_mtd_call_plan_c_cnt = 1 then plan.callplan_id else null end ) as mtd_call_plan_c_cnt
from 
(select	callplan_id,
		callplan_org_id ,
		callplan_creator_name ,
		callplan_createtime ,
		regexp_replace(callplan_finishtime,'-','') as callplan_finishtime,
		cast(substr(regexp_replace(callplan_createtime,'-',''),1,8) as int) as callplan_date,
		case when substr(regexp_replace(callplan_createtime,'-',''),1,8) = '$date$' then 1 else 0 end as is_call_plan_c_cnt,
		1 as is_mtd_call_plan_c_cnt,
		userc_id
 from dw_erp_d_gcdcnewp_plan 
where p_date = $date$
  and substr(regexp_replace(callplan_createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
) plan
left join 
(	select substr(regexp_replace(min(createtime),'-',''),1,8) as  track_day,user_id
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
	group by user_id
) track 
on plan.userc_id = track.user_id
group by plan.callplan_org_id

union all 
select callplan_org_id as org_id,
	0 as valid_call_rec_cnt,
	0 as valid_call_c_cnt,
	0 as call_c_cnt,
	0 as call_rec_cnt,
	0 as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	0 as finish_task_c_cnt,
	0 as call_plan_c_cnt,
	0 as mtd_valid_call_rec_cnt,
	0 as mtd_valid_call_c_cnt,
	0 as mtd_call_c_cnt,
	0 as mtd_call_rec_cnt,
	count(callplan_id) as mtd_no_finish_task_c_cnt,	
	0 as mtd_finish_res_c_cnt  ,
	0 as mtd_finish_level6_res_cnt ,
	0 as mtd_finish_level5_res_cnt ,
	0 as mtd_finish_level4_res_cnt ,
	0 as mtd_finish_level3_res_cnt ,
	0 as mtd_finish_level2_res_cnt ,
	0 as mtd_finish_level1_res_cnt ,
	0 as mtd_finish_biz_res_cnt  ,
	0 as mtd_finish_task_c_cnt,
	0 as mtd_call_plan_c_cnt	   
from (
	select 
	callplan_creator_id,
	callplan_org_id,
	callplan_id,
	callplan_status,
	row_number()over(partition by callplan_id order by p_date) rn 
	from dw_erp_d_gcdcnewp_plan
	where substr(regexp_replace(callplan_createtime,'-',''),1,8) = p_date
	and substr(regexp_replace(callplan_createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
	and p_date between concat(substr('$date$',1,6),'01') and '$date$'
) plan 
where rn = 1
and callplan_status = 3 
group by callplan_org_id
union all 

select 
	track.org_id as org_id,
	sum(case when track_day = $date$ and nvl(call_date,0) =  $date$ then is_valid else 0 end) as valid_call_rec_cnt,
	count(distinct case when track_day = $date$ and nvl(call_date,0) = $date$ and is_valid=1 then track.user_id else null end ) as  valid_call_c_cnt,
	count(distinct case when track_day = $date$ then track.user_id else null end ) as  call_c_cnt,
	sum(case when track_day = $date$ then 1 else 0 end) as call_rec_cnt,
	0 as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	0 as finish_task_c_cnt,
	0 as call_plan_c_cnt,
	sum(nvl(is_valid,0)) as  mtd_valid_call_rec_cnt,
	count(distinct case when nvl(is_valid,0) = 1 then track.user_id else null end ) as  mtd_valid_call_c_cnt,
	count(distinct track.user_id) as  mtd_call_c_cnt,	
	sum(1) as  mtd_call_rec_cnt,
	0 as mtd_no_finish_task_c_cnt,	
	0 as mtd_finish_res_c_cnt  ,
	0 as mtd_finish_level6_res_cnt ,
	0 as mtd_finish_level5_res_cnt ,
	0 as mtd_finish_level4_res_cnt ,
	0 as mtd_finish_level3_res_cnt ,
	0 as mtd_finish_level2_res_cnt ,
	0 as mtd_finish_level1_res_cnt ,
	0 as mtd_finish_biz_res_cnt  ,
	0 as mtd_finish_task_c_cnt,
	0 as mtd_call_plan_c_cnt
from 
(	select id,uuid,user_id,substr(regexp_replace(createtime,'-',''),1,8) as  track_day,org_id
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
) track 
left join 
(		 select uuid,case when sum(time_long) >60 then 1 else 0 end as is_valid,substr(regexp_replace(call_date,'-',''),1,8) as call_date
		   from call_record 
		where deleteflag  = 0
			and substr(regexp_replace(call_date,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and '$date$'
			and time_long > 0
		  group by uuid,substr(regexp_replace(call_date,'-',''),1,8)
) call_record 
on track.uuid = call_record.uuid
group by track.org_id
union all 
select org_id,
		0 as valid_call_rec_cnt,
		0 as valid_call_c_cnt,
		0 as call_c_cnt,
		0 as call_rec_cnt,
		0 as no_finish_task_c_cnt,	
		sum(case when track_day = $date$ then finish_res_c_cnt else 0 end)  as finish_res_c_cnt,
		sum(case when track_day = $date$ then finish_level6_res_cnt else 0 end)  as finish_level6_res_cnt,
		sum(case when track_day = $date$ then finish_level5_res_cnt else 0 end)  as finish_level5_res_cnt,
		sum(case when track_day = $date$ then finish_level4_res_cnt else 0 end)  as finish_level4_res_cnt,
		sum(case when track_day = $date$ then finish_level3_res_cnt else 0 end)  as finish_level3_res_cnt,
		sum(case when track_day = $date$ then finish_level2_res_cnt else 0 end)  as finish_level2_res_cnt,
		sum(case when track_day = $date$ then finish_level1_res_cnt else 0 end)  as finish_level1_res_cnt,
		sum(case when track_day = $date$ then finish_biz_res_cnt else 0 end)  as finish_biz_res_cnt,
		0 as finish_task_c_cnt,
		0 as call_plan_c_cnt,
		0 as mtd_valid_call_rec_cnt,
		0 as mtd_valid_call_c_cnt,
		0 as mtd_call_c_cnt,
		0 as mtd_call_rec_cnt,
		0 as mtd_no_finish_task_c_cnt,	
		sum(finish_res_c_cnt)  as mtd_finish_res_c_cnt,
		sum(finish_level6_res_cnt)  as mtd_finish_level6_res_cnt,
		sum(finish_level5_res_cnt)  as mtd_finish_level5_res_cnt,
		sum(finish_level4_res_cnt)  as mtd_finish_level4_res_cnt,
		sum(finish_level3_res_cnt)  as mtd_finish_level3_res_cnt,
		sum(finish_level2_res_cnt)  as mtd_finish_level2_res_cnt,
		sum(finish_level1_res_cnt)  as mtd_finish_level1_res_cnt,
		sum(finish_biz_res_cnt)  as mtd_finish_biz_res_cnt,
		0 as mtd_finish_task_c_cnt,
		0 as mtd_call_plan_c_cnt	
from (
	select 
		user_id,
		org_id,substr(regexp_replace(createtime,'-',''),1,8) as  track_day,
		case when instr(combine(cast(action_type as string)) ,4) >0 then 1 else 0 end  as finish_res_c_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt
	from promotion_callplan_log
	where substr(regexp_replace(createtime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and '$date$'
	group by user_id,org_id,substr(regexp_replace(createtime,'-',''),1,8)
)  m_log
where finish_res_c_cnt > 0
group by org_id
) fact 
left join 
(select d_org_id as id,
		org_name
	from dim_org 
) base
on fact.org_id = base.id
group by fact.org_id,
base.org_name;


insert overwrite table fact_h_gcdc_d_newpull_plan partition(p_date = $date$)
select
	$date$ as d_date,
	nvl(fact.callplan_industry,'999') as callplan_industry ,
	nvl(fact.callplan_industry_name,'其他') as callplan_industry_name ,
	nvl(fact.callplan_dq,'999') as callplan_dq ,	
	nvl(fact.callplan_dq_name,'不限') ,	
	fact.activity_type,
	case when fact.activity_type = '1' then '市场活动'
		 when fact.activity_type = '2' then '品牌活动'
		 when fact.activity_type = '3' then 'BI线上流量'
		 when fact.activity_type = '4' then '销售活动'
		 when fact.activity_type = '5' then '线上BD活动'
		 else  '未知' 
		 end as activity_type_name,

	sum(call_c_cnt) as call_c_cnt,
	sum(call_rec_cnt) as call_rec_cnt,
	sum(no_finish_task_c_cnt) as no_finish_task_c_cnt,	
	sum(valid_call_c_cnt) as valid_call_c_cnt,		
	sum(valid_call_rec_cnt) as valid_call_rec_cnt,
	sum(finish_res_c_cnt) as finish_res_c_cnt  ,
	sum(finish_biz_res_cnt) as finish_biz_res_cnt  ,	
	sum(finish_level6_res_cnt) as finish_level6_res_cnt ,
	sum(finish_level5_res_cnt) as finish_level5_res_cnt ,
	sum(finish_level4_res_cnt) as finish_level4_res_cnt ,
	sum(finish_level3_res_cnt) as finish_level3_res_cnt ,
	sum(finish_level2_res_cnt) as finish_level2_res_cnt ,
	sum(finish_level1_res_cnt) as finish_level1_res_cnt ,
	sum(finish_task_c_cnt) as finish_task_c_cnt,
	sum(call_plan_c_cnt) as call_plan_c_cnt,
	sum(mtd_call_c_cnt) as mtd_call_c_cnt,
	sum(mtd_call_rec_cnt) as mtd_call_rec_cnt,
	sum(mtd_no_finish_task_c_cnt) as mtd_no_finish_task_c_cnt,	
	sum(mtd_valid_call_c_cnt) as mtd_valid_call_c_cnt,	
	sum(mtd_valid_call_rec_cnt) as mtd_valid_call_rec_cnt,
	sum(mtd_finish_res_c_cnt) as mtd_finish_res_c_cnt  ,
	sum(mtd_finish_biz_res_cnt) as mtd_finish_biz_res_cnt  ,	
	sum(mtd_finish_level6_res_cnt) as mtd_finish_level6_res_cnt ,
	sum(mtd_finish_level5_res_cnt) as mtd_finish_level5_res_cnt ,
	sum(mtd_finish_level4_res_cnt) as mtd_finish_level4_res_cnt ,
	sum(mtd_finish_level3_res_cnt) as mtd_finish_level3_res_cnt ,
	sum(mtd_finish_level2_res_cnt) as mtd_finish_level2_res_cnt ,
	sum(mtd_finish_level1_res_cnt) as mtd_finish_level1_res_cnt ,
	sum(mtd_finish_task_c_cnt) as mtd_finish_task_c_cnt,
	sum(mtd_call_plan_c_cnt) as mtd_call_plan_c_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp,
	nvl(dim_dq.d_ch_code,'999') as city ,
	nvl(dim_dq.d_ch_name,'不限') as city_name ,
	nvl(dim_industry.d_main_industry_code,'999') as main_industry,	
	nvl(dim_industry.d_main_industry,'其他') as main_industry_name
from (
select 
	plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type,
	0 as valid_call_rec_cnt,
	0 as valid_call_c_cnt,
	0 as call_c_cnt,
	0 as call_rec_cnt,
	count(case when is_call_plan_c_cnt = 1 and track.track_day is null and callplan_finishtime <> $date$ then plan.callplan_id else null end ) as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	count(case when is_call_plan_c_cnt = 1 and track.track_day is not null then track.user_id else null end ) as finish_task_c_cnt,
	count(case when is_call_plan_c_cnt = 1 then plan.callplan_id else null end ) as call_plan_c_cnt,
	0 as mtd_valid_call_rec_cnt,
	0 as mtd_valid_call_c_cnt,
	0 as mtd_call_c_cnt,
	0 as mtd_call_rec_cnt,
	0 as mtd_no_finish_task_c_cnt,	
	0 as mtd_finish_res_c_cnt  ,
	0 as mtd_finish_level6_res_cnt ,
	0 as mtd_finish_level5_res_cnt ,
	0 as mtd_finish_level4_res_cnt ,
	0 as mtd_finish_level3_res_cnt ,
	0 as mtd_finish_level2_res_cnt ,
	0 as mtd_finish_level1_res_cnt ,
	0 as mtd_finish_biz_res_cnt  ,
	count(case when plan.is_mtd_call_plan_c_cnt = 1 then track.user_id else null end ) as mtd_finish_task_c_cnt,
	count(case when plan.is_mtd_call_plan_c_cnt = 1 then plan.callplan_id else null end ) as mtd_call_plan_c_cnt
from 
(select	callplan_id,
		callplan_org_id ,
		callplan_creator_name ,
		callplan_createtime ,
		callplan_industry ,
		callplan_industry_name ,
		callplan_dq ,	
		callplan_dq_name ,	
		activity_type,
		regexp_replace(callplan_finishtime,'-','') as callplan_finishtime,
		cast(substr(regexp_replace(callplan_createtime,'-',''),1,8) as int) as callplan_date,
		case when substr(regexp_replace(callplan_createtime,'-',''),1,8) = '$date$' then 1 else 0 end as is_call_plan_c_cnt,
		1 as is_mtd_call_plan_c_cnt,
		userc_id
 from dw_erp_d_gcdcnewp_plan 
where p_date = $date$
  and substr(regexp_replace(callplan_createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$' 
 ) plan
left join 
(	select user_id,substr(regexp_replace(min(createtime),'-',''),1,8) as  track_day
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
	group by user_id
) track 
on plan.userc_id = track.user_id
group by plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type
union all 
select plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type,
	0 as valid_call_rec_cnt,
	0 as valid_call_c_cnt,
	0 as call_c_cnt,
	0 as call_rec_cnt,
	0 as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	0 as finish_task_c_cnt,
	0 as call_plan_c_cnt,
	0 as mtd_valid_call_rec_cnt,
	0 as mtd_valid_call_c_cnt,
	0 as mtd_call_c_cnt,
	0 as mtd_call_rec_cnt,
	count(callplan_id) as mtd_no_finish_task_c_cnt,	
	0 as mtd_finish_res_c_cnt  ,
	0 as mtd_finish_level6_res_cnt ,
	0 as mtd_finish_level5_res_cnt ,
	0 as mtd_finish_level4_res_cnt ,
	0 as mtd_finish_level3_res_cnt ,
	0 as mtd_finish_level2_res_cnt ,
	0 as mtd_finish_level1_res_cnt ,
	0 as mtd_finish_biz_res_cnt  ,
	0 as mtd_finish_task_c_cnt,
	0 as mtd_call_plan_c_cnt	   
from (
	select 
	callplan_creator_id,
	callplan_status,
	callplan_id,
	callplan_org_id ,
	callplan_creator_name ,
	callplan_createtime ,
	callplan_industry ,
	callplan_industry_name ,
	callplan_dq ,	
	callplan_dq_name ,	
	activity_type,
	row_number()over(partition by callplan_id order by p_date) rn 
	from dw_erp_d_gcdcnewp_plan
	where substr(regexp_replace(callplan_createtime,'-',''),1,8) = p_date
	and substr(regexp_replace(callplan_createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
	and p_date between concat(substr('$date$',1,6),'01') and '$date$'
) plan 
where rn = 1
and callplan_status = 3 
group by plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type

union all 

select 
	plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type,
	sum(case when track_day = $date$ and nvl(call_date,0) =  $date$ then is_valid else 0 end) as valid_call_rec_cnt,
	count(distinct case when track_day = $date$ and nvl(call_date,0) = $date$ and is_valid = 1 then track.user_id else null end ) as  valid_call_c_cnt,
	count(distinct case when track_day = $date$ then track.user_id else null end ) as  call_c_cnt,
	sum(case when track_day = $date$ then 1 else 0 end) as call_rec_cnt,
	0 as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	0 as finish_task_c_cnt,
	0 as call_plan_c_cnt,
	sum(nvl(is_valid,0)) as  mtd_valid_call_rec_cnt,
	count(distinct case when nvl(is_valid,0) = 1 then track.user_id else null end ) as  mtd_valid_call_c_cnt,
	count(distinct track.user_id) as  mtd_call_c_cnt,	
	sum(1) as  mtd_call_rec_cnt,
	0 as mtd_no_finish_task_c_cnt,	
	0 as mtd_finish_res_c_cnt  ,
	0 as mtd_finish_level6_res_cnt ,
	0 as mtd_finish_level5_res_cnt ,
	0 as mtd_finish_level4_res_cnt ,
	0 as mtd_finish_level3_res_cnt ,
	0 as mtd_finish_level2_res_cnt ,
	0 as mtd_finish_level1_res_cnt ,
	0 as mtd_finish_biz_res_cnt  ,
	0 as mtd_finish_task_c_cnt,
	0 as mtd_call_plan_c_cnt
from 
(	select id,uuid,user_id,substr(regexp_replace(createtime,'-',''),1,8) as  track_day,org_id
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
) track 
left join 
(		 select uuid,case when sum(time_long) >60 then 1 else 0 end as is_valid,substr(regexp_replace(call_date,'-',''),1,8) as call_date
		   from call_record 
		where deleteflag  = 0
			and substr(regexp_replace(call_date,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and '$date$'
			and time_long > 0
		  group by uuid,substr(regexp_replace(call_date,'-',''),1,8)
) call_record 
on track.uuid = call_record.uuid
left join 
(select	callplan_id,
		callplan_industry ,
		callplan_industry_name ,
		callplan_dq ,	
		callplan_dq_name ,	
		activity_type,
		userc_id
 from dw_erp_d_gcdcnewp_plan 
where p_date = $date$) plan
on track.user_id = plan.userc_id
group by plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type
union all 
select  plan.callplan_industry ,
		plan.callplan_industry_name ,
		plan.callplan_dq ,	
		plan.callplan_dq_name ,	
		plan.activity_type,
		0 as valid_call_rec_cnt,
		0 as valid_call_c_cnt,
		0 as call_c_cnt,
		0 as call_rec_cnt,
		0 as no_finish_task_c_cnt,	
		sum(case when track_day = $date$ then finish_res_c_cnt else 0 end)  as finish_res_c_cnt,
		sum(case when track_day = $date$ then finish_level6_res_cnt else 0 end)  as finish_level6_res_cnt,
		sum(case when track_day = $date$ then finish_level5_res_cnt else 0 end)  as finish_level5_res_cnt,
		sum(case when track_day = $date$ then finish_level4_res_cnt else 0 end)  as finish_level4_res_cnt,
		sum(case when track_day = $date$ then finish_level3_res_cnt else 0 end)  as finish_level3_res_cnt,
		sum(case when track_day = $date$ then finish_level2_res_cnt else 0 end)  as finish_level2_res_cnt,
		sum(case when track_day = $date$ then finish_level1_res_cnt else 0 end)  as finish_level1_res_cnt,
		sum(case when track_day = $date$ then finish_biz_res_cnt else 0 end)  as finish_biz_res_cnt,
		0 as finish_task_c_cnt,
		0 as call_plan_c_cnt,
		0 as mtd_valid_call_rec_cnt,
		0 as mtd_valid_call_c_cnt,
		0 as mtd_call_c_cnt,
		0 as mtd_call_rec_cnt,
		0 as mtd_no_finish_task_c_cnt,	
		sum(finish_res_c_cnt)  as mtd_finish_res_c_cnt,
		sum(finish_level6_res_cnt)  as mtd_finish_level6_res_cnt,
		sum(finish_level5_res_cnt)  as mtd_finish_level5_res_cnt,
		sum(finish_level4_res_cnt)  as mtd_finish_level4_res_cnt,
		sum(finish_level3_res_cnt)  as mtd_finish_level3_res_cnt,
		sum(finish_level2_res_cnt)  as mtd_finish_level2_res_cnt,
		sum(finish_level1_res_cnt)  as mtd_finish_level1_res_cnt,
		sum(finish_biz_res_cnt)  as mtd_finish_biz_res_cnt,
		0 as mtd_finish_task_c_cnt,
		0 as mtd_call_plan_c_cnt	
from (
	select 
		user_id,
		org_id,substr(regexp_replace(createtime,'-',''),1,8) as  track_day,
		case when instr(combine(cast(action_type as string)) ,2) >0 then 1 else 0 end  as finish_res_c_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt
	from promotion_callplan_log
	where substr(regexp_replace(createtime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and '$date$'
	group by user_id,org_id,substr(regexp_replace(createtime,'-',''),1,8)
)  m_log
left join 
(select	callplan_id,
		callplan_industry ,
		callplan_industry_name ,
		callplan_dq ,	
		callplan_dq_name ,	
		activity_type,
		userc_id
 from dw_erp_d_gcdcnewp_plan 
where p_date = $date$) plan
on m_log.user_id = plan.userc_id
where finish_res_c_cnt > 0
group by  plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type
) fact 
left join dim_dq 
on fact.callplan_dq = dim_dq.d_code
left join dim_industry 
on fact.callplan_industry = dim_industry.d_ind_code
group by  
	fact.callplan_industry ,
	fact.callplan_industry_name ,
	fact.callplan_dq ,	
	fact.callplan_dq_name ,	
	fact.activity_type,
	dim_industry.d_main_industry_code,	
	dim_industry.d_main_industry,		
	dim_dq.d_ch_code,
	dim_dq.d_ch_name;




insert overwrite table fact_h_gcdc_w_newpull_cdc partition(p_date = $date$)
select
	$date$ as d_date,
	concat(dim_date.d_year,d_week) as d_week,
	nvl(fact.creator_id,-1) as gcdc_id,
	nvl(base.name,'未知') as gcdc_name,
	nvl(base.org_id,-1) as org_id,
	nvl(base.org_name,'未知') as org_name,
	sum(call_c_cnt) as call_c_cnt,
	sum(call_rec_cnt) as call_rec_cnt,
	sum(no_finish_task_c_cnt) as no_finish_task_c_cnt,	
	sum(valid_call_c_cnt) as valid_call_c_cnt,
	sum(valid_call_rec_cnt) as valid_call_rec_cnt,
	sum(finish_res_c_cnt) as finish_res_c_cnt  ,
	sum(finish_biz_res_cnt) as finish_biz_res_cnt  ,	
	sum(finish_level6_res_cnt) as finish_level6_res_cnt ,
	sum(finish_level5_res_cnt) as finish_level5_res_cnt ,
	sum(finish_level4_res_cnt) as finish_level4_res_cnt ,
	sum(finish_level3_res_cnt) as finish_level3_res_cnt ,
	sum(finish_level2_res_cnt) as finish_level2_res_cnt ,
	sum(finish_level1_res_cnt) as finish_level1_res_cnt ,
	sum(finish_task_c_cnt) as finish_task_c_cnt,
	sum(call_plan_c_cnt) as call_plan_c_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp
from (
select 
	plan.callplan_creator_id as creator_id,
	0 as valid_call_rec_cnt,
	0 as valid_call_c_cnt,
	0 as call_c_cnt,
	0 as call_rec_cnt,
	0 as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	count(case when is_call_plan_c_cnt = 1 and track.track_day is not null then track.user_id else null end ) as finish_task_c_cnt,
	count(case when is_call_plan_c_cnt = 1 then plan.callplan_id else null end ) as call_plan_c_cnt
from 
(select callplan_id,
		callplan_creator_id ,
		1 as is_call_plan_c_cnt,
		regexp_replace(substr(callplan_createtime,1,10),'-','') as callplan_createtime,
		userc_id
	 from dw_erp_d_gcdcnewp_plan 
	where p_date = $date$
      and regexp_replace(substr(callplan_createtime,1,10),'-','') between {{delta(date,-6)}} and $date$ 
	) plan
left join 
(	select user_id,substr(regexp_replace(min(createtime),'-',''),1,8) as  track_day
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
	group by user_id
) track 
on plan.userc_id = track.user_id
group by plan.callplan_creator_id

union all 
select callplan_creator_id as creator_id,
	0 as valid_call_rec_cnt,
	0 as valid_call_c_cnt,
	0 as call_c_cnt,
	0 as call_rec_cnt,
	count(plan.callplan_id) as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	0 as finish_task_c_cnt,
	0 as call_plan_c_cnt 
from (
	select 
	callplan_creator_id,
	callplan_status,
	callplan_id,
	callplan_org_id ,
	callplan_creator_name ,
	callplan_createtime ,
	callplan_industry ,
	callplan_industry_name ,
	callplan_dq ,	
	callplan_dq_name ,	
	activity_type,
	row_number()over(partition by callplan_id order by p_date) rn 
	from dw_erp_d_gcdcnewp_plan
	where substr(regexp_replace(callplan_createtime,'-',''),1,8) = p_date
	and substr(regexp_replace(callplan_createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
	and p_date between {{delta(date,-6)}} and $date$ 
) plan 
where rn = 1
and callplan_status = 3 
group by callplan_creator_id

union all 

select 
	track.creator_id as creator_id,
	sum(is_valid) as valid_call_rec_cnt,
	count(distinct case when nvl(is_valid,0) = 1 then track.user_id else null end ) as  valid_call_c_cnt,
	count(distinct track.user_id ) as  call_c_cnt,
	sum(1) as call_rec_cnt,
	0 as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	0 as finish_task_c_cnt,
	0 as call_plan_c_cnt
from 
(	select id,uuid,user_id,substr(regexp_replace(createtime,'-',''),1,8) as  track_day,creator_id
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
) track 
left join 
(		 select uuid,case when sum(time_long) >60 then 1 else 0 end as is_valid,substr(regexp_replace(call_date,'-',''),1,8) as call_date
		   from call_record 
		where deleteflag  = 0
			and substr(regexp_replace(call_date,'-',''),1,8)  between {{delta(date,-6)}} and $date$
			and time_long > 0
		  group by uuid,substr(regexp_replace(call_date,'-',''),1,8)
) call_record 
on track.uuid = call_record.uuid
group by track.creator_id
union all 
select creator_id,
		0 as valid_call_rec_cnt,
		0 as valid_call_c_cnt,
		0 as call_c_cnt,
		0 as call_rec_cnt,
		0 as no_finish_task_c_cnt,	
		sum(finish_res_c_cnt)  as finish_res_c_cnt,
		sum(finish_level6_res_cnt)  as finish_level6_res_cnt,
		sum(finish_level5_res_cnt)  as finish_level5_res_cnt,
		sum(finish_level4_res_cnt)  as finish_level4_res_cnt,
		sum(finish_level3_res_cnt)  as finish_level3_res_cnt,
		sum(finish_level2_res_cnt)  as finish_level2_res_cnt,
		sum(finish_level1_res_cnt)  as finish_level1_res_cnt,
		sum(finish_biz_res_cnt)  as finish_biz_res_cnt,
		0 as finish_task_c_cnt,
		0 as call_plan_c_cnt
from (
	select 
		user_id,org_id,
		creator_id,
		case when instr(combine(cast(action_type as string)) ,4) >0 then 1 else 0 end  as finish_res_c_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt
	from promotion_callplan_log
	where regexp_replace(substr(createtime,1,10),'-','') between {{delta(date,-6)}} and $date$
	group by user_id,org_id,creator_id
)  m_log
where finish_res_c_cnt > 0 
group by creator_id
) fact 
left join 
(select id,
		name,
		org_id,
		org_name
	from dw_erp_d_salesuser_base 
	where p_date = $date$
) base
on fact.creator_id = base.id
left join dim_date 
on dim_date.d_date = $date$
group by 
concat(dim_date.d_year,d_week),
fact.creator_id,
base.name,
base.org_id,
base.org_name;	


insert overwrite table fact_h_gcdc_w_newpull_org partition(p_date = $date$)
select
	$date$ as d_date,
	concat(dim_date.d_year,d_week) as d_week,
	nvl(fact.org_id,-1) as org_id,
	nvl(base.org_name,'未知') as org_name,
	sum(call_c_cnt) as call_c_cnt,
	sum(call_rec_cnt) as call_rec_cnt,
	sum(no_finish_task_c_cnt) as no_finish_task_c_cnt,	
	sum(valid_call_c_cnt) as valid_call_c_cnt,
	sum(valid_call_rec_cnt) as valid_call_rec_cnt,
	sum(finish_res_c_cnt) as finish_res_c_cnt  ,
	sum(finish_biz_res_cnt) as finish_biz_res_cnt  ,	
	sum(finish_level6_res_cnt) as finish_level6_res_cnt ,
	sum(finish_level5_res_cnt) as finish_level5_res_cnt ,
	sum(finish_level4_res_cnt) as finish_level4_res_cnt ,
	sum(finish_level3_res_cnt) as finish_level3_res_cnt ,
	sum(finish_level2_res_cnt) as finish_level2_res_cnt ,
	sum(finish_level1_res_cnt) as finish_level1_res_cnt ,
	sum(finish_task_c_cnt) as finish_task_c_cnt,
	sum(call_plan_c_cnt) as call_plan_c_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp
from (
select 
	plan.callplan_org_id as org_id,
	0 as valid_call_rec_cnt,
	0 as valid_call_c_cnt,
	0 as call_c_cnt,
	0 as call_rec_cnt,
	0 as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	count(case when is_call_plan_c_cnt = 1 and track.track_day is not null then track.user_id else null end ) as finish_task_c_cnt,
	count(case when is_call_plan_c_cnt = 1 then plan.callplan_id else null end ) as call_plan_c_cnt
from 
(select callplan_id,
		callplan_org_id ,
		1 as is_call_plan_c_cnt,
		regexp_replace(substr(callplan_createtime,1,10),'-','') as callplan_createtime,
		userc_id
	 from dw_erp_d_gcdcnewp_plan 
	where p_date = $date$
      and regexp_replace(substr(callplan_createtime,1,10),'-','') between {{delta(date,-6)}} and $date$ 
	) plan
left join 
(	select user_id,substr(regexp_replace(min(createtime),'-',''),1,8) as  track_day
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
	group by user_id
) track 
on plan.userc_id = track.user_id
group by plan.callplan_org_id

union all 
select callplan_org_id as org_id,
	0 as valid_call_rec_cnt,
	0 as valid_call_c_cnt,
	0 as call_c_cnt,
	0 as call_rec_cnt,
	count(plan.callplan_id) as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	0 as finish_task_c_cnt,
	0 as call_plan_c_cnt 
from (
	select 
	callplan_creator_id,
	callplan_status,
	callplan_id,
	callplan_org_id ,
	callplan_creator_name ,
	callplan_createtime ,
	callplan_industry ,
	callplan_industry_name ,
	callplan_dq ,	
	callplan_dq_name ,	
	activity_type,
	row_number()over(partition by callplan_id order by p_date) rn 
	from dw_erp_d_gcdcnewp_plan
	where substr(regexp_replace(callplan_createtime,'-',''),1,8) = p_date
	and substr(regexp_replace(callplan_createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
	and p_date between {{delta(date,-6)}} and $date$ 
) plan 
where rn = 1
and callplan_status = 3 
group by callplan_org_id

union all 

select 
	track.org_id as org_id,
	sum(is_valid) as valid_call_rec_cnt,
	count(distinct case when nvl(is_valid,0) = 1 then track.user_id else null end ) as  valid_call_c_cnt,
	count(distinct track.user_id ) as  call_c_cnt,
	sum(1) as call_rec_cnt,
	0 as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	0 as finish_task_c_cnt,
	0 as call_plan_c_cnt
from 
(	select id,uuid,user_id,substr(regexp_replace(createtime,'-',''),1,8) as  track_day,org_id
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
) track 
left join 
(		 select uuid,case when sum(time_long) >60 then 1 else 0 end as is_valid,substr(regexp_replace(call_date,'-',''),1,8) as call_date
		   from call_record 
		where deleteflag  = 0
			and substr(regexp_replace(call_date,'-',''),1,8)  between {{delta(date,-6)}} and $date$
			and time_long > 0
		  group by uuid,substr(regexp_replace(call_date,'-',''),1,8)
) call_record 
on track.uuid = call_record.uuid
group by track.org_id
union all 
select org_id,
		0 as valid_call_rec_cnt,
		0 as valid_call_c_cnt,
		0 as call_c_cnt,
		0 as call_rec_cnt,
		0 as no_finish_task_c_cnt,	
		sum(finish_res_c_cnt)  as finish_res_c_cnt,
		sum(finish_level6_res_cnt)  as finish_level6_res_cnt,
		sum(finish_level5_res_cnt)  as finish_level5_res_cnt,
		sum(finish_level4_res_cnt)  as finish_level4_res_cnt,
		sum(finish_level3_res_cnt)  as finish_level3_res_cnt,
		sum(finish_level2_res_cnt)  as finish_level2_res_cnt,
		sum(finish_level1_res_cnt)  as finish_level1_res_cnt,
		sum(finish_biz_res_cnt)  as finish_biz_res_cnt,
		0 as finish_task_c_cnt,
		0 as call_plan_c_cnt
from (
	select 
		user_id,creator_id,
		org_id,
		case when instr(combine(cast(action_type as string)) ,4) >0 then 1 else 0 end  as finish_res_c_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt
	from promotion_callplan_log
	where regexp_replace(substr(createtime,1,10),'-','') between {{delta(date,-6)}} and $date$
	group by user_id,creator_id,org_id
)  m_log
where finish_res_c_cnt > 0 
group by org_id
) fact 
left join 
(select d_org_id as id,
		org_name
	from dim_org 
) base
on fact.org_id = base.id
left join dim_date 
on dim_date.d_date = $date$
group by 
concat(dim_date.d_year,d_week),
fact.org_id,
base.org_name;

insert overwrite table fact_h_gcdc_w_newpull_plan partition(p_date = $date$)
select
	$date$ as d_date,
	concat(dim_date.d_year,d_week) as d_week,
	nvl(fact.callplan_industry,'999'),
	nvl(fact.callplan_industry_name,'其他'),
	nvl(act.callplan_dq,'999') as callplan_dq ,	
	nvl(act.callplan_dq_name,'不限') as callplan_dq_name ,	
	fact.activity_type,
	case when fact.activity_type = '1' then '市场活动'
		 when fact.activity_type = '2' then '品牌活动'
		 when fact.activity_type = '3' then 'BI线上流量'
		 when fact.activity_type = '4' then '销售活动'
		 when fact.activity_type = '5' then '线上BD活动'
		 else  '未知' 
		 end as activity_type_name,
	sum(call_c_cnt) as call_c_cnt,
	sum(call_rec_cnt) as call_rec_cnt,
	sum(no_finish_task_c_cnt) as no_finish_task_c_cnt,	
	sum(valid_call_c_cnt) as valid_call_c_cnt,
	sum(valid_call_rec_cnt) as valid_call_rec_cnt,
	sum(finish_res_c_cnt) as finish_res_c_cnt  ,
	sum(finish_biz_res_cnt) as finish_biz_res_cnt  ,	
	sum(finish_level6_res_cnt) as finish_level6_res_cnt ,
	sum(finish_level5_res_cnt) as finish_level5_res_cnt ,
	sum(finish_level4_res_cnt) as finish_level4_res_cnt ,
	sum(finish_level3_res_cnt) as finish_level3_res_cnt ,
	sum(finish_level2_res_cnt) as finish_level2_res_cnt ,
	sum(finish_level1_res_cnt) as finish_level1_res_cnt ,
	sum(finish_task_c_cnt) as finish_task_c_cnt,
	sum(call_plan_c_cnt) as call_plan_c_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp,
	nvl(dim_dq.d_ch_code,'999') as city ,
	nvl(dim_dq.d_ch_name,'不限') as city_name ,
	nvl(dim_industry.d_main_industry_code,	'999') as main_industry,	
	nvl(dim_industry.d_main_industry,'其他') as main_industry_name

from (
select 
	plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type,
	0 as valid_call_rec_cnt,
	0 as valid_call_c_cnt,
	0 as call_c_cnt,
	0 as call_rec_cnt,
	0 as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	count(case when is_call_plan_c_cnt = 1 and track.track_day is not null then track.user_id else null end ) as finish_task_c_cnt,
	count(case when is_call_plan_c_cnt = 1 then plan.callplan_id else null end ) as call_plan_c_cnt
from 
(select callplan_id,
		callplan_org_id ,
		callplan_creator_name ,
		callplan_createtime ,
		callplan_industry ,
		callplan_industry_name ,
		callplan_dq ,	
		callplan_dq_name ,	
		activity_type,
		1 as is_call_plan_c_cnt,
		userc_id
	 from dw_erp_d_gcdcnewp_plan 
	where p_date = $date$
      and regexp_replace(substr(callplan_createtime,1,10),'-','') between {{delta(date,-6)}} and $date$ 
	) plan
left join 
(	select user_id,substr(regexp_replace(min(createtime),'-',''),1,8) as  track_day
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
	group by user_id
) track 
on plan.userc_id = track.user_id
group by 	plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type

union all 
select plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type,
	0 as valid_call_rec_cnt,
	0 as valid_call_c_cnt,
	0 as call_c_cnt,
	0 as call_rec_cnt,
	count(plan.callplan_id) as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	0 as finish_task_c_cnt,
	0 as call_plan_c_cnt 
from (
	select 
	callplan_creator_id,
	callplan_status,
	callplan_id,
	callplan_org_id ,
	callplan_creator_name ,
	callplan_createtime ,
	callplan_industry ,
	callplan_industry_name ,
	callplan_dq ,	
	callplan_dq_name ,	
	activity_type,
	row_number()over(partition by callplan_id order by p_date) rn 
	from dw_erp_d_gcdcnewp_plan
	where substr(regexp_replace(callplan_createtime,'-',''),1,8) = p_date
	and substr(regexp_replace(callplan_createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
	and p_date between {{delta(date,-6)}} and $date$ 
) plan 
where rn = 1
and callplan_status = 3 
group by plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type

union all 

select 
	plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type,
	sum(is_valid) as valid_call_rec_cnt,
	count(distinct case when nvl(is_valid,0) = 1 then track.user_id else null end ) as  valid_call_c_cnt,
	count(distinct track.user_id ) as  call_c_cnt,
	sum(1) as call_rec_cnt,
	0 as no_finish_task_c_cnt,	
	0 as finish_res_c_cnt  ,
	0 as finish_level6_res_cnt ,
	0 as finish_level5_res_cnt ,
	0 as finish_level4_res_cnt ,
	0 as finish_level3_res_cnt ,
	0 as finish_level2_res_cnt ,
	0 as finish_level1_res_cnt ,
	0 as finish_biz_res_cnt  ,
	0 as finish_task_c_cnt,
	0 as call_plan_c_cnt
from 
(	select id,uuid,user_id,substr(regexp_replace(createtime,'-',''),1,8) as  track_day,org_id
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
) track 
left join 
(		 select uuid,case when sum(time_long) >60 then 1 else 0 end as is_valid,substr(regexp_replace(call_date,'-',''),1,8) as call_date
		   from call_record 
		where deleteflag  = 0
			and substr(regexp_replace(call_date,'-',''),1,8)  between {{delta(date,-6)}} and $date$
			and time_long > 0
		  group by uuid,substr(regexp_replace(call_date,'-',''),1,8)
) call_record 
on track.uuid = call_record.uuid
left join 
(select	callplan_id,
		callplan_industry ,
		callplan_industry_name ,
		callplan_dq ,	
		callplan_dq_name ,	
		activity_type,
		userc_id
 from dw_erp_d_gcdcnewp_plan 
where p_date = $date$) plan
on track.user_id = plan.userc_id
group by plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type
union all 
select  plan.callplan_industry ,
		plan.callplan_industry_name ,
		plan.callplan_dq ,	
		plan.callplan_dq_name ,	
		plan.activity_type,
		0 as valid_call_rec_cnt,
		0 as valid_call_c_cnt,
		0 as call_c_cnt,
		0 as call_rec_cnt,
		0 as no_finish_task_c_cnt,	
		sum(finish_res_c_cnt)  as finish_res_c_cnt,
		sum(finish_level6_res_cnt)  as finish_level6_res_cnt,
		sum(finish_level5_res_cnt)  as finish_level5_res_cnt,
		sum(finish_level4_res_cnt)  as finish_level4_res_cnt,
		sum(finish_level3_res_cnt)  as finish_level3_res_cnt,
		sum(finish_level2_res_cnt)  as finish_level2_res_cnt,
		sum(finish_level1_res_cnt)  as finish_level1_res_cnt,
		sum(finish_biz_res_cnt)  as finish_biz_res_cnt,
		0 as finish_task_c_cnt,
		0 as call_plan_c_cnt
from (
	select 
		user_id,creator_id,
		org_id,
		case when instr(combine(cast(action_type as string)) ,2) >0 then 1 else 0 end  as finish_res_c_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and max(resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt
	from promotion_callplan_log
	where regexp_replace(substr(createtime,1,10),'-','') between {{delta(date,-6)}} and $date$
	group by user_id,creator_id,org_id
)  m_log
left join 
(select	callplan_id,
		callplan_industry ,
		callplan_industry_name ,
		callplan_dq ,	
		callplan_dq_name ,	
		activity_type,
		userc_id
 from dw_erp_d_gcdcnewp_plan 
where p_date = $date$) plan
on m_log.user_id = plan.userc_id
where finish_res_c_cnt > 0 
group by  plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type
) fact 
left join dim_date 
on dim_date.d_date = $date$
left join dim_dq 
on fact.callplan_dq = dim_dq.d_code
left join dim_industry 
on fact.callplan_industry = dim_industry.d_ind_code
group by  
	fact.callplan_industry ,
	fact.callplan_industry_name ,
	fact.callplan_dq ,	
	fact.callplan_dq_name ,	
	fact.activity_type,
	concat(dim_date.d_year,d_week),
	dim_industry.d_main_industry_code,	
	dim_industry.d_main_industry,		
	dim_dq.d_ch_code,
	dim_dq.d_ch_name;