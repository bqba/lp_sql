--急需职位
--head:"招服ID	招服顾问	所属团队	招服岗位	类型	推荐简历数	推荐简历处理数	满意并下载数	满意并发起意向数	不满意数"
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
		count(ec.res_id) as recmd_cnt,
		count(case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20161201 and 20170105
						then ec.res_id 
				  end) as recmd_handle_cnt,
		count(case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20161201 and 20170105
							and feedback in (4)
						then ec.res_id 
				  end) as recmd_satisfied_download_cnt,
		count(case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20161201 and 20170105
							and feedback in (2,5)
						then ec.res_id 
				  end) as recmd_satisfied_intention_cnt,
		count(case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20161201 and 20170105
							and feedback in (6,9)
						then ec.res_id 
				  end) as recmd_unsatisfied_cnt
	from dw_erp_d_ejob_candidate ec
	join dw_erp_d_ejob eb
	on ec.ejob_id=eb.ejob_id
		and eb.kind in (1,8,9)
		and ec.source in (0,4)
		and eb.p_date=20170105
	join (
		select p_date,
			id,
			serviceuser_id,
			serviceuser_name,
			service_teamorg_name 
		from dw_erp_d_customer_base 
		where p_date between 20161201 and 20161231
		) cb
		on cb.id = ec.customer_id
			and cb.p_date = regexp_replace(substr(ec.createtime,1,10),'-','')
	left join (
		select p_date,
			id,
			position_name 
		from dw_erp_d_salesuser_base 
		where p_date between 20161201 and 20161231
	) ub
	on cb.serviceuser_id = ub.id
		and ub.p_date=regexp_replace(substr(ec.createtime,1,10),'-','')
	where regexp_replace(substr(ec.createtime,1,10),'-','') between 20161201 and 20161231 
		and ec.p_date=20170105
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

--所有职位
--head:"招服ID	招服顾问	所属团队	招服岗位	类型	推荐简历数	推荐简历处理数	满意并下载数	满意并发起意向数	不满意数"
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
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20161201 and 20170105
						then ec.res_id 
				  end) as recmd_handle_cnt,
		count(distinct case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20161201 and 20170105
							and feedback in (4)
						then ec.res_id 
				  end) as recmd_satisfied_download_cnt,
		count(distinct case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20161201 and 20170105
							and feedback in (2,5)
						then ec.res_id 
				  end) as recmd_satisfied_intention_cnt,
		count(distinct case 
						when regexp_replace(substr(ec.handletime,1,10),'-','') between 20161201 and 20170105
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
		where p_date between 20161201 and 20161231
		) cb
		on cb.id = ec.customer_id
			and cb.p_date = regexp_replace(substr(ec.createtime,1,10),'-','')
	left join (
		select p_date,
			id,
			position_name 
		from dw_erp_d_salesuser_base 
		where p_date between 20161201 and 20161231
		) ub
	on cb.serviceuser_id = ub.id
	and ub.p_date=regexp_replace(substr(ec.createtime,1,10),'-','')
	where regexp_replace(substr(ec.createtime,1,10),'-','') between 20161201 and 20161231 
		and ec.p_date=20170105
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