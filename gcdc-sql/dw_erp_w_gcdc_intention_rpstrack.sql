create table if not exists dw_erp_w_gcdc_intention_rpstrack
(
	d_date int comment '统计日期',
	gcdc_user_id int comment 'GCDC销售ID',
	gcdc_user_name string comment 'GCDC销售姓名',
	org_id int comment 'GCDC小组ID',
	org_name string comment 'GCDC小组名称',
	branch_id int comment '小组地区ID',
	branch_name string comment '小组地区名称',
	cust_cnt int comment '意向沟通发起客户数',
	consume_cust_cnt int comment '消耗意向沟通的客户数',
	pub_consume_cust_cnt int comment '主动消耗意向沟通的客户数',
	recom_consume_cust_cnt int comment '推荐消耗意向沟通的客户数',	
	track_cnt int comment '意向沟通发起数',
	consume_track_cnt int comment '意向沟通消耗总数',	
	pub_track_cnt int comment '意向沟通主动发起数',
	high_pub_track_cnt int comment '意向沟通主动发起数-高',
	mid_pub_track_cnt int comment '意向沟通主动发起数-中',
	low_pub_track_cnt int comment '意向沟通主动发起数-低',
	none_pub_track_cnt int comment '意向沟通主动发起数-无',
	invalid_pub_track_cnt int comment '意向沟通主动发起数-返还',	
	recom_track_cnt int comment '意向沟通推荐发起数',
	high_recom_track_cnt int comment '意向沟通推荐发起数-高',
	mid_recom_track_cnt int comment '意向沟通推荐发起数-中',
	low_recom_track_cnt int comment '意向沟通推荐发起数-低',
	none_recom_track_cnt int comment '意向沟通推荐发起数-无',
	invalid_recom_track_cnt int comment '意向沟通推荐发起数-返还',
	creation_timestamp timestamp
)
partitioned by (p_date int);

insert overwrite table dw_erp_w_gcdc_intention_rpstrack partition (p_date =$date$)
select
	$date$ as d_date,
	fact.creator_id as gcdc_user_id,
	nvl(salesuser.name ,'未知')as gcdc_user_name,
	nvl(fact.org_id,-1)  as org_id,
	nvl(org.org_name,'未知') as org_name,
	nvl(org.branch_id,-1) as branch_id,
	nvl(org.branch_name,'未知') as branch_name,
	sum( cust_cnt )  as  cust_cnt ,
	sum( consume_cust_cnt )  as  consume_cust_cnt ,
	sum( pub_consume_cust_cnt )  as  pub_consume_cust_cnt ,
	sum( recom_consume_cust_cnt )  as  recom_consume_cust_cnt ,
	sum( track_cnt )  as  track_cnt ,
	sum( pub_track_cnt ) + sum( recom_track_cnt )  as  consume_track_cnt ,
	sum( pub_track_cnt )  as  pub_track_cnt ,
	sum( high_pub_track_cnt )  as  high_pub_track_cnt ,
	sum( mid_pub_track_cnt )  as  mid_pub_track_cnt ,
	sum( low_pub_track_cnt )  as  low_pub_track_cnt ,
	sum( none_pub_track_cnt )  as  none_pub_track_cnt ,
	sum( invalid_pub_track_cnt )  as  invalid_pub_track_cnt ,
	sum( recom_track_cnt )  as  recom_track_cnt ,
	sum( high_recom_track_cnt )  as  high_recom_track_cnt ,
	sum( mid_recom_track_cnt )  as  mid_recom_track_cnt ,
	sum( low_recom_track_cnt )  as  low_recom_track_cnt ,
	sum( none_recom_track_cnt )  as  none_recom_track_cnt ,
	sum( invalid_recom_track_cnt )  as  invalid_recom_track_cnt ,	
	from_unixtime(unix_timestamp()) as creation_timestamp
from 
(
select 
	task.creator_id,task.org_id,
	0 as cust_cnt ,
	count(distinct case when trackTaskLog.result IN ('1','2','3','4') then track.customer_id else null end) as consume_cust_cnt,
	count(distinct case when trackTaskLog.result IN ('1','2','3','4') and track.kind = 0 then track.customer_id else null end) as pub_consume_cust_cnt ,
	count(distinct case when trackTaskLog.result IN ('1','2','3','4') and track.kind = 1 then track.customer_id else null end) as recom_consume_cust_cnt ,
	0 as track_cnt,
	0 as consume_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('1','2','3','4','6') and track.kind = 0 then task.id else null end) as pub_track_cnt,
	count(distinct case when trackTaskLog.result IN ('1') and track.kind = 0 then task.id else null end) as high_pub_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('2') and track.kind = 0 then task.id else null end) as mid_pub_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('3') and track.kind = 0 then task.id else null end) as low_pub_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('4') and track.kind = 0 then task.id else null end) as none_pub_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('6') and track.kind = 0 then task.id else null end) as invalid_pub_track_cnt,
	count(distinct case when trackTaskLog.result IN ('1','2','3','4','6') and track.kind = 1 then task.id else null end) as recom_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('1') and track.kind = 1 then task.id else null end) as high_recom_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('2') and track.kind = 1 then task.id else null end) as mid_recom_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('3') and track.kind = 1 then task.id else null end) as low_recom_track_cnt  ,
	count(distinct case when trackTaskLog.result IN ('4') and track.kind = 1 then task.id else null end) as none_recom_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('6') and track.kind = 1 then task.id else null end) as invalid_recom_track_cnt
	from 
	( select  tasklog.id, tasklog.result,tasklog.rsc_intention_task_b_id
			   from rsc_intention_task_b_log tasklog
			  where tasklog.deleteflag = 0
			  and substr(regexp_replace(tasklog.tracktime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and $date$
			  and tasklog.result in ('1','2','3','4') 
	  union all  
	  select  noused.id,noused.result,noused.rsc_intention_task_b_id	  
	  from 
		 (select  tasklog.id, tasklog.result,tasklog.rsc_intention_task_b_id,substr(regexp_replace(tasklog.tracktime,'-',''),1,8) as trackday
			from rsc_intention_task_b_log tasklog
		 where tasklog.deleteflag = 0
			  and substr(regexp_replace(tasklog.tracktime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and $date$
			  and tasklog.result = '6'
		) noused
		left  join 
		(    select  tasklog.id, tasklog.result,tasklog.rsc_intention_task_b_id,substr(regexp_replace(tasklog.tracktime,'-',''),1,8) as trackday
			   from rsc_intention_task_b_log tasklog
			where tasklog.deleteflag = 0
				 and substr(regexp_replace(tasklog.tracktime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and $date$
				 and tasklog.result in ('1','2','3','4')
		) used 
		on noused.rsc_intention_task_b_id = used.rsc_intention_task_b_id
		where used.rsc_intention_task_b_id is null 
		group by  noused.id,noused.result,noused.rsc_intention_task_b_id
	) trackTaskLog
	join rsc_intention_task_b task
	on trackTaskLog.rsc_intention_task_b_id=task.id
	join rsc_intention track 
	on task.rsc_intention_id=track.id
	and track.deleteflag = 0
	group by task.creator_id,task.org_id
union all
 select 
	task.creator_id,task.org_id,
 	count(distinct track.customer_id) as cust_cnt ,
	0 as consume_cust_cnt,
	0 as pub_consume_cust_cnt ,
	0 as recom_consume_cust_cnt ,	
	count(distinct task.id) as track_cnt,
	0 as consume_track_cnt ,	
	0 as pub_track_cnt,
	0 as high_pub_track_cnt ,
	0 as mid_pub_track_cnt ,
	0 as low_pub_track_cnt ,
	0 as none_pub_track_cnt ,
	0 as invalid_pub_track_cnt ,	
	0 as recom_track_cnt ,
	0 as high_recom_track_cnt ,
	0 as mid_recom_track_cnt ,
	0 as low_recom_track_cnt  ,
	0 as none_recom_track_cnt ,
	0 as invalid_recom_track_cnt
	from 
	(  select task.creator_id,org_id,task.id,task.rsc_intention_id
		from rsc_intention_task_b task
		where task.deleteflag = 0
		 and substr(regexp_replace(task.createtime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and $date$
	)  task
	join rsc_intention track 
	on task.rsc_intention_id=track.id
	and track.deleteflag = 0
	group by task.creator_id,task.org_id
)  fact 
join 
(select id,name from dw_erp_d_salesuser_base where p_date= $date$) salesuser
on fact.creator_id = salesuser.id
left join 
(select id,name as org_name,branch_id,branch_name from dim_gcdc_org  where p_date= $date$) org
on fact.org_id = org.id
left join dim_date d on d.d_date = $date$
group by 
	fact.creator_id,
	salesuser.name,
	fact.org_id,
	org.org_name,
	org.branch_id,
	org.branch_name,
	d.d_year,
	d.d_week;







insert overwrite table dw_erp_w_gcdc_intention_rpstrack partition (p_date =$date$)
select
	$date$ as d_date,
	fact.creator_id as gcdc_user_id,
	nvl(user.name ,'未知')as gcdc_user_name,
	nvl(fact.org_id,-1)  as org_id,
	nvl(org.org_name,'未知') as org_name,
	nvl(org.branch_id,-1) as branch_id,
	nvl(org.branch_name,'未知') as branch_name,
	sum( cust_cnt )  as  cust_cnt ,
	sum( consume_cust_cnt )  as  consume_cust_cnt ,
	sum( pub_consume_cust_cnt )  as  pub_consume_cust_cnt ,
	sum( recom_consume_cust_cnt )  as  recom_consume_cust_cnt ,
	sum( track_cnt )  as  track_cnt ,
	sum( consume_track_cnt )  as  consume_track_cnt ,
	sum( pub_track_cnt )  as  pub_track_cnt ,
	sum( high_pub_track_cnt )  as  high_pub_track_cnt ,
	sum( mid_pub_track_cnt )  as  mid_pub_track_cnt ,
	sum( low_pub_track_cnt )  as  low_pub_track_cnt ,
	sum( none_pub_track_cnt )  as  none_pub_track_cnt ,
	sum( invalid_pub_track_cnt )  as  invalid_pub_track_cnt ,
	sum( recom_track_cnt )  as  recom_track_cnt ,
	sum( high_recom_track_cnt )  as  high_recom_track_cnt ,
	sum( mid_recom_track_cnt )  as  mid_recom_track_cnt ,
	sum( low_recom_track_cnt )  as  low_recom_track_cnt ,
	sum( none_recom_track_cnt )  as  none_recom_track_cnt ,
	sum( invalid_recom_track_cnt )  as  invalid_recom_track_cnt ,	
	from_unixtime(unix_timestamp()) as creation_timestamp
from 
(
select 
	task.creator_id,task.org_id,
	0 as cust_cnt ,
	count(distinct case when trackTaskLog.result IN ('1','2','3','4') then track.customer_id else null end) as consume_cust_cnt,
	count(distinct case when trackTaskLog.result IN ('1','2','3','4') and track.kind = 0 then track.customer_id else null end) as pub_consume_cust_cnt ,
	count(distinct case when trackTaskLog.result IN ('1','2','3','4') and track.kind = 1 then track.customer_id else null end) as recom_consume_cust_cnt ,
	0 as track_cnt,
	0 as consume_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('1','2','3','4','6') and track.kind = 0 then task.id else null end) as pub_track_cnt,
	count(distinct case when trackTaskLog.result IN ('1') and track.kind = 0 then task.id else null end) as high_pub_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('2') and track.kind = 0 then task.id else null end) as mid_pub_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('3') and track.kind = 0 then task.id else null end) as low_pub_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('4') and track.kind = 0 then task.id else null end) as none_pub_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('6') and track.kind = 0 then task.id else null end) as invalid_pub_track_cnt,
	count(distinct case when trackTaskLog.result IN ('1','2','3','4','6') and track.kind = 1 then task.id else null end) as recom_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('1') and track.kind = 1 then task.id else null end) as high_recom_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('2') and track.kind = 1 then task.id else null end) as mid_recom_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('3') and track.kind = 1 then task.id else null end) as low_recom_track_cnt  ,
	count(distinct case when trackTaskLog.result IN ('4') and track.kind = 1 then task.id else null end) as none_recom_track_cnt ,
	count(distinct case when trackTaskLog.result IN ('6') and track.kind = 1 then task.id else null end) as invalid_recom_track_cnt
	from 
	( select  tasklog.id, tasklog.result,tasklog.rsc_intention_task_b_id
			   from rsc_intention_task_b_log tasklog
			  where tasklog.deleteflag = 0
			  and substr(regexp_replace(tasklog.tracktime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and $date$
			  and tasklog.result in ('1','2','3','4') 
	  union all  
	  select  noused.id,noused.result,noused.rsc_intention_task_b_id	  
	  from 
		 (select  tasklog.id, tasklog.result,tasklog.rsc_intention_task_b_id,substr(regexp_replace(tasklog.tracktime,'-',''),1,8) as trackday
			from rsc_intention_task_b_log tasklog
		 where tasklog.deleteflag = 0
			  and substr(regexp_replace(tasklog.tracktime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and $date$
			  and tasklog.result = '6'
		) noused
		left  join 
		(    select  tasklog.id, tasklog.result,tasklog.rsc_intention_task_b_id,substr(regexp_replace(tasklog.tracktime,'-',''),1,8) as trackday
			   from rsc_intention_task_b_log tasklog
			where tasklog.deleteflag = 0
				 and substr(regexp_replace(tasklog.tracktime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and $date$
				 and tasklog.result in ('1','2','3','4')
		) used 
		on noused.rsc_intention_task_b_id = used.rsc_intention_task_b_id
		where used.rsc_intention_task_b_id is null 
		group by  noused.id,noused.result,noused.rsc_intention_task_b_id
	) trackTaskLog
	join rsc_intention_task_b task
	on trackTaskLog.rsc_intention_task_b_id=task.id
	join rsc_intention track 
	on task.rsc_intention_id=track.id
	and track.deleteflag = 0
	group by task.creator_id,task.org_id
union all
 select 
	task.creator_id,task.org_id,
 	count(distinct track.customer_id) as cust_cnt ,
	0 as consume_cust_cnt,
	0 as pub_consume_cust_cnt ,
	0 as recom_consume_cust_cnt ,	
	count(distinct task.id) as track_cnt,
	0 as consume_track_cnt ,	
	0 as pub_track_cnt,
	0 as high_pub_track_cnt ,
	0 as mid_pub_track_cnt ,
	0 as low_pub_track_cnt ,
	0 as none_pub_track_cnt ,
	0 as invalid_pub_track_cnt ,	
	0 as recom_track_cnt ,
	0 as high_recom_track_cnt ,
	0 as mid_recom_track_cnt ,
	0 as low_recom_track_cnt  ,
	0 as none_recom_track_cnt ,
	0 as invalid_recom_track_cnt
	from 
	(  select task.creator_id,org_id,task.id,task.rsc_intention_id
		from rsc_intention_task_b task
		where task.deleteflag = 0
		 and substr(regexp_replace(task.createtime,'-',''),1,8)  between concat(substr('$date$',1,6),'01') and $date$
	)  task
	join rsc_intention track 
	on task.rsc_intention_id=track.id
	and track.deleteflag = 0
	group by task.creator_id,task.org_id
union all
  select  cbn.serviceuser_id as  creator_id,
			cbn.service_teamorg_id as org_id,
			0 as cust_cnt ,
			0 as consume_cust_cnt,
			0 as pub_consume_cust_cnt ,
			0 as recom_consume_cust_cnt ,
			0 as track_cnt,
			sum(rc.consume_intention * 2 + rc.consume_intention_cv) as consume_track_cnt,
			0 as pub_track_cnt,
			0 as high_pub_track_cnt ,
			0 as mid_pub_track_cnt ,
			0 as low_pub_track_cnt ,
			0 as none_pub_track_cnt ,
			0 as invalid_pub_track_cnt ,	
			0 as recom_track_cnt ,
			0 as high_recom_track_cnt ,
			0 as mid_recom_track_cnt ,
			0 as low_recom_track_cnt  ,
			0 as none_recom_track_cnt ,
			0 as invalid_recom_track_cnt
		from dw_b_d_resource_consume rc
		join dw_erp_d_customer_base_new cbn
		on rc.ecomp_root_id = cbn.ecomp_root_id
	   and cbn.ecomp_id = cbn.ecomp_root_id
		where rc.p_date between concat(substr($date$,1,6),'01') and $date$
		and cbn.serviceuser_id not in (0,-1)
		group by cbn.serviceuser_id ,cbn.service_teamorg_id
		having sum(rc.consume_intention * 2 + rc.consume_intention_cv)  > 0  
)  fact 
join 
(select id,name from dw_erp_d_salesuser_base where p_date= $date$) user
on fact.creator_id = user.id
left join 
(select id,name as org_name,branch_id,branch_name from dim_gcdc_org  where p_date= $date$) org
on fact.org_id = org.id
left join dim_date d on d.d_date = $date$
group by 
	fact.creator_id,
	user.name,
	fact.org_id,
	org.org_name,
	org.branch_id,
	org.branch_name,
	d.d_year,
	d.d_week;
