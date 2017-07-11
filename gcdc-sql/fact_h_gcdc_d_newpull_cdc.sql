表：
fact_h_gcdc_d_newpull_cdc_new
fact_h_gcdc_d_newpull_org_new
新增字段：
 activity_type string COMMENT ' 拉新活动类型 1:BI线上流量，2:市场活动流量，3:市场手动导入', 
 activity_type_name string COMMENT ' 拉新活动类型名称 ', 
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
  mtd_junior_res_cnt int COMMENT '月累计初级简历预估数',
  mtd_junior_res_ratio float COMMENT '月累计初级简历预估率',
  mtd_initiative_res_cnt int COMMENT '月累计经理人拉新成功',
  mtd_cover_ratio float COMMENT '月累计覆盖率',
表：
fact_h_gcdc_w_newpull_cdc_new
fact_h_gcdc_w_newpull_org_new
新增字段：
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
表：
fact_h_gcdc_d_newpull_plan_new
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
   pool_user_cnt float COMMENT '入库数据', 
  mtd_junior_res_cnt int COMMENT '月累计初级简历预估数',
  mtd_junior_res_ratio float COMMENT '月累计初级简历预估率',
  mtd_initiative_res_cnt int COMMENT '月累计经理人拉新成功',
  mtd_cover_ratio float COMMENT '月累计覆盖率',   
    mtd_pool_user_cnt float COMMENT '入库数据',    
表：   
fact_h_gcdc_w_newpull_plan_new
新增字段：
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
  pool_user_cnt float COMMENT '入库数据', 



CREATE TABLE fact_h_gcdc_d_newpull_cdc_new(
  d_date int COMMENT ' 统计日期 ', 
  gcdc_id int COMMENT ' gcdc顾问 ', 
  gcdc_name string COMMENT ' gcdc顾问名称 ', 
  org_id int COMMENT ' 所属部门 ', 
  org_name string COMMENT ' 所属部门名称 ', 
  activity_type string COMMENT ' 拉新活动类型 1:BI线上流量，2:市场活动流量，3:市场手动导入', 
  activity_type_name string COMMENT ' 拉新活动类型名称 ', 
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
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
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
  mtd_junior_res_cnt int COMMENT '月累计初级简历预估数',
  mtd_junior_res_ratio float COMMENT '月累计初级简历预估率',
  mtd_initiative_res_cnt int COMMENT '月累计经理人拉新成功',
  mtd_cover_ratio float COMMENT '月累计覆盖率',
  creation_timestamp timestamp COMMENT ' 时间戳 ')
PARTITIONED BY ( p_date int)
COMMENT '职业顾问拉新统计报表-顾问粒度';

CREATE TABLE fact_h_gcdc_d_newpull_cdc_new(
  d_date int COMMENT ' 统计日期 ', 
  gcdc_id int COMMENT ' gcdc顾问 ', 
  gcdc_name varchar(50) COMMENT ' gcdc顾问名称 ', 
  org_id int COMMENT ' 所属部门 ', 
  org_name varchar(200) COMMENT ' 所属部门名称 ', 
  activity_type varchar(50) COMMENT ' 拉新活动类型 1:BI线上流量，2:市场活动流量，3:市场手动导入', 
  activity_type_name varchar(50) COMMENT ' 拉新活动类型名称 ', 
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
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
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
  mtd_junior_res_cnt int COMMENT '月累计初级简历预估数',
  mtd_junior_res_ratio float COMMENT '月累计初级简历预估率',
  mtd_initiative_res_cnt int COMMENT '月累计经理人拉新成功',
  mtd_cover_ratio float COMMENT '月累计覆盖率',
  creation_timestamp timestamp default current_timestamp COMMENT ' 时间戳 ',
  primary key (d_date,gcdc_id,org_id,activity_type)
 )COMMENT '职业顾问拉新统计报表-顾问粒度';


insert overwrite table fact_h_gcdc_d_newpull_cdc_new partition(p_date = $date$)
select
	$date$ as d_date,
	nvl(fact.creator_id,-1) as gcdc_id,
	nvl(base.name,'未知') as gcdc_name,
	nvl(base.org_id,-1) as org_id,
	nvl(base.org_name,'未知') as org_name,
	nvl(fact.activity_type,-1) as activity_type,
	case fact.activity_type when 1 then 'BI线上流量' when 2 then '市场活动流量' when 3 then '市场手动导入' else '其他' end as activity_type_name,
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
	sum(junior_res_cnt) as junior_res_cnt,
	sum(junior_res_cnt) / sum(call_c_cnt) as junior_res_ratio,
	sum(initiative_res_cnt) as initiative_res_cnt,
	sum(call_c_cnt) / (sum(call_c_cnt) + sum(no_finish_task_c_cnt)) as cover_ratio,
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
	sum(mtd_junior_res_cnt) as mtd_junior_res_cnt,
	sum(mtd_junior_res_cnt) / sum(mtd_call_c_cnt) as mtd_junior_res_ratio,
	sum(mtd_initiative_res_cnt) as mtd_initiative_res_cnt,
	sum(mtd_call_c_cnt) / (sum(mtd_call_c_cnt) + sum(mtd_no_finish_task_c_cnt)) as mtd_cover_ratio,	
	from_unixtime(unix_timestamp()) as creation_timestamp
from (
select 
	plan.callplan_creator_id as creator_id,
	plan.activity_type,
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
	count(case when plan.is_mtd_call_plan_c_cnt = 1 then plan.callplan_id else null end ) as mtd_call_plan_c_cnt,
		0 as initiative_res_cnt,
	0 as junior_res_cnt,
	0 as mtd_initiative_res_cnt,
	0 as mtd_junior_res_cnt  
from 
(select	callplan_id,
		callplan_creator_id ,
		callplan_creator_name ,
		callplan_createtime ,
		regexp_replace(callplan_finishtime,'-','') as callplan_finishtime,
		cast(substr(regexp_replace(callplan_createtime,'-',''),1,8) as int) as callplan_date,
		case when substr(regexp_replace(callplan_createtime,'-',''),1,8) = '$date$' then 1 else 0 end as is_call_plan_c_cnt,
		1 as is_mtd_call_plan_c_cnt,
		userc_id,
		activity_type
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
group by plan.callplan_creator_id,plan.activity_type
union all 
select callplan_creator_id as creator_id,
activity_type,
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
	0 as mtd_call_plan_c_cnt,
		0 as initiative_res_cnt,
	0 as junior_res_cnt,
	0 as mtd_initiative_res_cnt,
	0 as mtd_junior_res_cnt  
from (
	select 
	callplan_creator_id,
	callplan_id,
	callplan_status,
	row_number()over(partition by callplan_id order by p_date) rn ,activity_type
	from dw_erp_d_gcdcnewp_plan
	where substr(regexp_replace(callplan_createtime,'-',''),1,8) = p_date
	and substr(regexp_replace(callplan_createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
	and p_date between concat(substr('$date$',1,6),'01') and '$date$'
) plan 
where rn = 1
and callplan_status = 3 
group by callplan_creator_id,activity_type

union all 

select 
	track.creator_id as creator_id,
	track.activity_type,
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
	0 as mtd_call_plan_c_cnt,
	0 as initiative_res_cnt,
	count(case when track.track_day = $date$ and track.status = 6 then track.user_id else null end) as junior_res_cnt,
	0 as mtd_initiative_res_cnt,
	count(case when track.status = 6 then track.user_id else null end) as mtd_junior_res_cnt  
from 
(	select track.id,track.uuid,substr(regexp_replace(track.createtime,'-',''),1,8) as  track_day,track.creator_id,track.user_id,plan.source as activity_type,track.status
	from  promotion_track track
	join promotion_callplan plan 
	on track.user_id = plan.user_id
	where substr(regexp_replace(track.createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
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
group by track.creator_id,track.activity_type
union all 
select creator_id,activity_type,
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
		0 as mtd_call_plan_c_cnt,
		sum(case when track_day = $date$ then initiative_res_cnt else 0 end)  as initiative_res_cnt ,
		0 as junior_res_cnt,
		sum(initiative_res_cnt) as mtd_initiative_res_cnt,
		0 as mtd_junior_res_cnt
from (
	select 
		log.user_id,log.org_id,plan.source as activity_type,
		log.creator_id,substr(regexp_replace(log.createtime,'-',''),1,8) as  track_day,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 then 1 else 0 end  as finish_res_c_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,4) >0 and max(log.resume_level) > 1 then 1 else 0 end  as initiative_res_cnt		
	from promotion_callplan_log log 
	join promotion_callplan plan 
	on log.user_id = plan.user_id
	where substr(regexp_replace(log.createtime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and '$date$'
	group by log.user_id,log.org_id,log.creator_id,substr(regexp_replace(log.createtime,'-',''),1,8),plan.source
)  m_log
where finish_res_c_cnt > 0 or initiative_res_cnt > 0
group by creator_id,activity_type
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
base.org_name,
fact.activity_type;


CREATE TABLE fact_h_gcdc_d_newpull_org_new(
  d_date int COMMENT ' 统计日期 ', 
  org_id int COMMENT ' 所属部门 ', 
  org_name string COMMENT ' 所属部门名称 ', 
  activity_type string COMMENT ' 拉新活动类型 1:BI线上流量，2:市场活动流量，3:市场手动导入', 
  activity_type_name string COMMENT ' 拉新活动类型名称 ', 
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
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
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
  mtd_junior_res_cnt int COMMENT '月累计初级简历预估数',
  mtd_junior_res_ratio float COMMENT '月累计初级简历预估率',
  mtd_initiative_res_cnt int COMMENT '月累计经理人拉新成功',
  mtd_cover_ratio float COMMENT '月累计覆盖率',
  creation_timestamp timestamp COMMENT ' 时间戳 ')
PARTITIONED BY ( p_date int)
COMMENT '职业顾问拉新统计报表-团队粒度';

CREATE TABLE fact_h_gcdc_d_newpull_org_new(
  d_date int COMMENT ' 统计日期 ', 
  org_id int COMMENT ' 所属部门 ', 
  org_name varchar(200) COMMENT ' 所属部门名称 ', 
  activity_type varchar(50) COMMENT ' 拉新活动类型 1:BI线上流量，2:市场活动流量，3:市场手动导入', 
  activity_type_name varchar(50) COMMENT ' 拉新活动类型名称 ', 
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
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
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
  mtd_junior_res_cnt int COMMENT '月累计初级简历预估数',
  mtd_junior_res_ratio float COMMENT '月累计初级简历预估率',
  mtd_initiative_res_cnt int COMMENT '月累计经理人拉新成功',
  mtd_cover_ratio float COMMENT '月累计覆盖率',
  creation_timestamp timestamp default current_timestamp COMMENT ' 时间戳 ',
  primary key (d_date,org_id,activity_type)
 )COMMENT '职业顾问拉新统计报表-团队粒度';

insert overwrite table fact_h_gcdc_d_newpull_org_new partition(p_date = $date$)
select
	$date$ as d_date,
	nvl(fact.org_id,-1) as org_id,
	nvl(base.org_name,'未知') as org_name,
	nvl(fact.activity_type,-1) as activity_type,
	case fact.activity_type when 1 then 'BI线上流量' when 2 then '市场活动流量' when 3 then '市场手动导入' else '其他' end as activity_type_name,
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
	sum(junior_res_cnt) as junior_res_cnt,
	sum(junior_res_cnt) / sum(call_c_cnt) as junior_res_ratio,
	sum(initiative_res_cnt) as initiative_res_cnt,
	sum(call_c_cnt) / (sum(call_c_cnt) + sum(no_finish_task_c_cnt)) as cover_ratio,
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
	sum(mtd_junior_res_cnt) as mtd_junior_res_cnt,
	sum(mtd_junior_res_cnt) / sum(mtd_call_c_cnt) as mtd_junior_res_ratio,
	sum(mtd_initiative_res_cnt) as mtd_initiative_res_cnt,
	sum(mtd_call_c_cnt) / (sum(mtd_call_c_cnt) + sum(mtd_no_finish_task_c_cnt)) as mtd_cover_ratio,	
	from_unixtime(unix_timestamp()) as creation_timestamp
from (
select 
	plan.callplan_org_id as org_id,
	plan.activity_type,
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
	count(case when plan.is_mtd_call_plan_c_cnt = 1 then plan.callplan_id else null end ) as mtd_call_plan_c_cnt,
		0 as initiative_res_cnt,
	0 as junior_res_cnt,
	0 as mtd_initiative_res_cnt,
	0 as mtd_junior_res_cnt  
from 
(select	callplan_id,
		callplan_org_id ,
		callplan_creator_name ,
		callplan_createtime ,
		regexp_replace(callplan_finishtime,'-','') as callplan_finishtime,
		cast(substr(regexp_replace(callplan_createtime,'-',''),1,8) as int) as callplan_date,
		case when substr(regexp_replace(callplan_createtime,'-',''),1,8) = '$date$' then 1 else 0 end as is_call_plan_c_cnt,
		1 as is_mtd_call_plan_c_cnt,
		userc_id,
		activity_type
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
group by plan.callplan_org_id,plan.activity_type
union all 
select callplan_org_id as org_id,
	activity_type,
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
	0 as mtd_call_plan_c_cnt,
		0 as initiative_res_cnt,
	0 as junior_res_cnt,
	0 as mtd_initiative_res_cnt,
	0 as mtd_junior_res_cnt  
from (
	select 
	callplan_org_id,
	callplan_id,
	callplan_status,
	row_number()over(partition by callplan_id order by p_date) rn ,activity_type
	from dw_erp_d_gcdcnewp_plan
	where substr(regexp_replace(callplan_createtime,'-',''),1,8) = p_date
	and substr(regexp_replace(callplan_createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
	and p_date between concat(substr('$date$',1,6),'01') and '$date$'
) plan 
where rn = 1
and callplan_status = 3 
group by callplan_org_id,activity_type

union all 

select 
	track.org_id,
	track.activity_type,
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
	0 as mtd_call_plan_c_cnt,
	0 as initiative_res_cnt,
	count(case when track.track_day = $date$ and track.status = 6 then track.user_id else null end) as junior_res_cnt,
	0 as mtd_initiative_res_cnt,
	count(case when track.status = 6 then track.user_id else null end) as mtd_junior_res_cnt  
from 
(	select track.id,track.uuid,substr(regexp_replace(track.createtime,'-',''),1,8) as  track_day,track.creator_id,track.user_id,plan.source as activity_type,track.status,track.org_id
	from  promotion_track track
	join promotion_callplan plan 
	on track.user_id = plan.user_id
	where substr(regexp_replace(track.createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
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
group by track.org_id,track.activity_type
union all 
select org_id,activity_type,
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
		0 as mtd_call_plan_c_cnt,
		sum(case when track_day = $date$ then initiative_res_cnt else 0 end)  as initiative_res_cnt ,
		0 as junior_res_cnt,
		sum(initiative_res_cnt) as mtd_initiative_res_cnt,
		0 as mtd_junior_res_cnt
from (
	select 
		log.user_id,log.org_id,plan.source as activity_type,
		log.creator_id,substr(regexp_replace(log.createtime,'-',''),1,8) as  track_day,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 then 1 else 0 end  as finish_res_c_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,4) >0 and max(log.resume_level) > 1 then 1 else 0 end  as initiative_res_cnt		
	from promotion_callplan_log log 
	join promotion_callplan plan 
	on log.user_id = plan.user_id
	where substr(regexp_replace(log.createtime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and '$date$'
	group by log.user_id,log.org_id,log.creator_id,substr(regexp_replace(log.createtime,'-',''),1,8),plan.source
)  m_log
where finish_res_c_cnt > 0 or initiative_res_cnt > 0
group by org_id,activity_type
) fact 
left join 
(select d_org_id as id,
		org_name
	from dim_org 
) base
on fact.org_id = base.id
group by fact.org_id,
base.org_name,
fact.activity_type;




CREATE TABLE fact_h_gcdc_d_newpull_plan_new(
  d_date int COMMENT ' 统计日期 ', 
  industry string COMMENT ' 经理人行业 ', 
  industry_name string COMMENT ' 经理人行业名称 ', 
  dq string COMMENT '活动地区或经理人地区', 
  dq_name string COMMENT '活动地区或经理人地区', 
  activity_type string COMMENT ' 拉新活动类型 1:BI线上流量，2:市场活动流量，3:市场手动导入', 
  activity_type_name string COMMENT ' 拉新活动类型名称 ', 
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
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
  pool_user_cnt float COMMENT '入库数据',  
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
  mtd_junior_res_cnt int COMMENT '月累计初级简历预估数',
  mtd_junior_res_ratio float COMMENT '月累计初级简历预估率',
  mtd_initiative_res_cnt int COMMENT '月累计经理人拉新成功',
  mtd_cover_ratio float COMMENT '月累计覆盖率',
  mtd_pool_user_cnt float COMMENT '月累计入库数据', 
  creation_timestamp timestamp COMMENT ' 时间戳 ')
PARTITIONED BY ( p_date int)
COMMENT '职业顾问拉新统计报表-经理人粒度';

CREATE TABLE fact_h_gcdc_d_newpull_plan_new(
  d_date int COMMENT ' 统计日期 ', 
  industry varchar(20) COMMENT ' 经理人行业 ', 
  industry_name varchar(50) COMMENT ' 经理人行业名称 ', 
  dq varchar(20) COMMENT '活动地区或经理人地区', 
  dq_name varchar(50) COMMENT '活动地区或经理人地区', 
  activity_type varchar(20) COMMENT ' 拉新活动类型 1:BI线上流量，2:市场活动流量，3:市场手动导入', 
  activity_type_name varchar(50) COMMENT ' 拉新活动类型名称 ',
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
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
  pool_user_cnt float COMMENT '入库数据', 
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
  mtd_junior_res_cnt int COMMENT '月累计初级简历预估数',
  mtd_junior_res_ratio float COMMENT '月累计初级简历预估率',
  mtd_initiative_res_cnt int COMMENT '月累计经理人拉新成功',
  mtd_cover_ratio float COMMENT '月累计覆盖率',
  mtd_pool_user_cnt float COMMENT '月累计入库数据', 
  creation_timestamp timestamp default current_timestamp COMMENT ' 时间戳 ',
  primary key (d_date,industry,dq,activity_type)
 )COMMENT '职业顾问拉新统计报表-经理人粒度';



insert overwrite table fact_h_gcdc_d_newpull_plan_new partition(p_date = $date$)
select
	$date$ as d_date,
	nvl(fact.callplan_industry,'999') as callplan_industry ,
	nvl(fact.callplan_industry_name,'其他') as callplan_industry_name ,
	nvl(fact.callplan_dq,'999') as callplan_dq ,	
	nvl(fact.callplan_dq_name,'不限') as callplan_dq_name,
	nvl(fact.activity_type,-1) as activity_type,
	case fact.activity_type when 1 then 'BI线上流量' when 2 then '市场活动流量' when 3 then '市场手动导入' else '其他' end as activity_type_name,
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
	sum(junior_res_cnt) as junior_res_cnt,
	sum(junior_res_cnt) / sum(call_c_cnt) as junior_res_ratio,
	sum(initiative_res_cnt) as initiative_res_cnt,
	sum(call_c_cnt) / (sum(call_c_cnt) + sum(no_finish_task_c_cnt)) as cover_ratio,
	sum(pool_user_cnt) as pool_user_cnt, 
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
	sum(mtd_junior_res_cnt) as mtd_junior_res_cnt,
	sum(mtd_junior_res_cnt) / sum(mtd_call_c_cnt) as mtd_junior_res_ratio,
	sum(mtd_initiative_res_cnt) as mtd_initiative_res_cnt,
	sum(mtd_call_c_cnt) / (sum(mtd_call_c_cnt) + sum(mtd_no_finish_task_c_cnt)) as mtd_cover_ratio,
	sum(mtd_pool_user_cnt) as mtd_pool_user_cnt, 	
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
	count(case when plan.is_mtd_call_plan_c_cnt = 1 then plan.callplan_id else null end ) as mtd_call_plan_c_cnt,
		0 as initiative_res_cnt,
	0 as junior_res_cnt,
	0 as mtd_initiative_res_cnt,
	0 as mtd_junior_res_cnt,
	0 as pool_user_cnt,
	0 as mtd_pool_user_cnt
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
	0 as mtd_call_plan_c_cnt,
		0 as initiative_res_cnt,
	0 as junior_res_cnt,
	0 as mtd_initiative_res_cnt,
	0 as mtd_junior_res_cnt,
	0 as pool_user_cnt,
	0 as mtd_pool_user_cnt
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
and callplan_status in (1,2,3) 
group by  plan.callplan_industry ,
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
	0 as mtd_call_plan_c_cnt,
	0 as initiative_res_cnt,
	count(case when track.track_day = $date$ and track.status = 6 then track.user_id else null end) as junior_res_cnt,
	0 as mtd_initiative_res_cnt,
	count(case when track.status = 6 then track.user_id else null end) as mtd_junior_res_cnt ,
	0 as pool_user_cnt,
	0 as mtd_pool_user_cnt 
from 
(	select track.id,track.uuid,substr(regexp_replace(track.createtime,'-',''),1,8) as  track_day,track.creator_id,track.user_id,track.status,track.org_id
	from  promotion_track track
	where substr(regexp_replace(track.createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
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
		0 as mtd_call_plan_c_cnt,
		sum(case when track_day = $date$ then initiative_res_cnt else 0 end)  as initiative_res_cnt ,
		0 as junior_res_cnt,
		sum(initiative_res_cnt) as mtd_initiative_res_cnt,
		0 as mtd_junior_res_cnt,
		0 as pool_user_cnt,
		0 as mtd_pool_user_cnt
from (
	select 
		log.user_id,log.org_id,
		log.creator_id,substr(regexp_replace(log.createtime,'-',''),1,8) as  track_day,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 then 1 else 0 end  as finish_res_c_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,4) >0 and max(log.resume_level) > 1 then 1 else 0 end  as initiative_res_cnt		
	from promotion_callplan_log log 
	where substr(regexp_replace(log.createtime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and '$date$'
	group by log.user_id,log.org_id,log.creator_id,substr(regexp_replace(log.createtime,'-',''),1,8)
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
where finish_res_c_cnt > 0 or initiative_res_cnt > 0
group by  plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type
union all 
select null as callplan_industry ,
		null as callplan_industry_name ,
		null as callplan_dq ,	
		null as callplan_dq_name ,
		source as activity_type,
		0 as valid_call_rec_cnt,
		0 as valid_call_c_cnt,
		0 as call_c_cnt,
		0 as call_rec_cnt,
		0 as no_finish_task_c_cnt,	
		0 as finish_res_c_cnt,
		0 as finish_level6_res_cnt,
		0 as finish_level5_res_cnt,
		0 as finish_level4_res_cnt,
		0 as finish_level3_res_cnt,
		0 as finish_level2_res_cnt,
		0 as finish_level1_res_cnt,
		0 as finish_biz_res_cnt,
		0 as finish_task_c_cnt,
		0 as call_plan_c_cnt,
		0 as mtd_valid_call_rec_cnt,
		0 as mtd_valid_call_c_cnt,
		0 as mtd_call_c_cnt,
		0 as mtd_call_rec_cnt,
		0 as mtd_no_finish_task_c_cnt,	
		0 as mtd_finish_res_c_cnt,
		0 as mtd_finish_level6_res_cnt,
		0 as mtd_finish_level5_res_cnt,
		0 as mtd_finish_level4_res_cnt,
		0 as mtd_finish_level3_res_cnt,
		0 as mtd_finish_level2_res_cnt,
		0 as mtd_finish_level1_res_cnt,
		0 as mtd_finish_biz_res_cnt,
		0 as mtd_finish_task_c_cnt,
		0 as mtd_call_plan_c_cnt,
		0  as initiative_res_cnt ,
		0 as junior_res_cnt,
		0 as mtd_initiative_res_cnt,
		0 as mtd_junior_res_cnt,		
		count(distinct case when substr(regexp_replace(createtime,'-',''),1,8) = '$date$' then user_id else null end) as pool_user_cnt,
		count(distinct user_id) as mtd_pool_user_cnt
   from promotion_pool
   where substr(regexp_replace(createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$' 
   group by source
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




CREATE TABLE fact_h_gcdc_w_newpull_cdc_new(
  d_date int COMMENT ' 统计日期 ', 
  gcdc_id int COMMENT ' gcdc顾问 ', 
  gcdc_name string COMMENT ' gcdc顾问名称 ', 
  org_id int COMMENT ' 所属部门 ', 
  org_name string COMMENT ' 所属部门名称 ', 
  activity_type string COMMENT ' 拉新活动类型 1:BI线上流量，2:市场活动流量，3:市场手动导入', 
  activity_type_name string COMMENT ' 拉新活动类型名称 ', 
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
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
  creation_timestamp timestamp COMMENT ' 时间戳 ')
COMMENT '职业顾问拉新统计报表-周-顾问粒度'
PARTITIONED BY ( p_date int);

CREATE TABLE fact_h_gcdc_w_newpull_cdc_new(
  d_date int COMMENT ' 统计日期 ', 
  gcdc_id int COMMENT ' gcdc顾问 ', 
  gcdc_name varchar(50) COMMENT ' gcdc顾问名称 ', 
  org_id int COMMENT ' 所属部门 ', 
  org_name varchar(200) COMMENT ' 所属部门名称 ', 
  activity_type varchar(50) COMMENT ' 拉新活动类型 1:BI线上流量，2:市场活动流量，3:市场手动导入', 
  activity_type_name varchar(50) COMMENT ' 拉新活动类型名称 ', 
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
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
  creation_timestamp timestamp default current_timestamp COMMENT ' 时间戳 ',
  primary key (d_date,gcdc_id,org_id,activity_type)
 ) COMMENT '职业顾问拉新统计报表-周-顾问粒度';



insert overwrite table fact_h_gcdc_w_newpull_cdc_new partition(p_date = $date$)
select
	$date$ as d_date,
	nvl(fact.creator_id,-1) as gcdc_id,
	nvl(base.name,'未知') as gcdc_name,
	nvl(base.org_id,-1) as org_id,
	nvl(base.org_name,'未知') as org_name,
	nvl(fact.activity_type,-1) as activity_type,
	case fact.activity_type when 1 then 'BI线上流量' when 2 then '市场活动流量' when 3 then '市场手动导入' else '其他' end as activity_type_name,
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
	sum(junior_res_cnt) as junior_res_cnt,
	sum(junior_res_cnt) / sum(call_c_cnt) as junior_res_ratio,
	sum(initiative_res_cnt) as initiative_res_cnt,
	sum(call_c_cnt) / (sum(call_c_cnt) + sum(no_finish_task_c_cnt)) as cover_ratio
	from_unixtime(unix_timestamp()) as creation_timestamp
from (
select 
	plan.callplan_creator_id as creator_id,
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
		0 as initiative_res_cnt,
	0 as junior_res_cnt
from 
(select	 callplan_id,
		callplan_creator_id ,
		1 as is_call_plan_c_cnt,
		regexp_replace(substr(callplan_createtime,1,10),'-','') as callplan_createtime,
		userc_id,
		activity_type
 from dw_erp_d_gcdcnewp_plan 
where p_date = $date$
  and substr(regexp_replace(callplan_createtime,'-',''),1,8)  between {{delta(date,-6)}} and $date$ 
) plan
left join 
(	select user_id,substr(regexp_replace(min(createtime),'-',''),1,8) as  track_day
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
	group by user_id
) track 
on plan.userc_id = track.user_id
group by plan.callplan_creator_id,plan.activity_type
union all 
select callplan_creator_id as creator_id,
activity_type,
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
	0 as initiative_res_cnt,
	0 as junior_res_cnt
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
and callplan_status in (1,2,3)
group by callplan_creator_id,activity_type

union all 

select 
	track.creator_id as creator_id,
	track.activity_type,
	sum(nvl(is_valid,0)) as  valid_call_rec_cnt,
	count(distinct case when nvl(is_valid,0) = 1 then track.user_id else null end ) as  valid_call_c_cnt,
	count(distinct track.user_id) as  call_c_cnt,	
	sum(1) as  call_rec_cnt,
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
	0 as initiative_res_cnt,
	count(case when track.status = 6 then track.user_id else null end) as junior_res_cnt  
from 
(	select track.id,track.uuid,substr(regexp_replace(track.createtime,'-',''),1,8) as  track_day,track.creator_id,track.user_id,plan.source as activity_type,track.status
	from  promotion_track track
	join promotion_callplan plan 
	on track.user_id = plan.user_id
	where substr(regexp_replace(track.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
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
group by track.creator_id,track.activity_type
union all 
select creator_id,activity_type,
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
		0 as call_plan_c_cnt,
		sum(case when track_day = $date$ then initiative_res_cnt else 0 end)  as initiative_res_cnt ,
		0 as junior_res_cnt
from (
	select 
		log.user_id,log.org_id,plan.source as activity_type,
		log.creator_id,substr(regexp_replace(log.createtime,'-',''),1,8) as  track_day,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 then 1 else 0 end  as finish_res_c_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,4) >0 and max(log.resume_level) > 1 then 1 else 0 end  as initiative_res_cnt		
	from promotion_callplan_log log 
	join promotion_callplan plan 
	on log.user_id = plan.user_id
	where substr(regexp_replace(log.createtime,'-',''),1,8)  between {{delta(date,-6)}} and $date$ 
	group by log.user_id,log.org_id,log.creator_id,substr(regexp_replace(log.createtime,'-',''),1,8),plan.source
)  m_log
where finish_res_c_cnt > 0 or initiative_res_cnt > 0
group by creator_id,activity_type
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
base.org_name,
fact.activity_type;


CREATE TABLE fact_h_gcdc_w_newpull_org_new(
  d_date int COMMENT ' 统计日期 ', 
  org_id int COMMENT ' 所属部门 ', 
  org_name string COMMENT ' 所属部门名称 ', 
  activity_type string COMMENT ' 拉新活动类型 1:BI线上流量，2:市场活动流量，3:市场手动导入', 
  activity_type_name string COMMENT ' 拉新活动类型名称 ', 
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
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
  creation_timestamp timestamp COMMENT ' 时间戳 ')
COMMENT '职业顾问拉新统计报表-团队粒度'
PARTITIONED BY ( p_date int);

CREATE TABLE fact_h_gcdc_w_newpull_org_new(
  d_date int COMMENT ' 统计日期 ', 
  org_id int COMMENT ' 所属部门 ', 
  org_name varchar(200) COMMENT ' 所属部门名称 ', 
  activity_type varchar(50) COMMENT ' 拉新活动类型 1:BI线上流量，2:市场活动流量，3:市场手动导入', 
  activity_type_name varchar(50) COMMENT ' 拉新活动类型名称 ', 
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
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
  creation_timestamp timestamp default current_timestamp COMMENT ' 时间戳 ',
  primary key (d_date,org_id,activity_type)
 )COMMENT '职业顾问拉新统计报表-团队粒度';

insert overwrite table fact_h_gcdc_w_newpull_org_new partition(p_date = $date$)
select
	$date$ as d_date,
	nvl(fact.org_id,-1) as org_id,
	nvl(base.org_name,'未知') as org_name,
	nvl(fact.activity_type,-1) as activity_type,
	case fact.activity_type when 1 then 'BI线上流量' when 2 then '市场活动流量' when 3 then '市场手动导入' else '其他' end as activity_type_name,
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
	sum(junior_res_cnt) as junior_res_cnt,
	sum(junior_res_cnt) / sum(call_c_cnt) as junior_res_ratio,
	sum(initiative_res_cnt) as initiative_res_cnt,
	sum(call_c_cnt) / (sum(call_c_cnt) + sum(no_finish_task_c_cnt)) as cover_ratio,
	from_unixtime(unix_timestamp()) as creation_timestamp
from (
select 
	plan.callplan_org_id as org_id,
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
		0 as initiative_res_cnt,
	0 as junior_res_cnt 
from 
(select	callplan_id,
		callplan_org_id ,
		1 as is_call_plan_c_cnt,
		regexp_replace(substr(callplan_createtime,1,10),'-','') as callplan_createtime,
		userc_id,
		activity_type
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
group by plan.callplan_org_id,plan.activity_type
union all 
select callplan_org_id as org_id,
	activity_type,
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
		0 as initiative_res_cnt,
	0 as junior_res_cnt
from (
	select 
	callplan_org_id,
	callplan_id,
	callplan_status,
	row_number()over(partition by callplan_id order by p_date) rn ,activity_type
	from dw_erp_d_gcdcnewp_plan
	where substr(regexp_replace(callplan_createtime,'-',''),1,8) = p_date
	and substr(regexp_replace(callplan_createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
	and p_date between {{delta(date,-6)}} and $date$ 
) plan 
where rn = 1
and callplan_status in (1,2,3)
group by callplan_org_id,activity_type

union all 

select 
	track.org_id,
	track.activity_type,
	sum(nvl(is_valid,0)) as  valid_call_rec_cnt,
	count(distinct case when nvl(is_valid,0) = 1 then track.user_id else null end ) as  valid_call_c_cnt,
	count(distinct track.user_id) as  call_c_cnt,	
	sum(1) as  call_rec_cnt,
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
	0 as initiative_res_cnt,
	count(case when track.status = 6 then track.user_id else null end) as junior_res_cnt  
from 
(	select track.id,track.uuid,substr(regexp_replace(track.createtime,'-',''),1,8) as  track_day,track.creator_id,track.user_id,plan.source as activity_type,track.status,track.org_id
	from  promotion_track track
	join promotion_callplan plan 
	on track.user_id = plan.user_id
	where substr(regexp_replace(track.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
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
group by track.org_id,track.activity_type
union all 
select org_id,activity_type,
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
		0 as call_plan_c_cnt,
		sum(initiative_res_cnt) as initiative_res_cnt,
		0 as junior_res_cnt
from (
	select 
		log.user_id,log.org_id,plan.source as activity_type,
		log.creator_id,substr(regexp_replace(log.createtime,'-',''),1,8) as  track_day,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 then 1 else 0 end  as finish_res_c_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,4) >0 and max(log.resume_level) > 1 then 1 else 0 end  as initiative_res_cnt		
	from promotion_callplan_log log 
	join promotion_callplan plan 
	on log.user_id = plan.user_id
	where substr(regexp_replace(log.createtime,'-',''),1,8)  between {{delta(date,-6)}} and $date$ 
	group by log.user_id,log.org_id,log.creator_id,substr(regexp_replace(log.createtime,'-',''),1,8),plan.source
)  m_log
where finish_res_c_cnt > 0 or initiative_res_cnt > 0
group by org_id,activity_type
) fact 
left join 
(select d_org_id as id,
		org_name
	from dim_org 
) base
on fact.org_id = base.id
group by fact.org_id,
base.org_name,
fact.activity_type;



CREATE TABLE fact_h_gcdc_w_newpull_plan_new(
  d_date int COMMENT ' 统计日期 ', 
  industry string COMMENT ' 经理人行业 ', 
  industry_name string COMMENT ' 经理人行业名称 ', 
  dq string COMMENT '活动地区或经理人地区', 
  dq_name string COMMENT '活动地区或经理人地区', 
  activity_type string COMMENT ' 拉新活动类型 1:BI线上流量，2:市场活动流量，3:市场手动导入', 
  activity_type_name string COMMENT ' 拉新活动类型名称 ', 
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
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
  pool_user_cnt float COMMENT '入库数据', 
  creation_timestamp timestamp COMMENT ' 时间戳 ')
COMMENT '职业顾问拉新统计报表-经理人粒度'
PARTITIONED BY ( p_date int);

CREATE TABLE fact_h_gcdc_w_newpull_plan_new(
  d_date int COMMENT ' 统计日期 ', 
  industry varchar(20) COMMENT ' 经理人行业 ', 
  industry_name varchar(50) COMMENT ' 经理人行业名称 ', 
  dq varchar(20) COMMENT '活动地区或经理人地区', 
  dq_name varchar(50) COMMENT '活动地区或经理人地区', 
  activity_type varchar(20) COMMENT ' 拉新活动类型 1:BI线上流量，2:市场活动流量，3:市场手动导入', 
  activity_type_name varchar(50) COMMENT ' 拉新活动类型名称 ',
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
  junior_res_cnt int COMMENT '初级简历预估数',
  junior_res_ratio float COMMENT '初级简历预估率',
  initiative_res_cnt int COMMENT '经理人拉新成功',
  cover_ratio float COMMENT '覆盖率',
  pool_user_cnt float COMMENT '入库数据', 
  creation_timestamp timestamp default current_timestamp COMMENT ' 时间戳 ',
  primary key (d_date,industry,dq,activity_type)
 )COMMENT '职业顾问拉新统计报表-经理人粒度';

alter table fact_h_gcdc_w_newpull_plan_new add (city varchar(50) COMMENT '活动城市或经理人城市', 
  city_name varchar(50) COMMENT '城市名称', 
  main_industry varchar(50) COMMENT '主行业', 
  main_industry_name varchar(50) COMMENT '主行业名称') ;

alter table fact_h_gcdc_d_newpull_plan_new add (city varchar(50) COMMENT '活动城市或经理人城市', 
  city_name varchar(50) COMMENT '城市名称', 
  main_industry varchar(50) COMMENT '主行业', 
  main_industry_name varchar(50) COMMENT '主行业名称') ;

insert overwrite table fact_h_gcdc_w_newpull_plan_new partition(p_date = $date$)
select
	$date$ as d_date,
	nvl(fact.callplan_industry,'999') as callplan_industry ,
	nvl(fact.callplan_industry_name,'其他') as callplan_industry_name ,
	nvl(fact.callplan_dq,'999') as callplan_dq ,	
	nvl(fact.callplan_dq_name,'不限') as callplan_dq_name,
	nvl(fact.activity_type,-1) as activity_type,
	case fact.activity_type when 1 then 'BI线上流量' when 2 then '市场活动流量' when 3 then '市场手动导入' else '其他' end as activity_type_name,
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
	sum(junior_res_cnt) as junior_res_cnt,
	sum(junior_res_cnt) / sum(call_c_cnt) as junior_res_ratio,
	sum(initiative_res_cnt) as initiative_res_cnt,
	sum(call_c_cnt) / (sum(call_c_cnt) + sum(no_finish_task_c_cnt)) as cover_ratio,
	sum(pool_user_cnt) as pool_user_cnt, 	
	from_unixtime(unix_timestamp()) as creation_timestamp
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
		0 as initiative_res_cnt,
	0 as junior_res_cnt,
	0 as pool_user_cnt
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
		1 as is_call_plan_c_cnt,		
		userc_id
 from dw_erp_d_gcdcnewp_plan 
where p_date = $date$
  and substr(regexp_replace(callplan_createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
) plan
left join 
(	select user_id,substr(regexp_replace(min(createtime),'-',''),1,8) as  track_day
	from  promotion_track
	where substr(regexp_replace(createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
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
	count(callplan_id)  as no_finish_task_c_cnt,	
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
		0 as initiative_res_cnt,
	0 as junior_res_cnt,
	0 as pool_user_cnt
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
and callplan_status in (1,2,3)
group by  plan.callplan_industry ,
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
	sum(nvl(is_valid,0)) as  valid_call_rec_cnt,
	count(distinct case when nvl(is_valid,0) = 1 then track.user_id else null end ) as  valid_call_c_cnt,
	count(distinct track.user_id) as  call_c_cnt,	
	sum(1) as  call_rec_cnt,
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
	0 as initiative_res_cnt,
	count(case when track.status = 6 then track.user_id else null end) as junior_res_cnt ,
	0 as pool_user_cnt
from 
(	select track.id,track.uuid,substr(regexp_replace(track.createtime,'-',''),1,8) as  track_day,track.creator_id,track.user_id,track.status,track.org_id
	from  promotion_track track
	where substr(regexp_replace(track.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
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
		sum(finish_res_c_cnt)  as finish_res_c_cnt,
		sum(finish_level6_res_cnt)  as finish_level6_res_cnt,
		sum(finish_level5_res_cnt)  as finish_level5_res_cnt,
		sum(finish_level4_res_cnt)  as finish_level4_res_cnt,
		sum(finish_level3_res_cnt)  as finish_level3_res_cnt,
		sum(finish_level2_res_cnt)  as finish_level2_res_cnt,
		sum(finish_level1_res_cnt)  as finish_level1_res_cnt,
		sum(finish_biz_res_cnt)  as finish_biz_res_cnt,
		0 as finish_task_c_cnt,
		0 as call_plan_c_cnt,
		sum(initiative_res_cnt) as initiative_res_cnt ,
		0 as junior_res_cnt,
		0 as pool_user_cnt
from (
	select 
		log.user_id,log.org_id,
		log.creator_id,substr(regexp_replace(log.createtime,'-',''),1,8) as  track_day,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 then 1 else 0 end  as finish_res_c_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,2) >0 and max(log.resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt,
		case when instr(combine(cast(log.action_type as string)) ,4) >0 and max(log.resume_level) > 1 then 1 else 0 end  as initiative_res_cnt		
	from promotion_callplan_log log 
	where substr(regexp_replace(log.createtime,'-',''),1,8)  between {{delta(date,-6)}} and $date$ 
	group by log.user_id,log.org_id,log.creator_id,substr(regexp_replace(log.createtime,'-',''),1,8)
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
where finish_res_c_cnt > 0 or initiative_res_cnt > 0
group by  plan.callplan_industry ,
	plan.callplan_industry_name ,
	plan.callplan_dq ,	
	plan.callplan_dq_name ,	
	plan.activity_type
union all 
select null as callplan_industry ,
		null as callplan_industry_name ,
		null as callplan_dq ,	
		null as callplan_dq_name ,
		source as activity_type,
		0 as valid_call_rec_cnt,
		0 as valid_call_c_cnt,
		0 as call_c_cnt,
		0 as call_rec_cnt,
		0 as no_finish_task_c_cnt,	
		0 as finish_res_c_cnt,
		0 as finish_level6_res_cnt,
		0 as finish_level5_res_cnt,
		0 as finish_level4_res_cnt,
		0 as finish_level3_res_cnt,
		0 as finish_level2_res_cnt,
		0 as finish_level1_res_cnt,
		0 as finish_biz_res_cnt,
		0 as finish_task_c_cnt,
		0 as call_plan_c_cnt,
		0  as initiative_res_cnt ,
		0 as junior_res_cnt,
		count(distinct user_id) as pool_user_cnt
   from promotion_pool
   where substr(regexp_replace(createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$  
   group by source
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