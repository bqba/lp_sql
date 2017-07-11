insert overwrite table dw_erp_d_gcdc_newpull partition (p_date)
select 
		plan_date as d_date,
		callplan_creator_id as gcdc_id,
		callplan_creator_name as gcdc_name ,
		callplan_org_id as org_id,
		callplan_org_name as org_name ,	
		callplan_industry ,
		callplan_industry_name ,
		callplan_dq ,	
		callplan_dq_name ,	
		activity_type,
		case when activity_type = '1' then '市场活动'
				when activity_type = '2' then '品牌活动'
				when activity_type = '3' then 'BI线上流量'
				when activity_type = '4' then '销售活动'
				when activity_type = '5' then '线上BD活动'
				else  '未知' 
				end as activity_type_name,
		sum(valid_call_rec_cnt) as valid_call_rec_cnt,
		sum(valid_call_c_cnt) as valid_call_c_cnt,
		sum(call_c_cnt) as call_c_cnt,
		sum(call_rec_cnt) as call_rec_cnt,
		sum(finish_res_c_cnt) as finish_res_c_cnt,
		sum(finish_level6_res_cnt) as finish_level6_res_cnt,
		sum(finish_level5_res_cnt) as finish_level5_res_cnt,
		sum(finish_level4_res_cnt) as finish_level4_res_cnt,
		sum(finish_level3_res_cnt) as finish_level3_res_cnt,
		sum(finish_level2_res_cnt) as finish_level2_res_cnt,
		sum(finish_level1_res_cnt) as finish_level1_res_cnt,
		sum(invite_c_cnt) as invite_c_cnt,
		sum(finish_invite_c_cnt) as finish_invite_c_cnt,
		sum(finish_res_cnt) as finish_res_cnt,
		sum(finish_biz_res_cnt) as finish_biz_res_cnt,
		sum(finish_task_c_cnt) as finish_task_c_cnt,
		sum(call_plan_c_cnt) as  call_plan_c_cnt,
		from_unixtime(unix_timestamp()) as creation_timestamp,
		plan_date as p_date
from 
(select 
			plan.callplan_industry ,
			plan.callplan_industry_name ,
			plan.callplan_dq ,	
			plan.callplan_dq_name ,	
			plan.callplan_creator_id ,
			plan.callplan_creator_name ,
			plan.callplan_org_id ,
			plan.callplan_org_name ,
			plan.activity_type,
			trackkpi.createtime as plan_date,
			nvl(sum(trackkpi.valid_call_rec_cnt),0) as valid_call_rec_cnt,
			count(case when trackkpi.valid_call_rec_cnt > 0 then trackkpi.popularize_callplan_id else null end) as valid_call_c_cnt,
			count(trackkpi.popularize_callplan_id) as call_c_cnt,
			nvl(sum(trackkpi.call_rec_cnt),0) as call_rec_cnt,
			0 as finish_res_c_cnt  ,
			0 as finish_level6_res_cnt ,
			0 as finish_level5_res_cnt ,
			0 as finish_level4_res_cnt ,
			0 as finish_level3_res_cnt ,
			0 as finish_level2_res_cnt ,
			0 as finish_level1_res_cnt ,
			0 as invite_c_cnt  ,
			0 as finish_invite_c_cnt  ,
			0 as finish_res_cnt  ,
			0 as finish_biz_res_cnt  ,
			count(case when plan.plan_date = trackkpi.createtime then trackkpi.popularize_callplan_id else null end ) as finish_task_c_cnt,
			0 as call_plan_c_cnt
	from 
	(select callplan_id,
				callplan_industry ,
				callplan_industry_name ,
				callplan_dq ,	
				callplan_dq_name ,	
				callplan_creator_id ,
				callplan_creator_name ,
				callplan_org_id ,
				callplan_org_name ,	
				callplan_createtime ,
				activity_type,
				regexp_replace(substr(callplan_createtime,1,10),'-','') as plan_date
		 from dw_erp_d_gcdcnewp_plan
		where p_date = 20160717
		 ) plan
	left join 	
	( select 
			track.popularize_callplan_id,track.createtime,
			sum(is_valid) as  valid_call_rec_cnt,
			count(track.id ) as  call_rec_cnt
		from 
		(	select id,uuid,popularize_callplan_id,regexp_replace(substr(createtime,1,10),'-','') as createtime
			from  popularize_track
			where regexp_replace(substr(createtime,1,10),'-','') between 20160216 and 20160412
		) track 
		left join 
		(		 select uuid,case when sum(time_long) >60 then 1 else 0 end as is_valid,call_date
				   from call_record_archive
				where deleteflag  = 0
					and call_date between 20160216 and 20160412
					and time_long > 0
				  group by uuid,call_date
		) call_record 
		on track.uuid = call_record.uuid
		and track.createtime = call_record.call_date		
		group by track.popularize_callplan_id,track.createtime		
	) trackkpi
	on plan.callplan_id = trackkpi.popularize_callplan_id
	group by plan.callplan_industry ,
					plan.callplan_industry_name ,
					plan.callplan_dq ,
					plan.callplan_dq_name ,
					plan.callplan_creator_id ,
					plan.callplan_creator_name ,
					plan.callplan_org_id ,
					plan.callplan_org_name ,
					plan.activity_type,
					trackkpi.createtime
	union all 				
		select
			plan.callplan_industry ,
			plan.callplan_industry_name ,
			plan.callplan_dq ,	
			plan.callplan_dq_name ,	
			plan.callplan_creator_id ,
			plan.callplan_creator_name ,
			plan.callplan_org_id ,
			plan.callplan_org_name ,
			plan.activity_type,
			plan.plan_date as plan_date,
			0 as valid_call_rec_cnt,
			0 as valid_call_c_cnt,
			0 as call_c_cnt,
			0 as call_rec_cnt,
			0 as finish_res_c_cnt  ,
			0 as finish_level6_res_cnt ,
			0 as finish_level5_res_cnt ,
			0 as finish_level4_res_cnt ,
			0 as finish_level3_res_cnt ,
			0 as finish_level2_res_cnt ,
			0 as finish_level1_res_cnt ,
			0 as invite_c_cnt  ,
			0 as finish_invite_c_cnt  ,
			0 as finish_res_cnt  ,
			0 as finish_biz_res_cnt  ,
			0 as finish_task_c_cnt,
			count(plan.callplan_id) as call_plan_c_cnt		
		from 
		(select callplan_id,
				callplan_industry ,
				callplan_industry_name ,
				callplan_dq ,	
				callplan_dq_name ,	
				callplan_creator_id ,
				callplan_creator_name ,
				callplan_org_id ,
				callplan_org_name ,	
				callplan_createtime ,
				activity_type,
				regexp_replace(substr(callplan_createtime,1,10),'-','') as plan_date
		 from dw_erp_d_gcdcnewp_plan
		where p_date = 20160717
		   and regexp_replace(substr(callplan_createtime,1,10),'-','')  between 20160216 and 20160412
		 ) plan
	group by plan.callplan_industry ,
					plan.callplan_industry_name ,
					plan.callplan_dq ,
					plan.callplan_dq_name ,
					plan.callplan_creator_id ,
					plan.callplan_creator_name ,
					plan.callplan_org_id ,
					plan.callplan_org_name ,
					plan.activity_type,
					plan.plan_date	
	union all
	select 
		plan.callplan_industry ,
		plan.callplan_industry_name ,
		plan.callplan_dq ,
		plan.callplan_dq_name ,
		planlog.creator_id as callplan_creator_id,
		base.name as callplan_creator_name ,
		planlog.org_id  as callplan_org_id,
		org.name as  callplan_org_name,
		plan.activity_type,
		planlog.createtime as plan_date,
		0 as valid_call_rec_cnt  ,
		0 as valid_call_c_cnt  ,
		0 as call_c_cnt  ,
		0 as call_rec_cnt  ,
		sum(finish_res_c_cnt) as finish_res_c_cnt,
		sum(finish_level6_res_cnt) as finish_level6_res_cnt,
		sum(finish_level5_res_cnt) as finish_level5_res_cnt,
		sum(finish_level4_res_cnt) as finish_level4_res_cnt,
		sum(finish_level3_res_cnt) as finish_level3_res_cnt,
		sum(finish_level2_res_cnt) as finish_level2_res_cnt,
		sum(finish_level1_res_cnt) as finish_level1_res_cnt,	
		sum(invite_c_cnt) as invite_c_cnt,
		sum(finish_invite_c_cnt) as finish_invite_c_cnt,
		sum(finish_res_cnt) as finish_res_cnt,
		sum(finish_biz_res_cnt) as finish_biz_res_cnt,
		0 as finish_task_c_cnt  ,
		0 as call_plan_c_cnt 
	from 
	(select 
		popularize_callplan_id,
		creator_id,regexp_replace(substr(createtime,1,10),'-','')  as createtime,org_id,
		case when instr(combine(cast(action_type as string)) ,4) >0 then 1 else 0 end  as finish_res_c_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 then 1 else 0 end  as invite_c_cnt,
		case when instr(combine(cast(action_type as string)) ,2) >0 and (instr(combine(cast(action_type as string)) ,4)>0 or instr(combine(cast(action_type as string)) ,5)>0 or instr(combine(cast(action_type as string)) ,7)>0 or instr(combine(cast(action_type as string)) ,8)>0 ) then 1 else 0 end  as finish_invite_c_cnt,
		case when instr(combine(cast(action_type as string)) ,4)>0 or instr(combine(cast(action_type as string)) ,5)>0 or instr(combine(cast(action_type as string)) ,7)>0 or instr(combine(cast(action_type as string)) ,8)>0  then 1 else 0 end  as finish_res_cnt,
		case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt
		from popularize_callplan_log
		where regexp_replace(substr(createtime,1,10),'-','')  between 20160216 and 20160412
		group by popularize_callplan_id,creator_id,regexp_replace(substr(createtime,1,10),'-',''),org_id
	) planlog
	left join 
	(select callplan_id,
				callplan_industry ,
				callplan_industry_name ,
				callplan_dq ,	
				callplan_dq_name ,	
				callplan_creator_id ,
				callplan_creator_name ,
				callplan_org_id ,
				callplan_org_name ,	
				callplan_createtime ,
				activity_type
		 from dw_erp_d_gcdcnewp_plan 
		where p_date = 20160717) plan
	on planlog.popularize_callplan_id = plan.callplan_id
	left join
	(select id,
				name,
				org_id,
				org_name
		from dw_erp_d_salesuser_base 
		where p_date = 20160717
	) base
	on planlog.creator_id = base.id
	left join 
	(select id ,name from portal_org) org
	on planlog.org_id = org.id	
	group by	plan.callplan_industry ,
					plan.callplan_industry_name ,
					plan.callplan_dq ,
					plan.callplan_dq_name ,
					planlog.creator_id ,
					base.name ,
					planlog.org_id ,
					org.name ,
					plan.activity_type,
					planlog.createtime
)  temp
group by	callplan_industry ,
				callplan_industry_name ,
				callplan_dq ,	
				callplan_dq_name ,	
				callplan_creator_id ,
				callplan_creator_name ,
				callplan_org_id ,
				callplan_org_name ,	
				activity_type,
				plan_date;