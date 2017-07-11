--head:"客户名称	客户所在地区	客户所属行业	客户当前版本	客户当前是否有效	月份	现招服姓名	招服团队	招服岗位	客户执行中合同金额	职位主动投递人数	邀请应聘主动投递人数	急聘主动投递人数	搜索下载	人工推荐下载	伯乐推荐下载	意向沟通高	意向沟通中	面试快推荐人数	RPO+PM推荐人数"
select regexp_replace(cntt.cusomter_name,'	','') as customer_name,
	cntt.dq,
	cntt.industry,
	cntt.version,
	cntt.valid_status,
	cntt.d_month,
	cntt.serviceuser_name,
	cntt.service_teamorg_name,
	cntt.position_name,
	cntt.contract_amount,
	nvl(aply.apply_cnt,0) as apply_cnt,
	nvl(invite.invite_apply_cnt,0) as invite_apply_cnt,
	nvl(urgent.urgent_apply_cnt,0) as urgent_apply_cnt,
	nvl(schd.download_search_cv_cnt,0) as download_search_cv_cnt,
	nvl(rcmd.rps_recmd_download_cnt,0) as rps_recmd_download_cnt,
	nvl(rcmd.bole_recmd_download_cnt,0) as bole_recmd_download_cnt,
	nvl(inten.h_cnt,0) as intention_h_cnt,
	nvl(inten.m_cnt,0) as intention_m_cnt,
	nvl(msk.msk_recmd_cnt,0) as msk_recmd_cnt,
	nvl(rpo.rpo_recmd_cnt,0) as rpo_recmd_cnt
from 
(select dd.d_month,
	cntt.customer_id,
	cust.name as cusomter_name,
	nvl(dq.d_ch_name,'未知') as dq,
	nvl(di.d_sub_industry,'未知') as industry,
	nvl(pel.enum_name,'未知') as version,
	if(cust.rsc_valid_status=1,'是','否') as valid_status,
	cust.serviceuser_name,
	cust.service_teamorg_name,
	suser.position_name,
	cust.ecomp_id as ecomp_root_id,
	sum(cntt.money) as contract_amount
from dw_erp_d_contract_base cntt
join crm_contract_lpt ccl
on cntt.id = ccl.contract_id
	and ccl.deleteflag = 0
join dim_date dd
on dd.is_last_day_in_month=1
	and dd.d_date between ${start_date} and ${end_date}
join dw_erp_d_customer_base cust
on cust.id = cntt.customer_id
	and cust.p_date = '${end_date}'
left join pub_enum_list pel
on cust.ecomp_version = pel.enum_code
	and pel.enum_type='ecomp_version'
	and pel.src_table='crm_customer'
	and pel.is_default=1
left join dw_erp_d_salesuser_base suser
on cust.serviceuser_id = suser.id
	and suser.p_date = '${end_date}'
left join dim_dq dq
on cust.dq = dq.d_code
left join dim_industry di
on cust.industry = di.d_ind_code
where cntt.p_date = '${end_date}'
and cntt.type in (0,14)
and cntt.subaction = 0
and cntt.status in (2,3)
--and cntt.money>0
and regexp_replace(cntt.lpt_service_effect_date,'-','') <= dd.d_date
and regexp_replace(cntt.lpt_service_expired_date,'-','') >= concat(substr(dd.d_date,1,6),'01')
group by dd.d_month,
	cntt.customer_id,
	cust.name,
	cust.serviceuser_name,
	cust.service_teamorg_name,
	suser.position_name,
	nvl(dq.d_ch_name,'未知'),
	nvl(di.d_sub_industry,'未知'),
	nvl(pel.enum_name,'未知'),
	cust.rsc_valid_status,
	cust.ecomp_id
) cntt
left join 
( select 
		dd.d_month,
		ur.ecomp_root_id,
		count(appejob_id) as apply_cnt
	from usere_recvapp ur
	join dim_date dd
	on substr(ur.appejob_createtime,1,8)= dd.d_date
	and dd.d_date between ${start_date} and ${end_date}
	where substr(regexp_replace(ur.appejob_createtime,'-',''),1,8) between ${start_date} and ${end_date}
	and ur.appejob_category!=4
	group by dd.d_month,
		ur.ecomp_root_id
) aply
on cntt.ecomp_root_id = aply.ecomp_root_id
and cntt.d_month = aply.d_month
left join
(select ecv.d_month,
		ecv.ecomp_root_id,
		count(ecv.res_id) as download_search_cv_cnt
	from 
	(select
			p_date, 
			user_id,
			nvl(get_json_object(data_info, '$.res_id'), decode_res_id(extract_url_param(url, 'res_id_encode'))) as res_id
		from tlog 
		where url like 'https://lpt.liepin.com/resume/showresumedetail%ck=%'
		and type = 'c'
		and info = 'b_resume_download'
		and p_date between ${start_date} and ${end_date}
	) tl 
	join (
	select 
		distinct 
		dd.d_date,
		dd.d_month,
		cd.res_id,
		cd.usere_id,
		cd.ecomp_root_id
	from e_cv_download cd
	join dim_date dd
	on regexp_replace(substr(cd.createtime, 1, 10),'-','') = dd.d_date
	and dd.d_date between ${start_date} and ${end_date}
	where substr(regexp_replace(createtime,'-',''), 1, 8) between ${start_date} and ${end_date}
	) ecv
		on tl.res_id = ecv.res_id
			and tl.user_id = ecv.usere_id 
			and tl.p_date = ecv.d_date
	group by ecv.d_month,
		ecv.ecomp_root_id
) schd --搜索下载
on cntt.ecomp_root_id = schd.ecomp_root_id
	and cntt.d_month = schd.d_month
left join
(select dd.d_month,
		task.customer_id,
		count(case when taskblog.result=1 then taskblog.id end) as h_cnt,
		count(case when taskblog.result=2 then taskblog.id end) as m_cnt
	from rsc_intention task 
	join rsc_intention_task_b taskb
	on taskb.rsc_intention_id = task.id
	join (select    tasklog.id,
	        tasklog.result,
	        tasklog.creator_id,
	        tasklog.org_id,
	        tasklog.rsc_intention_task_b_id,
	        tasklog.intention_type,
	        tasklog.demand_concat_result,
	        tasklog.createtime,
	        regexp_replace(substr(tasklog.createtime,1,10),'-','') as d_date
	    from (
	    select id,result,creator_id,org_id,intention_type,rsc_intention_task_b_id,demand_concat_result,createtime,
	         row_number()over(distribute by rsc_intention_task_b_id sort by createtime desc) rn 
	      from rsc_intention_task_b_log
	     where result in ('1','2','3','4','5')
	       and deleteflag = 0
	       and intention_type in ('1','2')
	       and substr(regexp_replace(tracktime,'-',''),1,8) between ${start_date} and ${end_date}
	       ) tasklog
	  where rn = 1
	    and result = 1 --可以进一步沟通
	    and substr(regexp_replace(tasklog.createtime,'-',''),1,8) between ${start_date} and ${end_date}
	) taskblog
	on taskb.id = taskblog.rsc_intention_task_b_id
	join dim_date dd
	on taskblog.d_date = dd.d_date
	and dd.d_date between ${start_date} and ${end_date}
	group by dd.d_month,
		task.customer_id
) inten
on cntt.customer_id = inten.customer_id
and cntt.d_month = inten.d_month
left join
(	
	select 
		dd.d_month,
		recmd.ecomp_root_id,
		count(distinct case when recmd.source=0 then concat_ws(',',cast(recmd.ejob_id as string),cast(recmd.res_id as string)) end) as rps_recmd_download_cnt,
		count(distinct case when recmd.source=4 then concat_ws(',',cast(recmd.ejob_id as string),cast(recmd.res_id as string)) end) as bole_recmd_download_cnt
	from 
		(select ecomp_root_id,
			ejob_id,
			res_id,
			source,
			regexp_replace(substr(handletime,1,10),'-','') as d_date
		from e_bole_recommend_info 
		where substr(regexp_replace(handletime,'-',''),1,8) between ${start_date} and ${end_date}
			and feedback = 4
			and source in (0,4)
		union all 
		select ecomp_root_id,
			ejob_id,
			res_id,
			source,
			regexp_replace(substr(handletime,1,10),'-','') as d_date
		from e_bole_recommend_history
		where substr(regexp_replace(handletime,'-',''),1,8) between ${start_date} and ${end_date}
			and feedback = 4
			and source in (0,4)
	) recmd
	join dim_date dd
	on dd.d_date=recmd.d_date
		and dd.d_date between ${start_date} and ${end_date}
	group by dd.d_month,
		recmd.ecomp_root_id
) rcmd --推荐下载
on cntt.ecomp_root_id = rcmd.customer_id
and cntt.d_month = rcmd.d_month
left join
(select dd.d_month,
	rj.customer_id,
	count(rcan.candidate_id) as rpo_recmd_cnt
from dw_god_d_rpo_candidate rcan 
join dw_god_d_rpo_job rj
on rcan.job_id = rj.job_id
and rj.p_date = '${end_date}'
join dim_date dd
on dd.d_date=regexp_replace(substr(rcan.recommend_time,1,10),'-','')
and dd.d_date between ${start_date} and ${end_date}
where rcan.p_date = '${end_date}'
and substr(regexp_replace(rcan.recommend_time,'-',''),1,8) between ${start_date} and ${end_date}
group by dd.d_month,
	rj.customer_id
) rpo
on cntt.customer_id = rpo.customer_id
and cntt.d_month = rpo.d_month
left join
(SELECT 
	dd.d_month,
	mskejob.customer_id,
	count(candidatelog.id) as msk_recmd_cnt
FROM msk_ejob_candidate_log candidatelog 
join dim_date dd
on dd.d_date = regexp_replace(substr(candidatelog.createtime,1,10),'-','')
	and dd.d_date between ${start_date} and ${end_date}
left join msk_ejob mskejob 
  on mskejob.id = candidatelog.msk_ejob_id
where candidatelog.deleteflag = 0
   and candidatelog.status in (1)
   and substr(regexp_replace(candidatelog.createTime,'-',''),1,8) between ${start_date} and ${end_date}
group by dd.d_month,
	mskejob.customer_id
) msk
on cntt.customer_id = msk.customer_id
and cntt.d_month = msk.d_month
left join 
(select 
		invite.ecomp_root_id,
		invite.d_month,
		count(distinct case when invite.invite_month=recv.app_month and invite.invite_date<=recv.app_date then concat_ws(',',cast(recv.ejob_id as string),cast(recv.res_id as string)) end) as invite_apply_cnt
	from 
	(select 
		ejob_id,
		ecomp_root_id,
		invite_date,
		invite_month,
		d_month,
		userc_id
	from (
		select 
			ia.ejob_id,
			ia.ecomp_root_id,
			dd.d_month,
			regexp_replace(substr(ia.liu_createtime,1,10),'-','') as invite_date,
			regexp_replace(substr(ia.liu_createtime,1,7),'-','') as invite_month,
			split(liu_userc_ids, ',') as userc_ids
		from dw_b_d_invite_apply  ia
		join dim_date dd
		on ia.p_date = dd.d_date
		and dd.d_date between ${start_date} and ${end_date}
		where p_date between ${start_date} and ${end_date}
		) ivt 
		lateral view explode(userc_ids) subview as userc_id
	) invite
	left join 
	(select ur.ejob_id,
					ur.res_id,
					ur.user_id as userc_id,
					substr(ur.appejob_createtime,1,8) as app_date,
					substr(ur.appejob_createtime,1,6) as app_month
			from usere_recvapp ur
		where substr(regexp_replace(ur.appejob_createtime,'-',''),1,8) between ${start_date} and ${end_date}
			and ur.appejob_category!=4
	) recv
		on invite.ejob_id = recv.ejob_id
		and invite.userc_id = recv.userc_id
	group by invite.ecomp_root_id,
		invite.d_month
) invite
on cntt.ecomp_root_id = invite.ecomp_root_id
and cntt.d_month = invite.d_month
left join
(select uj.ecomp_root_id,
		recv.d_month,
		count(distinct case when recv.apply_date between uj.start_time and uj.end_time then concat_ws(',',cast(recv.ejob_id as string),cast(recv.res_id as string)) end) as urgent_apply_cnt
	from (
		select uja.id as urgent_id,
			uja.ejob_id,
			eb.ecomp_root_id,
			substr(uja.start_time, 1, 8) as start_time,
			ifempty(substr(uja.end_time,1,8), regexp_replace(date_add(substr(reformat_datetime(uja.start_time), 1, 10), 6), '-', '')) as end_time
			from webmanager_urgent_job_auditlog uja
			join dw_b_d_ejob_base eb
			on uja.ejob_id = eb.ejob_id
			and ifempty(substr(uja.end_time,1,8), regexp_replace(date_add(substr(reformat_datetime(uja.start_time), 1, 10), 6), '-', '')) = eb.p_date
			and eb.p_date between ${start_date} and ${end_date}
		where uja.operate_status = 0
		and ifempty(substr(uja.end_time,1,8), regexp_replace(date_add(substr(reformat_datetime(uja.start_time), 1, 10), 6), '-', '')) between ${start_date} and ${end_date}
		) uj
	join  
	(select ur.ejob_id,
				ur.res_id,
				dd.d_month,
				substr(ur.appejob_createtime,1,8) as apply_date
		from usere_recvapp ur
		join dim_date dd
			on substr(ur.appejob_createtime,1,8) = dd.d_date
			  and dd.d_date between ${start_date} and ${end_date}
		where substr(regexp_replace(ur.appejob_createtime,'-',''),1,8) between ${start_date} and ${end_date}
		and ur.appejob_category!=4
	) recv
	on uj.ejob_id = recv.ejob_id
	group by uj.ecomp_root_id,
		recv.d_month
) urgent
on cntt.ecomp_root_id = urgent.ecomp_root_id
and cntt.d_month = urgent.d_month;