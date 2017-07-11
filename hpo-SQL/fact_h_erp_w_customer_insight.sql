insert overwrite table fact_h_erp_w_customer_insight_bak partition (p_date)
select d_date, customer_id, customer_name, industry, dq, salesuser_id, salesuser_name, salesorg_id, salesorg_name, is_certificate, ecomp_version, ecomp_id, ecomp_root_id, lpt_service_effect_date, lpt_service_expired_date, is_lpt_expire, is_new_contract_3months, top_mark_max, is_top_mark_level1, is_top_mark_level2, is_top_mark_level3, is_top_mark_level4, is_top_mark_level5, is_top_mark_level6, consume_cv_total_cnt, lpt_used_activity, login_cnt, new_ejob_cnt, search_cv_cnt, view_cv_cnt, download_cv_cnt, intention_cnt, msk_cnt, invite_cnt, urgent_cnt, outer_sr_job_cnt, outer_jr_job_cnt, view_sr_cv_cnt, view_jr_cv_cnt, download_jr_cv_cnt, valid_cover_cnt, is_opp, creation_timestamp, is_lpt_in_service, p_date
from fact_h_erp_w_customer_insight;

alter table fact_h_erp_w_customer_insight rename to fact_h_erp_w_customer_insight_0228;
alter table fact_h_erp_w_customer_insight_bak rename to fact_h_erp_w_customer_insight;

CREATE TABLE fact_h_erp_w_customer_insight(
 d_date int COMMENT'分析日期', 
 customer_id int COMMENT'客户id', 
 customer_name string COMMENT'客户名称', 
 industry string COMMENT'所属行业', 
 dq string COMMENT'所属地区', 
 salesuser_id int COMMENT'负责销售', 
 salesuser_name string COMMENT'负责销售名称', 
 salesorg_id int COMMENT'负责销售组织', 
 salesorg_name string COMMENT'负责销售组织名称', 
 is_certificate int COMMENT'是否认证', 
 ecomp_version string COMMENT'企业版本', 
 ecomp_id int COMMENT'猎聘通编号', 
 ecomp_root_id int COMMENT'猎聘通主编号', 
 lpt_service_effect_date string COMMENT'猎聘通服务开始时间', 
 lpt_service_expired_date string COMMENT'猎聘通服务结束时间', 
 is_lpt_expire int COMMENT'是否即将到期', 
 is_new_contract_3months int COMMENT'是否3个月内新签', 
 top_mark_max int COMMENT'客户top标识最高级', 
 is_top_mark_level1 int COMMENT'是否top1', 
 is_top_mark_level2 int COMMENT'是否top2', 
 is_top_mark_level3 int COMMENT'是否top3', 
 is_top_mark_level4 int COMMENT'是否top4', 
 is_top_mark_level5 int COMMENT'是否top5', 
 is_top_mark_level6 int COMMENT'是否top6', 
 consume_cv_total_cnt int COMMENT'综合消耗资源数', 
 lpt_used_activity int COMMENT'使用深度', 
 login_cnt int COMMENT'登陆天数', 
 new_ejob_cnt int COMMENT'职位发布数', 
 search_cv_cnt int COMMENT'简历搜索次数', 
 view_cv_cnt int COMMENT'简历浏览次数', 
 download_cv_cnt int COMMENT'简历下载次数', 
 intention_cnt int COMMENT'意向沟通数', 
 msk_cnt int COMMENT'面试快发起数', 
 invite_cnt int COMMENT'邀请应聘数', 
 urgent_cnt int COMMENT'急聘数', 
 outer_sr_job_cnt int COMMENT'外部精英职位数', 
 outer_jr_job_cnt int COMMENT'外部白领职位数', 
 view_sr_cv_cnt int COMMENT'浏览精英简历次数', 
 view_jr_cv_cnt int COMMENT'浏览精英简历次数', 
 download_jr_cv_cnt int COMMENT'下载白领简历数', 
 valid_cover_cnt int COMMENT'有效覆盖次数', 
 is_opp int COMMENT'是否目前处于商机中', 
 creation_timestamp timestamp COMMENT'时间戳', 
 is_lpt_in_service int COMMENT'是否合作中')
COMMENT'客户行为洞察-周表'
PARTITIONED BY ( 
 p_date int);

create table fact_h_erp_w_customer_insight 
(
d_date int comment'分析日期',
customer_id int comment'客户ID',
customer_name varchar(200) comment'客户名称',
industry varchar(30) comment'所属行业',
dq varchar(30) comment'所属地区',
salesuser_id int comment'负责销售',
salesuser_name varchar(200) comment'负责销售名称',
salesorg_id int comment'负责销售组织',
salesorg_name varchar(200) comment'负责销售组织名称',
is_certificate int comment'是否认证',
ecomp_version varchar(30) comment'企业版本',
ecomp_id int comment'猎聘通编号',
ecomp_root_id int comment'猎聘通主编号',
lpt_service_effect_date varchar(30) comment'猎聘通服务开始时间',
lpt_service_expired_date varchar(30) comment'猎聘通服务结束时间',
is_lpt_expire int COMMENT'是否即将到期', 
is_new_contract_3months int COMMENT'是否3个月内新签', 
top_mark_max int comment'客户TOP标识',
is_top_mark_level1 int comment'是否Top1',
is_top_mark_level2 int comment'是否Top2',
is_top_mark_level3 int comment'是否Top3',
is_top_mark_level4 int comment'是否Top4',
is_top_mark_level5 int comment'是否Top5',
is_top_mark_level6 int comment'是否Top6',
consume_cv_total_cnt int comment'综合消耗资源数',
lpt_used_activity int comment'使用深度',
login_cnt int comment'登陆天数',
new_ejob_cnt int comment'职位发布数',
search_cv_cnt int comment'简历搜索次数',
view_cv_cnt int comment'简历浏览次数',
download_cv_cnt int comment'简历下载次数',
intention_cnt int comment'意向沟通数',
msk_cnt int comment'面试快发起数',
invite_cnt int comment'邀请应聘数',
urgent_cnt int comment'急聘数',
outer_sr_job_cnt int comment'外部精英职位数',
outer_jr_job_cnt int comment'外部白领职位数',
view_sr_cv_cnt int comment'浏览精英简历次数',
view_jr_cv_cnt int comment'浏览白领简历次数',
download_jr_cv_cnt int comment'下载白领简历数',
valid_cover_cnt int comment'有效覆盖次数',
is_opp int comment'是否目前处于商机中',
creation_timestamp timestamp default CURRENT_TIMESTAMP comment'时间戳',
is_lpt_in_service int comment'是否合作中',
rps_user_id int comment '招聘服务顾问id',
rps_user_name varchar(50) comment '招聘服务顾问姓名',
rpsorg_id int comment '招聘服务小组id',
rpsorg_name varchar(150) comment '招聘服务小组名称',
rpsposition_id int comment '招聘岗位id',
rpsposition_name varchar(50) comment '招聘岗位名称',
rps_valid_cover_cnt int comment '招服有效覆盖客户次数',
rps_recommend_cv_cnt int comment '人工推荐简历数',
rps_recommend_satisfied_cv_cnt int comment '人工推荐简历满意数',
bole_recommend_cv_cnt int comment '伯乐推荐简历数',
bole_recommend_satisfied_cv_cnt int comment '伯乐推荐简历满意数',
primary key (d_date,customer_id)
) comment'客户行为洞察';

alter table fact_h_erp_w_customer_insight add columns(is_lpt_in_service int comment'是否合作中');
alter table fact_h_erp_w_customer_insight add is_lpt_in_service int comment'是否合作中';


alter table fact_h_erp_w_customer_insight add columns(
rps_user_id int comment '招聘服务顾问id',
rps_user_name string comment '招聘服务顾问姓名',
rpsorg_id int comment '招聘服务小组id',
rpsorg_name string comment '招聘服务小组名称',
rpsposition_id int comment '招聘岗位id',
rpsposition_name string comment '招聘岗位名称',
rps_valid_cover_cnt int comment '招服有效覆盖客户次数',
rps_recommend_cv_cnt int comment '人工推荐简历数',
rps_recommend_satisfied_cv_cnt int comment '人工推荐简历满意数',
bole_recommend_cv_cnt int comment '伯乐推荐简历数',
bole_recommend_satisfied_cv_cnt int comment '伯乐推荐简历满意数'
) cascade;


alter table fact_h_erp_w_customer_insight add (
rps_user_id int comment '招聘服务顾问id',
rps_user_name varchar(50) comment '招聘服务顾问姓名',
rpsorg_id int comment '招聘服务小组id',
rpsorg_name varchar(150) comment '招聘服务小组名称',
rpsposition_id int comment '招聘岗位id',
rpsposition_name varchar(50) comment '招聘岗位名称',
rps_valid_cover_cnt int comment '招服有效覆盖客户次数',
rps_recommend_cv_cnt int comment '人工推荐简历数',
rps_recommend_satisfied_cv_cnt int comment '人工推荐简历满意数',
bole_recommend_cv_cnt int comment '伯乐推荐简历数',
bole_recommend_satisfied_cv_cnt int comment '伯乐推荐简历满意数'
);


insert overwrite table fact_h_erp_w_customer_insight partition (p_date = $date$)
select 
$date$ as d_date,
cust_base.customer_id as customer_id,
cust_base.customer_name as customer_name,
cust_base.industry as industry,
cust_base.dq as dq,
cust_base.salesuser_id as salesuser_id,
cust_base.salesuser_name as salesuser_name,
cust_base.salesorg_id as salesorg_id,
cust_base.salesorg_name as salesorg_name,
cust_base.is_certificate as is_certificate,
cust_base.ecomp_version as ecomp_version,
cust_base.ecomp_id as ecomp_id,
cust_base.ecomp_root_id as ecomp_root_id,
regexp_replace(cust_base.lpt_service_effect_date,'-','') as lpt_service_effect_date,
regexp_replace(cust_base.lpt_service_expired_date,'-','') as lpt_service_expired_date,
cust_base.is_lpt_expire as is_lpt_expire,
cust_base.is_new_contract_3months as is_new_contract_3months,
cust_base.top_mark_max as top_mark_max,
cust_base.is_top_mark_level1 as is_top_mark_level1,
cust_base.is_top_mark_level2 as is_top_mark_level2,
cust_base.is_top_mark_level3 as is_top_mark_level3,
cust_base.is_top_mark_level4 as is_top_mark_level4,
cust_base.is_top_mark_level5 as is_top_mark_level5,
cust_base.is_top_mark_level6 as is_top_mark_level6,
cust_act.consume_cv_total_cnt as consume_cv_total_cnt,
10*intention_cnt + 100* msk_cnt + 5*download_cv_cnt + 60*invite_cnt + view_cv_cnt+ 50*urgent_cnt+ 10*search_cv_cnt + 30*new_ejob_cnt as lpt_used_activity,
cust_act.login_cnt as login_cnt,
nvl(ejob.new_ejob_cnt,0) as new_ejob_cnt,
cust_act.search_cv_cnt as search_cv_cnt,
cust_act.view_cv_cnt as view_cv_cnt,
cust_act.download_cv_cnt as download_cv_cnt,
cust_act.intention_cnt as intention_cnt,
cust_act.msk_cnt as msk_cnt,
cust_act.invite_cnt as invite_cnt,
cust_act.urgent_cnt as urgent_cnt,
cust_act.outer_sr_job_cnt as outer_sr_job_cnt,
cust_act.outer_jr_job_cnt as outer_jr_job_cnt,
cust_act.view_sr_cv_cnt as view_sr_cv_cnt,
cust_act.view_jr_cv_cnt as view_jr_cv_cnt,
cust_act.download_jr_cv_cnt as download_jr_cv_cnt,
cust_act.valid_cover_cnt as valid_cover_cnt,
cust_base.is_opp as is_opp,
from_unixtime(unix_timestamp()) as creation_timestamp,
cust_base.is_lpt_in_service as is_lpt_in_service,
cust_base.rps_user_id,
cust_base.rps_user_name,
cust_base.rpsorg_id,
cust_base.rpsorg_name,
cust_base.rpsposition_id,
cust_base.rpsposition_name,
cust_act.rps_valid_cover_cnt,
cust_act.rps_recommend_cv_cnt,
cust_act.rps_recommend_satisfied_cv_cnt,
cust_act.bole_recommend_cv_cnt,
cust_act.bole_recommend_satisfied_cv_cnt
from 
(select 
	customer_id,
	customer_name,
	industry,
	dq,
	salesuser_id,
	salesuser_name,
	salesorg_id,
	salesorg_name,
	is_certificate,
	ecomp_version,
	ecomp_id,
	ecomp_root_id,
	lpt_service_effect_date,
	lpt_service_expired_date,
	is_lpt_in_service,
	is_lpt_expire,
	is_new_contract_3months,
	top_mark,
	top_mark_max,
	nvl(substr(top_mark,1,1),'0') as is_top_mark_level1,
	nvl(substr(top_mark,2,1),'0') as is_top_mark_level2,
	nvl(substr(top_mark,3,1),'0') as is_top_mark_level3,
	nvl(substr(top_mark,4,1),'0') as is_top_mark_level4,
	nvl(substr(top_mark,5,1),'0') as is_top_mark_level5,
	nvl(substr(top_mark,6,1),'0') as is_top_mark_level6,	
	is_opp,
	serviceuser_id as rps_user_id,
	serviceuser_name as rps_user_name,
	service_position_id as rps_position_id,
	service_position_name as rps_position_name,
	service_teamorg_id as rps_teamorg_id,
	service_teamorg_name as rps_teamorg_name
  from dw_erp_d_customer_act
 where p_date = '$date$') cust_base
join 
(select
	customer_id,
	sum(consume_cv_total_cnt) as consume_cv_total_cnt,
	sum(is_login) as login_cnt,
	sum(search_cv_cnt) as search_cv_cnt,
	sum(view_cv_cnt) as view_cv_cnt,
	sum(download_cv_cnt) as download_cv_cnt,
	sum(intention_cnt) as intention_cnt,
	sum(msk_cnt) as msk_cnt,
	sum(invite_cnt) as invite_cnt,
	sum(urgent_cnt) as urgent_cnt,
	sum(outer_sr_job_cnt) as outer_sr_job_cnt,
	sum(outer_jr_job_cnt) as outer_jr_job_cnt,
	sum(view_sr_cv_cnt) as view_sr_cv_cnt,
	sum(view_jr_cv_cnt) as view_jr_cv_cnt,
	sum(download_jr_cv_cnt) as download_jr_cv_cnt,
	sum(valid_cover_cnt) as valid_cover_cnt,
	sum(rps_valid_cover_cnt) as rps_valid_cover_cnt,
	sum(rps_recommend_cv_cnt) as rps_recommend_cv_cnt,
	sum(rps_recommend_satisfied_cv_cnt) as rps_recommend_satisfied_cv_cnt,
	sum(bole_recommend_cv_cnt) as bole_recommend_cv_cnt,
	sum(bole_recommend_satisfied_cv_cnt) as bole_recommend_satisfied_cv_cnt
from dw_erp_d_customer_act
where p_date between {{delta(date,-6)}} and '$date$'
group by customer_id
) cust_act 
on cust_base.customer_id = cust_act.customer_id
left join (
	select ecomp_root_id,
	count(case when  date_format(ejob_createtime,'yyyyMMdd') between {{delta(date,-6)}} and '$date$' then ejob_id end) as new_ejob_cnt
	from dw_b_d_ejob_act 
	where p_date = '$date$'
	group by ecomp_root_id
) ejob
on cust_base.ecomp_id = ejob.ecomp_root_id
where cust_base.salesuser_id > 0;


CREATE TABLE fact_h_erp_m_customer_insight(
 d_date int COMMENT'分析日期', 
 customer_id int COMMENT'客户id', 
 customer_name string COMMENT'客户名称', 
 industry string COMMENT'所属行业', 
 dq string COMMENT'所属地区', 
 salesuser_id int COMMENT'负责销售', 
 salesuser_name string COMMENT'负责销售名称', 
 salesorg_id int COMMENT'负责销售组织', 
 salesorg_name string COMMENT'负责销售组织名称', 
 is_certificate int COMMENT'是否认证', 
 ecomp_version string COMMENT'企业版本', 
 ecomp_id int COMMENT'猎聘通编号', 
 ecomp_root_id int COMMENT'猎聘通主编号', 
 lpt_service_effect_date string COMMENT'猎聘通服务开始时间', 
 lpt_service_expired_date string COMMENT'猎聘通服务结束时间', 
 is_lpt_expire int COMMENT'是否即将到期', 
 is_new_contract_3months int COMMENT'是否3个月内新签', 
 top_mark_max int COMMENT'客户top标识最高级', 
 is_top_mark_level1 int COMMENT'是否top1', 
 is_top_mark_level2 int COMMENT'是否top2', 
 is_top_mark_level3 int COMMENT'是否top3', 
 is_top_mark_level4 int COMMENT'是否top4', 
 is_top_mark_level5 int COMMENT'是否top5', 
 is_top_mark_level6 int COMMENT'是否top6', 
 consume_cv_total_cnt int COMMENT'综合消耗资源数', 
 lpt_used_activity int COMMENT'使用深度', 
 login_cnt int COMMENT'登陆天数', 
 new_ejob_cnt int COMMENT'职位发布数', 
 search_cv_cnt int COMMENT'简历搜索次数', 
 view_cv_cnt int COMMENT'简历浏览次数', 
 download_cv_cnt int COMMENT'简历下载次数', 
 intention_cnt int COMMENT'意向沟通数', 
 msk_cnt int COMMENT'面试快发起数', 
 invite_cnt int COMMENT'邀请应聘数', 
 urgent_cnt int COMMENT'急聘数', 
 outer_sr_job_cnt int COMMENT'外部精英职位数', 
 outer_jr_job_cnt int COMMENT'外部白领职位数', 
 view_sr_cv_cnt int COMMENT'浏览精英简历次数', 
 view_jr_cv_cnt int COMMENT'浏览精英简历次数', 
 download_jr_cv_cnt int COMMENT'下载白领简历数', 
 valid_cover_cnt int COMMENT'有效覆盖次数', 
 is_opp int COMMENT'是否目前处于商机中', 
 creation_timestamp timestamp COMMENT'时间戳', 
 is_lpt_in_service int COMMENT'是否合作中')
COMMENT'客户行为洞察-月表'
PARTITIONED BY ( 
 p_date int);


create table fact_h_erp_m_customer_insight 
(
d_date int comment'分析日期',
customer_id int comment'客户ID',
customer_name varchar(200) comment'客户名称',
industry varchar(30) comment'所属行业',
dq varchar(30) comment'所属地区',
salesuser_id int comment'负责销售',
salesuser_name varchar(200) comment'负责销售名称',
salesorg_id int comment'负责销售组织',
salesorg_name varchar(200) comment'负责销售组织名称',
is_certificate int comment'是否认证',
ecomp_version varchar(30) comment'企业版本',
ecomp_id int comment'猎聘通编号',
ecomp_root_id int comment'猎聘通主编号',
lpt_service_effect_date varchar(30) comment'猎聘通服务开始时间',
lpt_service_expired_date varchar(30) comment'猎聘通服务结束时间',
is_lpt_expire int COMMENT'是否即将到期', 
is_new_contract_3months int COMMENT'是否3个月内新签', 
top_mark_max int comment'客户TOP标识',
is_top_mark_level1 int comment'是否Top1',
is_top_mark_level2 int comment'是否Top2',
is_top_mark_level3 int comment'是否Top3',
is_top_mark_level4 int comment'是否Top4',
is_top_mark_level5 int comment'是否Top5',
is_top_mark_level6 int comment'是否Top6',
consume_cv_total_cnt int comment'综合消耗资源数',
lpt_used_activity int comment'使用深度',
login_cnt int comment'登陆天数',
new_ejob_cnt int comment'职位发布数',
search_cv_cnt int comment'简历搜索次数',
view_cv_cnt int comment'简历浏览次数',
download_cv_cnt int comment'简历下载次数',
intention_cnt int comment'意向沟通数',
msk_cnt int comment'面试快发起数',
invite_cnt int comment'邀请应聘数',
urgent_cnt int comment'急聘数',
outer_sr_job_cnt int comment'外部精英职位数',
outer_jr_job_cnt int comment'外部白领职位数',
view_sr_cv_cnt int comment'浏览精英简历次数',
view_jr_cv_cnt int comment'浏览白领简历次数',
download_jr_cv_cnt int comment'下载白领简历数',
valid_cover_cnt int comment'有效覆盖次数',
is_opp int comment'是否目前处于商机中',
creation_timestamp timestamp default CURRENT_TIMESTAMP comment'时间戳',
is_lpt_in_service int comment'是否合作中',
primary key (d_date,customer_id)
) comment'客户行为洞察-月表';

alter table fact_h_erp_m_customer_insight add columns(
rps_user_id int comment '招聘服务顾问id',
rps_user_name string comment '招聘服务顾问姓名',
rpsorg_id int comment '招聘服务小组id',
rpsorg_name string comment '招聘服务小组名称',
rpsposition_id int comment '招聘岗位id',
rpsposition_name string comment '招聘岗位名称',
rps_valid_cover_cnt int comment '招服有效覆盖客户次数',
rps_recommend_cv_cnt int comment '人工推荐简历数',
rps_recommend_satisfied_cv_cnt int comment '人工推荐简历满意数',
bole_recommend_cv_cnt int comment '伯乐推荐简历数',
bole_recommend_satisfied_cv_cnt int comment '伯乐推荐简历满意数'
) cascade;


alter table fact_h_erp_m_customer_insight add (
rps_user_id int comment '招聘服务顾问id',
rps_user_name varchar(50) comment '招聘服务顾问姓名',
rpsorg_id int comment '招聘服务小组id',
rpsorg_name varchar(150) comment '招聘服务小组名称',
rpsposition_id int comment '招聘岗位id',
rpsposition_name varchar(50) comment '招聘岗位名称',
rps_valid_cover_cnt int comment '招服有效覆盖客户次数',
rps_recommend_cv_cnt int comment '人工推荐简历数',
rps_recommend_satisfied_cv_cnt int comment '人工推荐简历满意数',
bole_recommend_cv_cnt int comment '伯乐推荐简历数',
bole_recommend_satisfied_cv_cnt int comment '伯乐推荐简历满意数'
);

alter table fact_h_erp_m_customer_insight change rps_org_id rps_org_id int comment '招聘服务小组id';

insert overwrite table fact_h_erp_m_customer_insight partition (p_date = $date$)
select 
$date$ as d_date,
cust_base.customer_id as customer_id,
cust_base.customer_name as customer_name,
cust_base.industry as industry,
cust_base.dq as dq,
cust_base.salesuser_id as salesuser_id,
cust_base.salesuser_name as salesuser_name,
cust_base.salesorg_id as salesorg_id,
cust_base.salesorg_name as salesorg_name,
cust_base.is_certificate as is_certificate,
cust_base.ecomp_version as ecomp_version,
cust_base.ecomp_id as ecomp_id,
cust_base.ecomp_root_id as ecomp_root_id,
regexp_replace(cust_base.lpt_service_effect_date,'-','') as lpt_service_effect_date,
regexp_replace(cust_base.lpt_service_expired_date,'-','') as lpt_service_expired_date,
cust_base.is_lpt_expire as is_lpt_expire,
cust_base.is_new_contract_3months as is_new_contract_3months,
cust_base.top_mark_max as top_mark_max,
cust_base.is_top_mark_level1 as is_top_mark_level1,
cust_base.is_top_mark_level2 as is_top_mark_level2,
cust_base.is_top_mark_level3 as is_top_mark_level3,
cust_base.is_top_mark_level4 as is_top_mark_level4,
cust_base.is_top_mark_level5 as is_top_mark_level5,
cust_base.is_top_mark_level6 as is_top_mark_level6,
cust_act.consume_cv_total_cnt as consume_cv_total_cnt,
10*intention_cnt + 100* msk_cnt + 5*download_cv_cnt + 60*invite_cnt + view_cv_cnt+ 50*urgent_cnt+ 10*search_cv_cnt + 30*new_ejob_cnt as lpt_used_activity,
cust_act.login_cnt as login_cnt,
nvl(ejob.new_ejob_cnt,0) as new_ejob_cnt,
cust_act.search_cv_cnt as search_cv_cnt,
cust_act.view_cv_cnt as view_cv_cnt,
cust_act.download_cv_cnt as download_cv_cnt,
cust_act.intention_cnt as intention_cnt,
cust_act.msk_cnt as msk_cnt,
cust_act.invite_cnt as invite_cnt,
cust_act.urgent_cnt as urgent_cnt,
cust_act.outer_sr_job_cnt as outer_sr_job_cnt,
cust_act.outer_jr_job_cnt as outer_jr_job_cnt,
cust_act.view_sr_cv_cnt as view_sr_cv_cnt,
cust_act.view_jr_cv_cnt as view_jr_cv_cnt,
cust_act.download_jr_cv_cnt as download_jr_cv_cnt,
cust_act.valid_cover_cnt as valid_cover_cnt,
cust_base.is_opp as is_opp,
from_unixtime(unix_timestamp()) as creation_timestamp,
cust_base.is_lpt_in_service as is_lpt_in_service,
cust_base.rps_user_id,
cust_base.rps_user_name,
cust_base.rpsorg_id,
cust_base.rpsorg_name,
cust_base.rpsposition_id,
cust_base.rpsposition_name,
cust_act.rps_valid_cover_cnt,
cust_act.rps_recommend_cv_cnt,
cust_act.rps_recommend_satisfied_cv_cnt,
cust_act.bole_recommend_cv_cnt,
cust_act.bole_recommend_satisfied_cv_cnt
from 
(select 
	customer_id,
	customer_name,
	industry,
	dq,
	salesuser_id,
	salesuser_name,
	salesorg_id,
	salesorg_name,
	is_certificate,
	ecomp_version,
	ecomp_id,
	ecomp_root_id,
	lpt_service_effect_date,
	lpt_service_expired_date,
	is_lpt_in_service,
	is_lpt_expire,
	is_new_contract_3months,
	top_mark,
	top_mark_max,
	nvl(substr(top_mark,1,1),'0') as is_top_mark_level1,
	nvl(substr(top_mark,2,1),'0') as is_top_mark_level2,
	nvl(substr(top_mark,3,1),'0') as is_top_mark_level3,
	nvl(substr(top_mark,4,1),'0') as is_top_mark_level4,
	nvl(substr(top_mark,5,1),'0') as is_top_mark_level5,
	nvl(substr(top_mark,6,1),'0') as is_top_mark_level6,
	is_opp,
	serviceuser_id as rps_user_id,
	serviceuser_name as rps_user_name,
	service_position_id as rps_position_id,
	service_position_name as rps_position_name,
	service_teamorg_id as rps_teamorg_id,
	service_teamorg_name as rps_teamorg_name
  from dw_erp_d_customer_act
 where p_date = '$date$') cust_base
join 
(select
	customer_id,
	sum(consume_cv_total_cnt) as consume_cv_total_cnt,
	sum(is_login) as login_cnt,
	sum(search_cv_cnt) as search_cv_cnt,
	sum(view_cv_cnt) as view_cv_cnt,
	sum(download_cv_cnt) as download_cv_cnt,
	sum(intention_cnt) as intention_cnt,
	sum(msk_cnt) as msk_cnt,
	sum(invite_cnt) as invite_cnt,
	sum(urgent_cnt) as urgent_cnt,
	sum(outer_sr_job_cnt) as outer_sr_job_cnt,
	sum(outer_jr_job_cnt) as outer_jr_job_cnt,
	sum(view_sr_cv_cnt) as view_sr_cv_cnt,
	sum(view_jr_cv_cnt) as view_jr_cv_cnt,
	sum(download_jr_cv_cnt) as download_jr_cv_cnt,
	sum(valid_cover_cnt) as valid_cover_cnt,
	sum(rps_valid_cover_cnt) as rps_valid_cover_cnt,
	sum(rps_recommend_cv_cnt) as rps_recommend_cv_cnt,
	sum(rps_recommend_satisfied_cv_cnt) as rps_recommend_satisfied_cv_cnt,
	sum(bole_recommend_cv_cnt) as bole_recommend_cv_cnt,
	sum(bole_recommend_satisfied_cv_cnt) as bole_recommend_satisfied_cv_cnt
from dw_erp_d_customer_act
where p_date between concat(substr($date$,1,6),'01') and $date$
group by customer_id
) cust_act 
on cust_base.customer_id = cust_act.customer_id
left join (
	select ecomp_root_id,
	count(case when  date_format(ejob_createtime,'yyyyMMdd') between concat(substr($date$,1,6),'01') and $date$ then ejob_id end) as new_ejob_cnt
	from dw_b_d_ejob_act 
	where p_date = '$date$'
	group by ecomp_root_id
) ejob
on cust_base.ecomp_id = ejob.ecomp_root_id
where cust_base.salesuser_id > 0;




insert overwrite table fact_h_erp_w_customer_insight partition (p_date)
select d_date, customer_id, customer_name, industry, dq, salesuser_id, salesuser_name, salesorg_id, salesorg_name, is_certificate, ecomp_version, ecomp_id, ecomp_root_id, lpt_service_effect_date, lpt_service_expired_date, is_lpt_expire, is_new_contract_3months, top_mark_max, is_top_mark_level1, is_top_mark_level2, is_top_mark_level3, is_top_mark_level4, is_top_mark_level5, is_top_mark_level6, consume_cv_total_cnt, lpt_used_activity, login_cnt, new_ejob_cnt, search_cv_cnt, view_cv_cnt, download_cv_cnt, intention_cnt, msk_cnt, invite_cnt, urgent_cnt, outer_sr_job_cnt, outer_jr_job_cnt, view_sr_cv_cnt, view_jr_cv_cnt, download_jr_cv_cnt, valid_cover_cnt, is_opp, creation_timestamp, is_lpt_in_service, rps_user_id, rps_user_name, rpsorg_id, rpsorg_name, rpsposition_id, rpsposition_name, nvl(cust.rps_valid_cover_cnt,0), rps_recommend_cv_cnt, rps_recommend_satisfied_cv_cnt, bole_recommend_cv_cnt, bole_recommend_satisfied_cv_cnt, p_date
from fact_h_erp_w_customer_insight insight 
left join 
(select
	customer_id as id,
	sum(rps_valid_cover_cnt) as rps_valid_cover_cnt
from dw_erp_d_customer_act
where p_date between 20170227 and 20170305
group by customer_id
) cust
on insight.customer_id = cust.id 
where p_date = 20170305