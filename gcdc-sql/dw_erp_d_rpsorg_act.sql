
--先在hive修改表结构，进行测试，测试完毕后，再修改mysql表结构，并同步数据
alter table dw_erp_d_rpsorg_act add columns(rps_user_cnt int comment '组内人数') cascade;
alter table dw_erp_d_rpsorg_act add (rps_user_cnt int comment '组内人数') ;

alter table dw_erp_d_rpsorg_act add columns(avg_rps_user_cnt int comment '组内月平均人数') cascade;

alter table dw_erp_d_rpsorg_act add (avg_rps_user_cnt int comment '组内月平均人数') ;

create table dw_erp_d_rpsorg_act (
d_date	int	comment '统计日期',
org_id	int	comment '招聘服务小组id',
org_name	string	comment '招聘服务小组名称',
org_grade int comment '组织级次',
is_last int comment '是否末级节点',
parent_org_id	int	comment '上级招聘服务小组id',
parent_org_name	string	comment '上级招聘服务小组名称',
time_schedule_ratio float comment '时间进度',
cust_consume_cv_target_cnt	int	comment '日目标消耗简历',
cust_consume_cv_cnt	int	comment '日已消耗简历',
gcdc_valid_call_cnt	int	comment '日有效通话个数',
gcdc_valid_call_timelong	int	comment '日有效通话时长',
rps_cust_cover_cnt	int	comment '日客户覆盖数',
cust_return_visit_cnt int comment '客户回访',
ejob_to_bole_manual_cnt int comment '需伯乐推荐职位数',
ejob_to_rps_manual_cnt int comment '需rps推荐职位数',
ejob_to_rps_bole_manual_cnt int comment '需伯乐和rps推荐职位数',
ejob_to_rps_bole_manual_cover_cnt int comment '需求职位覆盖数',
consume_intention_cust_cnt int comment '意向沟通使用客户数',
consume_intention_cust_ratio float comment '意向沟通使用比例',
consume_msk_cust_cnt int comment '面试快使用客户数',
consume_msk_cust_ratio float comment '面试快使用比例',
consume_invite_cust_cnt int comment '邀请应聘使用客户数',
consume_invite_cust_ratio float comment '邀请应聘使用比例',
consume_urgent_cust_cnt int comment '急聘使用客户数',
consume_urgent_cust_ratio float comment '急聘使用比例', 
consume_cv_cust_cnt int comment '简历下载使用客户数',
consume_cv_cust_ratio float comment '简历下载使用比例',
mtd_consume_cv_cnt	int	comment '本月累计客户消耗的简历数',
mtd_consume_cv_target_cnt	int	comment '本月累计目标消耗简历数',
mtd_consume_cv_ratio	float	comment '简历消耗率',
mtd_gcdc_valid_call_cnt	int	comment '本月累计有效通话个数',
mtd_gcdc_valid_call_timelong int comment '本月累计有效通话时长',
mtd_cust_cover_cnt	int	comment '本月累计覆盖客户数',
cust_cnt	int	comment '名下客户数',
mtd_cust_no_cover_cnt	int	comment '当月未覆盖客户数',
mtd_cust_cover_ratio	float	comment '客户覆盖率',
mtd_expire_renewal_cust_cnt	int	comment '当月合同到期当月续约的客户数',
mtd_n_expire_renewal_cust_cnt	int	comment '当月合同未到期 提前在当月续约的客户数',
mtd_expire_cust_cnt	int	comment '当月到期的客户数',
mtd_expire_p_renewal_cust_cnt	int	comment '当月到期客户数中已经提前续约的客户',
mtd_contract_renewal_ratio	float	comment '合同期内续约率',
mtd_rps_recommend_cv_cnt int comment '本月人工推荐简历数',
mtd_rps_recommend_satisfied_cv_cnt int comment '本月人工推荐简历满意数',
mtd_bole_recommend_cv_cnt int comment '本月伯乐推荐简历数',
mtd_bole_recommend_satisfied_cv_cnt int comment '本月伯乐推荐简历满意数',
mtd_recommend_deal_cv_cnt	int	comment '本月推荐且已处理简历数',
mtd_recommend_cv_cnt	int	comment '本月累计推荐简历数',
mtd_recommend_cv_deal_ratio	float	comment '简历处理率',
mtd_recommend_satisfied_cv_cnt	int	comment '本月累计推荐简历满意数',
mtd_msk_showup_cnt	int	comment '本月累计面试快已到场人数',
callplan_no_finish_cnt	int	comment '拨打计划未完成',
task_no_finish_cnt	int	comment '待办任务',
intention_no_release_cnt	int	comment '意向沟通未释放',
intention_no_submit_cnt	int	comment '意向沟通未提交',
ejob_no_label_cnt	int	comment '待标记职位',
ejob_no_tag_cnt int comment '待标签职位',
ejob_recommend_to_manual_cnt	int	comment '需rps介入职位',
ejob_7day_recommend_undeal_cnt	int	comment '近7天推荐未处理职位',
msk_assess_cnt	int	comment '面试快委托未跟进',
cust_break_cnt	int	comment '断约客户',
cust_renewal_cnt	int	comment '已续约客户',
cust_3month_renewal_cnt	int	comment '近3个月新签客户数',
cust_3month_expire_cnt	int	comment '3个月到期客户数',
cust_renewal_high_cnt	int	comment '续约意向度高',
cust_renewal_mid_cnt	int	comment '续约意向度中',
cust_renewal_low_cnt	int	comment '续约意向度低',
cust_renewal_none_cnt	int	comment '续约意向度无',
creation_timestamp	timestamp	comment '时间戳'
) comment '招服组织行为表-含各级组织，指标不可聚合'
partitioned by (p_date int);


create table dw_erp_d_rpsorg_act (
d_date	int	comment '统计日期',
org_id	int	comment '招聘服务小组id',
org_name varchar(100) comment '招聘服务小组名称',
org_grade int comment '组织级次',
is_last int comment '是否末级节点',
parent_org_id int comment '上级招聘服务小组id',
parent_org_name	varchar(100) comment '上级招聘服务小组名称',
time_schedule_ratio float comment '时间进度',
cust_consume_cv_target_cnt	int	comment '日目标消耗简历',
cust_consume_cv_cnt	int	comment '日已消耗简历',
gcdc_valid_call_cnt	int	comment '日有效通话个数',
gcdc_valid_call_timelong	int	comment '日有效通话时长',
rps_cust_cover_cnt	int	comment '日客户覆盖数',
cust_return_visit_cnt int comment '客户回访',
ejob_to_bole_manual_cnt int comment '需伯乐推荐职位数',
ejob_to_rps_manual_cnt int comment '需rps推荐职位数',
ejob_to_rps_bole_manual_cnt int comment '需伯乐和rps推荐职位数',
ejob_to_rps_bole_manual_cover_cnt int comment '需求职位覆盖数',
consume_intention_cust_cnt int comment '意向沟通使用客户数',
consume_intention_cust_ratio float comment '意向沟通使用比例',
consume_msk_cust_cnt int comment '面试快使用客户数',
consume_msk_cust_ratio float comment '面试快使用比例',
consume_invite_cust_cnt int comment '邀请应聘使用客户数',
consume_invite_cust_ratio float comment '邀请应聘使用比例',
consume_urgent_cust_cnt int comment '急聘使用客户数',
consume_urgent_cust_ratio float comment '急聘使用比例', 
consume_cv_cust_cnt int comment '简历下载使用客户数',
consume_cv_cust_ratio float comment '简历下载使用比例',
mtd_consume_cv_cnt	int	comment '本月累计客户消耗的简历数',
mtd_consume_cv_target_cnt	int	comment '本月累计目标消耗简历数',
mtd_consume_cv_ratio	float	comment '简历消耗率',
mtd_gcdc_valid_call_cnt	int	comment '本月累计有效通话个数',
mtd_gcdc_valid_call_timelong int comment '本月累计有效通话时长',
mtd_cust_cover_cnt	int	comment '本月累计覆盖客户数',
cust_cnt	int	comment '名下客户数',
mtd_cust_no_cover_cnt	int	comment '当月未覆盖客户数',
mtd_cust_cover_ratio	float	comment '客户覆盖率',
mtd_expire_renewal_cust_cnt	int	comment '当月合同到期当月续约的客户数',
mtd_n_expire_renewal_cust_cnt	int	comment '当月合同未到期 提前在当月续约的客户数',
mtd_expire_cust_cnt	int	comment '当月到期的客户数',
mtd_expire_p_renewal_cust_cnt	int	comment '当月到期客户数中已经提前续约的客户',
mtd_contract_renewal_ratio	float	comment '合同期内续约率',
mtd_rps_recommend_cv_cnt int comment '本月人工推荐简历数',
mtd_rps_recommend_satisfied_cv_cnt int comment '本月人工推荐简历满意数',
mtd_bole_recommend_cv_cnt int comment '本月伯乐推荐简历数',
mtd_bole_recommend_satisfied_cv_cnt int comment '本月伯乐推荐简历满意数',
mtd_recommend_deal_cv_cnt	int	comment '本月推荐且已处理简历数',
mtd_recommend_cv_cnt	int	comment '本月累计推荐简历数',
mtd_recommend_cv_deal_ratio	float	comment '简历处理率',
mtd_recommend_satisfied_cv_cnt	int	comment '本月累计推荐简历满意数',
mtd_msk_showup_cnt	int	comment '本月累计面试快已到场人数',
callplan_no_finish_cnt	int	comment '拨打计划未完成',
task_no_finish_cnt	int	comment '待办任务',
intention_no_release_cnt	int	comment '意向沟通未释放',
intention_no_submit_cnt	int	comment '意向沟通未提交',
ejob_no_label_cnt	int	comment '待标记职位',
ejob_no_tag_cnt int comment '待标签职位',
ejob_recommend_to_manual_cnt	int	comment '需rps介入职位',
ejob_7day_recommend_undeal_cnt	int	comment '近7天推荐未处理职位',
msk_assess_cnt	int	comment '面试快委托未跟进',
cust_break_cnt	int	comment '断约客户',
cust_renewal_cnt	int	comment '已续约客户',
cust_3month_renewal_cnt	int	comment '近3个月新签客户数',
cust_3month_expire_cnt	int	comment '3个月到期客户数',
cust_renewal_high_cnt	int	comment '续约意向度高',
cust_renewal_mid_cnt	int	comment '续约意向度中',
cust_renewal_low_cnt	int	comment '续约意向度低',
cust_renewal_none_cnt	int	comment '续约意向度无',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,org_id)
) comment '招服组织行为表-含各级组织，指标不可聚合';


alter table dw_erp_d_rpsorg_act add columns (warn_resource_consume_cust_cnt int comment '资源消耗预警客户数');
alter table dw_erp_d_rpsorg_act_detail add columns (warn_resource_consume_cust_cnt int comment '资源消耗预警客户数');

alter table dw_erp_d_rpsorg_act add (warn_resource_consume_cust_cnt int comment '资源消耗预警客户数');
alter table dw_erp_d_rpsorg_act_detail add (warn_resource_consume_cust_cnt int comment '资源消耗预警客户数');

insert overwrite table dw_erp_d_rpsorg_act partition (p_date = $date$)
select
$date$ as d_date,
dol.d_org_id as org_id,
dol.org_name as org_name,
dol.grade as org_grade ,
dol.is_last as is_last ,
dol.parent_id as parent_org_id ,
dol.parent_name as parent_org_name,
dt.time_schedule_ratio ,
rpsorg_act.cust_consume_cv_target_cnt as cust_consume_cv_target_cnt,
rpsorg_act.cust_consume_cv_cnt as cust_consume_cv_cnt,
rpsorg_act.gcdc_valid_call_cnt as gcdc_valid_call_cnt,
rpsorg_act.gcdc_valid_call_timelong as gcdc_valid_call_timelong,
rpsorg_act.rps_cust_cover_cnt as rps_cust_cover_cnt,
0 as cust_return_visit_cnt ,
0 as ejob_to_bole_manual_cnt ,
0 as ejob_to_rps_manual_cnt ,
0 as ejob_to_rps_bole_manual_cnt ,
0 as ejob_to_rps_bole_manual_cover_cnt ,
rpsorg_act.consume_intention_cust_cnt as consume_intention_cust_cnt ,
rpsorg_act.consume_intention_cust_ratio as consume_intention_cust_ratio ,
rpsorg_act.consume_msk_cust_cnt as consume_msk_cust_cnt ,
rpsorg_act.consume_msk_cust_ratio as consume_msk_cust_ratio ,
rpsorg_act.consume_invite_cust_cnt as consume_invite_cust_cnt ,
rpsorg_act.consume_invite_cust_ratio as consume_invite_cust_ratio ,
rpsorg_act.consume_urgent_cust_cnt as consume_urgent_cust_cnt ,
rpsorg_act.consume_urgent_cust_ratio as consume_urgent_cust_ratio ,
rpsorg_act.consume_cv_cust_cnt as consume_cv_cust_cnt ,
rpsorg_act.consume_cv_cust_ratio as consume_cv_cust_ratio ,
rpsorg_act.mtd_consume_cv_cnt as mtd_consume_cv_cnt,
rpsorg_act.mtd_consume_cv_target_cnt as mtd_consume_cv_target_cnt,
rpsorg_act.mtd_consume_cv_ratio as mtd_consume_cv_ratio,
rpsorg_act.mtd_gcdc_valid_call_cnt as mtd_gcdc_valid_call_cnt,
rpsorg_act.mtd_gcdc_valid_call_timelong as mtd_gcdc_valid_call_timelong ,
rpsorg_act.mtd_cust_cover_cnt as mtd_cust_cover_cnt,
rpsorg_act.cust_cnt as cust_cnt,
rpsorg_act.mtd_cust_no_cover_cnt as mtd_cust_no_cover_cnt,
rpsorg_act.mtd_cust_cover_ratio as mtd_cust_cover_ratio,
rpsorg_act.mtd_expire_renewal_cust_cnt as mtd_expire_renewal_cust_cnt,
rpsorg_act.mtd_n_expire_renewal_cust_cnt as mtd_n_expire_renewal_cust_cnt,
rpsorg_act.mtd_expire_cust_cnt as mtd_expire_cust_cnt,
rpsorg_act.mtd_expire_p_renewal_cust_cnt as mtd_expire_p_renewal_cust_cnt,
rpsorg_act.mtd_contract_renewal_ratio as mtd_contract_renewal_ratio,
rpsorg_act.mtd_rps_recommend_cv_cnt as mtd_rps_recommend_cv_cnt ,
rpsorg_act.mtd_rps_recommend_satisfied_cv_cnt as mtd_rps_recommend_satisfied_cv_cnt ,
rpsorg_act.mtd_bole_recommend_cv_cnt as mtd_bole_recommend_cv_cnt ,
rpsorg_act.mtd_bole_recommend_satisfied_cv_cnt as mtd_bole_recommend_satisfied_cv_cnt ,
rpsorg_act.mtd_recommend_deal_cv_cnt as mtd_recommend_deal_cv_cnt,
rpsorg_act.mtd_recommend_cv_cnt as mtd_recommend_cv_cnt,
rpsorg_act.mtd_recommend_cv_deal_ratio as mtd_recommend_cv_deal_ratio,
rpsorg_act.mtd_recommend_satisfied_cv_cnt as mtd_recommend_satisfied_cv_cnt,
rpsorg_act.mtd_msk_showup_cnt as mtd_msk_showup_cnt,
0 as callplan_no_finish_cnt,
0 as task_no_finish_cnt,
0 as intention_no_release_cnt,
0 as intention_no_submit_cnt,
0 as ejob_no_label_cnt,
0 as ejob_no_tag_cnt,
0 as ejob_recommend_to_manual_cnt,
0 as ejob_7day_recommend_undeal_cnt,
rpsorg_act.msk_assess_cnt as msk_assess_cnt,
0 as cust_break_cnt,
0 as cust_renewal_cnt,
0 as cust_3month_renewal_cnt,
0 as cust_3month_expire_cnt,
0 as cust_renewal_high_cnt,
0 as cust_renewal_mid_cnt,
0 as cust_renewal_low_cnt,
0 as cust_renewal_none_cnt,
 from_unixtime(unix_timestamp()) as creation_timestamp,
rpsorg_act.warn_resource_consume_cust_cnt as warn_resource_consume_cust_cnt,
rpsorg_act.rps_user_cnt as rps_user_cnt,
rpsorg_act.avg_rps_user_cnt as avg_rps_user_cnt

from 
(select
coalesce(rps_renewal.org_id,rps_call.org_id,rps_consume.org_id,consume.org_id,msk.org_id,user_cnt.org_id,candidate.org_id) as org_id,
sum(rps_consume.cust_consume_cv_target_cnt) as cust_consume_cv_target_cnt,
sum(rps_consume.cust_consume_cv_cnt) as cust_consume_cv_cnt,
sum(rps_call.gcdc_valid_call_cnt) as gcdc_valid_call_cnt,
sum(rps_call.gcdc_valid_call_timelong) as gcdc_valid_call_timelong,
sum(rps_call.rps_cust_cover_cnt) as rps_cust_cover_cnt,
0 as cust_return_visit_cnt ,
0 as ejob_to_bole_manual_cnt ,
0 as ejob_to_rps_manual_cnt ,
0 as ejob_to_rps_bole_manual_cnt ,
0 as ejob_to_rps_bole_manual_cover_cnt ,
sum(consume.consume_intention_cust_cnt) as consume_intention_cust_cnt ,
sum(consume.consume_intention_cust_ratio) as consume_intention_cust_ratio ,
sum(consume.consume_msk_cust_cnt) as consume_msk_cust_cnt ,
sum(consume.consume_msk_cust_ratio) as consume_msk_cust_ratio ,
sum(consume.consume_invite_cust_cnt) as consume_invite_cust_cnt ,
sum(consume.consume_invite_cust_ratio) as consume_invite_cust_ratio ,
sum(consume.consume_urgent_cust_cnt) as consume_urgent_cust_cnt ,
sum(consume.consume_urgent_cust_ratio) as consume_urgent_cust_ratio ,
sum(consume.consume_cv_cust_cnt) as consume_cv_cust_cnt ,
sum(consume.consume_cv_cust_ratio) as consume_cv_cust_ratio ,
sum(rps_consume.mtd_consume_cv_cnt) as mtd_consume_cv_cnt,
sum(rps_consume.mtd_consume_cv_target_cnt) as mtd_consume_cv_target_cnt,
sum(rps_consume.mtd_consume_cv_ratio) as mtd_consume_cv_ratio,
sum(rps_call.mtd_gcdc_valid_call_cnt) as mtd_gcdc_valid_call_cnt,
sum(rps_call.mtd_gcdc_valid_call_timelong) as mtd_gcdc_valid_call_timelong ,
sum(rps_call.mtd_cust_cover_cnt) as mtd_cust_cover_cnt,
sum(rps_call.cust_cnt) as cust_cnt,
sum(rps_call.cust_cnt) - sum(rps_call.mtd_cust_cover_cnt) as mtd_cust_no_cover_cnt,
sum(rps_call.mtd_cust_cover_cnt) / sum(rps_call.cust_cnt) as mtd_cust_cover_ratio,
sum(rps_renewal.mtd_expire_renewal_cust_cnt) as mtd_expire_renewal_cust_cnt,
sum(rps_renewal.mtd_n_expire_renewal_cust_cnt) as mtd_n_expire_renewal_cust_cnt,
sum(rps_renewal.mtd_expire_cust_cnt) as mtd_expire_cust_cnt,
sum(rps_renewal.mtd_expire_p_renewal_cust_cnt) as mtd_expire_p_renewal_cust_cnt,
sum(rps_renewal.mtd_contract_renewal_ratio) as mtd_contract_renewal_ratio,
sum(candidate.mtd_rps_recommend_cv_cnt) as mtd_rps_recommend_cv_cnt ,
sum(candidate.mtd_rps_recommend_satisfied_cv_cnt) as mtd_rps_recommend_satisfied_cv_cnt ,
sum(candidate.mtd_bole_recommend_cv_cnt) as mtd_bole_recommend_cv_cnt ,
sum(candidate.mtd_bole_recommend_satisfied_cv_cnt) as mtd_bole_recommend_satisfied_cv_cnt ,
sum(candidate.mtd_recommend_deal_cv_cnt) as mtd_recommend_deal_cv_cnt,
sum(candidate.mtd_recommend_cv_cnt) as mtd_recommend_cv_cnt,
sum(candidate.mtd_recommend_cv_deal_ratio) as mtd_recommend_cv_deal_ratio,
sum(candidate.mtd_recommend_satisfied_cv_cnt) as mtd_recommend_satisfied_cv_cnt,
sum(msk.mtd_msk_showup_cnt) as mtd_msk_showup_cnt,
0 as callplan_no_finish_cnt,
0 as task_no_finish_cnt,
0 as intention_no_release_cnt,
0 as intention_no_submit_cnt,
0 as ejob_no_label_cnt,
0 as ejob_no_tag_cnt,
0 as ejob_recommend_to_manual_cnt,
0 as ejob_7day_recommend_undeal_cnt,
sum(msk.msk_assess_cnt) as msk_assess_cnt,
0 as cust_break_cnt,
0 as cust_renewal_cnt,
0 as cust_3month_renewal_cnt,
0 as cust_3month_expire_cnt,
0 as cust_renewal_high_cnt,
0 as cust_renewal_mid_cnt,
0 as cust_renewal_low_cnt,
0 as cust_renewal_none_cnt,
 from_unixtime(unix_timestamp()) as creation_timestamp,
sum(consume.warn_resource_consume_cust_cnt) as warn_resource_consume_cust_cnt,
sum(user_cnt.rps_user_cnt) as rps_user_cnt,
sum(user_cnt.avg_rps_user_cnt) as avg_rps_user_cnt
from 
(
  select
  coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
  sum(mtd_expire_renewal_cust_cnt) as mtd_expire_renewal_cust_cnt,
  sum(mtd_n_expire_renewal_cust_cnt) as mtd_n_expire_renewal_cust_cnt,
  sum(mtd_expire_cust_cnt) as mtd_expire_cust_cnt,
  sum(mtd_expire_p_renewal_cust_cnt) as mtd_expire_p_renewal_cust_cnt,
  (sum(mtd_expire_renewal_cust_cnt) +sum(mtd_n_expire_renewal_cust_cnt)) / (sum(mtd_expire_cust_cnt)-sum(mtd_expire_p_renewal_cust_cnt)+ sum(mtd_n_expire_renewal_cust_cnt))  as mtd_contract_renewal_ratio
  from (
    select org_id,
    	   sum(expire_renewal_cust_cnt) as mtd_expire_renewal_cust_cnt,
    	   sum(pre_expire_renewal_cust_cnt) as mtd_n_expire_renewal_cust_cnt,
    	   sum(expire_cust_cnt) as mtd_expire_cust_cnt,
    	   sum(expire_pre_renewal_cust_cnt) as mtd_expire_p_renewal_cust_cnt
      from fact_h_gcdc_d_renewal_rpsuser
     where d_date = $date$
     group by org_id
  ) renewal_org
  left join dim_org_level dol 
  on renewal_org.org_id = dol.d_org_id
  and dol.p_date = $date$
  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)
) rps_renewal
full join 
(
  select 
      coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
	  sum(mtd_gcdc_valid_call_timelong) as mtd_gcdc_valid_call_timelong,
	  sum(mtd_gcdc_valid_call_cnt) as mtd_gcdc_valid_call_cnt,
	  count(distinct case when mtd_gcdc_valid_call_cnt > 0 then  call.customer_id else null end) as mtd_cust_cover_cnt,
	  sum(gcdc_valid_call_timelong) as gcdc_valid_call_timelong,
	  sum(gcdc_valid_call_cnt) as gcdc_valid_call_cnt,
	  count(distinct case when gcdc_valid_call_cnt > 0 then call.customer_id else null end) as rps_cust_cover_cnt,
      count(distinct base.id) as cust_cnt
  from dw_erp_d_customer_base base
  left join 
  (select 
   org_id, 
    customer_id,
    sum(time_long)/60  as mtd_gcdc_valid_call_timelong,
    count(1) as mtd_gcdc_valid_call_cnt,
    sum(case when call_date = $date$ then time_long else 0 end) / 60 as gcdc_valid_call_timelong,
    sum(case when call_date = $date$ then 1 else 0 end) as gcdc_valid_call_cnt
  from call_record
  where call_date between  {{date[:6]+'01'}} and $date$ 
  and deleteflag = 0 
  and time_long > 60
  and customer_id > 0
  and call_type=0
  group by org_id,customer_id
  ) call 
  on  call.customer_id = base.id
  and call.org_id = base.service_teamorg_id
  join dim_org_level dol 
  on base.service_teamorg_id = dol.d_org_id
  and dol.p_date = $date$
  where  base.p_date = $date$ 
  and base.rps_service_version = 1
  and base.rsc_valid_status = 1
  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)
) rps_call
on rps_renewal.org_id = rps_call.org_id
full join 
(
  select  
      suser_act.org_id,
      suser_act.mtd_consume_cv_cnt as mtd_consume_cv_cnt,
      suser_act.mtd_consume_cv_target_cnt as mtd_consume_cv_target_cnt,
      suser_act.mtd_consume_cv_cnt / suser_act.mtd_consume_cv_target_cnt as mtd_consume_cv_ratio,
      suser_act.cust_consume_cv_cnt,
      suser_act.cust_consume_cv_target_cnt
   from (
        select 
        coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
        sum(case when act.p_date = $date$ then consume_cv_total_cnt+exchange_cv2lowcv else 0 end) as cust_consume_cv_cnt,
        sum(act.consume_cv_total_cnt+act.exchange_cv2lowcv) as mtd_consume_cv_cnt,
        sum((case when target.left_cnt > 0 then target.day_consume_cv_target_cnt else 0 end) * holiday.is_workday) as mtd_consume_cv_target_cnt,
        sum(case when base.p_date = $date$ then target.day_consume_cv_target_cnt else 0 end) as cust_consume_cv_target_cnt
      from 
      dw_erp_d_customer_base base 
      left join dw_erp_d_customer_consume_target target 
      on base.id = target.customer_id
      and base.p_date = target.p_date
      left join dw_erp_d_customer_act act 
      on base.id = act.customer_id
      and base.p_date = act.p_date
      join dim_date_holiday holiday on base.p_date = holiday.d_date
      join dim_org_level dol on base.service_teamorg_id = dol.d_org_id and dol.p_date = $date$
      where base.p_date  between  {{date[:6]+'01'}} and $date$ 
      and base.rps_service_version = 1
      and base.rsc_valid_status = 1 
	  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
	  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)
   ) suser_act
) rps_consume
on  rps_renewal.org_id = rps_consume.org_id
full join 
(
  select
    coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
    count(case when dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_rps_recommend_cv_cnt,
    count(case when dwejobcandidate.source = 4 then dwejobcandidate.id else null end) as mtd_bole_recommend_cv_cnt,
    count(dwejobcandidate.id) as mtd_recommend_cv_cnt,
    count(case when dwejobcandidate.feedback in (4,2,5) and dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_rps_recommend_satisfied_cv_cnt,
    count(case when dwejobcandidate.feedback in (4,2,5) and dwejobcandidate.source = 4 then dwejobcandidate.id else null end) as mtd_bole_recommend_satisfied_cv_cnt,
    count(case when dwejobcandidate.feedback in (4,2,5) then dwejobcandidate.id else null end) as mtd_recommend_satisfied_cv_cnt,
    count(case when dwejobcandidate.feedback <> 1 then dwejobcandidate.id else null end) as mtd_recommend_deal_cv_cnt,
    count(case when dwejobcandidate.feedback <> 1 and dwejobcandidate.source = 0 then dwejobcandidate.id else null end) / count(case when dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_recommend_cv_deal_ratio
  from  dw_erp_d_ejob_candidate dwejobcandidate  
  left join dim_org_level dol on dwejobcandidate.org_id = dol.d_org_id and dol.p_date = $date$
  join dw_erp_d_customer_base cust on dwejobcandidate.customer_id = cust.id and cust.p_date = $date$ and cust.rsc_valid_status = 1
  where dwejobcandidate.p_date = $date$
  and substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$
  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)
) candidate
on  rps_renewal.org_id = candidate.org_id
full join 
(
	select coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
		   sum(is_intention) as consume_intention_cust_cnt,
		   sum(is_intention) / sum(1) as  consume_intention_cust_ratio,
		   sum(is_msk) as consume_msk_cust_cnt,
		   sum(is_msk) / sum(1) as  consume_msk_cust_ratio,
		   sum(is_invite) as consume_invite_cust_cnt,
		   sum(is_invite) / sum(1) as  consume_invite_cust_ratio,
		   sum(is_urgent) as consume_urgent_cust_cnt,
		   sum(is_urgent) / sum(1) as  consume_urgent_cust_ratio,
		   sum(is_download_cv) as consume_cv_cust_cnt,
		   sum(is_download_cv) / sum(1) as consume_cv_cust_ratio,
		   sum(is_warn_resource_consume_cust_cnt) as warn_resource_consume_cust_cnt
	  from dw_erp_d_customer_base base
	  left join 
	  ( select customer_id,
		   		   case when sum(download_cv_cnt) > 0 then 1  else 0 end as is_download_cv,
				   case when sum(intention_cnt) > 0 then 1  else 0 end as is_intention,
				   case when sum(msk_cnt) > 0 then 1  else 0 end as is_msk,
				   case when sum(invite_cnt) > 0 then 1  else 0 end as is_invite,
				   case when sum(urgent_cnt) > 0 then 1 else 0 end as is_urgent,
				   case when sum(case when p_date = $date$ then consume_cv_total_cnt else 0 end) > 50 and 
				   sum(case when p_date = $date$ then day30_consume_cv_total_cnt else 0 end)  = 0 then 1 else 0 end as is_warn_resource_consume_cust_cnt
		     from dw_erp_d_customer_rps_act
		    where p_date between  {{date[:6]+'01'}} and $date$ 
		    group by customer_id
			) act 	  
	  on act.customer_id = base.id
	  join dim_org_level dol on base.service_teamorg_id = dol.d_org_id and dol.p_date = $date$
	  where base.p_date = $date$ 
	    and base.rps_service_version = 1 
	    and base.rsc_valid_status = 1
	  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
	  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)
) consume 
on  rps_renewal.org_id = consume.org_id
full join
(
	select coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
		   sum(case when msk.status in (1,3) then showup_cnt else 0 end) as mtd_msk_showup_cnt,
		   count(case when msk.is_delegation = 1 and msk.delegation_consultant_type = 1 and msk.status = 0 then cust.id else null end) as msk_assess_cnt
	  from dw_god_d_msk_service msk
	  left join (
	  		select god_service_id,sum(showup_cnt) as showup_cnt
	  		from dw_god_d_msk_service_order_index
	  		where p_date between {{date[:6]+'01'}} and $date$  
	  		 and consultant_type = 1
	  		group by god_service_id
	  	) msk_order
	  on msk.god_service_id = msk_order.god_service_id
	  join dw_erp_d_customer_base cust 
	  on msk.ecomp_root_id = cust.ecomp_root_id
	  and cust.p_date = $date$
	  and cust.rsc_valid_status = 1
	  join dim_org_level dol on cust.service_teamorg_id = dol.d_org_id and dol.p_date = $date$
	 where msk.status in (1,3,0)
	  and msk.p_date = $date$
	  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
	  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)	 
) msk 
on rps_renewal.org_id = msk.org_id
full join 
(
	select coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
		   sum(teamorg.rps_user_cnt) as rps_user_cnt,
		   sum(teamorg.avg_rps_user_cnt) as avg_rps_user_cnt
	from (
		select teamorg.service_teamorg_id as org_id,
			   sum(case when p_date = $date$ then teamorg.rps_user_cnt else 0 end) as rps_user_cnt,
			   avg(teamorg.rps_user_cnt) as avg_rps_user_cnt
		from (
		 select base.p_date,base.service_teamorg_id,count(distinct base.serviceuser_id) as rps_user_cnt
		   from dw_erp_d_customer_base base
		   join dw_erp_d_salesuser_base suser
		   on base.serviceuser_id = suser.id 
		   and base.p_date = suser.p_date
		   and suser.position_channel <> 'A0000681' --排除GCDC运营
		  where base.p_date  between  {{date[:6]+'01'}} and $date$ 
		      and base.rps_service_version = 1
		      and base.rsc_valid_status = 1 
		   group by base.p_date,base.service_teamorg_id
		 ) teamorg 
		group by service_teamorg_id
	) teamorg 
	join dim_org_level dol on teamorg.org_id = dol.d_org_id and dol.p_date = $date$
	  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
	  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)	  	
) user_cnt
on rps_renewal.org_id = user_cnt.org_id
group by coalesce(rps_renewal.org_id,rps_call.org_id,rps_consume.org_id,consume.org_id,msk.org_id,user_cnt.org_id,candidate.org_id)
) rpsorg_act 

join dim_org_level dol 
on rpsorg_act.org_id = dol.d_org_id
and dol.p_date = $date$
join (
 select  int(substr('$date$',7,2)) / int(substr(last_day(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-','01')),9,2)) as time_schedule_ratio 
   from dummy) dt on 1=1;


create table dw_erp_d_rpsorg_act_detail (
d_date	int	comment '统计日期',
rps_user_id int comment '招聘服务顾问id',
rps_user_name string comment '招聘服务顾问姓名',
org_id	int	comment '招聘服务小组id',
org_name	string	comment '招聘服务小组名称',
org_grade int comment '组织级次',
is_last int comment '是否末级节点',
parent_org_id	int	comment '上级招聘服务小组id',
parent_org_name	string	comment '上级招聘服务小组名称',
time_schedule_ratio float comment '时间进度',
cust_consume_cv_target_cnt	int	comment '日目标消耗简历',
cust_consume_cv_cnt	int	comment '日已消耗简历',
gcdc_valid_call_cnt	int	comment '日有效通话个数',
gcdc_valid_call_timelong	int	comment '日有效通话时长',
rps_cust_cover_cnt	int	comment '日客户覆盖数',
cust_return_visit_cnt int comment '客户回访',
ejob_to_bole_manual_cnt int comment '需伯乐推荐职位数',
ejob_to_rps_manual_cnt int comment '需rps推荐职位数',
ejob_to_rps_bole_manual_cnt int comment '需伯乐和rps推荐职位数',
ejob_to_rps_bole_manual_cover_cnt int comment '需求职位覆盖数',
consume_intention_cust_cnt int comment '意向沟通使用客户数',
consume_intention_cust_ratio float comment '意向沟通使用比例',
consume_msk_cust_cnt int comment '面试快使用客户数',
consume_msk_cust_ratio float comment '面试快使用比例',
consume_invite_cust_cnt int comment '邀请应聘使用客户数',
consume_invite_cust_ratio float comment '邀请应聘使用比例',
consume_urgent_cust_cnt int comment '急聘使用客户数',
consume_urgent_cust_ratio float comment '急聘使用比例', 
consume_cv_cust_cnt int comment '简历下载使用客户数',
consume_cv_cust_ratio float comment '简历下载使用比例',
mtd_consume_cv_cnt	int	comment '本月累计客户消耗的简历数',
mtd_consume_cv_target_cnt	int	comment '本月累计目标消耗简历数',
mtd_consume_cv_ratio	float	comment '简历消耗率',
mtd_gcdc_valid_call_cnt	int	comment '本月累计有效通话个数',
mtd_gcdc_valid_call_timelong int comment '本月累计有效通话时长',
mtd_cust_cover_cnt	int	comment '本月累计覆盖客户数',
cust_cnt	int	comment '名下客户数',
mtd_cust_no_cover_cnt	int	comment '当月未覆盖客户数',
mtd_cust_cover_ratio	float	comment '客户覆盖率',
mtd_expire_renewal_cust_cnt	int	comment '当月合同到期当月续约的客户数',
mtd_n_expire_renewal_cust_cnt	int	comment '当月合同未到期 提前在当月续约的客户数',
mtd_expire_cust_cnt	int	comment '当月到期的客户数',
mtd_expire_p_renewal_cust_cnt	int	comment '当月到期客户数中已经提前续约的客户',
mtd_contract_renewal_ratio	float	comment '合同期内续约率',
mtd_rps_recommend_cv_cnt int comment '本月人工推荐简历数',
mtd_rps_recommend_satisfied_cv_cnt int comment '本月人工推荐简历满意数',
mtd_bole_recommend_cv_cnt int comment '本月伯乐推荐简历数',
mtd_bole_recommend_satisfied_cv_cnt int comment '本月伯乐推荐简历满意数',
mtd_recommend_deal_cv_cnt	int	comment '本月推荐且已处理简历数',
mtd_recommend_cv_cnt	int	comment '本月累计推荐简历数',
mtd_recommend_cv_deal_ratio	float	comment '简历处理率',
mtd_recommend_satisfied_cv_cnt	int	comment '本月累计推荐简历满意数',
mtd_msk_showup_cnt	int	comment '本月累计面试快已到场人数',
callplan_no_finish_cnt	int	comment '拨打计划未完成',
task_no_finish_cnt	int	comment '待办任务',
intention_no_release_cnt	int	comment '意向沟通未释放',
intention_no_submit_cnt	int	comment '意向沟通未提交',
ejob_no_label_cnt	int	comment '待标记职位',
ejob_no_tag_cnt int comment '待标签职位',
ejob_recommend_to_manual_cnt	int	comment '需rps介入职位',
ejob_7day_recommend_undeal_cnt	int	comment '近7天推荐未处理职位',
msk_assess_cnt	int	comment '面试快委托未跟进',
cust_break_cnt	int	comment '断约客户',
cust_renewal_cnt	int	comment '已续约客户',
cust_3month_renewal_cnt	int	comment '近3个月新签客户数',
cust_3month_expire_cnt	int	comment '3个月到期客户数',
cust_renewal_high_cnt	int	comment '续约意向度高',
cust_renewal_mid_cnt	int	comment '续约意向度中',
cust_renewal_low_cnt	int	comment '续约意向度低',
cust_renewal_none_cnt	int	comment '续约意向度无',
creation_timestamp	timestamp	comment '时间戳'
) comment '招服组织行为表-含各级组织，指标不可聚合'
partitioned by (p_date int);


create table dw_erp_d_rpsorg_act_detail (
d_date	int	comment '统计日期',
rps_user_id int comment '招聘服务顾问id',
rps_user_name varchar(100) comment '招聘服务顾问姓名',
org_id	int	comment '招聘服务小组id',
org_name varchar(100) comment '招聘服务小组名称',
org_grade int comment '组织级次',
is_last int comment '是否末级节点',
parent_org_id int comment '上级招聘服务小组id',
parent_org_name	varchar(100) comment '上级招聘服务小组名称',
time_schedule_ratio float comment '时间进度',
cust_consume_cv_target_cnt	int	comment '日目标消耗简历',
cust_consume_cv_cnt	int	comment '日已消耗简历',
gcdc_valid_call_cnt	int	comment '日有效通话个数',
gcdc_valid_call_timelong	int	comment '日有效通话时长',
rps_cust_cover_cnt	int	comment '日客户覆盖数',
cust_return_visit_cnt int comment '客户回访',
ejob_to_bole_manual_cnt int comment '需伯乐推荐职位数',
ejob_to_rps_manual_cnt int comment '需rps推荐职位数',
ejob_to_rps_bole_manual_cnt int comment '需伯乐和rps推荐职位数',
ejob_to_rps_bole_manual_cover_cnt int comment '需求职位覆盖数',
consume_intention_cust_cnt int comment '意向沟通使用客户数',
consume_intention_cust_ratio float comment '意向沟通使用比例',
consume_msk_cust_cnt int comment '面试快使用客户数',
consume_msk_cust_ratio float comment '面试快使用比例',
consume_invite_cust_cnt int comment '邀请应聘使用客户数',
consume_invite_cust_ratio float comment '邀请应聘使用比例',
consume_urgent_cust_cnt int comment '急聘使用客户数',
consume_urgent_cust_ratio float comment '急聘使用比例', 
consume_cv_cust_cnt int comment '简历下载使用客户数',
consume_cv_cust_ratio float comment '简历下载使用比例',
mtd_consume_cv_cnt	int	comment '本月累计客户消耗的简历数',
mtd_consume_cv_target_cnt	int	comment '本月累计目标消耗简历数',
mtd_consume_cv_ratio	float	comment '简历消耗率',
mtd_gcdc_valid_call_cnt	int	comment '本月累计有效通话个数',
mtd_gcdc_valid_call_timelong int comment '本月累计有效通话时长',
mtd_cust_cover_cnt	int	comment '本月累计覆盖客户数',
cust_cnt	int	comment '名下客户数',
mtd_cust_no_cover_cnt	int	comment '当月未覆盖客户数',
mtd_cust_cover_ratio	float	comment '客户覆盖率',
mtd_expire_renewal_cust_cnt	int	comment '当月合同到期当月续约的客户数',
mtd_n_expire_renewal_cust_cnt	int	comment '当月合同未到期 提前在当月续约的客户数',
mtd_expire_cust_cnt	int	comment '当月到期的客户数',
mtd_expire_p_renewal_cust_cnt	int	comment '当月到期客户数中已经提前续约的客户',
mtd_contract_renewal_ratio	float	comment '合同期内续约率',
mtd_rps_recommend_cv_cnt int comment '本月人工推荐简历数',
mtd_rps_recommend_satisfied_cv_cnt int comment '本月人工推荐简历满意数',
mtd_bole_recommend_cv_cnt int comment '本月伯乐推荐简历数',
mtd_bole_recommend_satisfied_cv_cnt int comment '本月伯乐推荐简历满意数',
mtd_recommend_deal_cv_cnt	int	comment '本月推荐且已处理简历数',
mtd_recommend_cv_cnt	int	comment '本月累计推荐简历数',
mtd_recommend_cv_deal_ratio	float	comment '简历处理率',
mtd_recommend_satisfied_cv_cnt	int	comment '本月累计推荐简历满意数',
mtd_msk_showup_cnt	int	comment '本月累计面试快已到场人数',
callplan_no_finish_cnt	int	comment '拨打计划未完成',
task_no_finish_cnt	int	comment '待办任务',
intention_no_release_cnt	int	comment '意向沟通未释放',
intention_no_submit_cnt	int	comment '意向沟通未提交',
ejob_no_label_cnt	int	comment '待标记职位',
ejob_no_tag_cnt int comment '待标签职位',
ejob_recommend_to_manual_cnt	int	comment '需rps介入职位',
ejob_7day_recommend_undeal_cnt	int	comment '近7天推荐未处理职位',
msk_assess_cnt	int	comment '面试快委托未跟进',
cust_break_cnt	int	comment '断约客户',
cust_renewal_cnt	int	comment '已续约客户',
cust_3month_renewal_cnt	int	comment '近3个月新签客户数',
cust_3month_expire_cnt	int	comment '3个月到期客户数',
cust_renewal_high_cnt	int	comment '续约意向度高',
cust_renewal_mid_cnt	int	comment '续约意向度中',
cust_renewal_low_cnt	int	comment '续约意向度低',
cust_renewal_none_cnt	int	comment '续约意向度无',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,rps_user_id,org_id)
) comment '招服组织行为表-含各级组织，指标不可聚合';

insert overwrite table dw_erp_d_rpsorg_act_detail partition (p_date = $date$)
select
$date$ as d_date,
rps_user.id as rps_user_id,
rps_user.name as rps_user_name,
fact1.org_id as org_id,
dim_org_level.org_name as org_name,
nvl(dim_org_level.grade,-1) as org_grade ,
nvl(dim_org_level.is_last,-1) as is_last ,
nvl(dim_org_level.parent_id,-1) as parent_org_id ,
nvl(dim_org_level.parent_name,-1) as parent_org_name,
dt.time_schedule_ratio ,
fact1.cust_consume_cv_target_cnt as cust_consume_cv_target_cnt,
fact1.cust_consume_cv_cnt as cust_consume_cv_cnt,
fact1.gcdc_valid_call_cnt as gcdc_valid_call_cnt,
fact1.gcdc_valid_call_timelong as gcdc_valid_call_timelong,
fact1.rps_cust_cover_cnt as rps_cust_cover_cnt,
fact1.cust_return_visit_cnt as cust_return_visit_cnt,
fact1.ejob_to_bole_manual_cnt as ejob_to_bole_manual_cnt,
fact1.ejob_to_rps_manual_cnt as ejob_to_rps_manual_cnt,
fact1.ejob_to_rps_bole_manual_cnt as ejob_to_rps_bole_manual_cnt,
fact1.ejob_to_rps_bole_manual_cover_cnt as ejob_to_rps_bole_manual_cover_cnt,
fact1.consume_intention_cust_cnt as consume_intention_cust_cnt,
fact1.consume_intention_cust_ratio as consume_intention_cust_ratio,
fact1.consume_msk_cust_cnt as consume_msk_cust_cnt,
fact1.consume_msk_cust_ratio as consume_msk_cust_ratio,
fact1.consume_invite_cust_cnt as consume_invite_cust_cnt,
fact1.consume_invite_cust_ratio as consume_invite_cust_ratio,
fact1.consume_urgent_cust_cnt as consume_urgent_cust_cnt,
fact1.consume_urgent_cust_ratio as consume_urgent_cust_ratio,
fact1.consume_cv_cust_cnt as consume_cv_cust_cnt,
fact1.consume_cv_cust_ratio as consume_cv_cust_ratio,
fact1.mtd_consume_cv_cnt as mtd_consume_cv_cnt,
fact1.mtd_consume_cv_target_cnt as mtd_consume_cv_target_cnt,
fact1.mtd_consume_cv_ratio as mtd_consume_cv_ratio,
fact1.mtd_gcdc_valid_call_cnt as mtd_gcdc_valid_call_cnt,
fact1.mtd_gcdc_valid_call_timelong as mtd_gcdc_valid_call_timelong,
fact1.mtd_cust_cover_cnt as mtd_cust_cover_cnt,
fact1.cust_cnt as cust_cnt,
fact1.mtd_cust_no_cover_cnt as mtd_cust_no_cover_cnt,
fact1.mtd_cust_cover_ratio as mtd_cust_cover_ratio,
fact1.mtd_expire_renewal_cust_cnt as mtd_expire_renewal_cust_cnt,
fact1.mtd_n_expire_renewal_cust_cnt as mtd_n_expire_renewal_cust_cnt,
fact1.mtd_expire_cust_cnt as mtd_expire_cust_cnt,
fact1.mtd_expire_p_renewal_cust_cnt as mtd_expire_p_renewal_cust_cnt,
fact1.mtd_contract_renewal_ratio as mtd_contract_renewal_ratio,
fact1.mtd_rps_recommend_cv_cnt as mtd_rps_recommend_cv_cnt,
fact1.mtd_rps_recommend_satisfied_cv_cnt as mtd_rps_recommend_satisfied_cv_cnt,
fact1.mtd_bole_recommend_cv_cnt as mtd_bole_recommend_cv_cnt,
fact1.mtd_bole_recommend_satisfied_cv_cnt as mtd_bole_recommend_satisfied_cv_cnt,
fact1.mtd_recommend_deal_cv_cnt as mtd_recommend_deal_cv_cnt,
fact1.mtd_recommend_cv_cnt as mtd_recommend_cv_cnt,
fact1.mtd_recommend_cv_deal_ratio as mtd_recommend_cv_deal_ratio,
fact1.mtd_recommend_satisfied_cv_cnt as mtd_recommend_satisfied_cv_cnt,
fact1.mtd_msk_showup_cnt as mtd_msk_showup_cnt,
fact1.callplan_no_finish_cnt as callplan_no_finish_cnt,
fact1.task_no_finish_cnt as task_no_finish_cnt,
fact1.intention_no_release_cnt as intention_no_release_cnt,
fact1.intention_no_submit_cnt as intention_no_submit_cnt,
fact1.ejob_no_label_cnt as ejob_no_label_cnt,
fact1.ejob_no_tag_cnt as ejob_no_tag_cnt,
fact1.ejob_recommend_to_manual_cnt as ejob_recommend_to_manual_cnt,
fact1.ejob_7day_recommend_undeal_cnt as ejob_7day_recommend_undeal_cnt,
fact1.msk_assess_cnt as msk_assess_cnt,
fact1.cust_break_cnt as cust_break_cnt,
fact1.cust_renewal_cnt as cust_renewal_cnt,
fact1.cust_3month_renewal_cnt as cust_3month_renewal_cnt,
fact1.cust_3month_expire_cnt as cust_3month_expire_cnt,
fact1.cust_renewal_high_cnt as cust_renewal_high_cnt,
fact1.cust_renewal_mid_cnt as cust_renewal_mid_cnt,
fact1.cust_renewal_low_cnt as cust_renewal_low_cnt,
fact1.cust_renewal_none_cnt as cust_renewal_none_cnt,
from_unixtime(unix_timestamp()) as creation_timestamp,
fact1.warn_resource_consume_cust_cnt as warn_resource_consume_cust_cnt
from (
    select 
    coalesce(rps_renewal.rps_user_id,consume.rps_user_id,msk.rps_user_id,candidate.rps_user_id,rps_call.rps_user_id,rps_consume.rps_user_id) as rps_user_id,
    coalesce(rps_renewal.org_id,consume.org_id,msk.org_id,candidate.org_id,rps_call.org_id,rps_consume.org_id) as org_id,
    nvl(sum(rps_consume.cust_consume_cv_target_cnt),0) as cust_consume_cv_target_cnt,
    nvl(sum(rps_consume.cust_consume_cv_cnt),0) as cust_consume_cv_cnt,
    nvl(sum(rps_call.gcdc_valid_call_cnt),0) as gcdc_valid_call_cnt,
    nvl(sum(rps_call.gcdc_valid_call_timelong),0) as gcdc_valid_call_timelong,
    nvl(sum(rps_call.rps_cust_cover_cnt),0) as rps_cust_cover_cnt,
    0 as cust_return_visit_cnt ,
    0 as ejob_to_bole_manual_cnt ,
    0 as ejob_to_rps_manual_cnt ,
    0 as ejob_to_rps_bole_manual_cnt ,
    0 as ejob_to_rps_bole_manual_cover_cnt ,
    nvl(sum(consume.consume_intention_cust_cnt),0) as consume_intention_cust_cnt ,
    nvl(sum(consume.consume_intention_cust_ratio),0) as consume_intention_cust_ratio ,
    nvl(sum(consume.consume_msk_cust_cnt),0) as consume_msk_cust_cnt ,
    nvl(sum(consume.consume_msk_cust_ratio),0) as consume_msk_cust_ratio ,
    nvl(sum(consume.consume_invite_cust_cnt),0) as consume_invite_cust_cnt ,
    nvl(sum(consume.consume_invite_cust_ratio),0) as consume_invite_cust_ratio ,
    nvl(sum(consume.consume_urgent_cust_cnt),0) as consume_urgent_cust_cnt ,
    nvl(sum(consume.consume_urgent_cust_ratio),0) as consume_urgent_cust_ratio ,
    nvl(sum(consume.consume_cv_cust_cnt),0) as consume_cv_cust_cnt ,
    nvl(sum(consume.consume_cv_cust_ratio),0) as consume_cv_cust_ratio ,
    nvl(sum(rps_consume.mtd_consume_cv_cnt),0) as mtd_consume_cv_cnt,
    nvl(sum(rps_consume.mtd_consume_cv_target_cnt),0) as mtd_consume_cv_target_cnt,
    nvl(sum(rps_consume.mtd_consume_cv_ratio),0) as mtd_consume_cv_ratio,
    nvl(sum(rps_call.mtd_gcdc_valid_call_cnt),0) as mtd_gcdc_valid_call_cnt,
    nvl(sum(rps_call.mtd_gcdc_valid_call_timelong),0) as mtd_gcdc_valid_call_timelong ,
    nvl(sum(rps_call.mtd_cust_cover_cnt),0) as mtd_cust_cover_cnt,
    nvl(sum(rps_call.cust_cnt),0) as cust_cnt,
    nvl(sum(rps_call.cust_cnt) - sum(rps_call.mtd_cust_cover_cnt),0) as mtd_cust_no_cover_cnt,
    nvl(sum(rps_call.mtd_cust_cover_cnt) / sum(rps_call.cust_cnt),0) as mtd_cust_cover_ratio,
    nvl(sum(rps_renewal.mtd_expire_renewal_cust_cnt),0) as mtd_expire_renewal_cust_cnt,
    nvl(sum(rps_renewal.mtd_n_expire_renewal_cust_cnt),0) as mtd_n_expire_renewal_cust_cnt,
    nvl(sum(rps_renewal.mtd_expire_cust_cnt),0) as mtd_expire_cust_cnt,
    nvl(sum(rps_renewal.mtd_expire_p_renewal_cust_cnt),0) as mtd_expire_p_renewal_cust_cnt,
    nvl(sum(rps_renewal.mtd_contract_renewal_ratio),0) as mtd_contract_renewal_ratio,
    nvl(sum(candidate.mtd_rps_recommend_cv_cnt),0) as mtd_rps_recommend_cv_cnt ,
    nvl(sum(candidate.mtd_rps_recommend_satisfied_cv_cnt),0) as mtd_rps_recommend_satisfied_cv_cnt ,
    nvl(sum(candidate.mtd_bole_recommend_cv_cnt),0) as mtd_bole_recommend_cv_cnt ,
    nvl(sum(candidate.mtd_bole_recommend_satisfied_cv_cnt),0) as mtd_bole_recommend_satisfied_cv_cnt ,
    nvl(sum(candidate.mtd_recommend_deal_cv_cnt),0) as mtd_recommend_deal_cv_cnt,
    nvl(sum(candidate.mtd_recommend_cv_cnt),0) as mtd_recommend_cv_cnt,
    nvl(sum(candidate.mtd_recommend_cv_deal_ratio),0) as mtd_recommend_cv_deal_ratio,
    nvl(sum(candidate.mtd_recommend_satisfied_cv_cnt),0) as mtd_recommend_satisfied_cv_cnt,
    nvl(sum(msk.mtd_msk_showup_cnt),0) as mtd_msk_showup_cnt,
    0 as callplan_no_finish_cnt,
    0 as task_no_finish_cnt,
    0 as intention_no_release_cnt,
    0 as intention_no_submit_cnt,
    0 as ejob_no_label_cnt,
    0 as ejob_no_tag_cnt,
    0 as ejob_recommend_to_manual_cnt,
    0 as ejob_7day_recommend_undeal_cnt,
    nvl(sum(msk.msk_assess_cnt),0) as msk_assess_cnt,
    0 as cust_break_cnt,
    0 as cust_renewal_cnt,
    0 as cust_3month_renewal_cnt,
    0 as cust_3month_expire_cnt,
    0 as cust_renewal_high_cnt,
    0 as cust_renewal_mid_cnt,
    0 as cust_renewal_low_cnt,
    0 as cust_renewal_none_cnt,
    nvl(sum(consume.warn_resource_consume_cust_cnt),0) as warn_resource_consume_cust_cnt
    from 
    (
        select rps_user_id,org_id,
        	   sum(expire_renewal_cust_cnt) as mtd_expire_renewal_cust_cnt,
        	   sum(pre_expire_renewal_cust_cnt) as mtd_n_expire_renewal_cust_cnt,
        	   sum(expire_cust_cnt) as mtd_expire_cust_cnt,
        	   sum(expire_pre_renewal_cust_cnt) as mtd_expire_p_renewal_cust_cnt,
      		  (sum(expire_renewal_cust_cnt) +sum(pre_expire_renewal_cust_cnt)) / (sum(expire_cust_cnt)-sum(expire_pre_renewal_cust_cnt)+ sum(pre_expire_renewal_cust_cnt))  as mtd_contract_renewal_ratio	
          from fact_h_gcdc_d_renewal_rpsuser
         where d_date = $date$
         group by rps_user_id,org_id       
    ) rps_renewal
    full join 
    (
      select 
          base.serviceuser_id as rps_user_id,
          base.service_teamorg_id as org_id,
    	  sum(mtd_gcdc_valid_call_timelong) as mtd_gcdc_valid_call_timelong,
    	  sum(mtd_gcdc_valid_call_cnt) as mtd_gcdc_valid_call_cnt,
    	  count(distinct case when mtd_gcdc_valid_call_cnt > 0 then  call.customer_id else null end) as mtd_cust_cover_cnt,
    	  sum(gcdc_valid_call_timelong) as gcdc_valid_call_timelong,
    	  sum(gcdc_valid_call_cnt) as gcdc_valid_call_cnt,
    	  count(distinct case when gcdc_valid_call_cnt > 0 then call.customer_id else null end) as rps_cust_cover_cnt,
          count(distinct base.id) as cust_cnt
      from dw_erp_d_customer_base base
      left join 
      (select 
       org_id, 
       creator_id,
        customer_id,
        sum(time_long)/60  as mtd_gcdc_valid_call_timelong,
        count(1) as mtd_gcdc_valid_call_cnt,
        count(distinct customer_id) as mtd_cust_cover_cnt,
        sum(case when call_date = $date$ then time_long else 0 end) / 60 as gcdc_valid_call_timelong,
        sum(case when call_date = $date$ then 1 else 0 end)  as gcdc_valid_call_cnt
      from call_record
      where call_date between  {{date[:6]+'01'}} and $date$ 
      and deleteflag = 0 
      and time_long > 60
      and customer_id > 0
      and call_type=0
      group by org_id,creator_id,customer_id
      ) call 
      on  call.customer_id = base.id
      and call.creator_id = base.serviceuser_id
      and call.org_id = base.service_teamorg_id
      where  base.p_date = $date$ 
      and base.rps_service_version = 1
      and base.rsc_valid_status = 1
      group by base.service_teamorg_id,base.serviceuser_id
    ) rps_call
    on rps_renewal.rps_user_id = rps_call.rps_user_id
    and  rps_renewal.org_id = rps_call.org_id
    full join 
    (
      select  
          suser_act.serviceuser_id as rps_user_id,
          suser_act.service_teamorg_id as org_id,
          suser_act.mtd_consume_cv_cnt as mtd_consume_cv_cnt,
          suser_act.mtd_consume_cv_target_cnt as mtd_consume_cv_target_cnt,
          suser_act.mtd_consume_cv_cnt / suser_act.mtd_consume_cv_target_cnt as mtd_consume_cv_ratio,
          suser_act.cust_consume_cv_cnt,
          suser_act.cust_consume_cv_target_cnt
       from (
            select 
            base.service_teamorg_id,
            base.serviceuser_id,
            sum(case when act.p_date = $date$ then  consume_cv_total_cnt+exchange_cv2lowcv else 0 end) as cust_consume_cv_cnt,
            sum(act.consume_cv_total_cnt+act.exchange_cv2lowcv) as mtd_consume_cv_cnt,
            sum((case when target.left_cnt > 0 then target.day_consume_cv_target_cnt else 0 end) * holiday.is_workday) as mtd_consume_cv_target_cnt,
            sum(case when base.p_date = $date$ then target.day_consume_cv_target_cnt else 0 end) as cust_consume_cv_target_cnt
          from dw_erp_d_customer_base base 
          left join dw_erp_d_customer_consume_target target 
          on base.id = target.customer_id
          and base.p_date = target.p_date
          left join dw_erp_d_customer_act act 
          on base.id = act.customer_id
          and base.p_date = act.p_date
          join dim_date_holiday holiday on base.p_date = holiday.d_date
          where base.p_date  between  {{date[:6]+'01'}} and $date$ 
          and base.rps_service_version = 1
          and base.rsc_valid_status = 1 
          group by base.service_teamorg_id,base.serviceuser_id
       ) suser_act
    ) rps_consume
    on  rps_renewal.rps_user_id = rps_consume.rps_user_id
    and  rps_renewal.org_id = rps_consume.org_id
    full join 
    (
      select
        dwejobcandidate.org_id,dwejobcandidate.serviceuser_id as rps_user_id,
        count(case when dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_rps_recommend_cv_cnt,
        count(case when dwejobcandidate.source = 4 then dwejobcandidate.id else null end) as mtd_bole_recommend_cv_cnt,
        count(dwejobcandidate.id) as mtd_recommend_cv_cnt,
        count(case when dwejobcandidate.feedback in (4,2,5) and dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_rps_recommend_satisfied_cv_cnt,
        count(case when dwejobcandidate.feedback in (4,2,5) and dwejobcandidate.source = 4 then dwejobcandidate.id else null end) as mtd_bole_recommend_satisfied_cv_cnt,
        count(case when dwejobcandidate.feedback in (4,2,5) then dwejobcandidate.id else null end) as mtd_recommend_satisfied_cv_cnt,
        count(case when dwejobcandidate.feedback <> 1 then dwejobcandidate.id else null end) as mtd_recommend_deal_cv_cnt,
        count(case when dwejobcandidate.feedback <> 1 and dwejobcandidate.source = 0 then dwejobcandidate.id else null end) / count(case when dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_recommend_cv_deal_ratio
      from  dw_erp_d_ejob_candidate dwejobcandidate 
      join dw_erp_d_customer_base cust on dwejobcandidate.customer_id = cust.id and cust.p_date = $date$ and cust.rps_service_version = 1 and cust.rsc_valid_status = 1 
      where dwejobcandidate.p_date = $date$
      and dwejobcandidate.source in (0,4)
      and substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$
      group by dwejobcandidate.org_id,dwejobcandidate.serviceuser_id
    ) candidate
    on  rps_renewal.org_id = candidate.org_id
    and rps_renewal.rps_user_id = candidate.rps_user_id
    full join 
    (
    	select base.serviceuser_id as rps_user_id,
    		   base.service_teamorg_id as org_id,
    		   sum(is_intention) as consume_intention_cust_cnt,
    		   sum(is_intention) / sum(1) as  consume_intention_cust_ratio,
    		   sum(is_msk) as consume_msk_cust_cnt,
    		   sum(is_msk) / sum(1) as  consume_msk_cust_ratio,
    		   sum(is_invite) as consume_invite_cust_cnt,
    		   sum(is_invite) / sum(1) as  consume_invite_cust_ratio,
    		   sum(is_urgent) as consume_urgent_cust_cnt,
    		   sum(is_urgent) / sum(1) as  consume_urgent_cust_ratio,
    		   sum(is_download_cv) as consume_cv_cust_cnt,
    		   sum(is_download_cv) / sum(1) as consume_cv_cust_ratio,
    		   sum(is_warn_resource_consume_cust_cnt) as warn_resource_consume_cust_cnt
    	  from dw_erp_d_customer_base base
    	  left join 
    	  ( select customer_id,
    		   		   case when sum(download_cv_cnt) > 0 then 1  else 0 end as is_download_cv,
    				   case when sum(intention_cnt) > 0 then 1  else 0 end as is_intention,
    				   case when sum(msk_cnt) > 0 then 1  else 0 end as is_msk,
    				   case when sum(invite_cnt) > 0 then 1  else 0 end as is_invite,
    				   case when sum(urgent_cnt) > 0 then 1 else 0 end as is_urgent,
    				   case when sum(case when p_date = $date$ then consume_cv_total_cnt else 0 end) > 50 and 
    				   sum(case when p_date = $date$ then day30_consume_cv_total_cnt else 0 end)  = 0 then 1 else 0 end as is_warn_resource_consume_cust_cnt
    		     from dw_erp_d_customer_rps_act
    		    where p_date between  {{date[:6]+'01'}} and $date$ 
    		    group by customer_id
    			) act 	  
    	  on act.customer_id = base.id
    	  where base.p_date = $date$ 
    	    and base.rps_service_version = 1
    	    and base.rsc_valid_status = 1	 
    	  group by base.serviceuser_id ,
    	  		   base.service_teamorg_id
    ) consume 
    on  rps_renewal.rps_user_id = consume.rps_user_id
    and  rps_renewal.org_id = consume.org_id
    full join
    (
    	select cust.service_teamorg_id as org_id ,cust.serviceuser_id as rps_user_id,
    		   sum(case when msk.status in (1,3) then showup_cnt else 0 end) as mtd_msk_showup_cnt,
    		   count(case when msk.is_delegation = 1 and msk.delegation_consultant_type = 1 and msk.status = 0 then cust.id else null end) as msk_assess_cnt
    	  from dw_god_d_msk_service msk
    	  left join (
    	  		select god_service_id,sum(showup_cnt) as showup_cnt
    	  		from dw_god_d_msk_service_order_index
    	  		where p_date between {{date[:6]+'01'}} and $date$  
    	  		 and consultant_type = 1
    	  		group by god_service_id
    	  	) msk_order
    	  on msk.god_service_id = msk_order.god_service_id
    	  join dw_erp_d_customer_base cust 
    	  on msk.ecomp_root_id = cust.ecomp_root_id
    	  and cust.p_date = $date$
    	  and cust.rps_service_version = 1
    	  and cust.rsc_valid_status = 1
    	 where msk.status in (1,3,0)
    	  and msk.p_date = $date$
    	  group by cust.service_teamorg_id ,cust.serviceuser_id
    ) msk 
    on rps_renewal.org_id = msk.org_id
    and rps_renewal.rps_user_id = msk.rps_user_id
   
    group by coalesce(rps_renewal.rps_user_id,consume.rps_user_id,msk.rps_user_id,candidate.rps_user_id,rps_call.rps_user_id,rps_consume.rps_user_id),
    		 coalesce(rps_renewal.org_id,consume.org_id,msk.org_id,candidate.org_id,rps_call.org_id,rps_consume.org_id)
) fact1
join dw_erp_d_salesuser_base rps_user 
on  fact1.rps_user_id= rps_user.id 
and rps_user.p_date = $date$
join dim_org_level on fact1.org_id = dim_org_level.d_org_id and dim_org_level.p_date = $date$
join (
 select  int(substr('$date$',7,2)) / int(substr(last_day(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-','01')),9,2)) as time_schedule_ratio 
   from dummy) dt on 1=1;


create table dw_erp_d_rpsorg_act_detail_median (
d_date	int	comment '统计日期',
mtd_consume_cv_ratio float comment '简历消耗率', 
mtd_cust_cover_ratio float comment '客户电话覆盖率', 
mtd_contract_renewal_ratio float comment '合同期内续约率', 
mtd_recommend_cv_deal_ratio float comment '简历处理率', 
creation_timestamp  timestamp 
) comment '招服顾问月度比率全国中位数'
partitioned by (p_date int);

create table dw_erp_d_rpsorg_act_detail_median (
d_date	int	comment '统计日期',
mtd_consume_cv_ratio float comment '简历消耗率', 
mtd_cust_cover_ratio float comment '客户电话覆盖率', 
mtd_contract_renewal_ratio float comment '合同期内续约率', 
mtd_recommend_cv_deal_ratio float comment '简历处理率', 
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date)
) comment '招服顾问月度比率全国中位数';

insert overwrite table dw_erp_d_rpsorg_act_detail_median partition (p_date = $date$)
select 
$date$ as d_date,
percentile_approx(act.mtd_consume_cv_ratio,0.5),
percentile_approx(act.mtd_cust_cover_ratio,0.5),
percentile_approx(act.mtd_contract_renewal_ratio,0.5),
percentile_approx(act.mtd_recommend_cv_deal_ratio,0.5),
from_unixtime(unix_timestamp()) as creation_timestamp
from dw_erp_d_rpsuser_act act 
join 
(select serviceuser_id
   from dw_erp_d_customer_base
  where p_date = $date$
    and rps_service_version in (1,3)
    and rsc_valid_status = 1
    group by serviceuser_id) suser 
on act.rps_user_id = suser.serviceuser_id
where p_date = $date$;


rank_type int comment '排名对象类型：1-顾问，2-团队',

create table dw_erp_d_rpsorg_act_detail_rank (
d_date int comment '统计日期',
rps_user_id int comment '招服ID',
rps_user_name string comment '招服名称',
org_id int comment '招服小组ID',
org_name string comment '招服小组名称',
parent_org_id int comment '招服小组上级ID',
org_grade int comment '组织级次',
rank_type int comment '排名对象类型：1-顾问，2-团队',
mtd_rps_recommend_satisfied_cv_cnt  int comment '本月累计人工推荐简历满意数',
mtd_rps_recommend_satisfied_rank  int comment '本月累计人工推荐简历满意数全国排名',
mtd_rps_recommend_satisfied_rank_num  int comment '本月累计人工推荐简历满意数全国排名序号',
mtd_rps_recommend_satisfied_team_rank  int comment '本月累计人工推荐简历满意数组内排名',
mtd_rps_recommend_satisfied_team_rank_num  int comment '本月累计人工推荐简历满意数组内排名序号',
mtd_consume_cv_ratio  float comment '本月累计简历消耗率',
mtd_consume_cv_ratio_rank  int comment '本月累计简历消耗率全国排名',
mtd_consume_cv_ratio_rank_num  int comment '本月累计简历消耗率全国排名序号',
mtd_consume_cv_ratio_team_rank  int comment '本月累计简历消耗率组内排名',
mtd_consume_cv_ratio_team_rank_num  int comment '本月累计简历消耗率组内排名序号',
mtd_gcdc_valid_call_timelong  float comment '本月累计有效通话时长',
mtd_gcdc_valid_call_timelong_rank  int comment '本月累计有效通话时长全国排名',
mtd_gcdc_valid_call_timelong_rank_num  int comment '本月累计有效通话时长全国排名序号',
mtd_gcdc_valid_call_timelong_team_rank  int comment '本月累计有效通话时长组内排名',
mtd_gcdc_valid_call_timelong_team_rank_num  int comment '本月累计有效通话时长组内排名序号',
creation_timestamp  timestamp comment '时间戳'
) comment '招服Leader看板月度累计指标排名'
partitioned by (p_date int);


create table dw_erp_d_rpsorg_act_detail_rank (
d_date int comment '统计日期',
rps_user_id int comment '招服ID',
rps_user_name varchar(100) comment '招服名称',
org_id int comment '招服小组ID',
org_name varchar(100) comment '招服小组名称',
parent_org_id int comment '招服小组上级ID',
org_grade int comment '组织级次',
rank_type int comment '排名对象类型：1-顾问，0-团队',
mtd_rps_recommend_satisfied_cv_cnt  int comment '本月累计人工推荐简历满意数',
mtd_rps_recommend_satisfied_rank  int comment '本月累计人工推荐简历满意数全国排名',
mtd_rps_recommend_satisfied_rank_num  int comment '本月累计人工推荐简历满意数全国排名序号',
mtd_rps_recommend_satisfied_team_rank  int comment '本月累计人工推荐简历满意数组内排名',
mtd_rps_recommend_satisfied_team_rank_num  int comment '本月累计人工推荐简历满意数组内排名序号',
mtd_consume_cv_ratio  float comment '本月累计简历消耗率',
mtd_consume_cv_ratio_rank  int comment '本月累计简历消耗率全国排名',
mtd_consume_cv_ratio_rank_num  int comment '本月累计简历消耗率全国排名序号',
mtd_consume_cv_ratio_team_rank  int comment '本月累计简历消耗率组内排名',
mtd_consume_cv_ratio_team_rank_num  int comment '本月累计简历消耗率组内排名序号',
mtd_gcdc_valid_call_timelong  float comment '本月累计有效通话时长',
mtd_gcdc_valid_call_timelong_rank  int comment '本月累计有效通话时长全国排名',
mtd_gcdc_valid_call_timelong_rank_num  int comment '本月累计有效通话时长全国排名序号',
mtd_gcdc_valid_call_timelong_team_rank  int comment '本月累计有效通话时长组内排名',
mtd_gcdc_valid_call_timelong_team_rank_num  int comment '本月累计有效通话时长组内排名序号',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,rps_user_id,org_id,rank_type)
) comment '招服Leader看板月度累计指标排名';

alter table dw_erp_d_rpsorg_act_detail_rank_pre change rank_type rank_type int comment '排名对象类型：1-顾问，0-团队' ;

insert overwrite table dw_erp_d_rpsorg_act_detail_rank_pre partition (p_date= $date$)
select
	all_act.d_date,
	all_act.rps_user_id,
	all_act.rps_user_name,
	all_act.org_id,
	all_act.org_name,
	all_act.parent_org_id,
	all_act.org_grade,
	all_act.rank_type,
	all_act.mtd_rps_recommend_satisfied_cv_cnt,
	all_act.mtd_rps_recommend_satisfied_rank,
	all_act.mtd_rps_recommend_satisfied_rank_num,
	all_act.mtd_rps_recommend_satisfied_team_rank,
	all_act.mtd_rps_recommend_satisfied_team_rank_num,
	all_act.mtd_consume_cv_ratio,
	all_act.mtd_consume_cv_ratio_rank,
	all_act.mtd_consume_cv_ratio_rank_num,
	all_act.mtd_consume_cv_ratio_team_rank,
	all_act.mtd_consume_cv_ratio_team_rank_num,
	all_act.mtd_gcdc_valid_call_timelong,
	all_act.mtd_gcdc_valid_call_timelong_rank,
	all_act.mtd_gcdc_valid_call_timelong_rank_num,
	all_act.mtd_gcdc_valid_call_timelong_team_rank,
	all_act.mtd_gcdc_valid_call_timelong_team_rank_num,
	from_unixtime(unix_timestamp()) as creation_timestamp
from (
	select 
		'$date$' as d_date,
		detail.rps_user_id ,
		detail.rps_user_name ,
		detail.org_id	,
		detail.org_name ,
		detail.parent_org_id ,
		detail.org_grade ,
		0 as rank_type,
		detail.mtd_rps_recommend_satisfied_cv_cnt,
		rank()over(sort by mtd_rps_recommend_satisfied_cv_cnt desc) as mtd_rps_recommend_satisfied_rank,
		row_number()over(sort by mtd_rps_recommend_satisfied_cv_cnt desc) as mtd_rps_recommend_satisfied_rank_num,
		rank()over(distribute by detail.org_id sort by mtd_rps_recommend_satisfied_cv_cnt desc) as mtd_rps_recommend_satisfied_team_rank,
		row_number()over(distribute by detail.org_id sort by mtd_rps_recommend_satisfied_cv_cnt desc) as mtd_rps_recommend_satisfied_team_rank_num,

		detail.mtd_consume_cv_ratio,
		rank()over(sort by mtd_consume_cv_ratio desc) as mtd_consume_cv_ratio_rank,
		row_number()over(sort by mtd_consume_cv_ratio desc) as mtd_consume_cv_ratio_rank_num,
		rank()over(distribute by detail.org_id sort by mtd_consume_cv_ratio desc) as mtd_consume_cv_ratio_team_rank,
		row_number()over(distribute by detail.org_id sort by mtd_consume_cv_ratio desc) as mtd_consume_cv_ratio_team_rank_num,

		detail.mtd_gcdc_valid_call_timelong,
		rank()over(sort by mtd_gcdc_valid_call_timelong desc) as mtd_gcdc_valid_call_timelong_rank,
		row_number()over(sort by mtd_gcdc_valid_call_timelong desc) as mtd_gcdc_valid_call_timelong_rank_num,
		rank()over(distribute by detail.org_id sort by mtd_gcdc_valid_call_timelong desc) as mtd_gcdc_valid_call_timelong_team_rank,
		row_number()over(distribute by detail.org_id sort by mtd_gcdc_valid_call_timelong desc) as mtd_gcdc_valid_call_timelong_team_rank_num
	from dw_erp_d_rpsorg_act_detail_pre detail 
	join dw_erp_d_salesuser_base base 
	on detail.rps_user_id = base.id
	and base.position_channel =  'A0000603'
	and base.p_date = '$date$'
	where detail.p_date = '$date$'

	union all 

	select 
		'$date$' as d_date,
		-1 as rps_user_id,
		'未知' as rps_user_name,
		org_act.org_id	,
		org_act.org_name ,
		org_act.parent_org_id ,
		org_act.org_grade ,
		1 as rank_type,
		org_act.mtd_rps_recommend_satisfied_cv_cnt,
		rank()over(sort by mtd_rps_recommend_satisfied_cv_cnt desc) as mtd_rps_recommend_satisfied_rank,
		row_number()over(sort by mtd_rps_recommend_satisfied_cv_cnt desc) as mtd_rps_recommend_satisfied_rank_num,
		rank()over(distribute by org_act.parent_org_id sort by mtd_rps_recommend_satisfied_cv_cnt desc) as mtd_rps_recommend_satisfied_team_rank,
		row_number()over(distribute by org_act.parent_org_id sort by mtd_rps_recommend_satisfied_cv_cnt desc) as mtd_rps_recommend_satisfied_team_rank_num,

		org_act.mtd_consume_cv_ratio,
		rank()over(sort by mtd_consume_cv_ratio desc) as mtd_consume_cv_ratio_rank,
		row_number()over(sort by mtd_consume_cv_ratio desc) as mtd_consume_cv_ratio_rank_num,
		rank()over(distribute by org_act.parent_org_id sort by mtd_consume_cv_ratio desc) as mtd_consume_cv_ratio_team_rank,
		row_number()over(distribute by org_act.parent_org_id sort by mtd_consume_cv_ratio desc) as mtd_consume_cv_ratio_team_rank_num,

		org_act.mtd_gcdc_valid_call_timelong,
		rank()over(sort by mtd_gcdc_valid_call_timelong desc) as mtd_gcdc_valid_call_timelong_rank,
		row_number()over(sort by mtd_gcdc_valid_call_timelong desc) as mtd_gcdc_valid_call_timelong_rank_num,
		rank()over(distribute by org_act.parent_org_id sort by mtd_gcdc_valid_call_timelong desc) as mtd_gcdc_valid_call_timelong_team_rank,
		row_number()over(distribute by org_act.parent_org_id sort by mtd_gcdc_valid_call_timelong desc) as mtd_gcdc_valid_call_timelong_team_rank_num
	from (
			select
				org_id	,
				org_name ,
				parent_org_id ,
				org_grade ,
				sum(rps_recommend_satisfied_cv_cnt/dol.rps_user_cnt)  as mtd_rps_recommend_satisfied_cv_cnt,
				max(case when org_act.d_date = $date$ then org_act.mtd_consume_cv_ratio else 0 end) as mtd_consume_cv_ratio,
				sum(gcdc_valid_call_timelong / dol.rps_user_cnt) as mtd_gcdc_valid_call_timelong
			from dw_erp_d_rpsorg_act_pre org_act 
			join dim_org_level dol on org_act.org_id = dol.d_org_id and dol.p_date = org_act.d_date and dol.grade = 4  			
			left join (
			select
			    org_id,
			    substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) as d_date,
			    count(dwejobcandidate.id) as rps_recommend_satisfied_cv_cnt
			  from  dw_erp_d_ejob_candidate dwejobcandidate
			  where dwejobcandidate.p_date = $date$
			  and substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) between {{date[:6]+'01'}} and $date$
			  and dwejobcandidate.feedback in (4,2,5)
			  and dwejobcandidate.source = 0
			  group by org_id,substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8)
			 ) can 
			on org_act.org_id = can.org_id and org_act.d_date = can.d_date
			where org_act.d_date between {{date[:6]+'01'}} and $date$ 
			group by org_act.org_id,org_act.org_name,org_act.parent_org_id,org_act.org_grade
		) org_act
) all_act;



insert overwrite table dw_erp_d_rpsorg_act_pre partition (p_date = $date$)
select
	$date$ as d_date,
	dol.d_org_id as org_id,
	dol.org_name as org_name,
	dol.grade as org_grade ,
	dol.is_last as is_last ,
	dol.parent_id as parent_org_id ,
	dol.parent_name as parent_org_name,
	dt.time_schedule_ratio ,
	rpsorg_act.cust_consume_cv_target_cnt as cust_consume_cv_target_cnt,
	rpsorg_act.cust_consume_cv_cnt as cust_consume_cv_cnt,
	rpsorg_act.gcdc_valid_call_cnt as gcdc_valid_call_cnt,
	rpsorg_act.gcdc_valid_call_timelong as gcdc_valid_call_timelong,
	rpsorg_act.rps_cust_cover_cnt as rps_cust_cover_cnt,
	0 as cust_return_visit_cnt ,
	0 as ejob_to_bole_manual_cnt ,
	0 as ejob_to_rps_manual_cnt ,
	0 as ejob_to_rps_bole_manual_cnt ,
	0 as ejob_to_rps_bole_manual_cover_cnt ,
	rpsorg_act.consume_intention_cust_cnt as consume_intention_cust_cnt ,
	rpsorg_act.consume_intention_cust_ratio as consume_intention_cust_ratio ,
	rpsorg_act.consume_msk_cust_cnt as consume_msk_cust_cnt ,
	rpsorg_act.consume_msk_cust_ratio as consume_msk_cust_ratio ,
	rpsorg_act.consume_invite_cust_cnt as consume_invite_cust_cnt ,
	rpsorg_act.consume_invite_cust_ratio as consume_invite_cust_ratio ,
	rpsorg_act.consume_urgent_cust_cnt as consume_urgent_cust_cnt ,
	rpsorg_act.consume_urgent_cust_ratio as consume_urgent_cust_ratio ,
	rpsorg_act.consume_cv_cust_cnt as consume_cv_cust_cnt ,
	rpsorg_act.consume_cv_cust_ratio as consume_cv_cust_ratio ,
	rpsorg_act.mtd_consume_cv_cnt as mtd_consume_cv_cnt,
	rpsorg_act.mtd_consume_cv_target_cnt as mtd_consume_cv_target_cnt,
	rpsorg_act.mtd_consume_cv_ratio as mtd_consume_cv_ratio,
	rpsorg_act.mtd_gcdc_valid_call_cnt as mtd_gcdc_valid_call_cnt,
	rpsorg_act.mtd_gcdc_valid_call_timelong as mtd_gcdc_valid_call_timelong ,
	rpsorg_act.mtd_cust_cover_cnt as mtd_cust_cover_cnt,
	rpsorg_act.cust_cnt as cust_cnt,
	rpsorg_act.mtd_cust_no_cover_cnt as mtd_cust_no_cover_cnt,
	rpsorg_act.mtd_cust_cover_ratio as mtd_cust_cover_ratio,
	rpsorg_act.mtd_expire_renewal_cust_cnt as mtd_expire_renewal_cust_cnt,
	rpsorg_act.mtd_n_expire_renewal_cust_cnt as mtd_n_expire_renewal_cust_cnt,
	rpsorg_act.mtd_expire_cust_cnt as mtd_expire_cust_cnt,
	rpsorg_act.mtd_expire_p_renewal_cust_cnt as mtd_expire_p_renewal_cust_cnt,
	rpsorg_act.mtd_contract_renewal_ratio as mtd_contract_renewal_ratio,
	rpsorg_act.mtd_rps_recommend_cv_cnt as mtd_rps_recommend_cv_cnt ,
	rpsorg_act.mtd_rps_recommend_satisfied_cv_cnt as mtd_rps_recommend_satisfied_cv_cnt ,
	rpsorg_act.mtd_bole_recommend_cv_cnt as mtd_bole_recommend_cv_cnt ,
	rpsorg_act.mtd_bole_recommend_satisfied_cv_cnt as mtd_bole_recommend_satisfied_cv_cnt ,
	rpsorg_act.mtd_recommend_deal_cv_cnt as mtd_recommend_deal_cv_cnt,
	rpsorg_act.mtd_recommend_cv_cnt as mtd_recommend_cv_cnt,
	rpsorg_act.mtd_recommend_cv_deal_ratio as mtd_recommend_cv_deal_ratio,
	rpsorg_act.mtd_recommend_satisfied_cv_cnt as mtd_recommend_satisfied_cv_cnt,
	rpsorg_act.mtd_msk_showup_cnt as mtd_msk_showup_cnt,
	0 as callplan_no_finish_cnt,
	0 as task_no_finish_cnt,
	0 as intention_no_release_cnt,
	0 as intention_no_submit_cnt,
	0 as ejob_no_label_cnt,
	0 as ejob_no_tag_cnt,
	0 as ejob_recommend_to_manual_cnt,
	0 as ejob_7day_recommend_undeal_cnt,
	rpsorg_act.msk_assess_cnt as msk_assess_cnt,
	0 as cust_break_cnt,
	0 as cust_renewal_cnt,
	0 as cust_3month_renewal_cnt,
	0 as cust_3month_expire_cnt,
	0 as cust_renewal_high_cnt,
	0 as cust_renewal_mid_cnt,
	0 as cust_renewal_low_cnt,
	0 as cust_renewal_none_cnt,
	 from_unixtime(unix_timestamp()) as creation_timestamp,
	rpsorg_act.warn_resource_consume_cust_cnt as warn_resource_consume_cust_cnt,
	rpsorg_act.rps_user_cnt as rps_user_cnt,
	rpsorg_act.avg_rps_user_cnt as avg_rps_user_cnt
from 
(select
		coalesce(rps_renewal.org_id,rps_call.org_id,rps_consume.org_id,consume.org_id,msk.org_id,user_cnt.org_id,candidate.org_id) as org_id,
		sum(rps_consume.cust_consume_cv_target_cnt) as cust_consume_cv_target_cnt,
		sum(rps_consume.cust_consume_cv_cnt) as cust_consume_cv_cnt,
		sum(rps_call.gcdc_valid_call_cnt) as gcdc_valid_call_cnt,
		sum(rps_call.gcdc_valid_call_timelong) as gcdc_valid_call_timelong,
		sum(rps_call.rps_cust_cover_cnt) as rps_cust_cover_cnt,
		0 as cust_return_visit_cnt ,
		0 as ejob_to_bole_manual_cnt ,
		0 as ejob_to_rps_manual_cnt ,
		0 as ejob_to_rps_bole_manual_cnt ,
		0 as ejob_to_rps_bole_manual_cover_cnt ,
		sum(consume.consume_intention_cust_cnt) as consume_intention_cust_cnt ,
		sum(consume.consume_intention_cust_ratio) as consume_intention_cust_ratio ,
		sum(consume.consume_msk_cust_cnt) as consume_msk_cust_cnt ,
		sum(consume.consume_msk_cust_ratio) as consume_msk_cust_ratio ,
		sum(consume.consume_invite_cust_cnt) as consume_invite_cust_cnt ,
		sum(consume.consume_invite_cust_ratio) as consume_invite_cust_ratio ,
		sum(consume.consume_urgent_cust_cnt) as consume_urgent_cust_cnt ,
		sum(consume.consume_urgent_cust_ratio) as consume_urgent_cust_ratio ,
		sum(consume.consume_cv_cust_cnt) as consume_cv_cust_cnt ,
		sum(consume.consume_cv_cust_ratio) as consume_cv_cust_ratio ,
		sum(rps_consume.mtd_consume_cv_cnt) as mtd_consume_cv_cnt,
		sum(rps_consume.mtd_consume_cv_target_cnt) as mtd_consume_cv_target_cnt,
		sum(rps_consume.mtd_consume_cv_ratio) as mtd_consume_cv_ratio,
		sum(rps_call.mtd_gcdc_valid_call_cnt) as mtd_gcdc_valid_call_cnt,
		sum(rps_call.mtd_gcdc_valid_call_timelong) as mtd_gcdc_valid_call_timelong ,
		sum(rps_call.mtd_cust_cover_cnt) as mtd_cust_cover_cnt,
		sum(rps_call.cust_cnt) as cust_cnt,
		sum(rps_call.cust_cnt - rps_call.mtd_cust_cover_cnt) as mtd_cust_no_cover_cnt,
		sum(rps_call.mtd_cust_cover_cnt) / sum(rps_call.cust_cnt) as mtd_cust_cover_ratio,
		sum(rps_renewal.mtd_expire_renewal_cust_cnt) as mtd_expire_renewal_cust_cnt,
		sum(rps_renewal.mtd_n_expire_renewal_cust_cnt) as mtd_n_expire_renewal_cust_cnt,
		sum(rps_renewal.mtd_expire_cust_cnt) as mtd_expire_cust_cnt,
		sum(rps_renewal.mtd_expire_p_renewal_cust_cnt) as mtd_expire_p_renewal_cust_cnt,
		sum(rps_renewal.mtd_contract_renewal_ratio) as mtd_contract_renewal_ratio,
		sum(candidate.mtd_rps_recommend_cv_cnt) as mtd_rps_recommend_cv_cnt ,
		sum(candidate.mtd_rps_recommend_satisfied_cv_cnt) as mtd_rps_recommend_satisfied_cv_cnt ,
		sum(candidate.mtd_bole_recommend_cv_cnt) as mtd_bole_recommend_cv_cnt ,
		sum(candidate.mtd_bole_recommend_satisfied_cv_cnt) as mtd_bole_recommend_satisfied_cv_cnt ,
		sum(candidate.mtd_recommend_deal_cv_cnt) as mtd_recommend_deal_cv_cnt,
		sum(candidate.mtd_recommend_cv_cnt) as mtd_recommend_cv_cnt,
		sum(candidate.mtd_recommend_cv_deal_ratio) as mtd_recommend_cv_deal_ratio,
		sum(candidate.mtd_recommend_satisfied_cv_cnt) as mtd_recommend_satisfied_cv_cnt,
		sum(msk.mtd_msk_showup_cnt) as mtd_msk_showup_cnt,
		0 as callplan_no_finish_cnt,
		0 as task_no_finish_cnt,
		0 as intention_no_release_cnt,
		0 as intention_no_submit_cnt,
		0 as ejob_no_label_cnt,
		0 as ejob_no_tag_cnt,
		0 as ejob_recommend_to_manual_cnt,
		0 as ejob_7day_recommend_undeal_cnt,
		sum(msk.msk_assess_cnt) as msk_assess_cnt,
		0 as cust_break_cnt,
		0 as cust_renewal_cnt,
		0 as cust_3month_renewal_cnt,
		0 as cust_3month_expire_cnt,
		0 as cust_renewal_high_cnt,
		0 as cust_renewal_mid_cnt,
		0 as cust_renewal_low_cnt,
		0 as cust_renewal_none_cnt,
		 from_unixtime(unix_timestamp()) as creation_timestamp,
		sum(consume.warn_resource_consume_cust_cnt) as warn_resource_consume_cust_cnt,
		sum(user_cnt.rps_user_cnt) as rps_user_cnt,
		sum(user_cnt.avg_rps_user_cnt) as avg_rps_user_cnt	
	from 
	(
	  select
	  coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
	  sum(mtd_expire_renewal_cust_cnt) as mtd_expire_renewal_cust_cnt,
	  sum(mtd_n_expire_renewal_cust_cnt) as mtd_n_expire_renewal_cust_cnt,
	  sum(mtd_expire_cust_cnt) as mtd_expire_cust_cnt,
	  sum(mtd_expire_p_renewal_cust_cnt) as mtd_expire_p_renewal_cust_cnt,
	  (sum(mtd_expire_renewal_cust_cnt) +sum(mtd_n_expire_renewal_cust_cnt)) / (sum(mtd_expire_cust_cnt)-sum(mtd_expire_p_renewal_cust_cnt)+ sum(mtd_n_expire_renewal_cust_cnt))  as mtd_contract_renewal_ratio
	  from (
	    select org_id,
	    	   sum(expire_renewal_cust_cnt) as mtd_expire_renewal_cust_cnt,
	    	   sum(pre_expire_renewal_cust_cnt) as mtd_n_expire_renewal_cust_cnt,
	    	   sum(expire_cust_cnt) as mtd_expire_cust_cnt,
	    	   sum(expire_pre_renewal_cust_cnt) as mtd_expire_p_renewal_cust_cnt
	      from fact_h_gcdc_d_renewal_rpsuser
	     where d_date = $date$
	     group by org_id
	  ) renewal_org
	  left join dim_org_level dol 
	  on renewal_org.org_id = dol.d_org_id
	  and dol.p_date = $date$
	  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
	  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)
	) rps_renewal
	full join 
	(
	  select 
	      coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
		  sum(mtd_gcdc_valid_call_timelong) as mtd_gcdc_valid_call_timelong,
		  sum(mtd_gcdc_valid_call_cnt) as mtd_gcdc_valid_call_cnt,
		  count(distinct track.customer_id) as mtd_cust_cover_cnt,
		  sum(case when base.p_date = $date$ then gcdc_valid_call_timelong else 0 end) as gcdc_valid_call_timelong,
		  sum(case when base.p_date = $date$ then gcdc_valid_call_cnt else 0 end) as gcdc_valid_call_cnt,
		  count(distinct case when base.p_date = $date$ then call.customer_id else null end) as rps_cust_cover_cnt,
	    count(distinct base.id) as cust_cnt
	  from (select cust.p_date,
	               cust.id ,
	               suser.id as rps_user_id,
	               cust.service_teamorg_id
	          from dw_erp_d_customer_base cust 
	          join dw_erp_d_salesuser_base suser 
	          on cust.serviceuser_id = suser.id 
	          and cust.p_date = suser.p_date
	          and suser.position_channel = 'A0000603'
	          where cust.p_date = $date$
	          and cust.rsc_valid_status = 1
	          and cust.rps_service_version = 1
	          ) base
	  left join (select creator_id as rps_user_id,customer_id,count(id) as track_cnt
	               from track 
	              where substr(regexp_replace(track.createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$
	                and creator_role = 2
	              group by creator_id ,customer_id) track 
	  on base.id = track.customer_id
	  and base.rps_user_id = track.rps_user_id
	  left join 
	  (select 
	   org_id, 
	    customer_id,
	    call_date as p_date,
	    sum(time_long)/60  as mtd_gcdc_valid_call_timelong,
	    count(1) as mtd_gcdc_valid_call_cnt,
	    sum(case when call_date = $date$ then time_long else 0 end) / 60 as gcdc_valid_call_timelong,
	    sum(case when call_date = $date$ then 1 else 0 end) as gcdc_valid_call_cnt
	 from call_record
	  where call_date between  {{date[:6]+'01'}} and $date$ 
	  and deleteflag = 0 
	  and time_long > 60
	  and customer_id > 0
	  and call_type=0
	  group by org_id,customer_id,call_date
	  ) call 
	  on  call.customer_id = base.id
	  and call.org_id = base.service_teamorg_id
	  join dim_org_level dol 
	  on base.service_teamorg_id = dol.d_org_id
	  and dol.p_date = $date$  
	  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
	  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)
	) rps_call
	on rps_renewal.org_id = rps_call.org_id
	full join 
	(
	  select  
	      suser_act.org_id,
	      suser_act.mtd_consume_cv_cnt as mtd_consume_cv_cnt,
	      (suser_act.mtd_consume_cv_target_cnt+suser_act.tm_left_day_consume_cv_target_cnt) as mtd_consume_cv_target_cnt,
	      suser_act.mtd_consume_cv_cnt / (suser_act.mtd_consume_cv_target_cnt+suser_act.tm_left_day_consume_cv_target_cnt) as mtd_consume_cv_ratio,
	      suser_act.cust_consume_cv_cnt,
	      suser_act.cust_consume_cv_target_cnt
	   from (
	        select 
	        coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
	        sum(case when act.p_date = $date$ then consume_cv_total_cnt+exchange_cv2lowcv else 0 end) as cust_consume_cv_cnt,
	        sum(act.consume_cv_total_cnt+act.exchange_cv2lowcv) as mtd_consume_cv_cnt,
	        sum((case when target.left_cnt > 0 then target.day_consume_cv_target_cnt else 0 end) * holiday.is_workday) as mtd_consume_cv_target_cnt,
	        sum(case when base.p_date = $date$ then target.day_consume_cv_target_cnt else 0 end) as cust_consume_cv_target_cnt,
			sum(case when base.p_date = $date$ then target.tm_left_day_consume_cv_target_cnt else 0 end) as tm_left_day_consume_cv_target_cnt        
	      from 
	      (select cust.p_date,
	               cust.id,
	               suser.id as rps_user_id,
	               cust.service_teamorg_id 
	          from dw_erp_d_customer_base cust 
	          join dw_erp_d_salesuser_base suser 
	          on cust.serviceuser_id = suser.id 
	          and cust.p_date = suser.p_date
	          and suser.position_channel = 'A0000603'
	          where cust.p_date between {{date[:6]+'01'}} and $date$
	          and cust.rsc_valid_status = 1
	          and cust.rps_service_version = 1
	          ) base 
	      left join dw_erp_d_customer_consume_target target 
	      on base.id = target.customer_id
	      and base.p_date = target.p_date
	      left join dw_erp_d_customer_act act 
	      on base.id = act.customer_id
	      and base.p_date = act.p_date
	      join dim_date_holiday holiday on base.p_date = holiday.d_date
	      join dim_org_level dol on base.service_teamorg_id = dol.d_org_id and dol.p_date = $date$
	      group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
		  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)
	   ) suser_act
	) rps_consume
	on  rps_renewal.org_id = rps_consume.org_id
	full join 
	(
	  select
	    coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
	    count(case when dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_rps_recommend_cv_cnt,
	    count(case when dwejobcandidate.source = 4 then dwejobcandidate.id else null end) as mtd_bole_recommend_cv_cnt,
	    count(dwejobcandidate.id) as mtd_recommend_cv_cnt,
	    count(case when dwejobcandidate.feedback in (4,2,5) and dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_rps_recommend_satisfied_cv_cnt,
	    count(case when dwejobcandidate.feedback in (4,2,5) and dwejobcandidate.source = 4 then dwejobcandidate.id else null end) as mtd_bole_recommend_satisfied_cv_cnt,
	    count(case when dwejobcandidate.feedback in (4,2,5) then dwejobcandidate.id else null end) as mtd_recommend_satisfied_cv_cnt,
	    count(case when dwejobcandidate.feedback <> 1 then dwejobcandidate.id else null end) as mtd_recommend_deal_cv_cnt,
	    count(case when dwejobcandidate.feedback <> 1 and dwejobcandidate.source = 0 then dwejobcandidate.id else null end) / count(case when dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_recommend_cv_deal_ratio
	  from  dw_erp_d_ejob_candidate dwejobcandidate  
	  left join dim_org_level dol on dwejobcandidate.org_id = dol.d_org_id and dol.p_date = $date$
	  join dw_erp_d_customer_base cust
	   on dwejobcandidate.customer_id = cust.id 
	   and cust.p_date = $date$
	  where dwejobcandidate.p_date = $date$
	  and substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$
	  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
	  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)
	) candidate
	on  rps_renewal.org_id = candidate.org_id
	full join 
	(
		select coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
			   sum(is_intention) as consume_intention_cust_cnt,
			   sum(is_intention) / sum(1) as  consume_intention_cust_ratio,
			   sum(is_msk) as consume_msk_cust_cnt,
			   sum(is_msk) / sum(1) as  consume_msk_cust_ratio,
			   sum(is_invite) as consume_invite_cust_cnt,
			   sum(is_invite) / sum(1) as  consume_invite_cust_ratio,
			   sum(is_urgent) as consume_urgent_cust_cnt,
			   sum(is_urgent) / sum(1) as  consume_urgent_cust_ratio,
			   sum(is_download_cv) as consume_cv_cust_cnt,
			   sum(is_download_cv) / sum(1) as consume_cv_cust_ratio,
			   sum(is_warn_resource_consume_cust_cnt) as warn_resource_consume_cust_cnt
		  from (select cust.p_date,
	               cust.id ,
	               suser.id as rps_user_id,
	               cust.service_teamorg_id
	          from dw_erp_d_customer_base cust 
	          join dw_erp_d_salesuser_base suser 
	          on cust.serviceuser_id = suser.id 
	          and cust.p_date = suser.p_date
	          and suser.position_channel = 'A0000603'
	          where cust.p_date = $date$
	          and cust.rsc_valid_status = 1
	          and cust.rps_service_version = 1
	          ) base
		  left join 
		  ( select customer_id,
			   		   case when sum(download_cv_cnt) > 0 then 1  else 0 end as is_download_cv,
					   case when sum(intention_cnt) > 0 then 1  else 0 end as is_intention,
					   case when sum(msk_cnt) > 0 then 1  else 0 end as is_msk,
					   case when sum(invite_cnt) > 0 then 1  else 0 end as is_invite,
					   case when sum(urgent_cnt) > 0 then 1 else 0 end as is_urgent,
					   case when sum(case when p_date = $date$ then consume_cv_total_cnt else 0 end) > 50 and 
					   sum(case when p_date = $date$ then day30_consume_cv_total_cnt else 0 end)  = 0 then 1 else 0 end as is_warn_resource_consume_cust_cnt
			     from dw_erp_d_customer_rps_act
			    where p_date between  {{date[:6]+'01'}} and $date$ 
			    group by customer_id
				) act 	  
		  on act.customer_id = base.id
		  join dim_org_level dol on base.service_teamorg_id = dol.d_org_id and dol.p_date = $date$
		  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
		  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)
	) consume 
	on  rps_renewal.org_id = consume.org_id
	full join
	(
		select coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
			   sum(case when msk.status in (1,3) then showup_cnt else 0 end) as mtd_msk_showup_cnt,
			   count(case when msk.is_delegation = 1 and msk.delegation_consultant_type = 1 and msk.status = 0 then cust.id else null end) as msk_assess_cnt
		  from dw_god_d_msk_service msk
		  left join (
		  		select god_service_id,sum(showup_cnt) as showup_cnt
		  		from dw_god_d_msk_service_order_index
		  		where p_date between {{date[:6]+'01'}} and $date$  
		  		 and consultant_type = 1
		  		group by god_service_id
		  	) msk_order
		  on msk.god_service_id = msk_order.god_service_id
		  join (select cust.p_date,
	               cust.id ,
	               suser.id as rps_user_id,
	               cust.service_teamorg_id ,cust.ecomp_root_id
	          from dw_erp_d_customer_base cust 
	          join dw_erp_d_salesuser_base suser 
	          on cust.serviceuser_id = suser.id 
	          and cust.p_date = suser.p_date
	          and suser.position_channel = 'A0000603'
	          where cust.p_date = $date$
	          and cust.rsc_valid_status = 1
	          and cust.rps_service_version = 1
	          ) cust 
		  on msk.ecomp_root_id = cust.ecomp_root_id
		  join dim_org_level dol on cust.service_teamorg_id = dol.d_org_id and dol.p_date = $date$
		 where msk.status in (1,3,0)
		  and msk.p_date = $date$
		  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
		  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)	 
	) msk 
	on rps_renewal.org_id = msk.org_id
	full join 
	(
		select coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
			   sum(teamorg.rps_user_cnt) as rps_user_cnt,
			   sum(teamorg.avg_rps_user_cnt) as avg_rps_user_cnt
		from (
			select teamorg.service_teamorg_id as org_id,
				   sum(case when p_date = $date$ then teamorg.rps_user_cnt else 0 end) as rps_user_cnt,
				   avg(teamorg.rps_user_cnt) as avg_rps_user_cnt
			from (
			 select base.p_date,base.service_teamorg_id,count(distinct base.serviceuser_id) as rps_user_cnt
			   from dw_erp_d_customer_base base
			   join dw_erp_d_salesuser_base suser
			   on base.serviceuser_id = suser.id 
			   and base.p_date = suser.p_date
			   and suser.position_channel = 'A0000603'
			  where base.p_date  between  {{date[:6]+'01'}} and $date$ 
		      and base.rps_service_version = 1
		      and base.rsc_valid_status = 1 
			   group by base.p_date,base.service_teamorg_id
			 ) teamorg 
			group by service_teamorg_id
		) teamorg 
		join dim_org_level dol on teamorg.org_id = dol.d_org_id and dol.p_date = $date$
		  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
		  grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level)	  	
	) user_cnt
	on rps_renewal.org_id = user_cnt.org_id
	group by coalesce(rps_renewal.org_id,rps_call.org_id,rps_consume.org_id,consume.org_id,msk.org_id,user_cnt.org_id,candidate.org_id)
) rpsorg_act 
join dim_org_level dol 
on rpsorg_act.org_id = dol.d_org_id
and dol.p_date = $date$
join (
 select  int(substr('$date$',7,2)) / int(substr(last_day(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-','01')),9,2)) as time_schedule_ratio 
   from dummy) dt on 1=1;



insert overwrite table dw_erp_d_rpsorg_act_detail_pre partition (p_date = $date$)
select
$date$ as d_date,
rps_user.id as rps_user_id,
rps_user.name as rps_user_name,
fact1.org_id as org_id,
dim_org_level.org_name as org_name,
nvl(dim_org_level.grade,-1) as org_grade ,
nvl(dim_org_level.is_last,-1) as is_last ,
nvl(dim_org_level.parent_id,-1) as parent_org_id ,
nvl(dim_org_level.parent_name,-1) as parent_org_name,
dt.time_schedule_ratio ,
fact1.cust_consume_cv_target_cnt as cust_consume_cv_target_cnt,
fact1.cust_consume_cv_cnt as cust_consume_cv_cnt,
fact1.gcdc_valid_call_cnt as gcdc_valid_call_cnt,
fact1.gcdc_valid_call_timelong as gcdc_valid_call_timelong,
fact1.rps_cust_cover_cnt as rps_cust_cover_cnt,
fact1.cust_return_visit_cnt as cust_return_visit_cnt,
fact1.ejob_to_bole_manual_cnt as ejob_to_bole_manual_cnt,
fact1.ejob_to_rps_manual_cnt as ejob_to_rps_manual_cnt,
fact1.ejob_to_rps_bole_manual_cnt as ejob_to_rps_bole_manual_cnt,
fact1.ejob_to_rps_bole_manual_cover_cnt as ejob_to_rps_bole_manual_cover_cnt,
fact1.consume_intention_cust_cnt as consume_intention_cust_cnt,
fact1.consume_intention_cust_ratio as consume_intention_cust_ratio,
fact1.consume_msk_cust_cnt as consume_msk_cust_cnt,
fact1.consume_msk_cust_ratio as consume_msk_cust_ratio,
fact1.consume_invite_cust_cnt as consume_invite_cust_cnt,
fact1.consume_invite_cust_ratio as consume_invite_cust_ratio,
fact1.consume_urgent_cust_cnt as consume_urgent_cust_cnt,
fact1.consume_urgent_cust_ratio as consume_urgent_cust_ratio,
fact1.consume_cv_cust_cnt as consume_cv_cust_cnt,
fact1.consume_cv_cust_ratio as consume_cv_cust_ratio,
fact1.mtd_consume_cv_cnt as mtd_consume_cv_cnt,
fact1.mtd_consume_cv_target_cnt as mtd_consume_cv_target_cnt,
fact1.mtd_consume_cv_ratio as mtd_consume_cv_ratio,
fact1.mtd_gcdc_valid_call_cnt as mtd_gcdc_valid_call_cnt,
fact1.mtd_gcdc_valid_call_timelong as mtd_gcdc_valid_call_timelong,
fact1.mtd_cust_cover_cnt as mtd_cust_cover_cnt,
fact1.cust_cnt as cust_cnt,
fact1.mtd_cust_no_cover_cnt as mtd_cust_no_cover_cnt,
fact1.mtd_cust_cover_ratio as mtd_cust_cover_ratio,
fact1.mtd_expire_renewal_cust_cnt as mtd_expire_renewal_cust_cnt,
fact1.mtd_n_expire_renewal_cust_cnt as mtd_n_expire_renewal_cust_cnt,
fact1.mtd_expire_cust_cnt as mtd_expire_cust_cnt,
fact1.mtd_expire_p_renewal_cust_cnt as mtd_expire_p_renewal_cust_cnt,
fact1.mtd_contract_renewal_ratio as mtd_contract_renewal_ratio,
fact1.mtd_rps_recommend_cv_cnt as mtd_rps_recommend_cv_cnt,
fact1.mtd_rps_recommend_satisfied_cv_cnt as mtd_rps_recommend_satisfied_cv_cnt,
fact1.mtd_bole_recommend_cv_cnt as mtd_bole_recommend_cv_cnt,
fact1.mtd_bole_recommend_satisfied_cv_cnt as mtd_bole_recommend_satisfied_cv_cnt,
fact1.mtd_recommend_deal_cv_cnt as mtd_recommend_deal_cv_cnt,
fact1.mtd_recommend_cv_cnt as mtd_recommend_cv_cnt,
fact1.mtd_recommend_cv_deal_ratio as mtd_recommend_cv_deal_ratio,
fact1.mtd_recommend_satisfied_cv_cnt as mtd_recommend_satisfied_cv_cnt,
fact1.mtd_msk_showup_cnt as mtd_msk_showup_cnt,
fact1.callplan_no_finish_cnt as callplan_no_finish_cnt,
fact1.task_no_finish_cnt as task_no_finish_cnt,
fact1.intention_no_release_cnt as intention_no_release_cnt,
fact1.intention_no_submit_cnt as intention_no_submit_cnt,
fact1.ejob_no_label_cnt as ejob_no_label_cnt,
fact1.ejob_no_tag_cnt as ejob_no_tag_cnt,
fact1.ejob_recommend_to_manual_cnt as ejob_recommend_to_manual_cnt,
fact1.ejob_7day_recommend_undeal_cnt as ejob_7day_recommend_undeal_cnt,
fact1.msk_assess_cnt as msk_assess_cnt,
fact1.cust_break_cnt as cust_break_cnt,
fact1.cust_renewal_cnt as cust_renewal_cnt,
fact1.cust_3month_renewal_cnt as cust_3month_renewal_cnt,
fact1.cust_3month_expire_cnt as cust_3month_expire_cnt,
fact1.cust_renewal_high_cnt as cust_renewal_high_cnt,
fact1.cust_renewal_mid_cnt as cust_renewal_mid_cnt,
fact1.cust_renewal_low_cnt as cust_renewal_low_cnt,
fact1.cust_renewal_none_cnt as cust_renewal_none_cnt,
from_unixtime(unix_timestamp()) as creation_timestamp,
fact1.warn_resource_consume_cust_cnt as warn_resource_consume_cust_cnt
from (
    select 
    coalesce(rps_renewal.rps_user_id,consume.rps_user_id,msk.rps_user_id,candidate.rps_user_id,rps_call.rps_user_id,rps_consume.rps_user_id) as rps_user_id,
    coalesce(rps_renewal.org_id,consume.org_id,msk.org_id,candidate.org_id,rps_call.org_id,rps_consume.org_id) as org_id,
    nvl(sum(rps_consume.cust_consume_cv_target_cnt),0) as cust_consume_cv_target_cnt,
    nvl(sum(rps_consume.cust_consume_cv_cnt),0) as cust_consume_cv_cnt,
    nvl(sum(rps_call.gcdc_valid_call_cnt),0) as gcdc_valid_call_cnt,
    nvl(sum(rps_call.gcdc_valid_call_timelong),0) as gcdc_valid_call_timelong,
    nvl(sum(rps_call.rps_cust_cover_cnt),0) as rps_cust_cover_cnt,
    0 as cust_return_visit_cnt ,
    0 as ejob_to_bole_manual_cnt ,
    0 as ejob_to_rps_manual_cnt ,
    0 as ejob_to_rps_bole_manual_cnt ,
    0 as ejob_to_rps_bole_manual_cover_cnt ,
    nvl(sum(consume.consume_intention_cust_cnt),0) as consume_intention_cust_cnt ,
    nvl(sum(consume.consume_intention_cust_ratio),0) as consume_intention_cust_ratio ,
    nvl(sum(consume.consume_msk_cust_cnt),0) as consume_msk_cust_cnt ,
    nvl(sum(consume.consume_msk_cust_ratio),0) as consume_msk_cust_ratio ,
    nvl(sum(consume.consume_invite_cust_cnt),0) as consume_invite_cust_cnt ,
    nvl(sum(consume.consume_invite_cust_ratio),0) as consume_invite_cust_ratio ,
    nvl(sum(consume.consume_urgent_cust_cnt),0) as consume_urgent_cust_cnt ,
    nvl(sum(consume.consume_urgent_cust_ratio),0) as consume_urgent_cust_ratio ,
    nvl(sum(consume.consume_cv_cust_cnt),0) as consume_cv_cust_cnt ,
    nvl(sum(consume.consume_cv_cust_ratio),0) as consume_cv_cust_ratio ,
    nvl(sum(rps_consume.mtd_consume_cv_cnt),0) as mtd_consume_cv_cnt,
    nvl(sum(rps_consume.mtd_consume_cv_target_cnt),0) as mtd_consume_cv_target_cnt,
    nvl(sum(rps_consume.mtd_consume_cv_ratio),0) as mtd_consume_cv_ratio,
    nvl(sum(rps_call.mtd_gcdc_valid_call_cnt),0) as mtd_gcdc_valid_call_cnt,
    nvl(sum(rps_call.mtd_gcdc_valid_call_timelong),0) as mtd_gcdc_valid_call_timelong ,
    nvl(sum(rps_call.mtd_cust_cover_cnt),0) as mtd_cust_cover_cnt,
    nvl(sum(rps_call.cust_cnt),0) as cust_cnt,
    nvl(sum(rps_call.cust_cnt) - sum(rps_call.mtd_cust_cover_cnt),0) as mtd_cust_no_cover_cnt,
    nvl(sum(rps_call.mtd_cust_cover_cnt) / sum(rps_call.cust_cnt),0) as mtd_cust_cover_ratio,
    nvl(sum(rps_renewal.mtd_expire_renewal_cust_cnt),0) as mtd_expire_renewal_cust_cnt,
    nvl(sum(rps_renewal.mtd_n_expire_renewal_cust_cnt),0) as mtd_n_expire_renewal_cust_cnt,
    nvl(sum(rps_renewal.mtd_expire_cust_cnt),0) as mtd_expire_cust_cnt,
    nvl(sum(rps_renewal.mtd_expire_p_renewal_cust_cnt),0) as mtd_expire_p_renewal_cust_cnt,
    nvl(sum(rps_renewal.mtd_contract_renewal_ratio),0) as mtd_contract_renewal_ratio,
    nvl(sum(candidate.mtd_rps_recommend_cv_cnt),0) as mtd_rps_recommend_cv_cnt ,
    nvl(sum(candidate.mtd_rps_recommend_satisfied_cv_cnt),0) as mtd_rps_recommend_satisfied_cv_cnt ,
    nvl(sum(candidate.mtd_bole_recommend_cv_cnt),0) as mtd_bole_recommend_cv_cnt ,
    nvl(sum(candidate.mtd_bole_recommend_satisfied_cv_cnt),0) as mtd_bole_recommend_satisfied_cv_cnt ,
    nvl(sum(candidate.mtd_recommend_deal_cv_cnt),0) as mtd_recommend_deal_cv_cnt,
    nvl(sum(candidate.mtd_recommend_cv_cnt),0) as mtd_recommend_cv_cnt,
    nvl(sum(candidate.mtd_recommend_cv_deal_ratio),0) as mtd_recommend_cv_deal_ratio,
    nvl(sum(candidate.mtd_recommend_satisfied_cv_cnt),0) as mtd_recommend_satisfied_cv_cnt,
    nvl(sum(msk.mtd_msk_showup_cnt),0) as mtd_msk_showup_cnt,
    0 as callplan_no_finish_cnt,
    0 as task_no_finish_cnt,
    0 as intention_no_release_cnt,
    0 as intention_no_submit_cnt,
    0 as ejob_no_label_cnt,
    0 as ejob_no_tag_cnt,
    0 as ejob_recommend_to_manual_cnt,
    0 as ejob_7day_recommend_undeal_cnt,
    nvl(sum(msk.msk_assess_cnt),0) as msk_assess_cnt,
    0 as cust_break_cnt,
    0 as cust_renewal_cnt,
    0 as cust_3month_renewal_cnt,
    0 as cust_3month_expire_cnt,
    0 as cust_renewal_high_cnt,
    0 as cust_renewal_mid_cnt,
    0 as cust_renewal_low_cnt,
    0 as cust_renewal_none_cnt,
    nvl(sum(consume.warn_resource_consume_cust_cnt),0) as warn_resource_consume_cust_cnt
    from 
    (
        select rps_user_id,org_id,
        	   sum(expire_renewal_cust_cnt) as mtd_expire_renewal_cust_cnt,
        	   sum(pre_expire_renewal_cust_cnt) as mtd_n_expire_renewal_cust_cnt,
        	   sum(expire_cust_cnt) as mtd_expire_cust_cnt,
        	   sum(expire_pre_renewal_cust_cnt) as mtd_expire_p_renewal_cust_cnt,
      		  (sum(expire_renewal_cust_cnt) +sum(pre_expire_renewal_cust_cnt)) / (sum(expire_cust_cnt)-sum(expire_pre_renewal_cust_cnt)+ sum(pre_expire_renewal_cust_cnt))  as mtd_contract_renewal_ratio	
          from fact_h_gcdc_d_renewal_rpsuser
         where d_date = $date$
         group by rps_user_id,org_id       
    ) rps_renewal
    full join 
    (
      select 
          base.rps_user_id as rps_user_id,
          base.service_teamorg_id as org_id,
      	  sum(mtd_gcdc_valid_call_timelong) as mtd_gcdc_valid_call_timelong,
      	  sum(mtd_gcdc_valid_call_cnt) as mtd_gcdc_valid_call_cnt,
      	  count(distinct case when mtd_gcdc_valid_call_cnt > 0 then  call.customer_id else null end) as mtd_cust_cover_cnt,
      	  sum(gcdc_valid_call_timelong) as gcdc_valid_call_timelong,
      	  sum(gcdc_valid_call_cnt) as gcdc_valid_call_cnt,
      	  count(distinct case when gcdc_valid_call_cnt > 0 then call.customer_id else null end) as rps_cust_cover_cnt,
          count(distinct base.id) as cust_cnt
      from (select cust.p_date,
               cust.id ,
               suser.id as rps_user_id,
               cust.service_teamorg_id
          from dw_erp_d_customer_base cust 
          join dw_erp_d_salesuser_base suser 
          on cust.serviceuser_id = suser.id 
          and cust.p_date = suser.p_date
          and suser.position_channel = 'A0000603'
          where cust.p_date = $date$
          and cust.rsc_valid_status = 1
          and cust.rps_service_version = 1
          ) base 
        left join (select creator_id as rps_user_id,customer_id,count(id) as track_cnt
                     from track 
                    where substr(regexp_replace(track.createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$
                      and creator_role = 2
                    group by creator_id ,customer_id) track 
          on base.id = track.customer_id
          and base.rps_user_id = track.rps_user_id
        left join 
        (select 
              org_id, 
              creator_id,
              customer_id,
              sum(time_long)/60  as mtd_gcdc_valid_call_timelong,
              count(1) as mtd_gcdc_valid_call_cnt,
              sum(case when call_date = $date$ then time_long else 0 end) / 60 as gcdc_valid_call_timelong,
              sum(case when call_date = $date$ then 1 else 0 end)  as gcdc_valid_call_cnt
        from call_record
        where call_date between  {{date[:6]+'01'}} and $date$ 
          and deleteflag = 0 
          and time_long > 60
          and customer_id > 0
          and call_type=0
          group by org_id,creator_id,customer_id
        ) call 
      on  call.customer_id = base.id
      and call.creator_id = base.rps_user_id
      and call.org_id = base.service_teamorg_id
      where  base.p_date = $date$ 
      group by base.service_teamorg_id,base.rps_user_id
    ) rps_call
    on rps_renewal.rps_user_id = rps_call.rps_user_id
    and  rps_renewal.org_id = rps_call.org_id
    full join 
    (
      select  
          suser_act.rps_user_id as rps_user_id,
          suser_act.service_teamorg_id as org_id,
          suser_act.mtd_consume_cv_cnt as mtd_consume_cv_cnt,
          (suser_act.mtd_consume_cv_target_cnt+suser_act.tm_left_day_consume_cv_target_cnt) as mtd_consume_cv_target_cnt,
           suser_act.mtd_consume_cv_cnt / (suser_act.mtd_consume_cv_target_cnt+suser_act.tm_left_day_consume_cv_target_cnt) as mtd_consume_cv_ratio,
          suser_act.cust_consume_cv_cnt,
          suser_act.cust_consume_cv_target_cnt
       from (
            select 
            base.service_teamorg_id,
            base.rps_user_id,
            sum(case when act.p_date = $date$ then  consume_cv_total_cnt+exchange_cv2lowcv else 0 end) as cust_consume_cv_cnt,
            sum(act.consume_cv_total_cnt+act.exchange_cv2lowcv) as mtd_consume_cv_cnt,
            sum((case when target.left_cnt > 0 then target.day_consume_cv_target_cnt else 0 end) * holiday.is_workday) as mtd_consume_cv_target_cnt,
            sum(case when base.p_date = $date$ then target.day_consume_cv_target_cnt else 0 end) as cust_consume_cv_target_cnt,
            sum(case when base.p_date = $date$ then target.tm_left_day_consume_cv_target_cnt else 0 end) as tm_left_day_consume_cv_target_cnt
          from 
          (select cust.p_date,
                 cust.id,
                 suser.id as rps_user_id,
                 cust.service_teamorg_id 
          from dw_erp_d_customer_base cust 
          join dw_erp_d_salesuser_base suser 
            on cust.serviceuser_id = suser.id 
            and cust.p_date = suser.p_date
            and suser.position_channel = 'A0000603'
          where cust.p_date between {{date[:6]+'01'}} and $date$
            and cust.rsc_valid_status = 1
            and cust.rps_service_version = 1
          ) base 
          left join dw_erp_d_customer_consume_target target 
          on base.id = target.customer_id
          and base.p_date = target.p_date
          left join dw_erp_d_customer_act act 
          on base.id = act.customer_id
          and base.p_date = act.p_date
          join dim_date_holiday holiday on base.p_date = holiday.d_date
          where base.p_date  between  {{date[:6]+'01'}} and $date$ 
          group by base.service_teamorg_id,base.rps_user_id
       ) suser_act
    ) rps_consume
    on  rps_renewal.rps_user_id = rps_consume.rps_user_id
    and  rps_renewal.org_id = rps_consume.org_id
    full join 
    (
      select
        dwejobcandidate.org_id,dwejobcandidate.serviceuser_id as rps_user_id,
        count(case when dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_rps_recommend_cv_cnt,
        count(case when dwejobcandidate.source = 4 then dwejobcandidate.id else null end) as mtd_bole_recommend_cv_cnt,
        count(dwejobcandidate.id) as mtd_recommend_cv_cnt,
        count(case when dwejobcandidate.feedback in (4,2,5) and dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_rps_recommend_satisfied_cv_cnt,
        count(case when dwejobcandidate.feedback in (4,2,5) and dwejobcandidate.source = 4 then dwejobcandidate.id else null end) as mtd_bole_recommend_satisfied_cv_cnt,
        count(case when dwejobcandidate.feedback in (4,2,5) then dwejobcandidate.id else null end) as mtd_recommend_satisfied_cv_cnt,
        count(case when dwejobcandidate.feedback <> 1 then dwejobcandidate.id else null end) as mtd_recommend_deal_cv_cnt,
        count(case when dwejobcandidate.feedback <> 1 and dwejobcandidate.source = 0 then dwejobcandidate.id else null end) / count(case when dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_recommend_cv_deal_ratio
      from  dw_erp_d_ejob_candidate dwejobcandidate 
      join dw_erp_d_customer_base cust on dwejobcandidate.customer_id = cust.id and cust.p_date = $date$ 
      where dwejobcandidate.p_date = $date$
      and dwejobcandidate.source in (0,4)
      and substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$
      group by dwejobcandidate.org_id,dwejobcandidate.serviceuser_id
    ) candidate
    on  rps_renewal.org_id = candidate.org_id
    and rps_renewal.rps_user_id = candidate.rps_user_id
    full join 
    (
    	select base.rps_user_id as rps_user_id,
    		   base.service_teamorg_id as org_id,
    		   sum(is_intention) as consume_intention_cust_cnt,
    		   sum(is_intention) / sum(1) as  consume_intention_cust_ratio,
    		   sum(is_msk) as consume_msk_cust_cnt,
    		   sum(is_msk) / sum(1) as  consume_msk_cust_ratio,
    		   sum(is_invite) as consume_invite_cust_cnt,
    		   sum(is_invite) / sum(1) as  consume_invite_cust_ratio,
    		   sum(is_urgent) as consume_urgent_cust_cnt,
    		   sum(is_urgent) / sum(1) as  consume_urgent_cust_ratio,
    		   sum(is_download_cv) as consume_cv_cust_cnt,
    		   sum(is_download_cv) / sum(1) as consume_cv_cust_ratio,
    		   sum(is_warn_resource_consume_cust_cnt) as warn_resource_consume_cust_cnt
    	  from (select cust.p_date,
                     cust.id ,
                     suser.id as rps_user_id,
                     cust.service_teamorg_id
              from dw_erp_d_customer_base cust 
              join dw_erp_d_salesuser_base suser 
              on cust.serviceuser_id = suser.id 
              and cust.p_date = suser.p_date
              and suser.position_channel = 'A0000603'
              where cust.p_date = $date$
              and cust.rsc_valid_status = 1
              and cust.rps_service_version = 1
              ) base
    	  left join 
    	  ( select customer_id,
    		   		   case when sum(download_cv_cnt) > 0 then 1  else 0 end as is_download_cv,
    				   case when sum(intention_cnt) > 0 then 1  else 0 end as is_intention,
    				   case when sum(msk_cnt) > 0 then 1  else 0 end as is_msk,
    				   case when sum(invite_cnt) > 0 then 1  else 0 end as is_invite,
    				   case when sum(urgent_cnt) > 0 then 1 else 0 end as is_urgent,
    				   case when sum(case when p_date = $date$ then consume_cv_total_cnt else 0 end) > 50 and 
    				   sum(case when p_date = $date$ then day30_consume_cv_total_cnt else 0 end)  = 0 then 1 else 0 end as is_warn_resource_consume_cust_cnt
    		     from dw_erp_d_customer_rps_act
    		    where p_date between  {{date[:6]+'01'}} and $date$ 
    		    group by customer_id
    			) act 	  
    	  on act.customer_id = base.id
    	  group by base.rps_user_id ,
    	  		   base.service_teamorg_id
    ) consume 
    on  rps_renewal.rps_user_id = consume.rps_user_id
    and  rps_renewal.org_id = consume.org_id
    full join
    (
    	select cust.service_teamorg_id as org_id ,cust.rps_user_id,
    		   sum(case when msk.status in (1,3) then showup_cnt else 0 end) as mtd_msk_showup_cnt,
    		   count(case when msk.is_delegation = 1 and msk.delegation_consultant_type = 1 and msk.status = 0 then cust.id else null end) as msk_assess_cnt
    	  from dw_god_d_msk_service msk
    	  left join (
    	  		select god_service_id,sum(showup_cnt) as showup_cnt
    	  		from dw_god_d_msk_service_order_index
    	  		where p_date between {{date[:6]+'01'}} and $date$  
    	  		 and consultant_type = 1
    	  		group by god_service_id
    	  	) msk_order
    	  on msk.god_service_id = msk_order.god_service_id
    	  join (select cust.p_date,
                     cust.id ,
                     suser.id as rps_user_id,
                     cust.service_teamorg_id ,cust.ecomp_root_id
                from dw_erp_d_customer_base cust 
                join dw_erp_d_salesuser_base suser 
                on cust.serviceuser_id = suser.id 
                and cust.p_date = suser.p_date
                and suser.position_channel = 'A0000603'
                where cust.p_date = $date$
                and cust.rsc_valid_status = 1
                and cust.rps_service_version = 1
          ) cust 
    	  on msk.ecomp_root_id = cust.ecomp_root_id
    	 where msk.status in (1,3,0)
    	  and msk.p_date = $date$
    	  group by cust.service_teamorg_id ,cust.rps_user_id
    ) msk 
    on rps_renewal.org_id = msk.org_id
    and rps_renewal.rps_user_id = msk.rps_user_id   
    group by coalesce(rps_renewal.rps_user_id,consume.rps_user_id,msk.rps_user_id,candidate.rps_user_id,rps_call.rps_user_id,rps_consume.rps_user_id),
    		 coalesce(rps_renewal.org_id,consume.org_id,msk.org_id,candidate.org_id,rps_call.org_id,rps_consume.org_id)
) fact1
join dw_erp_d_salesuser_base rps_user 
on  fact1.rps_user_id= rps_user.id 
and rps_user.p_date = $date$
join dim_org_level on fact1.org_id = dim_org_level.d_org_id and dim_org_level.p_date = $date$
join (
 select  int(substr('$date$',7,2)) / int(substr(last_day(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-','01')),9,2)) as time_schedule_ratio 
   from dummy) dt 
on 1=1;

select 
'统计日期',
'招聘服务小组id',
'招聘服务小组名称',
'时间进度',
'本月累计客户消耗的简历数',
'本月累计目标消耗简历数',
'简历消耗率',
'本月累计覆盖客户数',
'名下客户数',
'客户覆盖率',
'当月合同到期当月续约的客户数',
'当月合同未到期 提前在当月续约的客户数',
'当月到期的客户数',
'当月到期客户数中已经提前续约的客户',
'合同期内续约率',
'本月累计推荐简历数',
'简历处理率',
'本月累计有效通话个数',
'本月累计有效通话时长',
'本月人工推荐简历数',
'本月人工推荐简历满意数',
'本月伯乐推荐简历数',
'本月伯乐推荐简历满意数',
'本月累计面试快已到场人数',
'意向沟通使用客户数',
'意向沟通使用比例',
'面试快使用客户数',
'面试快使用比例',
'邀请应聘使用客户数',
'邀请应聘使用比例',
'急聘使用客户数',
'急聘使用比例',
'简历下载使用客户数',
'简历下载使用比例',
'当天组内人数',
'当月组内平均人数'
from dummy;

select 
d_date,
org_id,
org_name,
time_schedule_ratio,
mtd_consume_cv_cnt,
mtd_consume_cv_target_cnt,
mtd_consume_cv_ratio,
mtd_cust_cover_cnt,
cust_cnt,
mtd_cust_cover_ratio,
mtd_expire_renewal_cust_cnt,
mtd_n_expire_renewal_cust_cnt,
mtd_expire_cust_cnt,
mtd_expire_p_renewal_cust_cnt,
mtd_contract_renewal_ratio,
mtd_recommend_cv_cnt,
mtd_recommend_cv_deal_ratio,
mtd_gcdc_valid_call_cnt,
mtd_gcdc_valid_call_timelong,
mtd_rps_recommend_cv_cnt,
mtd_rps_recommend_satisfied_cv_cnt,
mtd_bole_recommend_cv_cnt,
mtd_bole_recommend_satisfied_cv_cnt,
mtd_msk_showup_cnt,
consume_intention_cust_cnt,
consume_intention_cust_ratio,
consume_msk_cust_cnt,
consume_msk_cust_ratio,
consume_invite_cust_cnt,
consume_invite_cust_ratio,
consume_urgent_cust_cnt,
consume_urgent_cust_ratio,
consume_cv_cust_cnt,
consume_cv_cust_ratio,
rps_user_cnt,
avg_rps_user_cnt
from dw_erp_d_rpsorg_act_pre
where p_date in(20170223)

;

select 
'统计日期',
'招服id',
'招服名称',
'招服小组id',
'招服小组名称',
'招服小组上级id',
'组织级次',
'排名对象类型：0-顾问，1-团队',
'本月累计人工推荐简历满意数',
'本月累计人工推荐简历满意数全国排名',
'本月累计人工推荐简历满意数全国排名序号',
'本月累计人工推荐简历满意数组内排名',
'本月累计人工推荐简历满意数组内排名序号',
'本月累计简历消耗率',
'本月累计简历消耗率全国排名',
'本月累计简历消耗率全国排名序号',
'本月累计简历消耗率组内排名',
'本月累计简历消耗率组内排名序号',
'本月累计有效通话时长',
'本月累计有效通话时长全国排名',
'本月累计有效通话时长全国排名序号',
'本月累计有效通话时长组内排名',
'本月累计有效通话时长组内排名序号'
from dummy;

select d_date, rps_user_id, rps_user_name, org_id, org_name, parent_org_id, org_grade, rank_type, mtd_rps_recommend_satisfied_cv_cnt, mtd_rps_recommend_satisfied_rank, mtd_rps_recommend_satisfied_rank_num, mtd_rps_recommend_satisfied_team_rank, mtd_rps_recommend_satisfied_team_rank_num, mtd_consume_cv_ratio, mtd_consume_cv_ratio_rank, mtd_consume_cv_ratio_rank_num, mtd_consume_cv_ratio_team_rank, mtd_consume_cv_ratio_team_rank_num, mtd_gcdc_valid_call_timelong, mtd_gcdc_valid_call_timelong_rank, mtd_gcdc_valid_call_timelong_rank_num, mtd_gcdc_valid_call_timelong_team_rank, mtd_gcdc_valid_call_timelong_team_rank_num
from dw_erp_d_rpsorg_act_detail_rank_pre
where p_date in(20170223);


