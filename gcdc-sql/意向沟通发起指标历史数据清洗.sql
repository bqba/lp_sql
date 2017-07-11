create table fact_h_gcdc_intention_w_temp 
(d_date int ,
 id int , 
 intention_type int,
 intention_b_pub_cnt int,
 intention_b_recom_cnt int,
 mtd_intention_b_pub_cnt int,
 mtd_intention_b_recom_cnt int),
 org_type int comment '1-顾问，2-团队,3-地区'
 )
partitioned by (p_date int);


insert overwrite table fact_h_gcdc_intention_w_temp partition(p_date = $date$)
select 
d_date,
id,
intention_type,
intention_b_pub_cnt,
intention_b_recom_cnt,
0 as mtd_intention_b_pub_cnt,
0 as mtd_intention_b_recom_cnt,
org_type
from (
	select 
		  $date$ as d_date,
		  task.creator_id as id ,
		  task.intn_type as intention_type,
		  count(distinct case when task.intention_type <> 0 and track.kind = 0 then task.id else null end) as intention_b_pub_cnt,
		  count(distinct case when task.intention_type <> 0 and track.kind = 1 then task.id else null end) as intention_b_recom_cnt,
		  1 as org_type
		  from 
		  (  
		  	select 
		  		taskb.creator_id,taskb.org_id,taskb.id,taskb.rsc_intention_id,taskb.createtime,taskb.intention_type,
		  		all_type.intn_type
		  	from (
			  	select task.creator_id,task.org_id,task.id,task.rsc_intention_id,intention_type,createtime
			    from rsc_intention_task_b task
			    where task.deleteflag = 0
			     and substr(regexp_replace(task.createtime,'-',''),1,8) between {{delta(date,-6)}}} and $date$ 
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
	union all 	  
		select 
		  $date$ as d_date,
		  task.org_id as id,
		  task.intn_type as intention_type,
		  count(distinct case when task.intention_type <> 0 and track.kind = 0 then task.id else null end) as intention_b_pub_cnt,
		  count(distinct case when task.intention_type <> 0 and track.kind = 1 then task.id else null end) as intention_b_recom_cnt,
		  2 as org_type
		  from 
		  (  
		  	select 
		  		taskb.creator_id,taskb.org_id,taskb.id,taskb.rsc_intention_id,taskb.createtime,taskb.intention_type,
		  		all_type.intn_type
		  	from (
			  	select task.creator_id,task.org_id,task.id,task.rsc_intention_id,intention_type,createtime
			    from rsc_intention_task_b task
			    where task.deleteflag = 0
			     and substr(regexp_replace(task.createtime,'-',''),1,8) between {{delta(date,-6)}}} and $date$ 
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
	union all 	  
	      select 
		  $date$ as d_date,
		  dim_org.branch_id as id,
		  task.intn_type as intention_type,
		  count(distinct case when task.intention_type <> 0 and track.kind = 0 then task.id else null end) as intention_b_pub_cnt,
		  count(distinct case when task.intention_type <> 0 and track.kind = 1 then task.id else null end) as intention_b_recom_cnt,
		  3 as org_type
		  from 
		  (  
		  	select 
		  		taskb.creator_id,taskb.org_id,taskb.id,taskb.rsc_intention_id,taskb.createtime,taskb.intention_type,
		  		all_type.intn_type
		  	from (
			  	select task.creator_id,task.org_id,task.id,task.rsc_intention_id,intention_type,createtime
			    from rsc_intention_task_b task
			    where task.deleteflag = 0
			     and substr(regexp_replace(task.createtime,'-',''),1,8) between {{delta(date,-6)}}} and $date$ 
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
		  group by dim_org.branch_id,task.intn_type
) temp 



create table fact_h_gcdc_intention_temp 
(d_date int ,
 id int , 
 intention_type int,
 intention_b_pub_cnt int,
 intention_b_recom_cnt int,
 mtd_intention_b_pub_cnt int,
 mtd_intention_b_recom_cnt int)
partitioned by (p_date int);
alter table fact_h_gcdc_intention_temp add columns (org_type int comment '1-顾问，2-团队,3-地区') cascade;

insert overwrite table fact_h_gcdc_intention_temp partition(p_date = $date$)
select 
d_date,
id,
intention_type,
intention_b_pub_cnt,
intention_b_recom_cnt,
mtd_intention_b_pub_cnt,
mtd_intention_b_recom_cnt,
org_type
from (
	select 
		  $date$ as d_date,
		  task.creator_id as id ,
		  task.intn_type as intention_type,
		  count(distinct case when substr(regexp_replace(task.createtime,'-',''),1,8) = $date$ and task.intention_type <> 0 and track.kind = 0 then task.id else null end) as intention_b_pub_cnt,
		  count(distinct case when substr(regexp_replace(task.createtime,'-',''),1,8) = $date$ and task.intention_type <> 0 and track.kind = 1 then task.id else null end) as intention_b_recom_cnt,
		  count(distinct case when task.intention_type <> 0 and track.kind = 0 then task.id else null end) as mtd_intention_b_pub_cnt,
		  count(distinct case when task.intention_type <> 0 and track.kind = 1 then task.id else null end) as mtd_intention_b_recom_cnt,
		  1 as org_type
		  from 
		  (  
		  	select 
		  		taskb.creator_id,taskb.org_id,taskb.id,taskb.rsc_intention_id,taskb.createtime,taskb.intention_type,
		  		all_type.intn_type
		  	from (
			  	select task.creator_id,task.org_id,task.id,task.rsc_intention_id,intention_type,createtime
			    from rsc_intention_task_b task
			    where task.deleteflag = 0
			     and substr(regexp_replace(task.createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$ 
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
	union all 	  
		select 
		  $date$ as d_date,
		  task.org_id as id,
		  task.intn_type as intention_type,
		  count(distinct case when substr(regexp_replace(task.createtime,'-',''),1,8) = $date$ and task.intention_type <> 0 and track.kind = 0 then task.id else null end) as intention_b_pub_cnt,
		  count(distinct case when substr(regexp_replace(task.createtime,'-',''),1,8) = $date$ and task.intention_type <> 0 and track.kind = 1 then task.id else null end) as intention_b_recom_cnt,
		  count(distinct case when task.intention_type <> 0 and track.kind = 0 then task.id else null end) as mtd_intention_b_pub_cnt,
		  count(distinct case when task.intention_type <> 0 and track.kind = 1 then task.id else null end) as mtd_intention_b_recom_cnt,
		  2 as org_type
		  from 
		  (  
		  	select 
		  		taskb.creator_id,taskb.org_id,taskb.id,taskb.rsc_intention_id,taskb.createtime,taskb.intention_type,
		  		all_type.intn_type
		  	from (
			  	select task.creator_id,task.org_id,task.id,task.rsc_intention_id,intention_type,createtime
			    from rsc_intention_task_b task
			    where task.deleteflag = 0
			     and substr(regexp_replace(task.createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$ 
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
	union all 	  
	      select 
		  $date$ as d_date,
		  dim_org.branch_id as id,
		  task.intn_type as intention_type,
		  count(distinct case when substr(regexp_replace(task.createtime,'-',''),1,8) = $date$ and task.intention_type <> 0 and track.kind = 0 then task.id else null end) as intention_b_pub_cnt,
		  count(distinct case when substr(regexp_replace(task.createtime,'-',''),1,8) = $date$ and task.intention_type <> 0 and track.kind = 1 then task.id else null end) as intention_b_recom_cnt,
		  count(distinct case when task.intention_type <> 0 and track.kind = 0 then task.id else null end) as mtd_intention_b_pub_cnt,
		  count(distinct case when task.intention_type <> 0 and track.kind = 1 then task.id else null end) as mtd_intention_b_recom_cnt,
		  3 as org_type
		  from 
		  (  
		  	select 
		  		taskb.creator_id,taskb.org_id,taskb.id,taskb.rsc_intention_id,taskb.createtime,taskb.intention_type,
		  		all_type.intn_type
		  	from (
			  	select task.creator_id,task.org_id,task.id,task.rsc_intention_id,intention_type,createtime
			    from rsc_intention_task_b task
			    where task.deleteflag = 0
			     and substr(regexp_replace(task.createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$ 
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
		  group by dim_org.branch_id,task.intn_type
) temp 





insert overwrite table fact_h_gcdc_d_intention_rpsorg partition (p_date)
select org.d_date,org.org_id,org.org_name,org.branch_id,org.branch_name,org.intention_b_type,org.intention_b_cust_cnt,org.intention_b_consume_cust_cnt,org.intention_b_pub_consume_cust_cnt,org.intention_b_recom_consume_cust_cnt,org.intention_b_cnt,org.intention_b_release_cnt,org.intention_b_adoption_cnt,org.intention_b_reject_cnt,org.intention_b_consume_track_cnt,org.intention_b_pub_track_cnt,org.intention_b_high_pub_track_cnt,org.intention_b_mid_pub_track_cnt,org.intention_b_low_pub_track_cnt,org.intention_b_none_pub_track_cnt,org.intention_b_invalid_pub_track_cnt,org.intention_b_recom_track_cnt,org.intention_b_high_recom_track_cnt,org.intention_b_mid_recom_track_cnt,org.intention_b_low_recom_track_cnt,org.intention_b_none_recom_track_cnt,org.intention_b_invalid_recom_track_cnt,org.contact_cnt,org.contact_consume_track_cnt,org.contact_allow_pub_track_cnt,org.contact_disallow_pub_track_cnt,org.contact_invalid_pub_track_cnt,org.contact_allow_recom_track_cnt,org.contact_disallow_recom_track_cnt,org.contact_invalid_recom_track_cnt,org.intention_contact_consume_track_cnt,org.mtd_intention_b_cust_cnt,org.mtd_intention_b_consume_cust_cnt,org.mtd_intention_b_pub_consume_cust_cnt,org.mtd_intention_b_recom_consume_cust_cnt,org.mtd_intention_b_cnt,org.mtd_intention_b_release_cnt,org.mtd_intention_b_adoption_cnt,org.mtd_intention_b_reject_cnt,org.mtd_intention_b_consume_track_cnt,org.mtd_intention_b_pub_track_cnt,org.mtd_intention_b_high_pub_track_cnt,org.mtd_intention_b_mid_pub_track_cnt,org.mtd_intention_b_low_pub_track_cnt,org.mtd_intention_b_none_pub_track_cnt,org.mtd_intention_b_invalid_pub_track_cnt,org.mtd_intention_b_recom_track_cnt,org.mtd_intention_b_high_recom_track_cnt,org.mtd_intention_b_mid_recom_track_cnt,org.mtd_intention_b_low_recom_track_cnt,org.mtd_intention_b_none_recom_track_cnt,org.mtd_intention_b_invalid_recom_track_cnt,org.mtd_contact_cnt,org.mtd_contact_consume_track_cnt,org.mtd_contact_allow_pub_track_cnt,org.mtd_contact_disallow_pub_track_cnt,org.mtd_contact_invalid_pub_track_cnt,org.mtd_contact_allow_recom_track_cnt,org.mtd_contact_disallow_recom_track_cnt,org.mtd_contact_invalid_recom_track_cnt,org.mtd_intention_contact_consume_track_cnt,org.creation_timestamp, 
nvl(temp.intention_b_pub_cnt,0) as intention_b_pub_cnt, 
nvl(temp.intention_b_recom_cnt,0) as intention_b_recom_cnt, 
nvl(temp.mtd_intention_b_pub_cnt,0) as mtd_intention_b_pub_cnt, 
nvl(temp.mtd_intention_b_recom_cnt,0) as mtd_intention_b_recom_cnt, 
org.p_date
from (select d_date, org_id, org_name, branch_id, branch_name, intention_b_type, intention_b_cust_cnt, intention_b_consume_cust_cnt, intention_b_pub_consume_cust_cnt, intention_b_recom_consume_cust_cnt, intention_b_cnt, intention_b_release_cnt, intention_b_adoption_cnt, intention_b_reject_cnt, intention_b_consume_track_cnt, intention_b_pub_track_cnt, intention_b_high_pub_track_cnt, intention_b_mid_pub_track_cnt, intention_b_low_pub_track_cnt, intention_b_none_pub_track_cnt, intention_b_invalid_pub_track_cnt, intention_b_recom_track_cnt, intention_b_high_recom_track_cnt, intention_b_mid_recom_track_cnt, intention_b_low_recom_track_cnt, intention_b_none_recom_track_cnt, intention_b_invalid_recom_track_cnt, contact_cnt, contact_consume_track_cnt, contact_allow_pub_track_cnt, contact_disallow_pub_track_cnt, contact_invalid_pub_track_cnt, contact_allow_recom_track_cnt, contact_disallow_recom_track_cnt, contact_invalid_recom_track_cnt, intention_contact_consume_track_cnt, mtd_intention_b_cust_cnt, mtd_intention_b_consume_cust_cnt, mtd_intention_b_pub_consume_cust_cnt, mtd_intention_b_recom_consume_cust_cnt, mtd_intention_b_cnt, mtd_intention_b_release_cnt, mtd_intention_b_adoption_cnt, mtd_intention_b_reject_cnt, mtd_intention_b_consume_track_cnt, mtd_intention_b_pub_track_cnt, mtd_intention_b_high_pub_track_cnt, mtd_intention_b_mid_pub_track_cnt, mtd_intention_b_low_pub_track_cnt, mtd_intention_b_none_pub_track_cnt, mtd_intention_b_invalid_pub_track_cnt, mtd_intention_b_recom_track_cnt, mtd_intention_b_high_recom_track_cnt, mtd_intention_b_mid_recom_track_cnt, mtd_intention_b_low_recom_track_cnt, mtd_intention_b_none_recom_track_cnt, mtd_intention_b_invalid_recom_track_cnt, mtd_contact_cnt, mtd_contact_consume_track_cnt, mtd_contact_allow_pub_track_cnt, mtd_contact_disallow_pub_track_cnt, mtd_contact_invalid_pub_track_cnt, mtd_contact_allow_recom_track_cnt, mtd_contact_disallow_recom_track_cnt, mtd_contact_invalid_recom_track_cnt, mtd_intention_contact_consume_track_cnt, creation_timestamp, intention_b_pub_cnt, intention_b_recom_cnt, mtd_intention_b_pub_cnt, mtd_intention_b_recom_cnt, p_date
from fact_h_gcdc_d_intention_rpsorg
where p_date between 20170101 and 20170118
) org 
left join fact_h_gcdc_intention_temp temp
on org.p_date = temp.p_date
and org.org_id = temp.id 
and org.intention_b_type = temp.intention_type
and temp.org_type = 2;


select *
from fact_h_gcdc_intention_temp
where org_type = 2 
and p_date between 20170101 and 20170112 

insert overwrite table fact_h_gcdc_d_intention_rpsuser partition (p_date)
select org.d_date,org.rps_user_id,org.rps_user_name,org.org_id,org.org_name,org.branch_id,org.branch_name,org.position_id,org.position_name,org.intention_b_type,org.intention_b_cust_cnt,org.intention_b_consume_cust_cnt,org.intention_b_pub_consume_cust_cnt,org.intention_b_recom_consume_cust_cnt,org.intention_b_cnt,org.intention_b_release_cnt,org.intention_b_adoption_cnt,org.intention_b_reject_cnt,org.intention_b_consume_track_cnt,org.intention_b_pub_track_cnt,org.intention_b_high_pub_track_cnt,org.intention_b_mid_pub_track_cnt,org.intention_b_low_pub_track_cnt,org.intention_b_none_pub_track_cnt,org.intention_b_invalid_pub_track_cnt,org.intention_b_recom_track_cnt,org.intention_b_high_recom_track_cnt,org.intention_b_mid_recom_track_cnt,org.intention_b_low_recom_track_cnt,org.intention_b_none_recom_track_cnt,org.intention_b_invalid_recom_track_cnt,org.contact_cnt,org.contact_consume_track_cnt,org.contact_allow_pub_track_cnt,org.contact_disallow_pub_track_cnt,org.contact_invalid_pub_track_cnt,org.contact_allow_recom_track_cnt,org.contact_disallow_recom_track_cnt,org.contact_invalid_recom_track_cnt,org.intention_contact_consume_track_cnt,org.mtd_intention_b_cust_cnt,org.mtd_intention_b_consume_cust_cnt,org.mtd_intention_b_pub_consume_cust_cnt,org.mtd_intention_b_recom_consume_cust_cnt,org.mtd_intention_b_cnt,org.mtd_intention_b_release_cnt,org.mtd_intention_b_adoption_cnt,org.mtd_intention_b_reject_cnt,org.mtd_intention_b_consume_track_cnt,org.mtd_intention_b_pub_track_cnt,org.mtd_intention_b_high_pub_track_cnt,org.mtd_intention_b_mid_pub_track_cnt,org.mtd_intention_b_low_pub_track_cnt,org.mtd_intention_b_none_pub_track_cnt,org.mtd_intention_b_invalid_pub_track_cnt,org.mtd_intention_b_recom_track_cnt,org.mtd_intention_b_high_recom_track_cnt,org.mtd_intention_b_mid_recom_track_cnt,org.mtd_intention_b_low_recom_track_cnt,org.mtd_intention_b_none_recom_track_cnt,org.mtd_intention_b_invalid_recom_track_cnt,org.mtd_contact_cnt,org.mtd_contact_consume_track_cnt,org.mtd_contact_allow_pub_track_cnt,org.mtd_contact_disallow_pub_track_cnt,org.mtd_contact_invalid_pub_track_cnt,org.mtd_contact_allow_recom_track_cnt,org.mtd_contact_disallow_recom_track_cnt,org.mtd_contact_invalid_recom_track_cnt,org.mtd_intention_contact_consume_track_cnt,org.creation_timestamp, 
nvl(temp.intention_b_pub_cnt,0), 
nvl(temp.intention_b_recom_cnt,0), 
nvl(temp.mtd_intention_b_pub_cnt,0), 
nvl(temp.mtd_intention_b_recom_cnt,0), 
org.p_date
from fact_h_gcdc_d_intention_rpsuser org 
left join fact_h_gcdc_intention_temp temp
on org.p_date = temp.p_date
and org.rps_user_id = temp.id 
and org.intention_b_type = temp.intention_type
and temp.org_type = 1
where org.p_date between 20170101 and 20170118;

insert overwrite table fact_h_gcdc_d_intention_rpsbranch partition (p_date)
select org.d_date,org.branch_id,org.branch_name,org.intention_b_type,org.intention_b_cust_cnt,org.intention_b_consume_cust_cnt,org.intention_b_pub_consume_cust_cnt,org.intention_b_recom_consume_cust_cnt,org.intention_b_cnt,org.intention_b_release_cnt,org.intention_b_adoption_cnt,org.intention_b_reject_cnt,org.intention_b_consume_track_cnt,org.intention_b_pub_track_cnt,org.intention_b_high_pub_track_cnt,org.intention_b_mid_pub_track_cnt,org.intention_b_low_pub_track_cnt,org.intention_b_none_pub_track_cnt,org.intention_b_invalid_pub_track_cnt,org.intention_b_recom_track_cnt,org.intention_b_high_recom_track_cnt,org.intention_b_mid_recom_track_cnt,org.intention_b_low_recom_track_cnt,org.intention_b_none_recom_track_cnt,org.intention_b_invalid_recom_track_cnt,org.contact_cnt,org.contact_consume_track_cnt,org.contact_allow_pub_track_cnt,org.contact_disallow_pub_track_cnt,org.contact_invalid_pub_track_cnt,org.contact_allow_recom_track_cnt,org.contact_disallow_recom_track_cnt,org.contact_invalid_recom_track_cnt,org.intention_contact_consume_track_cnt,org.mtd_intention_b_cust_cnt,org.mtd_intention_b_consume_cust_cnt,org.mtd_intention_b_pub_consume_cust_cnt,org.mtd_intention_b_recom_consume_cust_cnt,org.mtd_intention_b_cnt,org.mtd_intention_b_release_cnt,org.mtd_intention_b_adoption_cnt,org.mtd_intention_b_reject_cnt,org.mtd_intention_b_consume_track_cnt,org.mtd_intention_b_pub_track_cnt,org.mtd_intention_b_high_pub_track_cnt,org.mtd_intention_b_mid_pub_track_cnt,org.mtd_intention_b_low_pub_track_cnt,org.mtd_intention_b_none_pub_track_cnt,org.mtd_intention_b_invalid_pub_track_cnt,org.mtd_intention_b_recom_track_cnt,org.mtd_intention_b_high_recom_track_cnt,org.mtd_intention_b_mid_recom_track_cnt,org.mtd_intention_b_low_recom_track_cnt,org.mtd_intention_b_none_recom_track_cnt,org.mtd_intention_b_invalid_recom_track_cnt,org.mtd_contact_cnt,org.mtd_contact_consume_track_cnt,org.mtd_contact_allow_pub_track_cnt,org.mtd_contact_disallow_pub_track_cnt,org.mtd_contact_invalid_pub_track_cnt,org.mtd_contact_allow_recom_track_cnt,org.mtd_contact_disallow_recom_track_cnt,org.mtd_contact_invalid_recom_track_cnt,org.mtd_intention_contact_consume_track_cnt,org.creation_timestamp, 
nvl(temp.intention_b_pub_cnt,0), 
nvl(temp.intention_b_recom_cnt,0), 
nvl(temp.mtd_intention_b_pub_cnt,0), 
nvl(temp.mtd_intention_b_recom_cnt,0), 
org.p_date
from fact_h_gcdc_d_intention_rpsbranch org 
left join fact_h_gcdc_intention_temp temp
on org.p_date = temp.p_date
and org.branch_id = temp.id 
and org.intention_b_type = temp.intention_type
and temp.org_type = 3
where org.p_date between 20170101 and 20170118;




insert overwrite table fact_h_gcdc_w_intention_rpsbranch partition (p_date)
select  org.d_date, branch_id, branch_name, intention_b_type, intention_b_cust_cnt, intention_b_consume_cust_cnt, intention_b_pub_consume_cust_cnt, intention_b_recom_consume_cust_cnt, intention_b_cnt, intention_b_release_cnt, intention_b_adoption_cnt, intention_b_reject_cnt, intention_b_consume_track_cnt, intention_b_pub_track_cnt, intention_b_high_pub_track_cnt, intention_b_mid_pub_track_cnt, intention_b_low_pub_track_cnt, intention_b_none_pub_track_cnt, intention_b_invalid_pub_track_cnt, intention_b_recom_track_cnt, intention_b_high_recom_track_cnt, intention_b_mid_recom_track_cnt, intention_b_low_recom_track_cnt, intention_b_none_recom_track_cnt, intention_b_invalid_recom_track_cnt, contact_cnt, contact_consume_track_cnt, contact_allow_pub_track_cnt, contact_disallow_pub_track_cnt, contact_invalid_pub_track_cnt, contact_allow_recom_track_cnt, contact_disallow_recom_track_cnt, contact_invalid_recom_track_cnt, intention_contact_consume_track_cnt, creation_timestamp, 
nvl(temp.intention_b_pub_cnt,0), 
nvl(temp.intention_b_recom_cnt,0), 
org.p_date
from fact_h_gcdc_w_intention_rpsbranch org 
left join fact_h_gcdc_intention_w_temp temp
on org.p_date = temp.p_date
and org.branch_id = temp.id 
and org.intention_b_type = temp.intention_type
and temp.org_type = 3
where org.p_date between 20170101 and 20170115;



insert overwrite table fact_h_gcdc_w_intention_rpsuser partition (p_date)
select org.d_date, rps_user_id, rps_user_name, org_id, org_name, branch_id, branch_name, position_id, position_name, intention_b_type, intention_b_cust_cnt, intention_b_consume_cust_cnt, intention_b_pub_consume_cust_cnt, intention_b_recom_consume_cust_cnt, intention_b_cnt, intention_b_release_cnt, intention_b_adoption_cnt, intention_b_reject_cnt, intention_b_consume_track_cnt, intention_b_pub_track_cnt, intention_b_high_pub_track_cnt, intention_b_mid_pub_track_cnt, intention_b_low_pub_track_cnt, intention_b_none_pub_track_cnt, intention_b_invalid_pub_track_cnt, intention_b_recom_track_cnt, intention_b_high_recom_track_cnt, intention_b_mid_recom_track_cnt, intention_b_low_recom_track_cnt, intention_b_none_recom_track_cnt, intention_b_invalid_recom_track_cnt, contact_cnt, contact_consume_track_cnt, contact_allow_pub_track_cnt, contact_disallow_pub_track_cnt, contact_invalid_pub_track_cnt, contact_allow_recom_track_cnt, contact_disallow_recom_track_cnt, contact_invalid_recom_track_cnt, intention_contact_consume_track_cnt, creation_timestamp, 
nvl(temp.intention_b_pub_cnt,0), 
nvl(temp.intention_b_recom_cnt,0), 
org.p_date
from fact_h_gcdc_w_intention_rpsuser org 
left join fact_h_gcdc_intention_w_temp temp
on org.p_date = temp.p_date
and org.rps_user_id = temp.id 
and org.intention_b_type = temp.intention_type
and temp.org_type = 1
where org.p_date between 20170101 and 20170115;

insert overwrite table fact_h_gcdc_w_intention_rpsorg partition (p_date)
select org.d_date, org_id, org_name, branch_id, branch_name, intention_b_type, intention_b_cust_cnt, intention_b_consume_cust_cnt, intention_b_pub_consume_cust_cnt, intention_b_recom_consume_cust_cnt, intention_b_cnt, intention_b_release_cnt, intention_b_adoption_cnt, intention_b_reject_cnt, intention_b_consume_track_cnt, intention_b_pub_track_cnt, intention_b_high_pub_track_cnt, intention_b_mid_pub_track_cnt, intention_b_low_pub_track_cnt, intention_b_none_pub_track_cnt, intention_b_invalid_pub_track_cnt, intention_b_recom_track_cnt, intention_b_high_recom_track_cnt, intention_b_mid_recom_track_cnt, intention_b_low_recom_track_cnt, intention_b_none_recom_track_cnt, intention_b_invalid_recom_track_cnt, contact_cnt, contact_consume_track_cnt, contact_allow_pub_track_cnt, contact_disallow_pub_track_cnt, contact_invalid_pub_track_cnt, contact_allow_recom_track_cnt, contact_disallow_recom_track_cnt, contact_invalid_recom_track_cnt, intention_contact_consume_track_cnt, creation_timestamp, 
nvl(temp.intention_b_pub_cnt,0), 
nvl(temp.intention_b_recom_cnt,0), 
org.p_date
from fact_h_gcdc_w_intention_rpsorg org 
left join fact_h_gcdc_intention_w_temp temp
on org.p_date = temp.p_date
and org.org_id = temp.id 
and org.intention_b_type = temp.intention_type
and temp.org_type = 2
where org.p_date between 20170101 and 20170115;