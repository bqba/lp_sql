create table dw_erp_d_customer_report_main(	
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
day7_outer_behavior_cnt int comment '近7天外部动态数',

cv_download_cnt int comment '近一年下载精英简历次数',
lowcv_download_cnt int comment '近一年下载白领简历次数',
intention_cnt int comment '近一年意向沟通发起次数',
invite_cnt int comment '近一年邀请应聘发起次数',
urgent_cnt int comment '近一年急聘发起次数',
consume_cv_cnt int comment '近一年下载精英简历消耗数',
consume_lowcv_cnt int comment '近一年下载白领简历消耗数',
consume_intention_cv_cnt int comment '近一年意向沟通消耗简历数',
consume_invite_cv_cnt int comment '近一年邀请应聘消耗简历数',
consume_urgent_cv_cnt int comment '近一年急聘消耗简历数',
consume_msk_cv_cnt int comment '近一年面试快简历消耗数',
ejob_avg_recv_cv_cnt int comment '近一年职均投递数',
recv_cv_cnt int comment '近一年职位总投递数',
recv_satisfied_cv_cnt int comment '近一年投递满意数',
recv_satisfied_ratio float comment '近一年投递满意率',
msk_service_cnt int comment '近一年发起面试快服务数',
msk_showup_service_cnt int comment '近一年有到场面试快服务数',
msk_showup_ratio float comment '近一年面试快到场率',
intention_valid_ratio float comment '近一年意向沟通有效率',
intention_submit_cnt int comment '近一年意向沟通交付数',
intention_submit_valid_cnt int comment '近一年意向沟通有效交付数',

day30_cv_download_cnt int comment '近一个月下载精英简历次数',
day30_lowcv_download_cnt int comment '近一个月下载白领简历次数',
day30_intention_cnt int comment '近一个月意向沟通发起次数',
day30_invite_cnt int comment '近一个月邀请应聘发起次数',
day30_urgent_cnt int comment '近一个月急聘发起次数',
day30_consume_cv_cnt int comment '近一个月下载精英简历消耗数',
day30_consume_lowcv_cnt int comment '近一个月下载白领简历消耗数',
day30_consume_intention_cv_cnt int comment '近一个月意向沟通消耗简历数',
day30_consume_invite_cv_cnt int comment '近一个月邀请应聘消耗简历数',
day30_consume_urgent_cv_cnt int comment '近一个月急聘消耗简历数',
day30_consume_msk_cv_cnt int comment '近一个月面试快简历消耗数',
day30_ejob_avg_recv_cv_cnt int comment '近一个月职均投递数',
day30_recv_cv_cnt int comment '近一个月职位总投递数',
day30_recv_satisfied_cv_cnt int comment '近一个月投递满意数',
day30_recv_satisfied_ratio float comment '近一个月投递满意率',
day30_msk_service_cnt int comment '近一个月发起面试快服务数',
day30_msk_showup_service_cnt int comment '近一个月有到场面试快服务数',
day30_msk_showup_ratio float comment '近一个月面试快到场率',
day30_intention_valid_ratio float comment '近一个月意向沟通有效率',
day30_intention_submit_cnt int comment '近一个月意向沟通交付数',
day30_intention_submit_valid_cnt int comment '近一个月意向沟通有效交付数',

day90_cv_download_cnt int comment '近三个月下载精英简历次数',
day90_lowcv_download_cnt int comment '近三个月下载白领简历次数',
day90_intention_cnt int comment '近三个月意向沟通发起次数',
day90_invite_cnt int comment '近三个月邀请应聘发起次数',
day90_urgent_cnt int comment '近三个月急聘发起次数',
day90_consume_cv_cnt int comment '近三个月下载精英简历消耗数',
day90_consume_lowcv_cnt int comment '近三个月下载白领简历消耗数',
day90_consume_intention_cv_cnt int comment '近三个月意向沟通消耗简历数',
day90_consume_invite_cv_cnt int comment '近三个月邀请应聘消耗简历数',
day90_consume_urgent_cv_cnt int comment '近三个月急聘消耗简历数',
day90_consume_msk_cv_cnt int comment '近三个月面试快简历消耗数',
day90_ejob_avg_recv_cv_cnt int comment '近三个月职均投递数',
day90_recv_cv_cnt int comment '近三个月职位总投递数',
day90_recv_satisfied_cv_cnt int comment '近三个月投递满意数',
day90_recv_satisfied_ratio float comment '近三个月投递满意率',
day90_msk_service_cnt int comment '近三个月发起面试快服务数',
day90_msk_showup_service_cnt int comment '近三个月有到场面试快服务数',
day90_msk_showup_ratio float comment '近三个月面试快到场率',
day90_intention_valid_ratio float comment '近三个月意向沟通有效率',
day90_intention_submit_cnt int comment '近三个月意向沟通交付数',
day90_intention_submit_valid_cnt int comment '近三个月意向沟通有效交付数',

day180_cv_download_cnt int comment '近半年下载精英简历次数',
day180_lowcv_download_cnt int comment '近半年下载白领简历次数',
day180_intention_cnt int comment '近半年意向沟通发起次数',
day180_invite_cnt int comment '近半年邀请应聘发起次数',
day180_urgent_cnt int comment '近半年急聘发起次数',
day180_consume_cv_cnt int comment '近半年下载精英简历消耗数',
day180_consume_lowcv_cnt int comment '近半年下载白领简历消耗数',
day180_consume_intention_cv_cnt int comment '近半年意向沟通消耗简历数',
day180_consume_invite_cv_cnt int comment '近半年邀请应聘消耗简历数',
day180_consume_urgent_cv_cnt int comment '近半年急聘消耗简历数',
day180_consume_msk_cv_cnt int comment '近半年面试快简历消耗数',
day180_ejob_avg_recv_cv_cnt int comment '近半年职均投递数',
day180_recv_cv_cnt int comment '近半年职位总投递数',
day180_recv_satisfied_cv_cnt int comment '近半年投递满意数',
day180_recv_satisfied_ratio float comment '近半年投递满意率',
day180_msk_service_cnt int comment '近半年发起面试快服务数',
day180_msk_showup_service_cnt int comment '近半年有到场面试快服务数',
day180_msk_showup_ratio float comment '近半年面试快到场率',
day180_intention_valid_ratio float comment '近半年意向沟通有效率',
day180_intention_submit_cnt int comment '近半年意向沟通交付数',
day180_intention_submit_valid_cnt int comment '近半年意向沟通有效交付数',

is_lost_risk int comment '是否有流失风险',
consume_total_cnt int comment '生效资源数',
consume_level string comment '生效资源数分类',
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
creation_timestamp  timestamp comment '时间戳'
) comment '客户7天内使用报告'
partitioned by (p_date int);

insert overwrite table dw_erp_d_customer_report_main partition (p_date = $date$)
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
nvl(sum(day7_outer_behavior_cnt),0) as day7_outer_behavior_cnt,

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

nvl(sum(day30_cv_download_cnt),0) as day30_cv_download_cnt,
nvl(sum(day30_lowcv_download_cnt),0) as day30_lowcv_download_cnt,
nvl(sum(day30_intention_cnt),0) as day30_intention_cnt,
nvl(sum(day30_invite_cnt),0) as day30_invite_cnt,
nvl(sum(day30_urgent_cnt),0) as day30_urgent_cnt,
nvl(sum(day30_consume_cv_cnt),0) as day30_consume_cv_cnt,
nvl(sum(day30_consume_lowcv_cnt),0) as day30_consume_lowcv_cnt,
nvl(sum(day30_consume_intention_cv_cnt),0) as day30_consume_intention_cv_cnt,
nvl(sum(day30_consume_invite_cv_cnt),0) as day30_consume_invite_cv_cnt,
nvl(sum(day30_consume_urgent_cv_cnt),0) as day30_consume_urgent_cv_cnt,
nvl(sum(day30_consume_msk_cv_cnt),0) as day30_consume_msk_cv_cnt,
nvl(sum(day30_ejob_avg_recv_cv_cnt),0) as day30_ejob_avg_recv_cv_cnt,
nvl(sum(day30_recv_cv_cnt),0) as day30_recv_cv_cnt,
nvl(sum(day30_recv_satisfied_cv_cnt),0) as day30_recv_satisfied_cv_cnt,
nvl(sum(day30_recv_satisfied_ratio),0) as day30_recv_satisfied_ratio,
nvl(sum(day30_msk_service_cnt),0) as day30_msk_service_cnt,
nvl(sum(day30_msk_showup_service_cnt),0) as day30_msk_showup_service_cnt,
nvl(sum(day30_msk_showup_ratio),0) as day30_msk_showup_ratio,
nvl(sum(day30_intention_valid_ratio),0) as day30_intention_valid_ratio,
nvl(sum(day30_intention_submit_cnt),0) as day30_intention_submit_cnt,
nvl(sum(day30_intention_submit_valid_cnt),0) as day30_intention_submit_valid_cnt,

nvl(sum(day90_cv_download_cnt),0) as day90_cv_download_cnt,
nvl(sum(day90_lowcv_download_cnt),0) as day90_lowcv_download_cnt,
nvl(sum(day90_intention_cnt),0) as day90_intention_cnt,
nvl(sum(day90_invite_cnt),0) as day90_invite_cnt,
nvl(sum(day90_urgent_cnt),0) as day90_urgent_cnt,
nvl(sum(day90_consume_cv_cnt),0) as day90_consume_cv_cnt,
nvl(sum(day90_consume_lowcv_cnt),0) as day90_consume_lowcv_cnt,
nvl(sum(day90_consume_intention_cv_cnt),0) as day90_consume_intention_cv_cnt,
nvl(sum(day90_consume_invite_cv_cnt),0) as day90_consume_invite_cv_cnt,
nvl(sum(day90_consume_urgent_cv_cnt),0) as day90_consume_urgent_cv_cnt,
nvl(sum(day90_consume_msk_cv_cnt),0) as day90_consume_msk_cv_cnt,
nvl(sum(day90_ejob_avg_recv_cv_cnt),0) as day90_ejob_avg_recv_cv_cnt,
nvl(sum(day90_recv_cv_cnt),0) as day90_recv_cv_cnt,
nvl(sum(day90_recv_satisfied_cv_cnt),0) as day90_recv_satisfied_cv_cnt,
nvl(sum(day90_recv_satisfied_ratio),0) as day90_recv_satisfied_ratio,
nvl(sum(day90_msk_service_cnt),0) as day90_msk_service_cnt,
nvl(sum(day90_msk_showup_service_cnt),0) as day90_msk_showup_service_cnt,
nvl(sum(day90_msk_showup_ratio),0) as day90_msk_showup_ratio,
nvl(sum(day90_intention_valid_ratio),0) as day90_intention_valid_ratio,
nvl(sum(day90_intention_submit_cnt),0) as day90_intention_submit_cnt,
nvl(sum(day90_intention_submit_valid_cnt),0) as day90_intention_submit_valid_cnt,

nvl(sum(day180_cv_download_cnt),0) as day180_cv_download_cnt,
nvl(sum(day180_lowcv_download_cnt),0) as day180_lowcv_download_cnt,
nvl(sum(day180_intention_cnt),0) as day180_intention_cnt,
nvl(sum(day180_invite_cnt),0) as day180_invite_cnt,
nvl(sum(day180_urgent_cnt),0) as day180_urgent_cnt,
nvl(sum(day180_consume_cv_cnt),0) as day180_consume_cv_cnt,
nvl(sum(day180_consume_lowcv_cnt),0) as day180_consume_lowcv_cnt,
nvl(sum(day180_consume_intention_cv_cnt),0) as day180_consume_intention_cv_cnt,
nvl(sum(day180_consume_invite_cv_cnt),0) as day180_consume_invite_cv_cnt,
nvl(sum(day180_consume_urgent_cv_cnt),0) as day180_consume_urgent_cv_cnt,
nvl(sum(day180_consume_msk_cv_cnt),0) as day180_consume_msk_cv_cnt,
nvl(sum(day180_ejob_avg_recv_cv_cnt),0) as day180_ejob_avg_recv_cv_cnt,
nvl(sum(day180_recv_cv_cnt),0) as day180_recv_cv_cnt,
nvl(sum(day180_recv_satisfied_cv_cnt),0) as day180_recv_satisfied_cv_cnt,
nvl(sum(day180_recv_satisfied_ratio),0) as day180_recv_satisfied_ratio,
nvl(sum(day180_msk_service_cnt),0) as day180_msk_service_cnt,
nvl(sum(day180_msk_showup_service_cnt),0) as day180_msk_showup_service_cnt,
nvl(sum(day180_msk_showup_ratio),0) as day180_msk_showup_ratio,
nvl(sum(day180_intention_valid_ratio),0) as day180_intention_valid_ratio,
nvl(sum(day180_intention_submit_cnt),0) as day180_intention_submit_cnt,
nvl(sum(day180_intention_submit_valid_cnt),0) as day180_intention_submit_valid_cnt,

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
		0 as day7_outer_behavior_cnt,

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

		sum(day30_cv_download_cnt) as day30_cv_download_cnt,
		sum(day30_lowcv_download_cnt) as day30_lowcv_download_cnt,
		sum(day30_intention_cnt) as day30_intention_cnt,
		sum(day30_invite_cnt) as day30_invite_cnt,
		sum(day30_urgent_cnt) as day30_urgent_cnt,
		sum(day30_consume_cv_cnt) as day30_consume_cv_cnt,
		sum(day30_consume_lowcv_cnt) as day30_consume_lowcv_cnt,
		sum(day30_consume_intention_cv_cnt) as day30_consume_intention_cv_cnt,
		sum(day30_consume_invite_cv_cnt) as day30_consume_invite_cv_cnt,
		sum(day30_consume_urgent_cv_cnt) as day30_consume_urgent_cv_cnt,
		sum(day30_consume_msk_cv_cnt) as day30_consume_msk_cv_cnt,
		sum(day30_msk_service_cnt) as day30_msk_service_cnt,
		sum(day30_msk_showup_service_cnt) as day30_msk_showup_service_cnt,
		sum(day30_msk_showup_service_cnt) / sum(day30_msk_service_cnt) as day30_msk_showup_ratio,
		sum(day30_recv_cv_cnt) / sum(ejob_cnt) as day30_ejob_avg_recv_cv_cnt,
		sum(day30_recv_cv_cnt) as day30_recv_cv_cnt,
		sum(day30_recv_satisfied_cv_cnt) as day30_recv_satisfied_cv_cnt,
		sum(day30_recv_satisfied_cv_cnt) / sum(day30_recv_cv_cnt) as day30_recv_satisfied_ratio,
		sum(day30_intention_submit_valid_cnt) / sum(day30_intention_submit_cnt) as day30_intention_valid_ratio,
		sum(day30_intention_submit_cnt) as day30_intention_submit_cnt,
		sum(day30_intention_submit_valid_cnt) as day30_intention_submit_valid_cnt,

		sum(day90_cv_download_cnt) as day90_cv_download_cnt,
		sum(day90_lowcv_download_cnt) as day90_lowcv_download_cnt,
		sum(day90_intention_cnt) as day90_intention_cnt,
		sum(day90_invite_cnt) as day90_invite_cnt,
		sum(day90_urgent_cnt) as day90_urgent_cnt,
		sum(day90_consume_cv_cnt) as day90_consume_cv_cnt,
		sum(day90_consume_lowcv_cnt) as day90_consume_lowcv_cnt,
		sum(day90_consume_intention_cv_cnt) as day90_consume_intention_cv_cnt,
		sum(day90_consume_invite_cv_cnt) as day90_consume_invite_cv_cnt,
		sum(day90_consume_urgent_cv_cnt) as day90_consume_urgent_cv_cnt,
		sum(day90_consume_msk_cv_cnt) as day90_consume_msk_cv_cnt,
		sum(day90_msk_service_cnt) as day90_msk_service_cnt,
		sum(day90_msk_showup_service_cnt) as day90_msk_showup_service_cnt,
		sum(day90_msk_showup_service_cnt) / sum(day90_msk_service_cnt) as day90_msk_showup_ratio,
		sum(day90_recv_cv_cnt) / sum(ejob_cnt) as day90_ejob_avg_recv_cv_cnt,
		sum(day90_recv_cv_cnt) as day90_recv_cv_cnt,
		sum(day90_recv_satisfied_cv_cnt) as day90_recv_satisfied_cv_cnt,
		sum(day90_recv_satisfied_cv_cnt) / sum(day90_recv_cv_cnt) as day90_recv_satisfied_ratio,
		sum(day90_intention_submit_valid_cnt) / sum(day90_intention_submit_cnt) as day90_intention_valid_ratio,
		sum(day90_intention_submit_cnt) as day90_intention_submit_cnt,
		sum(day90_intention_submit_valid_cnt) as day90_intention_submit_valid_cnt,

		sum(day180_cv_download_cnt) as day180_cv_download_cnt,
		sum(day180_lowcv_download_cnt) as day180_lowcv_download_cnt,
		sum(day180_intention_cnt) as day180_intention_cnt,
		sum(day180_invite_cnt) as day180_invite_cnt,
		sum(day180_urgent_cnt) as day180_urgent_cnt,
		sum(day180_consume_cv_cnt) as day180_consume_cv_cnt,
		sum(day180_consume_lowcv_cnt) as day180_consume_lowcv_cnt,
		sum(day180_consume_intention_cv_cnt) as day180_consume_intention_cv_cnt,
		sum(day180_consume_invite_cv_cnt) as day180_consume_invite_cv_cnt,
		sum(day180_consume_urgent_cv_cnt) as day180_consume_urgent_cv_cnt,
		sum(day180_consume_msk_cv_cnt) as day180_consume_msk_cv_cnt,
		sum(day180_msk_service_cnt) as day180_msk_service_cnt,
		sum(day180_msk_showup_service_cnt) as day180_msk_showup_service_cnt,
		sum(day180_msk_showup_service_cnt) / sum(day180_msk_service_cnt) as day180_msk_showup_ratio,
		sum(day180_recv_cv_cnt) / sum(ejob_cnt) as day180_ejob_avg_recv_cv_cnt,
		sum(day180_recv_cv_cnt) as day180_recv_cv_cnt,
		sum(day180_recv_satisfied_cv_cnt) as day180_recv_satisfied_cv_cnt,
		sum(day180_recv_satisfied_cv_cnt) / sum(day180_recv_cv_cnt) as day180_recv_satisfied_ratio,
		sum(day180_intention_submit_valid_cnt) / sum(day180_intention_submit_cnt) as day180_intention_valid_ratio,
		sum(day180_intention_submit_cnt) as day180_intention_submit_cnt,
		sum(day180_intention_submit_valid_cnt) as day180_intention_submit_valid_cnt,

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
	from dw_erp_d_customer_report_usere
	where p_date = $date$
	group by customer_id
	union all 
	select  coalesce(tips1.customer_id , tips2.customer_id,tips3.customer_id) as customer_id,
			0 as active_ejob_cnt,
			0 as publish_day7_no_apply_ejob_cnt,
			0 as msk_potential_ejob_cnt,
			nvl(tips1.day7_login_cnt,0) as day7_login_cnt,
			0 as day7_consume_cv_total_cnt,
			0 as day7_active_ejob_cnt,
			0 as day7_im_userc_cnt,
			nvl(tips3.day7_outer_behavior_cnt,0) as day7_outer_behavior_cnt,
			
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

			0 as day30_cv_download_cnt,
			0 as day30_lowcv_download_cnt,
			0 as day30_intention_cnt,
			0 as day30_invite_cnt,
			0 as day30_urgent_cnt,
			0 as day30_consume_cv_cnt,
			0 as day30_consume_lowcv_cnt,
			0 as day30_consume_intention_cv_cnt,
			0 as day30_consume_invite_cv_cnt,
			0 as day30_consume_urgent_cv_cnt,
			0 as day30_consume_msk_cv_cnt,
			0 as day30_ejob_avg_recv_cv_cnt,
			0 as day30_recv_cv_cnt,
			0 as day30_recv_satisfied_cv_cnt,
			0 as day30_recv_satisfied_ratio,
			0 as day30_msk_service_cnt,
			0 as day30_msk_showup_service_cnt,
			0 as day30_msk_showup_ratio,
			0 as day30_intention_valid_ratio,
			0 as day30_intention_submit_cnt,
			0 as day30_intention_submit_valid_cnt,

			0 as day90_cv_download_cnt,
			0 as day90_lowcv_download_cnt,
			0 as day90_intention_cnt,
			0 as day90_invite_cnt,
			0 as day90_urgent_cnt,
			0 as day90_consume_cv_cnt,
			0 as day90_consume_lowcv_cnt,
			0 as day90_consume_intention_cv_cnt,
			0 as day90_consume_invite_cv_cnt,
			0 as day90_consume_urgent_cv_cnt,
			0 as day90_consume_msk_cv_cnt,
			0 as day90_ejob_avg_recv_cv_cnt,
			0 as day90_recv_cv_cnt,
			0 as day90_recv_satisfied_cv_cnt,
			0 as day90_recv_satisfied_ratio,
			0 as day90_msk_service_cnt,
			0 as day90_msk_showup_service_cnt,
			0 as day90_msk_showup_ratio,
			0 as day90_intention_valid_ratio,
			0 as day90_intention_submit_cnt,
			0 as day90_intention_submit_valid_cnt,		
			
			0 as day180_cv_download_cnt,
			0 as day180_lowcv_download_cnt,
			0 as day180_intention_cnt,
			0 as day180_invite_cnt,
			0 as day180_urgent_cnt,
			0 as day180_consume_cv_cnt,
			0 as day180_consume_lowcv_cnt,
			0 as day180_consume_intention_cv_cnt,
			0 as day180_consume_invite_cv_cnt,
			0 as day180_consume_urgent_cv_cnt,
			0 as day180_consume_msk_cv_cnt,
			0 as day180_ejob_avg_recv_cv_cnt,
			0 as day180_recv_cv_cnt,
			0 as day180_recv_satisfied_cv_cnt,
			0 as day180_recv_satisfied_ratio,
			0 as day180_msk_service_cnt,
			0 as day180_msk_showup_service_cnt,
			0 as day180_msk_showup_ratio,
			0 as day180_intention_valid_ratio,
			0 as day180_intention_submit_cnt,
			0 as day180_intention_submit_valid_cnt,				

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
		  from dw_erp_d_customer_report_ejob
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
	full join 
	(select
			hc.customer_id, count(cd.hawkeye_customer_id) as day7_outer_behavior_cnt
		from 
			(select 
				hawkeye_customer_id,
				regexp_replace(job_title,'	','') as job_title,
				unique_flag,
				substr(job_publish_time,1,8) as job_publish_time,
				substr(job_modify_time,1,8) as job_modify_time
			from customer_dynamic
			where deleteflag = 0
				and (substr(job_publish_time,1,8) between {{delta(date,-6)}} and '$date$' or 
					 substr(job_modify_time,1,8) between  {{delta(date,-6)}} and '$date$')
			)cd
			left outer join 
			(select 
				id,
				customer_id
			from hawkeye_customer 
			where deleteflag = 0
			)hc 
			on cd.hawkeye_customer_id = hc.id
			group by hc.customer_id
	) tips3	
	on tips1.customer_id = tips3.customer_id
) main1 
join dw_erp_d_customer_base base on main1.customer_id = base.id and base.p_date = '$date$' and base.ecomp_version = 2
group by base.id,base.name,base.ecomp_root_id,base.ecomp_id


create table dw_erp_a_customer_report_main(	
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
day7_outer_behavior_cnt int comment '近7天外部动态数',

cv_download_cnt int comment '近一年下载精英简历次数',
lowcv_download_cnt int comment '近一年下载白领简历次数',
intention_cnt int comment '近一年意向沟通发起次数',
invite_cnt int comment '近一年邀请应聘发起次数',
urgent_cnt int comment '近一年急聘发起次数',
consume_cv_cnt int comment '近一年下载精英简历消耗数',
consume_lowcv_cnt int comment '近一年下载白领简历消耗数',
consume_intention_cv_cnt int comment '近一年意向沟通消耗简历数',
consume_invite_cv_cnt int comment '近一年邀请应聘消耗简历数',
consume_urgent_cv_cnt int comment '近一年急聘消耗简历数',
consume_msk_cv_cnt int comment '近一年面试快简历消耗数',
ejob_avg_recv_cv_cnt int comment '近一年职均投递数',
recv_cv_cnt int comment '近一年职位总投递数',
recv_satisfied_cv_cnt int comment '近一年投递满意数',
recv_satisfied_ratio float comment '近一年投递满意率',
msk_service_cnt int comment '近一年发起面试快服务数',
msk_showup_service_cnt int comment '近一年有到场面试快服务数',
msk_showup_ratio float comment '近一年面试快到场率',
intention_valid_ratio float comment '近一年意向沟通有效率',
intention_submit_cnt int comment '近一年意向沟通交付数',
intention_submit_valid_cnt int comment '近一年意向沟通有效交付数',

day30_cv_download_cnt int comment '近一个月下载精英简历次数',
day30_lowcv_download_cnt int comment '近一个月下载白领简历次数',
day30_intention_cnt int comment '近一个月意向沟通发起次数',
day30_invite_cnt int comment '近一个月邀请应聘发起次数',
day30_urgent_cnt int comment '近一个月急聘发起次数',
day30_consume_cv_cnt int comment '近一个月下载精英简历消耗数',
day30_consume_lowcv_cnt int comment '近一个月下载白领简历消耗数',
day30_consume_intention_cv_cnt int comment '近一个月意向沟通消耗简历数',
day30_consume_invite_cv_cnt int comment '近一个月邀请应聘消耗简历数',
day30_consume_urgent_cv_cnt int comment '近一个月急聘消耗简历数',
day30_consume_msk_cv_cnt int comment '近一个月面试快简历消耗数',
day30_ejob_avg_recv_cv_cnt int comment '近一个月职均投递数',
day30_recv_cv_cnt int comment '近一个月职位总投递数',
day30_recv_satisfied_cv_cnt int comment '近一个月投递满意数',
day30_recv_satisfied_ratio float comment '近一个月投递满意率',
day30_msk_service_cnt int comment '近一个月发起面试快服务数',
day30_msk_showup_service_cnt int comment '近一个月有到场面试快服务数',
day30_msk_showup_ratio float comment '近一个月面试快到场率',
day30_intention_valid_ratio float comment '近一个月意向沟通有效率',
day30_intention_submit_cnt int comment '近一个月意向沟通交付数',
day30_intention_submit_valid_cnt int comment '近一个月意向沟通有效交付数',

day90_cv_download_cnt int comment '近三个月下载精英简历次数',
day90_lowcv_download_cnt int comment '近三个月下载白领简历次数',
day90_intention_cnt int comment '近三个月意向沟通发起次数',
day90_invite_cnt int comment '近三个月邀请应聘发起次数',
day90_urgent_cnt int comment '近三个月急聘发起次数',
day90_consume_cv_cnt int comment '近三个月下载精英简历消耗数',
day90_consume_lowcv_cnt int comment '近三个月下载白领简历消耗数',
day90_consume_intention_cv_cnt int comment '近三个月意向沟通消耗简历数',
day90_consume_invite_cv_cnt int comment '近三个月邀请应聘消耗简历数',
day90_consume_urgent_cv_cnt int comment '近三个月急聘消耗简历数',
day90_consume_msk_cv_cnt int comment '近三个月面试快简历消耗数',
day90_ejob_avg_recv_cv_cnt int comment '近三个月职均投递数',
day90_recv_cv_cnt int comment '近三个月职位总投递数',
day90_recv_satisfied_cv_cnt int comment '近三个月投递满意数',
day90_recv_satisfied_ratio float comment '近三个月投递满意率',
day90_msk_service_cnt int comment '近三个月发起面试快服务数',
day90_msk_showup_service_cnt int comment '近三个月有到场面试快服务数',
day90_msk_showup_ratio float comment '近三个月面试快到场率',
day90_intention_valid_ratio float comment '近三个月意向沟通有效率',
day90_intention_submit_cnt int comment '近三个月意向沟通交付数',
day90_intention_submit_valid_cnt int comment '近三个月意向沟通有效交付数',

day180_cv_download_cnt int comment '近半年下载精英简历次数',
day180_lowcv_download_cnt int comment '近半年下载白领简历次数',
day180_intention_cnt int comment '近半年意向沟通发起次数',
day180_invite_cnt int comment '近半年邀请应聘发起次数',
day180_urgent_cnt int comment '近半年急聘发起次数',
day180_consume_cv_cnt int comment '近半年下载精英简历消耗数',
day180_consume_lowcv_cnt int comment '近半年下载白领简历消耗数',
day180_consume_intention_cv_cnt int comment '近半年意向沟通消耗简历数',
day180_consume_invite_cv_cnt int comment '近半年邀请应聘消耗简历数',
day180_consume_urgent_cv_cnt int comment '近半年急聘消耗简历数',
day180_consume_msk_cv_cnt int comment '近半年面试快简历消耗数',
day180_ejob_avg_recv_cv_cnt int comment '近半年职均投递数',
day180_recv_cv_cnt int comment '近半年职位总投递数',
day180_recv_satisfied_cv_cnt int comment '近半年投递满意数',
day180_recv_satisfied_ratio float comment '近半年投递满意率',
day180_msk_service_cnt int comment '近半年发起面试快服务数',
day180_msk_showup_service_cnt int comment '近半年有到场面试快服务数',
day180_msk_showup_ratio float comment '近半年面试快到场率',
day180_intention_valid_ratio float comment '近半年意向沟通有效率',
day180_intention_submit_cnt int comment '近半年意向沟通交付数',
day180_intention_submit_valid_cnt int comment '近半年意向沟通有效交付数',

is_lost_risk int comment '是否有流失风险',
consume_total_cnt int comment '生效资源数',
consume_level string comment '生效资源数分类',
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
creation_timestamp  timestamp comment '时间戳'
) comment '客户7天内使用报告';

create table dw_erp_a_customer_report_main(	
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
day7_outer_behavior_cnt int comment '近7天外部动态数',


cv_download_cnt int comment '近一年下载精英简历次数',
lowcv_download_cnt int comment '近一年下载白领简历次数',
intention_cnt int comment '近一年意向沟通发起次数',
invite_cnt int comment '近一年邀请应聘发起次数',
urgent_cnt int comment '近一年急聘发起次数',
consume_cv_cnt int comment '近一年下载精英简历消耗数',
consume_lowcv_cnt int comment '近一年下载白领简历消耗数',
consume_intention_cv_cnt int comment '近一年意向沟通消耗简历数',
consume_invite_cv_cnt int comment '近一年邀请应聘消耗简历数',
consume_urgent_cv_cnt int comment '近一年急聘消耗简历数',
consume_msk_cv_cnt int comment '近一年面试快简历消耗数',
ejob_avg_recv_cv_cnt int comment '近一年职均投递数',
recv_cv_cnt int comment '近一年职位总投递数',
recv_satisfied_cv_cnt int comment '近一年投递满意数',
recv_satisfied_ratio float comment '近一年投递满意率',
msk_service_cnt int comment '近一年发起面试快服务数',
msk_showup_service_cnt int comment '近一年有到场面试快服务数',
msk_showup_ratio float comment '近一年面试快到场率',
intention_valid_ratio float comment '近一年意向沟通有效率',
intention_submit_cnt int comment '近一年意向沟通交付数',
intention_submit_valid_cnt int comment '近一年意向沟通有效交付数',

day30_cv_download_cnt int comment '近一个月下载精英简历次数',
day30_lowcv_download_cnt int comment '近一个月下载白领简历次数',
day30_intention_cnt int comment '近一个月意向沟通发起次数',
day30_invite_cnt int comment '近一个月邀请应聘发起次数',
day30_urgent_cnt int comment '近一个月急聘发起次数',
day30_consume_cv_cnt int comment '近一个月下载精英简历消耗数',
day30_consume_lowcv_cnt int comment '近一个月下载白领简历消耗数',
day30_consume_intention_cv_cnt int comment '近一个月意向沟通消耗简历数',
day30_consume_invite_cv_cnt int comment '近一个月邀请应聘消耗简历数',
day30_consume_urgent_cv_cnt int comment '近一个月急聘消耗简历数',
day30_consume_msk_cv_cnt int comment '近一个月面试快简历消耗数',
day30_ejob_avg_recv_cv_cnt int comment '近一个月职均投递数',
day30_recv_cv_cnt int comment '近一个月职位总投递数',
day30_recv_satisfied_cv_cnt int comment '近一个月投递满意数',
day30_recv_satisfied_ratio float comment '近一个月投递满意率',
day30_msk_service_cnt int comment '近一个月发起面试快服务数',
day30_msk_showup_service_cnt int comment '近一个月有到场面试快服务数',
day30_msk_showup_ratio float comment '近一个月面试快到场率',
day30_intention_valid_ratio float comment '近一个月意向沟通有效率',
day30_intention_submit_cnt int comment '近一个月意向沟通交付数',
day30_intention_submit_valid_cnt int comment '近一个月意向沟通有效交付数',

day90_cv_download_cnt int comment '近三个月下载精英简历次数',
day90_lowcv_download_cnt int comment '近三个月下载白领简历次数',
day90_intention_cnt int comment '近三个月意向沟通发起次数',
day90_invite_cnt int comment '近三个月邀请应聘发起次数',
day90_urgent_cnt int comment '近三个月急聘发起次数',
day90_consume_cv_cnt int comment '近三个月下载精英简历消耗数',
day90_consume_lowcv_cnt int comment '近三个月下载白领简历消耗数',
day90_consume_intention_cv_cnt int comment '近三个月意向沟通消耗简历数',
day90_consume_invite_cv_cnt int comment '近三个月邀请应聘消耗简历数',
day90_consume_urgent_cv_cnt int comment '近三个月急聘消耗简历数',
day90_consume_msk_cv_cnt int comment '近三个月面试快简历消耗数',
day90_ejob_avg_recv_cv_cnt int comment '近三个月职均投递数',
day90_recv_cv_cnt int comment '近三个月职位总投递数',
day90_recv_satisfied_cv_cnt int comment '近三个月投递满意数',
day90_recv_satisfied_ratio float comment '近三个月投递满意率',
day90_msk_service_cnt int comment '近三个月发起面试快服务数',
day90_msk_showup_service_cnt int comment '近三个月有到场面试快服务数',
day90_msk_showup_ratio float comment '近三个月面试快到场率',
day90_intention_valid_ratio float comment '近三个月意向沟通有效率',
day90_intention_submit_cnt int comment '近三个月意向沟通交付数',
day90_intention_submit_valid_cnt int comment '近三个月意向沟通有效交付数',

day180_cv_download_cnt int comment '近半年下载精英简历次数',
day180_lowcv_download_cnt int comment '近半年下载白领简历次数',
day180_intention_cnt int comment '近半年意向沟通发起次数',
day180_invite_cnt int comment '近半年邀请应聘发起次数',
day180_urgent_cnt int comment '近半年急聘发起次数',
day180_consume_cv_cnt int comment '近半年下载精英简历消耗数',
day180_consume_lowcv_cnt int comment '近半年下载白领简历消耗数',
day180_consume_intention_cv_cnt int comment '近半年意向沟通消耗简历数',
day180_consume_invite_cv_cnt int comment '近半年邀请应聘消耗简历数',
day180_consume_urgent_cv_cnt int comment '近半年急聘消耗简历数',
day180_consume_msk_cv_cnt int comment '近半年面试快简历消耗数',
day180_ejob_avg_recv_cv_cnt int comment '近半年职均投递数',
day180_recv_cv_cnt int comment '近半年职位总投递数',
day180_recv_satisfied_cv_cnt int comment '近半年投递满意数',
day180_recv_satisfied_ratio float comment '近半年投递满意率',
day180_msk_service_cnt int comment '近半年发起面试快服务数',
day180_msk_showup_service_cnt int comment '近半年有到场面试快服务数',
day180_msk_showup_ratio float comment '近半年面试快到场率',
day180_intention_valid_ratio float comment '近半年意向沟通有效率',
day180_intention_submit_cnt int comment '近半年意向沟通交付数',
day180_intention_submit_valid_cnt int comment '近半年意向沟通有效交付数',

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

insert overwrite table dw_erp_a_customer_report_main 
select d_date
, customer_id
, customer_name
, ecomp_root_id
, ecomp_id
, active_ejob_cnt
, publish_day7_no_apply_ejob_cnt
, msk_potential_ejob_cnt
, day7_login_cnt
, day7_consume_cv_total_cnt
, day7_active_ejob_cnt
, day7_im_userc_cnt
, day7_outer_behavior_cnt
, cv_download_cnt
, lowcv_download_cnt
, intention_cnt
, invite_cnt
, urgent_cnt
, consume_cv_cnt
, consume_lowcv_cnt
, consume_intention_cv_cnt
, consume_invite_cv_cnt
, consume_urgent_cv_cnt
, consume_msk_cv_cnt
, ejob_avg_recv_cv_cnt
, recv_cv_cnt
, recv_satisfied_cv_cnt
, recv_satisfied_ratio
, msk_service_cnt
, msk_showup_service_cnt
, msk_showup_ratio
, intention_valid_ratio
, intention_submit_cnt
, intention_submit_valid_cnt
, day30_cv_download_cnt
, day30_lowcv_download_cnt
, day30_intention_cnt
, day30_invite_cnt
, day30_urgent_cnt
, day30_consume_cv_cnt
, day30_consume_lowcv_cnt
, day30_consume_intention_cv_cnt
, day30_consume_invite_cv_cnt
, day30_consume_urgent_cv_cnt
, day30_consume_msk_cv_cnt
, day30_ejob_avg_recv_cv_cnt
, day30_recv_cv_cnt
, day30_recv_satisfied_cv_cnt
, day30_recv_satisfied_ratio
, day30_msk_service_cnt
, day30_msk_showup_service_cnt
, day30_msk_showup_ratio
, day30_intention_valid_ratio
, day30_intention_submit_cnt
, day30_intention_submit_valid_cnt
, day90_cv_download_cnt
, day90_lowcv_download_cnt
, day90_intention_cnt
, day90_invite_cnt
, day90_urgent_cnt
, day90_consume_cv_cnt
, day90_consume_lowcv_cnt
, day90_consume_intention_cv_cnt
, day90_consume_invite_cv_cnt
, day90_consume_urgent_cv_cnt
, day90_consume_msk_cv_cnt
, day90_ejob_avg_recv_cv_cnt
, day90_recv_cv_cnt
, day90_recv_satisfied_cv_cnt
, day90_recv_satisfied_ratio
, day90_msk_service_cnt
, day90_msk_showup_service_cnt
, day90_msk_showup_ratio
, day90_intention_valid_ratio
, day90_intention_submit_cnt
, day90_intention_submit_valid_cnt
, day180_cv_download_cnt
, day180_lowcv_download_cnt
, day180_intention_cnt
, day180_invite_cnt
, day180_urgent_cnt
, day180_consume_cv_cnt
, day180_consume_lowcv_cnt
, day180_consume_intention_cv_cnt
, day180_consume_invite_cv_cnt
, day180_consume_urgent_cv_cnt
, day180_consume_msk_cv_cnt
, day180_ejob_avg_recv_cv_cnt
, day180_recv_cv_cnt
, day180_recv_satisfied_cv_cnt
, day180_recv_satisfied_ratio
, day180_msk_service_cnt
, day180_msk_showup_service_cnt
, day180_msk_showup_ratio
, day180_intention_valid_ratio
, day180_intention_submit_cnt
, day180_intention_submit_valid_cnt
, is_lost_risk
, consume_total_cnt
, consume_level
, day30_login_cnt
, second_day30_login_cnt
, third_day30_login_cnt
, consume_level_avg_login_cnt
, lp_total_cv_cnt
, lp_left_cv_cnt
, is_left_cv_10p
, in_msk_service_cnt
, is_in_msk_cv_lack
, is_have_msk_potential_ejob
, creation_timestamp
from dw_erp_d_customer_report_main
where p_date = $date$




CREATE TABLE dw_erp_d_customer_report_usere(
  d_date int COMMENT '统计日期', 
  usere_id int COMMENT 'hr主键id', 
  usere_name string COMMENT 'hr名称', 
  usere_account string COMMENT 'hr猎聘通账号', 
  usere_account_status int COMMENT '猎聘通账号状态', 
  customer_id int COMMENT '客户id', 
  customer_name string COMMENT '客户名称', 
  ecomp_root_id int COMMENT 'ecomp_root_id', 
  ecomp_id int COMMENT 'ecomp_id', 
  ecomp_name string COMMENT 'ecomp_name', 
  active_ejob_cnt int COMMENT '活跃职位数', 
  publish_day7_no_apply_ejob_cnt int COMMENT '发布七天以上无投递职位数', 
  msk_potential_ejob_cnt int COMMENT '面试快潜力职位数', 
  day7_login_cnt int COMMENT '近7天登录天数', 
  day7_consume_cv_total_cnt int COMMENT '近7天精英资源综合消耗', 
  day7_active_ejob_cnt int COMMENT '近7天活跃职位数', 
  day7_im_userc_cnt int COMMENT '近7天职聊人数', 
  day7_2_login_cnt int comment '近第2个7天登陆猎聘天数',
  day7_3_login_cnt int comment '近第3个7天登陆猎聘天数',
  day7_4_login_cnt int comment '近第4个7天登陆猎聘天数',
  day7_5_login_cnt int comment '近第5个7天登陆猎聘天数',
  day7_6_login_cnt int comment '近第6个7天登陆猎聘天数',
  day7_7_login_cnt int comment '近第7个7天登陆猎聘天数',
  day7_8_login_cnt int comment '近第8个7天登陆猎聘天数',
  day7_9_login_cnt int comment '近第9个7天登陆猎聘天数',
  day7_10_login_cnt int comment '近第10个7天登陆猎聘天数',
  day7_11_login_cnt int comment '近第11个7天登陆猎聘天数',
  day7_12_login_cnt int comment '近第12个7天登陆猎聘天数',
  day7_13_login_cnt int comment '近第13个7天登陆猎聘天数',
  day7_14_login_cnt int comment '近第14个7天登陆猎聘天数',
  day7_2_consume_cv_total_cnt int comment '近第2个7天精英资源综合消耗',
  day7_3_consume_cv_total_cnt int comment '近第3个7天精英资源综合消耗',
  day7_4_consume_cv_total_cnt int comment '近第4个7天精英资源综合消耗',
  day7_5_consume_cv_total_cnt int comment '近第5个7天精英资源综合消耗',
  day7_6_consume_cv_total_cnt int comment '近第6个7天精英资源综合消耗',
  day7_7_consume_cv_total_cnt int comment '近第7个7天精英资源综合消耗',
  day7_8_consume_cv_total_cnt int comment '近第8个7天精英资源综合消耗',
  day7_9_consume_cv_total_cnt int comment '近第9个7天精英资源综合消耗',
  day7_10_consume_cv_total_cnt int comment '近第10个7天精英资源综合消耗',
  day7_11_consume_cv_total_cnt int comment '近第11个7天精英资源综合消耗',
  day7_12_consume_cv_total_cnt int comment '近第12个7天精英资源综合消耗',
  day7_13_consume_cv_total_cnt int comment '近第13个7天精英资源综合消耗',
  day7_14_consume_cv_total_cnt int comment '近第14个7天精英资源综合消耗',
  day7_2_active_ejob_cnt int comment '近第2个7天活跃职位数',
  day7_3_active_ejob_cnt int comment '近第3个7天活跃职位数',
  day7_4_active_ejob_cnt int comment '近第4个7天活跃职位数',
  day7_5_active_ejob_cnt int comment '近第5个7天活跃职位数',
  day7_6_active_ejob_cnt int comment '近第6个7天活跃职位数',
  day7_7_active_ejob_cnt int comment '近第7个7天活跃职位数',
  day7_8_active_ejob_cnt int comment '近第8个7天活跃职位数',
  day7_9_active_ejob_cnt int comment '近第9个7天活跃职位数',
  day7_10_active_ejob_cnt int comment '近第10个7天活跃职位数',
  day7_11_active_ejob_cnt int comment '近第11个7天活跃职位数',
  day7_12_active_ejob_cnt int comment '近第12个7天活跃职位数',
  day7_13_active_ejob_cnt int comment '近第13个7天活跃职位数',
  day7_14_active_ejob_cnt int comment '近第14个7天活跃职位数',
  day7_2_im_userc_cnt int comment '近第2个7天职聊人数',
  day7_3_im_userc_cnt int comment '近第3个7天职聊人数',
  day7_4_im_userc_cnt int comment '近第4个7天职聊人数',
  day7_5_im_userc_cnt int comment '近第5个7天职聊人数',
  day7_6_im_userc_cnt int comment '近第6个7天职聊人数',
  day7_7_im_userc_cnt int comment '近第7个7天职聊人数',
  day7_8_im_userc_cnt int comment '近第8个7天职聊人数',
  day7_9_im_userc_cnt int comment '近第9个7天职聊人数',
  day7_10_im_userc_cnt int comment '近第10个7天职聊人数',
  day7_11_im_userc_cnt int comment '近第11个7天职聊人数',
  day7_12_im_userc_cnt int comment '近第12个7天职聊人数',
  day7_13_im_userc_cnt int comment '近第13个7天职聊人数',
  day7_14_im_userc_cnt int comment '近第14个7天职聊人数',
  cv_download_cnt int COMMENT '近一年下载精英简历', 
  lowcv_download_cnt int COMMENT '近一年下载白领简历', 
  intention_cnt int COMMENT '近一年意向沟通', 
  invite_cnt int COMMENT '近一年邀请应聘', 
  urgent_cnt int COMMENT '近一年急聘', 
  consume_cv_cnt int COMMENT '近一年下载精英简历消耗数', 
  consume_lowcv_cnt int COMMENT '近一年下载白领简历消耗数', 
  consume_intention_cv_cnt int COMMENT '近一年意向沟通消耗简历数', 
  consume_invite_cv_cnt int COMMENT '近一年邀请应聘消耗简历数', 
  consume_urgent_cv_cnt int COMMENT '近一年急聘消耗简历数', 
  consume_msk_cv_cnt int COMMENT '近一年面试快简历消耗数', 
  msk_service_cnt int COMMENT '近一年发起面试快服务数', 
  msk_showup_service_cnt int COMMENT '近一年有到场面试快服务数', 
  msk_showup_ratio float COMMENT '近一年面试快到场率', 
  ejob_avg_recv_cv_cnt int COMMENT '近一年职均投递数', 
  recv_cv_cnt int COMMENT '近一年职位总投递数', 
  recv_satisfied_cv_cnt int COMMENT '近一年投递满意数', 
  recv_satisfied_ratio float COMMENT '近一年投递满意率', 
  intention_valid_ratio float COMMENT '近一年意向沟通有效率', 
  intention_submit_cnt int COMMENT '近一年意向沟通交付数', 
  intention_submit_valid_cnt int COMMENT '近一年意向沟通有效交付数', 
  day30_cv_download_cnt int COMMENT '近一个月下载精英简历', 
  day30_lowcv_download_cnt int COMMENT '近一个月下载白领简历', 
  day30_intention_cnt int COMMENT '近一个月意向沟通', 
  day30_invite_cnt int COMMENT '近一个月邀请应聘', 
  day30_urgent_cnt int COMMENT '近一个月急聘', 
  day30_consume_cv_cnt int COMMENT '近一个月下载精英简历消耗数', 
  day30_consume_lowcv_cnt int COMMENT '近一个月下载白领简历消耗数', 
  day30_consume_intention_cv_cnt int COMMENT '近一个月意向沟通消耗简历数', 
  day30_consume_invite_cv_cnt int COMMENT '近一个月邀请应聘消耗简历数', 
  day30_consume_urgent_cv_cnt int COMMENT '近一个月急聘消耗简历数', 
  day30_consume_msk_cv_cnt int COMMENT '近一个月面试快简历消耗数', 
  day30_msk_service_cnt int COMMENT '近一个月发起面试快服务数', 
  day30_msk_showup_service_cnt int COMMENT '近一个月有到场面试快服务数', 
  day30_msk_showup_ratio float COMMENT '近一个月面试快到场率', 
  day30_ejob_avg_recv_cv_cnt int COMMENT '近一个月职均投递数', 
  day30_recv_cv_cnt int COMMENT '近一个月职位总投递数', 
  day30_recv_satisfied_cv_cnt int COMMENT '近一个月投递满意数', 
  day30_recv_satisfied_ratio float COMMENT '近一个月投递满意率', 
  day30_intention_valid_ratio float COMMENT '近一个月意向沟通有效率', 
  day30_intention_submit_cnt int COMMENT '近一个月意向沟通交付数', 
  day30_intention_submit_valid_cnt int COMMENT '近一个月意向沟通有效交付数', 
  day90_cv_download_cnt int COMMENT '近三个月下载精英简历', 
  day90_lowcv_download_cnt int COMMENT '近三个月下载白领简历', 
  day90_intention_cnt int COMMENT '近三个月意向沟通', 
  day90_invite_cnt int COMMENT '近三个月邀请应聘', 
  day90_urgent_cnt int COMMENT '近三个月急聘', 
  day90_consume_cv_cnt int COMMENT '近三个月下载精英简历消耗数', 
  day90_consume_lowcv_cnt int COMMENT '近三个月下载白领简历消耗数', 
  day90_consume_intention_cv_cnt int COMMENT '近三个月意向沟通消耗简历数', 
  day90_consume_invite_cv_cnt int COMMENT '近三个月邀请应聘消耗简历数', 
  day90_consume_urgent_cv_cnt int COMMENT '近三个月急聘消耗简历数', 
  day90_consume_msk_cv_cnt int COMMENT '近三个月面试快简历消耗数', 
  day90_msk_service_cnt int COMMENT '近三个月发起面试快服务数', 
  day90_msk_showup_service_cnt int COMMENT '近三个月有到场面试快服务数', 
  day90_msk_showup_ratio float COMMENT '近三个月面试快到场率', 
  day90_ejob_avg_recv_cv_cnt int COMMENT '近三个月职均投递数', 
  day90_recv_cv_cnt int COMMENT '近三个月职位总投递数', 
  day90_recv_satisfied_cv_cnt int COMMENT '近三个月投递满意数', 
  day90_recv_satisfied_ratio float COMMENT '近三个月投递满意率', 
  day90_intention_valid_ratio float COMMENT '近三个月意向沟通有效率', 
  day90_intention_submit_cnt int COMMENT '近三个月意向沟通交付数', 
  day90_intention_submit_valid_cnt int COMMENT '近三个月意向沟通有效交付数', 
  day180_cv_download_cnt int COMMENT '近半年下载精英简历', 
  day180_lowcv_download_cnt int COMMENT '近半年下载白领简历', 
  day180_intention_cnt int COMMENT '近半年意向沟通', 
  day180_invite_cnt int COMMENT '近半年邀请应聘', 
  day180_urgent_cnt int COMMENT '近半年急聘', 
  day180_consume_cv_cnt int COMMENT '近半年下载精英简历消耗数', 
  day180_consume_lowcv_cnt int COMMENT '近半年下载白领简历消耗数', 
  day180_consume_intention_cv_cnt int COMMENT '近半年意向沟通消耗简历数', 
  day180_consume_invite_cv_cnt int COMMENT '近半年邀请应聘消耗简历数', 
  day180_consume_urgent_cv_cnt int COMMENT '近半年急聘消耗简历数', 
  day180_consume_msk_cv_cnt int COMMENT '近半年面试快简历消耗数', 
  day180_msk_service_cnt int COMMENT '近半年发起面试快服务数', 
  day180_msk_showup_service_cnt int COMMENT '近半年有到场面试快服务数', 
  day180_msk_showup_ratio float COMMENT '近半年面试快到场率', 
  day180_ejob_avg_recv_cv_cnt int COMMENT '近半年职均投递数', 
  day180_recv_cv_cnt int COMMENT '近半年职位总投递数', 
  day180_recv_satisfied_cv_cnt int COMMENT '近半年投递满意数', 
  day180_recv_satisfied_ratio float COMMENT '近半年投递满意率', 
  day180_intention_valid_ratio float COMMENT '近半年意向沟通有效率', 
  day180_intention_submit_cnt int COMMENT '近半年意向沟通交付数', 
  day180_intention_submit_valid_cnt int COMMENT '近半年意向沟通有效交付数', 
  ejob_cnt int COMMENT '累计发布职位数', 
  day30_ejob_cnt int COMMENT '近一个月发布职位数', 
  day90_ejob_cnt int COMMENT '近三个月发布职位数', 
  day180_ejob_cnt int COMMENT '近半年发布职位数', 
  recv_deal_cv_cnt int COMMENT '累计投递处理量', 
  day30_recv_deal_cv_cnt int COMMENT '近一个月投递处理量', 
  day90_recv_deal_cv_cnt int COMMENT '近三个月投递处理量', 
  day180_recv_deal_cv_cnt int COMMENT '近半年投递处理量', 
  day365_recv_deal_cv_cnt int COMMENT '一年内投递处理量',   
  msk_takeorder_service_cnt int COMMENT '累计内有接单面试快服务数', 
  day30_msk_takeorder_service_cnt int COMMENT '近一个月有接单面试快服务数', 
  day90_msk_takeorder_service_cnt int COMMENT '近三个月有接单面试快服务数', 
  day180_msk_takeorder_service_cnt int COMMENT '近半年有接单面试快服务数', 
  day365_msk_takeorder_service_cnt int COMMENT '一年内有接单面试快服务数',
  ecomp_day7_login_cnt int COMMENT '分支机构近7天登录天数', 
  ecomp_day7_2_login_cnt int comment '分支机构近第2个7天登陆猎聘天数',
  ecomp_day7_3_login_cnt int comment '分支机构近第3个7天登陆猎聘天数',
  ecomp_day7_4_login_cnt int comment '分支机构近第4个7天登陆猎聘天数',
  ecomp_day7_5_login_cnt int comment '分支机构近第5个7天登陆猎聘天数',
  ecomp_day7_6_login_cnt int comment '分支机构近第6个7天登陆猎聘天数',
  ecomp_day7_7_login_cnt int comment '分支机构近第7个7天登陆猎聘天数',
  ecomp_day7_8_login_cnt int comment '分支机构近第8个7天登陆猎聘天数',
  ecomp_day7_9_login_cnt int comment '分支机构近第9个7天登陆猎聘天数',
  ecomp_day7_10_login_cnt int comment '分支机构近第10个7天登陆猎聘天数',
  ecomp_day7_11_login_cnt int comment '分支机构近第11个7天登陆猎聘天数',
  ecomp_day7_12_login_cnt int comment '分支机构近第12个7天登陆猎聘天数',
  ecomp_day7_13_login_cnt int comment '分支机构近第13个7天登陆猎聘天数',
  ecomp_day7_14_login_cnt int comment '分支机构近第14个7天登陆猎聘天数',  
  customer_day7_login_cnt int COMMENT '客户近7天登录天数', 
  customer_day7_2_login_cnt int comment '客户近第2个7天登陆猎聘天数',
  customer_day7_3_login_cnt int comment '客户近第3个7天登陆猎聘天数',
  customer_day7_4_login_cnt int comment '客户近第4个7天登陆猎聘天数',
  customer_day7_5_login_cnt int comment '客户近第5个7天登陆猎聘天数',
  customer_day7_6_login_cnt int comment '客户近第6个7天登陆猎聘天数',
  customer_day7_7_login_cnt int comment '客户近第7个7天登陆猎聘天数',
  customer_day7_8_login_cnt int comment '客户近第8个7天登陆猎聘天数',
  customer_day7_9_login_cnt int comment '客户近第9个7天登陆猎聘天数',
  customer_day7_10_login_cnt int comment '客户近第10个7天登陆猎聘天数',
  customer_day7_11_login_cnt int comment '客户近第11个7天登陆猎聘天数',
  customer_day7_12_login_cnt int comment '客户近第12个7天登陆猎聘天数',
  customer_day7_13_login_cnt int comment '客户近第13个7天登陆猎聘天数',
  customer_day7_14_login_cnt int comment '客户近第14个7天登陆猎聘天数',  
  creation_timestamp timestamp COMMENT '时间戳'
  )
COMMENT '客户hr7天内使用报告'
PARTITIONED BY (p_date int);
;


ecomp_day7_2_login_cnt int comment '分支机构近第2个7天登陆猎聘天数',
ecomp_day7_3_login_cnt int comment '分支机构近第3个7天登陆猎聘天数',
ecomp_day7_4_login_cnt int comment '分支机构近第4个7天登陆猎聘天数',
ecomp_day7_5_login_cnt int comment '分支机构近第5个7天登陆猎聘天数',
ecomp_day7_6_login_cnt int comment '分支机构近第6个7天登陆猎聘天数',
ecomp_day7_7_login_cnt int comment '分支机构近第7个7天登陆猎聘天数',
ecomp_day7_8_login_cnt int comment '分支机构近第8个7天登陆猎聘天数',
ecomp_day7_9_login_cnt int comment '分支机构近第9个7天登陆猎聘天数',
ecomp_day7_10_login_cnt int comment '分支机构近第10个7天登陆猎聘天数',
ecomp_day7_11_login_cnt int comment '分支机构近第11个7天登陆猎聘天数',
ecomp_day7_12_login_cnt int comment '分支机构近第12个7天登陆猎聘天数',
ecomp_day7_13_login_cnt int comment '分支机构近第13个7天登陆猎聘天数',
ecomp_day7_14_login_cnt int comment '分支机构近第14个7天登陆猎聘天数',
customer_day7_2_login_cnt int comment '客户近第2个7天登陆猎聘天数',
customer_day7_3_login_cnt int comment '客户近第3个7天登陆猎聘天数',
customer_day7_4_login_cnt int comment '客户近第4个7天登陆猎聘天数',
customer_day7_5_login_cnt int comment '客户近第5个7天登陆猎聘天数',
customer_day7_6_login_cnt int comment '客户近第6个7天登陆猎聘天数',
customer_day7_7_login_cnt int comment '客户近第7个7天登陆猎聘天数',
customer_day7_8_login_cnt int comment '客户近第8个7天登陆猎聘天数',
customer_day7_9_login_cnt int comment '客户近第9个7天登陆猎聘天数',
customer_day7_10_login_cnt int comment '客户近第10个7天登陆猎聘天数',
customer_day7_11_login_cnt int comment '客户近第11个7天登陆猎聘天数',
customer_day7_12_login_cnt int comment '客户近第12个7天登陆猎聘天数',
customer_day7_13_login_cnt int comment '客户近第13个7天登陆猎聘天数',
customer_day7_14_login_cnt int comment '客户近第14个7天登陆猎聘天数',
day7_2_login_cnt int comment '近第2个7天登陆猎聘天数',
day7_3_login_cnt int comment '近第3个7天登陆猎聘天数',
day7_4_login_cnt int comment '近第4个7天登陆猎聘天数',
day7_5_login_cnt int comment '近第5个7天登陆猎聘天数',
day7_6_login_cnt int comment '近第6个7天登陆猎聘天数',
day7_7_login_cnt int comment '近第7个7天登陆猎聘天数',
day7_8_login_cnt int comment '近第8个7天登陆猎聘天数',
day7_9_login_cnt int comment '近第9个7天登陆猎聘天数',
day7_10_login_cnt int comment '近第10个7天登陆猎聘天数',
day7_11_login_cnt int comment '近第11个7天登陆猎聘天数',
day7_12_login_cnt int comment '近第12个7天登陆猎聘天数',
day7_13_login_cnt int comment '近第13个7天登陆猎聘天数',
day7_14_login_cnt int comment '近第14个7天登陆猎聘天数',
day7_2_consume_cv_total_cnt int comment '近第2个7天精英资源综合消耗',
day7_3_consume_cv_total_cnt int comment '近第3个7天精英资源综合消耗',
day7_4_consume_cv_total_cnt int comment '近第4个7天精英资源综合消耗',
day7_5_consume_cv_total_cnt int comment '近第5个7天精英资源综合消耗',
day7_6_consume_cv_total_cnt int comment '近第6个7天精英资源综合消耗',
day7_7_consume_cv_total_cnt int comment '近第7个7天精英资源综合消耗',
day7_8_consume_cv_total_cnt int comment '近第8个7天精英资源综合消耗',
day7_9_consume_cv_total_cnt int comment '近第9个7天精英资源综合消耗',
day7_10_consume_cv_total_cnt int comment '近第10个7天精英资源综合消耗',
day7_11_consume_cv_total_cnt int comment '近第11个7天精英资源综合消耗',
day7_12_consume_cv_total_cnt int comment '近第12个7天精英资源综合消耗',
day7_13_consume_cv_total_cnt int comment '近第13个7天精英资源综合消耗',
day7_14_consume_cv_total_cnt int comment '近第14个7天精英资源综合消耗',
day7_2_active_ejob_cnt int comment '近第2个7天活跃职位数',
day7_3_active_ejob_cnt int comment '近第3个7天活跃职位数',
day7_4_active_ejob_cnt int comment '近第4个7天活跃职位数',
day7_5_active_ejob_cnt int comment '近第5个7天活跃职位数',
day7_6_active_ejob_cnt int comment '近第6个7天活跃职位数',
day7_7_active_ejob_cnt int comment '近第7个7天活跃职位数',
day7_8_active_ejob_cnt int comment '近第8个7天活跃职位数',
day7_9_active_ejob_cnt int comment '近第9个7天活跃职位数',
day7_10_active_ejob_cnt int comment '近第10个7天活跃职位数',
day7_11_active_ejob_cnt int comment '近第11个7天活跃职位数',
day7_12_active_ejob_cnt int comment '近第12个7天活跃职位数',
day7_13_active_ejob_cnt int comment '近第13个7天活跃职位数',
day7_14_active_ejob_cnt int comment '近第14个7天活跃职位数',
day7_2_im_userc_cnt int comment '近第2个7天职聊人数',
day7_3_im_userc_cnt int comment '近第3个7天职聊人数',
day7_4_im_userc_cnt int comment '近第4个7天职聊人数',
day7_5_im_userc_cnt int comment '近第5个7天职聊人数',
day7_6_im_userc_cnt int comment '近第6个7天职聊人数',
day7_7_im_userc_cnt int comment '近第7个7天职聊人数',
day7_8_im_userc_cnt int comment '近第8个7天职聊人数',
day7_9_im_userc_cnt int comment '近第9个7天职聊人数',
day7_10_im_userc_cnt int comment '近第10个7天职聊人数',
day7_11_im_userc_cnt int comment '近第11个7天职聊人数',
day7_12_im_userc_cnt int comment '近第12个7天职聊人数',
day7_13_im_userc_cnt int comment '近第13个7天职聊人数',
day7_14_im_userc_cnt int comment '近第14个7天职聊人数',

alter table dw_erp_a_customer_report_usere add 
(
	day365_msk_service_cnt int comment '近一年发起面试快服务数',
	day365_msk_showup_service_cnt int comment '近一年有到场面试快服务数',
	day365_msk_showup_ratio float comment '近一年面试快到场率',
	day365_recv_cv_cnt int comment '近一年投递数',
	day365_recv_satisfied_cv_cnt int comment '近一年投递满意数',
	day365_recv_satisfied_ratio float comment '近一年投递满意率',
	day365_intention_submit_cnt int comment '近一年意向沟通交付数',
	day365_intention_submit_valid_cnt int comment '近一年意向沟通有效交付数',
	day365_intention_valid_ratio float comment '近一年意向沟通有效率',
	day365_ejob_cnt int comment '近一年发布职位数',
	day365_ejob_avg_recv_cv_cnt int comment '近一年职均投递数'
);

insert overwrite table dw_erp_d_customer_report_usere partition (p_date = $date$)
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
usere_act.day7_2_login_cnt as day7_2_login_cnt, 
usere_act.day7_3_login_cnt as day7_3_login_cnt, 
usere_act.day7_4_login_cnt as day7_4_login_cnt, 
usere_act.day7_5_login_cnt as day7_5_login_cnt, 
usere_act.day7_6_login_cnt as day7_6_login_cnt, 
usere_act.day7_7_login_cnt as day7_7_login_cnt, 
usere_act.day7_8_login_cnt as day7_8_login_cnt, 
usere_act.day7_9_login_cnt as day7_9_login_cnt, 
usere_act.day7_10_login_cnt as day7_10_login_cnt, 
usere_act.day7_11_login_cnt as day7_11_login_cnt, 
usere_act.day7_12_login_cnt as day7_12_login_cnt, 
usere_act.day7_13_login_cnt as day7_13_login_cnt, 
usere_act.day7_14_login_cnt as day7_14_login_cnt, 
usere_act.day7_2_consume_cv_total_cnt as day7_2_consume_cv_total_cnt, 
usere_act.day7_3_consume_cv_total_cnt as day7_3_consume_cv_total_cnt, 
usere_act.day7_4_consume_cv_total_cnt as day7_4_consume_cv_total_cnt, 
usere_act.day7_5_consume_cv_total_cnt as day7_5_consume_cv_total_cnt, 
usere_act.day7_6_consume_cv_total_cnt as day7_6_consume_cv_total_cnt, 
usere_act.day7_7_consume_cv_total_cnt as day7_7_consume_cv_total_cnt, 
usere_act.day7_8_consume_cv_total_cnt as day7_8_consume_cv_total_cnt, 
usere_act.day7_9_consume_cv_total_cnt as day7_9_consume_cv_total_cnt, 
usere_act.day7_10_consume_cv_total_cnt as day7_10_consume_cv_total_cnt, 
usere_act.day7_11_consume_cv_total_cnt as day7_11_consume_cv_total_cnt, 
usere_act.day7_12_consume_cv_total_cnt as day7_12_consume_cv_total_cnt, 
usere_act.day7_13_consume_cv_total_cnt as day7_13_consume_cv_total_cnt, 
usere_act.day7_14_consume_cv_total_cnt as day7_14_consume_cv_total_cnt, 
usere_act.day7_2_active_ejob_cnt as day7_2_active_ejob_cnt, 
usere_act.day7_3_active_ejob_cnt as day7_3_active_ejob_cnt, 
usere_act.day7_4_active_ejob_cnt as day7_4_active_ejob_cnt, 
usere_act.day7_5_active_ejob_cnt as day7_5_active_ejob_cnt, 
usere_act.day7_6_active_ejob_cnt as day7_6_active_ejob_cnt, 
usere_act.day7_7_active_ejob_cnt as day7_7_active_ejob_cnt, 
usere_act.day7_8_active_ejob_cnt as day7_8_active_ejob_cnt, 
usere_act.day7_9_active_ejob_cnt as day7_9_active_ejob_cnt, 
usere_act.day7_10_active_ejob_cnt as day7_10_active_ejob_cnt, 
usere_act.day7_11_active_ejob_cnt as day7_11_active_ejob_cnt, 
usere_act.day7_12_active_ejob_cnt as day7_12_active_ejob_cnt, 
usere_act.day7_13_active_ejob_cnt as day7_13_active_ejob_cnt, 
usere_act.day7_14_active_ejob_cnt as day7_14_active_ejob_cnt, 
usere_act.day7_2_im_userc_cnt as day7_2_im_userc_cnt, 
usere_act.day7_3_im_userc_cnt as day7_3_im_userc_cnt, 
usere_act.day7_4_im_userc_cnt as day7_4_im_userc_cnt, 
usere_act.day7_5_im_userc_cnt as day7_5_im_userc_cnt, 
usere_act.day7_6_im_userc_cnt as day7_6_im_userc_cnt, 
usere_act.day7_7_im_userc_cnt as day7_7_im_userc_cnt, 
usere_act.day7_8_im_userc_cnt as day7_8_im_userc_cnt, 
usere_act.day7_9_im_userc_cnt as day7_9_im_userc_cnt, 
usere_act.day7_10_im_userc_cnt as day7_10_im_userc_cnt, 
usere_act.day7_11_im_userc_cnt as day7_11_im_userc_cnt, 
usere_act.day7_12_im_userc_cnt as day7_12_im_userc_cnt, 
usere_act.day7_13_im_userc_cnt as day7_13_im_userc_cnt, 
usere_act.day7_14_im_userc_cnt as day7_14_im_userc_cnt, 
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
usere_act.day30_cv_download_cnt as day30_cv_download_cnt, 
usere_act.day30_lowcv_download_cnt as day30_lowcv_download_cnt, 
usere_act.day30_intention_cnt as day30_intention_cnt, 
usere_act.day30_invite_cnt as day30_invite_cnt, 
usere_act.day30_urgent_cnt as day30_urgent_cnt, 
usere_act.day30_consume_cv_cnt as day30_consume_cv_cnt, 
usere_act.day30_consume_lowcv_cnt as day30_consume_lowcv_cnt, 
usere_act.day30_consume_intention_cv_cnt as day30_consume_intention_cv_cnt, 
usere_act.day30_consume_invite_cv_cnt as day30_consume_invite_cv_cnt, 
usere_act.day30_consume_urgent_cv_cnt as day30_consume_urgent_cv_cnt, 
usere_act.day30_consume_msk_cv_cnt as day30_consume_msk_cv_cnt, 
usere_act.day30_msk_service_cnt as day30_msk_service_cnt, 
usere_act.day30_msk_showup_service_cnt as day30_msk_showup_service_cnt, 
usere_act.day30_msk_showup_ratio as day30_msk_showup_ratio, 
usere_act.day30_ejob_avg_recv_cv_cnt as day30_ejob_avg_recv_cv_cnt, 
usere_act.day30_recv_cv_cnt as day30_recv_cv_cnt, 
usere_act.day30_recv_satisfied_cv_cnt as day30_recv_satisfied_cv_cnt, 
usere_act.day30_recv_satisfied_ratio as day30_recv_satisfied_ratio, 
usere_act.day30_intention_valid_ratio as day30_intention_valid_ratio, 
usere_act.day30_intention_submit_cnt as day30_intention_submit_cnt, 
usere_act.day30_intention_submit_valid_cnt as day30_intention_submit_valid_cnt,
usere_act.day90_cv_download_cnt as day90_cv_download_cnt, 
usere_act.day90_lowcv_download_cnt as day90_lowcv_download_cnt, 
usere_act.day90_intention_cnt as day90_intention_cnt, 
usere_act.day90_invite_cnt as day90_invite_cnt, 
usere_act.day90_urgent_cnt as day90_urgent_cnt, 
usere_act.day90_consume_cv_cnt as day90_consume_cv_cnt, 
usere_act.day90_consume_lowcv_cnt as day90_consume_lowcv_cnt, 
usere_act.day90_consume_intention_cv_cnt as day90_consume_intention_cv_cnt, 
usere_act.day90_consume_invite_cv_cnt as day90_consume_invite_cv_cnt, 
usere_act.day90_consume_urgent_cv_cnt as day90_consume_urgent_cv_cnt, 
usere_act.day90_consume_msk_cv_cnt as day90_consume_msk_cv_cnt, 
usere_act.day90_msk_service_cnt as day90_msk_service_cnt, 
usere_act.day90_msk_showup_service_cnt as day90_msk_showup_service_cnt, 
usere_act.day90_msk_showup_ratio as day90_msk_showup_ratio, 
usere_act.day90_ejob_avg_recv_cv_cnt as day90_ejob_avg_recv_cv_cnt, 
usere_act.day90_recv_cv_cnt as day90_recv_cv_cnt, 
usere_act.day90_recv_satisfied_cv_cnt as day90_recv_satisfied_cv_cnt, 
usere_act.day90_recv_satisfied_ratio as day90_recv_satisfied_ratio, 
usere_act.day90_intention_valid_ratio as day90_intention_valid_ratio, 
usere_act.day90_intention_submit_cnt as day90_intention_submit_cnt, 
usere_act.day90_intention_submit_valid_cnt as day90_intention_submit_valid_cnt,
usere_act.day180_cv_download_cnt as day180_cv_download_cnt, 
usere_act.day180_lowcv_download_cnt as day180_lowcv_download_cnt, 
usere_act.day180_intention_cnt as day180_intention_cnt, 
usere_act.day180_invite_cnt as day180_invite_cnt, 
usere_act.day180_urgent_cnt as day180_urgent_cnt, 
usere_act.day180_consume_cv_cnt as day180_consume_cv_cnt, 
usere_act.day180_consume_lowcv_cnt as day180_consume_lowcv_cnt, 
usere_act.day180_consume_intention_cv_cnt as day180_consume_intention_cv_cnt, 
usere_act.day180_consume_invite_cv_cnt as day180_consume_invite_cv_cnt, 
usere_act.day180_consume_urgent_cv_cnt as day180_consume_urgent_cv_cnt, 
usere_act.day180_consume_msk_cv_cnt as day180_consume_msk_cv_cnt, 
usere_act.day180_msk_service_cnt as day180_msk_service_cnt, 
usere_act.day180_msk_showup_service_cnt as day180_msk_showup_service_cnt, 
usere_act.day180_msk_showup_ratio as day180_msk_showup_ratio, 
usere_act.day180_ejob_avg_recv_cv_cnt as day180_ejob_avg_recv_cv_cnt, 
usere_act.day180_recv_cv_cnt as day180_recv_cv_cnt, 
usere_act.day180_recv_satisfied_cv_cnt as day180_recv_satisfied_cv_cnt, 
usere_act.day180_recv_satisfied_ratio as day180_recv_satisfied_ratio, 
usere_act.day180_intention_valid_ratio as day180_intention_valid_ratio, 
usere_act.day180_intention_submit_cnt as day180_intention_submit_cnt, 
usere_act.day180_intention_submit_valid_cnt as day180_intention_submit_valid_cnt,
usere_act.ejob_cnt,
usere_act.day30_ejob_cnt as day30_ejob_cnt,
usere_act.day90_ejob_cnt as day90_ejob_cnt,
usere_act.day180_ejob_cnt as day180_ejob_cnt,
usere_act.recv_deal_cv_cnt as recv_deal_cv_cnt,
usere_act.day30_recv_deal_cv_cnt as day30_recv_deal_cv_cnt,
usere_act.day90_recv_deal_cv_cnt as day90_recv_deal_cv_cnt,
usere_act.day180_recv_deal_cv_cnt as day180_recv_deal_cv_cnt,
usere_act.day365_recv_deal_cv_cnt as day365_recv_deal_cv_cnt,
usere_act.msk_takeorder_service_cnt as msk_takeorder_service_cnt,
usere_act.day30_msk_takeorder_service_cnt as day30_msk_takeorder_service_cnt,
usere_act.day90_msk_takeorder_service_cnt as day90_msk_takeorder_service_cnt,
usere_act.day180_msk_takeorder_service_cnt as day180_msk_takeorder_service_cnt,
usere_act.day365_msk_takeorder_service_cnt as day365_msk_takeorder_service_cnt,
usere_act.ecomp_day7_login_cnt,
usere_act.ecomp_day7_2_login_cnt,
usere_act.ecomp_day7_3_login_cnt,
usere_act.ecomp_day7_4_login_cnt,
usere_act.ecomp_day7_5_login_cnt,
usere_act.ecomp_day7_6_login_cnt,
usere_act.ecomp_day7_7_login_cnt,
usere_act.ecomp_day7_8_login_cnt,
usere_act.ecomp_day7_9_login_cnt,
usere_act.ecomp_day7_10_login_cnt,
usere_act.ecomp_day7_11_login_cnt,
usere_act.ecomp_day7_12_login_cnt,
usere_act.ecomp_day7_13_login_cnt,
usere_act.ecomp_day7_14_login_cnt,
usere_act.customer_day7_login_cnt,
usere_act.customer_day7_2_login_cnt,
usere_act.customer_day7_3_login_cnt,
usere_act.customer_day7_4_login_cnt,
usere_act.customer_day7_5_login_cnt,
usere_act.customer_day7_6_login_cnt,
usere_act.customer_day7_7_login_cnt,
usere_act.customer_day7_8_login_cnt,
usere_act.customer_day7_9_login_cnt,
usere_act.customer_day7_10_login_cnt,
usere_act.customer_day7_11_login_cnt,
usere_act.customer_day7_12_login_cnt,
usere_act.customer_day7_13_login_cnt,
usere_act.customer_day7_14_login_cnt,
usere_act.day365_msk_service_cnt,
usere_act.day365_msk_showup_service_cnt,
usere_act.day365_msk_showup_ratio,
usere_act.day365_recv_cv_cnt,
usere_act.day365_recv_satisfied_cv_cnt,
usere_act.day365_recv_satisfied_ratio,
usere_act.day365_intention_submit_cnt,
usere_act.day365_intention_submit_valid_cnt,
usere_act.day365_intention_valid_ratio,
usere_act.day365_ejob_cnt,
usere_act.day365_ejob_avg_recv_cv_cnt,
current_timestamp as creation_timestamp
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

    sum(consume.day30_cv_download_cnt) as day30_cv_download_cnt, 
    sum(consume.day30_lowcv_download_cnt) as day30_lowcv_download_cnt, 
    sum(consume.day30_intention_cnt) as day30_intention_cnt, 
    sum(consume.day30_invite_cnt) as day30_invite_cnt, 
    sum(consume.day30_urgent_cnt) as day30_urgent_cnt, 
    sum(consume.day30_consume_cv_cnt) as day30_consume_cv_cnt, 
    sum(consume.day30_consume_lowcv_cnt) as day30_consume_lowcv_cnt, 
    sum(consume.day30_consume_intention_cv_cnt) as day30_consume_intention_cv_cnt, 
    sum(consume.day30_consume_invite_cv_cnt) as day30_consume_invite_cv_cnt, 
    sum(consume.day30_consume_urgent_cv_cnt) as day30_consume_urgent_cv_cnt, 
    sum(consume.day30_consume_msk_cv_cnt) as day30_consume_msk_cv_cnt, 

    sum(consume.day90_cv_download_cnt) as day90_cv_download_cnt, 
    sum(consume.day90_lowcv_download_cnt) as day90_lowcv_download_cnt, 
    sum(consume.day90_intention_cnt) as day90_intention_cnt, 
    sum(consume.day90_invite_cnt) as day90_invite_cnt, 
    sum(consume.day90_urgent_cnt) as day90_urgent_cnt, 
    sum(consume.day90_consume_cv_cnt) as day90_consume_cv_cnt, 
    sum(consume.day90_consume_lowcv_cnt) as day90_consume_lowcv_cnt, 
    sum(consume.day90_consume_intention_cv_cnt) as day90_consume_intention_cv_cnt, 
    sum(consume.day90_consume_invite_cv_cnt) as day90_consume_invite_cv_cnt, 
    sum(consume.day90_consume_urgent_cv_cnt) as day90_consume_urgent_cv_cnt, 
    sum(consume.day90_consume_msk_cv_cnt) as day90_consume_msk_cv_cnt, 

    sum(consume.day180_cv_download_cnt) as day180_cv_download_cnt, 
    sum(consume.day180_lowcv_download_cnt) as day180_lowcv_download_cnt, 
    sum(consume.day180_intention_cnt) as day180_intention_cnt, 
    sum(consume.day180_invite_cnt) as day180_invite_cnt, 
    sum(consume.day180_urgent_cnt) as day180_urgent_cnt, 
    sum(consume.day180_consume_cv_cnt) as day180_consume_cv_cnt, 
    sum(consume.day180_consume_lowcv_cnt) as day180_consume_lowcv_cnt, 
    sum(consume.day180_consume_intention_cv_cnt) as day180_consume_intention_cv_cnt, 
    sum(consume.day180_consume_invite_cv_cnt) as day180_consume_invite_cv_cnt, 
    sum(consume.day180_consume_urgent_cv_cnt) as day180_consume_urgent_cv_cnt, 
    sum(consume.day180_consume_msk_cv_cnt) as day180_consume_msk_cv_cnt,        

    sum(ejob.msk_service_cnt) as msk_service_cnt, 
    sum(ejob.msk_showup_service_cnt) as msk_showup_service_cnt, 
    sum(ejob.msk_showup_ratio) as msk_showup_ratio, 
    sum(ejob.ejob_avg_recv_cv_cnt) as ejob_avg_recv_cv_cnt, 
    sum(ejob.recv_cv_cnt) as recv_cv_cnt, 
    sum(ejob.recv_satisfied_cv_cnt) as recv_satisfied_cv_cnt, 
    sum(ejob.recv_satisfied_ratio) as recv_satisfied_ratio, 
    sum(ejob.intention_valid_ratio) as intention_valid_ratio, 
    sum(ejob.intention_submit_cnt) as intention_submit_cnt, 
    sum(ejob.intention_submit_valid_cnt) as intention_submit_valid_cnt,

    sum(ejob.day30_msk_service_cnt) as day30_msk_service_cnt, 
    sum(ejob.day30_msk_showup_service_cnt) as day30_msk_showup_service_cnt, 
    sum(ejob.day30_msk_showup_ratio) as day30_msk_showup_ratio, 
    sum(ejob.day30_ejob_avg_recv_cv_cnt) as day30_ejob_avg_recv_cv_cnt, 
    sum(ejob.day30_recv_cv_cnt) as day30_recv_cv_cnt, 
    sum(ejob.day30_recv_satisfied_cv_cnt) as day30_recv_satisfied_cv_cnt, 
    sum(ejob.day30_recv_satisfied_ratio) as day30_recv_satisfied_ratio, 
    sum(ejob.day30_intention_valid_ratio) as day30_intention_valid_ratio, 
    sum(ejob.day30_intention_submit_cnt) as day30_intention_submit_cnt, 
    sum(ejob.day30_intention_submit_valid_cnt) as day30_intention_submit_valid_cnt,

    sum(ejob.day90_msk_service_cnt) as day90_msk_service_cnt, 
    sum(ejob.day90_msk_showup_service_cnt) as day90_msk_showup_service_cnt, 
    sum(ejob.day90_msk_showup_ratio) as day90_msk_showup_ratio, 
    sum(ejob.day90_ejob_avg_recv_cv_cnt) as day90_ejob_avg_recv_cv_cnt, 
    sum(ejob.day90_recv_cv_cnt) as day90_recv_cv_cnt, 
    sum(ejob.day90_recv_satisfied_cv_cnt) as day90_recv_satisfied_cv_cnt, 
    sum(ejob.day90_recv_satisfied_ratio) as day90_recv_satisfied_ratio, 
    sum(ejob.day90_intention_valid_ratio) as day90_intention_valid_ratio, 
    sum(ejob.day90_intention_submit_cnt) as day90_intention_submit_cnt, 
    sum(ejob.day90_intention_submit_valid_cnt) as day90_intention_submit_valid_cnt,   

    sum(ejob.day180_msk_service_cnt) as day180_msk_service_cnt, 
    sum(ejob.day180_msk_showup_service_cnt) as day180_msk_showup_service_cnt, 
    sum(ejob.day180_msk_showup_ratio) as day180_msk_showup_ratio, 
    sum(ejob.day180_ejob_avg_recv_cv_cnt) as day180_ejob_avg_recv_cv_cnt, 
    sum(ejob.day180_recv_cv_cnt) as day180_recv_cv_cnt, 
    sum(ejob.day180_recv_satisfied_cv_cnt) as day180_recv_satisfied_cv_cnt, 
    sum(ejob.day180_recv_satisfied_ratio) as day180_recv_satisfied_ratio, 
    sum(ejob.day180_intention_valid_ratio) as day180_intention_valid_ratio, 
    sum(ejob.day180_intention_submit_cnt) as day180_intention_submit_cnt, 
    sum(ejob.day180_intention_submit_valid_cnt) as day180_intention_submit_valid_cnt,
    sum(ejob.day30_ejob_cnt) as day30_ejob_cnt,
    sum(ejob.day90_ejob_cnt) as day90_ejob_cnt,
    sum(ejob.day180_ejob_cnt) as day180_ejob_cnt,
    sum(ejob.day365_recv_deal_cv_cnt) as day365_recv_deal_cv_cnt,
    sum(ejob.day30_recv_deal_cv_cnt) as day30_recv_deal_cv_cnt,
    sum(ejob.day90_recv_deal_cv_cnt) as day90_recv_deal_cv_cnt,
    sum(ejob.day180_recv_deal_cv_cnt) as day180_recv_deal_cv_cnt,
    sum(ejob.day365_msk_takeorder_service_cnt) as day365_msk_takeorder_service_cnt,
    sum(ejob.day30_msk_takeorder_service_cnt) as day30_msk_takeorder_service_cnt,
    sum(ejob.day90_msk_takeorder_service_cnt) as day90_msk_takeorder_service_cnt,
    sum(ejob.day180_msk_takeorder_service_cnt) as day180_msk_takeorder_service_cnt,
    sum(ejob.recv_deal_cv_cnt) as recv_deal_cv_cnt,
    sum(ejob.msk_takeorder_service_cnt) as msk_takeorder_service_cnt,

	sum(ejob.day365_msk_service_cnt) as day365_msk_service_cnt,
	sum(ejob.day365_msk_showup_service_cnt) as day365_msk_showup_service_cnt,
	sum(ejob.day365_msk_showup_ratio) as day365_msk_showup_ratio,
	sum(ejob.day365_recv_cv_cnt) as day365_recv_cv_cnt,
	sum(ejob.day365_recv_satisfied_cv_cnt) as day365_recv_satisfied_cv_cnt,
	sum(ejob.day365_recv_satisfied_ratio) as day365_recv_satisfied_ratio,
	sum(ejob.day365_intention_submit_cnt) as day365_intention_submit_cnt,
	sum(ejob.day365_intention_submit_valid_cnt) as day365_intention_submit_valid_cnt,
	sum(ejob.day365_intention_valid_ratio) as day365_intention_valid_ratio,
	sum(ejob.day365_ejob_cnt) as day365_ejob_cnt,
	sum(ejob.day365_ejob_avg_recv_cv_cnt) as day365_ejob_avg_recv_cv_cnt,    

    sum(ecomp_day7_2_login_cnt) as ecomp_day7_2_login_cnt,
    sum(ecomp_day7_3_login_cnt) as ecomp_day7_3_login_cnt,
    sum(ecomp_day7_4_login_cnt) as ecomp_day7_4_login_cnt,
    sum(ecomp_day7_5_login_cnt) as ecomp_day7_5_login_cnt,
    sum(ecomp_day7_6_login_cnt) as ecomp_day7_6_login_cnt,
    sum(ecomp_day7_7_login_cnt) as ecomp_day7_7_login_cnt,
    sum(ecomp_day7_8_login_cnt) as ecomp_day7_8_login_cnt,
    sum(ecomp_day7_9_login_cnt) as ecomp_day7_9_login_cnt,
    sum(ecomp_day7_10_login_cnt) as ecomp_day7_10_login_cnt,
    sum(ecomp_day7_11_login_cnt) as ecomp_day7_11_login_cnt,
    sum(ecomp_day7_12_login_cnt) as ecomp_day7_12_login_cnt,
    sum(ecomp_day7_13_login_cnt) as ecomp_day7_13_login_cnt,
    sum(ecomp_day7_14_login_cnt) as ecomp_day7_14_login_cnt,
    sum(customer_day7_2_login_cnt) as customer_day7_2_login_cnt,
    sum(customer_day7_3_login_cnt) as customer_day7_3_login_cnt,
    sum(customer_day7_4_login_cnt) as customer_day7_4_login_cnt,
    sum(customer_day7_5_login_cnt) as customer_day7_5_login_cnt,
    sum(customer_day7_6_login_cnt) as customer_day7_6_login_cnt,
    sum(customer_day7_7_login_cnt) as customer_day7_7_login_cnt,
    sum(customer_day7_8_login_cnt) as customer_day7_8_login_cnt,
    sum(customer_day7_9_login_cnt) as customer_day7_9_login_cnt,
    sum(customer_day7_10_login_cnt) as customer_day7_10_login_cnt,
    sum(customer_day7_11_login_cnt) as customer_day7_11_login_cnt,
    sum(customer_day7_12_login_cnt) as customer_day7_12_login_cnt,
    sum(customer_day7_13_login_cnt) as customer_day7_13_login_cnt,
    sum(customer_day7_14_login_cnt) as customer_day7_14_login_cnt,
    sum(day7_2_login_cnt) as day7_2_login_cnt,
    sum(day7_3_login_cnt) as day7_3_login_cnt,
    sum(day7_4_login_cnt) as day7_4_login_cnt,
    sum(day7_5_login_cnt) as day7_5_login_cnt,
    sum(day7_6_login_cnt) as day7_6_login_cnt,
    sum(day7_7_login_cnt) as day7_7_login_cnt,
    sum(day7_8_login_cnt) as day7_8_login_cnt,
    sum(day7_9_login_cnt) as day7_9_login_cnt,
    sum(day7_10_login_cnt) as day7_10_login_cnt,
    sum(day7_11_login_cnt) as day7_11_login_cnt,
    sum(day7_12_login_cnt) as day7_12_login_cnt,
    sum(day7_13_login_cnt) as day7_13_login_cnt,
    sum(day7_14_login_cnt) as day7_14_login_cnt,
    sum(day7_2_consume_cv_total_cnt) as day7_2_consume_cv_total_cnt,
    sum(day7_3_consume_cv_total_cnt) as day7_3_consume_cv_total_cnt,
    sum(day7_4_consume_cv_total_cnt) as day7_4_consume_cv_total_cnt,
    sum(day7_5_consume_cv_total_cnt) as day7_5_consume_cv_total_cnt,
    sum(day7_6_consume_cv_total_cnt) as day7_6_consume_cv_total_cnt,
    sum(day7_7_consume_cv_total_cnt) as day7_7_consume_cv_total_cnt,
    sum(day7_8_consume_cv_total_cnt) as day7_8_consume_cv_total_cnt,
    sum(day7_9_consume_cv_total_cnt) as day7_9_consume_cv_total_cnt,
    sum(day7_10_consume_cv_total_cnt) as day7_10_consume_cv_total_cnt,
    sum(day7_11_consume_cv_total_cnt) as day7_11_consume_cv_total_cnt,
    sum(day7_12_consume_cv_total_cnt) as day7_12_consume_cv_total_cnt,
    sum(day7_13_consume_cv_total_cnt) as day7_13_consume_cv_total_cnt,
    sum(day7_14_consume_cv_total_cnt) as day7_14_consume_cv_total_cnt,
    sum(day7_2_active_ejob_cnt) as day7_2_active_ejob_cnt,
    sum(day7_3_active_ejob_cnt) as day7_3_active_ejob_cnt,
    sum(day7_4_active_ejob_cnt) as day7_4_active_ejob_cnt,
    sum(day7_5_active_ejob_cnt) as day7_5_active_ejob_cnt,
    sum(day7_6_active_ejob_cnt) as day7_6_active_ejob_cnt,
    sum(day7_7_active_ejob_cnt) as day7_7_active_ejob_cnt,
    sum(day7_8_active_ejob_cnt) as day7_8_active_ejob_cnt,
    sum(day7_9_active_ejob_cnt) as day7_9_active_ejob_cnt,
    sum(day7_10_active_ejob_cnt) as day7_10_active_ejob_cnt,
    sum(day7_11_active_ejob_cnt) as day7_11_active_ejob_cnt,
    sum(day7_12_active_ejob_cnt) as day7_12_active_ejob_cnt,
    sum(day7_13_active_ejob_cnt) as day7_13_active_ejob_cnt,
    sum(day7_14_active_ejob_cnt) as day7_14_active_ejob_cnt,
    sum(day7_2_im_userc_cnt) as day7_2_im_userc_cnt,
    sum(day7_3_im_userc_cnt) as day7_3_im_userc_cnt,
    sum(day7_4_im_userc_cnt) as day7_4_im_userc_cnt,
    sum(day7_5_im_userc_cnt) as day7_5_im_userc_cnt,
    sum(day7_6_im_userc_cnt) as day7_6_im_userc_cnt,
    sum(day7_7_im_userc_cnt) as day7_7_im_userc_cnt,
    sum(day7_8_im_userc_cnt) as day7_8_im_userc_cnt,
    sum(day7_9_im_userc_cnt) as day7_9_im_userc_cnt,
    sum(day7_10_im_userc_cnt) as day7_10_im_userc_cnt,
    sum(day7_11_im_userc_cnt) as day7_11_im_userc_cnt,
    sum(day7_12_im_userc_cnt) as day7_12_im_userc_cnt,
    sum(day7_13_im_userc_cnt) as day7_13_im_userc_cnt,
    sum(day7_14_im_userc_cnt) as day7_14_im_userc_cnt
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
      sum(msk_showup_service_cnt) / sum(msk_takeorder_service_cnt) as msk_showup_ratio,
      sum(recv_cv_cnt) / sum(1) as ejob_avg_recv_cv_cnt,
      sum(recv_cv_cnt) as recv_cv_cnt,
      sum(recv_satisfied_cv_cnt) as recv_satisfied_cv_cnt,
      sum(recv_satisfied_cv_cnt) / sum(recv_deal_cv_cnt) as recv_satisfied_ratio,
      sum(intention_submit_valid_cnt) / sum(intention_submit_cnt) as intention_valid_ratio,
      sum(intention_submit_cnt) as intention_submit_cnt,
      sum(intention_submit_valid_cnt) as intention_submit_valid_cnt,

      sum(day30_msk_service_cnt) as day30_msk_service_cnt,
      sum(day30_msk_showup_service_cnt) as day30_msk_showup_service_cnt,
      sum(day30_msk_showup_service_cnt) / sum(day30_msk_takeorder_service_cnt) as day30_msk_showup_ratio,
      sum(day30_recv_cv_cnt) / sum(1) as day30_ejob_avg_recv_cv_cnt,
      sum(day30_recv_cv_cnt) as day30_recv_cv_cnt,
      sum(day30_recv_satisfied_cv_cnt) as day30_recv_satisfied_cv_cnt,
      sum(day30_recv_satisfied_cv_cnt) / sum(day30_recv_deal_cv_cnt) as day30_recv_satisfied_ratio,
      sum(day30_intention_submit_valid_cnt) / sum(day30_intention_submit_cnt) as day30_intention_valid_ratio,
      sum(day30_intention_submit_cnt) as day30_intention_submit_cnt,
      sum(day30_intention_submit_valid_cnt) as day30_intention_submit_valid_cnt,  

      sum(day90_msk_service_cnt) as day90_msk_service_cnt,
      sum(day90_msk_showup_service_cnt) as day90_msk_showup_service_cnt,
      sum(day90_msk_showup_service_cnt) / sum(day90_msk_takeorder_service_cnt) as day90_msk_showup_ratio,
      sum(day90_recv_cv_cnt) / sum(1) as day90_ejob_avg_recv_cv_cnt,
      sum(day90_recv_cv_cnt) as day90_recv_cv_cnt,
      sum(day90_recv_satisfied_cv_cnt) as day90_recv_satisfied_cv_cnt,
      sum(day90_recv_satisfied_cv_cnt) / sum(day90_recv_deal_cv_cnt) as day90_recv_satisfied_ratio,
      sum(day90_intention_submit_valid_cnt) / sum(day90_intention_submit_cnt) as day90_intention_valid_ratio,
      sum(day90_intention_submit_cnt) as day90_intention_submit_cnt,
      sum(day90_intention_submit_valid_cnt) as day90_intention_submit_valid_cnt,  

      sum(day180_msk_service_cnt) as day180_msk_service_cnt,
      sum(day180_msk_showup_service_cnt) as day180_msk_showup_service_cnt,
      sum(day180_msk_showup_service_cnt) / sum(day180_msk_takeorder_service_cnt) as day180_msk_showup_ratio,
      sum(day180_recv_cv_cnt) / sum(1) as day180_ejob_avg_recv_cv_cnt,
      sum(day180_recv_cv_cnt) as day180_recv_cv_cnt,
      sum(day180_recv_satisfied_cv_cnt) as day180_recv_satisfied_cv_cnt,
      sum(day180_recv_satisfied_cv_cnt) / sum(day180_recv_deal_cv_cnt) as day180_recv_satisfied_ratio,
      sum(day180_intention_submit_valid_cnt) / sum(day180_intention_submit_cnt) as day180_intention_valid_ratio,
      sum(day180_intention_submit_cnt) as day180_intention_submit_cnt,
      sum(day180_intention_submit_valid_cnt) as day180_intention_submit_valid_cnt,      

      sum(case when datediff(reformat_datetime('$date$','yyyy-MM-dd'),ejob_createtime) < 30  then 1 else 0 end) as day30_ejob_cnt,
      sum(case when datediff(reformat_datetime('$date$','yyyy-MM-dd'),ejob_createtime) < 90  then 1 else 0 end) as day90_ejob_cnt,
      sum(case when datediff(reformat_datetime('$date$','yyyy-MM-dd'),ejob_createtime) < 180 then 1 else 0 end) as day180_ejob_cnt,  

      sum(day365_recv_deal_cv_cnt) as day365_recv_deal_cv_cnt,
      sum(day30_recv_deal_cv_cnt) as day30_recv_deal_cv_cnt,
      sum(day90_recv_deal_cv_cnt) as day90_recv_deal_cv_cnt,
      sum(day180_recv_deal_cv_cnt) as day180_recv_deal_cv_cnt,
      sum(day365_msk_takeorder_service_cnt) as day365_msk_takeorder_service_cnt,
      sum(day30_msk_takeorder_service_cnt) as day30_msk_takeorder_service_cnt,
      sum(day90_msk_takeorder_service_cnt) as day90_msk_takeorder_service_cnt,
      sum(day180_msk_takeorder_service_cnt) as day180_msk_takeorder_service_cnt,
      sum(recv_deal_cv_cnt) as recv_deal_cv_cnt,
      sum(msk_takeorder_service_cnt) as msk_takeorder_service_cnt,

      sum(day365_msk_service_cnt) as day365_msk_service_cnt,
	  sum(day365_msk_showup_service_cnt) as day365_msk_showup_service_cnt,
	  sum(day365_msk_showup_service_cnt) / sum(day365_msk_takeorder_service_cnt) as day365_msk_showup_ratio,
	  sum(day365_recv_cv_cnt) as day365_recv_cv_cnt,
	  sum(day365_recv_satisfied_cv_cnt) as day365_recv_satisfied_cv_cnt,
	  sum(day365_recv_satisfied_cv_cnt) / sum(day365_recv_deal_cv_cnt) as day365_recv_satisfied_ratio,
	  sum(day365_intention_submit_cnt) as day365_intention_submit_cnt,
	  sum(day365_intention_submit_valid_cnt) as day365_intention_submit_valid_cnt,
	  sum(day365_intention_submit_valid_cnt) / sum(day365_intention_submit_cnt) as day365_intention_valid_ratio,
	  sum(case when publish_days < 365 then 1 else 0 end ) as day365_ejob_cnt,
	  sum(day365_recv_cv_cnt) / sum(case when publish_days < 365 then 1 else 0 end ) as day365_ejob_avg_recv_cv_cnt
    from dw_erp_d_customer_report_ejob
    where p_date = $date$
    group by 
      usere_id,
      usere_name,
      ecomp_id,
      ecomp_root_id,
      customer_id
  ) ejob 
  full join 
  (select usere_id,
          count(distinct case when day7_is_active = 1 and p_date between {{delta(date,-13)}} and {{delta(date,-7)}} then ejob_id else null end) as day7_2_active_ejob_cnt,
          count(distinct case when day7_is_active = 1 and p_date between {{delta(date,-20)}} and {{delta(date,-14)}} then ejob_id else null end) as day7_3_active_ejob_cnt,
          count(distinct case when day7_is_active = 1 and p_date between {{delta(date,-27)}} and {{delta(date,-21)}} then ejob_id else null end) as day7_4_active_ejob_cnt,
          count(distinct case when day7_is_active = 1 and p_date between {{delta(date,-34)}} and {{delta(date,-28)}} then ejob_id else null end) as day7_5_active_ejob_cnt,
          count(distinct case when day7_is_active = 1 and p_date between {{delta(date,-41)}} and {{delta(date,-35)}} then ejob_id else null end) as day7_6_active_ejob_cnt,
          count(distinct case when day7_is_active = 1 and p_date between {{delta(date,-48)}} and {{delta(date,-42)}} then ejob_id else null end) as day7_7_active_ejob_cnt,
          count(distinct case when day7_is_active = 1 and p_date between {{delta(date,-55)}} and {{delta(date,-49)}} then ejob_id else null end) as day7_8_active_ejob_cnt,
          count(distinct case when day7_is_active = 1 and p_date between {{delta(date,-62)}} and {{delta(date,-56)}} then ejob_id else null end) as day7_9_active_ejob_cnt,
          count(distinct case when day7_is_active = 1 and p_date between {{delta(date,-69)}} and {{delta(date,-63)}} then ejob_id else null end) as day7_10_active_ejob_cnt,
          count(distinct case when day7_is_active = 1 and p_date between {{delta(date,-76)}} and {{delta(date,-70)}} then ejob_id else null end) as day7_11_active_ejob_cnt,
          count(distinct case when day7_is_active = 1 and p_date between {{delta(date,-83)}} and {{delta(date,-77)}} then ejob_id else null end) as day7_12_active_ejob_cnt,
          count(distinct case when day7_is_active = 1 and p_date between {{delta(date,-90)}} and {{delta(date,-84)}} then ejob_id else null end) as day7_13_active_ejob_cnt,
          count(distinct case when day7_is_active = 1 and p_date between {{delta(date,-97)}} and {{delta(date,-91)}} then ejob_id else null end) as day7_14_active_ejob_cnt
     from dw_erp_d_customer_report_ejob
    where p_date between {{delta(date,-97)}} and $date$ 
    group by usere_id
  ) ejob_his
  on ejob.usere_id = ejob_his.usere_id
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
      sum(consume_lowcv/5) as consume_lowcv_cnt,
      sum(consume_intention_total) as consume_intention_cv_cnt,
      sum(consume_invite_total) as consume_invite_cv_cnt,
      sum(consume_urgent_cv) as consume_urgent_cv_cnt,
      sum(consume_msk_total) as consume_msk_cv_cnt,

      sum(case when p_date between {{delta(date,-29)}} and $date$ then cv_download_cnt else 0 end) as day30_cv_download_cnt,
      sum(case when p_date between {{delta(date,-29)}} and $date$ then lowcv_download_cnt else 0 end) as day30_lowcv_download_cnt,
      sum(case when p_date between {{delta(date,-29)}} and $date$ then intention_cnt else 0 end) as day30_intention_cnt,
      sum(case when p_date between {{delta(date,-29)}} and $date$ then invite_cnt else 0 end) as day30_invite_cnt,
      sum(case when p_date between {{delta(date,-29)}} and $date$ then urgent_cnt else 0 end) as day30_urgent_cnt,
      sum(case when p_date between {{delta(date,-29)}} and $date$ then consume_cv+consume_cvcoupon else 0 end) as day30_consume_cv_cnt,
      sum(case when p_date between {{delta(date,-29)}} and $date$ then consume_lowcv / 5 else 0 end) as day30_consume_lowcv_cnt,
      sum(case when p_date between {{delta(date,-29)}} and $date$ then consume_intention_total else 0 end) as day30_consume_intention_cv_cnt,
      sum(case when p_date between {{delta(date,-29)}} and $date$ then consume_invite_total else 0 end) as day30_consume_invite_cv_cnt,
      sum(case when p_date between {{delta(date,-29)}} and $date$ then consume_urgent_cv else 0 end) as day30_consume_urgent_cv_cnt,
      sum(case when p_date between {{delta(date,-29)}} and $date$ then consume_msk_total else 0 end) as day30_consume_msk_cv_cnt,

      sum(case when p_date between {{delta(date,-89)}} and $date$ then cv_download_cnt else 0 end) as day90_cv_download_cnt,
      sum(case when p_date between {{delta(date,-89)}} and $date$ then lowcv_download_cnt else 0 end) as day90_lowcv_download_cnt,
      sum(case when p_date between {{delta(date,-89)}} and $date$ then intention_cnt else 0 end) as day90_intention_cnt,
      sum(case when p_date between {{delta(date,-89)}} and $date$ then invite_cnt else 0 end) as day90_invite_cnt,
      sum(case when p_date between {{delta(date,-89)}} and $date$ then urgent_cnt else 0 end) as day90_urgent_cnt,
      sum(case when p_date between {{delta(date,-89)}} and $date$ then consume_cv+consume_cvcoupon else 0 end) as day90_consume_cv_cnt,
      sum(case when p_date between {{delta(date,-89)}} and $date$ then consume_lowcv / 5 else 0 end) as day90_consume_lowcv_cnt,
      sum(case when p_date between {{delta(date,-89)}} and $date$ then consume_intention_total else 0 end) as day90_consume_intention_cv_cnt,
      sum(case when p_date between {{delta(date,-89)}} and $date$ then consume_invite_total else 0 end) as day90_consume_invite_cv_cnt,
      sum(case when p_date between {{delta(date,-89)}} and $date$ then consume_urgent_cv else 0 end) as day90_consume_urgent_cv_cnt,
      sum(case when p_date between {{delta(date,-89)}} and $date$ then consume_msk_total else 0 end) as day90_consume_msk_cv_cnt,

      sum(case when p_date between {{delta(date,-179)}} and $date$ then cv_download_cnt else 0 end) as day180_cv_download_cnt,
      sum(case when p_date between {{delta(date,-179)}} and $date$ then lowcv_download_cnt else 0 end) as day180_lowcv_download_cnt,
      sum(case when p_date between {{delta(date,-179)}} and $date$ then intention_cnt else 0 end) as day180_intention_cnt,
      sum(case when p_date between {{delta(date,-179)}} and $date$ then invite_cnt else 0 end) as day180_invite_cnt,
      sum(case when p_date between {{delta(date,-179)}} and $date$ then urgent_cnt else 0 end) as day180_urgent_cnt,
      sum(case when p_date between {{delta(date,-179)}} and $date$ then consume_cv+consume_cvcoupon else 0 end) as day180_consume_cv_cnt,
      sum(case when p_date between {{delta(date,-179)}} and $date$ then consume_lowcv / 5 else 0 end) as day180_consume_lowcv_cnt,
      sum(case when p_date between {{delta(date,-179)}} and $date$ then consume_intention_total else 0 end) as day180_consume_intention_cv_cnt,
      sum(case when p_date between {{delta(date,-179)}} and $date$ then consume_invite_total else 0 end) as day180_consume_invite_cv_cnt,
      sum(case when p_date between {{delta(date,-179)}} and $date$ then consume_urgent_cv else 0 end) as day180_consume_urgent_cv_cnt,
      sum(case when p_date between {{delta(date,-179)}} and $date$ then consume_msk_total else 0 end) as day180_consume_msk_cv_cnt,

      sum(case when p_date between {{delta(date,-6)}} and $date$ then consume_cv_total else 0 end) as day7_consume_cv_total_cnt,
      sum(case when p_date between {{delta(date,-13)}} and {{delta(date,-7)}} then consume_cv_total else 0 end) as day7_2_consume_cv_total_cnt,
      sum(case when p_date between {{delta(date,-20)}} and {{delta(date,-14)}} then consume_cv_total else 0 end) as day7_3_consume_cv_total_cnt,
      sum(case when p_date between {{delta(date,-27)}} and {{delta(date,-21)}} then consume_cv_total else 0 end) as day7_4_consume_cv_total_cnt,
      sum(case when p_date between {{delta(date,-34)}} and {{delta(date,-28)}} then consume_cv_total else 0 end) as day7_5_consume_cv_total_cnt,
      sum(case when p_date between {{delta(date,-41)}} and {{delta(date,-35)}} then consume_cv_total else 0 end) as day7_6_consume_cv_total_cnt,
      sum(case when p_date between {{delta(date,-48)}} and {{delta(date,-42)}} then consume_cv_total else 0 end) as day7_7_consume_cv_total_cnt,
      sum(case when p_date between {{delta(date,-55)}} and {{delta(date,-49)}} then consume_cv_total else 0 end) as day7_8_consume_cv_total_cnt,
      sum(case when p_date between {{delta(date,-62)}} and {{delta(date,-56)}} then consume_cv_total else 0 end) as day7_9_consume_cv_total_cnt,
      sum(case when p_date between {{delta(date,-69)}} and {{delta(date,-63)}} then consume_cv_total else 0 end) as day7_10_consume_cv_total_cnt,
      sum(case when p_date between {{delta(date,-76)}} and {{delta(date,-70)}} then consume_cv_total else 0 end) as day7_11_consume_cv_total_cnt,
      sum(case when p_date between {{delta(date,-83)}} and {{delta(date,-77)}} then consume_cv_total else 0 end) as day7_12_consume_cv_total_cnt,
      sum(case when p_date between {{delta(date,-90)}} and {{delta(date,-84)}} then consume_cv_total else 0 end) as day7_13_consume_cv_total_cnt,
      sum(case when p_date between {{delta(date,-97)}} and {{delta(date,-91)}} then consume_cv_total else 0 end) as day7_14_consume_cv_total_cnt

    from dw_b_d_resource_consume
    where p_date between {{delta(date,-364)}} and $date$
    group by usere_id ) consume
    on ejob.usere_id = consume.usere_id
  full join 
  (
    select usere_id,
       sum(case when p_date between {{delta(date,-6)}} and $date$ then is_login else 0 end) as day7_login_cnt,
       count(distinct case when p_date between {{delta(date,-6)}} and $date$ then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_login_cnt,
       count(distinct case when p_date between {{delta(date,-6)}} and $date$ then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_login_cnt,

       sum(case when p_date between {{delta(date,-13)}} and {{delta(date,-7)}} then is_login else 0 end) as day7_2_login_cnt,
       count(distinct case when p_date between {{delta(date,-13)}} and {{delta(date,-7)}}  then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_2_login_cnt,
       count(distinct case when p_date between {{delta(date,-13)}} and {{delta(date,-7)}}  then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_2_login_cnt,

       sum(case when p_date between {{delta(date,-20)}} and {{delta(date,-14)}} then is_login else 0 end) as day7_3_login_cnt,
       count(distinct case when p_date between {{delta(date,-20)}} and {{delta(date,-14)}} then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_3_login_cnt,
       count(distinct case when p_date between {{delta(date,-20)}} and {{delta(date,-14)}} then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_3_login_cnt,

       sum(case when p_date between {{delta(date,-27)}} and {{delta(date,-21)}} then is_login else 0 end) as day7_4_login_cnt,
       count(distinct case when p_date between {{delta(date,-27)}} and {{delta(date,-21)}} then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_4_login_cnt,
       count(distinct case when p_date between {{delta(date,-27)}} and {{delta(date,-21)}} then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_4_login_cnt,

       sum(case when p_date between {{delta(date,-34)}} and {{delta(date,-28)}} then is_login else 0 end) as day7_5_login_cnt,
       count(distinct case when p_date between {{delta(date,-34)}} and {{delta(date,-28)}} then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_5_login_cnt,
       count(distinct case when p_date between {{delta(date,-34)}} and {{delta(date,-28)}} then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_5_login_cnt,

       sum(case when p_date between {{delta(date,-41)}} and {{delta(date,-35)}} then is_login else 0 end) as day7_6_login_cnt,
       count(distinct case when p_date between {{delta(date,-41)}} and {{delta(date,-35)}} then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_6_login_cnt,
       count(distinct case when p_date between {{delta(date,-41)}} and {{delta(date,-35)}} then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_6_login_cnt,

       sum(case when p_date between {{delta(date,-48)}} and {{delta(date,-42)}} then is_login else 0 end) as day7_7_login_cnt,
       count(distinct case when p_date between {{delta(date,-48)}} and {{delta(date,-42)}} then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_7_login_cnt,
       count(distinct case when p_date between {{delta(date,-48)}} and {{delta(date,-42)}} then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_7_login_cnt,

       sum(case when p_date between {{delta(date,-55)}} and {{delta(date,-49)}} then is_login else 0 end) as day7_8_login_cnt,
       count(distinct case when p_date between {{delta(date,-55)}} and {{delta(date,-49)}} then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_8_login_cnt,
       count(distinct case when p_date between {{delta(date,-55)}} and {{delta(date,-49)}} then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_8_login_cnt,

       sum(case when p_date between {{delta(date,-62)}} and {{delta(date,-56)}} then is_login else 0 end) as day7_9_login_cnt,
       count(distinct case when p_date between {{delta(date,-62)}} and {{delta(date,-56)}} then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_9_login_cnt,
       count(distinct case when p_date between {{delta(date,-62)}} and {{delta(date,-56)}} then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_9_login_cnt,

       sum(case when p_date between {{delta(date,-69)}} and {{delta(date,-63)}} then is_login else 0 end) as day7_10_login_cnt,
       count(distinct case when p_date between {{delta(date,-69)}} and {{delta(date,-63)}} then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_10_login_cnt,
       count(distinct case when p_date between {{delta(date,-69)}} and {{delta(date,-63)}} then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_10_login_cnt,

       sum(case when p_date between {{delta(date,-76)}} and {{delta(date,-70)}} then is_login else 0 end) as day7_11_login_cnt,
       count(distinct case when p_date between {{delta(date,-76)}} and {{delta(date,-70)}} then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_11_login_cnt,
       count(distinct case when p_date between {{delta(date,-76)}} and {{delta(date,-70)}} then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_11_login_cnt,

       sum(case when p_date between {{delta(date,-83)}} and {{delta(date,-77)}} then is_login else 0 end) as day7_12_login_cnt,
       count(distinct case when p_date between {{delta(date,-83)}} and {{delta(date,-77)}} then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_12_login_cnt,
       count(distinct case when p_date between {{delta(date,-83)}} and {{delta(date,-77)}} then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_12_login_cnt,                                                                      

       sum(case when p_date between {{delta(date,-90)}} and {{delta(date,-84)}} then is_login else 0 end) as day7_13_login_cnt,
       count(distinct case when p_date between {{delta(date,-90)}} and {{delta(date,-84)}} then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_13_login_cnt,
       count(distinct case when p_date between {{delta(date,-90)}} and {{delta(date,-84)}} then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_13_login_cnt,    

       sum(case when p_date between {{delta(date,-97)}} and {{delta(date,-91)}} then is_login else 0 end) as day7_14_login_cnt,
       count(distinct case when p_date between {{delta(date,-97)}} and {{delta(date,-91)}} then p_date else null end)over(distribute by ecomp_root_id) as customer_day7_14_login_cnt,
       count(distinct case when p_date between {{delta(date,-97)}} and {{delta(date,-91)}} then p_date else null end)over(distribute by ecomp_id) as ecomp_day7_14_login_cnt
    from dw_b_d_usere_act
    where p_date between {{delta(date,-97)}} and $date$
      and is_login = 1
    group by usere_id
  ) login 
  on ejob.usere_id = login.usere_id
  full join 
  (select user_id as usere_id,
          count(distinct case when p_date between {{delta(date,-6)}} and $date$ then opposite_user_id else null end) as day7_im_userc_cnt,
          count(distinct case when p_date between {{delta(date,-13)}} and {{delta(date,-7)}} then opposite_user_id else null end) as day7_2_im_userc_cnt,
          count(distinct case when p_date between {{delta(date,-20)}} and {{delta(date,-14)}} then opposite_user_id else null end) as day7_3_im_userc_cnt,
          count(distinct case when p_date between {{delta(date,-27)}} and {{delta(date,-21)}} then opposite_user_id else null end) as day7_4_im_userc_cnt,
          count(distinct case when p_date between {{delta(date,-34)}} and {{delta(date,-28)}} then opposite_user_id else null end) as day7_5_im_userc_cnt,
          count(distinct case when p_date between {{delta(date,-41)}} and {{delta(date,-35)}} then opposite_user_id else null end) as day7_6_im_userc_cnt,
          count(distinct case when p_date between {{delta(date,-48)}} and {{delta(date,-42)}} then opposite_user_id else null end) as day7_7_im_userc_cnt,
          count(distinct case when p_date between {{delta(date,-55)}} and {{delta(date,-49)}} then opposite_user_id else null end) as day7_8_im_userc_cnt,
          count(distinct case when p_date between {{delta(date,-62)}} and {{delta(date,-56)}} then opposite_user_id else null end) as day7_9_im_userc_cnt,
          count(distinct case when p_date between {{delta(date,-69)}} and {{delta(date,-63)}} then opposite_user_id else null end) as day7_10_im_userc_cnt,
          count(distinct case when p_date between {{delta(date,-76)}} and {{delta(date,-70)}} then opposite_user_id else null end) as day7_11_im_userc_cnt,
          count(distinct case when p_date between {{delta(date,-83)}} and {{delta(date,-77)}} then opposite_user_id else null end) as day7_12_im_userc_cnt,
          count(distinct case when p_date between {{delta(date,-90)}} and {{delta(date,-84)}} then opposite_user_id else null end) as day7_13_im_userc_cnt,
          count(distinct case when p_date between {{delta(date,-97)}} and {{delta(date,-91)}} then opposite_user_id else null end) as day7_14_im_userc_cnt
      from dw_c_d_user_message
      where user_kind = 1
        and opposite_user_kind = 0
        and d_date between {{delta(date,-97)}} and $date$
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

CREATE TABLE dw_erp_a_customer_report_usere(
  d_date int COMMENT '统计日期', 
  usere_id int COMMENT 'hr主键id', 
  usere_name string COMMENT 'hr名称', 
  usere_account string COMMENT 'hr猎聘通账号', 
  usere_account_status int COMMENT '猎聘通账号状态', 
  customer_id int COMMENT '客户id', 
  customer_name string COMMENT '客户名称', 
  ecomp_root_id int COMMENT 'ecomp_root_id', 
  ecomp_id int COMMENT 'ecomp_id', 
  ecomp_name string COMMENT 'ecomp_name', 
  active_ejob_cnt int COMMENT '活跃职位数', 
  publish_day7_no_apply_ejob_cnt int COMMENT '发布七天以上无投递职位数', 
  msk_potential_ejob_cnt int COMMENT '面试快潜力职位数', 
  day7_login_cnt int COMMENT '近7天登录天数', 
  day7_consume_cv_total_cnt int COMMENT '近7天精英资源综合消耗', 
  day7_active_ejob_cnt int COMMENT '近7天活跃职位数', 
  day7_im_userc_cnt int COMMENT '近7天职聊人数', 
  day7_2_login_cnt int comment '近第2个7天登陆猎聘天数',
  day7_3_login_cnt int comment '近第3个7天登陆猎聘天数',
  day7_4_login_cnt int comment '近第4个7天登陆猎聘天数',
  day7_5_login_cnt int comment '近第5个7天登陆猎聘天数',
  day7_6_login_cnt int comment '近第6个7天登陆猎聘天数',
  day7_7_login_cnt int comment '近第7个7天登陆猎聘天数',
  day7_8_login_cnt int comment '近第8个7天登陆猎聘天数',
  day7_9_login_cnt int comment '近第9个7天登陆猎聘天数',
  day7_10_login_cnt int comment '近第10个7天登陆猎聘天数',
  day7_11_login_cnt int comment '近第11个7天登陆猎聘天数',
  day7_12_login_cnt int comment '近第12个7天登陆猎聘天数',
  day7_13_login_cnt int comment '近第13个7天登陆猎聘天数',
  day7_14_login_cnt int comment '近第14个7天登陆猎聘天数',
  day7_2_consume_cv_total_cnt int comment '近第2个7天精英资源综合消耗',
  day7_3_consume_cv_total_cnt int comment '近第3个7天精英资源综合消耗',
  day7_4_consume_cv_total_cnt int comment '近第4个7天精英资源综合消耗',
  day7_5_consume_cv_total_cnt int comment '近第5个7天精英资源综合消耗',
  day7_6_consume_cv_total_cnt int comment '近第6个7天精英资源综合消耗',
  day7_7_consume_cv_total_cnt int comment '近第7个7天精英资源综合消耗',
  day7_8_consume_cv_total_cnt int comment '近第8个7天精英资源综合消耗',
  day7_9_consume_cv_total_cnt int comment '近第9个7天精英资源综合消耗',
  day7_10_consume_cv_total_cnt int comment '近第10个7天精英资源综合消耗',
  day7_11_consume_cv_total_cnt int comment '近第11个7天精英资源综合消耗',
  day7_12_consume_cv_total_cnt int comment '近第12个7天精英资源综合消耗',
  day7_13_consume_cv_total_cnt int comment '近第13个7天精英资源综合消耗',
  day7_14_consume_cv_total_cnt int comment '近第14个7天精英资源综合消耗',
  day7_2_active_ejob_cnt int comment '近第2个7天活跃职位数',
  day7_3_active_ejob_cnt int comment '近第3个7天活跃职位数',
  day7_4_active_ejob_cnt int comment '近第4个7天活跃职位数',
  day7_5_active_ejob_cnt int comment '近第5个7天活跃职位数',
  day7_6_active_ejob_cnt int comment '近第6个7天活跃职位数',
  day7_7_active_ejob_cnt int comment '近第7个7天活跃职位数',
  day7_8_active_ejob_cnt int comment '近第8个7天活跃职位数',
  day7_9_active_ejob_cnt int comment '近第9个7天活跃职位数',
  day7_10_active_ejob_cnt int comment '近第10个7天活跃职位数',
  day7_11_active_ejob_cnt int comment '近第11个7天活跃职位数',
  day7_12_active_ejob_cnt int comment '近第12个7天活跃职位数',
  day7_13_active_ejob_cnt int comment '近第13个7天活跃职位数',
  day7_14_active_ejob_cnt int comment '近第14个7天活跃职位数',
  day7_2_im_userc_cnt int comment '近第2个7天职聊人数',
  day7_3_im_userc_cnt int comment '近第3个7天职聊人数',
  day7_4_im_userc_cnt int comment '近第4个7天职聊人数',
  day7_5_im_userc_cnt int comment '近第5个7天职聊人数',
  day7_6_im_userc_cnt int comment '近第6个7天职聊人数',
  day7_7_im_userc_cnt int comment '近第7个7天职聊人数',
  day7_8_im_userc_cnt int comment '近第8个7天职聊人数',
  day7_9_im_userc_cnt int comment '近第9个7天职聊人数',
  day7_10_im_userc_cnt int comment '近第10个7天职聊人数',
  day7_11_im_userc_cnt int comment '近第11个7天职聊人数',
  day7_12_im_userc_cnt int comment '近第12个7天职聊人数',
  day7_13_im_userc_cnt int comment '近第13个7天职聊人数',
  day7_14_im_userc_cnt int comment '近第14个7天职聊人数',
  cv_download_cnt int COMMENT '近一年下载精英简历', 
  lowcv_download_cnt int COMMENT '近一年下载白领简历', 
  intention_cnt int COMMENT '近一年意向沟通', 
  invite_cnt int COMMENT '近一年邀请应聘', 
  urgent_cnt int COMMENT '近一年急聘', 
  consume_cv_cnt int COMMENT '近一年下载精英简历消耗数', 
  consume_lowcv_cnt int COMMENT '近一年下载白领简历消耗数', 
  consume_intention_cv_cnt int COMMENT '近一年意向沟通消耗简历数', 
  consume_invite_cv_cnt int COMMENT '近一年邀请应聘消耗简历数', 
  consume_urgent_cv_cnt int COMMENT '近一年急聘消耗简历数', 
  consume_msk_cv_cnt int COMMENT '近一年面试快简历消耗数', 
  msk_service_cnt int COMMENT '近一年发起面试快服务数', 
  msk_showup_service_cnt int COMMENT '近一年有到场面试快服务数', 
  msk_showup_ratio float COMMENT '近一年面试快到场率', 
  ejob_avg_recv_cv_cnt int COMMENT '近一年职均投递数', 
  recv_cv_cnt int COMMENT '近一年职位总投递数', 
  recv_satisfied_cv_cnt int COMMENT '近一年投递满意数', 
  recv_satisfied_ratio float COMMENT '近一年投递满意率', 
  intention_valid_ratio float COMMENT '近一年意向沟通有效率', 
  intention_submit_cnt int COMMENT '近一年意向沟通交付数', 
  intention_submit_valid_cnt int COMMENT '近一年意向沟通有效交付数', 
  day30_cv_download_cnt int COMMENT '近一个月下载精英简历', 
  day30_lowcv_download_cnt int COMMENT '近一个月下载白领简历', 
  day30_intention_cnt int COMMENT '近一个月意向沟通', 
  day30_invite_cnt int COMMENT '近一个月邀请应聘', 
  day30_urgent_cnt int COMMENT '近一个月急聘', 
  day30_consume_cv_cnt int COMMENT '近一个月下载精英简历消耗数', 
  day30_consume_lowcv_cnt int COMMENT '近一个月下载白领简历消耗数', 
  day30_consume_intention_cv_cnt int COMMENT '近一个月意向沟通消耗简历数', 
  day30_consume_invite_cv_cnt int COMMENT '近一个月邀请应聘消耗简历数', 
  day30_consume_urgent_cv_cnt int COMMENT '近一个月急聘消耗简历数', 
  day30_consume_msk_cv_cnt int COMMENT '近一个月面试快简历消耗数', 
  day30_msk_service_cnt int COMMENT '近一个月发起面试快服务数', 
  day30_msk_showup_service_cnt int COMMENT '近一个月有到场面试快服务数', 
  day30_msk_showup_ratio float COMMENT '近一个月面试快到场率', 
  day30_ejob_avg_recv_cv_cnt int COMMENT '近一个月职均投递数', 
  day30_recv_cv_cnt int COMMENT '近一个月职位总投递数', 
  day30_recv_satisfied_cv_cnt int COMMENT '近一个月投递满意数', 
  day30_recv_satisfied_ratio float COMMENT '近一个月投递满意率', 
  day30_intention_valid_ratio float COMMENT '近一个月意向沟通有效率', 
  day30_intention_submit_cnt int COMMENT '近一个月意向沟通交付数', 
  day30_intention_submit_valid_cnt int COMMENT '近一个月意向沟通有效交付数', 
  day90_cv_download_cnt int COMMENT '近三个月下载精英简历', 
  day90_lowcv_download_cnt int COMMENT '近三个月下载白领简历', 
  day90_intention_cnt int COMMENT '近三个月意向沟通', 
  day90_invite_cnt int COMMENT '近三个月邀请应聘', 
  day90_urgent_cnt int COMMENT '近三个月急聘', 
  day90_consume_cv_cnt int COMMENT '近三个月下载精英简历消耗数', 
  day90_consume_lowcv_cnt int COMMENT '近三个月下载白领简历消耗数', 
  day90_consume_intention_cv_cnt int COMMENT '近三个月意向沟通消耗简历数', 
  day90_consume_invite_cv_cnt int COMMENT '近三个月邀请应聘消耗简历数', 
  day90_consume_urgent_cv_cnt int COMMENT '近三个月急聘消耗简历数', 
  day90_consume_msk_cv_cnt int COMMENT '近三个月面试快简历消耗数', 
  day90_msk_service_cnt int COMMENT '近三个月发起面试快服务数', 
  day90_msk_showup_service_cnt int COMMENT '近三个月有到场面试快服务数', 
  day90_msk_showup_ratio float COMMENT '近三个月面试快到场率', 
  day90_ejob_avg_recv_cv_cnt int COMMENT '近三个月职均投递数', 
  day90_recv_cv_cnt int COMMENT '近三个月职位总投递数', 
  day90_recv_satisfied_cv_cnt int COMMENT '近三个月投递满意数', 
  day90_recv_satisfied_ratio float COMMENT '近三个月投递满意率', 
  day90_intention_valid_ratio float COMMENT '近三个月意向沟通有效率', 
  day90_intention_submit_cnt int COMMENT '近三个月意向沟通交付数', 
  day90_intention_submit_valid_cnt int COMMENT '近三个月意向沟通有效交付数', 
  day180_cv_download_cnt int COMMENT '近半年下载精英简历', 
  day180_lowcv_download_cnt int COMMENT '近半年下载白领简历', 
  day180_intention_cnt int COMMENT '近半年意向沟通', 
  day180_invite_cnt int COMMENT '近半年邀请应聘', 
  day180_urgent_cnt int COMMENT '近半年急聘', 
  day180_consume_cv_cnt int COMMENT '近半年下载精英简历消耗数', 
  day180_consume_lowcv_cnt int COMMENT '近半年下载白领简历消耗数', 
  day180_consume_intention_cv_cnt int COMMENT '近半年意向沟通消耗简历数', 
  day180_consume_invite_cv_cnt int COMMENT '近半年邀请应聘消耗简历数', 
  day180_consume_urgent_cv_cnt int COMMENT '近半年急聘消耗简历数', 
  day180_consume_msk_cv_cnt int COMMENT '近半年面试快简历消耗数', 
  day180_msk_service_cnt int COMMENT '近半年发起面试快服务数', 
  day180_msk_showup_service_cnt int COMMENT '近半年有到场面试快服务数', 
  day180_msk_showup_ratio float COMMENT '近半年面试快到场率', 
  day180_ejob_avg_recv_cv_cnt int COMMENT '近半年职均投递数', 
  day180_recv_cv_cnt int COMMENT '近半年职位总投递数', 
  day180_recv_satisfied_cv_cnt int COMMENT '近半年投递满意数', 
  day180_recv_satisfied_ratio float COMMENT '近半年投递满意率', 
  day180_intention_valid_ratio float COMMENT '近半年意向沟通有效率', 
  day180_intention_submit_cnt int COMMENT '近半年意向沟通交付数', 
  day180_intention_submit_valid_cnt int COMMENT '近半年意向沟通有效交付数', 
  ejob_cnt int COMMENT '累计发布职位数', 
  day30_ejob_cnt int COMMENT '近一个月发布职位数', 
  day90_ejob_cnt int COMMENT '近三个月发布职位数', 
  day180_ejob_cnt int COMMENT '近半年发布职位数', 
  recv_deal_cv_cnt int COMMENT '累计投递处理量', 
  day30_recv_deal_cv_cnt int COMMENT '近一个月投递处理量', 
  day90_recv_deal_cv_cnt int COMMENT '近三个月投递处理量', 
  day180_recv_deal_cv_cnt int COMMENT '近半年投递处理量', 
  day365_recv_deal_cv_cnt int COMMENT '一年内投递处理量',   
  msk_takeorder_service_cnt int COMMENT '累计内有接单面试快服务数', 
  day30_msk_takeorder_service_cnt int COMMENT '近一个月有接单面试快服务数', 
  day90_msk_takeorder_service_cnt int COMMENT '近三个月有接单面试快服务数', 
  day180_msk_takeorder_service_cnt int COMMENT '近半年有接单面试快服务数', 
  day365_msk_takeorder_service_cnt int COMMENT '一年内有接单面试快服务数',
  ecomp_day7_login_cnt int COMMENT '分支机构近7天登录天数', 
  ecomp_day7_2_login_cnt int comment '分支机构近第2个7天登陆猎聘天数',
  ecomp_day7_3_login_cnt int comment '分支机构近第3个7天登陆猎聘天数',
  ecomp_day7_4_login_cnt int comment '分支机构近第4个7天登陆猎聘天数',
  ecomp_day7_5_login_cnt int comment '分支机构近第5个7天登陆猎聘天数',
  ecomp_day7_6_login_cnt int comment '分支机构近第6个7天登陆猎聘天数',
  ecomp_day7_7_login_cnt int comment '分支机构近第7个7天登陆猎聘天数',
  ecomp_day7_8_login_cnt int comment '分支机构近第8个7天登陆猎聘天数',
  ecomp_day7_9_login_cnt int comment '分支机构近第9个7天登陆猎聘天数',
  ecomp_day7_10_login_cnt int comment '分支机构近第10个7天登陆猎聘天数',
  ecomp_day7_11_login_cnt int comment '分支机构近第11个7天登陆猎聘天数',
  ecomp_day7_12_login_cnt int comment '分支机构近第12个7天登陆猎聘天数',
  ecomp_day7_13_login_cnt int comment '分支机构近第13个7天登陆猎聘天数',
  ecomp_day7_14_login_cnt int comment '分支机构近第14个7天登陆猎聘天数',  
  customer_day7_login_cnt int COMMENT '客户近7天登录天数', 
  customer_day7_2_login_cnt int comment '客户近第2个7天登陆猎聘天数',
  customer_day7_3_login_cnt int comment '客户近第3个7天登陆猎聘天数',
  customer_day7_4_login_cnt int comment '客户近第4个7天登陆猎聘天数',
  customer_day7_5_login_cnt int comment '客户近第5个7天登陆猎聘天数',
  customer_day7_6_login_cnt int comment '客户近第6个7天登陆猎聘天数',
  customer_day7_7_login_cnt int comment '客户近第7个7天登陆猎聘天数',
  customer_day7_8_login_cnt int comment '客户近第8个7天登陆猎聘天数',
  customer_day7_9_login_cnt int comment '客户近第9个7天登陆猎聘天数',
  customer_day7_10_login_cnt int comment '客户近第10个7天登陆猎聘天数',
  customer_day7_11_login_cnt int comment '客户近第11个7天登陆猎聘天数',
  customer_day7_12_login_cnt int comment '客户近第12个7天登陆猎聘天数',
  customer_day7_13_login_cnt int comment '客户近第13个7天登陆猎聘天数',
  customer_day7_14_login_cnt int comment '客户近第14个7天登陆猎聘天数',  
  creation_timestamp timestamp COMMENT '时间戳'
  )
COMMENT '客户hr7天内使用报告';


create table dw_erp_a_customer_report_usere(
  d_date int COMMENT '统计日期', 
  usere_id int COMMENT 'hr主键id', 
  usere_name varchar(100) COMMENT 'hr名称', 
  usere_account varchar(100) COMMENT 'hr猎聘通账号', 
  usere_account_status int COMMENT '猎聘通账号状态', 
  customer_id int COMMENT '客户id', 
  customer_name varchar(200) COMMENT '客户名称', 
  ecomp_root_id int COMMENT 'ecomp_root_id', 
  ecomp_id int COMMENT 'ecomp_id', 
  ecomp_name varchar(200) COMMENT 'ecomp_name', 
  active_ejob_cnt int COMMENT '活跃职位数', 
  publish_day7_no_apply_ejob_cnt int COMMENT '发布七天以上无投递职位数', 
  msk_potential_ejob_cnt int COMMENT '面试快潜力职位数', 
  day7_login_cnt int COMMENT '近7天登录天数', 
  day7_consume_cv_total_cnt int COMMENT '近7天精英资源综合消耗', 
  day7_active_ejob_cnt int COMMENT '近7天活跃职位数', 
  day7_im_userc_cnt int COMMENT '近7天职聊人数', 
  day7_2_login_cnt int comment '近第2个7天登陆猎聘天数',
  day7_3_login_cnt int comment '近第3个7天登陆猎聘天数',
  day7_4_login_cnt int comment '近第4个7天登陆猎聘天数',
  day7_5_login_cnt int comment '近第5个7天登陆猎聘天数',
  day7_6_login_cnt int comment '近第6个7天登陆猎聘天数',
  day7_7_login_cnt int comment '近第7个7天登陆猎聘天数',
  day7_8_login_cnt int comment '近第8个7天登陆猎聘天数',
  day7_9_login_cnt int comment '近第9个7天登陆猎聘天数',
  day7_10_login_cnt int comment '近第10个7天登陆猎聘天数',
  day7_11_login_cnt int comment '近第11个7天登陆猎聘天数',
  day7_12_login_cnt int comment '近第12个7天登陆猎聘天数',
  day7_13_login_cnt int comment '近第13个7天登陆猎聘天数',
  day7_14_login_cnt int comment '近第14个7天登陆猎聘天数',
  day7_2_consume_cv_total_cnt int comment '近第2个7天精英资源综合消耗',
  day7_3_consume_cv_total_cnt int comment '近第3个7天精英资源综合消耗',
  day7_4_consume_cv_total_cnt int comment '近第4个7天精英资源综合消耗',
  day7_5_consume_cv_total_cnt int comment '近第5个7天精英资源综合消耗',
  day7_6_consume_cv_total_cnt int comment '近第6个7天精英资源综合消耗',
  day7_7_consume_cv_total_cnt int comment '近第7个7天精英资源综合消耗',
  day7_8_consume_cv_total_cnt int comment '近第8个7天精英资源综合消耗',
  day7_9_consume_cv_total_cnt int comment '近第9个7天精英资源综合消耗',
  day7_10_consume_cv_total_cnt int comment '近第10个7天精英资源综合消耗',
  day7_11_consume_cv_total_cnt int comment '近第11个7天精英资源综合消耗',
  day7_12_consume_cv_total_cnt int comment '近第12个7天精英资源综合消耗',
  day7_13_consume_cv_total_cnt int comment '近第13个7天精英资源综合消耗',
  day7_14_consume_cv_total_cnt int comment '近第14个7天精英资源综合消耗',
  day7_2_active_ejob_cnt int comment '近第2个7天活跃职位数',
  day7_3_active_ejob_cnt int comment '近第3个7天活跃职位数',
  day7_4_active_ejob_cnt int comment '近第4个7天活跃职位数',
  day7_5_active_ejob_cnt int comment '近第5个7天活跃职位数',
  day7_6_active_ejob_cnt int comment '近第6个7天活跃职位数',
  day7_7_active_ejob_cnt int comment '近第7个7天活跃职位数',
  day7_8_active_ejob_cnt int comment '近第8个7天活跃职位数',
  day7_9_active_ejob_cnt int comment '近第9个7天活跃职位数',
  day7_10_active_ejob_cnt int comment '近第10个7天活跃职位数',
  day7_11_active_ejob_cnt int comment '近第11个7天活跃职位数',
  day7_12_active_ejob_cnt int comment '近第12个7天活跃职位数',
  day7_13_active_ejob_cnt int comment '近第13个7天活跃职位数',
  day7_14_active_ejob_cnt int comment '近第14个7天活跃职位数',
  day7_2_im_userc_cnt int comment '近第2个7天职聊人数',
  day7_3_im_userc_cnt int comment '近第3个7天职聊人数',
  day7_4_im_userc_cnt int comment '近第4个7天职聊人数',
  day7_5_im_userc_cnt int comment '近第5个7天职聊人数',
  day7_6_im_userc_cnt int comment '近第6个7天职聊人数',
  day7_7_im_userc_cnt int comment '近第7个7天职聊人数',
  day7_8_im_userc_cnt int comment '近第8个7天职聊人数',
  day7_9_im_userc_cnt int comment '近第9个7天职聊人数',
  day7_10_im_userc_cnt int comment '近第10个7天职聊人数',
  day7_11_im_userc_cnt int comment '近第11个7天职聊人数',
  day7_12_im_userc_cnt int comment '近第12个7天职聊人数',
  day7_13_im_userc_cnt int comment '近第13个7天职聊人数',
  day7_14_im_userc_cnt int comment '近第14个7天职聊人数',
  cv_download_cnt int COMMENT '近一年下载精英简历', 
  lowcv_download_cnt int COMMENT '近一年下载白领简历', 
  intention_cnt int COMMENT '近一年意向沟通', 
  invite_cnt int COMMENT '近一年邀请应聘', 
  urgent_cnt int COMMENT '近一年急聘', 
  consume_cv_cnt int COMMENT '近一年下载精英简历消耗数', 
  consume_lowcv_cnt int COMMENT '近一年下载白领简历消耗数', 
  consume_intention_cv_cnt int COMMENT '近一年意向沟通消耗简历数', 
  consume_invite_cv_cnt int COMMENT '近一年邀请应聘消耗简历数', 
  consume_urgent_cv_cnt int COMMENT '近一年急聘消耗简历数', 
  consume_msk_cv_cnt int COMMENT '近一年面试快简历消耗数', 
  msk_service_cnt int COMMENT '近一年发起面试快服务数', 
  msk_showup_service_cnt int COMMENT '近一年有到场面试快服务数', 
  msk_showup_ratio float COMMENT '近一年面试快到场率', 
  ejob_avg_recv_cv_cnt int COMMENT '近一年职均投递数', 
  recv_cv_cnt int COMMENT '近一年职位总投递数', 
  recv_satisfied_cv_cnt int COMMENT '近一年投递满意数', 
  recv_satisfied_ratio float COMMENT '近一年投递满意率', 
  intention_valid_ratio float COMMENT '近一年意向沟通有效率', 
  intention_submit_cnt int COMMENT '近一年意向沟通交付数', 
  intention_submit_valid_cnt int COMMENT '近一年意向沟通有效交付数', 
  day30_cv_download_cnt int COMMENT '近一个月下载精英简历', 
  day30_lowcv_download_cnt int COMMENT '近一个月下载白领简历', 
  day30_intention_cnt int COMMENT '近一个月意向沟通', 
  day30_invite_cnt int COMMENT '近一个月邀请应聘', 
  day30_urgent_cnt int COMMENT '近一个月急聘', 
  day30_consume_cv_cnt int COMMENT '近一个月下载精英简历消耗数', 
  day30_consume_lowcv_cnt int COMMENT '近一个月下载白领简历消耗数', 
  day30_consume_intention_cv_cnt int COMMENT '近一个月意向沟通消耗简历数', 
  day30_consume_invite_cv_cnt int COMMENT '近一个月邀请应聘消耗简历数', 
  day30_consume_urgent_cv_cnt int COMMENT '近一个月急聘消耗简历数', 
  day30_consume_msk_cv_cnt int COMMENT '近一个月面试快简历消耗数', 
  day30_msk_service_cnt int COMMENT '近一个月发起面试快服务数', 
  day30_msk_showup_service_cnt int COMMENT '近一个月有到场面试快服务数', 
  day30_msk_showup_ratio float COMMENT '近一个月面试快到场率', 
  day30_ejob_avg_recv_cv_cnt int COMMENT '近一个月职均投递数', 
  day30_recv_cv_cnt int COMMENT '近一个月职位总投递数', 
  day30_recv_satisfied_cv_cnt int COMMENT '近一个月投递满意数', 
  day30_recv_satisfied_ratio float COMMENT '近一个月投递满意率', 
  day30_intention_valid_ratio float COMMENT '近一个月意向沟通有效率', 
  day30_intention_submit_cnt int COMMENT '近一个月意向沟通交付数', 
  day30_intention_submit_valid_cnt int COMMENT '近一个月意向沟通有效交付数', 
  day90_cv_download_cnt int COMMENT '近三个月下载精英简历', 
  day90_lowcv_download_cnt int COMMENT '近三个月下载白领简历', 
  day90_intention_cnt int COMMENT '近三个月意向沟通', 
  day90_invite_cnt int COMMENT '近三个月邀请应聘', 
  day90_urgent_cnt int COMMENT '近三个月急聘', 
  day90_consume_cv_cnt int COMMENT '近三个月下载精英简历消耗数', 
  day90_consume_lowcv_cnt int COMMENT '近三个月下载白领简历消耗数', 
  day90_consume_intention_cv_cnt int COMMENT '近三个月意向沟通消耗简历数', 
  day90_consume_invite_cv_cnt int COMMENT '近三个月邀请应聘消耗简历数', 
  day90_consume_urgent_cv_cnt int COMMENT '近三个月急聘消耗简历数', 
  day90_consume_msk_cv_cnt int COMMENT '近三个月面试快简历消耗数', 
  day90_msk_service_cnt int COMMENT '近三个月发起面试快服务数', 
  day90_msk_showup_service_cnt int COMMENT '近三个月有到场面试快服务数', 
  day90_msk_showup_ratio float COMMENT '近三个月面试快到场率', 
  day90_ejob_avg_recv_cv_cnt int COMMENT '近三个月职均投递数', 
  day90_recv_cv_cnt int COMMENT '近三个月职位总投递数', 
  day90_recv_satisfied_cv_cnt int COMMENT '近三个月投递满意数', 
  day90_recv_satisfied_ratio float COMMENT '近三个月投递满意率', 
  day90_intention_valid_ratio float COMMENT '近三个月意向沟通有效率', 
  day90_intention_submit_cnt int COMMENT '近三个月意向沟通交付数', 
  day90_intention_submit_valid_cnt int COMMENT '近三个月意向沟通有效交付数', 
  day180_cv_download_cnt int COMMENT '近半年下载精英简历', 
  day180_lowcv_download_cnt int COMMENT '近半年下载白领简历', 
  day180_intention_cnt int COMMENT '近半年意向沟通', 
  day180_invite_cnt int COMMENT '近半年邀请应聘', 
  day180_urgent_cnt int COMMENT '近半年急聘', 
  day180_consume_cv_cnt int COMMENT '近半年下载精英简历消耗数', 
  day180_consume_lowcv_cnt int COMMENT '近半年下载白领简历消耗数', 
  day180_consume_intention_cv_cnt int COMMENT '近半年意向沟通消耗简历数', 
  day180_consume_invite_cv_cnt int COMMENT '近半年邀请应聘消耗简历数', 
  day180_consume_urgent_cv_cnt int COMMENT '近半年急聘消耗简历数', 
  day180_consume_msk_cv_cnt int COMMENT '近半年面试快简历消耗数', 
  day180_msk_service_cnt int COMMENT '近半年发起面试快服务数', 
  day180_msk_showup_service_cnt int COMMENT '近半年有到场面试快服务数', 
  day180_msk_showup_ratio float COMMENT '近半年面试快到场率', 
  day180_ejob_avg_recv_cv_cnt int COMMENT '近半年职均投递数', 
  day180_recv_cv_cnt int COMMENT '近半年职位总投递数', 
  day180_recv_satisfied_cv_cnt int COMMENT '近半年投递满意数', 
  day180_recv_satisfied_ratio float COMMENT '近半年投递满意率', 
  day180_intention_valid_ratio float COMMENT '近半年意向沟通有效率', 
  day180_intention_submit_cnt int COMMENT '近半年意向沟通交付数', 
  day180_intention_submit_valid_cnt int COMMENT '近半年意向沟通有效交付数', 
  ejob_cnt int COMMENT '累计发布职位数', 
  day30_ejob_cnt int COMMENT '近一个月发布职位数', 
  day90_ejob_cnt int COMMENT '近三个月发布职位数', 
  day180_ejob_cnt int COMMENT '近半年发布职位数', 
  recv_deal_cv_cnt int COMMENT '累计投递处理量', 
  day30_recv_deal_cv_cnt int COMMENT '近一个月投递处理量', 
  day90_recv_deal_cv_cnt int COMMENT '近三个月投递处理量', 
  day180_recv_deal_cv_cnt int COMMENT '近半年投递处理量', 
  day365_recv_deal_cv_cnt int COMMENT '一年内投递处理量',   
  msk_takeorder_service_cnt int COMMENT '累计内有接单面试快服务数', 
  day30_msk_takeorder_service_cnt int COMMENT '近一个月有接单面试快服务数', 
  day90_msk_takeorder_service_cnt int COMMENT '近三个月有接单面试快服务数', 
  day180_msk_takeorder_service_cnt int COMMENT '近半年有接单面试快服务数', 
  day365_msk_takeorder_service_cnt int COMMENT '一年内有接单面试快服务数',
  ecomp_day7_login_cnt int COMMENT '分支机构近7天登录天数', 
  ecomp_day7_2_login_cnt int comment '分支机构近第2个7天登陆猎聘天数',
  ecomp_day7_3_login_cnt int comment '分支机构近第3个7天登陆猎聘天数',
  ecomp_day7_4_login_cnt int comment '分支机构近第4个7天登陆猎聘天数',
  ecomp_day7_5_login_cnt int comment '分支机构近第5个7天登陆猎聘天数',
  ecomp_day7_6_login_cnt int comment '分支机构近第6个7天登陆猎聘天数',
  ecomp_day7_7_login_cnt int comment '分支机构近第7个7天登陆猎聘天数',
  ecomp_day7_8_login_cnt int comment '分支机构近第8个7天登陆猎聘天数',
  ecomp_day7_9_login_cnt int comment '分支机构近第9个7天登陆猎聘天数',
  ecomp_day7_10_login_cnt int comment '分支机构近第10个7天登陆猎聘天数',
  ecomp_day7_11_login_cnt int comment '分支机构近第11个7天登陆猎聘天数',
  ecomp_day7_12_login_cnt int comment '分支机构近第12个7天登陆猎聘天数',
  ecomp_day7_13_login_cnt int comment '分支机构近第13个7天登陆猎聘天数',
  ecomp_day7_14_login_cnt int comment '分支机构近第14个7天登陆猎聘天数',  
  customer_day7_login_cnt int COMMENT '客户近7天登录天数', 
  customer_day7_2_login_cnt int comment '客户近第2个7天登陆猎聘天数',
  customer_day7_3_login_cnt int comment '客户近第3个7天登陆猎聘天数',
  customer_day7_4_login_cnt int comment '客户近第4个7天登陆猎聘天数',
  customer_day7_5_login_cnt int comment '客户近第5个7天登陆猎聘天数',
  customer_day7_6_login_cnt int comment '客户近第6个7天登陆猎聘天数',
  customer_day7_7_login_cnt int comment '客户近第7个7天登陆猎聘天数',
  customer_day7_8_login_cnt int comment '客户近第8个7天登陆猎聘天数',
  customer_day7_9_login_cnt int comment '客户近第9个7天登陆猎聘天数',
  customer_day7_10_login_cnt int comment '客户近第10个7天登陆猎聘天数',
  customer_day7_11_login_cnt int comment '客户近第11个7天登陆猎聘天数',
  customer_day7_12_login_cnt int comment '客户近第12个7天登陆猎聘天数',
  customer_day7_13_login_cnt int comment '客户近第13个7天登陆猎聘天数',
  customer_day7_14_login_cnt int comment '客户近第14个7天登陆猎聘天数',  
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,usere_id,ecomp_id)
) comment '客户HR7天内使用报告';

insert overwrite table dw_erp_a_customer_report_usere
select d_date
, usere_id
, usere_name
, usere_account
, usere_account_status
, customer_id
, customer_name
, ecomp_root_id
, ecomp_id
, ecomp_name
, active_ejob_cnt
, publish_day7_no_apply_ejob_cnt
, msk_potential_ejob_cnt
, day7_login_cnt
, day7_consume_cv_total_cnt
, day7_active_ejob_cnt
, day7_im_userc_cnt
, day7_2_login_cnt
, day7_3_login_cnt
, day7_4_login_cnt
, day7_5_login_cnt
, day7_6_login_cnt
, day7_7_login_cnt
, day7_8_login_cnt
, day7_9_login_cnt
, day7_10_login_cnt
, day7_11_login_cnt
, day7_12_login_cnt
, day7_13_login_cnt
, day7_14_login_cnt
, day7_2_consume_cv_total_cnt
, day7_3_consume_cv_total_cnt
, day7_4_consume_cv_total_cnt
, day7_5_consume_cv_total_cnt
, day7_6_consume_cv_total_cnt
, day7_7_consume_cv_total_cnt
, day7_8_consume_cv_total_cnt
, day7_9_consume_cv_total_cnt
, day7_10_consume_cv_total_cnt
, day7_11_consume_cv_total_cnt
, day7_12_consume_cv_total_cnt
, day7_13_consume_cv_total_cnt
, day7_14_consume_cv_total_cnt
, day7_2_active_ejob_cnt
, day7_3_active_ejob_cnt
, day7_4_active_ejob_cnt
, day7_5_active_ejob_cnt
, day7_6_active_ejob_cnt
, day7_7_active_ejob_cnt
, day7_8_active_ejob_cnt
, day7_9_active_ejob_cnt
, day7_10_active_ejob_cnt
, day7_11_active_ejob_cnt
, day7_12_active_ejob_cnt
, day7_13_active_ejob_cnt
, day7_14_active_ejob_cnt
, day7_2_im_userc_cnt
, day7_3_im_userc_cnt
, day7_4_im_userc_cnt
, day7_5_im_userc_cnt
, day7_6_im_userc_cnt
, day7_7_im_userc_cnt
, day7_8_im_userc_cnt
, day7_9_im_userc_cnt
, day7_10_im_userc_cnt
, day7_11_im_userc_cnt
, day7_12_im_userc_cnt
, day7_13_im_userc_cnt
, day7_14_im_userc_cnt
, cv_download_cnt
, lowcv_download_cnt
, intention_cnt
, invite_cnt
, urgent_cnt
, consume_cv_cnt
, consume_lowcv_cnt
, consume_intention_cv_cnt
, consume_invite_cv_cnt
, consume_urgent_cv_cnt
, consume_msk_cv_cnt
, msk_service_cnt
, msk_showup_service_cnt
, msk_showup_ratio
, ejob_avg_recv_cv_cnt
, recv_cv_cnt
, recv_satisfied_cv_cnt
, recv_satisfied_ratio
, intention_valid_ratio
, intention_submit_cnt
, intention_submit_valid_cnt
, day30_cv_download_cnt
, day30_lowcv_download_cnt
, day30_intention_cnt
, day30_invite_cnt
, day30_urgent_cnt
, day30_consume_cv_cnt
, day30_consume_lowcv_cnt
, day30_consume_intention_cv_cnt
, day30_consume_invite_cv_cnt
, day30_consume_urgent_cv_cnt
, day30_consume_msk_cv_cnt
, day30_msk_service_cnt
, day30_msk_showup_service_cnt
, day30_msk_showup_ratio
, day30_ejob_avg_recv_cv_cnt
, day30_recv_cv_cnt
, day30_recv_satisfied_cv_cnt
, day30_recv_satisfied_ratio
, day30_intention_valid_ratio
, day30_intention_submit_cnt
, day30_intention_submit_valid_cnt
, day90_cv_download_cnt
, day90_lowcv_download_cnt
, day90_intention_cnt
, day90_invite_cnt
, day90_urgent_cnt
, day90_consume_cv_cnt
, day90_consume_lowcv_cnt
, day90_consume_intention_cv_cnt
, day90_consume_invite_cv_cnt
, day90_consume_urgent_cv_cnt
, day90_consume_msk_cv_cnt
, day90_msk_service_cnt
, day90_msk_showup_service_cnt
, day90_msk_showup_ratio
, day90_ejob_avg_recv_cv_cnt
, day90_recv_cv_cnt
, day90_recv_satisfied_cv_cnt
, day90_recv_satisfied_ratio
, day90_intention_valid_ratio
, day90_intention_submit_cnt
, day90_intention_submit_valid_cnt
, day180_cv_download_cnt
, day180_lowcv_download_cnt
, day180_intention_cnt
, day180_invite_cnt
, day180_urgent_cnt
, day180_consume_cv_cnt
, day180_consume_lowcv_cnt
, day180_consume_intention_cv_cnt
, day180_consume_invite_cv_cnt
, day180_consume_urgent_cv_cnt
, day180_consume_msk_cv_cnt
, day180_msk_service_cnt
, day180_msk_showup_service_cnt
, day180_msk_showup_ratio
, day180_ejob_avg_recv_cv_cnt
, day180_recv_cv_cnt
, day180_recv_satisfied_cv_cnt
, day180_recv_satisfied_ratio
, day180_intention_valid_ratio
, day180_intention_submit_cnt
, day180_intention_submit_valid_cnt
, ejob_cnt
, day30_ejob_cnt
, day90_ejob_cnt
, day180_ejob_cnt
, recv_deal_cv_cnt
, day30_recv_deal_cv_cnt
, day90_recv_deal_cv_cnt
, day180_recv_deal_cv_cnt
, day365_recv_deal_cv_cnt
, msk_takeorder_service_cnt
, day30_msk_takeorder_service_cnt
, day90_msk_takeorder_service_cnt
, day180_msk_takeorder_service_cnt
, day365_msk_takeorder_service_cnt
, ecomp_day7_login_cnt
, ecomp_day7_2_login_cnt
, ecomp_day7_3_login_cnt
, ecomp_day7_4_login_cnt
, ecomp_day7_5_login_cnt
, ecomp_day7_6_login_cnt
, ecomp_day7_7_login_cnt
, ecomp_day7_8_login_cnt
, ecomp_day7_9_login_cnt
, ecomp_day7_10_login_cnt
, ecomp_day7_11_login_cnt
, ecomp_day7_12_login_cnt
, ecomp_day7_13_login_cnt
, ecomp_day7_14_login_cnt
, customer_day7_login_cnt
, customer_day7_2_login_cnt
, customer_day7_3_login_cnt
, customer_day7_4_login_cnt
, customer_day7_5_login_cnt
, customer_day7_6_login_cnt
, customer_day7_7_login_cnt
, customer_day7_8_login_cnt
, customer_day7_9_login_cnt
, customer_day7_10_login_cnt
, customer_day7_11_login_cnt
, customer_day7_12_login_cnt
, customer_day7_13_login_cnt
, customer_day7_14_login_cnt
, current_timestamp as  creation_timestamp
,day365_msk_service_cnt
,day365_msk_showup_service_cnt
,day365_msk_showup_ratio
,day365_recv_cv_cnt
,day365_recv_satisfied_cv_cnt
,day365_recv_satisfied_ratio
,day365_intention_submit_cnt
,day365_intention_submit_valid_cnt
,day365_intention_valid_ratio
,day365_ejob_cnt
,day365_ejob_avg_recv_cv_cnt
from dw_erp_d_customer_report_usere
where p_date = $date$








insert overwrite table dw_erp_d_customer_report_ejob partition (p_date = $date$)
select 
	$date$ as d_date,
	eb.ejob_id,
	regexp_replace(eb.ejob_title,'	','') as ejob_title,
	eb.usere_id,
	regexp_replace(ue.e_name,'	','') as usere_name,
	eb.ecomp_id,
	ep.ecomp_root_id,
	cb.id as customer_id,
	eb.ejob_createtime,
	eb.ejob_status,
	eb.ejob_focusflag,
	eb.ejob_dq as dq,
	concat(eb.ejob_salarylow_new,'w - ',eb.ejob_salaryhigh_new,'w') as salary_level,
	eb.is_day7_new_publish,
	eb.is_privacyreq,
	if(nvl(msk.in_service_msk_cnt,0)>0,1,0) as is_in_msk_service,
	nvl(urgt.is_in_urgent,0) as is_in_urgent,
	eb.is_in_hot,
	eb.publish_days,
	case 
		when eb.ejob_status = 0 and eb.is_day7_new_publish=1 then 1 --最近七天新发布的职位
		when eb.ejob_status = 0 and  (nvl(dn.day7_download_cv_cnt,0)>0 
			or nvl(urgt.is_in_urgent,0) =1 
			or nvl(invite.day7_invite_cnt,0)>0
			or nvl(inten.day7_intention_submit_cnt,0)>0)
			then 1--最近七天发生过消耗的职位
		when eb.ejob_status = 0 and  msk.in_service_msk_cnt>0 then 1 --当前在面试快中的职位
		when eb.ejob_status = 0 and  nvl(rcv.day7_recv_deal_cv_cnt,0) > 0 then 1 --最近七天HR有过投递处理的职位
		when eb.ejob_status = 0 and  eb.is_in_hot=1 then 1 --最近七天HR对该职位进行过置顶操作的职位
		when eb.ejob_status = 0 and  nvl(recmd.day7_rps_recmd_deal_cv_cnt,0)>0 then 1 --最近七天有过人工推荐处理的职位
		else 0
	end as day7_is_active,--是否活跃职位
	nvl(rcv.day7_recv_cv_cnt,0) as day7_recv_cv_cnt,
	nvl(rcv.day30_recv_cv_cnt,0) as day30_recv_cv_cnt,
	nvl(rcv.day30_recv_deal_cv_cnt,0) as day30_recv_deal_cv_cnt,
	nvl(rcv.day30_recv_satisfied_cv_cnt,0) as day30_recv_satisfied_cv_cnt,
	if(nvl(rcv.day30_recv_deal_cv_cnt,0)=0,0,round(nvl(rcv.day30_recv_satisfied_cv_cnt,0)/nvl(rcv.day30_recv_deal_cv_cnt,0),2)*100) as day30_recv_satisfied_ratio,
	nvl(rcv.day90_recv_cv_cnt,0) as day90_recv_cv_cnt,
	nvl(rcv.day90_recv_deal_cv_cnt,0) as day90_recv_deal_cv_cnt,
	nvl(rcv.day90_recv_satisfied_cv_cnt,0) as day90_recv_satisfied_cv_cnt,
	if(nvl(rcv.day90_recv_deal_cv_cnt,0)=0,0,round(nvl(rcv.day90_recv_satisfied_cv_cnt,0)/nvl(rcv.day90_recv_deal_cv_cnt,0),2)*100) as day90_recv_satisfied_ratio,
	nvl(rcv.day180_recv_cv_cnt,0) as day180_recv_cv_cnt,
	nvl(rcv.day180_recv_deal_cv_cnt,0) as day180_recv_deal_cv_cnt,
	nvl(rcv.day180_recv_satisfied_cv_cnt,0) as day180_recv_satisfied_cv_cnt,
	if(nvl(rcv.day180_recv_deal_cv_cnt,0)=0,0,round(nvl(rcv.day180_recv_satisfied_cv_cnt,0)/nvl(rcv.day180_recv_deal_cv_cnt,0),2)*100) as day180_recv_satisfied_ratio,
	nvl(rcv.day365_recv_cv_cnt,0) as day365_recv_cv_cnt,
	nvl(rcv.day365_recv_deal_cv_cnt,0) as day365_recv_deal_cv_cnt,
	nvl(rcv.day365_recv_satisfied_cv_cnt,0) as day365_recv_satisfied_cv_cnt,
	if(nvl(rcv.day365_recv_deal_cv_cnt,0)=0,0,round(nvl(rcv.day365_recv_satisfied_cv_cnt,0)/nvl(rcv.day365_recv_deal_cv_cnt,0),2)*100) as day365_recv_satisfied_ratio,
	nvl(rcv.recv_cv_cnt,0) as recv_cv_cnt,
	nvl(rcv.recv_deal_cv_cnt,0) as recv_deal_cv_cnt,
	nvl(rcv.recv_satisfied_cv_cnt,0) as recv_satisfied_cv_cnt,
	if(nvl(rcv.recv_deal_cv_cnt,0)=0,0,round(nvl(rcv.recv_satisfied_cv_cnt,0)/nvl(rcv.recv_deal_cv_cnt,0),2)*100) as recv_satisfied_ratio,
	nvl(dn.day7_download_cv_cnt,0) as day7_download_cv_cnt,
	nvl(rcv.day7_recv_deal_cv_cnt,0) as day7_recv_deal_cv_cnt,
	nvl(inten.day30_intention_submit_cnt,0) as day30_intention_submit_cnt,
	nvl(inten.day30_intention_submit_valid_cnt,0) as day30_intention_submit_valid_cnt,
	if(nvl(inten.day30_intention_submit_cnt,0)=0,0,round(nvl(inten.day30_intention_submit_valid_cnt,0)/nvl(inten.day30_intention_submit_cnt,0) ,2)*100) as day30_intention_valid_ratio,
	nvl(inten.day90_intention_submit_cnt,0) as day90_intention_submit_cnt,
	nvl(inten.day90_intention_submit_valid_cnt,0) as day90_intention_submit_valid_cnt,
	if(nvl(inten.day90_intention_submit_cnt,0)=0,0,round(nvl(inten.day90_intention_submit_valid_cnt,0)/nvl(inten.day90_intention_submit_cnt,0) ,2)*100) as day90_intention_valid_ratio,
	nvl(inten.day180_intention_submit_cnt,0) as day180_intention_submit_cnt,
	nvl(inten.day180_intention_submit_valid_cnt,0) as day180_intention_submit_valid_cnt,
	if(nvl(inten.day180_intention_submit_cnt,0)=0,0,round(nvl(inten.day180_intention_submit_valid_cnt,0)/nvl(inten.day180_intention_submit_cnt,0) ,2)*100) as day180_intention_valid_ratio,
	nvl(inten.day365_intention_submit_cnt,0) as day365_intention_submit_cnt,
	nvl(inten.day365_intention_submit_valid_cnt,0) as day365_intention_submit_valid_cnt,
	if(nvl(inten.day365_intention_submit_cnt,0)=0,0,round(nvl(inten.day365_intention_submit_valid_cnt,0)/nvl(inten.day365_intention_submit_cnt,0) ,2)*100) as day365_intention_valid_ratio,
	--intention
	nvl(inten.intention_submit_cnt,0) as intention_submit_cnt,
	nvl(inten.intention_submit_valid_cnt,0) as intention_submit_valid_cnt,
	if(nvl(inten.intention_submit_cnt,0)=0,0,round(nvl(inten.intention_submit_valid_cnt,0)/nvl(inten.intention_submit_cnt,0),2)*100) as intention_valid_ratio,
	--msk
	if(nvl(msk.msk_service_cnt,0)>0,1,0) as is_used_msk_service,
	nvl(msk.day30_msk_service_cnt,0) as day30_msk_service_cnt,
	nvl(msk.day30_msk_takeorder_service_cnt,0) as day30_msk_takeorder_service_cnt,
	nvl(msk.day30_msk_showup_service_cnt,0) as day30_msk_showup_service_cnt,
	if(nvl(msk.day30_msk_takeorder_service_cnt,0) =0,0,round(nvl(msk.day30_msk_showup_service_cnt,0)/nvl(msk.day30_msk_takeorder_service_cnt,0),2)*100) as day30_msk_showup_ratio, 
	nvl(msk.day90_msk_service_cnt,0) as day90_msk_service_cnt,
	nvl(msk.day90_msk_takeorder_service_cnt,0) as day90_msk_takeorder_service_cnt,
	nvl(msk.day90_msk_showup_service_cnt,0) as day90_msk_showup_service_cnt,
	if(nvl(msk.day90_msk_takeorder_service_cnt,0) =0,0,round(nvl(msk.day90_msk_showup_service_cnt,0)/nvl(msk.day90_msk_takeorder_service_cnt,0),2)*100) as day90_msk_showup_ratio, 
	nvl(msk.day180_msk_service_cnt,0) as day180_msk_service_cnt,
	nvl(msk.day180_msk_takeorder_service_cnt,0) as day180_msk_takeorder_service_cnt,
	nvl(msk.day180_msk_showup_service_cnt,0) as day180_msk_showup_service_cnt,
	if(nvl(msk.day180_msk_takeorder_service_cnt,0) =0,0,round(nvl(msk.day180_msk_showup_service_cnt,0)/nvl(msk.day180_msk_takeorder_service_cnt,0),2)*100) as day180_msk_showup_ratio, --?
	nvl(msk.day365_msk_service_cnt,0) as day365_msk_service_cnt,
	nvl(msk.day365_msk_takeorder_service_cnt,0) as day365_msk_takeorder_service_cnt,
	nvl(msk.day365_msk_showup_service_cnt,0) as day365_msk_showup_service_cnt,
	if(nvl(msk.day365_msk_takeorder_service_cnt,0) =0,0,round(nvl(msk.day365_msk_showup_service_cnt,0)/nvl(msk.day365_msk_takeorder_service_cnt,0),2)*100) as day365_msk_showup_ratio, --?
	nvl(msk.msk_service_cnt,0) as msk_service_cnt,
	nvl(msk.msk_takeorder_service_cnt,0) as msk_takeorder_service_cnt,
	nvl(msk.msk_showup_service_cnt,0) as msk_showup_service_cnt,
	if(nvl(msk.msk_takeorder_service_cnt,0)=0,0,round(nvl(msk.msk_showup_service_cnt,0)/nvl(msk.msk_takeorder_service_cnt,0),2)*100) as msk_showup_ratio, 
	--urgent
	if(nvl(urgt.urgent_cnt,0)>0,1,0) as is_used_urgent,
	--invite
	if(nvl(invite.invite_cnt,0)>0,1,0) as is_used_invite,
	--recommend
	nvl(recmd.day7_rps_recmd_cv_cnt,0) as day7_rps_recmd_cv_cnt,
	nvl(recmd.day7_rps_recmd_satisfied_cv_cnt,0) as day7_rps_recmd_satisfied_cv_cnt,
	nvl(recmd.day7_rps_recmd_deal_cv_cnt,0) as day7_rps_recmd_deal_cv_cnt,
	ee.tend_edulevel,
	ee.tend_agelevel,
	ee.tend_workyear,
	ee.tend_want_yearsalary,
	nvl(umsk.usere_used_msk_service_cnt,0) as usere_used_msk_service_cnt,
	nvl(samemsk.same_ejob_msk_success_cnt,0) as same_ejob_msk_success_cnt,
	nvl(samemsk.same_ejob_msk_rps_ratio,0) as same_ejob_msk_rps_ratio,
	nvl(samemsk.same_ejob_msk_consultant_cnt,0) as same_ejob_msk_consultant_cnt,
	nvl(usmsk.usere_same_ejob_msk_success_cnt,0) as usere_same_ejob_msk_success_cnt,
	nvl(samemsk.avg_same_ejob_msk_success_days,0) as avg_same_ejob_msk_success_days,
	case 
		when eb.ejob_status = 0 and nvl(msk.in_service_msk_cnt,0)=0 and nvl(samemsk.same_ejob_msk_success_cnt,0)>0 and eb.is_day7_new_publish=1 then 1 --最近七天新发布的职位
		when  eb.ejob_status = 0 and nvl(msk.in_service_msk_cnt,0)=0 and nvl(samemsk.same_ejob_msk_success_cnt,0)>0 
			and (nvl(dn.day7_download_cv_cnt,0)>0 
			or nvl(urgt.is_in_urgent,0) =1 
			or nvl(invite.day7_invite_cnt,0)>0
			or nvl(inten.day7_intention_submit_cnt,0)>0)
			then 1--最近七天发生过消耗的职位
		when eb.ejob_status = 0 and  nvl(msk.in_service_msk_cnt,0)=0 and nvl(samemsk.same_ejob_msk_success_cnt,0)>0  and nvl(rcv.day7_recv_deal_cv_cnt,0) > 0 then 1 --最近七天HR有过投递处理的职位
		when eb.ejob_status = 0 and  nvl(msk.in_service_msk_cnt,0)=0 and nvl(samemsk.same_ejob_msk_success_cnt,0)>0  and eb.is_in_hot=1 then 1 --最近七天HR对该职位进行过置顶操作的职位
		when eb.ejob_status = 0 and  nvl(msk.in_service_msk_cnt,0)=0 and nvl(samemsk.same_ejob_msk_success_cnt,0)>0  and nvl(recmd.day7_rps_recmd_deal_cv_cnt,0)>0 then 1 --最近七天有过人工推荐处理的职位
		else 0
	end as is_have_msk_potential,--是否面试快潜力职位(不在面试快服务中+有相似的面试快成功职位+活跃职位)
	nvl(incrpv.day7_view_cnt,0) as day7_view_cnt,
	nvl(pv.view_cnt,0)+nvl(incrpv.view_cnt,0) as view_cnt,
	current_timestamp() as create_timestamp
from
(select
	eb.ejob_id,
	eb.ejob_title,
	nvl(eue.user_id,-1) as usere_id,
	nvl(eue.ecomp_id,-1) as ecomp_id,
	reformat_datetime(eb.ejob_createtime) as ejob_createtime,
	eb.ejob_status,
	eb.ejob_focusflag,
	if(reformat_datetime(eb.ejob_createtime,'yyyy-MM-dd')>=date_sub(reformat_datetime('$date$','yyyy-MM-dd'),6),1,0) as is_day7_new_publish,
	datediff(reformat_datetime('$date$','yyyy-MM-dd'),reformat_datetime(eb.ejob_createtime,'yyyy-MM-dd')) as publish_days,
	eb.ejob_privacyreq as is_privacyreq,
	case 
		when ejob_hot_number=0 or ejob_hot_number is null then 0 
		when reformat_datetime(cast(ejob_hot_number as string),'yyyy-MM-dd')>=date_sub(reformat_datetime('$date$','yyyy-MM-dd'),6) then 1
		else 0
	end as is_in_hot,
	ceil(case when  cast(eb.ejob_monthlysalary_low * eb.ejob_salary_month as float) > 0 then cast(eb.ejob_monthlysalary_low * eb.ejob_salary_month as float) / 10 else  cast(ejob_salarylow as double) end ) as ejob_salarylow_new,
	ceil(case when  cast(eb.ejob_monthlysalary_high * eb.ejob_salary_month as float) > 0 then cast(eb.ejob_monthlysalary_high * eb.ejob_salary_month as float) / 10 else  cast(ejob_salaryhigh as double) end ) as ejob_salaryhigh_new,
	dq.d_ch_name as ejob_dq
from  ejob eb
left join ecomp_user eue
	on eb.user_id = eue.user_id
left join dim_dq dq
	on ifempty(get_first_code(eb.ejob_dq,',') , '999' ) = dq.d_code
) eb

join (
select ecomp_id,
	ecomp_root_id
from dw_b_d_ecomp_base 
	where p_date=$date$
		and ecomp_ver in (2,4)
) ep 
on eb.ecomp_id=ep.ecomp_id --精英版+精英过期版

left join (
select 
	ejob_id,
	count(case when status in ('0','1','3','5') then god_service_id end) as in_service_msk_cnt,
	count(case when reformat_datetime(launchtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),29) and reformat_datetime('$date$','yyyy-MM-dd') then god_service_id end) as day30_msk_service_cnt,
	count(case when reformat_datetime(launchtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),29) and reformat_datetime('$date$','yyyy-MM-dd') and is_takeorder='1' then god_service_id end) as day30_msk_takeorder_service_cnt, 
	count(case when reformat_datetime(launchtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),29) and reformat_datetime('$date$','yyyy-MM-dd') and is_showup='1' then god_service_id end) as day30_msk_showup_service_cnt, 
	count(case when reformat_datetime(launchtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),89) and reformat_datetime('$date$','yyyy-MM-dd') then god_service_id end) as day90_msk_service_cnt,
	count(case when reformat_datetime(launchtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),89) and reformat_datetime('$date$','yyyy-MM-dd') and is_takeorder='1' then god_service_id end) as day90_msk_takeorder_service_cnt, 
	count(case when reformat_datetime(launchtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),89) and reformat_datetime('$date$','yyyy-MM-dd') and is_showup='1' then god_service_id end) as day90_msk_showup_service_cnt, 
	count(case when reformat_datetime(launchtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),179) and reformat_datetime('$date$','yyyy-MM-dd') then god_service_id end) as day180_msk_service_cnt,
	count(case when reformat_datetime(launchtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),179) and reformat_datetime('$date$','yyyy-MM-dd') and is_takeorder='1' then god_service_id end) as day180_msk_takeorder_service_cnt, 
	count(case when reformat_datetime(launchtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),179) and reformat_datetime('$date$','yyyy-MM-dd') and is_showup='1' then god_service_id end) as day180_msk_showup_service_cnt, 
	count(case when reformat_datetime(launchtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),364) and reformat_datetime('$date$','yyyy-MM-dd') then god_service_id end) as day365_msk_service_cnt,
	count(case when reformat_datetime(launchtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),364) and reformat_datetime('$date$','yyyy-MM-dd') and is_takeorder='1' then god_service_id end) as day365_msk_takeorder_service_cnt, 
	count(case when reformat_datetime(launchtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),364) and reformat_datetime('$date$','yyyy-MM-dd') and is_showup='1' then god_service_id end) as day365_msk_showup_service_cnt, 
	count(god_service_id) as msk_service_cnt,
	count(case when is_takeorder='1' then god_service_id end) as msk_takeorder_service_cnt,
	count(case when is_showup='1' then god_service_id end) as msk_showup_service_cnt
from dw_god_d_msk_service 
where usere_kind = 0
	and p_date = $date$
group by ejob_id
) msk
on eb.ejob_id = msk.ejob_id --面试快

left join(
select 
	usere_id,
	count(god_service_id) as usere_used_msk_service_cnt
from dw_god_d_msk_service
	where usere_kind = 0
		and p_date=$date$
	group by usere_id
) umsk
on eb.usere_id = umsk.usere_id

left join (
select ejob_id,
	count(case when p_date=$date$ and reformat_datetime('$date$','yyyy-MM-dd') between start_time and end_time then urgent_id end) as is_in_urgent,
	count(distinct case when reformat_datetime(cast(p_date as string),'yyyy-MM-dd') = start_date then concat(ejob_id,start_date) end) as urgent_cnt
from dw_b_d_ejob_urgent 
	group by ejob_id
) urgt
on eb.ejob_id = urgt.ejob_id --急聘

left join (
select it.ejob_id,
		count(distinct case when reformat_datetime(it.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),6) and reformat_datetime('$date$','yyyy-MM-dd')  then track_task_id end) as day7_intention_submit_cnt,
		count(distinct case when reformat_datetime(it.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),29) and reformat_datetime('$date$','yyyy-MM-dd')  then track_task_id end) as day30_intention_submit_cnt,
		count(distinct case when reformat_datetime(it.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),29) and reformat_datetime('$date$','yyyy-MM-dd')   and (first_result  in ('高','中') or first_phone_result in ('0') or last_result in ('高','中') or last_phone_result in ('0')) then track_task_id end) as day30_intention_submit_valid_cnt,
		count(distinct case when reformat_datetime(it.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),89) and reformat_datetime('$date$','yyyy-MM-dd')  then track_task_id end) as day90_intention_submit_cnt,
		count(distinct case when reformat_datetime(it.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),89) and reformat_datetime('$date$','yyyy-MM-dd')   and (first_result  in ('高','中') or first_phone_result in ('0') or last_result in ('高','中') or last_phone_result in ('0')) then track_task_id end) as day90_intention_submit_valid_cnt,
		count(distinct case when reformat_datetime(it.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),179) and reformat_datetime('$date$','yyyy-MM-dd')  then track_task_id end) as day180_intention_submit_cnt,
		count(distinct case when reformat_datetime(it.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),179) and reformat_datetime('$date$','yyyy-MM-dd')   and (first_result  in ('高','中') or first_phone_result in ('0') or last_result in ('高','中') or last_phone_result in ('0')) then track_task_id end) as day180_intention_submit_valid_cnt,
		count(distinct case when reformat_datetime(it.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),364) and reformat_datetime('$date$','yyyy-MM-dd')  then track_task_id end) as day365_intention_submit_cnt,
		count(distinct case when reformat_datetime(it.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),364) and reformat_datetime('$date$','yyyy-MM-dd')   and (first_result  in ('高','中') or first_phone_result in ('0') or last_result in ('高','中') or last_phone_result in ('0')) then track_task_id end) as day365_intention_submit_valid_cnt,
		count(distinct case when reformat_datetime(it.createtime,'yyyyMMdd')<= $date$  then track_task_id end) as intention_submit_cnt,
		count(distinct case when reformat_datetime(it.createtime,'yyyyMMdd') <= $date$  and (first_result  in ('高','中') or first_phone_result in ('0') or last_result in ('高','中') or last_phone_result in ('0')) then track_task_id end) as intention_submit_valid_cnt
 from dw_b_a_intention_track it
	where  reformat_datetime(it.createtime,'yyyyMMdd')<='$date$'
	group by it.ejob_id
) inten
on eb.ejob_id = inten.ejob_id --意向沟通

left join (
select ejob_id,
	count(case when substr(liu_createtime,1,8)<=$date$ then liu_id end) as  invite_cnt,
	count(case when reformat_datetime(liu_createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),6) and reformat_datetime('$date$','yyyy-MM-dd') then liu_id end ) as day7_invite_cnt
from lpt_invite_userc
where substr(liu_createtime,1,8)<=$date$
group by ejob_id
) invite
on eb.ejob_id = invite.ejob_id --邀请应聘

left join(
select
	ja.ejob_id,
	count( distinct case when reformat_datetime(ja.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),6) and reformat_datetime('$date$','yyyy-MM-dd') and ur.appejob_id is null  then ja.apply_id  end) as day7_recv_cv_cnt,
	count( distinct case when reformat_datetime(jas.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),6) and reformat_datetime('$date$','yyyy-MM-dd')  and ur.appejob_id is null  and jas.status in (1,2,3,4,5) then ja.apply_id end) as day7_recv_deal_cv_cnt,
	count( distinct case when reformat_datetime(ja.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),29) and reformat_datetime('$date$','yyyy-MM-dd') and ur.appejob_id is null  then ja.apply_id  end) as day30_recv_cv_cnt,
	count( distinct case when reformat_datetime(jas.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),29) and reformat_datetime('$date$','yyyy-MM-dd') and ur.appejob_id is null and jas.status in (1,2,3,4,5) then ja.apply_id end) as day30_recv_deal_cv_cnt,
	count( distinct case when reformat_datetime(jas.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),29) and reformat_datetime('$date$','yyyy-MM-dd') and ur.appejob_id is null and jas.status in (2,3,5) then ja.apply_id end) as day30_recv_satisfied_cv_cnt,
	count( distinct case when reformat_datetime(ja.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),89) and reformat_datetime('$date$','yyyy-MM-dd') and ur.appejob_id is null  then ja.apply_id  end) as day90_recv_cv_cnt,
	count( distinct case when reformat_datetime(jas.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),89) and reformat_datetime('$date$','yyyy-MM-dd') and ur.appejob_id is null and jas.status in (1,2,3,4,5) then ja.apply_id end) as day90_recv_deal_cv_cnt,
	count( distinct case when reformat_datetime(jas.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),89) and reformat_datetime('$date$','yyyy-MM-dd') and ur.appejob_id is null and jas.status in (2,3,5) then ja.apply_id end) as day90_recv_satisfied_cv_cnt,
	count( distinct case when reformat_datetime(ja.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),179) and reformat_datetime('$date$','yyyy-MM-dd') and ur.appejob_id is null  then ja.apply_id  end) as day180_recv_cv_cnt,
	count( distinct case when reformat_datetime(jas.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),179) and reformat_datetime('$date$','yyyy-MM-dd') and ur.appejob_id is null and jas.status in (1,2,3,4,5) then ja.apply_id end) as day180_recv_deal_cv_cnt,
	count( distinct case when reformat_datetime(jas.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),179) and reformat_datetime('$date$','yyyy-MM-dd') and ur.appejob_id is null and jas.status in (2,3,5) then ja.apply_id end) as day180_recv_satisfied_cv_cnt,
	count( distinct case when reformat_datetime(ja.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),364) and reformat_datetime('$date$','yyyy-MM-dd') and ur.appejob_id is null  then ja.apply_id  end) as day365_recv_cv_cnt,
	count( distinct case when reformat_datetime(jas.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),364) and reformat_datetime('$date$','yyyy-MM-dd') and ur.appejob_id is null and jas.status in (1,2,3,4,5) then ja.apply_id end) as day365_recv_deal_cv_cnt,
	count( distinct case when reformat_datetime(jas.createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),364) and reformat_datetime('$date$','yyyy-MM-dd') and ur.appejob_id is null and jas.status in (2,3,5) then ja.apply_id end) as day365_recv_satisfied_cv_cnt,
	count( distinct case when reformat_datetime(ja.createtime,'yyyyMMdd') <= '$date$' and ur.appejob_id is null  then ja.apply_id  end) as recv_cv_cnt,
	count( distinct case when reformat_datetime(jas.createtime,'yyyyMMdd') <= '$date$' and ur.appejob_id is null and jas.status in (1,2,3,4,5) then ja.apply_id end) as recv_deal_cv_cnt,
	count( distinct case when reformat_datetime(jas.createtime,'yyyyMMdd') <= '$date$' and ur.appejob_id is null and jas.status in (2,3,5) then ja.apply_id end) as recv_satisfied_cv_cnt
from
	(select apply_id,
			job_id as ejob_id,
			res_id,
			user_id,
			createtime
	from job_apply
	where reformat_datetime(createtime,'yyyyMMdd') <= $date$
		and job_kind = 2) ja
left join job_apply_status jas
	on ja.apply_id = jas.apply_id
left join usere_recvapp ur
	on ja.ejob_id = ur.ejob_id
		and ja.res_id = ur.res_id
		and ja.user_id = ur.user_id
		and ur.appejob_category = 4
group by ja.ejob_id
) rcv --收到应聘
on eb.ejob_id = rcv.ejob_id

left join ( 
		select ejob_id,
		count(distinct case when substr(createtime,1,10) between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),6) and reformat_datetime('$date$','yyyy-MM-dd')  
								and source in (0) then res_id  end) as day7_rps_recmd_cv_cnt,
		count(distinct case when substr(createtime,1,10) between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),6) and reformat_datetime('$date$','yyyy-MM-dd')  
								and handletime between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),6) and reformat_datetime('$date$','yyyy-MM-dd')  
								and source in (0) then res_id else null end) as day7_rps_recmd_deal_cv_cnt,
		count(distinct case when substr(createtime,1,10) between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),6) and reformat_datetime('$date$','yyyy-MM-dd')  
								and handletime between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),6) and reformat_datetime('$date$','yyyy-MM-dd') 
								and source in (0) and feedback in ('2','4') then res_id else null end) as day7_rps_recmd_satisfied_cv_cnt
from dw_erp_d_ejob_candidate 
where p_date=$date$
	group by ejob_id
) recmd --简历推荐
	on eb.ejob_id = recmd.ejob_id

left join(
select ejob_id,
	count(res_id) as day7_download_cv_cnt
	from e_cv_download 
where ejob_id != 0
	and reformat_datetime(createtime,'yyyy-MM-dd') between date_sub(reformat_datetime('$date$','yyyy-MM-dd'),6) and reformat_datetime('$date$','yyyy-MM-dd')
group by ejob_id
) dn
	on eb.ejob_id = dn.ejob_id
	
left join dw_erp_d_customer_base cb
	on eb.ecomp_id=cb.ecomp_id
	and cb.p_date=$date$ 

left join user_e ue
	on eb.usere_id = ue.user_id
	
left join (
select ejob_id,
	ejob_similarity_key,
	concat('学历：',tend_edulevel) as tend_edulevel,
	concat('年龄：',tend_agelevel) as tend_agelevel,
	concat('工作年限：',tend_workyear) as tend_workyear,
	concat('年薪：',tend_want_yearsalary) as tend_want_yearsalary
from dw_erp_d_customer_report_ejob_ext 
where p_date=$date$
) ee
	on ee.ejob_id = eb.ejob_id
	
left join (
select ejob_similarity_key,
	count(god_service_id) as same_ejob_msk_success_cnt,
	round(count(case when consultant_type=0 then god_service_id end)/count(god_service_id),2)*100 as same_ejob_msk_rps_ratio,
	sum(case when consultant_type=1 then consultant_cnt else 0 end) as same_ejob_msk_consultant_cnt,
	round(sum(consume_days)/count(god_service_id),0) as avg_same_ejob_msk_success_days
from dw_god_d_jobtitle_success
	where p_date = $date$
	and ejob_similarity_key is not null
group by ejob_similarity_key
) samemsk
on ee.ejob_similarity_key = samemsk.ejob_similarity_key

left join (
select ms.usere_id,
	js.ejob_similarity_key,
	count(ms.god_service_id) as usere_same_ejob_msk_success_cnt
from dw_god_d_msk_service ms
join dw_god_d_jobtitle_success js
	on ms.god_service_id = js.god_service_id
		and js.p_date=$date$
where ms.usere_kind = 0
	and ms.p_date=$date$
group by ms.usere_id,
	js.ejob_similarity_key
) usmsk
on eb.usere_id = usmsk.usere_id
	and ee.ejob_similarity_key = usmsk.ejob_similarity_key
left join (
select job_id as ejob_id,
	sum(case when p_date = $date$ then pv else 0 end ) as view_cnt,
	sum(pv) as day7_view_cnt
from dw_log_d_job_traffic 
where job_kind = 2
and p_date between regexp_replace(date_sub(reformat_datetime('$date$','yyyy-MM-dd'),6),'-','') and '$date$'
group by job_id
) incrpv
on incrpv.ejob_id = eb.ejob_id
left join (
	select ejob_id,
		view_cnt
	from dw_erp_d_customer_report_ejob
	where p_date = regexp_replace(date_sub(reformat_datetime('$date$','yyyy-MM-dd'),1),'-','')
) pv
on pv.ejob_id = eb.ejob_id;