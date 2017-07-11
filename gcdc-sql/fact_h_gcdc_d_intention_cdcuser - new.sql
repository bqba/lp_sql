select 
cdc_user_id,
cdc_user_name,
org_id,
org_name,
branch_id,
branch_name,
sum(standard_intention_c_submit_cnt) as standard_intention_c_submit_cnt ,
sum(intention_c_submit_cnt) as intention_c_submit_cnt 
from fact_h_gcdc_d_intention_cdcuser
where p_date between 20170101 and 20170131
group by 
cdc_user_id,
cdc_user_name,
org_id,
org_name,
branch_id,
branch_name

create table if not exists fact_h_gcdc_d_intention_cdcuser_new
(
  d_date int comment '统计日期',
  cdc_user_id int comment '职业顾问ID',
  cdc_user_name string comment '职业顾问姓名',
  org_id int comment '职业顾问小组ID',
  org_name string comment '职业顾问小组名称',
  branch_id int comment '地区ID',
  branch_name string comment '地区名称',
  intention_c_type string comment '意向沟通类型:0-索要联系方式发起,1-意向沟通发起,2-意向沟通+索要联系方式',
  industry string comment '发起意向沟通的企业行业编码',
  industry_name string comment '发起意向沟通的企业行业名称',
  deliver_type string comment '交付类型 1:一天交付,2:两天交付,3:三天交付',
  intention_c_release_cnt int comment '意向沟通释放数',
  intention_c_complete_cnt int comment '意向沟通完成数',
  intention_c_adoption_cnt int comment '意向沟通采纳数',
  intention_c_reject_cnt int comment '意向沟通驳回数',
  intention_c_high_track_cnt int comment '意向度-高',
  intention_c_mid_track_cnt int comment '意向度-中',
  intention_c_low_track_cnt int comment '意向度-低',
  intention_c_none_track_cnt int comment '意向度-无',
  intention_c_unknow_track_cnt int comment '未知', 
  intention_c_allow_track_cnt int comment '开放', 
  intention_c_disallow_track_cnt int comment '不开放', 
  intention_c_invalid_track_cnt int comment '未成功沟通数',
  intention_c_withdraw_cnt int comment '意向沟通收回数',
  standard_intention_c_submit_cnt int comment '达标意向沟通提交数',
  intention_c_submit_cnt int comment '意向沟通提交数',
  mtd_intention_c_release_cnt int comment '月累计意向沟通释放数',
  mtd_intention_c_complete_cnt int comment '月累计意向沟通完成数',
  mtd_intention_c_adoption_cnt int comment '月累计意向沟通采纳数',
  mtd_intention_c_reject_cnt int comment '月累计意向沟通驳回数',
  mtd_intention_c_high_track_cnt int comment '月累计意向度-高',
  mtd_intention_c_mid_track_cnt int comment '月累计意向度-中',
  mtd_intention_c_low_track_cnt int comment '月累计意向度-低',
  mtd_intention_c_none_track_cnt int comment '月累计意向度-无',
  mtd_intention_c_unknow_track_cnt int comment '月累计未知', 
  mtd_intention_c_allow_track_cnt int comment '月累计开放', 
  mtd_intention_c_disallow_track_cnt int comment '月累计不开放', 
  mtd_intention_c_invalid_track_cnt int comment '月累计未成功沟通数',
  mtd_intention_c_withdraw_cnt int comment '月累计意向沟通收回数',
  mtd_standard_intention_c_submit_cnt int comment '月累计达标意向沟通提交数',
  mtd_intention_c_submit_cnt int comment '月累计意向沟通提交数',  
  creation_timestamp  timestamp 
) comment '职业顾问意向沟通统计日表'
partitioned by (p_date int);

create table if not exists fact_h_gcdc_d_intention_cdcuser_new
(
  d_date int comment '统计日期',
  cdc_user_id int comment '职业顾问ID',
  cdc_user_name varchar(50) comment '职业顾问姓名',
  org_id int comment '职业顾问小组ID',
  org_name varchar(100) comment '职业顾问小组名称',
  branch_id int comment '地区ID',
  branch_name varchar(50) comment '地区名称',
  intention_c_type varchar(50) comment '意向沟通类型:0-索要联系方式发起,1-意向沟通发起,2-意向沟通+索要联系方式',
  industry varchar(50) comment '发起意向沟通的企业行业编码',
  industry_name varchar(50) comment '发起意向沟通的企业行业名称',
  deliver_type varchar(2) comment '交付类型 1:一天交付,2:两天交付,3:三天交付',
  intention_c_release_cnt int comment '意向沟通释放数',
  intention_c_complete_cnt int comment '意向沟通完成数',
  intention_c_adoption_cnt int comment '意向沟通采纳数',
  intention_c_reject_cnt int comment '意向沟通驳回数',
  intention_c_high_track_cnt int comment '意向度-高',
  intention_c_mid_track_cnt int comment '意向度-中',
  intention_c_low_track_cnt int comment '意向度-低',
  intention_c_none_track_cnt int comment '意向度-无',
  intention_c_unknow_track_cnt int comment '未知', 
  intention_c_allow_track_cnt int comment '开放', 
  intention_c_disallow_track_cnt int comment '不开放', 
  intention_c_invalid_track_cnt int comment '未成功沟通数',
  intention_c_withdraw_cnt int comment '意向沟通收回数',
  standard_intention_c_submit_cnt int comment '达标意向沟通提交数',
  intention_c_submit_cnt int comment '意向沟通提交数', 
  mtd_intention_c_release_cnt int comment '月累计意向沟通释放数',
  mtd_intention_c_complete_cnt int comment '月累计意向沟通完成数',
  mtd_intention_c_adoption_cnt int comment '月累计意向沟通采纳数',
  mtd_intention_c_reject_cnt int comment '月累计意向沟通驳回数',
  mtd_intention_c_high_track_cnt int comment '月累计意向度-高',
  mtd_intention_c_mid_track_cnt int comment '月累计意向度-中',
  mtd_intention_c_low_track_cnt int comment '月累计意向度-低',
  mtd_intention_c_none_track_cnt int comment '月累计意向度-无',
  mtd_intention_c_unknow_track_cnt int comment '月累计未知', 
  mtd_intention_c_allow_track_cnt int comment '月累计开放', 
  mtd_intention_c_disallow_track_cnt int comment '月累计不开放', 
  mtd_intention_c_invalid_track_cnt int comment '月累计未成功沟通数',
  mtd_intention_c_withdraw_cnt int comment '月累计意向沟通收回数',
  mtd_standard_intention_c_submit_cnt int comment '月累计达标意向沟通提交数',
  mtd_intention_c_submit_cnt int comment '月累计意向沟通提交数',    
  creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
  primary key (d_date,cdc_user_id,intention_c_type,industry,deliver_type)
) comment '职业顾问意向沟通统计日表';

insert overwrite table fact_h_gcdc_d_intention_cdcuser_new partition(p_date = $date$)
select
    $date$ as d_date,
    nvl(intention.creator_id,'-1') as cdc_user_id,
    nvl(salesuser.name,'未知') as cdc_user_name,
    nvl(salesuser.org_id,'-1') as org_id,
    nvl(dim_org.name,'未知') as org_name,
    nvl(dim_org.branch_id,'-1') as branch_id,
    nvl(dim_org.branch_name,'未知') as branch_name,
    nvl(intention.intention_type,'-1') as intention_c_type,
    nvl(dim_industry_pre.d_main_industry_code,'999') as industry,
    nvl(dim_industry_pre.d_main_industry,'未知') as industry_name,
    nvl(intention.deliver_type,-1) as deliver_type,
    nvl(sum(intention.intention_c_release_cnt),0) as intention_c_release_cnt,
    nvl(sum(intention.intention_c_complete_cnt),0) as intention_c_complete_cnt,
    nvl(sum(intention.intention_c_adoption_cnt),0) as intention_c_adoption_cnt,
    nvl(sum(intention.intention_c_reject_cnt),0) as intention_c_reject_cnt,
    nvl(sum(intention.intention_c_high_track_cnt),0) as intention_c_high_track_cnt,
    nvl(sum(intention.intention_c_mid_track_cnt),0) as intention_c_mid_track_cnt,
    nvl(sum(intention.intention_c_low_track_cnt),0) as intention_c_low_track_cnt,
    nvl(sum(intention.intention_c_none_track_cnt),0) as intention_c_none_track_cnt,
    nvl(sum(intention.intention_c_unknow_track_cnt),0) as intention_c_unknow_track_cnt,
    nvl(sum(intention.intention_c_allow_track_cnt),0) as intention_c_allow_track_cnt,
    nvl(sum(intention.intention_c_disallow_track_cnt),0) as intention_c_disallow_track_cnt,
    nvl(sum(intention.intention_c_invalid_track_cnt),0) as intention_c_invalid_track_cnt,
    nvl(sum(intention.intention_c_withdraw_cnt),0) as intention_c_withdraw_cnt,
    nvl(sum(intention.standard_intention_c_submit_cnt),0) as standard_intention_c_submit_cnt, 
    nvl(sum(intention.intention_c_submit_cnt),0) as intention_c_submit_cnt,
    nvl(sum(intention.mtd_intention_c_release_cnt),0) as mtd_intention_c_release_cnt,
    nvl(sum(intention.mtd_intention_c_complete_cnt),0) as mtd_intention_c_complete_cnt,
    nvl(sum(intention.mtd_intention_c_adoption_cnt),0) as mtd_intention_c_adoption_cnt,
    nvl(sum(intention.mtd_intention_c_reject_cnt),0) as mtd_intention_c_reject_cnt,
    nvl(sum(intention.mtd_intention_c_high_track_cnt),0) as mtd_intention_c_high_track_cnt,
    nvl(sum(intention.mtd_intention_c_mid_track_cnt),0) as mtd_intention_c_mid_track_cnt,
    nvl(sum(intention.mtd_intention_c_low_track_cnt),0) as mtd_intention_c_low_track_cnt,
    nvl(sum(intention.mtd_intention_c_none_track_cnt),0) as mtd_intention_c_none_track_cnt,
    nvl(sum(intention.mtd_intention_c_unknow_track_cnt),0) as mtd_intention_c_unknow_track_cnt,
    nvl(sum(intention.mtd_intention_c_allow_track_cnt),0) as mtd_intention_c_allow_track_cnt,
    nvl(sum(intention.mtd_intention_c_disallow_track_cnt),0) as mtd_intention_c_disallow_track_cnt,
    nvl(sum(intention.mtd_intention_c_invalid_track_cnt),0) as mtd_intention_c_invalid_track_cnt,
    nvl(sum(intention.mtd_intention_c_withdraw_cnt),0) as mtd_intention_c_withdraw_cnt,
    nvl(sum(intention.mtd_standard_intention_c_submit_cnt),0) as mtd_standard_intention_c_submit_cnt, 
    nvl(sum(intention.mtd_intention_c_submit_cnt),0) as mtd_intention_c_submit_cnt,
    from_unixtime(unix_timestamp()) as creation_timestamp
from 
(  select 
      task.creator_id,task.intention_type,customer.industry,task.deliver_type,
      count(task.id) as intention_c_release_cnt,
      0 as intention_c_complete_cnt,
      0 as intention_c_adoption_cnt,
      0 as intention_c_reject_cnt,
      0 as intention_c_high_track_cnt,
      0 as intention_c_mid_track_cnt,
      0 as intention_c_low_track_cnt,
      0 as intention_c_none_track_cnt,
      0 as intention_c_unknow_track_cnt,
      0 as intention_c_allow_track_cnt,
      0 as intention_c_disallow_track_cnt,
      0 as intention_c_invalid_track_cnt,
      0 as intention_c_withdraw_cnt,
      0 as intention_c_submit_cnt,
      0 as standard_intention_c_submit_cnt,
      0 as mtd_intention_c_release_cnt,
      0 as mtd_intention_c_complete_cnt,
      0 as mtd_intention_c_adoption_cnt,
      0 as mtd_intention_c_reject_cnt,
      0 as mtd_intention_c_high_track_cnt,
      0 as mtd_intention_c_mid_track_cnt,
      0 as mtd_intention_c_low_track_cnt,
      0 as mtd_intention_c_none_track_cnt,
      0 as mtd_intention_c_unknow_track_cnt,
      0 as mtd_intention_c_allow_track_cnt,
      0 as mtd_intention_c_disallow_track_cnt,
      0 as mtd_intention_c_invalid_track_cnt,
      0 as mtd_intention_c_withdraw_cnt,
      0 as mtd_intention_c_submit_cnt,
      0 as mtd_standard_intention_c_submit_cnt    
  from rsc_intention_task_c task 
  join dw_erp_d_customer_base customer  
  on task.customer_id = customer.id
  and customer.p_date = $date$
  where task.deleteflag = 0
  and task.intention_type in (0,1,2)
  and substr(regexp_replace(task.createtime,'-',''),1,8) = $date$
  group by task.creator_id,task.intention_type,customer.industry,task.deliver_type
  union all 
  select 
      task.creator_id,task.intention_type,customer.industry,task.deliver_type,
      0 as intention_c_release_cnt,
      0 as intention_c_complete_cnt,
      count(case when log.status =4 then log.id else null end) as intention_c_adoption_cnt,
      count(case when log.status =2 then log.id else null end) as intention_c_reject_cnt,
      0 as intention_c_high_track_cnt,
      0 as intention_c_mid_track_cnt,
      0 as intention_c_low_track_cnt,
      0 as intention_c_none_track_cnt,
      0 as intention_c_unknow_track_cnt,
      0 as intention_c_allow_track_cnt,
      0 as intention_c_disallow_track_cnt,
      0 as intention_c_invalid_track_cnt,
      count(case when log.status =3 then log.id else null end) as intention_c_withdraw_cnt,
      0 as intention_c_submit_cnt,
      0 as standard_intention_c_submit_cnt,
      0 as mtd_intention_c_release_cnt,
      0 as mtd_intention_c_complete_cnt,
      0 as mtd_intention_c_adoption_cnt,
      0 as mtd_intention_c_reject_cnt,
      0 as mtd_intention_c_high_track_cnt,
      0 as mtd_intention_c_mid_track_cnt,
      0 as mtd_intention_c_low_track_cnt,
      0 as mtd_intention_c_none_track_cnt,
      0 as mtd_intention_c_unknow_track_cnt,
      0 as mtd_intention_c_allow_track_cnt,
      0 as mtd_intention_c_disallow_track_cnt,
      0 as mtd_intention_c_invalid_track_cnt,
      0 as mtd_intention_c_withdraw_cnt,
      0 as mtd_intention_c_submit_cnt,
      0 as mtd_standard_intention_c_submit_cnt     
  from rsc_intention_task_c_log log 
  join rsc_intention_task_c task 
  on log.rsc_intention_task_c_id = task.id
  join dw_erp_d_customer_base customer  
  on task.customer_id = customer.id
  and customer.p_date = $date$
  where log.deleteflag = 0
  and log.intention_type in (0,1,2)
  and log.status in (0,2,4,3)
  and substr(regexp_replace(log.createtime,'-',''),1,8) = $date$
  group by task.creator_id,task.intention_type,customer.industry,task.deliver_type
  union all 
  select log.creator_id,log.intention_type,customer.industry,task.deliver_type,
          0 as intention_c_release_cnt,
          count(case when log.intention_type in (1,2) and log.result in (1,2,3,4) then log.id else null end) as intention_c_complete_cnt,
          0 as intention_c_adoption_cnt,
          0 as intention_c_reject_cnt, 
          0 as intention_c_high_track_cnt,
          0 as intention_c_mid_track_cnt,
          0 as intention_c_low_track_cnt,
          0 as intention_c_none_track_cnt,
          0 as intention_c_unknow_track_cnt,
          0 as intention_c_allow_track_cnt,
          0 as intention_c_disallow_track_cnt,
          count(case when log.intention_type = 0 and log.demand_concat_result =4 then log.id 
           when log.intention_type = 0 and log.demand_concat_result <> 4 then null
           when log.intention_type in (1,2) and log.result = 6 then log.id 
           when log.intention_type in (1,2) and log.result <> 6 then null
           else null end) as intention_c_invalid_track_cnt,
          0 as intention_c_withdraw_cnt,
          count(case when log.intention_type in (1,2) and log.result in (1,2,3,4,6) then log.id else null end) as intention_c_submit_cnt,
          count(case when log.intention_type in (1,2) and log.result in (1,2,3,4,6) and work_hour_diff(task.createtime,log.createtime)/24 < deliver_type then log.id else null end) as standard_intention_c_submit_cnt,
          0 as mtd_intention_c_release_cnt,
          0 as mtd_intention_c_complete_cnt,         
          0 as mtd_intention_c_adoption_cnt,
          0 as mtd_intention_c_reject_cnt, 
          0 as mtd_intention_c_high_track_cnt,
          0 as mtd_intention_c_mid_track_cnt,
          0 as mtd_intention_c_low_track_cnt,
          0 as mtd_intention_c_none_track_cnt,
          0 as mtd_intention_c_unknow_track_cnt,
          0 as mtd_intention_c_allow_track_cnt,
          0 as mtd_intention_c_disallow_track_cnt,
          0 as mtd_intention_c_invalid_track_cnt,
          0 as mtd_intention_c_withdraw_cnt,
          0 as mtd_intention_c_submit_cnt,
          0 as mtd_standard_intention_c_submit_cnt
    from rsc_intention_task_c_log log 
    join rsc_intention_task_c task 
      on log.rsc_intention_task_c_id = task.id
    join dw_erp_d_customer_base customer  
      on task.customer_id = customer.id
      and customer.p_date = $date$
   where log.deleteflag = 0
     and log.intention_type in (0,1,2)
     and log.status = 1 
     and substr(regexp_replace(log.createtime,'-',''),1,8)= $date$
   group by log.creator_id,log.intention_type,customer.industry,task.deliver_type
   union all 
  select log.creator_id,log.intention_type,customer.industry,log.deliver_type,
          0 as intention_c_release_cnt,
          0 as intention_c_complete_cnt,
          0 as intention_c_adoption_cnt,
          0 as intention_c_reject_cnt,
          count(case when log.status in (1,4) and log.result =1 then log.id else null end) as intention_c_high_track_cnt,
          count(case when log.status in (1,4) and log.result =2 then log.id else null end) as intention_c_mid_track_cnt,
          count(case when log.status in (1,4) and log.result =3 then log.id else null end) as intention_c_low_track_cnt,
          count(case when log.status in (1,4) and log.result =4 then log.id else null end) as intention_c_none_track_cnt,
          count(case when log.status in (1,4) and log.result =5 then log.id else null end) as intention_c_unknow_track_cnt,
          count(case when log.demand_concat_result =1 then log.id else null end) as intention_c_allow_track_cnt,
          count(case when log.demand_concat_result =2 then log.id else null end) as intention_c_disallow_track_cnt,
          0 as intention_c_invalid_track_cnt,
          0 as intention_c_withdraw_cnt,
          0 as intention_c_submit_cnt,
          0 as standard_intention_c_submit_cnt,
          0 as mtd_intention_c_release_cnt,
          0 as mtd_intention_c_complete_cnt,         
          0 as mtd_intention_c_adoption_cnt,
          0 as mtd_intention_c_reject_cnt, 
          0 as mtd_intention_c_high_track_cnt,
          0 as mtd_intention_c_mid_track_cnt,
          0 as mtd_intention_c_low_track_cnt,
          0 as mtd_intention_c_none_track_cnt,
          0 as mtd_intention_c_unknow_track_cnt,
          0 as mtd_intention_c_allow_track_cnt,
          0 as mtd_intention_c_disallow_track_cnt,
          0 as mtd_intention_c_invalid_track_cnt,
          0 as mtd_intention_c_withdraw_cnt,
          0 as mtd_intention_c_submit_cnt,
          0 as mtd_standard_intention_c_submit_cnt
    from rsc_intention_task_c log 
    join dw_erp_d_customer_base customer  
      on log.customer_id = customer.id
     and customer.p_date = '$date$'
   where log.deleteflag = 0
     and log.intention_type in (0,1,2)
     and log.status = 4
     and substr(regexp_replace(log.modifytime,'-',''),1,8) = '$date$'
    group by log.creator_id,log.intention_type,customer.industry,log.deliver_type
) intention
join 
(select id,name,org_id,org_name from dw_erp_d_salesuser_base where p_date =$date$) salesuser
on intention.creator_id = salesuser.id
left join dim_gcdc_org dim_org
on salesuser.org_id = dim_org.id
and dim_org.p_date = $date$
left join dim_industry_pre
on intention.industry = dim_industry.d_ind_code
group by  
  intention.creator_id,
  salesuser.name,
  salesuser.org_id,
  dim_org.name,
  dim_org.branch_id,
  dim_org.branch_name,
  intention.intention_type,
  dim_industry_pre.d_main_industry_code,
  dim_industry_pre.d_main_industry,
  intention.deliver_type;

create table if not exists fact_h_gcdc_d_intention_cdcorg_new
(
  d_date int comment '统计日期',
  org_id int comment '职业顾问小组ID',
  org_name string comment '职业顾问小组名称',
  branch_id int comment '地区ID',
  branch_name string comment '地区名称',
  intention_c_type string comment '意向沟通类型:0-索要联系方式发起,1-意向沟通发起,2-意向沟通+索要联系方式',
  industry string comment '发起意向沟通的企业行业编码',
  industry_name string comment '发起意向沟通的企业行业名称',
  deliver_type string comment '交付类型 1:一天交付,2:两天交付,3:三天交付',
  intention_c_release_cnt int comment '意向沟通释放数',
  intention_c_complete_cnt int comment '意向沟通完成数',
  intention_c_adoption_cnt int comment '意向沟通采纳数',
  intention_c_reject_cnt int comment '意向沟通驳回数',
  intention_c_high_track_cnt int comment '意向度-高',
  intention_c_mid_track_cnt int comment '意向度-中',
  intention_c_low_track_cnt int comment '意向度-低',
  intention_c_none_track_cnt int comment '意向度-无',
  intention_c_unknow_track_cnt int comment '未知', 
  intention_c_allow_track_cnt int comment '开放', 
  intention_c_disallow_track_cnt int comment '不开放', 
  intention_c_invalid_track_cnt int comment '未成功沟通数',
  intention_c_withdraw_cnt int comment '意向沟通收回数',
  standard_intention_c_submit_cnt int comment '达标意向沟通提交数',
  intention_c_submit_cnt int comment '意向沟通提交数',  
  mtd_intention_c_release_cnt int comment '月累计意向沟通释放数',
  mtd_intention_c_complete_cnt int comment '月累计意向沟通完成数',
  mtd_intention_c_adoption_cnt int comment '月累计意向沟通采纳数',
  mtd_intention_c_reject_cnt int comment '月累计意向沟通驳回数',
  mtd_intention_c_high_track_cnt int comment '月累计意向度-高',
  mtd_intention_c_mid_track_cnt int comment '月累计意向度-中',
  mtd_intention_c_low_track_cnt int comment '月累计意向度-低',
  mtd_intention_c_none_track_cnt int comment '月累计意向度-无',
  mtd_intention_c_unknow_track_cnt int comment '月累计未知', 
  mtd_intention_c_allow_track_cnt int comment '月累计开放', 
  mtd_intention_c_disallow_track_cnt int comment '月累计不开放', 
  mtd_intention_c_invalid_track_cnt int comment '月累计未成功沟通数',
  mtd_intention_c_withdraw_cnt int comment '月累计意向沟通收回数',
  mtd_standard_intention_c_submit_cnt int comment '月累计达标意向沟通提交数',
  mtd_intention_c_submit_cnt int comment '月累计意向沟通提交数',   
  creation_timestamp timestamp
) comment '职业顾问小组意向沟通统计日表'
partitioned by (p_date int);


create table if not exists fact_h_gcdc_d_intention_cdcorg_new
(
  d_date int comment '统计日期',
  org_id int comment '职业顾问小组ID',
  org_name varchar(100) comment '职业顾问小组名称',
  branch_id int comment '地区ID',
  branch_name varchar(50) comment '地区名称',
  intention_c_type varchar(50) comment '意向沟通类型:0-索要联系方式发起,1-意向沟通发起,2-意向沟通+索要联系方式',
  industry varchar(50) comment '发起意向沟通的企业行业编码',
  industry_name varchar(50) comment '发起意向沟通的企业行业名称',
  deliver_type varchar(2) comment '交付类型 1:一天交付,2:两天交付,3:三天交付',
  intention_c_release_cnt int comment '意向沟通释放数',
  intention_c_complete_cnt int comment '意向沟通完成数',
  intention_c_adoption_cnt int comment '意向沟通采纳数',
  intention_c_reject_cnt int comment '意向沟通驳回数',
  intention_c_high_track_cnt int comment '意向度-高',
  intention_c_mid_track_cnt int comment '意向度-中',
  intention_c_low_track_cnt int comment '意向度-低',
  intention_c_none_track_cnt int comment '意向度-无',
  intention_c_unknow_track_cnt int comment '未知', 
  intention_c_allow_track_cnt int comment '开放', 
  intention_c_disallow_track_cnt int comment '不开放', 
  intention_c_invalid_track_cnt int comment '未成功沟通数',
  intention_c_withdraw_cnt int comment '意向沟通收回数',
  standard_intention_c_submit_cnt int comment '达标意向沟通提交数',
  intention_c_submit_cnt int comment '意向沟通提交数',  
  mtd_intention_c_release_cnt int comment '月累计意向沟通释放数',
  mtd_intention_c_complete_cnt int comment '月累计意向沟通完成数',
  mtd_intention_c_adoption_cnt int comment '月累计意向沟通采纳数',
  mtd_intention_c_reject_cnt int comment '月累计意向沟通驳回数',
  mtd_intention_c_high_track_cnt int comment '月累计意向度-高',
  mtd_intention_c_mid_track_cnt int comment '月累计意向度-中',
  mtd_intention_c_low_track_cnt int comment '月累计意向度-低',
  mtd_intention_c_none_track_cnt int comment '月累计意向度-无',
  mtd_intention_c_unknow_track_cnt int comment '月累计未知', 
  mtd_intention_c_allow_track_cnt int comment '月累计开放', 
  mtd_intention_c_disallow_track_cnt int comment '月累计不开放', 
  mtd_intention_c_invalid_track_cnt int comment '月累计未成功沟通数',
  mtd_intention_c_withdraw_cnt int comment '月累计意向沟通收回数',
  mtd_standard_intention_c_submit_cnt int comment '月累计达标意向沟通提交数',
  mtd_intention_c_submit_cnt int comment '月累计意向沟通提交数',   
  creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
  primary key (d_date,org_id,intention_c_type,industry,deliver_type)
) comment '职业顾问小组意向沟通统计日表';

insert overwrite table fact_h_gcdc_d_intention_cdcorg_new partition(p_date = $date$)
select
    $date$ as d_date,
    nvl(intention.org_id,'-1') as org_id,
    nvl(dim_org.name,'未知') as org_name,
    nvl(dim_org.branch_id,'-1') as branch_id,
    nvl(dim_org.branch_name,'未知') as branch_name,
    nvl(intention.intention_type,'-1') as intention_c_type,
    nvl(dim_industry_pre.d_main_industry_code,'999') as industry,
    nvl(dim_industry_pre.d_main_industry,'未知') as industry_name,
    nvl(intention.deliver_type,-1),
    nvl(sum(intention.intention_c_release_cnt),0) as intention_c_release_cnt,
    nvl(sum(intention.intention_c_complete_cnt),0) as intention_c_complete_cnt,
    nvl(sum(intention.intention_c_adoption_cnt),0) as intention_c_adoption_cnt,
    nvl(sum(intention.intention_c_reject_cnt),0) as intention_c_reject_cnt,
    nvl(sum(intention.intention_c_high_track_cnt),0) as intention_c_high_track_cnt,
    nvl(sum(intention.intention_c_mid_track_cnt),0) as intention_c_mid_track_cnt,
    nvl(sum(intention.intention_c_low_track_cnt),0) as intention_c_low_track_cnt,
    nvl(sum(intention.intention_c_none_track_cnt),0) as intention_c_none_track_cnt,
    nvl(sum(intention.intention_c_unknow_track_cnt),0) as intention_c_unknow_track_cnt,
    nvl(sum(intention.intention_c_allow_track_cnt),0) as intention_c_allow_track_cnt,
    nvl(sum(intention.intention_c_disallow_track_cnt),0) as intention_c_disallow_track_cnt,
    nvl(sum(intention.intention_c_invalid_track_cnt),0) as intention_c_invalid_track_cnt,
    nvl(sum(intention.intention_c_withdraw_cnt),0) as intention_c_withdraw_cnt,
    nvl(sum(intention.standard_intention_c_submit_cnt),0) as standard_intention_c_submit_cnt, 
    nvl(sum(intention.intention_c_submit_cnt),0) as intention_c_submit_cnt,
    nvl(sum(intention.mtd_intention_c_release_cnt),0) as mtd_intention_c_release_cnt,
    nvl(sum(intention.mtd_intention_c_complete_cnt),0) as mtd_intention_c_complete_cnt,
    nvl(sum(intention.mtd_intention_c_adoption_cnt),0) as mtd_intention_c_adoption_cnt,
    nvl(sum(intention.mtd_intention_c_reject_cnt),0) as mtd_intention_c_reject_cnt,
    nvl(sum(intention.mtd_intention_c_high_track_cnt),0) as mtd_intention_c_high_track_cnt,
    nvl(sum(intention.mtd_intention_c_mid_track_cnt),0) as mtd_intention_c_mid_track_cnt,
    nvl(sum(intention.mtd_intention_c_low_track_cnt),0) as mtd_intention_c_low_track_cnt,
    nvl(sum(intention.mtd_intention_c_none_track_cnt),0) as mtd_intention_c_none_track_cnt,
    nvl(sum(intention.mtd_intention_c_unknow_track_cnt),0) as mtd_intention_c_unknow_track_cnt,
    nvl(sum(intention.mtd_intention_c_allow_track_cnt),0) as mtd_intention_c_allow_track_cnt,
    nvl(sum(intention.mtd_intention_c_disallow_track_cnt),0) as mtd_intention_c_disallow_track_cnt,
    nvl(sum(intention.mtd_intention_c_invalid_track_cnt),0) as mtd_intention_c_invalid_track_cnt,
    nvl(sum(intention.mtd_intention_c_withdraw_cnt),0) as mtd_intention_c_withdraw_cnt,
    nvl(sum(intention.mtd_standard_intention_c_submit_cnt),0) as mtd_standard_intention_c_submit_cnt, 
    nvl(sum(intention.mtd_intention_c_submit_cnt),0) as mtd_intention_c_submit_cnt,
    from_unixtime(unix_timestamp()) as creation_timestamp
from 
(  select 
      task.org_id,task.intention_type,customer.industry,task.deliver_type,
      count(task.id) as intention_c_release_cnt,
      0 as intention_c_complete_cnt,
      0 as intention_c_adoption_cnt,
      0 as intention_c_reject_cnt,
      0 as intention_c_high_track_cnt,
      0 as intention_c_mid_track_cnt,
      0 as intention_c_low_track_cnt,
      0 as intention_c_none_track_cnt,
      0 as intention_c_unknow_track_cnt,
      0 as intention_c_allow_track_cnt,
      0 as intention_c_disallow_track_cnt,
      0 as intention_c_invalid_track_cnt,
      0 as intention_c_withdraw_cnt,
      0 as intention_c_submit_cnt,
      0 as standard_intention_c_submit_cnt,
      0 as mtd_intention_c_release_cnt,
      0 as mtd_intention_c_complete_cnt,
      0 as mtd_intention_c_adoption_cnt,
      0 as mtd_intention_c_reject_cnt,
      0 as mtd_intention_c_high_track_cnt,
      0 as mtd_intention_c_mid_track_cnt,
      0 as mtd_intention_c_low_track_cnt,
      0 as mtd_intention_c_none_track_cnt,
      0 as mtd_intention_c_unknow_track_cnt,
      0 as mtd_intention_c_allow_track_cnt,
      0 as mtd_intention_c_disallow_track_cnt,
      0 as mtd_intention_c_invalid_track_cnt,
      0 as mtd_intention_c_withdraw_cnt,
      0 as mtd_intention_c_submit_cnt,
      0 as mtd_standard_intention_c_submit_cnt    
  from rsc_intention_task_c task 
  join dw_erp_d_customer_base customer  
  on task.customer_id = customer.id
  and customer.p_date = $date$
  where task.deleteflag = 0
  and task.intention_type in (0,1,2)
  and substr(regexp_replace(task.createtime,'-',''),1,8) = $date$
  group by task.org_id,task.intention_type,customer.industry,task.deliver_type
  union all 
  select 
      task.org_id,task.intention_type,customer.industry,task.deliver_type,
      0 as intention_c_release_cnt,
      0 as intention_c_complete_cnt,
      count(case when log.status =4 then log.id else null end) as intention_c_adoption_cnt,
      count(case when log.status =2 then log.id else null end) as intention_c_reject_cnt,
      0 as intention_c_high_track_cnt,
      0 as intention_c_mid_track_cnt,
      0 as intention_c_low_track_cnt,
      0 as intention_c_none_track_cnt,
      0 as intention_c_unknow_track_cnt,
      0 as intention_c_allow_track_cnt,
      0 as intention_c_disallow_track_cnt,
      0 as intention_c_invalid_track_cnt,
      count(case when log.status =3 then log.id else null end) as intention_c_withdraw_cnt,
      0 as intention_c_submit_cnt,
      0 as standard_intention_c_submit_cnt,
      0 as mtd_intention_c_release_cnt,
      0 as mtd_intention_c_complete_cnt,
      0 as mtd_intention_c_adoption_cnt,
      0 as mtd_intention_c_reject_cnt,
      0 as mtd_intention_c_high_track_cnt,
      0 as mtd_intention_c_mid_track_cnt,
      0 as mtd_intention_c_low_track_cnt,
      0 as mtd_intention_c_none_track_cnt,
      0 as mtd_intention_c_unknow_track_cnt,
      0 as mtd_intention_c_allow_track_cnt,
      0 as mtd_intention_c_disallow_track_cnt,
      0 as mtd_intention_c_invalid_track_cnt,
      0 as mtd_intention_c_withdraw_cnt,
      0 as mtd_intention_c_submit_cnt,
      0 as mtd_standard_intention_c_submit_cnt     
  from rsc_intention_task_c_log log 
  join rsc_intention_task_c task 
  on log.rsc_intention_task_c_id = task.id
  join dw_erp_d_customer_base customer  
  on task.customer_id = customer.id
  and customer.p_date = $date$
  where log.deleteflag = 0
  and log.intention_type in (0,1,2)
  and log.status in (0,2,4,3)
  and substr(regexp_replace(log.createtime,'-',''),1,8) = $date$
  group by task.org_id,task.intention_type,customer.industry,task.deliver_type
  union all 
  select log.org_id,log.intention_type,customer.industry,task.deliver_type,
          0 as intention_c_release_cnt,
           count(case when log.intention_type in (1,2) and log.result in (1,2,3,4) then log.id else null end) as intention_c_complete_cnt,
          0 as intention_c_adoption_cnt,
          0 as intention_c_reject_cnt, 
          0 as intention_c_high_track_cnt,
          0 as intention_c_mid_track_cnt,
          0 as intention_c_low_track_cnt,
          0 as intention_c_none_track_cnt,
          0 as intention_c_unknow_track_cnt,
          0 as intention_c_allow_track_cnt,
          0 as intention_c_disallow_track_cnt,
          count(case when log.intention_type = 0 and log.demand_concat_result =4 then log.id 
           when log.intention_type = 0 and log.demand_concat_result <> 4 then null
           when log.intention_type in (1,2) and log.result = 6 then log.id 
           when log.intention_type in (1,2) and log.result <> 6 then null
           else null end) as intention_c_invalid_track_cnt,
          0 as intention_c_withdraw_cnt,
          count(case when log.intention_type in (1,2) and log.result in (1,2,3,4,6) then log.id else null end) as intention_c_submit_cnt,
          count(case when log.intention_type in (1,2) and log.result in (1,2,3,4,6) and work_hour_diff(task.createtime,log.createtime)/24 < deliver_type then log.id else null end) as standard_intention_c_submit_cnt,
          0 as mtd_intention_c_release_cnt,
          0 as mtd_intention_c_complete_cnt,         
          0 as mtd_intention_c_adoption_cnt,
          0 as mtd_intention_c_reject_cnt, 
          0 as mtd_intention_c_high_track_cnt,
          0 as mtd_intention_c_mid_track_cnt,
          0 as mtd_intention_c_low_track_cnt,
          0 as mtd_intention_c_none_track_cnt,
          0 as mtd_intention_c_unknow_track_cnt,
          0 as mtd_intention_c_allow_track_cnt,
          0 as mtd_intention_c_disallow_track_cnt,
          0 as mtd_intention_c_invalid_track_cnt,
          0 as mtd_intention_c_withdraw_cnt,
          0 as mtd_intention_c_submit_cnt,
          0 as mtd_standard_intention_c_submit_cnt
    from rsc_intention_task_c_log log 
    join rsc_intention_task_c task 
      on log.rsc_intention_task_c_id = task.id
    join dw_erp_d_customer_base customer  
      on task.customer_id = customer.id
      and customer.p_date = $date$
   where log.deleteflag = 0
     and log.intention_type in (0,1,2)
     and log.status = 1 
     and substr(regexp_replace(log.createtime,'-',''),1,8)= $date$
   group by log.org_id,log.intention_type,customer.industry,task.deliver_type
   union all 
  select log.org_id,log.intention_type,customer.industry,log.deliver_type,
      0 as intention_c_release_cnt,
      0 as intention_c_complete_cnt,
      0 as intention_c_adoption_cnt,
      0 as intention_c_reject_cnt,
      count(case when log.status in (1,4) and log.result =1 then log.id else null end) as intention_c_high_track_cnt,
      count(case when log.status in (1,4) and log.result =2 then log.id else null end) as intention_c_mid_track_cnt,
      count(case when log.status in (1,4) and log.result =3 then log.id else null end) as intention_c_low_track_cnt,
      count(case when log.status in (1,4) and log.result =4 then log.id else null end) as intention_c_none_track_cnt,
      count(case when log.status in (1,4) and log.result =5 then log.id else null end) as intention_c_unknow_track_cnt,
      count(case when log.demand_concat_result =1 then log.id else null end) as intention_c_allow_track_cnt,
      count(case when log.demand_concat_result =2 then log.id else null end) as intention_c_disallow_track_cnt,
      0 as intention_c_invalid_track_cnt,
      0 as intention_c_withdraw_cnt,
      0 as intention_c_submit_cnt,
      0 as standard_intention_c_submit_cnt,
      0 as mtd_intention_c_release_cnt,
      0 as mtd_intention_c_complete_cnt,         
      0 as mtd_intention_c_adoption_cnt,
      0 as mtd_intention_c_reject_cnt, 
      0 as mtd_intention_c_high_track_cnt,
      0 as mtd_intention_c_mid_track_cnt,
      0 as mtd_intention_c_low_track_cnt,
      0 as mtd_intention_c_none_track_cnt,
      0 as mtd_intention_c_unknow_track_cnt,
      0 as mtd_intention_c_allow_track_cnt,
      0 as mtd_intention_c_disallow_track_cnt,
      0 as mtd_intention_c_invalid_track_cnt,
      0 as mtd_intention_c_withdraw_cnt,
      0 as mtd_intention_c_submit_cnt,
      0 as mtd_standard_intention_c_submit_cnt
    from rsc_intention_task_c log 
    join dw_erp_d_customer_base customer  
      on log.customer_id = customer.id
     and customer.p_date = '$date$'
   where log.deleteflag = 0
     and log.intention_type in (0,1,2)
     and log.status = 4
     and substr(regexp_replace(log.modifytime,'-',''),1,8) = '$date$'
    group by log.org_id,log.intention_type,customer.industry,log.deliver_type
) intention
left join dim_gcdc_org dim_org
on intention.org_id = dim_org.id
and dim_org.p_date = $date$
left join  dim_industry_pre
on intention.industry = dim_industry_pre.d_ind_code
group by 
intention.org_id,
dim_org.name,
dim_org.branch_id,
dim_org.branch_name,
intention.intention_type,
  dim_industry_pre.d_main_industry_code,
  dim_industry_pre.d_main_industry,
  intention.deliver_type


create table if not exists fact_h_gcdc_w_intention_cdcuser_new
(
  d_date int comment '统计日期',
  cdc_user_id int comment '职业顾问ID',
  cdc_user_name string comment '职业顾问姓名',
  org_id int comment '职业顾问小组ID',
  org_name string comment '职业顾问小组名称',
  branch_id int comment '地区ID',
  branch_name string comment '地区名称',
  intention_c_type string comment '意向沟通类型:0-索要联系方式发起,1-意向沟通发起,2-意向沟通+索要联系方式',
  industry string comment '发起意向沟通的企业行业编码',
  industry_name string comment '发起意向沟通的企业行业名称',
  deliver_type string comment '交付类型 1:一天交付,2:两天交付,3:三天交付',
  intention_c_release_cnt int comment '意向沟通释放数',
  intention_c_complete_cnt int comment '意向沟通完成数',
  intention_c_adoption_cnt int comment '意向沟通采纳数',
  intention_c_reject_cnt int comment '意向沟通驳回数',
  intention_c_high_track_cnt int comment '意向度-高',
  intention_c_mid_track_cnt int comment '意向度-中',
  intention_c_low_track_cnt int comment '意向度-低',
  intention_c_none_track_cnt int comment '意向度-无',
  intention_c_unknow_track_cnt int comment '未知', 
  intention_c_allow_track_cnt int comment '开放', 
  intention_c_disallow_track_cnt int comment '不开放', 
  intention_c_invalid_track_cnt int comment '未成功沟通数',
  intention_c_withdraw_cnt int comment '意向沟通收回数',
  standard_intention_c_submit_cnt int comment '达标意向沟通提交数',
  intention_c_submit_cnt int comment '意向沟通提交数',
  creation_timestamp  timestamp 
) comment '职业顾问意向沟通统计周表'
partitioned by (p_date int);

create table if not exists fact_h_gcdc_w_intention_cdcuser_new
(
  d_date int comment '统计日期',
  cdc_user_id int comment '职业顾问ID',
  cdc_user_name varchar(50) comment '职业顾问姓名',
  org_id int comment '职业顾问小组ID',
  org_name varchar(100) comment '职业顾问小组名称',
  branch_id int comment '地区ID',
  branch_name varchar(50) comment '地区名称',
  intention_c_type varchar(50) comment '意向沟通类型:0-索要联系方式发起,1-意向沟通发起,2-意向沟通+索要联系方式',
  industry varchar(50) comment '发起意向沟通的企业行业编码',
  industry_name varchar(50) comment '发起意向沟通的企业行业名称',
  deliver_type varchar(2) comment '交付类型 1:一天交付,2:两天交付,3:三天交付',
  intention_c_release_cnt int comment '意向沟通释放数',
  intention_c_complete_cnt int comment '意向沟通完成数',
  intention_c_adoption_cnt int comment '意向沟通采纳数',
  intention_c_reject_cnt int comment '意向沟通驳回数',
  intention_c_high_track_cnt int comment '意向度-高',
  intention_c_mid_track_cnt int comment '意向度-中',
  intention_c_low_track_cnt int comment '意向度-低',
  intention_c_none_track_cnt int comment '意向度-无',
  intention_c_unknow_track_cnt int comment '未知', 
  intention_c_allow_track_cnt int comment '开放', 
  intention_c_disallow_track_cnt int comment '不开放', 
  intention_c_invalid_track_cnt int comment '未成功沟通数',
  intention_c_withdraw_cnt int comment '意向沟通收回数',
  standard_intention_c_submit_cnt int comment '达标意向沟通提交数',
  intention_c_submit_cnt int comment '意向沟通提交数', 
  creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
  primary key (d_date,cdc_user_id,intention_c_type,industry,deliver_type)
) comment '职业顾问意向沟通统计周表';

insert overwrite table fact_h_gcdc_w_intention_cdcuser_new partition(p_date = $date$)
select
    $date$ as d_date,
    nvl(intention.creator_id,'-1') as cdc_user_id,
    nvl(salesuser.name,'未知') as cdc_user_name,
    nvl(salesuser.org_id,'-1') as org_id,
    nvl(dim_org.name,'未知') as org_name,
    nvl(dim_org.branch_id,'-1') as branch_id,
    nvl(dim_org.branch_name,'未知') as branch_name,
    nvl(intention.intention_type,'-1') as intention_c_type,
    nvl(dim_industry.main_industry,'999') as industry,
    nvl(dim_industry.main_industry_name,'未知') as industry_name,
    nvl(intention.deliver_type,-1) as deliver_type,
    nvl(sum(intention.intention_c_release_cnt),0) as intention_c_release_cnt,
    nvl(sum(intention.intention_c_complete_cnt),0) as intention_c_complete_cnt,
    nvl(sum(intention.intention_c_adoption_cnt),0) as intention_c_adoption_cnt,
    nvl(sum(intention.intention_c_reject_cnt),0) as intention_c_reject_cnt,
    nvl(sum(intention.intention_c_high_track_cnt),0) as intention_c_high_track_cnt,
    nvl(sum(intention.intention_c_mid_track_cnt),0) as intention_c_mid_track_cnt,
    nvl(sum(intention.intention_c_low_track_cnt),0) as intention_c_low_track_cnt,
    nvl(sum(intention.intention_c_none_track_cnt),0) as intention_c_none_track_cnt,
    nvl(sum(intention.intention_c_unknow_track_cnt),0) as intention_c_unknow_track_cnt,
    nvl(sum(intention.intention_c_allow_track_cnt),0) as intention_c_allow_track_cnt,
    nvl(sum(intention.intention_c_disallow_track_cnt),0) as intention_c_disallow_track_cnt,
    nvl(sum(intention.intention_c_invalid_track_cnt),0) as intention_c_invalid_track_cnt,
    nvl(sum(intention.intention_c_withdraw_cnt),0) as intention_c_withdraw_cnt,
    nvl(sum(intention.standard_intention_c_submit_cnt),0) as standard_intention_c_submit_cnt, 
    nvl(sum(intention.intention_c_submit_cnt),0) as intention_c_submit_cnt,
    from_unixtime(unix_timestamp()) as creation_timestamp
from 
(  select 
      task.creator_id,task.intention_type,customer.industry,task.deliver_type,
      count(task.id) as intention_c_release_cnt,
      0 as intention_c_complete_cnt,
      0 as intention_c_adoption_cnt,
      0 as intention_c_reject_cnt,
      0 as intention_c_high_track_cnt,
      0 as intention_c_mid_track_cnt,
      0 as intention_c_low_track_cnt,
      0 as intention_c_none_track_cnt,
      0 as intention_c_unknow_track_cnt,
      0 as intention_c_allow_track_cnt,
      0 as intention_c_disallow_track_cnt,
      0 as intention_c_invalid_track_cnt,
      0 as intention_c_withdraw_cnt,
      0 as intention_c_submit_cnt,
      0 as standard_intention_c_submit_cnt  
  from rsc_intention_task_c task 
  join dw_erp_d_customer_base customer  
  on task.customer_id = customer.id
  and customer.p_date = $date$
  where task.deleteflag = 0
  and task.intention_type in (0,1,2)
  and substr(regexp_replace(task.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
  group by task.creator_id,task.intention_type,customer.industry,task.deliver_type
  union all 
  select 
      task.creator_id,task.intention_type,customer.industry,task.deliver_type,
      0 as intention_c_release_cnt,
      0 as intention_c_complete_cnt,
      count(case when log.status =4 then log.id else null end) as intention_c_adoption_cnt,
      count(case when log.status =2 then log.id else null end) as intention_c_reject_cnt,
      0 as intention_c_high_track_cnt,
      0 as intention_c_mid_track_cnt,
      0 as intention_c_low_track_cnt,
      0 as intention_c_none_track_cnt,
      0 as intention_c_unknow_track_cnt,
      0 as intention_c_allow_track_cnt,
      0 as intention_c_disallow_track_cnt,
      0 as intention_c_invalid_track_cnt,
      count(case when log.status =3 then log.id else null end) as intention_c_withdraw_cnt,
      0 as intention_c_submit_cnt,
      0 as standard_intention_c_submit_cnt    
  from rsc_intention_task_c_log log 
  join rsc_intention_task_c task 
  on log.rsc_intention_task_c_id = task.id
  join dw_erp_d_customer_base customer  
  on task.customer_id = customer.id
  and customer.p_date = $date$
  where log.deleteflag = 0
  and log.intention_type in (0,1,2)
  and log.status in (0,2,4,3)
  and substr(regexp_replace(log.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
  group by task.creator_id,task.intention_type,customer.industry,task.deliver_type
  union all 
  select log.creator_id,log.intention_type,customer.industry,task.deliver_type,
          0 as intention_c_release_cnt,
          count(case when log.status = 1 and log.result in (1,2,3,4) then log.id else null end) as intention_c_complete_cnt,
          0 as intention_c_adoption_cnt,
          0 as intention_c_reject_cnt, 
          0 as intention_c_high_track_cnt,
          0 as intention_c_mid_track_cnt,
          0 as intention_c_low_track_cnt,
          0 as intention_c_none_track_cnt,
          0 as intention_c_unknow_track_cnt,
          0 as intention_c_allow_track_cnt,
          0 as intention_c_disallow_track_cnt,
          0 as intention_c_invalid_track_cnt,
          0 as intention_c_withdraw_cnt,
          count(case when ((log.intention_type in (1,2) and log.result = 6) or (log.status = 1 and log.result in (1,2,3,4,6))) then log.id else null end) as intention_c_submit_cnt,
          count(case when log.intention_type in (1,2) and log.result in (1,2,3,4,6) and work_hour_diff(task.createtime,log.createtime)/24 < deliver_type then log.id else null end) as standard_intention_c_submit_cnt
    from rsc_intention_task_c_log log 
    join rsc_intention_task_c task 
      on log.rsc_intention_task_c_id = task.id
    join dw_erp_d_customer_base customer  
      on task.customer_id = customer.id
      and customer.p_date = $date$
   where log.deleteflag = 0
     and log.intention_type in (0,1,2)
     and log.status = 1 
     and substr(regexp_replace(log.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
   group by log.creator_id,log.intention_type,customer.industry,task.deliver_type
   union all 
    select log.creator_id,log.intention_type,log.industry,log.deliver_type,
      0 as intention_c_release_cnt,
      0 as intention_c_complete_cnt,
      0 as intention_c_adoption_cnt,
      0 as intention_c_reject_cnt,
      count(case when log.status in (1,4) and log.result =1 then log.id else null end) as intention_c_high_track_cnt,
      count(case when log.status in (1,4) and log.result =2 then log.id else null end) as intention_c_mid_track_cnt,
      count(case when log.status in (1,4) and log.result =3 then log.id else null end) as intention_c_low_track_cnt,
      count(case when log.status in (1,4) and log.result =4 then log.id else null end) as intention_c_none_track_cnt,
      0 as intention_c_unknow_track_cnt,
      count(case when log.status in (1,4) and log.demand_concat_result =1 then log.id else null end) as intention_c_allow_track_cnt,
      count(case when log.status in (1,4) and log.demand_concat_result =2 then log.id else null end) as intention_c_disallow_track_cnt,
      count(case when log.status in (1,4) and log.intention_type = 0 and log.demand_concat_result =4 then log.id 
                 when log.status in (1,4) and log.intention_type = 0 and log.demand_concat_result <> 4 then null
                 when log.status in (1,4) and log.intention_type in (1,2) and log.result = 6 then log.id 
                 when log.status in (1,4) and log.intention_type in (1,2) and log.result <> 6 then null
                 else null end) as intention_c_invalid_track_cnt,
      0 as intention_c_withdraw_cnt,
      0 as intention_c_submit_cnt,
      0 as standard_intention_c_submit_cnt
    from (
        select  log.id,log.result,log.status,log.demand_concat_result,
                task.deliver_type,task.creator_id,log.intention_type,customer.industry,
                row_number()over(distribute by log.rsc_intention_task_c_id sort by log.createtime desc ) as rn 
          from rsc_intention_task_c_log log 
          join rsc_intention_task_c task 
            on log.rsc_intention_task_c_id = task.id
          join dw_erp_d_customer_base customer  
            on task.customer_id = customer.id
           and customer.p_date = $date$
         where log.deleteflag = 0
           and log.intention_type in (0,1,2)
           and substr(regexp_replace(log.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
    ) log 
    where rn = 1
    group by log.creator_id,log.intention_type,log.industry,log.deliver_type
 union all 
    select log.creator_id,log.intention_type,log.industry,log.deliver_type,
      0 as intention_c_release_cnt,
      0 as intention_c_complete_cnt,
      0 as intention_c_adoption_cnt,
      0 as intention_c_reject_cnt,
      0 as intention_c_high_track_cnt,
      0 as intention_c_mid_track_cnt,
      0 as intention_c_low_track_cnt,
      0 as intention_c_none_track_cnt,
      count(case when log.status = 1 and log.result =5 then log.id else null end) as intention_c_unknow_track_cnt,
      0 as intention_c_allow_track_cnt,
      0 as intention_c_disallow_track_cnt,
      0 as intention_c_invalid_track_cnt,
      0 as intention_c_withdraw_cnt,
      0 as intention_c_submit_cnt,
      0 as standard_intention_c_submit_cnt
    from (
        select  log.id,log.result,log.status,log.demand_concat_result,
                task.deliver_type,log.creator_id,log.intention_type,customer.industry,
                row_number()over(distribute by log.rsc_intention_task_c_id,substr(regexp_replace(log.createtime,'-',''),1,8) sort by log.createtime desc ) as rn 
          from rsc_intention_task_c_log log 
          join rsc_intention_task_c task 
            on log.rsc_intention_task_c_id = task.id
          join dw_erp_d_customer_base customer  
            on task.customer_id = customer.id
           and customer.p_date = $date$
         where log.deleteflag = 0
           and log.intention_type in (0,1,2)
           and log.status = 1
           and substr(regexp_replace(log.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
    ) log 
    where rn = 1
    group by log.creator_id,log.intention_type,log.industry,log.deliver_type
) intention
join 
(select id,name,org_id,org_name from dw_erp_d_salesuser_base where p_date =$date$) salesuser
on intention.creator_id = salesuser.id
left join dim_gcdc_org dim_org
on salesuser.org_id = dim_org.id
and dim_org.p_date = $date$
left join (
  select di1.d_ind_code,di1.d_main_industry as main_industry_name,nvl(di2.d_ind_code,'000') as main_industry
  from dim_industry di1
  left join dim_industry di2
  on di1.d_main_industry = di2.d_main_industry
  and length(di2.d_ind_code) = 2
 ) dim_industry
on intention.industry = dim_industry.d_ind_code
group by  
  intention.creator_id,
  salesuser.name,
  salesuser.org_id,
  dim_org.name,
  dim_org.branch_id,
  dim_org.branch_name,
  intention.intention_type,
  dim_industry.main_industry,
  dim_industry.main_industry_name,
  intention.deliver_type

create table if not exists fact_h_gcdc_w_intention_cdcorg_new
(
  d_date int comment '统计日期',
  org_id int comment '职业顾问小组ID',
  org_name string comment '职业顾问小组名称',
  branch_id int comment '地区ID',
  branch_name string comment '地区名称',
  intention_c_type string comment '意向沟通类型:0-索要联系方式发起,1-意向沟通发起,2-意向沟通+索要联系方式',
  industry string comment '发起意向沟通的企业行业编码',
  industry_name string comment '发起意向沟通的企业行业名称',
  deliver_type string comment '交付类型 1:一天交付,2:两天交付,3:三天交付',
  intention_c_release_cnt int comment '意向沟通释放数',
  intention_c_complete_cnt int comment '意向沟通完成数',
  intention_c_adoption_cnt int comment '意向沟通采纳数',
  intention_c_reject_cnt int comment '意向沟通驳回数',
  intention_c_high_track_cnt int comment '意向度-高',
  intention_c_mid_track_cnt int comment '意向度-中',
  intention_c_low_track_cnt int comment '意向度-低',
  intention_c_none_track_cnt int comment '意向度-无',
  intention_c_unknow_track_cnt int comment '未知', 
  intention_c_allow_track_cnt int comment '开放', 
  intention_c_disallow_track_cnt int comment '不开放', 
  intention_c_invalid_track_cnt int comment '未成功沟通数',
  intention_c_withdraw_cnt int comment '意向沟通收回数',
  standard_intention_c_submit_cnt int comment '达标意向沟通提交数',
  intention_c_submit_cnt int comment '意向沟通提交数', 
  creation_timestamp timestamp
) comment '职业顾问小组意向沟通统计周表'
partitioned by (p_date int);


create table if not exists fact_h_gcdc_w_intention_cdcorg_new
(
  d_date int comment '统计日期',
  org_id int comment '职业顾问小组ID',
  org_name varchar(100) comment '职业顾问小组名称',
  branch_id int comment '地区ID',
  branch_name varchar(50) comment '地区名称',
  intention_c_type varchar(50) comment '意向沟通类型:0-索要联系方式发起,1-意向沟通发起,2-意向沟通+索要联系方式',
  industry varchar(50) comment '发起意向沟通的企业行业编码',
  industry_name varchar(50) comment '发起意向沟通的企业行业名称',
  deliver_type varchar(2) comment '交付类型 1:一天交付,2:两天交付,3:三天交付',
  intention_c_release_cnt int comment '意向沟通释放数',
  intention_c_complete_cnt int comment '意向沟通完成数',
  intention_c_adoption_cnt int comment '意向沟通采纳数',
  intention_c_reject_cnt int comment '意向沟通驳回数',
  intention_c_high_track_cnt int comment '意向度-高',
  intention_c_mid_track_cnt int comment '意向度-中',
  intention_c_low_track_cnt int comment '意向度-低',
  intention_c_none_track_cnt int comment '意向度-无',
  intention_c_unknow_track_cnt int comment '未知', 
  intention_c_allow_track_cnt int comment '开放', 
  intention_c_disallow_track_cnt int comment '不开放', 
  intention_c_invalid_track_cnt int comment '未成功沟通数',
  intention_c_withdraw_cnt int comment '意向沟通收回数',
  standard_intention_c_submit_cnt int comment '达标意向沟通提交数',
  intention_c_submit_cnt int comment '意向沟通提交数',  
  creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
  primary key (d_date,org_id,intention_c_type,industry)
) comment '职业顾问小组意向沟通统计周表';


insert overwrite table fact_h_gcdc_w_intention_cdcorg_new partition(p_date = $date$)
select
    $date$ as d_date,
    nvl(intention.org_id,'-1') as org_id,
    nvl(dim_org.name,'未知') as org_name,
    nvl(dim_org.branch_id,'-1') as branch_id,
    nvl(dim_org.branch_name,'未知') as branch_name,
    nvl(intention.intention_type,'-1') as intention_c_type,
    nvl(dim_industry.main_industry,'999') as industry,
    nvl(dim_industry.main_industry_name,'未知') as industry_name,
    nvl(intention.deliver_type,-1),
    nvl(sum(intention.intention_c_release_cnt),0) as intention_c_release_cnt,
    nvl(sum(intention.intention_c_complete_cnt),0) as intention_c_complete_cnt,
    nvl(sum(intention.intention_c_adoption_cnt),0) as intention_c_adoption_cnt,
    nvl(sum(intention.intention_c_reject_cnt),0) as intention_c_reject_cnt,
    nvl(sum(intention.intention_c_high_track_cnt),0) as intention_c_high_track_cnt,
    nvl(sum(intention.intention_c_mid_track_cnt),0) as intention_c_mid_track_cnt,
    nvl(sum(intention.intention_c_low_track_cnt),0) as intention_c_low_track_cnt,
    nvl(sum(intention.intention_c_none_track_cnt),0) as intention_c_none_track_cnt,
    nvl(sum(intention.intention_c_unknow_track_cnt),0) as intention_c_unknow_track_cnt,
    nvl(sum(intention.intention_c_allow_track_cnt),0) as intention_c_allow_track_cnt,
    nvl(sum(intention.intention_c_disallow_track_cnt),0) as intention_c_disallow_track_cnt,
    nvl(sum(intention.intention_c_invalid_track_cnt),0) as intention_c_invalid_track_cnt,
    nvl(sum(intention.intention_c_withdraw_cnt),0) as intention_c_withdraw_cnt,
    nvl(sum(intention.standard_intention_c_submit_cnt),0) as standard_intention_c_submit_cnt, 
    nvl(sum(intention.intention_c_submit_cnt),0) as intention_c_submit_cnt,
    from_unixtime(unix_timestamp()) as creation_timestamp
from 
(  select 
      task.org_id,task.intention_type,customer.industry,task.deliver_type,
      count(task.id) as intention_c_release_cnt,
      0 as intention_c_complete_cnt,
      0 as intention_c_adoption_cnt,
      0 as intention_c_reject_cnt,
      0 as intention_c_high_track_cnt,
      0 as intention_c_mid_track_cnt,
      0 as intention_c_low_track_cnt,
      0 as intention_c_none_track_cnt,
      0 as intention_c_unknow_track_cnt,
      0 as intention_c_allow_track_cnt,
      0 as intention_c_disallow_track_cnt,
      0 as intention_c_invalid_track_cnt,
      0 as intention_c_withdraw_cnt,
      0 as intention_c_submit_cnt,
      0 as standard_intention_c_submit_cnt 
  from rsc_intention_task_c task 
  join dw_erp_d_customer_base customer  
  on task.customer_id = customer.id
  and customer.p_date = $date$
  where task.deleteflag = 0
  and task.intention_type in (0,1,2)
  and substr(regexp_replace(task.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
  group by task.org_id,task.intention_type,customer.industry,task.deliver_type
  union all 
  select 
      task.org_id,task.intention_type,customer.industry,task.deliver_type,
      0 as intention_c_release_cnt,
      0 as intention_c_complete_cnt,
      count(case when log.status =4 then log.id else null end) as intention_c_adoption_cnt,
      count(case when log.status =2 then log.id else null end) as intention_c_reject_cnt,
      0 as intention_c_high_track_cnt,
      0 as intention_c_mid_track_cnt,
      0 as intention_c_low_track_cnt,
      0 as intention_c_none_track_cnt,
      0 as intention_c_unknow_track_cnt,
      0 as intention_c_allow_track_cnt,
      0 as intention_c_disallow_track_cnt,
      0 as intention_c_invalid_track_cnt,
      count(case when log.status =3 then log.id else null end) as intention_c_withdraw_cnt,
      0 as intention_c_submit_cnt,
      0 as standard_intention_c_submit_cnt   
  from rsc_intention_task_c_log log 
  join rsc_intention_task_c task 
  on log.rsc_intention_task_c_id = task.id
  join dw_erp_d_customer_base customer  
  on task.customer_id = customer.id
  and customer.p_date = $date$
  where log.deleteflag = 0
  and log.intention_type in (0,1,2)
  and log.status in (0,2,4,3)
  and substr(regexp_replace(log.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
  group by task.org_id,task.intention_type,customer.industry,task.deliver_type
  union all 
  select log.org_id,log.intention_type,customer.industry,task.deliver_type,
          0 as intention_c_release_cnt,
          count(case when log.status = 1 and log.result in (1,2,3,4)  then log.id else null end) as intention_c_complete_cnt,
          0 as intention_c_adoption_cnt,
          0 as intention_c_reject_cnt, 
          0 as intention_c_high_track_cnt,
          0 as intention_c_mid_track_cnt,
          0 as intention_c_low_track_cnt,
          0 as intention_c_none_track_cnt,
          0 as intention_c_unknow_track_cnt,
          0 as intention_c_allow_track_cnt,
          0 as intention_c_disallow_track_cnt,
          0 as intention_c_invalid_track_cnt,
          0 as intention_c_withdraw_cnt,
          count(case when ((log.intention_type in (1,2) and log.result = 6) or (log.status = 1 and log.result in (1,2,3,4,6)))  then log.id else null end) as intention_c_submit_cnt,
          count(case when log.intention_type in (1,2) and log.result in (1,2,3,4,6) and work_hour_diff(task.createtime,log.createtime)/24 < deliver_type  then log.id else null end) as standard_intention_c_submit_cnt
    from rsc_intention_task_c_log log 
    join rsc_intention_task_c task 
      on log.rsc_intention_task_c_id = task.id
    join dw_erp_d_customer_base customer  
      on task.customer_id = customer.id
      and customer.p_date = $date$
   where log.deleteflag = 0
     and log.intention_type in (0,1,2)
     and log.status = 1 
     and substr(regexp_replace(log.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
   group by log.org_id,log.intention_type,customer.industry,task.deliver_type
   union all 
    select log.org_id,log.intention_type,log.industry,log.deliver_type,
      0 as intention_c_release_cnt,
      0 as intention_c_complete_cnt,
      0 as intention_c_adoption_cnt,
      0 as intention_c_reject_cnt,
      count(case when log.status in (1,4) and log.result =1 then log.id else null end) as intention_c_high_track_cnt,
      count(case when log.status in (1,4) and log.result =2 then log.id else null end) as intention_c_mid_track_cnt,
      count(case when log.status in (1,4) and log.result =3 then log.id else null end) as intention_c_low_track_cnt,
      count(case when log.status in (1,4) and log.result =4 then log.id else null end) as intention_c_none_track_cnt,
      0 as intention_c_unknow_track_cnt,
      count(case when log.status in (1,4) and log.demand_concat_result =1 then log.id else null end) as intention_c_allow_track_cnt,
      count(case when log.status in (1,4) and log.demand_concat_result =2 then log.id else null end) as intention_c_disallow_track_cnt,
      count(case when log.status in (1,4) and log.intention_type = 0 and log.demand_concat_result =4 then log.id 
                 when log.status in (1,4) and log.intention_type = 0 and log.demand_concat_result <> 4 then null
                 when log.status in (1,4) and log.intention_type in (1,2) and log.result = 6 then log.id 
                 when log.status in (1,4) and log.intention_type in (1,2) and log.result <> 6 then null
                 else null end) as intention_c_invalid_track_cnt,
      0 as intention_c_withdraw_cnt,
      0 as intention_c_submit_cnt,
      0 as standard_intention_c_submit_cnt
    from (
        select  log.id,log.result,log.status,substr(regexp_replace(log.createtime,'-',''),1,8) as createtime,log.demand_concat_result,
                task.deliver_type,task.org_id,log.intention_type,customer.industry,
                row_number()over(distribute by log.rsc_intention_task_c_id sort by log.createtime desc ) as rn 
          from rsc_intention_task_c_log log 
          join rsc_intention_task_c task 
            on log.rsc_intention_task_c_id = task.id
          join dw_erp_d_customer_base customer  
            on task.customer_id = customer.id
           and customer.p_date = $date$
         where log.deleteflag = 0
           and log.intention_type in (0,1,2)
           and substr(regexp_replace(log.createtime,'-',''),1,8) = $date$
    ) log 
    where rn = 1
    group by log.org_id,log.intention_type,log.industry,log.deliver_type
 union all 
    select log.org_id,log.intention_type,log.industry,log.deliver_type,
      0 as intention_c_release_cnt,
      0 as intention_c_complete_cnt,
      0 as intention_c_adoption_cnt,
      0 as intention_c_reject_cnt,
      0 as intention_c_high_track_cnt,
      0 as intention_c_mid_track_cnt,
      0 as intention_c_low_track_cnt,
      0 as intention_c_none_track_cnt,
      count(case when log.status = 1 and log.result =5 then log.id else null end) as intention_c_unknow_track_cnt,
      0 as intention_c_allow_track_cnt,
      0 as intention_c_disallow_track_cnt,
      0 as intention_c_invalid_track_cnt,
      0 as intention_c_withdraw_cnt,
      0 as intention_c_submit_cnt,
      0 as standard_intention_c_submit_cnt
    from (
        select  log.id,log.result,log.status,substr(regexp_replace(log.createtime,'-',''),1,8) as createtime,log.demand_concat_result,
                task.deliver_type,log.org_id,log.intention_type,customer.industry,
                row_number()over(distribute by log.rsc_intention_task_c_id,substr(regexp_replace(log.createtime,'-',''),1,8) sort by log.createtime desc ) as rn 
          from rsc_intention_task_c_log log 
          join rsc_intention_task_c task 
            on log.rsc_intention_task_c_id = task.id
          join dw_erp_d_customer_base customer  
            on task.customer_id = customer.id
           and customer.p_date = $date$
         where log.deleteflag = 0
           and log.intention_type in (0,1,2)
           and log.status = 1
           and substr(regexp_replace(log.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
    ) log 
    where rn = 1
    group by log.org_id,log.intention_type,log.industry,log.deliver_type 
) intention
left join dim_gcdc_org dim_org
on intention.org_id = dim_org.id
and dim_org.p_date = $date$
left join (
  select di1.d_ind_code,di1.d_main_industry as main_industry_name,nvl(di2.d_ind_code,'000') as main_industry
  from dim_industry di1
  left join dim_industry di2
  on di1.d_main_industry = di2.d_main_industry
  and length(di2.d_ind_code) = 2
 ) dim_industry
on intention.industry = dim_industry.d_ind_code
group by 
intention.org_id,
dim_org.name,
dim_org.branch_id,
dim_org.branch_name,
intention.intention_type,
  dim_industry.main_industry,
  dim_industry.main_industry_name,
  intention.deliver_type;



insert overwrite table fact_h_gcdc_d_intention_cdcuser_new partition (p_date)
select d_date, cdc_user_id, cdc_user_name, org_id, org_name, branch_id, branch_name, intention_c_type, 
dim_industry_pre.d_main_industry_code  as industry,
dim_industry_pre.d_main_industry as industry_name, 
9 as deliver_type,
sum(intention_c_release_cnt) as intention_c_release_cnt,
sum(intention_c_complete_cnt) as intention_c_complete_cnt,
sum(intention_c_adoption_cnt) as intention_c_adoption_cnt,
sum(intention_c_reject_cnt) as intention_c_reject_cnt,
sum(intention_c_high_track_cnt) as intention_c_high_track_cnt,
sum(intention_c_mid_track_cnt) as intention_c_mid_track_cnt,
sum(intention_c_low_track_cnt) as intention_c_low_track_cnt,
sum(intention_c_none_track_cnt) as intention_c_none_track_cnt,
sum(intention_c_unknow_track_cnt) as intention_c_unknow_track_cnt,
sum(intention_c_allow_track_cnt) as intention_c_allow_track_cnt,
sum(intention_c_disallow_track_cnt) as intention_c_disallow_track_cnt,
sum(intention_c_invalid_track_cnt) as intention_c_invalid_track_cnt,
sum(intention_c_withdraw_cnt) as intention_c_withdraw_cnt,
sum(standard_intention_c_submit_cnt) as standard_intention_c_submit_cnt,
sum(intention_c_submit_cnt) as intention_c_submit_cnt, 
0 as mtd_intention_c_release_cnt,
0 as mtd_intention_c_complete_cnt,
0 as mtd_intention_c_adoption_cnt,
0 as mtd_intention_c_reject_cnt,
0 as mtd_intention_c_high_track_cnt,
0 as mtd_intention_c_mid_track_cnt,
0 as mtd_intention_c_low_track_cnt,
 0 as mtd_intention_c_none_track_cnt,
 0 as mtd_intention_c_unknow_track_cnt,
 0 as mtd_intention_c_allow_track_cnt,
 0 as mtd_intention_c_disallow_track_cnt,
 0 as mtd_intention_c_invalid_track_cnt,
 0 as mtd_intention_c_withdraw_cnt,
 0 as mtd_standard_intention_c_submit_cnt,
 0 as mtd_intention_c_submit_cnt, 
 creation_timestamp, p_date
from fact_h_gcdc_d_intention_cdcuser
left join dim_industry_pre 
on industry = d_ind_code
where p_date between 20161001 and 20161231
group by p_date,d_date, cdc_user_id, cdc_user_name, org_id, org_name, branch_id, branch_name, intention_c_type, 
dim_industry_pre.d_main_industry_code , dim_industry_pre.d_main_industry;

insert overwrite table fact_h_gcdc_d_intention_cdcorg_new partition (p_date)
select d_date, org_id, org_name, branch_id, branch_name, intention_c_type,
dim_industry_pre.d_main_industry_code  as industry,
dim_industry_pre.d_main_industry as industry_name, 
9 as deliver_type,
sum(intention_c_release_cnt) as intention_c_release_cnt,
sum(intention_c_complete_cnt) as intention_c_complete_cnt,
sum(intention_c_adoption_cnt) as intention_c_adoption_cnt,
sum(intention_c_reject_cnt) as intention_c_reject_cnt,
sum(intention_c_high_track_cnt) as intention_c_high_track_cnt,
sum(intention_c_mid_track_cnt) as intention_c_mid_track_cnt,
sum(intention_c_low_track_cnt) as intention_c_low_track_cnt,
sum(intention_c_none_track_cnt) as intention_c_none_track_cnt,
sum(intention_c_unknow_track_cnt) as intention_c_unknow_track_cnt,
sum(intention_c_allow_track_cnt) as intention_c_allow_track_cnt,
sum(intention_c_disallow_track_cnt) as intention_c_disallow_track_cnt,
sum(intention_c_invalid_track_cnt) as intention_c_invalid_track_cnt,
sum(intention_c_withdraw_cnt) as intention_c_withdraw_cnt,
sum(standard_intention_c_submit_cnt) as standard_intention_c_submit_cnt,
sum(intention_c_submit_cnt) as intention_c_submit_cnt, 
0 as mtd_intention_c_release_cnt,
0 as mtd_intention_c_complete_cnt,
0 as mtd_intention_c_adoption_cnt,
0 as mtd_intention_c_reject_cnt,
0 as mtd_intention_c_high_track_cnt,
0 as mtd_intention_c_mid_track_cnt,
0 as mtd_intention_c_low_track_cnt,
 0 as mtd_intention_c_none_track_cnt,
 0 as mtd_intention_c_unknow_track_cnt,
 0 as mtd_intention_c_allow_track_cnt,
 0 as mtd_intention_c_disallow_track_cnt,
 0 as mtd_intention_c_invalid_track_cnt,
 0 as mtd_intention_c_withdraw_cnt,
 0 as mtd_standard_intention_c_submit_cnt,
 0 as mtd_intention_c_submit_cnt, 
 current_timestamp, p_date
from fact_h_gcdc_d_intention_cdcorg
left join dim_industry_pre 
on industry = d_ind_code
where p_date between 20161001 and 20161231
group by p_date,d_date, org_id, org_name, branch_id, branch_name, intention_c_type, 
dim_industry_pre.d_main_industry_code , dim_industry_pre.d_main_industry;


insert overwrite table fact_h_gcdc_d_intention_cdcorg_new partition (p_date)
select d_date, org_id, org_name, branch_id, branch_name, intention_c_type, 
case industry
when 10 then 1
when 11 then 2
when 12 then 3
when 13 then 4
when 14 then 5
when 15 then 6
when 16 then 7
when 17 then 8
when 18 then 9
when 19 then 10
when 20 then 11
when 21 then 12
else 999 end as industry, 
industry_name, deliver_type, intention_c_release_cnt, intention_c_complete_cnt, intention_c_adoption_cnt, intention_c_reject_cnt, intention_c_high_track_cnt, intention_c_mid_track_cnt, intention_c_low_track_cnt, intention_c_none_track_cnt, intention_c_unknow_track_cnt, intention_c_allow_track_cnt, intention_c_disallow_track_cnt, intention_c_invalid_track_cnt, intention_c_withdraw_cnt, standard_intention_c_submit_cnt, intention_c_submit_cnt, mtd_intention_c_release_cnt, mtd_intention_c_complete_cnt, mtd_intention_c_adoption_cnt, mtd_intention_c_reject_cnt, mtd_intention_c_high_track_cnt, mtd_intention_c_mid_track_cnt, mtd_intention_c_low_track_cnt, mtd_intention_c_none_track_cnt, mtd_intention_c_unknow_track_cnt, mtd_intention_c_allow_track_cnt, mtd_intention_c_disallow_track_cnt, mtd_intention_c_invalid_track_cnt, mtd_intention_c_withdraw_cnt, mtd_standard_intention_c_submit_cnt, mtd_intention_c_submit_cnt, creation_timestamp, p_date
from fact_h_gcdc_d_intention_cdcorg_new
where p_date between 20170101 and 20170208;