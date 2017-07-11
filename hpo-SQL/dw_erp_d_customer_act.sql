create table dw_erp_d_customer_rps_act
(
d_date int comment '分析日期',
customer_id int comment '客户ID',
customer_name string comment '客户名称',
industry string comment '所属行业',
dq string comment '所属地区',
salesuser_id int comment '负责销售',
salesuser_name string comment '负责销售名称',
salesorg_id int comment '负责销售组织',
salesorg_name string comment '负责销售组织名称',
salesbranch_id int comment '负责销售城市',
salesbranch_name string comment '负责销售城市名称',
serviceuser_id int comment '负责招服',
serviceuser_name string comment '负责招服名称',
service_teamorg_id int comment '负责招服组织',
service_teamorg_name string comment '负责招服组织名称',
service_branch_id int comment '负责招服城市',
service_branch_name string comment '负责招服城市名称',
rps_service_version int comment 'rps服务版本:0：不服务 ,1：服务版, 2：服务过期版,3：服务版未到期',
rsc_valid_status int comment '招服服务的客户有效标示',
is_certificate int comment '是否认证',
ecomp_version string comment '企业版本',
ecomp_id int comment '猎聘通编号',
ecomp_root_id int comment '猎聘通主编号',
lpt_service_effect_date string comment '猎聘通服务开始时间',
lpt_service_expired_date string comment '猎聘通服务结束时间',
is_opp int comment '目前处于商机中',
is_lpt_in_service int comment '是否合作中',
is_lpt_expire int COMMENT '是否即将到期', 
is_new_contract_3months int COMMENT '是否3个月内新签', 
top_mark string comment '客户TOP标识',
top_mark_max string comment '客户TOP标识等级',
consume_cv_total_cnt int comment '综合消耗数',
lpt_used_activity int comment '使用深度',
is_login int comment '当天是否登陆',
day30_consume_cv_total_cnt int comment '近30天综合消耗数',
day30_is_login int comment '近30天登陆天数',
new_ejob_cnt int comment '职位发布数',
search_cv_cnt int comment '简历搜索次数',
view_cv_cnt int comment '简历浏览次数',
download_cv_cnt int comment '简历下载次数',
intention_cnt int comment '意向沟通数',
msk_cnt int comment '面试快发起数',
invite_cnt int comment '邀请应聘数',
urgent_cnt int comment '急聘数',
outer_sr_job_cnt int comment '外部精英职位数',
outer_jr_job_cnt int comment '外部白领职位数',
view_sr_cv_cnt int comment '浏览中高端简历数',
view_jr_cv_cnt int comment '浏览初级简历数',
download_jr_cv_cnt int comment '下载初级简历数',
valid_cover_cnt int comment '有效覆盖次数',
resource_total_cnt int comment '有效资源总数-换算成简历',
resource_consume_day_target_cnt int comment '资源消耗日目标数',
creation_timestamp timestamp COMMENT '时间戳'
) comment '有招服的客户实体行为表' 
partitioned by (p_date int);

alter table dw_erp_d_customer_rps_act change 30day_consume_cv_total_cnt day30_consume_cv_total_cnt int comment '近30天综合消耗数' cascade;
alter table dw_erp_d_customer_rps_act change 30day_is_login day30_is_login int comment '近30天登陆天数' cascade;

alter table dw_erp_d_customer_rps_act change 30day_consume_cv_total_cnt day30_consume_cv_total_cnt int comment '近30天综合消耗数';
alter table dw_erp_d_customer_rps_act change 30day_is_login day30_is_login int comment '近30天登陆天数';



create table dw_erp_d_customer_rps_act
(
d_date int comment '分析日期',
customer_id int comment '客户ID',
customer_name varchar(100) comment '客户名称',
industry varchar(100) comment '所属行业',
dq varchar(100) comment '所属地区',
salesuser_id int comment '负责销售',
salesuser_name varchar(100) comment '负责销售名称',
salesorg_id int comment '负责销售组织',
salesorg_name varchar(100) comment '负责销售组织名称',
salesbranch_id int comment '负责销售城市',
salesbranch_name varchar(100) comment '负责销售城市名称',
serviceuser_id int comment '负责招服',
serviceuser_name varchar(100) comment '负责招服名称',
service_teamorg_id int comment '负责招服组织',
service_teamorg_name varchar(100) comment '负责招服组织名称',
service_branch_id int comment '负责招服城市',
service_branch_name varchar(100) comment '负责招服城市名称',
rps_service_version int comment 'rps服务版本:0：不服务 ,1：服务版, 2：服务过期版,3：服务版未到期',
rsc_valid_status int comment '招服服务的客户有效标示',
is_certificate int comment '是否认证',
ecomp_version varchar(100) comment '企业版本',
ecomp_id int comment '猎聘通编号',
ecomp_root_id int comment '猎聘通主编号',
lpt_service_effect_date varchar(100) comment '猎聘通服务开始时间',
lpt_service_expired_date varchar(100) comment '猎聘通服务结束时间',
is_opp int comment '目前处于商机中',
is_lpt_in_service int comment '是否合作中',
is_lpt_expire int COMMENT '是否即将到期', 
is_new_contract_3months int COMMENT '是否3个月内新签', 
top_mark varchar(100) comment '客户TOP标识',
top_mark_max varchar(100) comment '客户TOP标识等级',
consume_cv_total_cnt int comment '综合消耗数',
lpt_used_activity int comment '使用深度',
is_login int comment '当天是否登陆',
day30_consume_cv_total_cnt int comment '近30天综合消耗数',
day30_is_login int comment '近30天登陆天数',
new_ejob_cnt int comment '职位发布数',
search_cv_cnt int comment '简历搜索次数',
view_cv_cnt int comment '简历浏览次数',
download_cv_cnt int comment '简历下载次数',
intention_cnt int comment '意向沟通数',
msk_cnt int comment '面试快发起数',
invite_cnt int comment '邀请应聘数',
urgent_cnt int comment '急聘数',
outer_sr_job_cnt int comment '外部精英职位数',
outer_jr_job_cnt int comment '外部白领职位数',
view_sr_cv_cnt int comment '浏览中高端简历数',
view_jr_cv_cnt int comment '浏览初级简历数',
download_jr_cv_cnt int comment '下载初级简历数',
valid_cover_cnt int comment '有效覆盖次数',
resource_total_cnt int comment '有效资源总数-换算成简历',
resource_consume_day_target_cnt int comment '资源消耗日目标数',
creation_timestamp timestamp default CURRENT_TIMESTAMP comment'时间戳',
primary key (d_date,customer_id)
) comment '有招服的客户实体行为表';

insert overwrite table dw_erp_d_customer_rps_act partition (p_date = $date$)
select 
act.d_date,
act.customer_id,
act.customer_name,
act.industry,
act.dq,
act.salesuser_id,
act.salesuser_name,
act.salesorg_id,
act.salesorg_name,
-1 as salesbranch_id,
'字段弃用'  as salesbranch_name,
act.serviceuser_id,
act.serviceuser_name,
act.service_teamorg_id,
act.service_teamorg_name,
act.service_branch_id,
act.service_branch_name,
act.rsc_service_version,
act.rsc_valid_status,
act.is_certificate,
act.ecomp_version,
act.ecomp_id,
act.ecomp_root_id,
act.lpt_service_effect_date,
act.lpt_service_expired_date,
act.is_opp,
act.is_lpt_in_service,
act.is_lpt_expire,
act.is_new_contract_3months,
act.top_mark,
act.top_mark_max,
act.consume_cv_total_cnt,
act.lpt_used_activity,
act.is_login,
nvl(day30.day30_consume_cv_total_cnt,0) as day30_consume_cv_total_cnt,
nvl(day30.day30_is_login,0) as day30_is_login,
act.new_ejob_cnt,
act.search_cv_cnt,
act.view_cv_cnt,
act.download_cv_cnt,
act.intention_cnt,
act.msk_cnt,
act.invite_cnt,
act.urgent_cnt,
act.outer_sr_job_cnt,
act.outer_jr_job_cnt,
act.view_sr_cv_cnt,
act.view_jr_cv_cnt,
act.download_jr_cv_cnt,
act.valid_cover_cnt,
0 as resource_total_cnt,
0 as resource_consume_day_target_cnt,
act.creation_timestamp
from dw_erp_d_customer_act act 
left join (
select customer_id,
		sum(is_login) as day30_is_login,
		sum(consume_cv_total_cnt) as day30_consume_cv_total_cnt
 from dw_erp_d_customer_act
 where p_date between {{delta(date,-30)}} and $date$
 group by customer_id
) day30 
on act.customer_id = day30.customer_id
where p_date = $date$
and act.serviceuser_id not in  (0,-1);



insert overwrite table dw_erp_d_customer_rps_act partition (p_date)
select 
act.d_date,
act.customer_id,
act.customer_name,
act.industry,
act.dq,
act.salesuser_id,
act.salesuser_name,
act.salesorg_id,
act.salesorg_name,
-1 as salesbranch_id,
'字段弃用'  as salesbranch_name,
act.serviceuser_id,
act.serviceuser_name,
act.service_teamorg_id,
act.service_teamorg_name,
act.service_branch_id,
act.service_branch_name,
act.rsc_service_version,
act.rsc_valid_status,
act.is_certificate,
act.ecomp_version,
act.ecomp_id,
act.ecomp_root_id,
act.lpt_service_effect_date,
act.lpt_service_expired_date,
act.is_opp,
act.is_lpt_in_service,
act.is_lpt_expire,
act.is_new_contract_3months,
act.top_mark,
act.top_mark_max,
act.consume_cv_total_cnt,
act.lpt_used_activity,
act.is_login,
-1 as day30_consume_cv_total_cnt,
-1 as day30_is_login,
act.new_ejob_cnt,
act.search_cv_cnt,
act.view_cv_cnt,
act.download_cv_cnt,
act.intention_cnt,
act.msk_cnt,
act.invite_cnt,
act.urgent_cnt,
act.outer_sr_job_cnt,
act.outer_jr_job_cnt,
act.view_sr_cv_cnt,
act.view_jr_cv_cnt,
act.download_jr_cv_cnt,
act.valid_cover_cnt,
0 as resource_total_cnt,
0 as resource_consume_day_target_cnt,
act.creation_timestamp,
act.p_date
from dw_erp_d_customer_act act 
where p_date between 20161201 and 20161212
and act.serviceuser_id not in  (0,-1);




alter table dw_erp_d_customer_act add columns(
serviceuser_id int comment '负责招服',
serviceuser_name string comment '负责招服名称',
service_position_id int comment '负责招服城市',
service_position_name string comment '负责招服城市名称',
service_teamorg_id int comment '负责招服组织',
service_teamorg_name string comment '负责招服组织名称',
service_branch_id int comment '负责招服城市',
service_branch_name string comment '负责招服城市名称',
rsc_service_version int comment 'rps服务版本:0：不服务 ,1：服务版, 2：服务过期版,3：服务版未到期',
rsc_valid_status int comment '招服服务的客户有效标示'
) cascade;

alter table dw_erp_d_customer_act add columns( exchange_cv2lowcv int comment '兑换白领简历消耗的精英简历下载数') cascade;

create table dw_erp_d_customer_act
(
d_date int comment '分析日期',
customer_id int comment '客户ID',
customer_name string comment '客户名称',
industry string comment '所属行业',
dq string comment '所属地区',
salesuser_id int comment '负责销售',
salesuser_name string comment '负责销售名称',
salesorg_id int comment '负责销售组织',
salesorg_name string comment '负责销售组织名称',
is_certificate int comment '是否认证',
ecomp_version string comment '企业版本',
ecomp_id int comment '猎聘通编号',
ecomp_root_id int comment '猎聘通主编号',
lpt_service_effect_date string comment '猎聘通服务开始时间',
lpt_service_expired_date string comment '猎聘通服务结束时间',
is_lpt_in_service int comment '是否合作中',
is_lpt_expire int COMMENT '是否即将到期', 
is_new_contract_3months int COMMENT '是否3个月内新签', 
top_mark string comment '客户TOP标识',
top_mark_max string comment '客户TOP标识等级',
consume_cv_total_cnt int comment '综合消耗数',
lpt_used_activity int comment '使用深度',
is_login int comment '当天是否登陆',
new_ejob_cnt int comment '职位发布数',
search_cv_cnt int comment '简历搜索次数',
view_cv_cnt int comment '简历浏览次数',
download_cv_cnt int comment '简历下载次数',
intention_cnt int comment '意向沟通数',
msk_cnt int comment '面试快发起数',
invite_cnt int comment '邀请应聘数',
urgent_cnt int comment '急聘数',
outer_sr_job_cnt int comment '外部精英职位数',
outer_jr_job_cnt int comment '外部白领职位数',
view_sr_cv_cnt int comment '浏览中高端简历数',
view_jr_cv_cnt int comment '浏览初级简历数',
download_jr_cv_cnt int comment '下载初级简历数',
valid_cover_cnt int comment '有效覆盖次数',
is_opp int comment '目前处于商机中',
creation_timestamp timestamp COMMENT '时间戳'
) comment '客户实体行为表' 
partitioned by (p_date int);

alter table dw_erp_d_customer_act change valid_cover_cnt valid_cover_cnt int comment '销售顾问有效覆盖次数';

alter table dw_erp_d_customer_act add columns(
rps_valid_cover_cnt int comment '招服有效覆盖客户次数',
rps_recommend_cv_cnt int comment '人工推荐简历数',
rps_recommend_satisfied_cv_cnt int comment '人工推荐简历满意数',
bole_recommend_cv_cnt int comment '伯乐推荐简历数',
bole_recommend_satisfied_cv_cnt int comment '伯乐推荐简历满意数'
) cascade;

insert overwrite table dw_erp_d_customer_act partition (p_date = $date$)
select 
	$date$ as d_date,
	base.id as customer_id,
	base.name as customer_name,
	base.industry as industry,
	base.dq as dq,
	base.sales_user_id as salesuser_id,
	base.sales_user_name as salesuser_name,
	base.sales_org_id as salesorg_id,
	base.sales_org_name as salesorg_name,
	case when nvl(base.company_certificate,'-1') = '-1' or base.company_certificate = '' then 0 else 1 end as  is_certificate,
	base.ecomp_version as ecomp_version,
	base.ecomp_id as ecomp_id,
	base.ecomp_root_id as ecomp_root_id,
	nvl(lptservice.lp_startdate,'1900-01-01') as lpt_service_effect_date,
	nvl(lptservice.lp_enddate,'1900-01-01') as lpt_service_expired_date,
	case when base.ecomp_version in (2,3) then 1 else 0 end  as is_lpt_in_service,
	case when cal_days('$date$' ,regexp_replace(lpt_service_expired_date,'-','')) between 0 and 90  then 1 else 0 end as is_lpt_expire,
	case when custstatus.new_contract_3months > 0 then 1 else 0 end as is_new_contract_3months,
	base.top_mark as top_mark,
	case when instr(reverse(base.top_mark),'1') > 0 then 7-instr(reverse(base.top_mark),'1') else 0 end as top_mark_max,
	nvl(ecomp_resource.consume_cv_total_cnt,0) as consume_cv_total_cnt,
	10*nvl(ecomp_resource.intention_cnt,0) + 100* nvl(ecomp_resource.msk_cnt,0) + 5*nvl(ecomp_resource.download_cv_cnt,0) + 60*nvl(ecomp_resource.invite_cnt,0) +nvl(view.view_sr_cv_cnt +view.view_jr_cv_cnt,0)*50*nvl(ecomp_resource.urgent_cnt,0)+ 10*nvl(sch.search_cv_cnt,0) + 30*nvl(ejob.new_ejob_cnt,0) as lpt_used_activity,
	nvl(login.is_login,0) as is_login,
	nvl(ejob.new_ejob_cnt,0) as new_ejob_cnt,
	nvl(sch.search_cv_cnt,0) as search_cv_cnt,
	nvl(view.view_sr_cv_cnt +view.view_jr_cv_cnt,0) as view_cv_cnt,
	nvl(ecomp_resource.download_cv_cnt,0) as download_cv_cnt,
	nvl(ecomp_resource.intention_cnt,0) as intention_cnt,
	nvl(msk.msk_cnt,0) as msk_cnt,
	nvl(ecomp_resource.invite_cnt,0) as invite_cnt,
	nvl(ecomp_resource.urgent_cnt,0) as urgent_cnt,
	nvl(behavior.outer_sr_job_cnt,0) as outer_sr_job_cnt,
	nvl(behavior.outer_jr_job_cnt,0) as outer_jr_job_cnt,
	nvl(view.view_sr_cv_cnt,0) as view_sr_cv_cnt,
	nvl(view.view_jr_cv_cnt,0) as view_jr_cv_cnt,
	nvl(ecomp_resource.download_jr_cv_cnt,0) as download_jr_cv_cnt,
	nvl(cover.valid_cover_cnt,0) as valid_cover_cnt,
	case when opp.customer_id is not null then 1 else 0 end as is_opp,
	from_unixtime(unix_timestamp()) as creation_timestamp,
	base.serviceuser_id,
	base.serviceuser_name,
	suser.position_id as service_position_id,
	suser.position_name as service_position_name,
	base.service_teamorg_id,
	base.service_teamorg_name,
	base.service_branch_id,
	base.service_branch_name,
	base.rps_service_version,
	base.rsc_valid_status,
	nvl(ecomp_resource.exchange_cv2lowcv,0) as exchange_cv2lowcv,	
	nvl(track.rps_valid_cover_cnt,0) as rps_valid_cover_cnt,
	nvl(candidate.rps_recommend_cv_cnt,0) as rps_recommend_cv_cnt,
	nvl(candidate.rps_recommend_satisfied_cv_cnt,0) as rps_recommend_satisfied_cv_cnt,
	nvl(candidate.bole_recommend_cv_cnt,0) as bole_recommend_cv_cnt,
	nvl(candidate.bole_recommend_satisfied_cv_cnt,0) as bole_recommend_satisfied_cv_cnt
 from dw_erp_d_customer_base base
 left join 
 (select customer_id,
		 min(lpt_service_effect_date) lpt_service_effect_date,
		 max(lpt_service_expired_date) lpt_service_expired_date,
		 sum(case when cal_days(regexp_replace(sign_date,'-',''),'$date$') between 0 and 90  then 1 else 0 end ) as new_contract_3months
 from dw_erp_d_contract_base
  where p_date =  '$date$'
  and subaction = 0
  and status in (2,3)
  and lpt_service_effect_date not in ('--','1900-01-01')
  group by customer_id
)  custstatus 
 on base.id = custstatus.customer_id
left join  dw_b_d_ecomp_resource_base lptservice
  on  lptservice.p_date = '$date$'
  and base.ecomp_id = lptservice.ecomp_id
left join (
	select ecomp_root_id,case when sum(active_usere_cnt) > 0 then 1 else 0 end as is_login
	from dw_b_d_ecomp_act ul
	where ul.p_date = $date$
	group by ecomp_root_id
) login
on base.ecomp_id = login.ecomp_root_id
left join (
	select ecomp_root_id,sum(search_cnt) as search_cv_cnt
	from (
	select actor_id as usere_id,
		count(distinct case when get_json_object(action_info,'$.cur_page') = '0' then get_json_object(action_info,'$.condition_key') end) as search_cnt
	from blog bl
	where action_kind = 'SEARCH-RESUME'
		and p_date = $date$
		and get_json_object(system_info, '$.clientId') = '20006' --企业用户搜索
	group by actor_id
	) bl 
	join dw_b_d_ecomp_usere_base base 
	on bl.usere_id = base.usere_id
	and base.p_date = $date$
	group by base.ecomp_root_id
) sch
on base.ecomp_id = sch.ecomp_root_id
left join (
	select ecomp_root_id,
	count(case when is_new_publish = 1 then ejob_id end) as new_ejob_cnt
	from dw_b_d_ejob_act 
	where p_date = $date$
	group by ecomp_root_id
) ejob
on base.ecomp_id = ejob.ecomp_root_id
left join 
(select ev.ecomp_root_id,count(distinct case when res_level in ('2','3','4','5','6') then ev.res_id end ) as view_sr_cv_cnt,
                        count(distinct case when res_level in('0','1') then ev.res_id end ) as view_jr_cv_cnt
from  e_cv_view_hive ev 
join res_user ru on ev.res_id = ru.res_id 
where substr(ev.ur_createtime,1,8)  = '$date$'
and p_date = '$date$'
group by ev.ecomp_root_id
) view 
on base.ecomp_id = view.ecomp_root_id
left join (
select ecomp_root_id,
	   sum(consume_cv) as download_cv_cnt,
	   sum(consume_cv + consume_cvcoupon + consume_intention * 2 + consume_invite * 50 + consume_mskcoupon * 50 + consume_intention_cv + consume_invite_cv + consume_urgent_cv + consume_msk_cv + consume_mskplus_cv + consume_rzk_cv) as consume_cv_total_cnt,
	   sum(intention_cnt) as intention_cnt,
	   sum(msk_cnt) as msk_cnt,
	   sum(invite_cnt) as invite_cnt,
	   sum(urgent_cnt) as urgent_cnt,
      sum(lowcv_download_cnt) as download_jr_cv_cnt,
      sum(exchange_cv2lowcv) as exchange_cv2lowcv
from dw_b_d_resource_consume
where p_date = '$date$'
group by ecomp_root_id
) ecomp_resource
on base.ecomp_id = ecomp_resource.ecomp_root_id
left join
(select gm.ecomp_root_id,
		count(case 
				when substr(regexp_replace(gm.launchtime, '-', ''), 1, 8) = '$date$'
					then gm.god_service_id
				end) as msk_cnt
	from dw_god_d_msk_service gm
	where gm.p_date = $date$
	  and substr(regexp_replace(gm.launchtime, '-', ''), 1, 8) = '$date$'
	group by gm.ecomp_root_id
) msk 
on base.ecomp_id = msk.ecomp_root_id
left join dw_erp_d_customer_behavior behavior 
on base.id = behavior.id
and behavior.p_date = '$date$'
left join dw_erp_d_customer_cover_act cover
on base.id = cover.customer_id
and cover.p_date = '$date$'
left join 
(select customer_id
   from dw_erp_d_opportunity_base
   where process_status not in (8,9)
   and p_date = '$date$'
   group by customer_id) opp 
on base.id = opp.customer_id
left join dw_erp_d_salesuser_base suser 
on base.serviceuser_id = suser.id 
and suser.p_date = $date$
left join 
(select customer_id,
		count(case when can.source = 0 and substr(regexp_replace(can.createtime,'-',''),1,8) = '$date$' then can.id else null end) as rps_recommend_cv_cnt, 		
		count(case when can.source = 0 and substr(regexp_replace(can.handletime,'-',''),1,8) = '$date$' and can.feedback in (4,2,5) then id else null end) as rps_recommend_satisfied_cv_cnt,
		count(case when can.source = 4 and substr(regexp_replace(can.createtime,'-',''),1,8) = '$date$' then can.id else null end) as bole_recommend_cv_cnt, 		
		count(case when can.source = 4 and substr(regexp_replace(can.handletime,'-',''),1,8) = '$date$' and can.feedback in (4,2,5) then id else null end) as bole_recommend_satisfied_cv_cnt
  from dw_erp_d_ejob_candidate can
  where p_date = '$date$'
    and (substr(regexp_replace(can.createtime,'-',''),1,8) = '$date$'
    	or substr(regexp_replace(can.handletime,'-',''),1,8) = '$date$'
    	)
    and source in (0,4)
  group by customer_id
 ) candidate
on base.id = candidate.customer_id
left join 
 (select creator_id as rps_user_id,customer_id,count(id) as rps_valid_cover_cnt
   from track 
  where substr(regexp_replace(track.createtime,'-',''),1,8) = '$date$'
    and creator_role = 2
  group by creator_id ,customer_id) track 
on base.id = track.customer_id
and base.serviceuser_id = track.rps_user_id
where base.p_date = '$date$';

insert overwrite table dw_erp_d_customer_act partition(p_date)
select 
customer_act.d_date,
customer_act.customer_id,
customer_act.customer_name,
customer_act.industry,
customer_act.dq,
customer_act.salesuser_id,
customer_act.salesuser_name,
customer_act.salesorg_id,
customer_act.salesorg_name,
customer_act.is_certificate,
customer_act.ecomp_version,
customer_act.ecomp_id,
customer_act.ecomp_root_id,
customer_act.lpt_service_effect_date,
customer_act.lpt_service_expired_date,
customer_act.is_lpt_in_service,
customer_act.is_lpt_expire,
customer_act.is_new_contract_3months,
customer_act.top_mark,
customer_act.top_mark_max,
customer_act.consume_cv_total_cnt,
customer_act.lpt_used_activity,
customer_act.is_login,
customer_act.new_ejob_cnt,
customer_act.search_cv_cnt,
customer_act.view_cv_cnt,
customer_act.download_cv_cnt,
customer_act.intention_cnt,
customer_act.msk_cnt,
customer_act.invite_cnt,
customer_act.urgent_cnt,
customer_act.outer_sr_job_cnt,
customer_act.outer_jr_job_cnt,
customer_act.view_sr_cv_cnt,
customer_act.view_jr_cv_cnt,
customer_act.download_jr_cv_cnt,
customer_act.valid_cover_cnt,
customer_act.is_opp,
customer_act.creation_timestamp,
customer_act.serviceuser_id,
customer_act.serviceuser_name,
customer_act.service_position_id,
customer_act.service_position_name,
customer_act.service_teamorg_id,
customer_act.service_teamorg_name,
customer_act.service_branch_id,
customer_act.service_branch_name,
customer_act.rsc_service_version,
customer_act.rsc_valid_status,
nvl(ecomp_resource.exchange_cv2lowcv,0) as exchange_cv2lowcv,
customer_act.p_date
from dw_erp_d_customer_act customer_act 
left join 
(select customer_id,
		count(case when can.source = 0 and substr(regexp_replace(can.createtime,'-',''),1,8) = '$date$' then can.id else null end) as rps_recommend_cv_cnt, 		
		count(case when can.source = 0 and substr(regexp_replace(can.handletime,'-',''),1,8) = '$date$' and can.feedback in (4,2,5) then id else null end) as rps_recommend_satisfied_cv_cnt,
		count(case when can.source = 4 and substr(regexp_replace(can.createtime,'-',''),1,8) = '$date$' then can.id else null end) as bole_recommend_cv_cnt, 		
		count(case when can.source = 4 and substr(regexp_replace(can.handletime,'-',''),1,8) = '$date$' and can.feedback in (4,2,5) then id else null end) as bole_recommend_satisfied_cv_cnt
  from dw_erp_d_ejob_candidate can
  where p_date = 20170228
    and (substr(regexp_replace(can.createtime,'-',''),1,8) = '$date$'
    	or substr(regexp_replace(can.handletime,'-',''),1,8) = '$date$'
    	)
    and source in (0,4)

  group by customer_id,
 ) candidate
on base.id = candidate.customer_id
left join 
 (select creator_id as rps_user_id,customer_id,count(id) as rps_valid_cover_cnt
   from track 
  where substr(regexp_replace(track.createtime,'-',''),1,8) = '$date$'
    and creator_role = 2
  group by creator_id ,customer_id) track 
on base.id = track.customer_id
and base.serviceuser_id = track.rps_user_id
on customer_act.ecomp_id = ecomp_resource.ecomp_root_id
and customer_act.p_date = ecomp_resource.p_date
where customer_act.p_date between 20170201 and 20170228;


insert overwrite table dw_erp_d_customer_act partition (p_date)
select d_date, customer_id, customer_name, industry, dq, salesuser_id, salesuser_name, salesorg_id, salesorg_name, is_certificate, ecomp_version, ecomp_id, ecomp_root_id, lpt_service_effect_date, lpt_service_expired_date, is_lpt_in_service, is_lpt_expire, is_new_contract_3months, top_mark, top_mark_max, consume_cv_total_cnt, lpt_used_activity, is_login, new_ejob_cnt, search_cv_cnt, view_cv_cnt, download_cv_cnt, intention_cnt, msk_cnt, invite_cnt, urgent_cnt, outer_sr_job_cnt, outer_jr_job_cnt, view_sr_cv_cnt, view_jr_cv_cnt, download_jr_cv_cnt, valid_cover_cnt, is_opp, creation_timestamp, serviceuser_id, serviceuser_name, service_position_id, service_position_name, service_teamorg_id, service_teamorg_name, service_branch_id, service_branch_name, rsc_service_version, rsc_valid_status, rps_valid_cover_cnt,exchange_cv2lowcv,rps_recommend_cv_cnt, rps_recommend_satisfied_cv_cnt, bole_recommend_cv_cnt, bole_recommend_satisfied_cv_cnt, p_date
from dw_erp_d_customer_act
where p_date between 20170201 and 20170305