create table dw_erp_d_customer_target_report_main
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name string comment '客户名称',
ecomp_root_id int comment 'ecomp_root_id',
ecomp_id int comment 'ecomp_id',
company_scale string comment '公司规模',
company_kind string comment '公司性质',
industry_candidate_cnt int comment '同行业人才数',
industry_lpt_company_cnt int comment '同行业猎聘合作伙伴数',
industry_lpt_company_list string comment '同行业猎聘合作伙伴列表',
lpt_break_days int comment '猎聘通断约天数',
last_lpt_contract_money float comment '最后猎聘通合作合同金额',
cumu_contract_money float comment '历史累计合作金额',
cumu_lpt_service_days int comment '历史猎聘通合作时长',
cumu_contract_type_list string comment '历史合作合同类型',
is_in_rpo_project int comment '是否有未结项RPO',
cumu_ejob_cnt int comment '历史职位数',
ejob_avg_recv_cv_cnt int comment '职均投递数',
cumu_recv_cv_cnt  int comment '总投递',
cumu_recv_satisfied_cv_cnt int comment '投递满意数',
cumu_recv_satisfied_ratio float comment '投递满意数',
cumu_msk_service_cnt int comment '面试快次数',
cumu_msk_showup_ratio float comment '面试快到场率',
cumu_lost_opportunity_cnt int comment '累计失效商机个数',
cumu_lost_opportunity_money float comment '累计失效商机金额',
first_process_lost_opportunity string comment '失效商机最靠前的进程',
first_process_lost_opportunity_money string comment '失效商机最靠前的金额',
last_lost_opportunity_days int comment '最后失效商机创建距今天数',
last_lost_opportunity_type string comment '最后失效商机类型',
cumu_lost_opportunity_type_list string comment '所有失效商机类型',
day7_login_cnt int comment '近7天是否登陆猎聘',
day7_2_login_cnt int comment '近第2个7天是否登陆猎聘',
day7_3_login_cnt int comment '近第3个7天是否登陆猎聘',
day7_4_login_cnt int comment '近第4个7天是否登陆猎聘',
day7_5_login_cnt int comment '近第5个7天是否登陆猎聘',
day7_6_login_cnt int comment '近第6个7天是否登陆猎聘',
day7_7_login_cnt int comment '近第7个7天是否登陆猎聘',
day7_8_login_cnt int comment '近第8个7天是否登陆猎聘',
day7_9_login_cnt int comment '近第9个7天是否登陆猎聘',
day7_10_login_cnt int comment '近第10个7天是否登陆猎聘',
day7_11_login_cnt int comment '近第11个7天是否登陆猎聘',
day7_12_login_cnt int comment '近第12个7天是否登陆猎聘',
day7_13_login_cnt int comment '近第13个7天是否登陆猎聘',
day7_14_login_cnt int comment '近第14个7天是否登陆猎聘',
creation_timestamp timestamp comment '时间戳')
comment '非合作客户列表'
partitioned by (p_date int);

insert overwrite table dw_erp_d_customer_target_report_main partition (p_date = $date$)
select 
'$date$' as d_date,
cust.id as customer_id,
cust.name as customer_name,
cust.ecomp_root_id,
cust.ecomp_id,
cust.company_scale,
cust.company_kind,
nvl(industry_candidate_cnt,0) as industry_candidate_cnt,
nvl(industry_lpt_company_cnt,0) as industry_lpt_company_cnt,
nvl(ind_cust_list.industry_lpt_company_list,'未知') as industry_lpt_company_list,
nvl(lpt_break_days,0) as lpt_break_days,
nvl(last_lpt_contract_money,0) as last_lpt_contract_money,
nvl(cumu_contract_money,0) as cumu_contract_money,
nvl(cumu_lpt_service_days,0) as cumu_lpt_service_days,
nvl(cumu_contract_type_list,'未知') as cumu_contract_type_list,
case when rpo.customer_id is not null then 1 else 0 end as is_in_rpo_project,
nvl(cumu_ejob_cnt,0) as cumu_ejob_cnt,
nvl(cumu_recv_cv_cnt / cumu_ejob_cnt ,0) as ejob_avg_recv_cv_cnt,
nvl(cumu_recv_cv_cnt,0) as cumu_recv_cv_cnt,
nvl(cumu_recv_satisfied_cv_cnt,0) as cumu_recv_satisfied_cv_cnt,
nvl(cumu_recv_satisfied_cv_cnt / cumu_recv_cv_cnt ,0)  as cumu_recv_satisfied_ratio,
nvl(cumu_msk_service_cnt,0) as cumu_msk_service_cnt,
nvl(cumu_msk_service_showup_cnt / cumu_msk_takeorder_service_cnt ,0) as cumu_msk_showup_ratio,
nvl(cumu_lost_opportunity_cnt,0) as cumu_lost_opportunity_cnt,
nvl(cumu_lost_opportunity_money,0) as cumu_lost_opportunity_money,
nvl(first_process_lost_opportunity,0) as first_process_lost_opportunity,
nvl(first_process_lost_opportunity_money,0) as first_process_lost_opportunity_money,
nvl(last_lost_opportunity_days,0) as last_lost_opportunity_days,
nvl(last_lost_opportunity_type,'未知') as last_lost_opportunity_type,
nvl(cumu_lost_opportunity_type_list,'未知') as cumu_lost_opportunity_type_list,
nvl(day7_login_cnt,0) as day7_login_cnt,
nvl(day7_2_login_cnt,0) as day7_2_login_cnt,
nvl(day7_3_login_cnt,0) as day7_3_login_cnt,
nvl(day7_4_login_cnt,0) as day7_4_login_cnt,
nvl(day7_5_login_cnt,0) as day7_5_login_cnt,
nvl(day7_6_login_cnt,0) as day7_6_login_cnt,
nvl(day7_7_login_cnt,0) as day7_7_login_cnt,
nvl(day7_8_login_cnt,0) as day7_8_login_cnt,
nvl(day7_9_login_cnt,0) as day7_9_login_cnt,
nvl(day7_10_login_cnt,0) as day7_10_login_cnt,
nvl(day7_11_login_cnt,0) as day7_11_login_cnt,
nvl(day7_12_login_cnt,0) as day7_12_login_cnt,
nvl(day7_13_login_cnt,0) as day7_13_login_cnt,
nvl(day7_14_login_cnt,0) as day7_14_login_cnt,
current_timestamp as  creation_timestamp
from 
(select id,name,ecomp_root_id,ecomp_id,scale_enum.enum_name as  company_scale,kind_enum.enum_name as company_kind,industry,di.d_main_industry_code
from dw_erp_d_customer_base 
join dim_industry di
on industry = di.d_ind_code
left outer join 
(select enum_code,
		enum_name,
		row_number()over(distribute by enum_code sort by startdate desc) as rn 
   from pub_enum_list
  where src_table = 'customer'
   and is_default = 1
   and enum_type = 'company_scale') scale_enum
on company_scale = scale_enum.enum_code
and scale_enum.rn = 1
left outer join 
(select enum_code,
		enum_name,
		row_number()over(distribute by enum_code sort by startdate desc) as rn 
   from pub_enum_list
  where src_table = 'customer'
   and is_default = 1
   and enum_type = 'company_kind') kind_enum
on company_kind = kind_enum.enum_code
and kind_enum.rn = 1
where p_date = $date$
and ecomp_version not in (2,3)

) cust 
left join 
(select di.d_main_industry_code,count(1) as industry_candidate_cnt 
from dw_c_d_res_base res 
join dim_industry di
on res.c_industry = di.d_ind_code
where p_date = $date$
group by di.d_main_industry_code
) ind_res
on cust.d_main_industry_code = ind_res.d_main_industry_code
left join 
(select di.d_main_industry_code,count(1) as industry_lpt_company_cnt
	from dw_erp_d_customer_base cust 
	join dim_industry di 
	on cust.industry = di.d_ind_code
	where p_date = $date$
	and ecomp_version = 2
	group by di.d_main_industry_code
) ind_cust
on cust.d_main_industry_code = ind_cust.d_main_industry_code
left join 
(
	select d_main_industry_code,
			concat_ws(',',collect_set(name)) as industry_lpt_company_list
	from 
	(	select di.d_main_industry_code,
			cust.name,
			case company_scale when '080' then '051' else company_scale end as company_scale,
			row_number()over(distribute by di.d_main_industry_code sort  by case company_scale when '080' then '051' else company_scale end desc) as rn
		from dw_erp_d_customer_base cust 
		join dim_industry di 
		on cust.industry = di.d_ind_code
		where p_date = $date$
		and ecomp_version = 2
	) ind0 
	where rn <=10
	group by d_main_industry_code
) ind_cust_list
on cust.d_main_industry_code = ind_cust_list.d_main_industry_code
left join 
(
	select customer_id,
	   sum(case when contract_type = '猎聘通线上综合合同' and service_effect_date not in ('0','--','1900-01-01') and service_expired_date not in ('0','--','1900-01-01') then datediff(service_expired_date,service_effect_date) else 0 end) as cumu_lpt_service_days,
	   sum(case when contract_type = '猎聘通线上综合合同' and service_expired_date not in ('0','--','1900-01-01') then datediff(reformat_datetime('$date$','yyyy-MM-dd'),service_expired_date) else 0 end) as lpt_break_days,	
	   concat_ws(',',collect_set(contract_type)) as cumu_contract_type_list  
	from 
	(select customer_id,
			contract_type,
			min(service_effect_date) as service_effect_date ,
			max(service_expired_date) as service_expired_date
	   from dw_erp_d_contract_act
	  where p_date = $date$
	  group by customer_id,contract_type
	) contract0 
	group by customer_id
) contract 
on cust.id = contract.customer_id
left join 
(
	select customer_id,
			sum(income_money) as cumu_contract_money,
			sum(case when contract_type = '猎聘通线上综合合同' and rn = 1 then income_money else 0 end) as last_lpt_contract_money
	from 
	(	select customer_id,contract_id,contract_type,income_money,pay_time,
			   row_number()over(distribute by customer_id,contract_type sort by pay_time desc) as rn 
		  from (
			select  br.customer_id,br.contract_id,ca.contract_type,
					sum(bf.money) as income_money,
					max(bf.pay_time) as pay_time
			  from dw_erp_a_crmfinance_income bf
			  join crm_finance_receivables br 
				on bf.receivable_id = br.id 
				and br.deleteflag=0
			  join dw_erp_d_contract_act ca 
			  on br.contract_id = ca.contract_id
			  and ca.p_date = '$date$'
			group by br.customer_id,br.contract_id,ca.contract_type
		 ) income0
	) income1
	group by customer_id
) income
on cust.id = income.customer_id
left join 
(
	select get_first_code(customer_ids,',') as customer_id
	  from dw_god_d_rpo_project
	  where p_date = '$date$'
	   and status = 2
) rpo
on cust.id = rpo.customer_id
left join 
(select ecomp_root_id,
		count(ejob_id) as cumu_ejob_cnt,
		nvl(sum(get_json_object(cumu_recv_apply_cv,'$.cv_cnt')),0) + nvl(sum(get_json_object(cumu_recv_apply_lowcv,'$.lowcv_cnt')),0) as cumu_recv_cv_cnt ,
		nvl(sum(get_json_object(cumu_recv_apply_cv,'$.satisfied_cnt')),0) + nvl(sum(get_json_object(cumu_recv_apply_lowcv,'$.satisfied_cnt')),0) as cumu_recv_satisfied_cv_cnt 
   from dw_b_d_ejob_apply
  where p_date = $date$
  group by ecomp_root_id
) recv_apply 
on cust.ecomp_id = recv_apply.ecomp_root_id
left join 
(select customer_id,
		count(god_service_id) as cumu_msk_service_cnt,
		count(case when is_showup = 1 then god_service_id else null end) as cumu_msk_service_showup_cnt,
		count(case when is_takeorder = 1 then god_service_id else null end) as cumu_msk_takeorder_service_cnt
   from dw_god_d_msk_service
  where p_date = $date$
    and usere_kind = 0
  group by customer_id
) msk 
on cust.id = msk.customer_id
left join 
(
	
	select customer_id,
		count(id) as cumu_lost_opportunity_cnt,
		sum(money) as cumu_lost_opportunity_money,
		max(case when first_process_lost_rn = 1 then 
				(case process_status 
	 					when 9 then '取消'
	 					when 8 then '丢单'
	 					when 7 then '已回款'
	 					when 6 then '已开发票'
	 					when 5 then '已发合同'
	 					when 4 then '已发方案'
	 					when 3 then '有商机'
	 					when 2 then '需求客户'
	 					when 1 then '潜在客户'
	 					else '未知'
	 				end) else -1 end) as first_process_lost_opportunity,
		sum(case when first_process_lost_rn = 1 then money else 0 end) as first_process_lost_opportunity_money,
		max(case when last_lost_rn = 1 then lost_days else -1 end) as last_lost_opportunity_days,
		max(case when last_lost_rn = 1 then biz_category else '未知' end) as last_lost_opportunity_type,
		concat_ws(',',collect_set(biz_category)) as cumu_lost_opportunity_type_list
	from (
			select id,is_lost,process_status,finish_date,customer_id,money,biz_category,lost_days,
				   	row_number()over(distribute by customer_id sort by process_status) as first_process_lost_rn ,
				   	row_number()over(distribute by customer_id sort by lost_days ) as last_lost_rn 
			from 
			(	
			select opp.id,
				   case when actual_income_date in  ('0000-00-00','0--','0') and 
				   	 (datediff(reformat_datetime('$date$','yyyy-MM-dd'),substr(opp.createtime,1,10)) > 180 or 
				   	 	opp.creator_id <> cust.sales_user_id or 
				   	 	is_finish = 1
				   	 ) then 1 else 0 end as is_lost,
				   	 process_status,
				   	 money,
				   	 finish_date,
				   	 customer_id,
				   	 case biz_category  
                    	when 6 then '线上线下综合服务业务'
                    	when 5 then '诚猎通业务'
                    	when 4 then '校园业务'
                    	when 3 then 'RPO业务'
                    	when 2 then '猎聘通线上产品'
                    	when 1 then '白领业务'
                    	else '其他'
                    end as biz_category,
				   	 datediff(reformat_datetime('$date$','yyyy-MM-dd'),substr(opp.createtime,1,10)) as lost_days
			  from dw_erp_d_opportunity_base opp 
			  left join dw_erp_d_customer_base cust 
			  on opp.customer_id = cust.id 
			  and cust.p_date = '$date$'	  
			  where opp.p_date = '$date$'
			  ) opp0 
			where is_lost = 1
		) opp1
	group by customer_id
) opp 
on cust.id = opp.customer_id
left join 
(
	select ecomp_root_id,
		count(distinct case when p_date between {{delta(date,-6)}} and $date$ then p_date else null end) as day7_login_cnt,
		count(distinct case when p_date between {{delta(date,-13)}} and {{delta(date,-7)}}  then p_date else null end) as day7_2_login_cnt,
		count(distinct case when p_date between {{delta(date,-20)}} and {{delta(date,-14)}} then p_date else null end) as day7_3_login_cnt,
		count(distinct case when p_date between {{delta(date,-27)}} and {{delta(date,-21)}} then p_date else null end) as day7_4_login_cnt,      
		count(distinct case when p_date between {{delta(date,-34)}} and {{delta(date,-28)}} then p_date else null end) as day7_5_login_cnt,
		count(distinct case when p_date between {{delta(date,-41)}} and {{delta(date,-35)}} then p_date else null end) as day7_6_login_cnt,
		count(distinct case when p_date between {{delta(date,-48)}} and {{delta(date,-42)}} then p_date else null end) as day7_7_login_cnt,
		count(distinct case when p_date between {{delta(date,-55)}} and {{delta(date,-49)}} then p_date else null end) as day7_8_login_cnt,
		count(distinct case when p_date between {{delta(date,-62)}} and {{delta(date,-56)}} then p_date else null end) as day7_9_login_cnt,
		count(distinct case when p_date between {{delta(date,-69)}} and {{delta(date,-63)}} then p_date else null end) as day7_10_login_cnt,
		count(distinct case when p_date between {{delta(date,-76)}} and {{delta(date,-70)}} then p_date else null end) as day7_11_login_cnt,
		count(distinct case when p_date between {{delta(date,-83)}} and {{delta(date,-77)}} then p_date else null end) as day7_12_login_cnt,
		count(distinct case when p_date between {{delta(date,-90)}} and {{delta(date,-84)}} then p_date else null end) as day7_13_login_cnt,
		count(distinct case when p_date between {{delta(date,-97)}} and {{delta(date,-91)}} then p_date else null end) as day7_14_login_cnt
	from dw_b_d_usere_act
	where p_date between {{delta(date,-97)}} and $date$
	and is_login = 1
	group by ecomp_root_id
  ) login
on cust.ecomp_id = login.ecomp_root_id


create table dw_erp_d_customer_target_report_ejob
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name string comment '客户名称',
ejob_source string comment '渠道来源: 1-51job,2-智联招聘,3-中华英才网,4-拉勾网,-1-未知',
ejob_salary_level string comment '职位薪资水平: 0-未知,1-7W以下,2-7到10W,3-10W以上,-1-未知',
day180_ejob_cnt int comment '最近半年累计职位数',
day7_ejob_cnt int comment '近7天需求职位数',
day7_sr_ejob_cnt int comment '近7天优质需求职位数',
creation_timestamp timestamp comment '时间戳')
comment '非合作客户需求职位统计'
partitioned by (p_date int);

insert overwrite table dw_erp_d_customer_target_report_ejob partition (p_date = $date$)
select
	$date$ as d_date,
	cust.id as customer_id,
	cust.name as customer_name,
	behavior.ejob_source,
	behavior.ejob_salary_level,
	behavior.day180_ejob_cnt,
	behavior.day7_ejob_cnt,
	behavior.day7_sr_ejob_cnt,
	current_timestamp as creation_timestamp
from 
(select id,name,ecomp_root_id,ecomp_id,company_scale,company_kind,industry,di.d_main_industry_code
from dw_erp_d_customer_base 
join dim_industry di
on industry = di.d_ind_code
where p_date = $date$
and ecomp_version not in (2,3)
) cust 
join 
(	select
		hc.customer_id,
		cd.source as ejob_source,
		case when cd.job_salary_avg < 7 and cd.job_salary_avg > 0 then 1
		     when cd.job_salary_avg < 10 and cd.job_salary_avg >= 7 then 2
		     when cd.job_salary_avg >= 10 then 3
		else 0 end as ejob_salary_level,
		count(distinct unique_flag) as day180_ejob_cnt,
		count(distinct case when last_update_date between {{delta(date,-6)}} and '$date$' then unique_flag else null end) as day7_ejob_cnt,
		count(distinct case when last_update_date between {{delta(date,-6)}} and '$date$' and is_sr = 1 then job_title_new else null end) as day7_sr_ejob_cnt
	from 
	(select 
		hawkeye_customer_id,
		regexp_replace(job_title,'	','') as job_title,
		regexp_replace(regexp_replace(regexp_replace(regexp_replace(concat(job_title,dim_dq.d_ch_name),'\t',''),' ',''),'（','('),'）',')') as job_title_new,
		unique_flag,
		greatest(substr(job_publish_time,1,8),substr(job_modify_time,1,8)) as last_update_date,
		source,
		job_salary_high,
		job_salary_low,
		substr(job_publish_time,1,8) as job_publish_time,
		substr(job_modify_time,1,8) as job_modify_time,
		job_workyears,
		(job_salary_low + job_salary_high) / 2 as job_salary_avg,
		dim_dq.d_ch_name as ejob_dq,
		case 
			when job_level = 0 and not contains_any(job_title,'lianjia','班主任','包吃住','包食宿','包住','包住宿','毕业','不封顶','不误','不限经验','不要经验','才俊','储干','催收','贷款','导购','底薪','电话','电销','动销','房产精英','房屋租赁','分销','股票','管住','过万','会销','基金','激情','技工','家家顺','兼职','见习','讲师','交易岗','教练','教师','教务','接待','金融分析师','金融行情分析师','金融经理','金融精英','金融数据分析师','经纪人','客服','客户经理','客户拓展','老师','理想','链家','零基础','零经验','零售代表','买房买车','买手','没经验','美容','梦想','模特','内勤','你','平安','起薪','轻松','融资','入万','上万','摄影师','师傅','实训生','司机','提成','挑战','网络主播','网销','微商','无经验','无责','无责任','现货分析师','想法','想要','销讲','新人','信贷','信托','学徒','压力小','邀约','业务主管','一二手房','一手房','医药代表','有住宿','月入','招商','直销','助教','住房','住宿','转行','赚','咨询','自我','租赁','技师','金领','白领','蓝领','销售','管理培训','储备','实习','应届生','操盘手','交易员','顾问','公关','理财','业务经理','代理','合伙人','财富','客户代表','业务员','业务代表','渠道','管培','助理','秘书','案场','员','大学生','无需经验','毕业生','管理培训生') then 1
			when (dim_dq.d_ch_name  not in ('北京','上海','广州','深圳','杭州','天津','南京') and job_salary_low >= 7 ) and not contains_any(job_title,'lianjia','班主任','包吃住','包食宿','包住','包住宿','毕业','不封顶','不误','不限经验','不要经验','才俊','储干','催收','贷款','导购','底薪','电话','电销','动销','房产精英','房屋租赁','分销','股票','管住','过万','会销','基金','激情','技工','家家顺','兼职','见习','讲师','交易岗','教练','教师','教务','接待','金融分析师','金融行情分析师','金融经理','金融精英','金融数据分析师','经纪人','客服','客户经理','客户拓展','老师','理想','链家','零基础','零经验','零售代表','买房买车','买手','没经验','美容','梦想','模特','内勤','你','平安','起薪','轻松','融资','入万','上万','摄影师','师傅','实训生','司机','提成','挑战','网络主播','网销','微商','无经验','无责','无责任','现货分析师','想法','想要','销讲','新人','信贷','信托','学徒','压力小','邀约','业务主管','一二手房','一手房','医药代表','有住宿','月入','招商','直销','助教','住房','住宿','转行','赚','咨询','自我','租赁','技师','金领','白领','蓝领','销售','管理培训','储备','实习','应届生','操盘手','交易员','顾问','公关','理财','业务经理','代理','合伙人','财富','客户代表','业务员','业务代表','渠道','管培','助理','秘书','案场','员','大学生','无需经验','毕业生','管理培训生') then 1
			when contains_any(job_title,'COO','CTO','CDO','CEO','CFO','CHO','运营官','执行官','财务官','技术官','架构师','VP','人才官','厂长','行长','院长','校长','总经理','总裁','总工','总编','CIO',"CRO",'副总','专家','HRD','CSO','CMO','CEO','执行总经理','HRVP','负责人','首席','总监','董事') and not contains_any(job_title,'lianjia','班主任','包吃住','包食宿','包住','包住宿','毕业','不封顶','不误','不限经验','不要经验','才俊','储干','催收','贷款','导购','底薪','电话','电销','动销','房产精英','房屋租赁','分销','股票','管住','过万','会销','基金','激情','技工','家家顺','兼职','见习','讲师','交易岗','教练','教师','教务','接待','金融分析师','金融行情分析师','金融经理','金融精英','金融数据分析师','经纪人','客服','客户经理','客户拓展','老师','理想','链家','零基础','零经验','零售代表','买房买车','买手','没经验','美容','梦想','模特','内勤','你','平安','起薪','轻松','融资','入万','上万','摄影师','师傅','实训生','司机','提成','挑战','网络主播','网销','微商','无经验','无责','无责任','现货分析师','想法','想要','销讲','新人','信贷','信托','学徒','压力小','邀约','业务主管','一二手房','一手房','医药代表','有住宿','月入','招商','直销','助教','住房','住宿','转行','赚','咨询','自我','租赁','技师','金领','白领','蓝领','销售','管理培训','储备','实习','应届生','操盘手','交易员','顾问','公关','理财','业务经理','代理','合伙人','财富','客户代表','业务员','业务代表','渠道','管培','助理','秘书','案场','员','大学生','无需经验','毕业生','管理培训生') then 1
			when contains_any(job_title,'经理') and not contains_any(job_title,'lianjia','班主任','包吃住','包食宿','包住','包住宿','毕业','不封顶','不误','不限经验','不要经验','才俊','储干','催收','贷款','导购','底薪','电话','电销','动销','房产精英','房屋租赁','分销','股票','管住','过万','会销','基金','激情','技工','家家顺','兼职','见习','讲师','交易岗','教练','教师','教务','接待','金融分析师','金融行情分析师','金融经理','金融精英','金融数据分析师','经纪人','客服','客户经理','客户拓展','老师','理想','链家','零基础','零经验','零售代表','买房买车','买手','没经验','美容','梦想','模特','内勤','你','平安','起薪','轻松','融资','入万','上万','摄影师','师傅','实训生','司机','提成','挑战','网络主播','网销','微商','无经验','无责','无责任','现货分析师','想法','想要','销讲','新人','信贷','信托','学徒','压力小','邀约','业务主管','一二手房','一手房','医药代表','有住宿','月入','招商','直销','助教','住房','住宿','转行','赚','咨询','自我','租赁','技师','金领','白领','蓝领','销售','管理培训','储备','实习','应届生','操盘手','交易员','顾问','公关','理财','业务经理','代理','合伙人','财富','客户代表','业务员','业务代表','渠道','管培','助理','秘书','案场','员','大学生','无需经验','毕业生','管理培训生') then 1	
			when (job_title like '%大区%经理%' or job_title like '%区域%经理%' or job_title like '%总经理%' or job_title like '%总监%' or job_title like '%副总%') and not contains_any(job_title,'包吃住','包食宿','包住','包住宿','毕业','不封顶','不误','不限经验','不要经验','才俊','储干','底薪','管住','过万','激情','兼职','见习','理想','零基础','零经验','买房买车','没经验','梦想','你','起薪','轻松','入万','上万','师傅','实训生','提成','挑战','无经验','无责','无责任','想法','想要','新人','学徒','压力小','有住宿','月入','住房','住宿','转行','赚','自我','技师','金领','白领','蓝领','管理培训','储备','实习','应届生','管培','助理','秘书','员','大学生','无需经验','毕业生','管理培训生') then 1 				
		end as is_sr
	from customer_dynamic
	left join dim_dq 
	on job_dq = dim_dq.d_code
	where deleteflag = 0
	  and greatest(substr(job_publish_time,1,8),substr(job_modify_time,1,8)) between {{delta(date,-180)}} and '$date$'
	) cd
	left outer join (select id,customer_id from hawkeye_customer where deleteflag = 0) hc 
	on cd.hawkeye_customer_id = hc.id
	group by hc.customer_id,cd.source,
			case when cd.job_salary_avg < 7 and cd.job_salary_avg > 0 then 1
			     when cd.job_salary_avg < 10 and cd.job_salary_avg >= 7 then 2
			     when cd.job_salary_avg >= 10 then 3
			else 0 end 
) behavior
on cust.id = behavior.customer_id




create table dw_erp_d_customer_target_report_ejob_sr_detail
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name string comment '客户名称',
ejob_desc string comment '优质职位',
ejob_source string comment '渠道来源: 1-51job,2-智联招聘,3-中华英才网,4-拉勾网',
ejob_salary string comment '职位薪资',
ejob_dq string comment '职位地区',
work_year string  comment '工作年限',
publish_days int comment '已发布天数',
last_refresh_days int comment '距最后刷新天数',
creation_timestamp timestamp comment '时间戳')
comment '非合作客户优质需求明细'
partitioned by (p_date int);


insert overwrite table dw_erp_d_customer_target_report_ejob_sr_detail partition (p_date = $date$)
select
	$date$ as d_date,	
	cust.id as customer_id,
	cust.name as customer_name,
	behavior.ejob_desc,
	behavior.ejob_source,
	behavior.ejob_salary,
	behavior.ejob_dq,
	behavior.work_year,
	behavior.publish_days,
	behavior.last_refresh_days,
	current_timestamp as creation_timestamp
from 
(select id,name,ecomp_root_id,ecomp_id,company_scale,company_kind,industry,di.d_main_industry_code
from dw_erp_d_customer_base 
join dim_industry di
on industry = di.d_ind_code
where p_date = $date$
and ecomp_version not in (2,3)
) cust 
join 
(	select customer_id,ejob_desc,ejob_source,ejob_salary,ejob_dq,work_year,publish_days,last_refresh_days
	  from 
		(select
				hc.customer_id,
				cd.ejob_desc,
				cd.source as ejob_source,
				cd.job_salary as  ejob_salary,
				cd.ejob_dq,
				cd.job_workyears as work_year,
				cd.publish_days,
				cd.last_refresh_days,
				row_number()over(distribute by job_title_new sort by is_sr desc,unique_flag) as rn	
			from 
			(select 
				hawkeye_customer_id,
				regexp_replace(job_title,'	','') as job_title,
				regexp_replace(regexp_replace(regexp_replace(regexp_replace(concat(job_title),'\t',''),' ',''),'（','('),'）',')') as ejob_desc,
				regexp_replace(regexp_replace(regexp_replace(regexp_replace(concat(job_title,dim_dq.d_ch_name),'\t',''),' ',''),'（','('),'）',')') as job_title_new,
				unique_flag,
				greatest(substr(job_publish_time,1,8),substr(job_modify_time,1,8)) as last_update_date,
				datediff(reformat_datetime('$date$','yyyy-MM-dd'),reformat_datetime(substr(job_publish_time,1,8),'yyyy-MM-dd')) as publish_days,
				datediff(reformat_datetime('$date$','yyyy-MM-dd'),reformat_datetime(substr(job_modify_time,1,8),'yyyy-MM-dd')) as last_refresh_days,
				source,
				job_salary,
				job_salary_high,
				job_salary_low,
				substr(job_publish_time,1,8) as job_publish_time,
				substr(job_modify_time,1,8) as job_modify_time,
				job_workyears,
				(job_salary_low + job_salary_high) / 2 as job_salary_avg,
				dim_dq.d_ch_name as ejob_dq,
				case 
					when job_level = 0 and not contains_any(job_title,'lianjia','班主任','包吃住','包食宿','包住','包住宿','毕业','不封顶','不误','不限经验','不要经验','才俊','储干','催收','贷款','导购','底薪','电话','电销','动销','房产精英','房屋租赁','分销','股票','管住','过万','会销','基金','激情','技工','家家顺','兼职','见习','讲师','交易岗','教练','教师','教务','接待','金融分析师','金融行情分析师','金融经理','金融精英','金融数据分析师','经纪人','客服','客户经理','客户拓展','老师','理想','链家','零基础','零经验','零售代表','买房买车','买手','没经验','美容','梦想','模特','内勤','你','平安','起薪','轻松','融资','入万','上万','摄影师','师傅','实训生','司机','提成','挑战','网络主播','网销','微商','无经验','无责','无责任','现货分析师','想法','想要','销讲','新人','信贷','信托','学徒','压力小','邀约','业务主管','一二手房','一手房','医药代表','有住宿','月入','招商','直销','助教','住房','住宿','转行','赚','咨询','自我','租赁','技师','金领','白领','蓝领','销售','管理培训','储备','实习','应届生','操盘手','交易员','顾问','公关','理财','业务经理','代理','合伙人','财富','客户代表','业务员','业务代表','渠道','管培','助理','秘书','案场','员','大学生','无需经验','毕业生','管理培训生') then 1
					when (dim_dq.d_ch_name  not in ('北京','上海','广州','深圳','杭州','天津','南京') and job_salary_low >= 7 ) and not contains_any(job_title,'lianjia','班主任','包吃住','包食宿','包住','包住宿','毕业','不封顶','不误','不限经验','不要经验','才俊','储干','催收','贷款','导购','底薪','电话','电销','动销','房产精英','房屋租赁','分销','股票','管住','过万','会销','基金','激情','技工','家家顺','兼职','见习','讲师','交易岗','教练','教师','教务','接待','金融分析师','金融行情分析师','金融经理','金融精英','金融数据分析师','经纪人','客服','客户经理','客户拓展','老师','理想','链家','零基础','零经验','零售代表','买房买车','买手','没经验','美容','梦想','模特','内勤','你','平安','起薪','轻松','融资','入万','上万','摄影师','师傅','实训生','司机','提成','挑战','网络主播','网销','微商','无经验','无责','无责任','现货分析师','想法','想要','销讲','新人','信贷','信托','学徒','压力小','邀约','业务主管','一二手房','一手房','医药代表','有住宿','月入','招商','直销','助教','住房','住宿','转行','赚','咨询','自我','租赁','技师','金领','白领','蓝领','销售','管理培训','储备','实习','应届生','操盘手','交易员','顾问','公关','理财','业务经理','代理','合伙人','财富','客户代表','业务员','业务代表','渠道','管培','助理','秘书','案场','员','大学生','无需经验','毕业生','管理培训生') then 1
					when contains_any(job_title,'COO','CTO','CDO','CEO','CFO','CHO','运营官','执行官','财务官','技术官','架构师','VP','人才官','厂长','行长','院长','校长','总经理','总裁','总工','总编','CIO',"CRO",'副总','专家','HRD','CSO','CMO','CEO','执行总经理','HRVP','负责人','首席','总监','董事') and not contains_any(job_title,'lianjia','班主任','包吃住','包食宿','包住','包住宿','毕业','不封顶','不误','不限经验','不要经验','才俊','储干','催收','贷款','导购','底薪','电话','电销','动销','房产精英','房屋租赁','分销','股票','管住','过万','会销','基金','激情','技工','家家顺','兼职','见习','讲师','交易岗','教练','教师','教务','接待','金融分析师','金融行情分析师','金融经理','金融精英','金融数据分析师','经纪人','客服','客户经理','客户拓展','老师','理想','链家','零基础','零经验','零售代表','买房买车','买手','没经验','美容','梦想','模特','内勤','你','平安','起薪','轻松','融资','入万','上万','摄影师','师傅','实训生','司机','提成','挑战','网络主播','网销','微商','无经验','无责','无责任','现货分析师','想法','想要','销讲','新人','信贷','信托','学徒','压力小','邀约','业务主管','一二手房','一手房','医药代表','有住宿','月入','招商','直销','助教','住房','住宿','转行','赚','咨询','自我','租赁','技师','金领','白领','蓝领','销售','管理培训','储备','实习','应届生','操盘手','交易员','顾问','公关','理财','业务经理','代理','合伙人','财富','客户代表','业务员','业务代表','渠道','管培','助理','秘书','案场','员','大学生','无需经验','毕业生','管理培训生') then 1
					when contains_any(job_title,'经理') and not contains_any(job_title,'lianjia','班主任','包吃住','包食宿','包住','包住宿','毕业','不封顶','不误','不限经验','不要经验','才俊','储干','催收','贷款','导购','底薪','电话','电销','动销','房产精英','房屋租赁','分销','股票','管住','过万','会销','基金','激情','技工','家家顺','兼职','见习','讲师','交易岗','教练','教师','教务','接待','金融分析师','金融行情分析师','金融经理','金融精英','金融数据分析师','经纪人','客服','客户经理','客户拓展','老师','理想','链家','零基础','零经验','零售代表','买房买车','买手','没经验','美容','梦想','模特','内勤','你','平安','起薪','轻松','融资','入万','上万','摄影师','师傅','实训生','司机','提成','挑战','网络主播','网销','微商','无经验','无责','无责任','现货分析师','想法','想要','销讲','新人','信贷','信托','学徒','压力小','邀约','业务主管','一二手房','一手房','医药代表','有住宿','月入','招商','直销','助教','住房','住宿','转行','赚','咨询','自我','租赁','技师','金领','白领','蓝领','销售','管理培训','储备','实习','应届生','操盘手','交易员','顾问','公关','理财','业务经理','代理','合伙人','财富','客户代表','业务员','业务代表','渠道','管培','助理','秘书','案场','员','大学生','无需经验','毕业生','管理培训生') then 1	
					when (job_title like '%大区%经理%' or job_title like '%区域%经理%' or job_title like '%总经理%' or job_title like '%总监%' or job_title like '%副总%') and not contains_any(job_title,'包吃住','包食宿','包住','包住宿','毕业','不封顶','不误','不限经验','不要经验','才俊','储干','底薪','管住','过万','激情','兼职','见习','理想','零基础','零经验','买房买车','没经验','梦想','你','起薪','轻松','入万','上万','师傅','实训生','提成','挑战','无经验','无责','无责任','想法','想要','新人','学徒','压力小','有住宿','月入','住房','住宿','转行','赚','自我','技师','金领','白领','蓝领','管理培训','储备','实习','应届生','管培','助理','秘书','员','大学生','无需经验','毕业生','管理培训生') then 1 				
				end as is_sr
			from customer_dynamic
			left join dim_dq 
			on job_dq = dim_dq.d_code
			where deleteflag = 0
			  and greatest(substr(job_publish_time,1,8),substr(job_modify_time,1,8)) between {{delta(date,-6)}} and '$date$'
			) cd
			join (select id,customer_id from hawkeye_customer where deleteflag = 0) hc 
			on cd.hawkeye_customer_id = hc.id
			where cd.is_sr = 1
		  ) sr where rn = 1
) behavior
on cust.id = behavior.customer_id


create table dw_erp_d_customer_target_report_ejob_cnt
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name string comment '客户名称',
day180_ejob_cnt int comment '最近半年累计职位数',
day7_ejob_cnt int comment '近7天需求职位数',
day7_sr_ejob_cnt int comment '近7天优质需求职位数',
creation_timestamp timestamp comment '时间戳')
comment '非合作客户需求职位统计'
partitioned by (p_date int);











create table dw_erp_a_customer_target_report_main
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name string comment '客户名称',
ecomp_root_id int comment 'ecomp_root_id',
ecomp_id int comment 'ecomp_id',
company_scale string comment '公司规模',
company_kind string comment '公司性质',
industry_candidate_cnt int comment '同行业人才数',
industry_lpt_company_cnt int comment '同行业猎聘合作伙伴数',
industry_lpt_company_list string comment '同行业猎聘合作伙伴列表',
lpt_break_days int comment '猎聘通断约天数',
last_lpt_contract_money float comment '最后猎聘通合作合同金额',
cumu_contract_money float comment '历史累计合作金额',
cumu_lpt_service_days int comment '历史猎聘通合作时长',
cumu_contract_type_list string comment '历史合作合同类型',
is_in_rpo_project int comment '是否有未结项RPO',
cumu_ejob_cnt int comment '历史职位数',
ejob_avg_recv_cv_cnt int comment '职均投递数',
cumu_recv_cv_cnt  int comment '总投递',
cumu_recv_satisfied_cv_cnt int comment '投递满意数',
cumu_recv_satisfied_ratio float comment '投递满意数',
cumu_msk_service_cnt int comment '面试快次数',
cumu_msk_showup_ratio float comment '面试快到场率',
cumu_lost_opportunity_cnt int comment '累计失效商机个数',
cumu_lost_opportunity_money float comment '累计失效商机金额',
first_process_lost_opportunity string comment '失效商机最靠前的进程',
first_process_lost_opportunity_money string comment '失效商机最靠前的金额',
last_lost_opportunity_days int comment '最后失效商机创建距今天数',
last_lost_opportunity_type string comment '最后失效商机类型',
cumu_lost_opportunity_type_list string comment '所有失效商机类型',
day7_login_cnt int comment '近7天是否登陆猎聘',
day7_2_login_cnt int comment '近第2个7天是否登陆猎聘',
day7_3_login_cnt int comment '近第3个7天是否登陆猎聘',
day7_4_login_cnt int comment '近第4个7天是否登陆猎聘',
day7_5_login_cnt int comment '近第5个7天是否登陆猎聘',
day7_6_login_cnt int comment '近第6个7天是否登陆猎聘',
day7_7_login_cnt int comment '近第7个7天是否登陆猎聘',
day7_8_login_cnt int comment '近第8个7天是否登陆猎聘',
day7_9_login_cnt int comment '近第9个7天是否登陆猎聘',
day7_10_login_cnt int comment '近第10个7天是否登陆猎聘',
day7_11_login_cnt int comment '近第11个7天是否登陆猎聘',
day7_12_login_cnt int comment '近第12个7天是否登陆猎聘',
day7_13_login_cnt int comment '近第13个7天是否登陆猎聘',
day7_14_login_cnt int comment '近第14个7天是否登陆猎聘',
creation_timestamp timestamp comment '时间戳')
comment '非合作客户列表';

insert overwrite table dw_erp_a_customer_target_report_main
select d_date
, customer_id
, customer_name
, ecomp_root_id
, ecomp_id
, company_scale
, company_kind
, industry_candidate_cnt
, industry_lpt_company_cnt
, industry_lpt_company_list
, lpt_break_days
, last_lpt_contract_money
, cumu_contract_money
, cumu_lpt_service_days
, cumu_contract_type_list
, is_in_rpo_project
, cumu_ejob_cnt
, ejob_avg_recv_cv_cnt
, cumu_recv_cv_cnt
, cumu_recv_satisfied_cv_cnt
, cumu_recv_satisfied_ratio
, cumu_msk_service_cnt
, cumu_msk_showup_ratio
, cumu_lost_opportunity_cnt
, cumu_lost_opportunity_money
, first_process_lost_opportunity
, first_process_lost_opportunity_money
, last_lost_opportunity_days
, last_lost_opportunity_type
, cumu_lost_opportunity_type_list
, day7_login_cnt
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
, current_timestamp as creation_timestamp
from dw_erp_d_customer_target_report_main
where p_date = $date$

create table dw_erp_a_customer_target_report_ejob
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name string comment '客户名称',
ejob_source string comment '渠道来源',
ejob_salary_level string comment '职位薪资水平',
day180_ejob_cnt int comment '最近半年累计职位数',
day7_ejob_cnt int comment '近7天需求职位数',
day7_sr_ejob_cnt int comment '近7天优质需求职位数',
creation_timestamp timestamp comment '时间戳')
comment '非合作客户需求职位统计';


create table dw_erp_a_customer_target_report_ejob_sr_detail
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name string comment '客户名称',
ejob_desc string comment '优质职位',
ejob_source string comment '渠道来源',
ejob_salary string comment '职位薪资水平',
ejob_dq string comment '职位地区',
work_year string  comment '工作年限',
publish_days int comment '已发布天数',
last_refresh_days int comment '距最后刷新天数',
creation_timestamp timestamp comment '时间戳')
comment '非合作客户优质需求明细';



create table dw_erp_a_customer_target_report_main
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name varchar(200) comment '客户名称',
ecomp_root_id int comment 'ecomp_root_id',
ecomp_id int comment 'ecomp_id',
company_scale varchar(200) comment '公司规模',
company_kind varchar(200) comment '公司性质',
industry_candidate_cnt int comment '同行业人才数',
industry_lpt_company_cnt int comment '同行业猎聘合作伙伴数',
industry_lpt_company_list varchar(200) comment '同行业猎聘合作伙伴列表',
lpt_break_days int comment '猎聘通断约天数',
last_lpt_contract_money float comment '最后猎聘通合作合同金额',
cumu_contract_money float comment '历史累计合作金额',
cumu_lpt_service_days int comment '历史猎聘通合作时长',
cumu_contract_type_list varchar(200) comment '历史合作合同类型',
is_in_rpo_project int comment '是否有未结项RPO',
cumu_ejob_cnt int comment '历史职位数',
ejob_avg_recv_cv_cnt int comment '职均投递数',
cumu_recv_cv_cnt  int comment '总投递',
cumu_recv_satisfied_cv_cnt int comment '投递满意数',
cumu_recv_satisfied_ratio float comment '投递满意数',
cumu_msk_service_cnt int comment '面试快次数',
cumu_msk_showup_ratio float comment '面试快到场率',
cumu_lost_opportunity_cnt int comment '累计失效商机个数',
cumu_lost_opportunity_money float comment '累计失效商机金额',
first_process_lost_opportunity varchar(200) comment '失效商机最靠前的进程',
first_process_lost_opportunity_money varchar(200) comment '失效商机最靠前的金额',
last_lost_opportunity_days int comment '最后失效商机创建距今天数',
last_lost_opportunity_type varchar(200) comment '最后失效商机类型',
cumu_lost_opportunity_type_list varchar(200) comment '所有失效商机类型',
day7_login_cnt int comment '近7天是否登陆猎聘',
day7_2_login_cnt int comment '近第2个7天是否登陆猎聘',
day7_3_login_cnt int comment '近第3个7天是否登陆猎聘',
day7_4_login_cnt int comment '近第4个7天是否登陆猎聘',
day7_5_login_cnt int comment '近第5个7天是否登陆猎聘',
day7_6_login_cnt int comment '近第6个7天是否登陆猎聘',
day7_7_login_cnt int comment '近第7个7天是否登陆猎聘',
day7_8_login_cnt int comment '近第8个7天是否登陆猎聘',
day7_9_login_cnt int comment '近第9个7天是否登陆猎聘',
day7_10_login_cnt int comment '近第10个7天是否登陆猎聘',
day7_11_login_cnt int comment '近第11个7天是否登陆猎聘',
day7_12_login_cnt int comment '近第12个7天是否登陆猎聘',
day7_13_login_cnt int comment '近第13个7天是否登陆猎聘',
day7_14_login_cnt int comment '近第14个7天是否登陆猎聘',
creation_timestamp timestamp default current_timestamp comment '时间戳',
primary key (d_date,customer_id)
)
comment '非合作客户列表';



create table dw_erp_a_customer_target_report_ejob
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name varchar(200) comment '客户名称',
ejob_source varchar(20) comment '渠道来源',
ejob_salary_level varchar(20) comment '职位薪资水平',
day180_ejob_cnt int comment '最近半年累计职位数',
day7_ejob_cnt int comment '近7天需求职位数',
day7_sr_ejob_cnt int comment '近7天优质需求职位数',
creation_timestamp timestamp default current_timestamp comment '时间戳',
primary key (d_date,customer_id,ejob_source,ejob_salary_level)
)
comment '非合作客户需求职位统计';

insert overwrite table dw_erp_a_customer_target_report_ejob
select d_date
, customer_id
, customer_name
, ejob_source
, ejob_salary_level
, day180_ejob_cnt
, day7_ejob_cnt
, day7_sr_ejob_cnt
, current_timestamp as creation_timestamp
from dw_erp_d_customer_target_report_ejob
where p_date = $date$;



create table dw_erp_a_customer_target_report_ejob_sr_detail
(
d_date int comment '统计日期',
customer_id int comment '客户ID',
customer_name varchar(200) comment '客户名称',
ejob_desc varchar(200) comment '优质职位',
ejob_source varchar(20) comment '渠道来源',
ejob_salary varchar(20) comment '职位薪资水平',
ejob_dq varchar(20) comment '职位地区',
work_year varchar(20)  comment '工作年限',
publish_days int comment '已发布天数',
last_refresh_days int comment '距最后刷新天数',
creation_timestamp timestamp default current_timestamp comment '时间戳',
primary key (d_date,customer_id,ejob_desc)
)
comment '非合作客户优质需求明细';

insert overwrite table dw_erp_a_customer_target_report_ejob_sr_detail
select d_date
, customer_id
, customer_name
, ejob_desc
, ejob_source
, ejob_salary
, ejob_dq
, work_year
, publish_days
, last_refresh_days
, current_timestamp as creation_timestamp
from dw_erp_d_customer_target_report_ejob_sr_detail
where p_date = $date$;