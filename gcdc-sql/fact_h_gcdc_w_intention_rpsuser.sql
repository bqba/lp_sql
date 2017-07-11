create table if not exists fact_h_gcdc_w_intention_rpsuser_pre
(
	d_date int comment '统计日期',
	rps_user_id int comment '招聘服务顾问ID',
	rps_user_name string comment '招聘服务顾问姓名',
	org_id int comment '招聘服务小组ID',
	org_name string comment '招聘服务小组名称',
	branch_id int comment '地区ID',
	branch_name string comment '地区名称',
	position_id int comment '岗位ID',
	position_name string comment '岗位名称',
	intention_b_type string comment '意向沟通类型',
	intention_b_cust_cnt int comment '意向沟通发起客户数',
	intention_b_consume_cust_cnt int comment '消耗意向沟通的客户数',
	intention_b_pub_consume_cust_cnt int comment '主动消耗意向沟通的客户数',
	intention_b_recom_consume_cust_cnt int comment '推荐消耗意向沟通的客户数',	
	intention_b_cnt int comment '意向沟通发起数',
	intention_b_release_cnt int comment '意向沟通释放数',
	intention_b_adoption_cnt int comment '意向沟通采纳数',
	intention_b_reject_cnt int comment '意向沟通驳回数',
	intention_b_consume_track_cnt int comment '意向沟通消耗总数',	
	intention_b_pub_track_cnt int comment '意向沟通主动发起数',
	intention_b_high_pub_track_cnt int comment '意向沟通主动发起数-高',
	intention_b_mid_pub_track_cnt int comment '意向沟通主动发起数-中',
	intention_b_low_pub_track_cnt int comment '意向沟通主动发起数-低',
	intention_b_none_pub_track_cnt int comment '意向沟通主动发起数-无',
	intention_b_invalid_pub_track_cnt int comment '意向沟通主动发起数-返还',	
	intention_b_recom_track_cnt int comment '意向沟通推荐发起数',
	intention_b_high_recom_track_cnt int comment '意向沟通推荐发起数-高',
	intention_b_mid_recom_track_cnt int comment '意向沟通推荐发起数-中',
	intention_b_low_recom_track_cnt int comment '意向沟通推荐发起数-低',
	intention_b_none_recom_track_cnt int comment '意向沟通推荐发起数-无',
	intention_b_invalid_recom_track_cnt int comment '意向沟通推荐发起数-返还',
	contact_cnt int comment '索要联系方式发起数',
	contact_consume_track_cnt int comment '索要联系方式消耗总数',
	contact_allow_pub_track_cnt int comment '索要联系方式（客户）-开放',
	contact_disallow_pub_track_cnt int comment '索要联系方式（客户）-不开放',
	contact_invalid_pub_track_cnt int comment '索要联系方式（客户）-未成功沟通',
	contact_allow_recom_track_cnt int comment '索要联系方式（推荐）-开放',
	contact_disallow_recom_track_cnt int comment '索要联系方式（推荐）-不开放',
	contact_invalid_recom_track_cnt int comment '索要联系方式（推荐）-未成功沟通',
	intention_contact_consume_track_cnt int comment '总消耗数',	
	creation_timestamp timestamp
) comment '招服顾问意向沟通统计周表'
partitioned by (p_date int);


create table if not exists fact_h_gcdc_w_intention_rpsuser_pre
(
	d_date int comment '统计日期',
	rps_user_id int comment '招聘服务顾问ID',
	rps_user_name varchar(50) comment '招聘服务顾问姓名',
	org_id int comment '招聘服务小组ID',
	org_name varchar(100) comment '招聘服务小组名称',
	branch_id int comment '地区ID',
	branch_name varchar(50) comment '地区名称',
	position_id int comment '岗位ID',
	position_name varchar(50) comment '岗位名称',	
	intention_b_type varchar(50) comment '意向沟通类型',
	intention_b_cust_cnt int comment '意向沟通发起客户数',
	intention_b_consume_cust_cnt int comment '消耗意向沟通的客户数',
	intention_b_pub_consume_cust_cnt int comment '主动消耗意向沟通的客户数',
	intention_b_recom_consume_cust_cnt int comment '推荐消耗意向沟通的客户数',	
	intention_b_cnt int comment '意向沟通发起数',
	intention_b_release_cnt int comment '意向沟通释放数',
	intention_b_adoption_cnt int comment '意向沟通采纳数',
	intention_b_reject_cnt int comment '意向沟通驳回数',
	intention_b_consume_track_cnt int comment '意向沟通消耗总数',	
	intention_b_pub_track_cnt int comment '意向沟通主动发起数',
	intention_b_high_pub_track_cnt int comment '意向沟通主动发起数-高',
	intention_b_mid_pub_track_cnt int comment '意向沟通主动发起数-中',
	intention_b_low_pub_track_cnt int comment '意向沟通主动发起数-低',
	intention_b_none_pub_track_cnt int comment '意向沟通主动发起数-无',
	intention_b_invalid_pub_track_cnt int comment '意向沟通主动发起数-返还',	
	intention_b_recom_track_cnt int comment '意向沟通推荐发起数',
	intention_b_high_recom_track_cnt int comment '意向沟通推荐发起数-高',
	intention_b_mid_recom_track_cnt int comment '意向沟通推荐发起数-中',
	intention_b_low_recom_track_cnt int comment '意向沟通推荐发起数-低',
	intention_b_none_recom_track_cnt int comment '意向沟通推荐发起数-无',
	intention_b_invalid_recom_track_cnt int comment '意向沟通推荐发起数-返还',
	contact_cnt int comment '索要联系方式发起数',
	contact_consume_track_cnt int comment '索要联系方式消耗总数',
	contact_allow_pub_track_cnt int comment '索要联系方式（客户）-开放',
	contact_disallow_pub_track_cnt int comment '索要联系方式（客户）-不开放',
	contact_invalid_pub_track_cnt int comment '索要联系方式（客户）-未成功沟通',
	contact_allow_recom_track_cnt int comment '索要联系方式（推荐）-开放',
	contact_disallow_recom_track_cnt int comment '索要联系方式（推荐）-不开放',
	contact_invalid_recom_track_cnt int comment '索要联系方式（推荐）-未成功沟通',	
	intention_contact_consume_track_cnt int comment '总消耗数',	
	creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
	primary key (d_date,rps_user_id,intention_b_type)
) comment '招服顾问意向沟通统计周表';


insert overwrite table fact_h_gcdc_w_intention_rpsuser_pre partition (p_date =$date$)
select
	$date$ as d_date,
	fact.creator_id as rps_user_id,
	nvl(salesuser.name ,'未知')as rps_user_name,
	nvl(salesuser.org_id,-1)  as org_id,
	nvl(salesuser.org_name,'未知') as org_name,
	nvl(dim_org.branch_id,-1) as branch_id,
	nvl(dim_org.branch_name,'未知') as branch_name,
	nvl(salesuser.position_id,'-1') as position_id,
	nvl(salesuser.position_name,'-1') as position_name,	
	nvl(fact.intention_type,-1) as intention_b_type,
	sum(fact.intention_b_cust_cnt) as intention_b_cust_cnt,
	sum(fact.intention_b_consume_cust_cnt) as intention_b_consume_cust_cnt,
	sum(fact.intention_b_pub_consume_cust_cnt) as intention_b_pub_consume_cust_cnt,
	sum(fact.intention_b_recom_consume_cust_cnt) as intention_b_recom_consume_cust_cnt,
	sum(fact.intention_b_cnt) as intention_b_cnt,
	sum(fact.intention_b_release_cnt) as intention_b_release_cnt,
	sum(fact.intention_b_adoption_cnt) as intention_b_adoption_cnt,
	sum(fact.intention_b_reject_cnt) as intention_b_reject_cnt,
	sum(fact.intention_b_consume_track_cnt) as intention_b_consume_track_cnt,
	sum(fact.intention_b_pub_track_cnt) as intention_b_pub_track_cnt,
	sum(fact.intention_b_high_pub_track_cnt) as intention_b_high_pub_track_cnt,
	sum(fact.intention_b_mid_pub_track_cnt) as intention_b_mid_pub_track_cnt,
	sum(fact.intention_b_low_pub_track_cnt) as intention_b_low_pub_track_cnt,
	sum(fact.intention_b_none_pub_track_cnt) as intention_b_none_pub_track_cnt,
	sum(fact.intention_b_invalid_pub_track_cnt) as intention_b_invalid_pub_track_cnt,
	sum(fact.intention_b_recom_track_cnt) as intention_b_recom_track_cnt,
	sum(fact.intention_b_high_recom_track_cnt) as intention_b_high_recom_track_cnt,
	sum(fact.intention_b_mid_recom_track_cnt) as intention_b_mid_recom_track_cnt,
	sum(fact.intention_b_low_recom_track_cnt) as intention_b_low_recom_track_cnt,
	sum(fact.intention_b_none_recom_track_cnt) as intention_b_none_recom_track_cnt,
	sum(fact.intention_b_invalid_recom_track_cnt) as intention_b_invalid_recom_track_cnt,
	sum(fact.contact_cnt) as contact_cnt,
	sum(fact.contact_consume_track_cnt) as contact_consume_track_cnt,
	sum(fact.contact_allow_pub_track_cnt) as contact_allow_pub_track_cnt,
	sum(fact.contact_disallow_pub_track_cnt) as contact_disallow_pub_track_cnt,
	sum(fact.contact_invalid_pub_track_cnt) as contact_invalid_pub_track_cnt,
	sum(fact.contact_allow_recom_track_cnt) as contact_allow_recom_track_cnt,
	sum(fact.contact_disallow_recom_track_cnt) as contact_disallow_recom_track_cnt,
	sum(fact.contact_invalid_recom_track_cnt) as contact_invalid_recom_track_cnt,
	sum(fact.intention_contact_consume_track_cnt) as intention_contact_consume_track_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp
from 
(
select 
	coalesce(weekresult1.creator_id,daytaskb1.creator_id,dayrelease1.creator_id,daytaskc1.creator_id) as creator_id,
	coalesce(weekresult1.intention_type,daytaskb1.intention_type,dayrelease1.intention_type,daytaskc1.intention_type) as intention_type,

	nvl(dayrelease1.intention_b_release_cnt,0) as intention_b_release_cnt,

	nvl(daytaskc1.intention_b_adoption_cnt,0) as intention_b_adoption_cnt,
	nvl(daytaskc1.intention_b_reject_cnt,0) as intention_b_reject_cnt,

	nvl(weekresult1.intention_b_consume_cust_cnt,0) as intention_b_consume_cust_cnt,
	nvl(weekresult1.intention_b_pub_consume_cust_cnt,0) as intention_b_pub_consume_cust_cnt,
	nvl(weekresult1.intention_b_recom_consume_cust_cnt,0) as intention_b_recom_consume_cust_cnt,
	nvl(weekresult1.intention_b_consume_track_cnt,0) as intention_b_consume_track_cnt,
	nvl(weekresult1.intention_b_pub_track_cnt,0) as intention_b_pub_track_cnt,
	nvl(weekresult1.intention_b_high_pub_track_cnt,0) as intention_b_high_pub_track_cnt,
	nvl(weekresult1.intention_b_mid_pub_track_cnt,0) as intention_b_mid_pub_track_cnt,
	nvl(weekresult1.intention_b_low_pub_track_cnt,0) as intention_b_low_pub_track_cnt,
	nvl(weekresult1.intention_b_none_pub_track_cnt,0) as intention_b_none_pub_track_cnt,
	nvl(weekresult1.intention_b_invalid_pub_track_cnt,0) as intention_b_invalid_pub_track_cnt,
	nvl(weekresult1.intention_b_recom_track_cnt,0) as intention_b_recom_track_cnt,
	nvl(weekresult1.intention_b_high_recom_track_cnt,0) as intention_b_high_recom_track_cnt,
	nvl(weekresult1.intention_b_mid_recom_track_cnt,0) as intention_b_mid_recom_track_cnt,
	nvl(weekresult1.intention_b_low_recom_track_cnt,0) as intention_b_low_recom_track_cnt,
	nvl(weekresult1.intention_b_none_recom_track_cnt,0) as intention_b_none_recom_track_cnt,
	nvl(weekresult1.intention_b_invalid_recom_track_cnt,0) as intention_b_invalid_recom_track_cnt,
	nvl(weekresult1.contact_consume_track_cnt,0) as contact_consume_track_cnt,
	nvl(weekresult1.contact_allow_pub_track_cnt,0) as contact_allow_pub_track_cnt,
	nvl(weekresult1.contact_disallow_pub_track_cnt,0) as contact_disallow_pub_track_cnt,
	nvl(weekresult1.contact_invalid_pub_track_cnt,0) as contact_invalid_pub_track_cnt,
	nvl(weekresult1.contact_allow_recom_track_cnt,0) as contact_allow_recom_track_cnt,
	nvl(weekresult1.contact_disallow_recom_track_cnt,0) as contact_disallow_recom_track_cnt,
	nvl(weekresult1.contact_invalid_recom_track_cnt,0) as contact_invalid_recom_track_cnt,
	nvl(weekresult1.intention_b_consume_track_cnt,0) + nvl(weekresult1.contact_consume_track_cnt,0) as intention_contact_consume_track_cnt,

	nvl(daytaskb1.intention_b_cust_cnt,0) as intention_b_cust_cnt,
	nvl(daytaskb1.intention_b_cnt,0) as intention_b_cnt,
	nvl(daytaskb1.contact_cnt,0) as contact_cnt


from 
	(
	select 
	  task.creator_id,trackTaskLog.intention_type,
	  count(distinct case when (trackTaskLog.intention_type in (1,2,3,9) and trackTaskLog.result IN ('1','2','3','4') ) or ( trackTaskLog.intention_type in (0,4,9) and trackTaskLog.demand_concat_result in (1,2)) then track.customer_id else null end) as intention_b_consume_cust_cnt ,
	  count(distinct case when ((trackTaskLog.intention_type in (1,2,3,9) and trackTaskLog.result IN ('1','2','3','4') ) or ( trackTaskLog.intention_type in (0,4,9) and trackTaskLog.demand_concat_result in (1,2))) and track.kind = 0 then track.customer_id else null end) as intention_b_pub_consume_cust_cnt ,
	  count(distinct case when ((trackTaskLog.intention_type in (1,2,3,9) and trackTaskLog.result IN ('1','2','3','4') ) or ( trackTaskLog.intention_type in (0,4,9) and trackTaskLog.demand_concat_result in (1,2)) ) and track.kind = 1 then track.customer_id else null end) as intention_b_recom_consume_cust_cnt ,
	  count(distinct case when trackTaskLog.result IN ('1','2','3','4') then task.id else null end)  as intention_b_consume_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('1','2','3','4') and track.kind = 0 then task.id else null end) as intention_b_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('1') and track.kind = 0 then task.id else null end) as intention_b_high_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('2') and track.kind = 0 then task.id else null end) as intention_b_mid_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('3') and track.kind = 0 then task.id else null end) as intention_b_low_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('4') and track.kind = 0 then task.id else null end) as intention_b_none_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('6') and track.kind = 0 then task.id else null end) as intention_b_invalid_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('1','2','3','4') and track.kind = 1 then task.id else null end) as intention_b_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('1') and track.kind = 1 then task.id else null end) as intention_b_high_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('2') and track.kind = 1 then task.id else null end) as intention_b_mid_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('3') and track.kind = 1 then task.id else null end) as intention_b_low_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('4') and track.kind = 1 then task.id else null end) as intention_b_none_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('6') and track.kind = 1 then task.id else null end) as intention_b_invalid_recom_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result in (1,2) then task.id else null end) as contact_consume_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 1 and track.kind = 0 then task.id else null end) as contact_allow_pub_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 2 and track.kind = 0 then task.id else null end) as contact_disallow_pub_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 4 and track.kind = 0 then task.id else null end) as contact_invalid_pub_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 1 and track.kind = 1 then task.id else null end) as contact_allow_recom_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 2 and track.kind = 1 then task.id else null end) as contact_disallow_recom_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 4 and track.kind = 1 then task.id else null end) as contact_invalid_recom_track_cnt	
	  from 
	  (select 
	  		all_type.intn_type as intention_type,
	  		TaskLogb.id,
		    TaskLogb.result,
		    TaskLogb.creator_id,
		    TaskLogb.org_id,
		    TaskLogb.rsc_intention_task_b_id,
		    TaskLogb.demand_concat_result
	    from 
		  ( select  tasklog.id,
		    		tasklog.result,
		    		tasklog.creator_id,
		    		tasklog.org_id,
		    		tasklog.rsc_intention_task_b_id,
		    		tasklog.intention_type,
		    		tasklog.demand_concat_result
		    from (
		    select id,result,creator_id,org_id,intention_type,rsc_intention_task_b_id,demand_concat_result,
		    	   row_number()over(distribute by rsc_intention_task_b_id sort by createtime desc) rn 
		      from rsc_intention_task_b_log
		     where (result in ('1','2','3','4','6') or demand_concat_result in (1,2,4))
		       and deleteflag = 0
		       and intention_type in ('1','2','0')
		       and substr(regexp_replace(tracktime,'-',''),1,8) between {{delta(date,-6)}} and $date$
		    ) tasklog
		    where rn = 1
		  ) TaskLogb
		  join (select explode(array(0,1,2,3,4,9)) AS intn_type FROM dummy) all_type
		  on 1=1
		  where all_type.intn_type = 9 or 
		  		(TaskLogb.intention_type = all_type.intn_type) or 
		  		(all_type.intn_type = 3 and TaskLogb.intention_type <> 0) or 
		  		(all_type.intn_type = 4 and TaskLogb.intention_type <> 1)
	   ) trackTaskLog
	  join rsc_intention_task_b task
	  on trackTaskLog.rsc_intention_task_b_id=task.id
	  join rsc_intention track 
	  on task.rsc_intention_id=track.id
	  and track.deleteflag = 0
	  group by task.creator_id,trackTaskLog.intention_type
	) weekresult1	
	full join 
	(
	 select 
	  task.creator_id,
	  task.intn_type as intention_type,
	  count(distinct track.customer_id) as intention_b_cust_cnt,
	  count(distinct case when task.intention_type <> 0 then task.id else null end) as intention_b_cnt,
	  count(distinct case when task.intention_type = 0 then task.id else null end) as contact_cnt
	  from 
	  (  
	  	select 
	  		taskb.creator_id,taskb.org_id,taskb.id,taskb.rsc_intention_id,taskb.createtime,taskb.intention_type,
	  		all_type.intn_type
	  	from (
		  	select task.creator_id,org_id,task.id,task.rsc_intention_id,intention_type,createtime
		    from rsc_intention_task_b task
		    where task.deleteflag = 0
		     and substr(regexp_replace(task.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
		     and task.intention_type in (1,2,0)
	     ) taskb 
	  	join (select explode(array(0,1,2,3,4,9)) AS intn_type FROM dummy) all_type
		   on 1=1
		   where all_type.intn_type = 9 or 
		   		(taskb.intention_type = all_type.intn_type) or 
		   		(all_type.intn_type = 3 and taskb.intention_type <> 0) or 
		   		(all_type.intn_type = 4 and taskb.intention_type <> 1)
	  ) task
	  join rsc_intention track 
	  on task.rsc_intention_id=track.id
	  and track.deleteflag = 0
	  group by task.creator_id,task.intn_type
	) daytaskb1
	on weekresult1.creator_id = daytaskb1.creator_id
	and weekresult1.intention_type = daytaskb1.intention_type
	full join 
	(
	   select taskb.creator_id,all_type.intn_type as intention_type,
	   		  count(distinct taskb.id) as intention_b_release_cnt
	    from (select taskc.id,taskc.rsc_intention_task_b_id,taskc.intention_type,taskc.createtime
	    	    from rsc_intention_task_c taskc
	    	    where taskc.deleteflag = 0
	    	      and substr(regexp_replace(taskc.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
	    	      and taskc.intention_type in (1,2)
	    	  ) task
	    join rsc_intention_task_b taskb 
		  on task.rsc_intention_task_b_id = taskb.id
	    join (select explode(array(1,2,3,9)) AS intn_type FROM dummy) all_type
		   on 1=1
		where all_type.intn_type in (3,9) or 
		   		(taskb.intention_type = all_type.intn_type) 
	    group by taskb.creator_id,all_type.intn_type
	) dayrelease1
	on weekresult1.creator_id = dayrelease1.creator_id
	and weekresult1.intention_type = dayrelease1.intention_type
	full join 
	(
	   select taskb.creator_id,all_type.intn_type as intention_type,
	  		 count(distinct case when log.status = 2 then taskb.id else null end) as intention_b_reject_cnt,
	  		  count(distinct case when log.status = 4 then taskb.id else null end) as intention_b_adoption_cnt
	    from (
	    	select id,rsc_intention_task_c_id,intention_type,createtime,status
	    	  from rsc_intention_task_c_log log
	    	 where log.deleteflag = 0
		     and substr(regexp_replace(log.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
		     and log.intention_type in (1,2)
		     and log.status in (2,4) 
	    ) log 
	    join rsc_intention_task_c taskc 
	    on log.rsc_intention_task_c_id = taskc.id 
	    join rsc_intention_task_b taskb 
	    on taskc.rsc_intention_task_b_id = taskb.id
	    join (select explode(array(1,2,3,9)) AS intn_type FROM dummy) all_type
		   on 1=1
		where all_type.intn_type in (3,9) or 
		(taskb.intention_type = all_type.intn_type) 	    
	    group by taskb.creator_id,all_type.intn_type
	) daytaskc1
	on weekresult1.creator_id = daytaskc1.creator_id
	and weekresult1.intention_type = daytaskc1.intention_type  
)  fact 
join 
(select id,name,org_id,org_name,position_id,position_name from dw_erp_d_salesuser_base where p_date =$date$) salesuser
on fact.creator_id = salesuser.id
left join dim_org
on salesuser.org_id = dim_org.d_org_id
group by fact.creator_id,
		salesuser.name ,
		salesuser.org_id,
		salesuser.org_name,
		salesuser.position_id,
		salesuser.position_name,
		dim_org.branch_id,
		dim_org.branch_name,
		fact.intention_type

create table if not exists fact_h_gcdc_w_intention_rpsorg_pre
(
	d_date int comment '统计日期',
	org_id int comment '招聘服务小组ID',
	org_name string comment '招聘服务小组名称',
	branch_id int comment '地区ID',
	branch_name string comment '地区名称',
	intention_b_type string comment '意向沟通类型',
	intention_b_cust_cnt int comment '意向沟通发起客户数',
	intention_b_consume_cust_cnt int comment '消耗意向沟通的客户数',
	intention_b_pub_consume_cust_cnt int comment '主动消耗意向沟通的客户数',
	intention_b_recom_consume_cust_cnt int comment '推荐消耗意向沟通的客户数',	
	intention_b_cnt int comment '意向沟通发起数',
	intention_b_release_cnt int comment '意向沟通释放数',
	intention_b_adoption_cnt int comment '意向沟通采纳数',
	intention_b_reject_cnt int comment '意向沟通驳回数',
	intention_b_consume_track_cnt int comment '意向沟通消耗总数',	
	intention_b_pub_track_cnt int comment '意向沟通主动发起数',
	intention_b_high_pub_track_cnt int comment '意向沟通主动发起数-高',
	intention_b_mid_pub_track_cnt int comment '意向沟通主动发起数-中',
	intention_b_low_pub_track_cnt int comment '意向沟通主动发起数-低',
	intention_b_none_pub_track_cnt int comment '意向沟通主动发起数-无',
	intention_b_invalid_pub_track_cnt int comment '意向沟通主动发起数-返还',	
	intention_b_recom_track_cnt int comment '意向沟通推荐发起数',
	intention_b_high_recom_track_cnt int comment '意向沟通推荐发起数-高',
	intention_b_mid_recom_track_cnt int comment '意向沟通推荐发起数-中',
	intention_b_low_recom_track_cnt int comment '意向沟通推荐发起数-低',
	intention_b_none_recom_track_cnt int comment '意向沟通推荐发起数-无',
	intention_b_invalid_recom_track_cnt int comment '意向沟通推荐发起数-返还',
	contact_cnt int comment '索要联系方式发起数',
	contact_consume_track_cnt int comment '索要联系方式消耗总数',
	contact_allow_pub_track_cnt int comment '索要联系方式（客户）-开放',
	contact_disallow_pub_track_cnt int comment '索要联系方式（客户）-不开放',
	contact_invalid_pub_track_cnt int comment '索要联系方式（客户）-未成功沟通',
	contact_allow_recom_track_cnt int comment '索要联系方式（推荐）-开放',
	contact_disallow_recom_track_cnt int comment '索要联系方式（推荐）-不开放',
	contact_invalid_recom_track_cnt int comment '索要联系方式（推荐）-未成功沟通',
	intention_contact_consume_track_cnt int comment '总消耗数',	
	creation_timestamp timestamp
) comment '招服Team意向沟通统计周表'
partitioned by (p_date int);

create table if not exists fact_h_gcdc_w_intention_rpsorg_pre
(
	d_date int comment '统计日期',
	org_id int comment '招聘服务小组ID',
	org_name varchar(100) comment '招聘服务小组名称',
	branch_id int comment '地区ID',
	branch_name varchar(50) comment '地区名称',
	intention_b_type varchar(50) comment '意向沟通类型',
	intention_b_cust_cnt int comment '意向沟通发起客户数',
	intention_b_consume_cust_cnt int comment '消耗意向沟通的客户数',
	intention_b_pub_consume_cust_cnt int comment '主动消耗意向沟通的客户数',
	intention_b_recom_consume_cust_cnt int comment '推荐消耗意向沟通的客户数',	
	intention_b_cnt int comment '意向沟通发起数',
	intention_b_release_cnt int comment '意向沟通释放数',
	intention_b_adoption_cnt int comment '意向沟通采纳数',
	intention_b_reject_cnt int comment '意向沟通驳回数',
	intention_b_consume_track_cnt int comment '意向沟通消耗总数',	
	intention_b_pub_track_cnt int comment '意向沟通主动发起数',
	intention_b_high_pub_track_cnt int comment '意向沟通主动发起数-高',
	intention_b_mid_pub_track_cnt int comment '意向沟通主动发起数-中',
	intention_b_low_pub_track_cnt int comment '意向沟通主动发起数-低',
	intention_b_none_pub_track_cnt int comment '意向沟通主动发起数-无',
	intention_b_invalid_pub_track_cnt int comment '意向沟通主动发起数-返还',	
	intention_b_recom_track_cnt int comment '意向沟通推荐发起数',
	intention_b_high_recom_track_cnt int comment '意向沟通推荐发起数-高',
	intention_b_mid_recom_track_cnt int comment '意向沟通推荐发起数-中',
	intention_b_low_recom_track_cnt int comment '意向沟通推荐发起数-低',
	intention_b_none_recom_track_cnt int comment '意向沟通推荐发起数-无',
	intention_b_invalid_recom_track_cnt int comment '意向沟通推荐发起数-返还',
	contact_cnt int comment '索要联系方式发起数',
	contact_consume_track_cnt int comment '索要联系方式消耗总数',
	contact_allow_pub_track_cnt int comment '索要联系方式（客户）-开放',
	contact_disallow_pub_track_cnt int comment '索要联系方式（客户）-不开放',
	contact_invalid_pub_track_cnt int comment '索要联系方式（客户）-未成功沟通',
	contact_allow_recom_track_cnt int comment '索要联系方式（推荐）-开放',
	contact_disallow_recom_track_cnt int comment '索要联系方式（推荐）-不开放',
	contact_invalid_recom_track_cnt int comment '索要联系方式（推荐）-未成功沟通',	
	intention_contact_consume_track_cnt int comment '总消耗数',	
	creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
	primary key (d_date,org_id,intention_b_type)
) comment '招服Team意向沟通统计周表';

insert overwrite table fact_h_gcdc_w_intention_rpsorg_pre partition (p_date =$date$)
select
	$date$ as d_date,
	nvl(fact.org_id,-1)  as org_id,
	nvl(dim_org.org_name,'未知') as org_name,
	nvl(dim_org.branch_id,-1) as branch_id,
	nvl(dim_org.branch_name,'未知') as branch_name,
	nvl(fact.intention_type,-1) as intention_b_type,
	sum(fact.intention_b_cust_cnt) as intention_b_cust_cnt,
	sum(fact.intention_b_consume_cust_cnt) as intention_b_consume_cust_cnt,
	sum(fact.intention_b_pub_consume_cust_cnt) as intention_b_pub_consume_cust_cnt,
	sum(fact.intention_b_recom_consume_cust_cnt) as intention_b_recom_consume_cust_cnt,
	sum(fact.intention_b_cnt) as intention_b_cnt,
	sum(fact.intention_b_release_cnt) as intention_b_release_cnt,
	sum(fact.intention_b_adoption_cnt) as intention_b_adoption_cnt,
	sum(fact.intention_b_reject_cnt) as intention_b_reject_cnt,
	sum(fact.intention_b_consume_track_cnt) as intention_b_consume_track_cnt,
	sum(fact.intention_b_pub_track_cnt) as intention_b_pub_track_cnt,
	sum(fact.intention_b_high_pub_track_cnt) as intention_b_high_pub_track_cnt,
	sum(fact.intention_b_mid_pub_track_cnt) as intention_b_mid_pub_track_cnt,
	sum(fact.intention_b_low_pub_track_cnt) as intention_b_low_pub_track_cnt,
	sum(fact.intention_b_none_pub_track_cnt) as intention_b_none_pub_track_cnt,
	sum(fact.intention_b_invalid_pub_track_cnt) as intention_b_invalid_pub_track_cnt,
	sum(fact.intention_b_recom_track_cnt) as intention_b_recom_track_cnt,
	sum(fact.intention_b_high_recom_track_cnt) as intention_b_high_recom_track_cnt,
	sum(fact.intention_b_mid_recom_track_cnt) as intention_b_mid_recom_track_cnt,
	sum(fact.intention_b_low_recom_track_cnt) as intention_b_low_recom_track_cnt,
	sum(fact.intention_b_none_recom_track_cnt) as intention_b_none_recom_track_cnt,
	sum(fact.intention_b_invalid_recom_track_cnt) as intention_b_invalid_recom_track_cnt,
	sum(fact.contact_cnt) as contact_cnt,
	sum(fact.contact_consume_track_cnt) as contact_consume_track_cnt,
	sum(fact.contact_allow_pub_track_cnt) as contact_allow_pub_track_cnt,
	sum(fact.contact_disallow_pub_track_cnt) as contact_disallow_pub_track_cnt,
	sum(fact.contact_invalid_pub_track_cnt) as contact_invalid_pub_track_cnt,
	sum(fact.contact_allow_recom_track_cnt) as contact_allow_recom_track_cnt,
	sum(fact.contact_disallow_recom_track_cnt) as contact_disallow_recom_track_cnt,
	sum(fact.contact_invalid_recom_track_cnt) as contact_invalid_recom_track_cnt,
	sum(fact.intention_contact_consume_track_cnt) as intention_contact_consume_track_cnt,	
	from_unixtime(unix_timestamp()) as creation_timestamp
from 
(
select 
	coalesce(weekresult1.org_id,daytaskb1.org_id,dayrelease1.org_id,daytaskc1.org_id) as org_id,
	coalesce(weekresult1.intention_type,daytaskb1.intention_type,dayrelease1.intention_type,daytaskc1.intention_type) as intention_type,

	nvl(dayrelease1.intention_b_release_cnt,0) as intention_b_release_cnt,
	nvl(daytaskc1.intention_b_adoption_cnt,0) as intention_b_adoption_cnt,
	nvl(daytaskc1.intention_b_reject_cnt,0) as intention_b_reject_cnt,
	nvl(weekresult1.intention_b_consume_cust_cnt,0) as intention_b_consume_cust_cnt,
	nvl(weekresult1.intention_b_pub_consume_cust_cnt,0) as intention_b_pub_consume_cust_cnt,
	nvl(weekresult1.intention_b_recom_consume_cust_cnt,0) as intention_b_recom_consume_cust_cnt,
	nvl(weekresult1.intention_b_consume_track_cnt,0) as intention_b_consume_track_cnt,
	nvl(weekresult1.intention_b_pub_track_cnt,0) as intention_b_pub_track_cnt,
	nvl(weekresult1.intention_b_high_pub_track_cnt,0) as intention_b_high_pub_track_cnt,
	nvl(weekresult1.intention_b_mid_pub_track_cnt,0) as intention_b_mid_pub_track_cnt,
	nvl(weekresult1.intention_b_low_pub_track_cnt,0) as intention_b_low_pub_track_cnt,
	nvl(weekresult1.intention_b_none_pub_track_cnt,0) as intention_b_none_pub_track_cnt,
	nvl(weekresult1.intention_b_invalid_pub_track_cnt,0) as intention_b_invalid_pub_track_cnt,
	nvl(weekresult1.intention_b_recom_track_cnt,0) as intention_b_recom_track_cnt,
	nvl(weekresult1.intention_b_high_recom_track_cnt,0) as intention_b_high_recom_track_cnt,
	nvl(weekresult1.intention_b_mid_recom_track_cnt,0) as intention_b_mid_recom_track_cnt,
	nvl(weekresult1.intention_b_low_recom_track_cnt,0) as intention_b_low_recom_track_cnt,
	nvl(weekresult1.intention_b_none_recom_track_cnt,0) as intention_b_none_recom_track_cnt,
	nvl(weekresult1.intention_b_invalid_recom_track_cnt,0) as intention_b_invalid_recom_track_cnt,
	nvl(weekresult1.contact_consume_track_cnt,0) as contact_consume_track_cnt,
	nvl(weekresult1.contact_allow_pub_track_cnt,0) as contact_allow_pub_track_cnt,
	nvl(weekresult1.contact_disallow_pub_track_cnt,0) as contact_disallow_pub_track_cnt,
	nvl(weekresult1.contact_invalid_pub_track_cnt,0) as contact_invalid_pub_track_cnt,
	nvl(weekresult1.contact_allow_recom_track_cnt,0) as contact_allow_recom_track_cnt,
	nvl(weekresult1.contact_disallow_recom_track_cnt,0) as contact_disallow_recom_track_cnt,
	nvl(weekresult1.contact_invalid_recom_track_cnt,0) as contact_invalid_recom_track_cnt,
	nvl(weekresult1.intention_b_consume_track_cnt,0) + nvl(weekresult1.contact_consume_track_cnt,0) as intention_contact_consume_track_cnt,
	nvl(daytaskb1.intention_b_cust_cnt,0) as intention_b_cust_cnt,
	nvl(daytaskb1.intention_b_cnt,0) as intention_b_cnt,
	nvl(daytaskb1.contact_cnt,0) as contact_cnt
from 
	(
	select 
	  task.org_id,trackTaskLog.intention_type,
	  count(distinct case when (trackTaskLog.intention_type in (1,2,3,9) and trackTaskLog.result IN ('1','2','3','4') ) or ( trackTaskLog.intention_type in (0,4,9) and trackTaskLog.demand_concat_result in (1,2)) then track.customer_id else null end) as intention_b_consume_cust_cnt ,
	  count(distinct case when ((trackTaskLog.intention_type in (1,2,3,9) and trackTaskLog.result IN ('1','2','3','4') ) or ( trackTaskLog.intention_type in (0,4,9) and trackTaskLog.demand_concat_result in (1,2))) and track.kind = 0 then track.customer_id else null end) as intention_b_pub_consume_cust_cnt ,
	  count(distinct case when ((trackTaskLog.intention_type in (1,2,3,9) and trackTaskLog.result IN ('1','2','3','4') ) or ( trackTaskLog.intention_type in (0,4,9) and trackTaskLog.demand_concat_result in (1,2)) ) and track.kind = 1 then track.customer_id else null end) as intention_b_recom_consume_cust_cnt ,
	  count(distinct case when trackTaskLog.result IN ('1','2','3','4') then task.id else null end)  as intention_b_consume_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('1','2','3','4') and track.kind = 0 then task.id else null end) as intention_b_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('1') and track.kind = 0 then task.id else null end) as intention_b_high_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('2') and track.kind = 0 then task.id else null end) as intention_b_mid_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('3') and track.kind = 0 then task.id else null end) as intention_b_low_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('4') and track.kind = 0 then task.id else null end) as intention_b_none_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('6') and track.kind = 0 then task.id else null end) as intention_b_invalid_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('1','2','3','4') and track.kind = 1 then task.id else null end) as intention_b_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('1') and track.kind = 1 then task.id else null end) as intention_b_high_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('2') and track.kind = 1 then task.id else null end) as intention_b_mid_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('3') and track.kind = 1 then task.id else null end) as intention_b_low_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('4') and track.kind = 1 then task.id else null end) as intention_b_none_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('6') and track.kind = 1 then task.id else null end) as intention_b_invalid_recom_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result in (1,2) then task.id else null end) as contact_consume_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 1 and track.kind = 0 then task.id else null end) as contact_allow_pub_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 2 and track.kind = 0 then task.id else null end) as contact_disallow_pub_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 4 and track.kind = 0 then task.id else null end) as contact_invalid_pub_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 1 and track.kind = 1 then task.id else null end) as contact_allow_recom_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 2 and track.kind = 1 then task.id else null end) as contact_disallow_recom_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 4 and track.kind = 1 then task.id else null end) as contact_invalid_recom_track_cnt
	  from 
	  (select 
	  		all_type.intn_type as intention_type,
	  		TaskLogb.id,
		    TaskLogb.result,
		    TaskLogb.creator_id,
		    TaskLogb.org_id,
		    TaskLogb.rsc_intention_task_b_id,
		    TaskLogb.demand_concat_result
	    from 
		  ( select  tasklog.id,
		    		tasklog.result,
		    		tasklog.creator_id,
		    		tasklog.org_id,
		    		tasklog.rsc_intention_task_b_id,
		    		tasklog.intention_type,
		    		tasklog.demand_concat_result
		    from (
		    select id,result,creator_id,org_id,intention_type,rsc_intention_task_b_id,demand_concat_result,
		    	   row_number()over(distribute by rsc_intention_task_b_id sort by createtime desc) rn 
		      from rsc_intention_task_b_log
		     where (result in ('1','2','3','4','6') or demand_concat_result in (1,2,4))
		       and deleteflag = 0
		       and intention_type in ('1','2','0')
		       and substr(regexp_replace(tracktime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
		    ) tasklog
		    where rn = 1
		  ) TaskLogb
		  join (select explode(array(0,1,2,3,4,9)) AS intn_type FROM dummy) all_type
		  on 1=1
		  where all_type.intn_type = 9 or 
		  		(TaskLogb.intention_type = all_type.intn_type) or 
		  		(all_type.intn_type = 3 and TaskLogb.intention_type <> 0) or 
		  		(all_type.intn_type = 4 and TaskLogb.intention_type <> 1)
	   ) trackTaskLog
	  join rsc_intention_task_b task
	  on trackTaskLog.rsc_intention_task_b_id=task.id
	  join rsc_intention track 
	  on task.rsc_intention_id=track.id
	  and track.deleteflag = 0
	  group by task.org_id,trackTaskLog.intention_type
	) weekresult1
	full join 
	(
	 select 
	  task.org_id,
	  task.intn_type as intention_type,
	  count(distinct track.customer_id) as intention_b_cust_cnt,
	  count(distinct case when task.intention_type <> 0 then task.id else null end) as intention_b_cnt,
	  count(distinct case when task.intention_type = 0 then task.id else null end) as contact_cnt
	  from 
	  (  
	  	select 
	  		taskb.creator_id,taskb.org_id,taskb.id,taskb.rsc_intention_id,taskb.createtime,taskb.intention_type,
	  		all_type.intn_type
	  	from (
		  	select task.creator_id,task.org_id,task.id,task.rsc_intention_id,intention_type,createtime
		    from rsc_intention_task_b task
		    where task.deleteflag = 0
		     and substr(regexp_replace(task.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
		     and task.intention_type in (1,2,0)
	     ) taskb 
	  	join (select explode(array(0,1,2,3,4,9)) AS intn_type FROM dummy) all_type
		   on 1=1
		   where all_type.intn_type = 9 or 
		   		(taskb.intention_type = all_type.intn_type) or 
		   		(all_type.intn_type = 3 and taskb.intention_type <> 0) or 
		   		(all_type.intn_type = 4 and taskb.intention_type <> 1)
	  ) task
	  join rsc_intention track 
	  on task.rsc_intention_id=track.id
	  and track.deleteflag = 0
	  group by task.org_id,task.intn_type
	) daytaskb1
	on weekresult1.org_id = daytaskb1.org_id
	and weekresult1.intention_type = daytaskb1.intention_type
	full join 
	(
	   select taskb.org_id,all_type.intn_type as intention_type,
	   		  count(distinct taskb.id) as intention_b_release_cnt
	    from (select taskc.id,taskc.rsc_intention_task_b_id,taskc.intention_type,taskc.createtime
	    	    from rsc_intention_task_c taskc
	    	    where taskc.deleteflag = 0
	    	      and substr(regexp_replace(taskc.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
	    	      and taskc.intention_type in (1,2)
	    	  ) task
	    join rsc_intention_task_b taskb 
		  on task.rsc_intention_task_b_id = taskb.id
	    join (select explode(array(1,2,3,9)) AS intn_type FROM dummy) all_type
		   on 1=1
		where all_type.intn_type in (3,9) or 
		   		(taskb.intention_type = all_type.intn_type) 
	    group by taskb.org_id,all_type.intn_type
	) dayrelease1
	on weekresult1.org_id = dayrelease1.org_id
	and weekresult1.intention_type = dayrelease1.intention_type
	full join 
	(
	   select taskb.org_id,all_type.intn_type as intention_type,
	  		  count(distinct case when log.status = 2 then taskb.id else null end) as intention_b_reject_cnt,
	  		  count(distinct case when log.status = 4 then taskb.id else null end) as intention_b_adoption_cnt
	    from (
	    	select id,rsc_intention_task_c_id,intention_type,createtime,status
	    	  from rsc_intention_task_c_log log
	    	 where log.deleteflag = 0
		     and substr(regexp_replace(log.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
		     and log.intention_type in (1,2)
		     and log.status in (2,4) 
	    ) log 
	    join rsc_intention_task_c taskc 
	    on log.rsc_intention_task_c_id = taskc.id 
	    join rsc_intention_task_b taskb 
	    on taskc.rsc_intention_task_b_id = taskb.id
	    join (select explode(array(1,2,3,9)) AS intn_type FROM dummy) all_type
		   on 1=1
		where all_type.intn_type in (3,9) or 
		(taskb.intention_type = all_type.intn_type) 	    
	    group by taskb.org_id,all_type.intn_type
	) daytaskc1
	on weekresult1.org_id = daytaskc1.org_id
	and weekresult1.intention_type = daytaskc1.intention_type  
)  fact 
left join dim_org
on fact.org_id = dim_org.d_org_id
group by fact.org_id,
		 dim_org.org_name,
		 dim_org.branch_id,
		 dim_org.branch_name,
		 fact.intention_type;

create table if not exists fact_h_gcdc_w_intention_rpsbranch_pre
(
	d_date int comment '统计日期',
	branch_id int comment '地区ID',
	branch_name string comment '地区名称',
	intention_b_type string comment '意向沟通类型',
	intention_b_cust_cnt int comment '意向沟通发起客户数',
	intention_b_consume_cust_cnt int comment '消耗意向沟通的客户数',
	intention_b_pub_consume_cust_cnt int comment '主动消耗意向沟通的客户数',
	intention_b_recom_consume_cust_cnt int comment '推荐消耗意向沟通的客户数',	
	intention_b_cnt int comment '意向沟通发起数',
	intention_b_release_cnt int comment '意向沟通释放数',
	intention_b_adoption_cnt int comment '意向沟通采纳数',
	intention_b_reject_cnt int comment '意向沟通驳回数',
	intention_b_consume_track_cnt int comment '意向沟通消耗总数',	
	intention_b_pub_track_cnt int comment '意向沟通主动发起数',
	intention_b_high_pub_track_cnt int comment '意向沟通主动发起数-高',
	intention_b_mid_pub_track_cnt int comment '意向沟通主动发起数-中',
	intention_b_low_pub_track_cnt int comment '意向沟通主动发起数-低',
	intention_b_none_pub_track_cnt int comment '意向沟通主动发起数-无',
	intention_b_invalid_pub_track_cnt int comment '意向沟通主动发起数-返还',	
	intention_b_recom_track_cnt int comment '意向沟通推荐发起数',
	intention_b_high_recom_track_cnt int comment '意向沟通推荐发起数-高',
	intention_b_mid_recom_track_cnt int comment '意向沟通推荐发起数-中',
	intention_b_low_recom_track_cnt int comment '意向沟通推荐发起数-低',
	intention_b_none_recom_track_cnt int comment '意向沟通推荐发起数-无',
	intention_b_invalid_recom_track_cnt int comment '意向沟通推荐发起数-返还',
	contact_cnt int comment '索要联系方式发起数',
	contact_consume_track_cnt int comment '索要联系方式消耗总数',
	contact_allow_pub_track_cnt int comment '索要联系方式（客户）-开放',
	contact_disallow_pub_track_cnt int comment '索要联系方式（客户）-不开放',
	contact_invalid_pub_track_cnt int comment '索要联系方式（客户）-未成功沟通',
	contact_allow_recom_track_cnt int comment '索要联系方式（推荐）-开放',
	contact_disallow_recom_track_cnt int comment '索要联系方式（推荐）-不开放',
	contact_invalid_recom_track_cnt int comment '索要联系方式（推荐）-未成功沟通',
	intention_contact_consume_track_cnt int comment '总消耗数',	
	creation_timestamp timestamp
) comment '招服地区意向沟通统计周表'
partitioned by (p_date int);

create table if not exists fact_h_gcdc_w_intention_rpsbranch_pre
(
	d_date int comment '统计日期',
	branch_id int comment '地区ID',
	branch_name varchar(50) comment '地区名称',
	intention_b_type varchar(50) comment '意向沟通类型',
	intention_b_cust_cnt int comment '意向沟通发起客户数',
	intention_b_consume_cust_cnt int comment '消耗意向沟通的客户数',
	intention_b_pub_consume_cust_cnt int comment '主动消耗意向沟通的客户数',
	intention_b_recom_consume_cust_cnt int comment '推荐消耗意向沟通的客户数',	
	intention_b_cnt int comment '意向沟通发起数',
	intention_b_release_cnt int comment '意向沟通释放数',
	intention_b_adoption_cnt int comment '意向沟通采纳数',
	intention_b_reject_cnt int comment '意向沟通驳回数',
	intention_b_consume_track_cnt int comment '意向沟通消耗总数',	
	intention_b_pub_track_cnt int comment '意向沟通主动发起数',
	intention_b_high_pub_track_cnt int comment '意向沟通主动发起数-高',
	intention_b_mid_pub_track_cnt int comment '意向沟通主动发起数-中',
	intention_b_low_pub_track_cnt int comment '意向沟通主动发起数-低',
	intention_b_none_pub_track_cnt int comment '意向沟通主动发起数-无',
	intention_b_invalid_pub_track_cnt int comment '意向沟通主动发起数-返还',	
	intention_b_recom_track_cnt int comment '意向沟通推荐发起数',
	intention_b_high_recom_track_cnt int comment '意向沟通推荐发起数-高',
	intention_b_mid_recom_track_cnt int comment '意向沟通推荐发起数-中',
	intention_b_low_recom_track_cnt int comment '意向沟通推荐发起数-低',
	intention_b_none_recom_track_cnt int comment '意向沟通推荐发起数-无',
	intention_b_invalid_recom_track_cnt int comment '意向沟通推荐发起数-返还',
	contact_cnt int comment '索要联系方式发起数',
	contact_consume_track_cnt int comment '索要联系方式消耗总数',
	contact_allow_pub_track_cnt int comment '索要联系方式（客户）-开放',
	contact_disallow_pub_track_cnt int comment '索要联系方式（客户）-不开放',
	contact_invalid_pub_track_cnt int comment '索要联系方式（客户）-未成功沟通',
	contact_allow_recom_track_cnt int comment '索要联系方式（推荐）-开放',
	contact_disallow_recom_track_cnt int comment '索要联系方式（推荐）-不开放',
	contact_invalid_recom_track_cnt int comment '索要联系方式（推荐）-未成功沟通',	
	intention_contact_consume_track_cnt int comment '总消耗数',	
	creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
	primary key (d_date,branch_id,intention_b_type)
) comment '招服地区意向沟通统计周表';

insert overwrite table fact_h_gcdc_w_intention_rpsbranch_pre partition (p_date =$date$)
select
	$date$ as d_date,
	nvl(fact.branch_id,-1) as branch_id,
	nvl(fact.branch_name,'未知') as branch_name,
	nvl(fact.intention_type,-1) as intention_b_type,
	sum(fact.intention_b_cust_cnt) as intention_b_cust_cnt,
	sum(fact.intention_b_consume_cust_cnt) as intention_b_consume_cust_cnt,
	sum(fact.intention_b_pub_consume_cust_cnt) as intention_b_pub_consume_cust_cnt,
	sum(fact.intention_b_recom_consume_cust_cnt) as intention_b_recom_consume_cust_cnt,
	sum(fact.intention_b_cnt) as intention_b_cnt,
	sum(fact.intention_b_release_cnt) as intention_b_release_cnt,
	sum(fact.intention_b_adoption_cnt) as intention_b_adoption_cnt,
	sum(fact.intention_b_reject_cnt) as intention_b_reject_cnt,
	sum(fact.intention_b_consume_track_cnt) as intention_b_consume_track_cnt,
	sum(fact.intention_b_pub_track_cnt) as intention_b_pub_track_cnt,
	sum(fact.intention_b_high_pub_track_cnt) as intention_b_high_pub_track_cnt,
	sum(fact.intention_b_mid_pub_track_cnt) as intention_b_mid_pub_track_cnt,
	sum(fact.intention_b_low_pub_track_cnt) as intention_b_low_pub_track_cnt,
	sum(fact.intention_b_none_pub_track_cnt) as intention_b_none_pub_track_cnt,
	sum(fact.intention_b_invalid_pub_track_cnt) as intention_b_invalid_pub_track_cnt,
	sum(fact.intention_b_recom_track_cnt) as intention_b_recom_track_cnt,
	sum(fact.intention_b_high_recom_track_cnt) as intention_b_high_recom_track_cnt,
	sum(fact.intention_b_mid_recom_track_cnt) as intention_b_mid_recom_track_cnt,
	sum(fact.intention_b_low_recom_track_cnt) as intention_b_low_recom_track_cnt,
	sum(fact.intention_b_none_recom_track_cnt) as intention_b_none_recom_track_cnt,
	sum(fact.intention_b_invalid_recom_track_cnt) as intention_b_invalid_recom_track_cnt,
	sum(fact.contact_cnt) as contact_cnt,
	sum(fact.contact_consume_track_cnt) as contact_consume_track_cnt,
	sum(fact.contact_allow_pub_track_cnt) as contact_allow_pub_track_cnt,
	sum(fact.contact_disallow_pub_track_cnt) as contact_disallow_pub_track_cnt,
	sum(fact.contact_invalid_pub_track_cnt) as contact_invalid_pub_track_cnt,
	sum(fact.contact_allow_recom_track_cnt) as contact_allow_recom_track_cnt,
	sum(fact.contact_disallow_recom_track_cnt) as contact_disallow_recom_track_cnt,
	sum(fact.contact_invalid_recom_track_cnt) as contact_invalid_recom_track_cnt,
	sum(fact.intention_contact_consume_track_cnt) as intention_contact_consume_track_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp
from 
(
select 
	coalesce(weekresult1.branch_id,daytaskb1.branch_id,dayrelease1.branch_id,daytaskc1.branch_id) as branch_id,
	coalesce(weekresult1.branch_name,daytaskb1.branch_name,dayrelease1.branch_name,daytaskc1.branch_name) as branch_name,
	coalesce(weekresult1.intention_type,daytaskb1.intention_type,dayrelease1.intention_type,daytaskc1.intention_type) as intention_type,

	nvl(dayrelease1.intention_b_release_cnt,0) as intention_b_release_cnt,
	nvl(daytaskc1.intention_b_adoption_cnt,0) as intention_b_adoption_cnt,
	nvl(daytaskc1.intention_b_reject_cnt,0) as intention_b_reject_cnt,
	nvl(weekresult1.intention_b_consume_cust_cnt,0) as intention_b_consume_cust_cnt,
	nvl(weekresult1.intention_b_pub_consume_cust_cnt,0) as intention_b_pub_consume_cust_cnt,
	nvl(weekresult1.intention_b_recom_consume_cust_cnt,0) as intention_b_recom_consume_cust_cnt,
	nvl(weekresult1.intention_b_consume_track_cnt,0) as intention_b_consume_track_cnt,
	nvl(weekresult1.intention_b_pub_track_cnt,0) as intention_b_pub_track_cnt,
	nvl(weekresult1.intention_b_high_pub_track_cnt,0) as intention_b_high_pub_track_cnt,
	nvl(weekresult1.intention_b_mid_pub_track_cnt,0) as intention_b_mid_pub_track_cnt,
	nvl(weekresult1.intention_b_low_pub_track_cnt,0) as intention_b_low_pub_track_cnt,
	nvl(weekresult1.intention_b_none_pub_track_cnt,0) as intention_b_none_pub_track_cnt,
	nvl(weekresult1.intention_b_invalid_pub_track_cnt,0) as intention_b_invalid_pub_track_cnt,
	nvl(weekresult1.intention_b_recom_track_cnt,0) as intention_b_recom_track_cnt,
	nvl(weekresult1.intention_b_high_recom_track_cnt,0) as intention_b_high_recom_track_cnt,
	nvl(weekresult1.intention_b_mid_recom_track_cnt,0) as intention_b_mid_recom_track_cnt,
	nvl(weekresult1.intention_b_low_recom_track_cnt,0) as intention_b_low_recom_track_cnt,
	nvl(weekresult1.intention_b_none_recom_track_cnt,0) as intention_b_none_recom_track_cnt,
	nvl(weekresult1.intention_b_invalid_recom_track_cnt,0) as intention_b_invalid_recom_track_cnt,
	nvl(weekresult1.contact_consume_track_cnt,0) as contact_consume_track_cnt,
	nvl(weekresult1.contact_allow_pub_track_cnt,0) as contact_allow_pub_track_cnt,
	nvl(weekresult1.contact_disallow_pub_track_cnt,0) as contact_disallow_pub_track_cnt,
	nvl(weekresult1.contact_invalid_pub_track_cnt,0) as contact_invalid_pub_track_cnt,
	nvl(weekresult1.contact_allow_recom_track_cnt,0) as contact_allow_recom_track_cnt,
	nvl(weekresult1.contact_disallow_recom_track_cnt,0) as contact_disallow_recom_track_cnt,
	nvl(weekresult1.contact_invalid_recom_track_cnt,0) as contact_invalid_recom_track_cnt,
	nvl(weekresult1.intention_b_consume_track_cnt,0) + nvl(weekresult1.contact_consume_track_cnt,0) as intention_contact_consume_track_cnt,
	nvl(daytaskb1.intention_b_cust_cnt,0) as intention_b_cust_cnt,
	nvl(daytaskb1.intention_b_cnt,0) as intention_b_cnt,
	nvl(daytaskb1.contact_cnt,0) as contact_cnt
from 
	(
	select 
	  dim_org.branch_id,dim_org.branch_name,trackTaskLog.intention_type,
	  count(distinct case when (trackTaskLog.intention_type in (1,2,3,9) and trackTaskLog.result IN ('1','2','3','4') ) or ( trackTaskLog.intention_type in (0,4,9) and trackTaskLog.demand_concat_result in (1,2)) then track.customer_id else null end) as intention_b_consume_cust_cnt ,
	  count(distinct case when ((trackTaskLog.intention_type in (1,2,3,9) and trackTaskLog.result IN ('1','2','3','4') ) or ( trackTaskLog.intention_type in (0,4,9) and trackTaskLog.demand_concat_result in (1,2))) and track.kind = 0 then track.customer_id else null end) as intention_b_pub_consume_cust_cnt ,
	  count(distinct case when ((trackTaskLog.intention_type in (1,2,3,9) and trackTaskLog.result IN ('1','2','3','4') ) or ( trackTaskLog.intention_type in (0,4,9) and trackTaskLog.demand_concat_result in (1,2)) ) and track.kind = 1 then track.customer_id else null end) as intention_b_recom_consume_cust_cnt ,
	  count(distinct case when trackTaskLog.result IN ('1','2','3','4') then task.id else null end)  as intention_b_consume_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('1','2','3','4') and track.kind = 0 then task.id else null end) as intention_b_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('1') and track.kind = 0 then task.id else null end) as intention_b_high_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('2') and track.kind = 0 then task.id else null end) as intention_b_mid_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('3') and track.kind = 0 then task.id else null end) as intention_b_low_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('4') and track.kind = 0 then task.id else null end) as intention_b_none_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('6') and track.kind = 0 then task.id else null end) as intention_b_invalid_pub_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('1','2','3','4') and track.kind = 1 then task.id else null end) as intention_b_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('1') and track.kind = 1 then task.id else null end) as intention_b_high_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('2') and track.kind = 1 then task.id else null end) as intention_b_mid_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('3') and track.kind = 1 then task.id else null end) as intention_b_low_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('4') and track.kind = 1 then task.id else null end) as intention_b_none_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('6') and track.kind = 1 then task.id else null end) as intention_b_invalid_recom_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result in (1,2) then task.id else null end) as contact_consume_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 1 and track.kind = 0 then task.id else null end) as contact_allow_pub_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 2 and track.kind = 0 then task.id else null end) as contact_disallow_pub_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 4 and track.kind = 0 then task.id else null end) as contact_invalid_pub_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 1 and track.kind = 1 then task.id else null end) as contact_allow_recom_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 2 and track.kind = 1 then task.id else null end) as contact_disallow_recom_track_cnt,
	  count(distinct case when trackTaskLog.demand_concat_result = 4 and track.kind = 1 then task.id else null end) as contact_invalid_recom_track_cnt,
	  count(distinct case when trackTaskLog.result IN ('1','2','3','4') or trackTaskLog.demand_concat_result in (1,2) then task.id else null end) as intention_contact_consume_track_cnt 	
	  from 
	  (select 
	  		all_type.intn_type as intention_type,
	  		TaskLogb.id,
		    TaskLogb.result,
		    TaskLogb.creator_id,
		    TaskLogb.org_id,
		    TaskLogb.rsc_intention_task_b_id,
		    TaskLogb.demand_concat_result
	    from 
		  ( select  tasklog.id,
		    		tasklog.result,
		    		tasklog.creator_id,
		    		tasklog.org_id,
		    		tasklog.rsc_intention_task_b_id,
		    		tasklog.intention_type,
		    		tasklog.demand_concat_result
		    from (
		    select id,result,creator_id,org_id,intention_type,rsc_intention_task_b_id,demand_concat_result,
		    	   row_number()over(distribute by rsc_intention_task_b_id sort by createtime desc) rn 
		      from rsc_intention_task_b_log
		     where (result in ('1','2','3','4','6') or demand_concat_result in (1,2,4))
		       and deleteflag = 0
		       and intention_type in ('1','2','0')
		       and substr(regexp_replace(tracktime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
		    ) tasklog
		    where rn = 1
		  ) TaskLogb
		  join (select explode(array(0,1,2,3,4,9)) AS intn_type FROM dummy) all_type
		  on 1=1
		  where all_type.intn_type = 9 or 
		  		(TaskLogb.intention_type = all_type.intn_type) or 
		  		(all_type.intn_type = 3 and TaskLogb.intention_type <> 0) or 
		  		(all_type.intn_type = 4 and TaskLogb.intention_type <> 1)
	   ) trackTaskLog
	  join rsc_intention_task_b task
	  on trackTaskLog.rsc_intention_task_b_id=task.id
	  join rsc_intention track 
	  on task.rsc_intention_id=track.id
	  and track.deleteflag = 0
	  join dim_org 
	  on task.org_id = dim_org.d_org_id	 		  
	  group by dim_org.branch_id,dim_org.branch_name,trackTaskLog.intention_type	 
	) weekresult1
	full join 
	(
	 select 
	  dim_org.branch_id,dim_org.branch_name,task.intn_type as intention_type,
	  count(distinct track.customer_id) as intention_b_cust_cnt,
	  count(distinct case when task.intention_type <> 0 then task.id else null end) as intention_b_cnt,
	  count(distinct case when task.intention_type = 0 then task.id else null end) as contact_cnt
	  from 
	  (  
	  	select 
	  		taskb.creator_id,taskb.org_id,taskb.id,taskb.rsc_intention_id,taskb.createtime,taskb.intention_type,
	  		all_type.intn_type
	  	from (
		  	select task.creator_id,org_id,task.id,task.rsc_intention_id,intention_type,createtime
		    from rsc_intention_task_b task
		    where task.deleteflag = 0
		     and substr(regexp_replace(task.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
		     and task.intention_type in (1,2,0)
	     ) taskb 
	  	join (select explode(array(0,1,2,3,4,9)) AS intn_type FROM dummy) all_type
		   on 1=1
		   where all_type.intn_type = 9 or 
		   		(taskb.intention_type = all_type.intn_type) or 
		   		(all_type.intn_type = 3 and taskb.intention_type <> 0) or 
		   		(all_type.intn_type = 4 and taskb.intention_type <> 1)
	  ) task
	  join rsc_intention track 
	  on task.rsc_intention_id=track.id
	  and track.deleteflag = 0
	  join dim_org 
	  on task.org_id = dim_org.d_org_id	 
	  group by dim_org.branch_id,dim_org.branch_name,task.intn_type	  
	) daytaskb1
	on weekresult1.branch_id = daytaskb1.branch_id
	and weekresult1.intention_type = daytaskb1.intention_type
	full join 
	(
	   select dim_org.branch_id,dim_org.branch_name,all_type.intn_type as intention_type,
	   		  count(distinct taskb.id) as intention_b_release_cnt
	    from (select taskc.id,taskc.rsc_intention_task_b_id,taskc.intention_type,taskc.createtime
	    	    from rsc_intention_task_c taskc
	    	    where taskc.deleteflag = 0
	    	      and substr(regexp_replace(taskc.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
	    	      and taskc.intention_type in (1,2)
	    	  ) task
	    join rsc_intention_task_b taskb 
		  on task.rsc_intention_task_b_id = taskb.id
		join dim_org 
		on taskb.org_id = dim_org.d_org_id	 	  
	    join (select explode(array(1,2,3,9)) AS intn_type FROM dummy) all_type
		   on 1=1
		where all_type.intn_type in (3,9) or (taskb.intention_type = all_type.intn_type) 
	   group by dim_org.branch_id,dim_org.branch_name,all_type.intn_type
	) dayrelease1
	on weekresult1.branch_id = dayrelease1.branch_id
	and weekresult1.intention_type = dayrelease1.intention_type
	full join 
	(
	   select dim_org.branch_id,dim_org.branch_name,all_type.intn_type as intention_type,
	  		  count(distinct case when log.status = 2 then taskb.id else null end) as intention_b_reject_cnt,
	  		  count(distinct case when log.status = 4 then taskb.id else null end) as intention_b_adoption_cnt
	    from (
	    	select id,rsc_intention_task_c_id,intention_type,createtime,status
	    	  from rsc_intention_task_c_log log
	    	 where log.deleteflag = 0
		     and substr(regexp_replace(log.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$ 
		     and log.intention_type in (1,2)
		     and log.status in (2,4) 
	    ) log 
	    join rsc_intention_task_c taskc 
	    on log.rsc_intention_task_c_id = taskc.id 
	    join rsc_intention_task_b taskb 
	    on taskc.rsc_intention_task_b_id = taskb.id
		join dim_org 
		on taskb.org_id = dim_org.d_org_id	    
	    join (select explode(array(1,2,3,9)) AS intn_type FROM dummy) all_type
		   on 1=1
		where all_type.intn_type in (3,9) or 
		(taskb.intention_type = all_type.intn_type) 	    
	    group by dim_org.branch_id,dim_org.branch_name,all_type.intn_type
	) daytaskc1
	on weekresult1.branch_id = daytaskc1.branch_id
	and weekresult1.intention_type = daytaskc1.intention_type  
)  fact 
group by fact.branch_id,
		 fact.branch_name,
		 fact.intention_type;