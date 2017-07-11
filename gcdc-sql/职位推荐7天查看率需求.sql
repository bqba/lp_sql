
--职位推荐七天查看率 线下需求
select can.serviceuser_id,can.serviceuser_name,can.org_name,suser.position_name,
count(case when can.source = 4 and datediff(can.readtime,can.createtime) between 0 and 7  then res_id else null end) as bole_recom_cnt_7day,
count(case when can.source = 4 then res_id else null end) as bole_recom_cnt,
count(case when can.source = 4 and datediff(can.readtime,can.createtime) between 0 and 7  then res_id else null end) / count(case when can.source = 4 then res_id else null end) as bole_day7_ration,
count(case when can.source = 0 and datediff(can.readtime,can.createtime) between 0 and 7  then res_id else null end) as rps_recom_cnt_7day,
count(case when can.source = 0 then res_id else null end) as rps_recom_cnt,
count(case when can.source = 0 and datediff(can.readtime,can.createtime) between 0 and 7  then res_id else null end) / count(case when can.source = 0 then res_id else null end) as rps_day7_ration
from dw_erp_d_ejob_candidate can 
join dw_erp_d_salesuser_base suser 
on can.serviceuser_id = suser.id 
and suser.p_date = 20170216
where can.p_date = 20170216 
and substr(can.createtime,1,10) between '2017-02-04' and '2017-02-10'
group by can.serviceuser_id,can.serviceuser_name,can.org_name,suser.position_name;

--职位推荐新口径，取推荐发起时客户所属的招服
select  ub.id,ub.name,ub.org_name,ub.position_name,
		count(case when can.source = 4 and datediff(can.readtime,can.createtime) between 0 and 7  then res_id else null end) as bole_recom_cnt_7day,
		count(case when can.source = 4 then res_id else null end) as bole_recom_cnt,
		count(case when can.source = 4 and datediff(can.readtime,can.createtime) between 0 and 7  then res_id else null end) / count(case when can.source = 4 then res_id else null end) as bole_day7_ration,
		count(case when can.source = 0 and datediff(can.readtime,can.createtime) between 0 and 7  then res_id else null end) as rps_recom_cnt_7day,
		count(case when can.source = 0 then res_id else null end) as rps_recom_cnt,
		count(case when can.source = 0 and datediff(can.readtime,can.createtime) between 0 and 7  then res_id else null end) / count(case when can.source = 0 then res_id else null end) as rps_day7_ration
from dw_erp_d_ejob_candidate can 
join (select p_date,
			id,
			serviceuser_id,
			serviceuser_name,
			service_teamorg_name 
	   from dw_erp_d_customer_base 
	  where p_date between '20170201' and '20170228'
	) cb
on cb.id = can.customer_id
and cb.p_date = regexp_replace(substr(can.createtime,1,10),'-','')
join (
	select  p_date,
			id,name,org_name,
			position_name 
	 from dw_erp_d_salesuser_base 
	where p_date between '20170201' and '20170228'
) ub
on cb.serviceuser_id = ub.id
and ub.p_date=regexp_replace(substr(can.createtime,1,10),'-','')
where can.p_date = '20170308' 
and substr(regexp_replace(can.createtime,'-',''),1,8) between '20170201' and '20170228'
and can.source in (0,4)
group by ub.id,ub.name,ub.org_name,ub.position_name;




select 
cb.name as customer_name,can.ejob_id,can.job_title,can.res_id,ub.id,ub.name as user_name,can.createtime,can.readtime,
case when datediff(can.readtime,can.createtime) between 0 and 7  then 1 else 0 end as is_read_flag_7days,
can.readflag,
from dw_erp_d_ejob_candidate can 
join (select p_date,
			id,
			name,
			serviceuser_id,
			serviceuser_name,
			service_teamorg_name 
	   from dw_erp_d_customer_base 
	  where p_date between '20170201' and '20170228'
	) cb
on cb.id = can.customer_id
and cb.p_date = regexp_replace(substr(can.createtime,1,10),'-','')
join (
	select  p_date,
			id,name,org_name,
			position_name 
	 from dw_erp_d_salesuser_base 
	where p_date between '20170201' and '20170228'
) ub
on cb.serviceuser_id = ub.id
and ub.p_date=regexp_replace(substr(can.createtime,1,10),'-','')
where can.p_date = '20170228' 
and substr(regexp_replace(can.createtime,'-',''),1,8) between '20170201' and '20170228'
and can.source = 0
and ub.name in ('侯婧','刘奥','何叶繁');


select substr(regexp_replace(log.createtime,'-',''),1,6) as d_month,      
	   count(case when log.intention_type = 0 and log.demand_concat_result =4 then log.id 
				 when log.intention_type = 0 and log.demand_concat_result <> 4 then null
				 when log.intention_type in (1,2) and log.result = 6 then log.id 
				 when log.intention_type in (1,2) and log.result <> 6 then null
				 else null end) as intention_c_invalid_track_cnt
	from rsc_intention_task_c log 
	join dw_erp_d_customer_base customer  
	  on log.customer_id = customer.id
	 and customer.p_date = '20161231'
	 and customer.industry in ('4','130','140','150','430','500')
   where log.deleteflag = 0
	 and log.intention_type in (0,1,2)
	 and log.status = 4
	 and substr(regexp_replace(log.createtime,'-',''),1,4) = '2016'
	 group by substr(regexp_replace(log.createtime,'-',''),1,6);


--head:"招服ID    招服顾问    所属团队    招服岗位    类型  推荐简历数   推荐简历处理数 满意并下载数  满意并发起意向数    不满意数"


select 
recmd.serviceuser_id,
recmd.serviceuser_name,
recmd.service_teamorg_name,
recmd.position_name,
recmd.source,
recmd.recmd_cnt,
recmd.recmd_handle_cnt,
recmd.recmd_satisfied_download_cnt,
recmd.recmd_satisfied_intention_cnt,
recmd.recmd_unsatisfied_cnt
from (
	select 
		if(ec.source=0,ec.serviceuser_id,cb.serviceuser_id) as serviceuser_id,
		if(ec.source=0,ec.serviceuser_name,cb.serviceuser_name) as serviceuser_name,
		if(ec.source=0,ec.org_name,cb.service_teamorg_name) as service_teamorg_name,
		nvl(ub.position_name,'未知') as position_name,
		case 
			when ec.source = 0 then '人工推荐'
			when ec.source=4 then '伯乐推荐'
		end as source,
		count(distinct ec.res_id) as recmd_cnt,
		count(distinct case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20170101 and 20170206
						then ec.res_id 
				  end) as recmd_handle_cnt,
		count(distinct case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20170101 and 20170206
							and feedback in (4)
						then ec.res_id 
				  end) as recmd_satisfied_download_cnt,
		count(distinct case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20170101 and 20170206
							and feedback in (2,5)
						then ec.res_id 
				  end) as recmd_satisfied_intention_cnt,
		count(distinct case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20170101 and 20170206
							and feedback in (6,9)
						then ec.res_id 
				  end) as recmd_unsatisfied_cnt
	from dw_erp_d_ejob_candidate ec
	join (
		select p_date,
			id,
			serviceuser_id,
			serviceuser_name,
			service_teamorg_name 
		from dw_erp_d_customer_base 
		where p_date between 20170101 and 20170131
		) cb
		on cb.id = ec.customer_id
			and cb.p_date = regexp_replace(substr(ec.createtime,1,10),'-','')
	left join (
		select p_date,
			id,
			position_name 
		from dw_erp_d_salesuser_base 
		where p_date between 20170101 and 20170131
		) ub
	on cb.serviceuser_id = ub.id
	and ub.p_date=regexp_replace(substr(ec.createtime,1,10),'-','')
	where regexp_replace(substr(ec.createtime,1,10),'-','') between 20170101 and 20170131
		and ec.p_date=20170207
		and ec.source in (0,4)
		group by if(ec.source=0,ec.serviceuser_id,cb.serviceuser_id),
		if(ec.source=0,ec.serviceuser_name,cb.serviceuser_name),
		if(ec.source=0,ec.org_name,cb.service_teamorg_name),
		nvl(ub.position_name,'未知'),
		case 
			when ec.source = 0 then '人工推荐'
			when ec.source=4 then '伯乐推荐'
		end
) recmd
order by recmd.serviceuser_id,recmd.source;

--续约意向度线下需求
--客户名称  负责招服ID  负责招服    招服岗位    招服所属团队  续约意向度   预算充裕度   客户的需求量  人选入职效果  面试人选数   对本公司的服务认可度  职位发布的认可度    简历下载的认可度    意向沟通的认可度    邀请应聘的认可度    急聘的认可度  面试快的认可度
--task_gcdc_m_renewal_intention

select 
'客户名称',
'负责招服ID',
'负责招服',
'招服岗位',
'招服所属团队',
'续约意向度',
'预算充裕度',
'客户的需求量',
'人选入职效果',
'面试人选数',
'对本公司的服务认可度',
'职位发布的认可度',
'简历下载的认可度',
'意向沟通的认可度',
'邀请应聘的认可度',
'急聘的认可度',
'面试快的认可度'
from dummy;


select expire_cust.customer_name,
suser.id,
suser.name,
suser.position_name,
dim_org.org_name,
case renewIntention when 1 then '无' when 2 then '低' when 3 then '中' when 4 then '高' when 0 then '未反馈' else '未调查' end as renewIntention, --续约意向度
case budget when 1 then '不充裕' when 2 then '一般' when 3 then '充裕' when 0 then '未反馈' else '未调查' end as budget, --预算充裕度
case demand when 1 then '小' when 2 then '一般' when 3 then '大' when 0 then '未反馈' else '未调查' end as demand, --客户的需求量
case entrantResult when 1 then '不好' when 2 then '一般' when 3 then '好' when 0 then '未反馈' else '未调查' end as entrantResult, --人选入职效果
case interviewCnt when 1 then '少' when 2 then '一般' when 3 then '多' when 0 then '未反馈' else '未调查' end as interviewCnt, --面试人选数
case serviceSatisfaction when 1 then '不认可' when 2 then '一般' when 3 then '认可' when 0 then '未反馈' else '未调查' end as serviceSatisfaction, --对本公司的服务认可度
case jobSatisfaction when 1 then '不认可' when 2 then '一般' when 3 then '认可' when 0 then '未反馈' else '未调查' end as jobSatisfaction, --职位发布的认可度
case cvSatisfaction when 1 then '不认可' when 2 then '一般' when 3 then '认可' when 0 then '未反馈' else '未调查' end as cvSatisfaction, --简历下载的认可度
case intentionSatisfaction when 1 then '不认可' when 2 then '一般' when 3 then '认可' when 0 then '未反馈' else '未调查' end as intentionSatisfaction, --意向沟通的认可度
case inviteSatisfaction when 1 then '不认可' when 2 then '一般' when 3 then '认可' when 0 then '未反馈' else '未调查' end as inviteSatisfaction, --邀请应聘的认可度
case urgencySatisfaction when 1 then '不认可' when 2 then '一般' when 3 then '认可' when 0 then '未反馈' else '未调查' end as urgencySatisfaction, --急聘的认可度
case mskSatisfaction when 1 then '不认可' when 2 then '一般' when 3 then '认可' when 0 then '未反馈' else '未调查' end as mskSatisfaction --面试快的认可度
from (
select cust_id,customer_name,expire_rps_user_id,expire_rps_org_id
from dw_erp_d_gcdc_contract_list
where p_date = $date$
and substr(contract_expire_date,1,6) = substr('$date$',1,6)
group by cust_id,customer_name,expire_rps_user_id,expire_rps_org_id
) expire_cust
left join 
(select customer_id,
		get_json_object(renew_intention_data,'$.renewIntention') as renewIntention, --续约意向度
		get_json_object(renew_intention_data,'$.budget') as budget, --预算充裕度
		get_json_object(renew_intention_data,'$.demand') as demand, --客户的需求量
		get_json_object(renew_intention_data,'$.entrantResult') as entrantResult, --人选入职效果
		get_json_object(renew_intention_data,'$.interviewCnt') as interviewCnt, --面试人选数
		get_json_object(renew_intention_data,'$.serviceSatisfaction') as serviceSatisfaction, --对本公司的服务认可度
		get_json_object(renew_intention_data,'$.jobSatisfaction') as jobSatisfaction, --职位发布的认可度
		get_json_object(renew_intention_data,'$.cvSatisfaction') as cvSatisfaction, --简历下载的认可度
		get_json_object(renew_intention_data,'$.intentionSatisfaction') as intentionSatisfaction, --意向沟通的认可度
		get_json_object(renew_intention_data,'$.inviteSatisfaction') as inviteSatisfaction, --邀请应聘的认可度
		get_json_object(renew_intention_data,'$.urgencySatisfaction') as urgencySatisfaction, --急聘的认可度
		get_json_object(renew_intention_data,'$.mskSatisfaction') as mskSatisfaction
  from rsc_customer_extension) rce
  on expire_cust.cust_id = rce.customer_id
left join dw_erp_d_salesuser_base suser on expire_cust.expire_rps_user_id = suser.id and suser.p_date = $date$
left join dim_org on expire_cust.expire_rps_org_id = dim_org.d_org_id

--RPS看板线下需求
--task_gcdc_m_rps_kpi
select
'顾问ID',
'顾问姓名',
'顾问组别',
'顾问岗位',
'月初服务客户数',
'月末服务客户数',
'使用意向沟通客户数',
'使用简历下载客户数',
'月目标消耗量',
'月消耗总量',
'人工简历推荐数',
'人工推荐满意数', 
'人工推荐不满意数', 
'伯乐简历推荐数',
'伯乐推荐满意数',
'伯乐推荐不满意数',
'拨打计划完成率',
'续约率',
'续约个数',
'面试快到场数',
'使用意向沟通客户比例',
'使用面试快客户比例',
'使用邀请应聘客户比例',
'使用急聘客户比例',
'使用简历下载客户比例'
from dummy;

select 
	rps_act.rps_user_id, --顾问ID
	suser.name, --顾问姓名
	suser.org_name, --顾问组别
	suser.position_name, --顾问岗位
	rps_act.month_end_cust_cnt, --月初服务客户数
	rps_act.month_start_cust_cnt, --月末服务客户数
	rps_act.consume_intention_cust_cnt, --使用意向沟通客户数
	rps_act.consume_cv_cust_cnt, --使用简历下载客户数
	rps_act.mtd_consume_cv_target_cnt, --月目标消耗量
	rps_act.mtd_consume_cv_cnt, --月消耗总量
	rps_act.rps_recommend_resume_num, --人工简历推荐数
	rps_act.rps_recommend_satisfied_num, --人工推荐满意数 
	rps_act.rps_recommend_unsatisfied_num, --人工推荐不满意数 
	rps_act.bole_recommend_resume_num, --伯乐简历推荐数
	rps_act.bole_recommend_satisfied_num, --伯乐推荐满意数
	rps_act.bole_recommend_unsatisfied_num, --伯乐推荐不满意数
	rps_act.finish_ratio, --拨打计划完成率
	rps_act.mtd_contract_renewal_ratio, --续约率
	rps_act.renewal_cust_cnt, --续约个数
	rps_act.mtd_msk_showup_cnt, --面试快到场数
	rps_act.consume_intention_cust_ratio, --使用意向沟通客户比例
	rps_act.consume_msk_cust_ratio, --使用面试快客户比例
	rps_act.consume_invite_cust_ratio, --使用邀请应聘客户比例
	rps_act.consume_urgent_cust_ratio, --使用急聘客户比例
	rps_act.consume_cv_cust_ratio --使用简历下载客户比例

from (
	select 
		coalesce(rpsuser.rps_user_id,cust.serviceuser_id,recommend.serviceuser_id,callplan.creator_id) as rps_user_id,
		nvl(sum(month_end_cust_cnt),0) as month_end_cust_cnt,
		nvl(sum(month_start_cust_cnt),0) as month_start_cust_cnt,
		nvl(sum(consume_intention_cust_cnt),0) as consume_intention_cust_cnt,
		nvl(sum(consume_cv_cust_cnt),0) as consume_cv_cust_cnt,
		nvl(sum(mtd_consume_cv_target_cnt),0) as mtd_consume_cv_target_cnt,
		nvl(sum(mtd_consume_cv_cnt),0) as mtd_consume_cv_cnt,
		nvl(sum(rps_recommend_resume_num),0) as rps_recommend_resume_num,
		nvl(sum(rps_recommend_satisfied_num),0) as rps_recommend_satisfied_num,
		nvl(sum(rps_recommend_unsatisfied_num),0) as rps_recommend_unsatisfied_num,
		nvl(sum(bole_recommend_resume_num),0) as bole_recommend_resume_num,
		nvl(sum(bole_recommend_satisfied_num),0) as bole_recommend_satisfied_num,
		nvl(sum(bole_recommend_unsatisfied_num),0) as bole_recommend_unsatisfied_num,
		nvl(sum(finish_ratio),0) as finish_ratio,
		nvl(sum(mtd_contract_renewal_ratio),0) as mtd_contract_renewal_ratio,
		nvl(sum(renewal_cust_cnt),0) as renewal_cust_cnt,
		nvl(sum(mtd_msk_showup_cnt),0) as mtd_msk_showup_cnt,
		nvl(sum(consume_intention_cust_ratio),0) as consume_intention_cust_ratio,
		nvl(sum(consume_msk_cust_ratio),0) as consume_msk_cust_ratio,
		nvl(sum(consume_invite_cust_ratio),0) as consume_invite_cust_ratio,
		nvl(sum(consume_urgent_cust_ratio),0) as consume_urgent_cust_ratio,
		nvl(sum(consume_cv_cust_ratio),0) as consume_cv_cust_ratio
	from 
	(  select 
		rps_user_id,
		cust_cnt as month_end_cust_cnt,
		consume_intention_cust_cnt,
		consume_cv_cust_cnt,
		mtd_consume_cv_target_cnt,
		mtd_consume_cv_cnt,
		(mtd_expire_renewal_cust_cnt+mtd_n_expire_renewal_cust_cnt) as renewal_cust_cnt,
		mtd_contract_renewal_ratio,
		mtd_msk_showup_cnt,
		consume_intention_cust_ratio,
		consume_msk_cust_ratio,
		consume_invite_cust_ratio,
		consume_urgent_cust_ratio,
		consume_cv_cust_ratio
		from dw_erp_d_rpsuser_act
		where p_date = $date$
	) rpsuser 
	full join 
	(
	select serviceuser_id,count(1) as month_start_cust_cnt
	from dw_erp_d_customer_base
	where rps_service_version = 1
	and rsc_valid_status = 1
	and p_date = {{date[:6]+'01'}}
	group by serviceuser_id
	) cust
	on rpsuser.rps_user_id = cust.serviceuser_id
	full join 
	(select serviceuser_id,
			sum(case when source = 0 then mtd_recommend_resume_num else 0 end) as rps_recommend_resume_num,
			sum(case when source = 0 then mtd_satisfied_download_num + mtd_satisfied_intention_num else 0 end) as rps_recommend_satisfied_num,
			sum(case when source = 0 then mtd_unsatisfied_num else 0 end) as rps_recommend_unsatisfied_num,
			sum(case when source = 1 then mtd_recommend_resume_num else 0 end) as bole_recommend_resume_num,
			sum(case when source = 1 then mtd_satisfied_download_num + mtd_satisfied_intention_num else 0 end) as bole_recommend_satisfied_num,
			sum(case when source = 1 then mtd_unsatisfied_num else 0 end) as bole_recommend_unsatisfied_num
	  from fact_h_gcdc_d_ejob_candidate
	  where p_date =  $date$
	  and res_type = 0
	  group by serviceuser_id
	) recommend 
	on rpsuser.rps_user_id = recommend.serviceuser_id
	full join 
	(select 
	rsc.creator_id,
	count(case when rsc.status = 1 then rsc.id else null end) /(count(case when rsc.status = 1 then rsc.id else null end) + count(case when rsc.status = 2 then rsc.id else null end)) as finish_ratio
	from rsc_callplan rsc
	where substr(rsc.calltime,1,8) between {{date[:6]+'01'}} and $date$
	and rsc.deleteflag = 0 
	and rsc.creator_id != 346 
	group by rsc.creator_id
	) callplan 
	on rpsuser.rps_user_id = callplan.creator_id
	group by coalesce(rpsuser.rps_user_id,cust.serviceuser_id,recommend.serviceuser_id,callplan.creator_id)
) rps_act
join dw_erp_d_salesuser_base suser on rps_act.rps_user_id = suser.id and suser.p_date = $date$;



--重点产品使用比例
select 
	cust.serviceuser_id,
	suser.name,
	suser.org_name,
	suser.position_name,	
	sum(avg_cust_cnt) as avg_cust_cnt,
	sum(download_cv_cust_cnt) as download_cv_cust_cnt,
	sum(intention_cust_cnt) as intention_cust_cnt,
	sum(msk_cust_cnt) as msk_cust_cnt,
	sum(invite_cust_cnt) as invite_cust_cnt,
	sum(urgent_cust_cnt) as urgent_cust_cnt
from 
 (select base.serviceuser_id,
 		count(id) / count(distinct p_date) as avg_cust_cnt,
 		0 as download_cv_cust_cnt,
		0 as intention_cust_cnt,
		0 as msk_cust_cnt,
		0 as invite_cust_cnt,
		0 as urgent_cust_cnt
from dw_erp_d_customer_base base
where base.p_date between 20170301 and 20170331
  and base.rps_service_version = 1
  and base.rsc_valid_status = 1 
  and base.parent_customer_id = 0
group by base.serviceuser_id

union all 

select act.serviceuser_id,
			0 as avg_cust_cnt,
			count(distinct case when download_cv_cnt > 0 then customer_id else null end) as download_cv_cust_cnt,	
			count(distinct case when intention_cnt > 0 then customer_id else null end) as intention_cust_cnt,
			count(distinct case when msk_cnt > 0 then customer_id else null end) as msk_cust_cnt,
			count(distinct case when invite_cnt > 0 then customer_id else null end) as invite_cust_cnt,	
			count(distinct case when urgent_cnt > 0 then customer_id else null end) as urgent_cust_cnt
     from dw_erp_d_customer_rps_act act
     join dw_erp_d_customer_base cust 
     on act.customer_id = cust.id 
     and act.p_date = cust.p_date
    where act.p_date between 20170301 and 20170331
      and cust.rsc_valid_status = 1
 group by act.serviceuser_id
 having download_cv_cust_cnt+intention_cust_cnt+msk_cust_cnt+invite_cust_cnt+urgent_cust_cnt > 0
 ) cust
join dw_erp_d_salesuser_base suser on cust.serviceuser_id = suser.id and suser.p_date = 20170331
group by cust.serviceuser_id,
suser.name,
suser.org_name,
suser.position_name



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
            where p_date between 20170301 and 20170331
            group by customer_id
          ) act     
        on act.customer_id = base.id
        where base.p_date = $date$ 
          and base.rps_service_version = 1
          and base.rsc_valid_status = 1 
        group by base.serviceuser_id 


--客户消耗相关数据提取申请
select 
'年份',
'月份',
'客户ID',
'客户名称',
'行业',
'客户所在地',
'所属顾问',
'所属顾问级别',
'顾问地区',
'简历下载数',
'兑换白领简历精英简历下载数',
'意向沟通数',
'邀请应聘数',
'急聘消耗数',
'面试快消耗数',
'面试快'+消耗,
'入职快消耗数',
'面试快券消耗',
'下载劵消耗数',
'综合消耗数',
'面试快消耗数',
'面试快券消耗',
'顾问推荐简历下载数',
'顾问推荐意向沟通消耗数'
from dummy;

--head:"年份  月份  客户ID    客户名称    行业  客户所在地   所属顾问    所属顾问级别  顾问地区    简历下载数   兑换白领简历精英简历下载数   意向沟通数   邀请应聘数   急聘消耗数   面试快消耗数  面试快+消耗  入职快消耗数  面试快券消耗  下载劵消耗数  综合消耗数   面试快消耗数  面试快券消耗  顾问推荐简历下载数   顾问推荐意向沟通消耗数"
select
	substr(ecomop_act.d_month,1,4) as d_year,
	substr(ecomop_act.d_month,5,2) as d_month,
	cust.id ,
	cust.name,
	dim_industry.d_main_industry,
	dim_dq.d_ch_name,
	cust.serviceuser_name,
	suser.position_level_name,
	cust.service_branch_name,    
	cv_cnt,
	exchangelowcv_cv_cnt,
	intention_cv_cnt,
	invitation_cv_cnt,
	urgent_cv_cnt,
	msk_cv_cnt,
	mskplus_cv_cnt,
	rzk_cv_cnt,
	mskcoupon_cnt,
	cvcoupon_cnt,
	total,
	consume_cv_cnt,
	consume_mskcoupon_cnt,
	recmd_satisfied_download_cnt,
	recmd_satisfied_intention_cnt
from (
	select
		coalesce(rsc.d_month,msk.d_month,can.d_month) as d_month,
		coalesce(rsc.ecomp_root_id,msk.ecomp_root_id,can.ecomp_root_id) as ecomp_root_id,
		sum(cv_cnt) as cv_cnt,
		sum(cvcoupon_cnt) as cvcoupon_cnt,
		sum(intention_cnt) as intention_cnt,
		sum(invitation_cnt) as invitation_cnt,
		sum(mskcoupon_cnt) as mskcoupon_cnt,
		sum(jobrecommendcoupon_cnt) as jobrecommendcoupon_cnt,
		sum(intention_cv_cnt) as intention_cv_cnt,
		sum(invitation_cv_cnt) as invitation_cv_cnt,
		sum(urgent_cv_cnt) as urgent_cv_cnt,
		sum(msk_cv_cnt) as msk_cv_cnt,
		sum(mskplus_cv_cnt) as mskplus_cv_cnt,
		sum(rzk_cv_cnt) as rzk_cv_cnt,
		sum(exchangelowcv_cv_cnt) as exchangelowcv_cv_cnt,
		sum(total) as total,
		sum(consume_cv_cnt) as consume_cv_cnt,
		sum(consume_mskcoupon_cnt) as consume_mskcoupon_cnt,
		sum(recmd_satisfied_download_cnt) as recmd_satisfied_download_cnt,
		sum(recmd_satisfied_intention_cnt)*2 as recmd_satisfied_intention_cnt
	from 
	(  select 
			substr(p_date,1,6) as d_month,
			ecomp_root_id,
			sum(consume_cv) as cv_cnt,
			sum(consume_cvcoupon) as cvcoupon_cnt,
			sum(consume_intention) as intention_cnt,
			sum(consume_invite) as invitation_cnt,
			sum(consume_mskcoupon) as mskcoupon_cnt,
			sum(consume_jobrecommendcoupon) as jobrecommendcoupon_cnt,
			sum(consume_intention_cv) as intention_cv_cnt,
			sum(consume_invite_cv) as invitation_cv_cnt,
			sum(consume_urgent_cv) as urgent_cv_cnt,
			sum(consume_msk_cv) as msk_cv_cnt,
			sum(consume_mskplus_cv) as mskplus_cv_cnt,
			sum(consume_rzk_cv) as rzk_cv_cnt,
			sum(exchange_cv2lowcv) as exchangelowcv_cv_cnt,
			sum(consume_cv + consume_cvcoupon + consume_intention * 2 + consume_invite * 50 + consume_mskcoupon * 50 + consume_intention_cv + consume_invite_cv + consume_urgent_cv + consume_msk_cv + consume_mskplus_cv + consume_rzk_cv+exchange_cv2lowcv) as total
		from dw_b_d_resource_consume
		where p_date between 20160101 and 20161231
		group by ecomp_root_id,substr(p_date,1,6)
		having jobrecommendcoupon_cnt+total>0
		) rsc
	full join 
	(
		select  substr(regexp_replace(can.showup_time,'-',''),1,6) as d_month,
				order1.ecomp_root_id,
				sum(consume_cv_cnt) as consume_cv_cnt,
				sum(consume_mskcoupon_cnt) as consume_mskcoupon_cnt
		from dw_god_d_msk_service_order order1 
		join dw_god_d_msk_candidate can 
		on order1.god_service_order_id = can.god_service_order_id
		and can.p_date = 20170101
		and substr(regexp_replace(can.showup_time,'-',''),1,4) = '2016'
		where order1.p_date = 20170101
		and consultant_type = 1
		group by order1.ecomp_root_id,substr(regexp_replace(can.showup_time,'-',''),1,6)
	) msk 
	on rsc.d_month = msk.d_month
	and rsc.ecomp_root_id = msk.ecomp_root_id
	full join
	(select regexp_replace(greatest(substr(handletime,1,7),substr(createtime,1,7)),'-','') as d_month,
			ecomp_root_id,
			count(case when feedback = 4 then res_id else null end) as recmd_satisfied_download_cnt,
			count(case when feedback = 2 then res_id else null end) as recmd_satisfied_intention_cnt
	   from dw_erp_d_ejob_candidate
	  where p_date = 20170101
		and feedback in (2,4)
		and source = 0
		and (substr(handletime,1,7) between '2016-07' and '2016-12' or substr(createtime,1,7) between '2016-01' and '2016-09')
	  group by regexp_replace(greatest(substr(handletime,1,7),substr(createtime,1,7)),'-',''),ecomp_root_id
	) can 
	on rsc.d_month = can.d_month
	and rsc.ecomp_root_id = can.ecomp_root_id
	group by coalesce(rsc.d_month,msk.d_month,can.d_month),
			 coalesce(rsc.ecomp_root_id,msk.ecomp_root_id,can.ecomp_root_id)
) ecomop_act
join dw_erp_d_customer_base cust
on ecomop_act.ecomp_root_id = cust.ecomp_id
and cust.p_date = 20170215
join dw_erp_d_salesuser_base suser 
on cust.serviceuser_id = suser.id 
and suser.p_date = 20170215
join dim_industry 
on cust.industry = dim_industry.d_ind_code
join dim_dq
on cust.dq = dim_dq.d_code ;



select *
	   from dw_erp_d_ejob_candidate
	  where p_date = 20170101
		and source = 0
		and (substr(handletime,1,7) between '2016-07' and '2016-12' or substr(createtime,1,7) between '2016-01' and '2016-09')
		and customer_id = 6628;

--2016年意向沟通数据提取
select
'客户ID',
'职位',
'简历编号',
'类型',
'B端跟进意向度',
'C端跟进意向度',
'招服专员B',
'招服专员B所在团队',
'招服专员C',
'招服专员C所在团队',
'邀请沟通时间',
'招聘专员释放给C时间',
'招聘顾问收回意向时间',
'C已提交时间',
'B端回复客户时间'
from dummy;

select  cust.name as cust_name,
		dim_jobtitle.d_ch_name as ejob_jobtitle,
		task.res_id,
		case task.kind when 0 then '客户' when 1 then '推荐' end as task_type,
		case taskblog.result when 1 then '高' when 2 then '中' when 3 then '低' when 4 then '无' when 6 then '未成功沟通' end as taskb_result,
		case taskclog.result when 1 then '高' when 2 then '中' when 3 then '低' when 4 then '无' when 6 then '未成功沟通' end as taskc_result,
		rps.name as rps_user_name,
		rps_org.org_name as rps_org_name,
		nvl(cdc.name,cdc2.name) as cdc_user_name,
		nvl(cdc_org.org_name,cdc_org2.org_name) as cdc_org_name,
		task.createtime as in_createtime,
		taskb.createtime as taskc_createtime,
		taskclog_sh.tl_createtime as sh_tl_createtime,
		taskclog.tl_createtime as taskc_sub_createtime,
		taskblog.createtime as taskb_createtime
from rsc_intention task 
join 
(select taskb.id,taskb.rsc_intention_id,taskc.createtime
   from rsc_intention_task_b taskb 
   join rsc_intention_task_c taskc 
   on taskb.id = taskc.rsc_intention_task_b_id
   and taskc.intention_type in (1,2)
  where substr(taskc.createtime,1,4) = '2016'
   and (taskc.result in (1,2,3,4,6) or taskc.status = 3)
 ) taskb
on taskb.rsc_intention_id = task.id
left join (select   tasklog.id,
					tasklog.result,
					tasklog.creator_id as rps_user_id,
					tasklog.org_id as rps_org_id,
					tasklog.rsc_intention_task_b_id,
					tasklog.createtime --B端回复客户时间
		from (
		select id,result,creator_id,org_id,intention_type,rsc_intention_task_b_id,createtime,
			   row_number()over(distribute by rsc_intention_task_b_id sort by createtime desc) rn 
		  from rsc_intention_task_b_log
		 where deleteflag = 0
		   and intention_type in ('1','2')
		   and substr(createtime,1,4) >= '2016'
			 ) tasklog
		where rn = 1
		 and result in ('1','2','3','4','6')          
) taskblog 
on taskb.id = taskblog.rsc_intention_task_b_id
left join (select   tasklog.id,
					tasklog.result,
					tasklog.creator_id as cdc_user_id,
					tasklog.org_id as cdc_org_id,
					tasklog.rsc_intention_task_b_id,
					tasklog.tc_createtime, --招聘专员释放给C时间
					tasklog.tl_createtime --C已提交时间
		from (
		select  logc.id,
				logc.result,
				logc.creator_id,
				logc.org_id,
				logc.status,
				taskc.rsc_intention_task_b_id,
				taskc.createtime as tc_createtime,
				logc.createtime as tl_createtime,
				row_number()over(distribute by taskc.rsc_intention_task_b_id sort by logc.createtime desc) rn 
		  from rsc_intention_task_c_log logc
		  join rsc_intention_task_c taskc
		  on logc.rsc_intention_task_c_id = taskc.id
		 where logc.deleteflag = 0
		   and logc.intention_type in ('1','2')
		   and logc.status = 1
		   and logc.result in ('1','2','3','4','6')
		   and substr(logc.createtime,1,4) >= '2016'
			 ) tasklog
		where rn = 1
) taskclog 
on taskb.id = taskclog.rsc_intention_task_b_id
left join (select   tasklog.id,
					tasklog.result,
					tasklog.rps_user_id,
					tasklog.rps_org_id,
					tasklog.cdc_user_id,
					tasklog.cdc_org_id,                    
					tasklog.rsc_intention_task_b_id,
					tasklog.tc_createtime, --招聘专员释放给C时间
					tasklog.tl_createtime --招聘顾问收回意向时间
		from (
		select  logc.id,
				logc.result,
				logc.creator_id as rps_user_id,
				logc.org_id as rps_org_id,
				logc.status,
				taskc.rsc_intention_task_b_id,
				taskc.creator_id as cdc_user_id, 
				taskc.org_id as cdc_org_id, 
				taskc.createtime as tc_createtime,
				logc.createtime as tl_createtime,
				row_number()over(distribute by taskc.rsc_intention_task_b_id sort by logc.createtime desc) rn 
		  from rsc_intention_task_c_log logc
		  join rsc_intention_task_c taskc
		  on logc.rsc_intention_task_c_id = taskc.id
		 where logc.deleteflag = 0
		   and logc.intention_type in ('1','2')
		   and substr(logc.createtime,1,4) >= '2016'
			 ) tasklog
		where rn = 1
		  and status = 3
) taskclog_sh
on taskb.id = taskclog_sh.rsc_intention_task_b_id
join dw_erp_d_customer_base_new cust 
on task.customer_id = cust.id 
left join rsc_ejob  
on task.rsc_ejob_id = rsc_ejob.id 
left join ejob
on rsc_ejob.ejob_id = ejob.ejob_id
left join dim_jobtitle 
on get_first_code(ejob.ejob_jobtitle,',') = dim_jobtitle.d_code
left join dw_erp_d_salesuser_base rps 
on taskblog.rps_user_id = rps.id 
and rps.p_date = '20161231'
left join dim_org rps_org
on taskblog.rps_org_id = rps_org.d_org_id
left join dw_erp_d_salesuser_base cdc 
on taskclog.cdc_user_id = cdc.id 
and cdc.p_date = '20161231'
left join dim_org cdc_org
on taskclog.cdc_org_id = cdc_org.d_org_id
left join dw_erp_d_salesuser_base cdc2 
on taskclog_sh.cdc_user_id = cdc2.id 
and cdc2.p_date = '20161231'
left join dim_org cdc_org2
on taskclog_sh.cdc_org_id = cdc_org2.d_org_id
where substr(task.createtime,1,4) = '2016';

--2016年BI拉新数据

select 
plan.industry,plan.branch,plan.city,
count(distinct plan.callplan_id) as draft_cv_cnt,
count(distinct track.popularize_callplan_id) as cover_cnt,
sum(finish_res_c_cnt) as finish_res_c_cnt,
sum(finish_biz_res_cnt) as finish_biz_res_cnt,
sum(finish_level6_res_cnt) as finish_level6_res_cnt,
sum(finish_level5_res_cnt) as finish_level5_res_cnt,
sum(finish_level4_res_cnt) as finish_level4_res_cnt,
sum(finish_level3_res_cnt) as finish_level3_res_cnt,
sum(finish_level2_res_cnt) as finish_level2_res_cnt,
sum(finish_level1_res_cnt) as finish_level1_res_cnt
from 
(select 
	dim_industry.d_main_industry as industry,
	dim_dq.d_branch as branch,
	dim_dq.d_parent_ch_name as city,
	callplan_id
from dw_erp_d_gcdcnewp_plan plan
left join dim_dq 
on plan.callplan_dq = dim_dq.d_code
left join dim_industry 
on plan.callplan_industry = dim_industry.d_ind_code
where substr(regexp_replace(task_createtime,'-',''),1,4) = '2016'
and p_date = '20161231'
) plan 
left join 
(
	select 
		popularize_callplan_id,
	case when instr(combine(cast(action_type as string)) ,4) >0 then 1 else 0 end  as finish_res_c_cnt,
	case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 6 then 1 else 0 end  as finish_level6_res_cnt,
	case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 5 then 1 else 0 end  as finish_level5_res_cnt,
	case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 4 then 1 else 0 end  as finish_level4_res_cnt,
	case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 3 then 1 else 0 end  as finish_level3_res_cnt,
	case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 2 then 1 else 0 end  as finish_level2_res_cnt,
	case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) = 1 then 1 else 0 end  as finish_level1_res_cnt,
	case when instr(combine(cast(action_type as string)) ,4) >0 and max(resume_level) > 1 then 1 else 0 end  as finish_biz_res_cnt
	from popularize_callplan_log
	where substr(regexp_replace(createtime,'-',''),1,4) >= '2016'
	group by popularize_callplan_id
) planlog 
on plan.callplan_id = planlog.popularize_callplan_id
left join 
(	select popularize_callplan_id
	from  popularize_track
	where substr(regexp_replace(createtime,'-',''),1,4) >= '2016'
	group by popularize_callplan_id
) track 
on plan.callplan_id = track.popularize_callplan_id
group by plan.industry,plan.branch,plan.city

--回归简历统计

select
substr(d_date,5,2) as d_month,
sum(regress_full_res_cnt)-sum(degenerate_full_res_cnt) as rgr_res_cnt,
sum(regress_full_res_cnt)-sum(degenerate_full_res_cnt) - sum(case when d_regress_device = 10 then regress_full_res_cnt-degenerate_full_res_cnt else 0 end) -
sum(case when dm.d_mscid is not null then regress_full_res_cnt-degenerate_full_res_cnt else 0 end) as nat_rgr_res_cnt,
sum(case when dm.d_mscid is not null then regress_full_res_cnt-degenerate_full_res_cnt else 0 end) as edm_rgr_res_cnt
from fact_t_mk_d_regress_res res
left join dim_mscid dm 
on res.d_regress_mscid = dm.d_mscid
and dm.d_class_2 = 'EDM'
where d_date like '2016%'
group by substr(d_date,5,2);


--客户量统计
select substr(p_date,1,6) as d_month,
		dim_industry.d_main_industry,
		dim_dq.d_ch_name,
		count(1) as cust_cnt
from dw_erp_d_customer_base cust 
left join dim_industry
on cust.industry = dim_industry.d_ind_code
left join dim_dq 
on cust.dq = dim_dq.d_code
where p_date in (20160131,20160229,20160331,20160430,20160531,20160630,20160731,20160831,20160930,20161031,20161130,20161231)
and ecomp_version = 2
group by substr(p_date,1,6),dim_industry.d_main_industry,dim_dq.d_ch_name;

--职位量统计
select substr(p_date,1,6) as d_month,
		dim_industry.d_main_industry,
		dim_dq.d_ch_name,
		count(1) as cust_cnt
from dw_erp_d_customer_base cust 
join dw_b_d_ejob_base ejob 
on cust.ecomp_id = ejob.ecomp_root_id
and ejob.p_date = cust.p_date
and ejob.ejob_status = 0
left join dim_industry
on cust.industry = dim_industry.d_ind_code
left join dim_dq 
on ejob.ejob_dq_first = dim_dq.d_code
where p_date in (20160131,20160229,20160331,20160430,20160531,20160630,20160731,20160831,20160930,20161031,20161130,20161231)
and ecomp_version = 2
group by substr(p_date,1,6),dim_industry.d_main_industry,dim_dq.d_ch_name;

--简历下载量统计
select substr(ecomp_act.p_date,1,6) as d_month,
		dim_industry.d_main_industry,
		dim_dq.d_ch_name,
		sum(consume_cv+consume_lowcv) as consume_cv_cnt
from dw_erp_d_customer_base_new cust 
join dw_b_d_resource_consume ecomp_act
on cust.ecomp_id = ecomp_act.ecomp_root_id
left join dim_industry
on cust.industry = dim_industry.d_ind_code
left join dim_dq 
on cust.dq = dim_dq.d_code
where ecomp_act.p_date like '2016%'
group by substr(ecomp_act.p_date,1,6),dim_industry.d_main_industry,dim_dq.d_ch_name;


--RPO简历完善激活数
select fullcv.d_month,
sum(full_cv_cnt) as full_cv_cnt,
sum(act_cv_cnt) as act_cv_cnt
from (
select substr(regexp_replace(ucr_perfected_cv_time,'-',''),1,6) as d_month,
	count(distinct ucr_bi_id) as full_cv_cnt,
	0 as act_cv_cnt
from upload_cv_record
where substr(regexp_replace(ucr_perfected_cv_time,'-',''),1,4) = '2016'
group by substr(regexp_replace(ucr_perfected_cv_time,'-',''),1,6)
union all 
select substr(regexp_replace(account_active_time,'-',''),1,6) as d_month,
	0 as full_cv_cnt,
	count(distinct ucr_bi_id) as act_cv_cnt
from upload_cv_record up
join liepin_cv_relation lc
on up.ucr_bi_id	 = lc.lcr_bi_id
where substr(regexp_replace(account_active_time,'-',''),1,4) = '2016'
and substr(regexp_replace(ucr_perfected_cv_time,'-',''),1,4) = '2016'
group by substr(regexp_replace(account_active_time,'-',''),1,6)
) fullcv 
group by fullcv.d_month

---重点职位推荐
select 
	suser.id,
	suser.name,
	suser.org_name,
	suser.position_name,
	sum(fc_ejob_cnt) as fc_ejob_cnt,
	sum(fc_ejob_cust_cnt) as fc_ejob_cust_cnt,
	sum(rps_recom_ejob_cnt) as rps_recom_ejob_cnt,
	sum(rps_recom_res_cnt) as rps_recom_res_cnt,
	sum(rps_recom_ejob_satistied_cnt) as rps_recom_ejob_satistied_cnt,
	sum(rps_recom_res_satistied_cnt) as rps_recom_res_satistied_cnt,
	sum(rps_recom_res_unsatistied_cnt) as rps_recom_res_unsatistied_cnt,
	sum(bole_recom_ejob_cnt) as bole_recom_ejob_cnt,
	sum(bole_recom_res_cnt) as bole_recom_res_cnt,
	sum(bole_recom_ejob_satistied_cnt) as bole_recom_ejob_satistied_cnt,
	sum(bole_recom_res_satistied_cnt) as bole_recom_res_satistied_cnt,
	sum(bole_recom_res_unsatistied_cnt) as bole_recom_res_unsatistied_cnt,
	sum(bole_rps_recom_ejob_satistied_cnt) as bole_rps_recom_ejob_satistied_cnt,
	sum(bole_rps_recom_ejob_cnt) as bole_rps_recom_ejob_cnt
from (
	select 
		cust1.serviceuser_id,
		count(distinct fc_ejob.ejob_id) as fc_ejob_cnt,
		count(distinct cust1.ecomp_id) as fc_ejob_cust_cnt,
		nvl(sum(rps_recom_ejob_cnt),0) as rps_recom_ejob_cnt,
		nvl(sum(rps_recom_res_cnt),0) as rps_recom_res_cnt,
		nvl(sum(rps_recom_ejob_satistied_cnt),0) as rps_recom_ejob_satistied_cnt,
		nvl(sum(rps_recom_res_satistied_cnt),0) as rps_recom_res_satistied_cnt,
		nvl(sum(rps_recom_res_unsatistied_cnt),0) as rps_recom_res_unsatistied_cnt,
		nvl(sum(bole_recom_ejob_cnt),0) as bole_recom_ejob_cnt,
		nvl(sum(bole_recom_res_cnt),0) as bole_recom_res_cnt,
		nvl(sum(bole_recom_ejob_satistied_cnt),0) as bole_recom_ejob_satistied_cnt,
		nvl(sum(bole_recom_res_satistied_cnt),0) as bole_recom_res_satistied_cnt,
		nvl(sum(bole_recom_res_unsatistied_cnt),0) as bole_recom_res_unsatistied_cnt,
		nvl(sum(bole_rps_recom_ejob_satistied_cnt),0) as bole_rps_recom_ejob_satistied_cnt,
		nvl(sum(bole_rps_recom_ejob_cnt),0) as bole_rps_recom_ejob_cnt
	from 
	(
		select ejob_id,ecomp_root_id
		from dw_b_d_ejob_base 
		where p_date between 20170301 and 20170331
		and ejob_focusflag = 1
		group by ejob_id,ecomp_root_id
	) fc_ejob 
	join 
	(select ecomp_id,serviceuser_id,id 
	  from dw_erp_d_customer_base 
	  where p_date = 20170331
	) cust1 
	on cust1.ecomp_id = fc_ejob.ecomp_root_id
	left join 
	(
		select  cust.serviceuser_id,
				cust.id,
		        count(distinct case when rps_recom_res_cnt > 0 then can.ejob_id else null end) as rps_recom_ejob_cnt,
		        sum(rps_recom_res_cnt) as rps_recom_res_cnt,
		        count(distinct case when rps_recom_res_satistied_cnt > 0 then can.ejob_id else null end) as rps_recom_ejob_satistied_cnt,
		        sum(rps_recom_res_satistied_cnt) as rps_recom_res_satistied_cnt,
		        sum(rps_recom_res_unsatistied_cnt) as rps_recom_res_unsatistied_cnt,
		        count(distinct case when bole_recom_res_cnt > 0 then can.ejob_id else null end) as bole_recom_ejob_cnt,
				sum(bole_recom_res_cnt) as bole_recom_res_cnt,
				count(distinct case when bole_recom_res_satistied_cnt > 0 then can.ejob_id else null end) as bole_recom_ejob_satistied_cnt,
				sum(bole_recom_res_satistied_cnt) as bole_recom_res_satistied_cnt,
				sum(bole_recom_res_unsatistied_cnt) as bole_recom_res_unsatistied_cnt,
				count(distinct case when bole_recom_res_satistied_cnt+rps_recom_res_satistied_cnt> 0 then can.ejob_id else null end) as bole_rps_recom_ejob_satistied_cnt,
				count(distinct case when rps_recom_res_cnt+bole_recom_res_cnt> 0 then can.ejob_id else null end) as bole_rps_recom_ejob_cnt	
		from   (select ejob_id,substr(regexp_replace(createtime,'-',''),1,8) as recom_date,customer_id,
						count(case when source = 0 then id else null end) as rps_recom_res_cnt,
						count(case when source = 0 and feedback in (2,4,5) then id else null end) as rps_recom_res_satistied_cnt,
						count(case when source = 0 and feedback in (9,6) then id else null end) as rps_recom_res_unsatistied_cnt,
						count(case when source = 4 then id else null end) as bole_recom_res_cnt,
						count(case when source = 4 and feedback in (2,4,5) then id else null end) as bole_recom_res_satistied_cnt,
						count(case when source = 4 and feedback in (9,6) then id else null end) as bole_recom_res_unsatistied_cnt
				   from dw_erp_d_ejob_candidate
				  where p_date = 20170406
				    and substr(regexp_replace(createtime,'-',''),1,8) between 20170301 and 20170331
				   group by customer_id,ejob_id,substr(regexp_replace(createtime,'-',''),1,8)
				) can 
				left join dw_erp_d_customer_base cust 
				on can.customer_id = cust.id 
				and cust.p_date = can.recom_date
				and cust.p_date between  20170301 and 20170331
				join 
				(
					select ejob_id,ecomp_root_id
					from dw_b_d_ejob_base 
					where p_date between  20170301 and 20170331
					and ejob_focusflag = 1
					group by ejob_id,ecomp_root_id
				) fc_ejob 
				on can.ejob_id =fc_ejob.ejob_id
		group by cust.serviceuser_id,cust.id
	) recom 
	on cust1.serviceuser_id = recom.serviceuser_id
	and cust1.id = recom.id 
	group by cust1.serviceuser_id
) fact
join dw_erp_d_salesuser_base suser 
on fact.serviceuser_id = suser.id 
and suser.p_date = 20170331 -- 华东区，华南区，西南区
group by suser.id,
	suser.name,
	suser.org_name,
	suser.position_name



select 
	suser.id,
	suser.name,
	suser.org_name,
	suser.position_name,
	sum(fc_ejob_cnt) as fc_ejob_cnt,
	sum(fc_ejob_cust_cnt) as fc_ejob_cust_cnt,
	sum(rps_recom_ejob_cnt) as rps_recom_ejob_cnt,
	sum(rps_recom_res_cnt) as rps_recom_res_cnt,
	sum(rps_recom_ejob_satistied_cnt) as rps_recom_ejob_satistied_cnt,
	sum(rps_recom_res_satistied_cnt) as rps_recom_res_satistied_cnt,
	sum(rps_recom_res_unsatistied_cnt) as rps_recom_res_unsatistied_cnt,
	sum(bole_recom_ejob_cnt) as bole_recom_ejob_cnt,
	sum(bole_recom_res_cnt) as bole_recom_res_cnt,
	sum(bole_recom_ejob_satistied_cnt) as bole_recom_ejob_satistied_cnt,
	sum(bole_recom_res_satistied_cnt) as bole_recom_res_satistied_cnt,
	sum(bole_recom_res_unsatistied_cnt) as bole_recom_res_unsatistied_cnt,
	sum(bole_rps_recom_ejob_satistied_cnt) as bole_rps_recom_ejob_satistied_cnt,
	sum(bole_rps_recom_ejob_cnt) as bole_rps_recom_ejob_cnt
from (
	select 
		cust1.serviceuser_id,
		count(distinct fc_ejob.ejob_id) as fc_ejob_cnt,
		count(distinct cust1.ecomp_id) as fc_ejob_cust_cnt,
		0 as rps_recom_ejob_cnt,
		0 as rps_recom_res_cnt,
		0 as rps_recom_ejob_satistied_cnt,
		0 as rps_recom_res_satistied_cnt,
		0 as rps_recom_res_unsatistied_cnt,
		0 as bole_recom_ejob_cnt,
		0 as bole_recom_res_cnt,
		0 as bole_recom_ejob_satistied_cnt,
		0 as bole_recom_res_satistied_cnt,
		0 as bole_recom_res_unsatistied_cnt,
		0 as bole_rps_recom_ejob_satistied_cnt,
		0 as bole_rps_recom_ejob_cnt
	from 
	(
		select ejob_id,ecomp_root_id
		from dw_b_d_ejob_base 
		where p_date between 20170301 and 20170331
		and ejob_focusflag = 1
		group by ejob_id,ecomp_root_id
	) fc_ejob 
	join 
	(select ecomp_id,serviceuser_id
	  from dw_erp_d_customer_base 
	  where p_date = 20170331
	) cust1 
	on cust1.ecomp_id = fc_ejob.ecomp_root_id
	group by cust1.serviceuser_id
	union all 
	select  cust.serviceuser_id,
			0 as fc_ejob_cnt,
			0 as fc_ejob_cust_cnt,
	        count(distinct case when rps_recom_res_cnt > 0 then can.ejob_id else null end) as rps_recom_ejob_cnt,
	        sum(rps_recom_res_cnt) as rps_recom_res_cnt,
	        count(distinct case when rps_recom_res_satistied_cnt > 0 then can.ejob_id else null end) as rps_recom_ejob_satistied_cnt,
	        sum(rps_recom_res_satistied_cnt) as rps_recom_res_satistied_cnt,
	        sum(rps_recom_res_unsatistied_cnt) as rps_recom_res_unsatistied_cnt,
	        count(distinct case when bole_recom_res_cnt > 0 then can.ejob_id else null end) as bole_recom_ejob_cnt,
			sum(bole_recom_res_cnt) as bole_recom_res_cnt,
			count(distinct case when bole_recom_res_satistied_cnt > 0 then can.ejob_id else null end) as bole_recom_ejob_satistied_cnt,
			sum(bole_recom_res_satistied_cnt) as bole_recom_res_satistied_cnt,
			sum(bole_recom_res_unsatistied_cnt) as bole_recom_res_unsatistied_cnt,
			count(distinct case when bole_recom_res_satistied_cnt+rps_recom_res_satistied_cnt> 0 then can.ejob_id else null end) as bole_rps_recom_ejob_satistied_cnt,
			count(distinct case when rps_recom_res_cnt+bole_recom_res_cnt> 0 then can.ejob_id else null end) as bole_rps_recom_ejob_cnt	
	from   (select ejob_id,substr(regexp_replace(createtime,'-',''),1,8) as recom_date,customer_id,
					count(case when source = 0 then id else null end) as rps_recom_res_cnt,
					count(case when source = 0 and feedback in (2,4,5) then id else null end) as rps_recom_res_satistied_cnt,
					count(case when source = 0 and feedback in (9,6) then id else null end) as rps_recom_res_unsatistied_cnt,
					count(case when source = 4 then id else null end) as bole_recom_res_cnt,
					count(case when source = 4 and feedback in (2,4,5) then id else null end) as bole_recom_res_satistied_cnt,
					count(case when source = 4 and feedback in (9,6) then id else null end) as bole_recom_res_unsatistied_cnt
			   from dw_erp_d_ejob_candidate
			  where p_date = 20170406
			    and substr(regexp_replace(createtime,'-',''),1,8) between 20170301 and 20170331
			   group by customer_id,ejob_id,substr(regexp_replace(createtime,'-',''),1,8)
			) can 
			join dw_erp_d_customer_base cust 
			on can.customer_id = cust.id 
			and cust.p_date = can.recom_date
			and cust.p_date between  20170301 and 20170331
			join 
			(
				select ejob_id,ecomp_root_id
				from dw_b_d_ejob_base 
				where p_date between  20170301 and 20170331
				and ejob_focusflag = 1
				group by ejob_id,ecomp_root_id
			) fc_ejob 
			on can.ejob_id =fc_ejob.ejob_id
			join 
			(select ecomp_id,serviceuser_id,id
			  from dw_erp_d_customer_base 
			  where p_date = 20170331
			) cust1 
			on cust.id = cust1.id 
			and cust.serviceuser_id = cust1.serviceuser_id
	group by cust.serviceuser_id
) fact
join dw_erp_d_salesuser_base suser 
on fact.serviceuser_id = suser.id 
and suser.p_date = 20170331 -- 华东区，华南区，西南区
group by suser.id,
	suser.name,
	suser.org_name,
	suser.position_name



--重点产品覆盖

select  rps_user_id, rps_user_name, org_name, position_name, 
		sum(case when p_date = 20170301 then cust_cnt else 0 end) as cust_cnt_start,
		sum(case when p_date = 20170331 then cust_cnt else 0 end) as cust_cnt_end,
		sum(case when p_date = 20170331 then consume_intention_cust_cnt else 0 end) as consume_intention_cust_cnt,
		sum(case when p_date = 20170331 then consume_cv_cust_cnt else 0 end) as consume_cv_cust_cnt,
		sum(case when p_date = 20170331 then consume_msk_cust_cnt else 0 end) as consume_msk_cust_cnt,
		sum(case when p_date = 20170331 then consume_urgent_cust_cnt else 0 end) as consume_urgent_cust_cnt,		
		sum(case when p_date = 20170331 then consume_invite_cust_cnt else 0 end) as consume_invite_cust_cnt
from dw_erp_d_rpsuser_act
where p_date in (20170331,20170301)
group by rps_user_id, rps_user_name, org_name, position_name


--推荐满意度
--head:"招服ID	招服顾问	所属团队	招服岗位	类型	满意并下载数	满意并发起意向数	推荐简历数	推荐简历满意数"
select 
recmd.serviceuser_id,
recmd.serviceuser_name,
recmd.service_teamorg_name,
recmd.position_name,

recmd.rps_recmd_satisfied_download_cnt,
recmd.rps_recmd_satisfied_intention_cnt,
recmd.rps_recmd_cnt,
recmd.rps_recmd_handle_cnt,
recmd.rps_recmd_satisfied_cnt/recmd.rps_recmd_cnt as rps_recmd_satisfied_ratio,

recmd.bole_recmd_satisfied_download_cnt,
recmd.bole_recmd_satisfied_intention_cnt,
recmd.bole_recmd_cnt,
recmd.bole_recmd_handle_cnt,
recmd.bole_recmd_satisfied_cnt/recmd.bole_recmd_cnt as bole_recmd_satisfied_ratio
from (
	select 
		if(ec.source=0,ec.serviceuser_id,cb.serviceuser_id) as serviceuser_id,
		if(ec.source=0,ec.serviceuser_name,cb.serviceuser_name) as serviceuser_name,
		if(ec.source=0,ec.org_name,cb.service_teamorg_name) as service_teamorg_name,
		nvl(ub.position_name,'未知') as position_name,
		count(case when ec.source = 0 then ec.res_id else null end) as rps_recmd_cnt,
		count(case 
				when ec.source = 0 and regexp_replace(substr(ec.handletime,1,10),'-','') between 20170301 and 20170406
				then ec.res_id 
		  end) as rps_recmd_handle_cnt,
		count(case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20170301 and 20170406
							and feedback in (4,2,5)  and ec.source = 0
						then ec.res_id 
				  end) as rps_recmd_satisfied_cnt,		
		count(case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20170301 and 20170406
							and feedback in (4) and ec.source = 0
						then ec.res_id 
				  end) as rps_recmd_satisfied_download_cnt,
		count(case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20170301 and 20170406
							and feedback in (2,5) and ec.source = 0
						then ec.res_id 
				  end) as rps_recmd_satisfied_intention_cnt,

		count(case when ec.source = 4 then ec.res_id else null end) as bole_recmd_cnt,
		count(case 
				when ec.source = 4 and regexp_replace(substr(ec.handletime,1,10),'-','') between 20170301 and 20170406
				then ec.res_id 
		  end) as bole_recmd_handle_cnt,
		count(case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20170301 and 20170406
							and feedback in (4,2,5)  and ec.source = 4
						then ec.res_id 
				  end) as bole_recmd_satisfied_cnt,		
		count(case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20170301 and 20170406
							and feedback in (4) and ec.source = 4
						then ec.res_id 
				  end) as bole_recmd_satisfied_download_cnt,
		count(case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20170301 and 20170406
							and feedback in (2,5) and ec.source = 4
						then ec.res_id 
				  end) as bole_recmd_satisfied_intention_cnt
	from dw_erp_d_ejob_candidate ec
	join (
		select p_date,
			id,
			serviceuser_id,
			serviceuser_name,
			service_teamorg_name 
		from dw_erp_d_customer_base 
		where p_date between 20170301 and 20170331
		) cb
		on cb.id = ec.customer_id
			and cb.p_date = regexp_replace(substr(ec.createtime,1,10),'-','')
	left join (
		select p_date,
			id,
			position_name 
		from dw_erp_d_salesuser_base 
		where p_date between 20170301 and 20170331
		) ub
	on cb.serviceuser_id = ub.id
	and ub.p_date=regexp_replace(substr(ec.createtime,1,10),'-','')
	where regexp_replace(substr(ec.createtime,1,10),'-','') between 20170301 and 20170331 
		and ec.p_date=20170406
		and ec.source in (0,4)
		group by if(ec.source=0,ec.serviceuser_id,cb.serviceuser_id),
		if(ec.source=0,ec.serviceuser_name,cb.serviceuser_name),
		if(ec.source=0,ec.org_name,cb.service_teamorg_name),
		nvl(ub.position_name,'未知')
) recmd;



select id, ecomp_root_id, ecomp_id, customer_id, usere_id, ejob_id, job_title, res_id, readflag, feedback, readtime, handletime, createtime, modifytime, source, score, reason, serviceuser_id, serviceuser_name, org_id, org_name,  res_type, ejob_deleteflag, rps_service_version, rsc_valid_status, p_date
from dw_erp_d_ejob_candidate
where p_date=20170303
and serviceuser_name = '张虹梅'
and regexp_replace(substr(createtime,1,10),'-','') between 20170301 and 20170228 ;