create table dw_erp_d_rpsuser_act (
d_date int comment '统计日期',
rps_user_id int comment '招聘服务顾问id',
rps_user_name string comment '招聘服务顾问姓名',
org_id int comment '招聘服务小组id',
org_name string comment '招聘服务小组名称',
branch_id int comment '地区id',
branch_name string comment '地区名称',
position_id int comment '岗位id',
position_name string comment '岗位名称',
time_schedule_ratio float comment '时间进度',
cust_consume_cv_target_cnt  int comment '日目标消耗简历',
cust_consume_cv_cnt int comment '日已消耗简历',
gcdc_valid_call_cnt int comment '日有效通话个数',
gcdc_valid_call_timelong  int comment '日有效通话时长',
rps_cust_cover_cnt  int comment '日客户覆盖数',
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
mtd_consume_cv_cnt  int comment '本月累计客户消耗的简历数',
mtd_consume_cv_target_cnt int comment '本月累计目标消耗简历数',
mtd_consume_cv_ratio  float comment '简历消耗率',
mtd_gcdc_valid_call_cnt int comment '本月累计有效通话个数',
mtd_gcdc_valid_call_timelong int comment '本月累计有效通话时长',
mtd_cust_cover_cnt  int comment '本月累计覆盖客户数',
cust_cnt  int comment '名下客户数',
mtd_cust_no_cover_cnt int comment '当月未覆盖客户数',
mtd_cust_cover_ratio  float comment '客户覆盖率',
mtd_expire_renewal_cust_cnt int comment '当月合同到期当月续约的客户数',
mtd_n_expire_renewal_cust_cnt int comment '当月合同未到期 提前在当月续约的客户数',
mtd_expire_cust_cnt int comment '当月到期的客户数',
mtd_expire_p_renewal_cust_cnt int comment '当月到期客户数中已经提前续约的客户',
mtd_contract_renewal_ratio  float comment '合同期内续约率',
mtd_rps_recommend_cv_cnt int comment '本月人工推荐简历数',
mtd_rps_recommend_satisfied_cv_cnt int comment '本月人工推荐简历满意数',
mtd_bole_recommend_cv_cnt int comment '本月伯乐推荐简历数',
mtd_bole_recommend_satisfied_cv_cnt int comment '本月伯乐推荐简历满意数',
mtd_recommend_deal_cv_cnt int comment '本月推荐且已处理简历数',
mtd_recommend_cv_cnt  int comment '本月累计推荐简历数',
mtd_recommend_cv_deal_ratio float comment '简历处理率',
mtd_recommend_satisfied_cv_cnt  int comment '本月累计推荐简历满意数',
mtd_msk_showup_cnt  int comment '本月累计面试快已到场人数',
callplan_no_finish_cnt  int comment '拨打计划未完成',
task_no_finish_cnt  int comment '待办任务',
intention_no_release_cnt  int comment '意向沟通未释放',
intention_no_submit_cnt int comment '意向沟通未提交',
ejob_no_label_cnt int comment '待标记职位',
ejob_no_tag_cnt int comment '待标签职位',
ejob_recommend_to_manual_cnt  int comment '需rps介入职位',
ejob_7day_recommend_undeal_cnt  int comment '近7天推荐未处理职位',
msk_assess_cnt  int comment '面试快委托未跟进',
cust_break_cnt  int comment '断约客户',
cust_renewal_cnt  int comment '已续约客户',
cust_3month_renewal_cnt int comment '近3个月新签客户数',
cust_3month_expire_cnt  int comment '3个月到期客户数',
cust_renewal_high_cnt int comment '续约意向度高',
cust_renewal_mid_cnt  int comment '续约意向度中',
cust_renewal_low_cnt  int comment '续约意向度低',
cust_renewal_none_cnt int comment '续约意向度无',
tm_satisfied_download_num int comment '本月推荐本月处理-满意并下载数',
tm_satisfied_intention_num int comment '本月推荐本月处理-满意并发起意向沟通数',
tm_unsatisfied_num int comment '本月推荐本月处理-不满意数',
warn_resource_consume_cust_cnt int comment '资源消耗预警客户数',
creation_timestamp  timestamp comment '时间戳'
) comment '招服顾问日行为表'
partitioned by (p_date int);


create table dw_erp_d_rpsuser_act (
d_date int comment '统计日期',
rps_user_id int comment '招聘服务顾问id',
rps_user_name varchar(100) comment '招聘服务顾问姓名',
org_id int comment '招聘服务小组id',
org_name varchar(100) comment '招聘服务小组名称',
branch_id int comment '地区id',
branch_name varchar(100) comment '地区名称',
position_id int comment '岗位id',
position_name varchar(100) comment '岗位名称',
time_schedule_ratio float comment '时间进度',
cust_consume_cv_target_cnt  int comment '日目标消耗简历',
cust_consume_cv_cnt int comment '日已消耗简历',
gcdc_valid_call_cnt int comment '日有效通话个数',
gcdc_valid_call_timelong  int comment '日有效通话时长',
rps_cust_cover_cnt  int comment '日客户覆盖数',
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
mtd_consume_cv_cnt  int comment '本月累计客户消耗的简历数',
mtd_consume_cv_target_cnt int comment '本月累计目标消耗简历数',
mtd_consume_cv_ratio  float comment '简历消耗率',
mtd_gcdc_valid_call_cnt int comment '本月累计有效通话个数',
mtd_gcdc_valid_call_timelong int comment '本月累计有效通话时长',
mtd_cust_cover_cnt  int comment '本月累计覆盖客户数',
cust_cnt  int comment '名下客户数',
mtd_cust_no_cover_cnt int comment '当月未覆盖客户数',
mtd_cust_cover_ratio  float comment '客户覆盖率',
mtd_expire_renewal_cust_cnt int comment '当月合同到期当月续约的客户数',
mtd_n_expire_renewal_cust_cnt int comment '当月合同未到期 提前在当月续约的客户数',
mtd_expire_cust_cnt int comment '当月到期的客户数',
mtd_expire_p_renewal_cust_cnt int comment '当月到期客户数中已经提前续约的客户',
mtd_contract_renewal_ratio  float comment '合同期内续约率',
mtd_rps_recommend_cv_cnt int comment '本月人工推荐简历数',
mtd_rps_recommend_satisfied_cv_cnt int comment '本月人工推荐简历满意数',
mtd_bole_recommend_cv_cnt int comment '本月伯乐推荐简历数',
mtd_bole_recommend_satisfied_cv_cnt int comment '本月伯乐推荐简历满意数',
mtd_recommend_deal_cv_cnt int comment '本月推荐且已处理简历数',
mtd_recommend_cv_cnt  int comment '本月累计推荐简历数',
mtd_recommend_cv_deal_ratio float comment '简历处理率',
mtd_recommend_satisfied_cv_cnt  int comment '本月累计推荐简历满意数',
mtd_msk_showup_cnt  int comment '本月累计面试快已到场人数',
callplan_no_finish_cnt  int comment '拨打计划未完成',
task_no_finish_cnt  int comment '待办任务',
intention_no_release_cnt  int comment '意向沟通未释放',
intention_no_submit_cnt int comment '意向沟通未提交',
ejob_no_label_cnt int comment '待标记职位',
ejob_no_tag_cnt int comment '待标签职位',
ejob_recommend_to_manual_cnt  int comment '需rps介入职位',
ejob_7day_recommend_undeal_cnt  int comment '近7天推荐未处理职位',
msk_assess_cnt  int comment '面试快委托未跟进',
cust_break_cnt  int comment '断约客户',
cust_renewal_cnt  int comment '已续约客户',
cust_3month_renewal_cnt int comment '近3个月新签客户数',
cust_3month_expire_cnt  int comment '3个月到期客户数',
cust_renewal_high_cnt int comment '续约意向度高',
cust_renewal_mid_cnt  int comment '续约意向度中',
cust_renewal_low_cnt  int comment '续约意向度低',
cust_renewal_none_cnt int comment '续约意向度无',
tm_satisfied_download_num int comment '本月推荐本月处理-满意并下载数',
tm_satisfied_intention_num int comment '本月推荐本月处理-满意并发起意向沟通数',
tm_unsatisfied_num int comment '本月推荐本月处理-不满意数',
warn_resource_consume_cust_cnt int comment '资源消耗预警客户数',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,rps_user_id)
) comment '招服顾问日行为表';


insert overwrite table dw_erp_d_rpsuser_act partition (p_date = $date$)
select
$date$ as d_date,
rps_user.id as rps_user_id,
rps_user.name as rps_user_name,
rps_user.org_id as org_id,
rps_user.org_name as org_name,
nvl(dim_org.branch_id,0) as branch_id,
nvl(dim_org.branch_name,'未知') as branch_name,
rps_user.position_id as position_id,
rps_user.position_name as position_name,
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
fact1.tm_satisfied_download_num as tm_satisfied_download_num,
fact1.tm_satisfied_intention_num as tm_satisfied_intention_num,
fact1.tm_unsatisfied_num as tm_unsatisfied_num,
fact1.warn_resource_consume_cust_cnt as warn_resource_consume_cust_cnt,
from_unixtime(unix_timestamp()) as creation_timestamp
from (
    select 
    coalesce(rps_renewal.rps_user_id,consume.rps_user_id,msk.rps_user_id,candidate.rps_user_id,rps_call.rps_user_id,rps_consume.rps_user_id) as rps_user_id,
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
    nvl(sum(rps_call.mtd_cust_cover_cnt),0) / nvl(sum(rps_call.cust_cnt),0) as mtd_cust_cover_ratio,
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
    nvl(sum(candidate.mtd_recommend_deal_cv_cnt)/ sum(candidate.mtd_recommend_cv_cnt),0) as mtd_recommend_cv_deal_ratio,
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
    0 as tm_satisfied_download_num,
    0 as tm_satisfied_intention_num,
    0 as tm_unsatisfied_num,
    nvl(sum(consume.warn_resource_consume_cust_cnt),0) as warn_resource_consume_cust_cnt
    from 
    (
        select rps_user_id,
             sum(expire_renewal_cust_cnt) as mtd_expire_renewal_cust_cnt,
             sum(pre_expire_renewal_cust_cnt) as mtd_n_expire_renewal_cust_cnt,
             sum(expire_cust_cnt) as mtd_expire_cust_cnt,
             sum(expire_pre_renewal_cust_cnt) as mtd_expire_p_renewal_cust_cnt,
            (sum(expire_renewal_cust_cnt) +sum(pre_expire_renewal_cust_cnt)) / (sum(expire_cust_cnt)-sum(expire_pre_renewal_cust_cnt)+ sum(pre_expire_renewal_cust_cnt))  as mtd_contract_renewal_ratio 
          from fact_h_gcdc_d_renewal_rpsuser
         where d_date = $date$
         group by rps_user_id
    ) rps_renewal
    full join 
    (
      select 
          base.serviceuser_id as rps_user_id,
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
      and base.rsc_valid_status = 1
      and base.rps_service_version = 1
      group by base.serviceuser_id
    ) rps_call
    on rps_renewal.rps_user_id = rps_call.rps_user_id
    full join 
    (
      select  
          suser_act.serviceuser_id as rps_user_id,
          suser_act.mtd_consume_cv_cnt as mtd_consume_cv_cnt,
          suser_act.mtd_consume_cv_target_cnt as mtd_consume_cv_target_cnt,
          suser_act.mtd_consume_cv_cnt / suser_act.mtd_consume_cv_target_cnt as mtd_consume_cv_ratio,
          suser_act.cust_consume_cv_cnt,
          suser_act.cust_consume_cv_target_cnt
       from (
            select 
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
          and base.rsc_valid_status = 1
          and base.rps_service_version = 1
          group by base.serviceuser_id
       ) suser_act
    ) rps_consume
    on  rps_renewal.rps_user_id = rps_consume.rps_user_id
    full join 
    (
      select
        dwejobcandidate.serviceuser_id as rps_user_id,
        count(case when dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_rps_recommend_cv_cnt,
        count(case when dwejobcandidate.source = 4 then dwejobcandidate.id else null end) as mtd_bole_recommend_cv_cnt,
        count(dwejobcandidate.id) as mtd_recommend_cv_cnt,
        count(case when dwejobcandidate.feedback in (4,2,5) and dwejobcandidate.source = 0 then dwejobcandidate.id else null end) as mtd_rps_recommend_satisfied_cv_cnt,
        count(case when dwejobcandidate.feedback in (4,2,5) and dwejobcandidate.source = 4 then dwejobcandidate.id else null end) as mtd_bole_recommend_satisfied_cv_cnt,
        count(case when dwejobcandidate.feedback in (4,2,5) then dwejobcandidate.id else null end) as mtd_recommend_satisfied_cv_cnt,
        count(case when dwejobcandidate.feedback <> 1 then dwejobcandidate.id else null end) as mtd_recommend_deal_cv_cnt
      from  dw_erp_d_ejob_candidate dwejobcandidate  
      join dw_erp_d_customer_base cust on dwejobcandidate.customer_id = cust.id and cust.p_date = $date$ and cust.rsc_valid_status = 1 and cust.rps_service_version = 1
      where dwejobcandidate.p_date = $date$
      and substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$
      group by dwejobcandidate.serviceuser_id
    ) candidate
    on  rps_renewal.rps_user_id = candidate.rps_user_id
    full join 
    (
      select base.serviceuser_id as rps_user_id,
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
        group by base.serviceuser_id 
    ) consume 
    on  rps_renewal.rps_user_id = consume.rps_user_id
    full join
    (
      select cust.serviceuser_id as rps_user_id,
           sum(case when msk.status in (1,3) then showup_cnt else 0 end) as mtd_msk_showup_cnt,
           count(case when msk.is_delegation = 1 and msk.delegation_consultant_type = 1 and msk.status = 0 then id else null end) as msk_assess_cnt
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
        group by cust.serviceuser_id
    ) msk 
    on rps_renewal.rps_user_id = msk.rps_user_id
    group by coalesce(rps_renewal.rps_user_id,consume.rps_user_id,msk.rps_user_id,candidate.rps_user_id,rps_call.rps_user_id,rps_consume.rps_user_id)
) fact1
join dw_erp_d_salesuser_base rps_user 
on  rps_user.id = fact1.rps_user_id
and rps_user.p_date = $date$
join dim_org 
on rps_user.org_id = dim_org.d_org_id
join (
 select  int(substr('$date$',7,2)) / int(substr(last_day(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-','01')),9,2)) as time_schedule_ratio 
   from dummy) dt on 1=1;