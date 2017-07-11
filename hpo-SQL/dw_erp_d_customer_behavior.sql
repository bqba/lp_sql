select 
behavior.id,
behavior.name,
behavior.is_sr,
behavior.is_jr,
nvl(cover.valid_call_cnt,0) as valid_call_cnt,
case when income.customer_id is not null then 1 else 0 end,
income.first_income_date
from 
(select id,name,
case when sum(is_outer_active_sr) > 0 then 1 else 0 end as is_sr,
case when sum(is_outer_active_sr) = 0  and sum(is_outer_active_jr) > 0 then 1 else 0 end as is_jr,
sum(outer_sr_job_cnt) as outer_sr_job_cnt,
sum(outer_jr_job_cnt) as outer_jr_job_cnt
from dw_erp_d_customer_behavior
where p_date between 20170101 and 20170331
group by id,name
) behavior
left join 
(select customer_id,count(1) as valid_call_cnt
from dw_erp_a_call_record call
join dw_erp_d_salesuser_base suser 
on call.creator_id = suser.id 
and suser.p_date = 20170331
and suser.is_saleuser = 1
where customer_id > 0
and timelong > 45
and call_date between 20170101 and 20170331
group by customer_id
) cover
on behavior.id = cover.customer_id
left join 
(select customer_id,min(d_date) as first_income_date
from dw_erp_a_crmfinance_income
where money > 1000
group by customer_id
having min(d_date) between 20170101 and 20170331
) income 
on behavior.id = income.customer_id






select call_date,timelong
from dw_erp_a_call_record
where customer_id > 0
and call_date between 20170101 and 20170331
and customer_id = 114004
and creator_id = 3157


create table dw_erp_d_customer_behavior
(
id	int	comment '企业id',
name	string	comment '企业名称',
dq	string	comment '地区',
source	int	comment '来源1:51job,2:智联招聘,3:中华英才网,4:拉勾网,5:猎聘网注册,6:HPO录入,7:导入,8:其他',
sign_lpt_type	int	comment '签署合同类型  0 未签约 1 合作 2 断约',
industry	string	comment '行业',
company_scale	string	comment '公司规模',
company_kind	string	comment '公司性质',
company_certificate	string	comment '认证信息',
cachet_certificate	string	comment '红章营业执照',
last_lock_time	string	comment '最后一次锁定时间',
input_id	int	comment '录入人id',
ecomp_id	int	comment '机构id',
ecomp_root_id	int	comment '机构root_id',
parent_customer_id	int	comment '父客户id 为0时是父客户',
is_sub_package_customer	int	comment '是否分支结构或包成员客户',
ecomp_version	int	comment '企业版本',
sales_user_id	int	comment '当前销售顾问id',
sales_user_name	string	comment '当前销售顾问姓名',
sales_org_id	int	comment '当前销售部门id',
sales_org_name	string	comment '当前销售部门名称',
sales_branch_id	int	comment '当前销售分公司',
sales_branch_name	string	comment '当前销售分公司名称',
repertory_industry	string	comment '客户深耕行业',
base_type	int	comment '客户库类型',
repertory_level	int	comment '客户深耕级别',
repertory_branch_id	int	comment '客户深耕所属分公司',
is_outer_active int comment '是否有外部动态',
is_outer_active_sr int comment '是否有外部精英动态',
is_outer_active_jr int comment '是否有外部白领动态',
outer_sr_job_cnt int comment '外部精英职位发布数',
outer_jr_job_cnt int comment '外部白领职位发布数',
creation_timestamp timestamp comment '时间戳'
) comment '客户日动态表'
partitioned by (p_date int);

insert overwrite table dw_erp_d_customer_behavior partition(p_date=$date$)
select 
	main.id,
	main.name,
	main.dq,
	main.source,
	main.sign_lpt_type,
	main.industry,
	main.company_scale,
	main.company_kind,
	main.company_certificate,
	main.cachet_certificate,
	main.last_lock_time,
	main.input_id,
	main.ecomp_id,
	main.ecomp_root_id,
	main.parent_customer_id,
	main.is_sub_package_customer,
	main.ecomp_version,
	main.sales_user_id,
	main.sales_user_name,
	main.sales_org_id,
	main.sales_org_name,
	main.sales_branch_id,
	main.sales_branch_name,
	main.repertory_industry,
	main.base_type,
	main.repertory_level,
	main.repertory_branch_id,
	case when main.is_sr+main.is_jr > 0 then 1 else 0 end as is_outer_active,
	main.is_sr as is_outer_active_sr,
	main.is_jr as is_outer_active_jr,
	main.sr_job_cnt as outer_sr_job_cnt,
	main.jr_job_cnt as outer_jr_job_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp
from (
select 
	cnew.id,
	cnew.name,
	cnew.dq,
	cnew.source,
	cnew.sign_lpt_type,
	cnew.industry,
	cnew.company_scale,
	cnew.company_kind,
	cnew.company_certificate,
	cnew.cachet_certificate,
	cnew.last_lock_time,
	cnew.input_id,
	cnew.ecomp_id,
	cnew.ecomp_root_id,
	cnew.parent_customer_id,
	cnew.is_sub_package_customer,
	cnew.ecomp_version,
	cnew.sales_user_id,
	cnew.sales_user_name,
	cnew.sales_org_id,
	cnew.sales_org_name,
	cnew.sales_branch_id,
	cnew.sales_branch_name,
	cnew.repertory_industry,
	cnew.base_type,
	cnew.repertory_level,
	cnew.repertory_branch_id,
	jm.is_sr,
	jm.is_jr,	
	jm.sr_job_cnt,
	jm.jr_job_cnt,
	row_number()over(distribute by cnew.id sort by jm.is_sr desc) as rn 
from 
(
	select jmain.job_com_id,
		   case when sum(job_level) > 0 then 1 else 0 end as is_sr,
		   sum(job_level) as sr_job_cnt,
		   case when sum(1) > 0 and sum(job_level) = 0 then 1 else 0 end is_jr,
		   sum(1) - sum(job_level) as jr_job_cnt
	from (select job_id,job_com_id,
		        case when job_salary_low >= 10 or 
		       			  (job_salary_low = 0 and ((contains_any(job_title,'COO','CTO','CDO','CEO','CFO','架构师','经理','总监','VP','Manager','Supervisor','厂长','行长','院长','校长') and not contains_any(job_title,'专员','客户经理')) 
		       			  							or (job_title like '%高级%工程师%' or  job_title like '%高级%开发%' or job_title like '%高级%研发%' ))
		       			  ) then '1' 
		       	else '0' end as job_level  
			from job_main
			where regexp_replace(substr(createtime,1,10),'-','') = '$date$'
		 ) jmain 
	group by jmain.job_com_id

) jm
join 
(
	select cmb.com_id,cmb.com_name
	from (
		select regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(cm.com_name,'）',')'),' ',''),'公司',''),'股份',''),'（','(')as com_name,cm.com_id
		from company_main cm
		union all 
		select regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(cma.com_auth_name,'）',')'),' ',''),'公司',''),'股份',''),'（','(') as com_name,cma.com_id
		from company_main cma
	) cmb 
	group by cmb.com_id,cmb.com_name
) cmain
on jm.job_com_id = cmain.com_id
join 
(select id, name, dq, source, sign_lpt_type, industry, company_scale, company_kind, company_certificate, cachet_certificate, last_lock_time, input_id, ecomp_id, ecomp_root_id, parent_customer_id, null as is_sub_package_customer, ecomp_version, sales_user_id, sales_user_name, sales_org_id, sales_org_name, sales_branch_id, sales_branch_name, repertory_industry, base_type, repertory_level,repertory_branch_id,modifytime
  from dw_erp_d_customer_base
 where  company_certificate != ''
   and  name != '公司'
   and  p_date = $date$
   and  delete_flag = 0
) cnew
on cmain.com_name = regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(cnew.name,'）',')'),' ',''),'公司',''),'股份',''),'（','(')
) main 
where main.rn = 1;





insert overwrite table dw_erp_d_customer_behavior partition(p_date=$date$)
select 
	main.id,
	main.name,
	main.dq,
	main.source,
	main.sign_lpt_type,
	main.industry,
	main.company_scale,
	main.company_kind,
	main.company_certificate,
	main.cachet_certificate,
	main.last_lock_time,
	main.input_id,
	main.ecomp_id,
	main.ecomp_root_id,
	main.parent_customer_id,
	main.is_sub_package_customer,
	main.ecomp_version,
	main.sales_user_id,
	main.sales_user_name,
	main.sales_org_id,
	main.sales_org_name,
	main.sales_branch_id,
	main.sales_branch_name,
	main.repertory_industry,
	main.base_type,
	main.repertory_level,
	main.repertory_branch_id,
	case when main.is_sr+main.is_jr > 0 then 1 else 0 end as is_outer_active,
	main.is_sr as is_outer_active_sr,
	main.is_jr as is_outer_active_jr,
	main.sr_job_cnt as outer_sr_job_cnt,
	main.jr_job_cnt as outer_jr_job_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp
from (
select 
	cnew.id,
	cnew.name,
	cnew.dq,
	cnew.source,
	cnew.sign_lpt_type,
	cnew.industry,
	cnew.company_scale,
	cnew.company_kind,
	cnew.company_certificate,
	cnew.cachet_certificate,
	cnew.last_lock_time,
	cnew.input_id,
	cnew.ecomp_id,
	cnew.ecomp_root_id,
	cnew.parent_customer_id,
	cnew.is_sub_package_customer,
	cnew.ecomp_version,
	cnew.sales_user_id,
	cnew.sales_user_name,
	cnew.sales_org_id,
	cnew.sales_org_name,
	cnew.sales_branch_id,
	cnew.sales_branch_name,
	cnew.repertory_industry,
	cnew.base_type,
	cnew.repertory_level,
	cnew.repertory_branch_id,
	jm.is_sr,
	jm.is_jr,	
	jm.sr_job_cnt,
	jm.jr_job_cnt,
	row_number()over(distribute by cnew.id sort by jm.is_sr desc) as rn 
from 
(
	select jmain.job_com_id,
		   case when sum(job_level) > 0 then 1 else 0 end as is_sr,
		   sum(job_level) as sr_job_cnt,
		   case when sum(1) > 0 and sum(job_level) = 0 then 1 else 0 end is_jr,
		   sum(1) - sum(job_level) as jr_job_cnt
	from (select job_id,job_com_id,
		        case when job_salary_low >= 10 or 
		       			  (job_salary_low = 0 and ((contains_any(job_title,'COO','CTO','CDO','CEO','CFO','架构师','经理','总监','VP','Manager','Supervisor','厂长','行长','院长','校长') and not contains_any(job_title,'专员','客户经理')) 
		       			  							or (job_title like '%高级%工程师%' or  job_title like '%高级%开发%' or job_title like '%高级%研发%' ))
		       			  ) then '1' 
		       	else '0' end as job_level  
			from job_main
			where regexp_replace(substr(createtime,1,10),'-','') = '$date$'
		 ) jmain 
	group by jmain.job_com_id

) jm
join 
(
	select cmb.com_id,cmb.com_name
	from (
		select regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(cm.com_name,'）',')'),' ',''),'公司',''),'股份',''),'（','(')as com_name,cm.com_id
		from company_main cm
		union all 
		select regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(cma.com_auth_name,'）',')'),' ',''),'公司',''),'股份',''),'（','(') as com_name,cma.com_id
		from company_main cma
	) cmb 
	group by cmb.com_id,cmb.com_name
) cmain
on jm.job_com_id = cmain.com_id
join 
(select id, name, dq, source, sign_lpt_type, industry, company_scale, company_kind, company_certificate, cachet_certificate, last_lock_time, input_id, ecomp_id, ecomp_root_id, parent_customer_id, null as is_sub_package_customer, ecomp_version, sales_user_id, sales_user_name, sales_org_id, sales_org_name, sales_branch_id, sales_branch_name, repertory_industry, base_type, repertory_level,repertory_branch_id,modifytime
  from dw_erp_d_customer_base
 where  company_certificate != ''
   and  name != '公司'
   and  p_date = $date$
   and  delete_flag = 0
) cnew
on cmain.com_name = regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(cnew.name,'）',')'),' ',''),'公司',''),'股份',''),'（','(')
) main 
where main.rn = 1;



insert overwrite table dw_erp_d_customer_behavior partition(p_date=$date$)
select	
	cnew.id,
	cnew.name,
	cnew.dq,
	cnew.source,
	cnew.sign_lpt_type,
	cnew.industry,
	cnew.company_scale,
	cnew.company_kind,
	cnew.company_certificate,
	cnew.cachet_certificate,
	cnew.last_lock_time,
	cnew.input_id,
	cnew.ecomp_id,
	cnew.ecomp_root_id,
	cnew.parent_customer_id,
	cnew.is_sub_package_customer,
	cnew.ecomp_version,
	cnew.sales_user_id,
	cnew.sales_user_name,
	cnew.sales_org_id,
	cnew.sales_org_name,
	cnew.sales_branch_id,
	cnew.sales_branch_name,
	cnew.repertory_industry,
	cnew.base_type,
	cnew.repertory_level,
	cnew.repertory_branch_id,
	case when jm.is_sr+jm.is_jr > 0 then 1 else 0 end as is_outer_active,	
	jm.is_sr as is_outer_active_sr,
	jm.is_jr as is_outer_active_jr,
	jm.sr_job_cnt as outer_sr_job_cnt,
	jm.jr_job_cnt as outer_jr_job_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp
from 	
(select id, name, dq, source, sign_lpt_type, industry, company_scale, company_kind, company_certificate, cachet_certificate, last_lock_time, input_id, ecomp_id, ecomp_root_id, parent_customer_id, null as is_sub_package_customer, ecomp_version, sales_user_id, sales_user_name, sales_org_id, sales_org_name, sales_branch_id, sales_branch_name, repertory_industry, base_type, repertory_level,repertory_branch_id,modifytime
  from dw_erp_d_customer_base
 where  company_certificate != ''
   and  name != '公司'
   and  p_date = $date$
   and  delete_flag = 0
) cnew
join 
(
   select ch.match_name,
			case when count(case when job_level = 0 then ch.hawkeye_customer_id else null end) > 0 then 1 else 0 end as is_sr,
		    count(case when job_level = 0 then ch.hawkeye_customer_id else null end) as sr_job_cnt,
		    case when count(case when job_level = 0 then ch.hawkeye_customer_id else null end) = 0 and count(case when job_level = 1 then ch.hawkeye_customer_id else null end) > 0 then 1 else 0 end as is_jr,
		    count(ch.hawkeye_customer_id) - count(case when job_level = 0 then ch.hawkeye_customer_id else null end)  as jr_job_cnt
   from 
    (select
			hc.customer_id, 
			cd.hawkeye_customer_id,
			cd.job_level,
			regexp_replace(hc.name,"(and)|(exec)|(insert)|(select)|(delete)|(update)|(\\*)|(\\%)|(chr)|(mid)|(master)|(truncate)|(char)|(declare)|(\\;)|(or)|(\\-)|(\\+)|(\\,)|(\\!)|(\\()|(\\))|(\\）)|(\\（)","") as match_name
		from customer_dynamic cd
		left outer join  hawkeye_customer hc 
		on cd.hawkeye_customer_id = hc.id
		and hc.deleteflag = 0
		where cd.deleteflag = 0 
		 and (substr(regexp_replace(cd.job_publish_time,'-',''),1,8) = '$date$'  
					or substr(regexp_replace(cd.job_modify_time,'-',''),1,8) = '$date$')
	) ch 
   group by ch.match_name
) jm   	
on cnew.name = jm.match_name;






select	
	cnew.id,
	cnew.name,
	cnew.dq,
	cnew.source,
	cnew.sign_lpt_type,
	cnew.industry,
	cnew.company_scale,
	cnew.company_kind,
	cnew.company_certificate,
	cnew.cachet_certificate,
	cnew.last_lock_time,
	cnew.input_id,
	cnew.ecomp_id,
	cnew.ecomp_root_id,
	cnew.parent_customer_id,
	cnew.is_sub_package_customer,
	cnew.ecomp_version,
	cnew.sales_user_id,
	cnew.sales_user_name,
	cnew.sales_org_id,
	cnew.sales_org_name,
	cnew.sales_branch_id,
	cnew.sales_branch_name,
	cnew.repertory_industry,
	cnew.base_type,
	cnew.repertory_level,
	cnew.repertory_branch_id,
	case when jm.is_sr+jm.is_jr > 0 then 1 else 0 end as is_outer_active,	
	jm.is_sr as is_outer_active_sr,
	jm.is_jr as is_outer_active_jr,
	jm.sr_job_cnt as outer_sr_job_cnt,
	jm.jr_job_cnt as outer_jr_job_cnt,
	from_unixtime(unix_timestamp()) as creation_timestamp
	from 
(select id, name, dq, source, sign_lpt_type, industry, company_scale, company_kind, company_certificate, cachet_certificate, last_lock_time, input_id, ecomp_id, ecomp_root_id, parent_customer_id, null as is_sub_package_customer, ecomp_version, sales_user_id, sales_user_name, sales_org_id, sales_org_name, sales_branch_id, sales_branch_name, repertory_industry, base_type, repertory_level,repertory_branch_id,modifytime
  from dw_erp_d_customer_base
 where  company_certificate != ''
   and  name != '公司'
   and  p_date = 20170531
   and  delete_flag = 0
) cnew
join 
(
   select ch.match_name,
  			case when count(case when job_level = 0 then ch.hawkeye_customer_id else null end) > 0 then 1 else 0 end as is_sr,
		    count(case when job_level = 0 then ch.hawkeye_customer_id else null end) as sr_job_cnt,
		    case when count(case when job_level = 0 then ch.hawkeye_customer_id else null end) = 0 and count(case when job_level = 1 then ch.hawkeye_customer_id else null end) > 0 then 1 else 0 end as is_jr,
		    count(ch.hawkeye_customer_id) - count(case when job_level = 0 then ch.hawkeye_customer_id else null end)  as jr_job_cnt
   from 
    (select
			hc.customer_id, 
			cd.hawkeye_customer_id,cd.job_level,
			regexp_replace(hc.name,"(and)|(exec)|(insert)|(select)|(delete)|(update)|(\\*)|(\\%)|(chr)|(mid)|(master)|(truncate)|(char)|(declare)|(or)|(\\-)|(\\+)|(\\,)|(\\!)|(\\()|(\\))|(\\）)|(\\（)","") as match_name
		from customer_dynamic cd
		left outer join  hawkeye_customer hc 
		on cd.hawkeye_customer_id = hc.id
		and hc.deleteflag = 0
		where cd.deleteflag = 0 
		 and (substr(regexp_replace(cd.job_publish_time,'-',''),1,8) = '20170531'  
					or substr(regexp_replace(cd.job_modify_time,'-',''),1,8) = '20170531')
	) ch 
   group by ch.match_name
) jm   	
on cnew.name = jm.match_name