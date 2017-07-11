insert overwrite table fact_h_gcdc_d_rps_resource_consume partition (p_date)
select 20170328 as d_date,
	su.serviceuser_id as rps_id,
	nvl(esb.name,'未知') as rps_name,
	nvl(esb.position_id,-1) as position_id,
	nvl(esb.position_name,'未知') as position_name,
	nvl(esb.org_id,-1) as rps_org_id,
	nvl(esb.org_name,'未知') as rps_org_name,
	nvl(org.branch_id,-1) as rps_branch_id,
	nvl(org.branch_name,'未知') as rps_branch_name,
	nvl(org.area_id,-1) as rps_area_id,
	nvl(org.area_name,'未知') as rps_area_name,
	nvl(su.cust_cv_cnt,0) as cust_cv_cnt,
	nvl(su.cust_exchangelowcv_cv_cnt,0) as cust_exchangelowcv_cv_cnt,
	nvl(su.cust_intention_cnt,0) as cust_intention_cnt,
	nvl(su.cust_invitation_cnt,0) as cust_invitation_cnt,
	nvl(su.cust_urgent_cnt,0) as cust_urgent_cnt,
	nvl(su.cust_msk_cnt,0) as cust_msk_cnt,
	nvl(su.cust_mskplus_cnt,0) as cust_mskplus_cnt,
	nvl(su.cust_rzk_cnt,0) as cust_rzk_cnt,
	nvl(su.cust_mskcoupon_cnt,0) as cust_mskcoupon_cnt,
	nvl(su.cust_cvcoupon_cnt,0) as cust_cvcoupon_cnt,
	nvl(su.cust_resource_cnt,0) as cust_resource_cnt,
	nvl(su.rps_msk_cv_cnt,0) as rps_msk_cv_cnt,
	nvl(su.rps_mskcoupon_cnt,0) as rps_mskcoupon_cnt,
	current_timestamp() as create_timestamp,
	nvl(su.day_consume_cv_target_cnt,0) as cust_resource_target_cnt,
	nvl(su.rsc_valid_status,-1) as rsc_valid_status,
	20170328 as p_date
from (
	select coalesce(cust.serviceuser_id,target.serviceuser_id,rps.serviceuser_id) as serviceuser_id,
		   coalesce(cust.rsc_valid_status,target.rsc_valid_status,rps.rsc_valid_status) as rsc_valid_status,
		sum(nvl(cust.cust_cv_cnt, 0)) as cust_cv_cnt,
		sum(nvl(cust.cust_intention_cnt, 0)) as cust_intention_cnt,
		sum(nvl(cust.cust_invitation_cnt, 0)) as cust_invitation_cnt,
		sum(nvl(cust.cust_urgent_cv_cnt, 0)) as cust_urgent_cnt,
		sum(nvl(cust.cust_msk_cv_cnt, 0)) as cust_msk_cnt,
		sum(nvl(cust.cust_mskplus_cv_cnt, 0)) as cust_mskplus_cnt,
		sum(nvl(cust.rzk_cv_cnt, 0)) as cust_rzk_cnt,
		sum(nvl(cust.cust_mskcoupon_cnt, 0)) as cust_mskcoupon_cnt,
		sum(nvl(cust.cust_cvcoupon_cnt, 0)) as cust_cvcoupon_cnt,
		sum(nvl(cust.cust_exchangelowcv_cv_cnt,0)) as cust_exchangelowcv_cv_cnt,
  		sum(nvl(cust.cust_cv_cnt, 0)
  			+nvl(cust.cust_exchangelowcv_cv_cnt,0)
  			+nvl(cust.cust_intention_cnt, 0)
  			+nvl(cust.cust_invitation_cnt, 0)
  			+nvl(cust.cust_urgent_cv_cnt, 0)
  			+nvl(cust.cust_msk_cv_cnt, 0)
  			+nvl(cust.cust_mskcoupon_cnt, 0)
  			+nvl(cust.cust_mskplus_cv_cnt, 0)
  			+nvl(cust.rzk_cv_cnt, 0)
  			+nvl(cust.cust_cvcoupon_cnt,0)) as cust_resource_cnt,
		sum(nvl(rps.rps_msk_cv_cnt, 0)) as rps_msk_cv_cnt,
		sum(nvl(rps.rps_mskcoupon_cnt, 0)) as rps_mskcoupon_cnt,
		sum(nvl(target.day_consume_cv_target_cnt,0)) as day_consume_cv_target_cnt
	from (
		select cbn.serviceuser_id,cbn.rsc_valid_status,
			sum(rc.consume_cv) as cust_cv_cnt,
			sum(rc.consume_intention * 2 + rc.consume_intention_cv) as cust_intention_cnt,
			sum(rc.consume_invite * 50 + rc.consume_invite_cv) as cust_invitation_cnt,
			sum(rc.consume_urgent_cv) as cust_urgent_cv_cnt,
			sum(rc.consume_msk_cv) as cust_msk_cv_cnt,
			sum(rc.consume_mskplus_cv) as cust_mskplus_cv_cnt,
			sum(rc.consume_rzk_cv) as rzk_cv_cnt,
			sum(rc.consume_mskcoupon * 50) as cust_mskcoupon_cnt,
			sum(rc.consume_cvcoupon) as cust_cvcoupon_cnt,
			sum(rc.exchange_cv2lowcv) as cust_exchangelowcv_cv_cnt
		from dw_b_d_resource_consume rc
		join dw_erp_d_customer_base cbn
		on rc.ecomp_root_id = cbn.ecomp_root_id
		and cbn.ecomp_id = cbn.ecomp_root_id
		and rc.p_date = cbn.p_date
		and cbn.p_date = 20170328
		and rc.p_date = 20170328
		where  cbn.serviceuser_id not in (0,-1)
		group by cbn.serviceuser_id,cbn.rsc_valid_status
		) cust
	full outer join (
		select me.serviceuser_id,me.rsc_valid_status,
			sum(me.msk_cv) as rps_msk_cv_cnt,
			sum(me.mskcoupon*50) as rps_mskcoupon_cnt
		from 
		(select 
			log.creator_id as serviceuser_id,cust.rsc_valid_status,
			sum(log.res_cost) as msk_cv, --自己做单简历数消耗（到场6+强制结束扣除7)
			0 as mskcoupon
		from msk_ejob_candidate_log log 
		left join dw_erp_d_customer_base cust on log.customer_id = cust.id and cust.p_date = '20170328' 
		where substr(regexp_replace(log.createtime, '-', ''), 1, 8) = '20170328'
			and log.status in (2,3,4,5,6,7) 
			and log.deleteflag = 0
		group by log.creator_id,cust.rsc_valid_status
		union all
		select mecl.creator_id as serviceuser_id,cust.rsc_valid_status,
			sum(mskcp.msk_cv) as msk_cv,
			sum(mskcp.mskcoupon) as mskcoupon
			from
			(select business_id as ejob_id,
				0 as msk_cv,
				sum(precost_resource_num) as mskcoupon --自己做单面试快券消耗数
			from (select * 
						from 
						(select rpd.*,
							case when 
								cast(rpd.rpd_id as string) = his.rpd_id and
								cast(rpd.ecomp_root_id as string) = his.ecomp_root_id and
								cast(rpd.ecomp_id as string) = his.ecomp_id and
								cast(rpd.usere_id as string) = his.usere_id and
								cast(rpd.precost_resource_num as string) = his.precost_resource_num and
								cast(rpd.precost_resource_type as string) = his.precost_resource_type and
								cast(rpd.business_id as string) = his.business_id and
								cast(rpd.business_type as string) = his.business_type and
								cast(rpd.precost_state as string) = his.precost_state and
								cast(rpd.expire_state as string) = his.expire_state and
								cast(rpd.create_time as string) = his.create_time and
								cast(rpd.expired_resource_num as string) = his.expired_resource_num and
								cast(rpd.used_resource_num as string) = his.used_resource_num 
							then 0
							else 1 
							end as is_incr
						from resource_precost_detail rpd
						left join recovery.resource_precost_detail_history_20170327_20170327 his
						on cast(rpd.rpd_id as string)=his.rpd_id) rsc
						where is_incr=1 
					) rst
				where substr(regexp_replace(modify_time, '-', ''), 1, 8) = '20170328'
				and business_type = 2
				and precost_resource_type =9
				and precost_state = 1
				group by business_id) mskcp
			join 
			(select ejob_id,creator_id
				from msk_ejob_candidate_log
					where substr(regexp_replace(createtime, '-', ''), 1,8) = '20170328'
					and status in (6) --到场
					and deleteflag = 0
				group by ejob_id,creator_id
			) mecl
			on mskcp.ejob_id = mecl.ejob_id
			join dw_b_d_ejob_base ejob on mecl.ejob_id = ejob.ejob_id and ejob.p_date = '20170328'
			join dw_erp_d_customer_base cust on ejob.ecomp_root_id = cust.ecomp_id and cust.p_date = '20170328' 
	    group by mecl.creator_id,cust.rsc_valid_status
		) me
		group by me.serviceuser_id,me.rsc_valid_status
	) rps
	on cust.serviceuser_id = rps.serviceuser_id
	and cust.rsc_valid_status = rps.rsc_valid_status
	full outer join (
		select ct.serviceuser_id, 1 as rsc_valid_status,
				sum(day_consume_cv_target_cnt) as day_consume_cv_target_cnt
		  from dw_erp_d_customer_consume_target ct 
		  join dim_date_holiday dh 
		  on dh.d_date = '20170328'
		  and is_workday = 1
		  and ct.p_date = dh.d_date
		 where ct.p_date = '20170328'
		 group by ct.serviceuser_id
	) target 
	on cust.serviceuser_id = target.serviceuser_id
	and cust.rsc_valid_status = target.rsc_valid_status
	group by coalesce(cust.serviceuser_id,target.serviceuser_id,rps.serviceuser_id),coalesce(cust.rsc_valid_status,target.rsc_valid_status,rps.rsc_valid_status)
 ) su
left join dw_erp_d_salesuser_base esb
	on su.serviceuser_id = esb.id
		and esb.p_date = '20170328'
left join dim_org org
	on esb.org_id = org.d_org_id
where su.cust_cv_cnt+su.cust_intention_cnt+su.cust_invitation_cnt+su.cust_urgent_cnt+su.cust_msk_cnt+su.cust_mskplus_cnt+su.cust_mskcoupon_cnt+su.cust_cvcoupon_cnt+su.rps_msk_cv_cnt+su.rps_mskcoupon_cnt+su.cust_rzk_cnt+su.cust_exchangelowcv_cv_cnt+su.day_consume_cv_target_cnt<>0;