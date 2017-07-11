create table dw_erp_w_customer_report_main(	
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name string comment '客户名称',
ecomp_root_id int comment 'ecomp_root_id',
ecomp_id int comment 'ecomp_id',
active_ejob_cnt int comment '活跃职位数',
publish_day7_no_apply_ejob_cnt int comment '发布七天以上无投递职位数',
msk_potential_ejob_cnt int comment '面试快潜力职位数',
day7_login_cnt int comment '近7天登录天数',
day7_consume_cv_total_cnt int comment '近7天精英资源综合消耗',
day7_active_ejob_cnt int comment '近7天活跃职位数',
day7_im_userc_cnt int comment '近7天职聊人数',
cv_download_cnt int comment '下载精英简历次数',
lowcv_download_cnt int comment '下载白领简历次数',
intention_cnt int comment '意向沟通发起次数',
invite_cnt int comment '邀请应聘发起次数',
urgent_cnt int comment '急聘发起次数',
consume_cv_cnt int comment '下载精英简历消耗数',
consume_lowcv_cnt int comment '下载白领简历消耗数',
consume_intention_cv_cnt int comment '意向沟通消耗简历数',
consume_invite_cv_cnt int comment '邀请应聘消耗简历数',
consume_urgent_cv_cnt int comment '急聘消耗简历数',
consume_msk_cv_cnt int comment '面试快简历消耗数',
ejob_avg_recv_cv_cnt int comment '职均投递数',
recv_cv_cnt int comment '职位总投递数',
recv_satisfied_cv_cnt int comment '投递满意数',
recv_satisfied_ratio float comment '投递满意率',
msk_service_cnt int comment '发起面试快服务数',
msk_showup_service_cnt int comment '有到场面试快服务数',
msk_showup_ratio float comment '面试快到场率',
intention_valid_ratio float comment '意向沟通有效率',
intention_submit_cnt int comment '意向沟通交付数',
intention_submit_valid_cnt int comment '意向沟通有效交付数',
is_lost_risk int comment '是否有流失风险',
consume_total_cnt int comment '生效资源数',
consume_level string comment '生效资源数分类',
day30_login_cnt int comment '最近30天登录数',
second_day30_login_cnt int comment '第二最近30天登录数',
third_day30_login_cnt int comment '第三最近30天登录数',
consume_level_avg_login_cnt int comment '资源分类平均30天登录数',
lp_total_cv_cnt int comment '总精英简历数',
lp_left_cv_cnt int comment '精英剩余简历数',
is_left_cv_10p int comment '是否精英剩余简历数低于10',%
in_msk_service_cnt int comment '正在进行中的面试快服务',
is_in_msk_cv_lack int comment '是否面试快简历资源缺乏',
is_have_msk_potential_ejob int comment '是否有面试快潜力职位',
creation_timestamp  timestamp comment '时间戳'
) comment '客户7天内使用报告'
partitioned by (p_date int);

create table dw_erp_w_customer_report_main(	
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name varchar(100) comment '客户名称',
ecomp_root_id int comment 'ecomp_root_id',
ecomp_id int comment 'ecomp_id',
active_ejob_cnt int comment '活跃职位数',
publish_day7_no_apply_ejob_cnt int comment '发布七天以上无投递职位数',
msk_potential_ejob_cnt int comment '面试快潜力职位数',
day7_login_cnt int comment '近7天登录天数',
day7_consume_cv_total_cnt int comment '近7天精英资源综合消耗',
day7_active_ejob_cnt int comment '近7天活跃职位数',
day7_im_userc_cnt int comment '近7天职聊人数',
cv_download_cnt int comment '下载精英简历次数',
lowcv_download_cnt int comment '下载白领简历次数',
intention_cnt int comment '意向沟通发起次数',
invite_cnt int comment '邀请应聘发起次数',
urgent_cnt int comment '急聘发起次数',
consume_cv_cnt int comment '下载精英简历消耗数',
consume_lowcv_cnt int comment '下载白领简历消耗数',
consume_intention_cv_cnt int comment '意向沟通消耗简历数',
consume_invite_cv_cnt int comment '邀请应聘消耗简历数',
consume_urgent_cv_cnt int comment '急聘消耗简历数',
consume_msk_cv_cnt int comment '面试快简历消耗数',
ejob_avg_recv_cv_cnt int comment '职均投递数',
recv_cv_cnt int comment '职位总投递数',
recv_satisfied_cv_cnt int comment '投递满意数',
recv_satisfied_ratio float comment '投递满意率',
msk_service_cnt int comment '发起面试快服务数',
msk_showup_service_cnt int comment '有到场面试快服务数',
msk_showup_ratio float comment '面试快到场率',
intention_valid_ratio float comment '意向沟通有效率',
intention_submit_cnt int comment '意向沟通交付数',
intention_submit_valid_cnt int comment '意向沟通有效交付数',
is_lost_risk int comment '是否有流失风险',
consume_total_cnt int comment '生效资源数',
consume_level varchar(100) comment '生效资源数分类',
day30_login_cnt int comment '最近30天登录数',
second_day30_login_cnt int comment '第二最近30天登录数',
third_day30_login_cnt int comment '第三最近30天登录数',
consume_level_avg_login_cnt int comment '资源分类平均30天登录数',
lp_total_cv_cnt int comment '总精英简历数',
lp_left_cv_cnt int comment '精英剩余简历数',
is_left_cv_10p int comment '是否精英剩余简历数低于10%',
in_msk_service_cnt int comment '正在进行中的面试快服务',
is_in_msk_cv_lack int comment '是否面试快简历资源缺乏',
is_have_msk_potential_ejob int comment '是否有面试快潜力职位',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,customer_id)
) comment '客户7天内使用报告';


insert overwrite table dw_erp_w_customer_report_main partition (p_date = $date$)
select 
$date$ as d_date,
base.id,
base.name,
base.ecomp_root_id,
base.ecomp_id,
nvl(sum(active_ejob_cnt),0) as active_ejob_cnt,
nvl(sum(publish_day7_no_apply_ejob_cnt),0) as publish_day7_no_apply_ejob_cnt,
nvl(sum(msk_potential_ejob_cnt),0) as msk_potential_ejob_cnt,
nvl(sum(day7_login_cnt),0) as day7_login_cnt,
nvl(sum(day7_consume_cv_total_cnt),0) as day7_consume_cv_total_cnt,
nvl(sum(day7_active_ejob_cnt),0) as day7_active_ejob_cnt,
nvl(sum(day7_im_userc_cnt),0) as day7_im_userc_cnt,
nvl(sum(cv_download_cnt),0) as cv_download_cnt,
nvl(sum(lowcv_download_cnt),0) as lowcv_download_cnt,
nvl(sum(intention_cnt),0) as intention_cnt,
nvl(sum(invite_cnt),0) as invite_cnt,
nvl(sum(urgent_cnt),0) as urgent_cnt,
nvl(sum(consume_cv_cnt),0) as consume_cv_cnt,
nvl(sum(consume_lowcv_cnt),0) as consume_lowcv_cnt,
nvl(sum(consume_intention_cv_cnt),0) as consume_intention_cv_cnt,
nvl(sum(consume_invite_cv_cnt),0) as consume_invite_cv_cnt,
nvl(sum(consume_urgent_cv_cnt),0) as consume_urgent_cv_cnt,
nvl(sum(consume_msk_cv_cnt),0) as consume_msk_cv_cnt,
nvl(sum(ejob_avg_recv_cv_cnt),0) as ejob_avg_recv_cv_cnt,
nvl(sum(recv_cv_cnt),0) as recv_cv_cnt,
nvl(sum(recv_satisfied_cv_cnt),0) as recv_satisfied_cv_cnt,
nvl(sum(recv_satisfied_ratio),0) as recv_satisfied_ratio,
nvl(sum(msk_service_cnt),0) as msk_service_cnt,
nvl(sum(msk_showup_service_cnt),0) as msk_showup_service_cnt,
nvl(sum(msk_showup_ratio),0) as msk_showup_ratio,
nvl(sum(intention_valid_ratio),0) as intention_valid_ratio,
nvl(sum(intention_submit_cnt),0) as intention_submit_cnt,
nvl(sum(intention_submit_valid_cnt),0) as intention_submit_valid_cnt,
nvl(sum(is_lost_risk),0) as is_lost_risk,
nvl(sum(consume_total_cnt),0) as consume_total_cnt,
nvl(sum(consume_level),0) as consume_level,
nvl(sum(day30_login_cnt),0) as day30_login_cnt,
nvl(sum(second_day30_login_cnt),0) as second_day30_login_cnt,
nvl(sum(third_day30_login_cnt),0) as third_day30_login_cnt,
nvl(sum(consume_level_avg_login_cnt),0) as consume_level_avg_login_cnt,
nvl(sum(lp_total_cv_cnt),0) as lp_total_cv_cnt,
nvl(sum(lp_left_cv_cnt),0) as lp_left_cv_cnt,
nvl(sum(is_left_cv_10p),0) as is_left_cv_10p,
nvl(sum(in_msk_service_cnt),0) as in_msk_service_cnt,
nvl(sum(is_in_msk_cv_lack),0) as is_in_msk_cv_lack,
nvl(sum(is_have_msk_potential_ejob),0) as is_have_msk_potential_ejob,
from_unixtime(unix_timestamp()) as creation_timestamp
from 
(   select 
		customer_id,
		sum(active_ejob_cnt) as active_ejob_cnt,
		sum(publish_day7_no_apply_ejob_cnt) as publish_day7_no_apply_ejob_cnt,
		sum(msk_potential_ejob_cnt) as msk_potential_ejob_cnt,
		0 as day7_login_cnt,
		sum(day7_active_ejob_cnt) as day7_active_ejob_cnt,
		sum(day7_consume_cv_total_cnt) as day7_consume_cv_total_cnt,
		sum(day7_im_userc_cnt) as day7_im_userc_cnt,
		sum(cv_download_cnt) as cv_download_cnt,
		sum(lowcv_download_cnt) as lowcv_download_cnt,
		sum(intention_cnt) as intention_cnt,
		sum(invite_cnt) as invite_cnt,
		sum(urgent_cnt) as urgent_cnt,
		sum(consume_cv_cnt) as consume_cv_cnt,
		sum(consume_lowcv_cnt) as consume_lowcv_cnt,
		sum(consume_intention_cv_cnt) as consume_intention_cv_cnt,
		sum(consume_invite_cv_cnt) as consume_invite_cv_cnt,
		sum(consume_urgent_cv_cnt) as consume_urgent_cv_cnt,
		sum(consume_msk_cv_cnt) as consume_msk_cv_cnt,
		sum(msk_service_cnt) as msk_service_cnt,
		sum(msk_showup_service_cnt) as msk_showup_service_cnt,
		sum(msk_showup_service_cnt) / sum(msk_service_cnt) as msk_showup_ratio,
		sum(recv_cv_cnt) / sum(ejob_cnt) as ejob_avg_recv_cv_cnt,
		sum(recv_cv_cnt) as recv_cv_cnt,
		sum(recv_satisfied_cv_cnt) as recv_satisfied_cv_cnt,
		sum(recv_satisfied_cv_cnt) / sum(recv_cv_cnt) as recv_satisfied_ratio,
		sum(intention_submit_valid_cnt) / sum(intention_submit_cnt) as intention_valid_ratio,
		sum(intention_submit_cnt) as intention_submit_cnt,
		sum(intention_submit_valid_cnt) as intention_submit_valid_cnt,
		0 as is_lost_risk,
		0 as consume_total_cnt,
		0 as consume_level,
		0 as day30_login_cnt,
		0 as second_day30_login_cnt,
		0 as third_day30_login_cnt,
		0 as consume_level_avg_login_cnt,
		0 as lp_total_cv_cnt,
		0 as lp_left_cv_cnt,
		0 as is_left_cv_10p,
		0 as in_msk_service_cnt,
		0 as is_in_msk_cv_lack,
		0 as is_have_msk_potential_ejob
	from dw_erp_w_customer_report_usere
	where p_date = $date$
	group by customer_id
	union all 
	select  nvl(tips1.customer_id , tips2.customer_id) as customer_id,
			0 as active_ejob_cnt,
			0 as publish_day7_no_apply_ejob_cnt,
			0 as msk_potential_ejob_cnt,
			nvl(tips1.day7_login_cnt,0) as day7_login_cnt,
			0 as day7_consume_cv_total_cnt,
			0 as day7_active_ejob_cnt,
			0 as day7_im_userc_cnt,
			0 as cv_download_cnt,
			0 as lowcv_download_cnt,
			0 as intention_cnt,
			0 as invite_cnt,
			0 as urgent_cnt,
			0 as consume_cv_cnt,
			0 as consume_lowcv_cnt,
			0 as consume_intention_cv_cnt,
			0 as consume_invite_cv_cnt,
			0 as consume_urgent_cv_cnt,
			0 as consume_msk_cv_cnt,
			0 as ejob_avg_recv_cv_cnt,
			0 as recv_cv_cnt,
			0 as recv_satisfied_cv_cnt,
			0 as recv_satisfied_ratio,
			0 as msk_service_cnt,
			0 as msk_showup_service_cnt,
			0 as msk_showup_ratio,
			0 as intention_valid_ratio,
			0 as intention_submit_cnt,
			0 as intention_submit_valid_cnt,
			case when tips1.day30_login_cnt < tips1.second_day30_login_cnt and tips1.day30_login_cnt < least(tips1.forth_day30_login_cnt, tips1.third_day30_login_cnt)
			 and tips1.day30_login_cnt < avg(tips1.day30_login_cnt)over(distribute by tips2.consume_level) and tips2.is_lost = 1 then 1 else 0 end as is_lost_risk,
			nvl(tips2.allresource,0) as consume_total_cnt,
			nvl(tips2.consume_level,0) as consume_level,
			nvl(tips1.day30_login_cnt,0) as day30_login_cnt,
			nvl(tips1.second_day30_login_cnt,0) as second_day30_login_cnt,
			nvl(tips1.third_day30_login_cnt,0) as third_day30_login_cnt,
			nvl(avg(tips1.day30_login_cnt)over(distribute by tips2.consume_level),0) as consume_level_avg_login_cnt,
			nvl(tips2.all_cv_cnt,0) as lp_total_cv_cnt,
			nvl(tips2.left_cv_cnt,0) as lp_left_cv_cnt,
			case when tips2.left_ratio < 0.1 and tips2.is_renewal = 1 then 1  else 0 end as is_left_cv_10p,
			nvl(tips1.msk_service_cnt,0) as in_msk_service_cnt,
			case when tips1.msk_service_cnt*100 > tips2.left_cv_cnt and tips2.is_renewal = 1 then 1 else 0 end as is_in_msk_cv_lack,			
			case when tips1.msk_potential_cnt > 0 and tips2.is_renewal = 1 then 1 else 0 end is_have_msk_potential_ejob
	 from 
	(select  base.id as customer_id,
				sum(msk_service_cnt) as msk_service_cnt,
				sum(msk_potential_cnt) as msk_potential_cnt,
				sum(day7_login_cnt) as day7_login_cnt,
				sum(day30_login_cnt) as day30_login_cnt,
				sum(second_day30_login_cnt) as second_day30_login_cnt,
				sum(third_day30_login_cnt) as third_day30_login_cnt,
				sum(forth_day30_login_cnt) as forth_day30_login_cnt
		from (
		select ecomp_root_id,
			   0 as msk_service_cnt,
			   0 as msk_potential_cnt,
			   count(distinct case when p_date between {{delta(date,-6)}} and $date$ and is_login = 1 then p_date else null end) as day7_login_cnt,
			   count(distinct case when p_date between {{delta(date,-29)}} and $date$ and is_login = 1 then p_date else null end) as day30_login_cnt,
			   count(distinct case when p_date between {{delta(date,-36)}} and {{delta(date,-7)}}  and is_login = 1 then p_date else null end) as second_day30_login_cnt,
			   count(distinct case when p_date between {{delta(date,-43)}} and {{delta(date,-14)}} and is_login = 1  then p_date else null end) as third_day30_login_cnt,
			   count(distinct case when p_date between {{delta(date,-50)}} and {{delta(date,-21)}} and is_login = 1  then p_date else null end) as forth_day30_login_cnt
		from dw_b_d_usere_act
		where p_date between {{delta(date,-50)}} and $date$
		group by ecomp_root_id
		union all 
		select ecomp_root_id,
				sum(is_in_msk_service) as msk_service_cnt,
				sum(is_have_msk_potential) as msk_potential_cnt,
				0 as day7_login_cnt,
				0 as day30_login_cnt,
				0 as second_day30_login_cnt,
				0 as third_day30_login_cnt,
				0 as forth_day30_login_cnt
		  from dw_erp_w_customer_report_ejob
		 where p_date = $date$
		 group by ecomp_root_id
		 ) ecomp_root 
		join dw_erp_d_customer_base base on ecomp_root.ecomp_root_id = base.ecomp_id and base.p_date = $date$ and ecomp_version = 2
		group by base.id
	) tips1 
	full join 
	(select customer_id,
			allresource,
			case when allresource <=450 then 1 
				 when allresource >451 and allresource <=1000 then 2
				 when allresource >=1001 then  3 
				 else 0 
		    end as consume_level,
		    case when datediff(reformat_datetime(string(enddate),'yyyy-MM-dd'),reformat_datetime('$date$','yyyy-MM-dd')) > 90 then 1 else 0 end as is_renewal,
		    case when datediff(reformat_datetime('$date$','yyyy-MM-dd'),reformat_datetime(string(startdate),'yyyy-MM-dd')) > 120
	   				  and datediff(reformat_datetime(string(enddate),'yyyy-MM-dd'),reformat_datetime('$date$','yyyy-MM-dd')) < 120 then 1 else 0 end as is_lost,
		    all_cv_cnt,
		    (all_cv_cnt-used_cv_cnt) / all_cv_cnt as left_ratio,
		    (all_cv_cnt-used_cv_cnt) as left_cv_cnt
	  from dw_erp_d_customer_consume_target
	 where p_date = $date$
	   and ( datediff(reformat_datetime('$date$','yyyy-MM-dd'),reformat_datetime(string(startdate),'yyyy-MM-dd')) > 120
	   and datediff(reformat_datetime(string(enddate),'yyyy-MM-dd'),reformat_datetime('$date$','yyyy-MM-dd')) < 120  
    		or datediff(reformat_datetime(string(enddate),'yyyy-MM-dd'),reformat_datetime('$date$','yyyy-MM-dd')) > 90 
	   )
	) tips2
	on tips1.customer_id = tips2.customer_id
) main1 
join dw_erp_d_customer_base base on main1.customer_id = base.id and base.p_date = '$date$' and base.ecomp_version = 2
group by base.id,base.name,base.ecomp_root_id,base.ecomp_id



create table dw_erp_w_customer_report_usere(
d_date int comment '统计日期',
usere_id int comment 'HR主键ID',
usere_name string comment 'HR名称',
usere_account string comment 'HR猎聘通账号',
usere_account_status int comment '猎聘通账号状态',
customer_id int comment '客户ID',
customer_name string comment '客户名称',
ecomp_root_id int comment 'ecomp_root_id',
ecomp_id int comment 'ecomp_id',
ecomp_name string comment 'ecomp_name',
active_ejob_cnt int comment '活跃职位数',
publish_day7_no_apply_ejob_cnt int comment '发布七天以上无投递职位数',
msk_potential_ejob_cnt int comment '面试快潜力职位数',
day7_login_cnt int comment '近7天登录天数',
day7_consume_cv_total_cnt int comment '近7天精英资源综合消耗',
day7_active_ejob_cnt int comment '近7天活跃职位数',
day7_im_userc_cnt int comment '近7天职聊人数',
cv_download_cnt int comment '下载精英简历',
lowcv_download_cnt int comment '下载白领简历',
intention_cnt int comment '意向沟通',
invite_cnt int comment '邀请应聘',
urgent_cnt int comment '急聘',
consume_cv_cnt int comment '下载精英简历消耗数',
consume_lowcv_cnt int comment '下载白领简历消耗数',
consume_intention_cv_cnt int comment '意向沟通消耗简历数',
consume_invite_cv_cnt int comment '邀请应聘消耗简历数',
consume_urgent_cv_cnt int comment '急聘消耗简历数',
consume_msk_cv_cnt int comment '面试快简历消耗数',
msk_service_cnt int comment '发起面试快服务数',
msk_showup_service_cnt int comment '有到场面试快服务数',
msk_showup_ratio float comment '面试快到场率',
ejob_avg_recv_cv_cnt int comment '职均投递数',
recv_cv_cnt int comment '职位总投递数',
recv_satisfied_cv_cnt int comment '投递满意数',
recv_satisfied_ratio float comment '投递满意率',
intention_valid_ratio float comment '意向沟通有效率',
intention_submit_cnt int comment '意向沟通交付数',
intention_submit_valid_cnt int comment '意向沟通有效交付数',
creation_timestamp  timestamp comment '时间戳'
) comment '客户HR7天内使用报告'
partitioned by (p_date int);


create table dw_erp_w_customer_report_usere(
d_date int comment '统计日期',
usere_id int comment 'HR主键ID',
usere_name varchar(50) comment 'HR名称',
usere_account varchar(50) comment 'HR猎聘通账号',
usere_account_status int comment '猎聘通账号状态',
customer_id int comment '客户ID',
customer_name varchar(150) comment '客户名称',
ecomp_root_id int comment 'ecomp_root_id',
ecomp_id int comment 'ecomp_id',
ecomp_name varchar(150) comment 'ecomp_name',
active_ejob_cnt int comment '活跃职位数',
publish_day7_no_apply_ejob_cnt int comment '发布七天以上无投递职位数',
msk_potential_ejob_cnt int comment '面试快潜力职位数',
day7_login_cnt int comment '近7天登录天数',
day7_consume_cv_total_cnt int comment '近7天精英资源综合消耗',
day7_active_ejob_cnt int comment '近7天活跃职位数',
day7_im_userc_cnt int comment '近7天职聊人数',
cv_download_cnt int comment '下载精英简历',
lowcv_download_cnt int comment '下载白领简历',
intention_cnt int comment '意向沟通',
invite_cnt int comment '邀请应聘',
urgent_cnt int comment '急聘',
consume_cv_cnt int comment '下载精英简历消耗数',
consume_lowcv_cnt int comment '下载白领简历消耗数',
consume_intention_cv_cnt int comment '意向沟通消耗简历数',
consume_invite_cv_cnt int comment '邀请应聘消耗简历数',
consume_urgent_cv_cnt int comment '急聘消耗简历数',
consume_msk_cv_cnt int comment '面试快简历消耗数',
msk_service_cnt int comment '发起面试快服务数',
msk_showup_service_cnt int comment '有到场面试快服务数',
msk_showup_ratio float comment '面试快到场率',
ejob_avg_recv_cv_cnt int comment '职均投递数',
recv_cv_cnt int comment '职位总投递数',
recv_satisfied_cv_cnt int comment '投递满意数',
recv_satisfied_ratio float comment '投递满意率',
intention_valid_ratio float comment '意向沟通有效率',
intention_submit_cnt int comment '意向沟通交付数',
intention_submit_valid_cnt int comment '意向沟通有效交付数',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,usere_id,ecomp_id)
) comment '客户HR7天内使用报告';

alter table dw_erp_w_customer_report_usere add columns(
	ejob_cnt int comment '累计发布职位数',
	ecomp_day7_login_cnt int comment '分支机构近7天登录天数',
	customer_day7_login_cnt int commment '客户近7天登录天数') cascade;

alter table dw_erp_w_customer_report_usere add (
	ejob_cnt int default 0  comment '累计发布职位数',
	ecomp_day7_login_cnt int  default 0  comment '分支机构近7天登录天数',
	customer_day7_login_cnt int  default 0 comment '客户近7天登录天数');

sum(recv_cv_cnt) / sum(ejob_cnt) as ejob_avg_recv_cv_cnt -- '职均投递数',


insert overwrite table dw_erp_w_customer_report_usere partition (p_date = $date$)
select 
$date$ as d_date,
nvl(usere_act.usere_id,-1) as usere_id,
nvl(usere_act.usere_name,'未知') as usere_name,
-1 as usere_account,
-1 as usere_account_status,
nvl(cust.id,-1) as customer_id,
nvl(cust.name,'未知') as customer_name,
nvl(ecomp.ecomp_root_id,-1) as ecomp_root_id,
nvl(ecomp.ecomp_id,-1) as ecomp_id,
nvl(ecomp.ecomp_name,'未知') as ecomp_name,
usere_act.active_ejob_cnt as active_ejob_cnt, 
usere_act.publish_day7_no_apply_ejob_cnt as publish_day7_no_apply_ejob_cnt, 
usere_act.msk_potential_ejob_cnt as msk_potential_ejob_cnt, 
usere_act.day7_login_cnt as day7_login_cnt, 
usere_act.day7_consume_cv_total_cnt as day7_consume_cv_total_cnt, 
usere_act.day7_active_ejob_cnt as day7_active_ejob_cnt, 
usere_act.day7_im_userc_cnt as day7_im_userc_cnt, 
usere_act.cv_download_cnt as cv_download_cnt, 
usere_act.lowcv_download_cnt as lowcv_download_cnt, 
usere_act.intention_cnt as intention_cnt, 
usere_act.invite_cnt as invite_cnt, 
usere_act.urgent_cnt as urgent_cnt, 
usere_act.consume_cv_cnt as consume_cv_cnt, 
usere_act.consume_lowcv_cnt as consume_lowcv_cnt, 
usere_act.consume_intention_cv_cnt as consume_intention_cv_cnt, 
usere_act.consume_invite_cv_cnt as consume_invite_cv_cnt, 
usere_act.consume_urgent_cv_cnt as consume_urgent_cv_cnt, 
usere_act.consume_msk_cv_cnt as consume_msk_cv_cnt, 
usere_act.msk_service_cnt as msk_service_cnt, 
usere_act.msk_showup_service_cnt as msk_showup_service_cnt, 
usere_act.msk_showup_ratio as msk_showup_ratio, 
usere_act.ejob_avg_recv_cv_cnt as ejob_avg_recv_cv_cnt, 
usere_act.recv_cv_cnt as recv_cv_cnt, 
usere_act.recv_satisfied_cv_cnt as recv_satisfied_cv_cnt, 
usere_act.recv_satisfied_ratio as recv_satisfied_ratio, 
usere_act.intention_valid_ratio as intention_valid_ratio, 
usere_act.intention_submit_cnt as intention_submit_cnt, 
usere_act.intention_submit_valid_cnt as intention_submit_valid_cnt,
from_unixtime(unix_timestamp()) as creation_timestamp,
usere_act.ejob_cnt,
usere_act.ecomp_day7_login_cnt,
usere_act.customer_day7_login_cnt
from 
(
	select 
		coalesce(ejob.usere_id,consume.usere_id,login.usere_id,message.usere_id) as usere_id,
		nvl(ejob.usere_name,'未知') as usere_name,
		sum(ejob.ejob_cnt) as ejob_cnt, 
		sum(ejob.active_ejob_cnt) as active_ejob_cnt, 
		sum(ejob.publish_day7_no_apply_ejob_cnt) as publish_day7_no_apply_ejob_cnt, 
		sum(ejob.msk_potential_ejob_cnt) as msk_potential_ejob_cnt, 
		sum(login.day7_login_cnt) as day7_login_cnt, 
		sum(login.customer_day7_login_cnt) as customer_day7_login_cnt, 
		sum(login.ecomp_day7_login_cnt) as ecomp_day7_login_cnt, 
		sum(consume.day7_consume_cv_total_cnt) as day7_consume_cv_total_cnt, 
		sum(ejob.day7_active_ejob_cnt) as day7_active_ejob_cnt, 
		sum(message.day7_im_userc_cnt) as day7_im_userc_cnt, 
		sum(consume.cv_download_cnt) as cv_download_cnt, 
		sum(consume.lowcv_download_cnt) as lowcv_download_cnt, 
		sum(consume.intention_cnt) as intention_cnt, 
		sum(consume.invite_cnt) as invite_cnt, 
		sum(consume.urgent_cnt) as urgent_cnt, 
		sum(consume.consume_cv_cnt) as consume_cv_cnt, 
		sum(consume.consume_lowcv_cnt) as consume_lowcv_cnt, 
		sum(consume.consume_intention_cv_cnt) as consume_intention_cv_cnt, 
		sum(consume.consume_invite_cv_cnt) as consume_invite_cv_cnt, 
		sum(consume.consume_urgent_cv_cnt) as consume_urgent_cv_cnt, 
		sum(consume.consume_msk_cv_cnt) as consume_msk_cv_cnt, 
		sum(ejob.msk_service_cnt) as msk_service_cnt, 
		sum(ejob.msk_showup_service_cnt) as msk_showup_service_cnt, 
		sum(ejob.msk_showup_ratio) as msk_showup_ratio, 
		sum(ejob.ejob_avg_recv_cv_cnt) as ejob_avg_recv_cv_cnt, 
		sum(ejob.recv_cv_cnt) as recv_cv_cnt, 
		sum(ejob.recv_satisfied_cv_cnt) as recv_satisfied_cv_cnt, 
		sum(ejob.recv_satisfied_ratio) as recv_satisfied_ratio, 
		sum(ejob.intention_valid_ratio) as intention_valid_ratio, 
		sum(ejob.intention_submit_cnt) as intention_submit_cnt, 
		sum(ejob.intention_submit_valid_cnt) as intention_submit_valid_cnt
	from 
	(
		select 
			usere_id,
			usere_name,
			customer_id,
			ecomp_root_id,
			ecomp_id,
			sum(1) as ejob_cnt,
			sum(day7_is_active) as active_ejob_cnt,
			sum(case when ejob_status = 0 and publish_days >= 7 and recv_cv_cnt = 0 then 1 else 0 end) as publish_day7_no_apply_ejob_cnt,
			sum(is_have_msk_potential) as msk_potential_ejob_cnt,
			sum(day7_is_active) as day7_active_ejob_cnt,
			sum(msk_service_cnt) as msk_service_cnt,
			sum(msk_showup_service_cnt) as msk_showup_service_cnt,
			sum(msk_service_cnt) / sum(msk_showup_service_cnt) as msk_showup_ratio,
			sum(day365_recv_cv_cnt) / sum(1) as ejob_avg_recv_cv_cnt,
			sum(day365_recv_cv_cnt) as recv_cv_cnt,
			sum(day365_recv_satisfied_cv_cnt) as recv_satisfied_cv_cnt,
			sum(day365_recv_satisfied_cv_cnt) / sum(day365_recv_cv_cnt) as recv_satisfied_ratio,
			sum(day365_intention_submit_valid_cnt) / sum(day365_intention_submit_cnt) as intention_valid_ratio,
			sum(day365_intention_submit_cnt) as intention_submit_cnt,
			sum(day365_intention_submit_valid_cnt) as intention_submit_valid_cnt
		from dw_erp_w_customer_report_ejob
		where p_date = $date$
		group by 
			usere_id,
			usere_name,
			ecomp_id,
			ecomp_root_id,
			customer_id
	) ejob 
	full join 
	(
		select 
			usere_id,
			sum(cv_download_cnt) as cv_download_cnt,
			sum(lowcv_download_cnt) as lowcv_download_cnt,
			sum(intention_cnt) as intention_cnt,
			sum(invite_cnt) as invite_cnt,
			sum(urgent_cnt) as urgent_cnt,
			sum(consume_cv+consume_cvcoupon) as consume_cv_cnt,
			sum(consume_lowcv) as consume_lowcv_cnt,
			sum(consume_intention_total) as consume_intention_cv_cnt,
			sum(consume_invite_total) as consume_invite_cv_cnt,
			sum(consume_urgent_cv) as consume_urgent_cv_cnt,
			sum(consume_msk_total) as consume_msk_cv_cnt,
			sum(case when p_date between {{delta(date,-6)}} and $date$ then consume_cv_total else 0 end) as day7_consume_cv_total_cnt
		from dw_b_d_resource_consume
		where p_date between {{delta(date,-364)}} and $date$
		group by usere_id ) consume
		on ejob.usere_id = consume.usere_id
	full join 
	(
		select usere_id,sum(is_login) as day7_login_cnt,
		   count(distinct p_date)over(distribute by ecomp_root_id) as customer_day7_login_cnt,
		   count(distinct p_date)over(distribute by ecomp_id) as ecomp_day7_login_cnt
		from dw_b_d_usere_act
		where p_date between {{delta(date,-6)}} and $date$
		  and is_login = 1
		group by usere_id
	) login 
	on ejob.usere_id = login.usere_id
	full join 
	(select user_id as usere_id,
	        count(distinct opposite_user_id) as day7_im_userc_cnt
	    from dw_c_d_user_message
	    where user_kind = 1
	      and opposite_user_kind = 0
	      and d_date between {{delta(date,-6)}} and $date$ 
	  group by user_id
	) message 
	on ejob.usere_id = message.usere_id
	group by  
	coalesce(ejob.usere_id,consume.usere_id,login.usere_id,message.usere_id),
	ejob.usere_name
) usere_act
join ecomp_user usere on usere_act.usere_id = usere.user_id
join dw_b_d_ecomp_base ecomp on usere.ecomp_id = ecomp.ecomp_id and ecomp.p_date = $date$
join dw_erp_d_customer_base cust on cust.ecomp_id = ecomp.ecomp_root_id and cust.p_date = $date$ and cust.ecomp_version = 2;



insert overwrite table dw_erp_w_customer_report_usere partition (p_date = $date$)
select user3.d_date,user3.usere_id,user3.usere_name,user3.usere_account,user3.usere_account_status,user3.customer_id,user3.customer_name,user3.ecomp_root_id,user3.ecomp_id,user3.ecomp_name,user3.active_ejob_cnt,user3.publish_day7_no_apply_ejob_cnt,user3.msk_potential_ejob_cnt,
nvl(login.day7_login_cnt,0) as day7_login_cnt,
user3.day7_consume_cv_total_cnt,user3.day7_active_ejob_cnt,user3.day7_im_userc_cnt,user3.cv_download_cnt,user3.lowcv_download_cnt,user3.intention_cnt,user3.invite_cnt,user3.urgent_cnt,user3.consume_cv_cnt,user3.consume_lowcv_cnt,user3.consume_intention_cv_cnt,user3.consume_invite_cv_cnt,user3.consume_urgent_cv_cnt,user3.consume_msk_cv_cnt,user3.msk_service_cnt,user3.msk_showup_service_cnt,user3.msk_showup_ratio,user3.ejob_avg_recv_cv_cnt,user3.recv_cv_cnt,user3.recv_satisfied_cv_cnt,user3.recv_satisfied_ratio,user3.intention_valid_ratio,user3.intention_submit_cnt,user3.intention_submit_valid_cnt,user3.creation_timestamp,user3.ejob_cnt,
	nvl(login.ecomp_day7_login_cnt,0) as ecomp_day7_login_cnt,
	nvl(login.customer_day7_login_cnt,0) as customer_day7_login_cnt
from dw_erp_w_customer_report_usere user3
left join (

    select user_id,sum(is_login) as day7_login_cnt,
		   count(distinct p_date)over(distribute by ecomp_root_id) as customer_day7_login_cnt,
		   count(distinct p_date)over(distribute by ecomp_id) as ecomp_day7_login_cnt
	from 	   
    (
		select er.ecomp_root_id,eu.ecomp_id,ul.user_id,ul.p_date, 1 as is_login
		from user_login ul
		join ecomp_user eu on ul.user_id = eu.user_id
		join ecomp_relation er on eu.ecomp_id = er.ecomp_id
		where ul.user_kind = 1
		  and ul.p_date between {{delta(date,-6)}} and $date$
		  group by er.ecomp_root_id,eu.ecomp_id,ul.user_id,ul.p_date
	) usere_login
	group by user_id
) login
on user3.usere_id = login.user_id
where user3.p_date = $date$;

