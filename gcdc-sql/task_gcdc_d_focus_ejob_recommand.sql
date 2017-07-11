select
'员工编号',
'顾问姓名',
'顾问团队',
'顾问职位名称',
'重点职位量',
'重点职位客户量',
'重点职位人工推荐简历职位量',
'重点职位人工推荐简历量',
'重点职位人工推荐满意简历职位量',
'重点职位人工推荐满意简历量',
'重点职位人工推荐不满意简历量',
'重点职位伯乐推荐简历职位量',
'重点职位伯乐推荐简历量',
'重点职位伯乐推荐满意简历职位量',
'重点职位伯乐推荐满意简历量',
'重点职位伯乐推荐不满意简历量',
'重点职位伯乐+人工推荐满意职位量'
from dummy;
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
	sum(bole_rps_recom_ejob_satistied_cnt) as bole_rps_recom_ejob_satistied_cnt
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
		0 as bole_rps_recom_ejob_satistied_cnt
	from 
	(
		select ejob_id,ecomp_root_id
		from dw_b_d_ejob_base 
		where p_date between 20170301 and 20170331
		and ejob_focusflag = 1
		group by ejob_id,ecomp_root_id
	) fc_ejob 
	left join 
	(select ecomp_id,serviceuser_id
	  from dw_erp_d_customer_base 
	  where p_date between 20170301 and 20170331
	  group by ecomp_id,serviceuser_id
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
			count(distinct case when bole_recom_res_satistied_cnt+rps_recom_res_satistied_cnt> 0 then can.ejob_id else null end) as bole_rps_recom_ejob_satistied_cnt
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
	group by cust.serviceuser_id
) fact
join dw_erp_d_salesuser_base suser 
on fact.serviceuser_id = suser.id 
and suser.p_date = 20170331 -- 华东区，华南区，西南区
group by suser.id,
	suser.name,
	suser.org_name,
	suser.position_name;


--task_gcdc_d_focus_ejob_recommand
select
'员工编号',
'顾问姓名',
'顾问团队',
'顾问职位名称',
'重点职位量',
'重点职位客户量',
'重点职位人工推荐简历职位量',
'重点职位人工推荐简历量',
'重点职位人工推荐满意简历职位量',
'重点职位人工推荐满意简历量',
'重点职位人工推荐不满意简历量',
'重点职位伯乐推荐简历职位量',
'重点职位伯乐推荐简历量',
'重点职位伯乐推荐满意简历职位量',
'重点职位伯乐推荐满意简历量',
'重点职位伯乐推荐不满意简历量',
'重点职位伯乐+人工推荐满意职位量'
from dummy;
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
	sum(bole_rps_recom_ejob_satistied_cnt) as bole_rps_recom_ejob_satistied_cnt
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
		0 as bole_rps_recom_ejob_satistied_cnt
	from 
	(
		select ejob_id,ecomp_root_id
		from dw_b_d_ejob_base 
		where p_date between 20170301 and $date$
		and ejob_focusflag = 1
		group by ejob_id,ecomp_root_id
	) fc_ejob 
	left join 
	(select ecomp_id,serviceuser_id
	  from dw_erp_d_customer_base 
	  where p_date between 20170301 and $date$
	  group by ecomp_id,serviceuser_id
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
			count(distinct case when bole_recom_res_satistied_cnt+rps_recom_res_satistied_cnt> 0 then can.ejob_id else null end) as bole_rps_recom_ejob_satistied_cnt
	from   (select ejob_id,substr(regexp_replace(createtime,'-',''),1,8) as recom_date,customer_id,
					count(case when source = 0 then id else null end) as rps_recom_res_cnt,
					count(case when source = 0 and feedback in (2,4,5) then id else null end) as rps_recom_res_satistied_cnt,
					count(case when source = 0 and feedback in (9,6) then id else null end) as rps_recom_res_unsatistied_cnt,
					count(case when source = 4 then id else null end) as bole_recom_res_cnt,
					count(case when source = 4 and feedback in (2,4,5) then id else null end) as bole_recom_res_satistied_cnt,
					count(case when source = 4 and feedback in (9,6) then id else null end) as bole_recom_res_unsatistied_cnt
			   from dw_erp_d_ejob_candidate
			  where p_date = $date$
			    and substr(regexp_replace(createtime,'-',''),1,8) between 20170301 and $date$
			   group by customer_id,ejob_id,substr(regexp_replace(createtime,'-',''),1,8)
			) can 
			left join dw_erp_d_customer_base cust 
			on can.customer_id = cust.id 
			and cust.p_date = can.recom_date
			and cust.p_date between  20170301 and $date$
			join 
			(
				select ejob_id,ecomp_root_id
				from dw_b_d_ejob_base 
				where p_date between  20170301 and $date$
				and ejob_focusflag = 1
				group by ejob_id,ecomp_root_id
			) fc_ejob 
			on can.ejob_id =fc_ejob.ejob_id
	group by cust.serviceuser_id
) fact
join dw_erp_d_salesuser_base suser 
on fact.serviceuser_id = suser.id 
and suser.p_date = $date$ -- 华东区，华南区，西南区
group by suser.id,
	suser.name,
	suser.org_name,
	suser.position_name;

--task_gcdc_d_focus_ejob_recommand_bj
select
'员工编号',
'顾问姓名',
'顾问团队',
'顾问职位名称',
'重点职位量',
'重点职位客户量',
'重点职位人工推荐简历职位量',
'重点职位人工推荐简历量',
'重点职位人工推荐满意简历职位量',
'重点职位人工推荐满意简历量',
'重点职位人工推荐不满意简历量',
'重点职位伯乐推荐简历职位量',
'重点职位伯乐推荐简历量',
'重点职位伯乐推荐满意简历职位量',
'重点职位伯乐推荐满意简历量',
'重点职位伯乐推荐不满意简历量',
'重点职位伯乐+人工推荐满意职位量'
from dummy;
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
	sum(bole_rps_recom_ejob_satistied_cnt) as bole_rps_recom_ejob_satistied_cnt
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
		0 as bole_rps_recom_ejob_satistied_cnt
	from 
	(
		select ejob_id,ecomp_root_id
		from dw_b_d_ejob_base 
		where p_date between 20170301 and $date$
		and ejob_focusflag = 1
		group by ejob_id,ecomp_root_id
	) fc_ejob 
	left join 
	(select ecomp_id,serviceuser_id
	  from dw_erp_d_customer_base 
	  where p_date between 20170301 and $date$
	  group by ecomp_id,serviceuser_id
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
			count(distinct case when bole_recom_res_satistied_cnt+rps_recom_res_satistied_cnt> 0 then can.ejob_id else null end) as bole_rps_recom_ejob_satistied_cnt
	from   (select ejob_id,substr(regexp_replace(createtime,'-',''),1,8) as recom_date,customer_id,
					count(case when source = 0 then id else null end) as rps_recom_res_cnt,
					count(case when source = 0 and feedback in (2,4,5) then id else null end) as rps_recom_res_satistied_cnt,
					count(case when source = 0 and feedback in (9,6) then id else null end) as rps_recom_res_unsatistied_cnt,
					count(case when source = 4 then id else null end) as bole_recom_res_cnt,
					count(case when source = 4 and feedback in (2,4,5) then id else null end) as bole_recom_res_satistied_cnt,
					count(case when source = 4 and feedback in (9,6) then id else null end) as bole_recom_res_unsatistied_cnt
			   from dw_erp_d_ejob_candidate
			  where p_date = $date$
			    and substr(regexp_replace(createtime,'-',''),1,8) between 20170301 and $date$
			   group by customer_id,ejob_id,substr(regexp_replace(createtime,'-',''),1,8)
			) can 
			left join dw_erp_d_customer_base cust 
			on can.customer_id = cust.id 
			and cust.p_date = can.recom_date
			and cust.p_date between  20170301 and $date$
			join 
			(
				select ejob_id,ecomp_root_id
				from dw_b_d_ejob_base 
				where p_date between  20170301 and $date$
				and ejob_focusflag = 1
				group by ejob_id,ecomp_root_id
			) fc_ejob 
			on can.ejob_id =fc_ejob.ejob_id
	group by cust.serviceuser_id
) fact
join dw_erp_d_salesuser_base suser 
on fact.serviceuser_id = suser.id 
and suser.p_date = $date$
join dim_org
on suser.org_id = dim_org.d_org_id
and dim_org.branch_name = '北京' -- 华东区，华南区，西南区
group by suser.id,
	suser.name,
	suser.org_name,
	suser.position_name;


--task_gcdc_d_focus_ejob_recommand_tj
	
月累计重点职位推荐数据-天津
mancj@liepin.com,sunjing@liepin.com,rps.doc.tj@liepin.com,gcdc.doc@liepin.com

select
'员工编号',
'顾问姓名',
'顾问团队',
'顾问职位名称',
'重点职位量',
'重点职位客户量',
'重点职位人工推荐简历职位量',
'重点职位人工推荐简历量',
'重点职位人工推荐满意简历职位量',
'重点职位人工推荐满意简历量',
'重点职位人工推荐不满意简历量',
'重点职位伯乐推荐简历职位量',
'重点职位伯乐推荐简历量',
'重点职位伯乐推荐满意简历职位量',
'重点职位伯乐推荐满意简历量',
'重点职位伯乐推荐不满意简历量',
'重点职位伯乐+人工推荐满意职位量'
from dummy;
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
	sum(bole_rps_recom_ejob_satistied_cnt) as bole_rps_recom_ejob_satistied_cnt
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
		0 as bole_rps_recom_ejob_satistied_cnt
	from 
	(
		select ejob_id,ecomp_root_id
		from dw_b_d_ejob_base 
		where p_date between 20170301 and $date$
		and ejob_focusflag = 1
		group by ejob_id,ecomp_root_id
	) fc_ejob 
	left join 
	(select ecomp_id,serviceuser_id
	  from dw_erp_d_customer_base 
	  where p_date between 20170301 and $date$
	  group by ecomp_id,serviceuser_id
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
			count(distinct case when bole_recom_res_satistied_cnt+rps_recom_res_satistied_cnt> 0 then can.ejob_id else null end) as bole_rps_recom_ejob_satistied_cnt
	from   (select ejob_id,substr(regexp_replace(createtime,'-',''),1,8) as recom_date,customer_id,
					count(case when source = 0 then id else null end) as rps_recom_res_cnt,
					count(case when source = 0 and feedback in (2,4,5) then id else null end) as rps_recom_res_satistied_cnt,
					count(case when source = 0 and feedback in (9,6) then id else null end) as rps_recom_res_unsatistied_cnt,
					count(case when source = 4 then id else null end) as bole_recom_res_cnt,
					count(case when source = 4 and feedback in (2,4,5) then id else null end) as bole_recom_res_satistied_cnt,
					count(case when source = 4 and feedback in (9,6) then id else null end) as bole_recom_res_unsatistied_cnt
			   from dw_erp_d_ejob_candidate
			  where p_date = $date$
			    and substr(regexp_replace(createtime,'-',''),1,8) between 20170301 and $date$
			   group by customer_id,ejob_id,substr(regexp_replace(createtime,'-',''),1,8)
			) can 
			left join dw_erp_d_customer_base cust 
			on can.customer_id = cust.id 
			and cust.p_date = can.recom_date
			and cust.p_date between  20170301 and $date$
			join 
			(
				select ejob_id,ecomp_root_id
				from dw_b_d_ejob_base 
				where p_date between  20170301 and $date$
				and ejob_focusflag = 1
				group by ejob_id,ecomp_root_id
			) fc_ejob 
			on can.ejob_id =fc_ejob.ejob_id
	group by cust.serviceuser_id
) fact
join dw_erp_d_salesuser_base suser 
on fact.serviceuser_id = suser.id 
and suser.p_date = $date$
join dim_org
on suser.org_id = dim_org.d_org_id
and dim_org.branch_name = '天津' -- 华东区，华南区，西南区
group by suser.id,
	suser.name,
	suser.org_name,
	suser.position_name

--task_gcdc_d_focus_ejob_recommand_sh
月累计重点职位推荐数据-上海
mancj@liepin.com,sunjing@liepin.com,rps.doc.sh@liepin.com,gcdc.doc@liepin.com

select
'员工编号',
'顾问姓名',
'顾问团队',
'顾问职位名称',
'重点职位量',
'重点职位客户量',
'重点职位人工推荐简历职位量',
'重点职位人工推荐简历量',
'重点职位人工推荐满意简历职位量',
'重点职位人工推荐满意简历量',
'重点职位人工推荐不满意简历量',
'重点职位伯乐推荐简历职位量',
'重点职位伯乐推荐简历量',
'重点职位伯乐推荐满意简历职位量',
'重点职位伯乐推荐满意简历量',
'重点职位伯乐推荐不满意简历量',
'重点职位伯乐+人工推荐满意职位量'
from dummy;
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
	sum(bole_rps_recom_ejob_satistied_cnt) as bole_rps_recom_ejob_satistied_cnt
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
		0 as bole_rps_recom_ejob_satistied_cnt
	from 
	(
		select ejob_id,ecomp_root_id
		from dw_b_d_ejob_base 
		where p_date between 20170301 and $date$
		and ejob_focusflag = 1
		group by ejob_id,ecomp_root_id
	) fc_ejob 
	left join 
	(select ecomp_id,serviceuser_id
	  from dw_erp_d_customer_base 
	  where p_date between 20170301 and $date$
	  group by ecomp_id,serviceuser_id
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
			count(distinct case when bole_recom_res_satistied_cnt+rps_recom_res_satistied_cnt> 0 then can.ejob_id else null end) as bole_rps_recom_ejob_satistied_cnt
	from   (select ejob_id,substr(regexp_replace(createtime,'-',''),1,8) as recom_date,customer_id,
					count(case when source = 0 then id else null end) as rps_recom_res_cnt,
					count(case when source = 0 and feedback in (2,4,5) then id else null end) as rps_recom_res_satistied_cnt,
					count(case when source = 0 and feedback in (9,6) then id else null end) as rps_recom_res_unsatistied_cnt,
					count(case when source = 4 then id else null end) as bole_recom_res_cnt,
					count(case when source = 4 and feedback in (2,4,5) then id else null end) as bole_recom_res_satistied_cnt,
					count(case when source = 4 and feedback in (9,6) then id else null end) as bole_recom_res_unsatistied_cnt
			   from dw_erp_d_ejob_candidate
			  where p_date = $date$
			    and substr(regexp_replace(createtime,'-',''),1,8) between 20170301 and $date$
			   group by customer_id,ejob_id,substr(regexp_replace(createtime,'-',''),1,8)
			) can 
			left join dw_erp_d_customer_base cust 
			on can.customer_id = cust.id 
			and cust.p_date = can.recom_date
			and cust.p_date between  20170301 and $date$
			join 
			(
				select ejob_id,ecomp_root_id
				from dw_b_d_ejob_base 
				where p_date between  20170301 and $date$
				and ejob_focusflag = 1
				group by ejob_id,ecomp_root_id
			) fc_ejob 
			on can.ejob_id =fc_ejob.ejob_id
	group by cust.serviceuser_id
) fact
join dw_erp_d_salesuser_base suser 
on fact.serviceuser_id = suser.id 
and suser.p_date = $date$
join dim_org
on suser.org_id = dim_org.d_org_id
and dim_org.branch_name = '上海' -- 华东区，华南区，西南区
group by suser.id,
	suser.name,
	suser.org_name,
	suser.position_name


--task_gcdc_d_focus_ejob_recommand_cd
月累计重点职位推荐数据-成都
mancj@liepin.com,sunjing@liepin.com,rps.doc.cd@liepin.com,gcdc.doc@liepin.com
select
'员工编号',
'顾问姓名',
'顾问团队',
'顾问职位名称',
'重点职位量',
'重点职位客户量',
'重点职位人工推荐简历职位量',
'重点职位人工推荐简历量',
'重点职位人工推荐满意简历职位量',
'重点职位人工推荐满意简历量',
'重点职位人工推荐不满意简历量',
'重点职位伯乐推荐简历职位量',
'重点职位伯乐推荐简历量',
'重点职位伯乐推荐满意简历职位量',
'重点职位伯乐推荐满意简历量',
'重点职位伯乐推荐不满意简历量',
'重点职位伯乐+人工推荐满意职位量'
from dummy;
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
	sum(bole_rps_recom_ejob_satistied_cnt) as bole_rps_recom_ejob_satistied_cnt
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
		0 as bole_rps_recom_ejob_satistied_cnt
	from 
	(
		select ejob_id,ecomp_root_id
		from dw_b_d_ejob_base 
		where p_date between 20170301 and $date$
		and ejob_focusflag = 1
		group by ejob_id,ecomp_root_id
	) fc_ejob 
	left join 
	(select ecomp_id,serviceuser_id
	  from dw_erp_d_customer_base 
	  where p_date between 20170301 and $date$
	  group by ecomp_id,serviceuser_id
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
			count(distinct case when bole_recom_res_satistied_cnt+rps_recom_res_satistied_cnt> 0 then can.ejob_id else null end) as bole_rps_recom_ejob_satistied_cnt
	from   (select ejob_id,substr(regexp_replace(createtime,'-',''),1,8) as recom_date,customer_id,
					count(case when source = 0 then id else null end) as rps_recom_res_cnt,
					count(case when source = 0 and feedback in (2,4,5) then id else null end) as rps_recom_res_satistied_cnt,
					count(case when source = 0 and feedback in (9,6) then id else null end) as rps_recom_res_unsatistied_cnt,
					count(case when source = 4 then id else null end) as bole_recom_res_cnt,
					count(case when source = 4 and feedback in (2,4,5) then id else null end) as bole_recom_res_satistied_cnt,
					count(case when source = 4 and feedback in (9,6) then id else null end) as bole_recom_res_unsatistied_cnt
			   from dw_erp_d_ejob_candidate
			  where p_date = $date$
			    and substr(regexp_replace(createtime,'-',''),1,8) between 20170301 and $date$
			   group by customer_id,ejob_id,substr(regexp_replace(createtime,'-',''),1,8)
			) can 
			left join dw_erp_d_customer_base cust 
			on can.customer_id = cust.id 
			and cust.p_date = can.recom_date
			and cust.p_date between  20170301 and $date$
			join 
			(
				select ejob_id,ecomp_root_id
				from dw_b_d_ejob_base 
				where p_date between  20170301 and $date$
				and ejob_focusflag = 1
				group by ejob_id,ecomp_root_id
			) fc_ejob 
			on can.ejob_id =fc_ejob.ejob_id
	group by cust.serviceuser_id
) fact
join dw_erp_d_salesuser_base suser 
on fact.serviceuser_id = suser.id 
and suser.p_date = $date$
join dim_org
on suser.org_id = dim_org.d_org_id
and dim_org.branch_name = '成都' -- 华东区，华南区，西南区
group by suser.id,
	suser.name,
	suser.org_name,
	suser.position_name

--task_gcdc_d_focus_ejob_recommand_gz
月累计重点职位推荐数据-广州
mancj@liepin.com,sunjing@liepin.com,rps.doc.gz@liepin.com,gcdc.doc@liepin.com

select
'员工编号',
'顾问姓名',
'顾问团队',
'顾问职位名称',
'重点职位量',
'重点职位客户量',
'重点职位人工推荐简历职位量',
'重点职位人工推荐简历量',
'重点职位人工推荐满意简历职位量',
'重点职位人工推荐满意简历量',
'重点职位人工推荐不满意简历量',
'重点职位伯乐推荐简历职位量',
'重点职位伯乐推荐简历量',
'重点职位伯乐推荐满意简历职位量',
'重点职位伯乐推荐满意简历量',
'重点职位伯乐推荐不满意简历量',
'重点职位伯乐+人工推荐满意职位量'
from dummy;
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
	sum(bole_rps_recom_ejob_satistied_cnt) as bole_rps_recom_ejob_satistied_cnt
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
		0 as bole_rps_recom_ejob_satistied_cnt
	from 
	(
		select ejob_id,ecomp_root_id
		from dw_b_d_ejob_base 
		where p_date between 20170301 and $date$
		and ejob_focusflag = 1
		group by ejob_id,ecomp_root_id
	) fc_ejob 
	left join 
	(select ecomp_id,serviceuser_id
	  from dw_erp_d_customer_base 
	  where p_date between 20170301 and $date$
	  group by ecomp_id,serviceuser_id
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
			count(distinct case when bole_recom_res_satistied_cnt+rps_recom_res_satistied_cnt> 0 then can.ejob_id else null end) as bole_rps_recom_ejob_satistied_cnt
	from   (select ejob_id,substr(regexp_replace(createtime,'-',''),1,8) as recom_date,customer_id,
					count(case when source = 0 then id else null end) as rps_recom_res_cnt,
					count(case when source = 0 and feedback in (2,4,5) then id else null end) as rps_recom_res_satistied_cnt,
					count(case when source = 0 and feedback in (9,6) then id else null end) as rps_recom_res_unsatistied_cnt,
					count(case when source = 4 then id else null end) as bole_recom_res_cnt,
					count(case when source = 4 and feedback in (2,4,5) then id else null end) as bole_recom_res_satistied_cnt,
					count(case when source = 4 and feedback in (9,6) then id else null end) as bole_recom_res_unsatistied_cnt
			   from dw_erp_d_ejob_candidate
			  where p_date = $date$
			    and substr(regexp_replace(createtime,'-',''),1,8) between 20170301 and $date$
			   group by customer_id,ejob_id,substr(regexp_replace(createtime,'-',''),1,8)
			) can 
			left join dw_erp_d_customer_base cust 
			on can.customer_id = cust.id 
			and cust.p_date = can.recom_date
			and cust.p_date between  20170301 and $date$
			join 
			(
				select ejob_id,ecomp_root_id
				from dw_b_d_ejob_base 
				where p_date between  20170301 and $date$
				and ejob_focusflag = 1
				group by ejob_id,ecomp_root_id
			) fc_ejob 
			on can.ejob_id =fc_ejob.ejob_id
	group by cust.serviceuser_id
) fact
join dw_erp_d_salesuser_base suser 
on fact.serviceuser_id = suser.id 
and suser.p_date = $date$
join dim_org
on suser.org_id = dim_org.d_org_id
and dim_org.branch_name = '广州' -- 华东区，华南区，西南区
group by suser.id,
	suser.name,
	suser.org_name,
	suser.position_name