select count(distinct com.customer_id)
from  
(
select cm.com_id,bc.customer_id,bc.customer_name,com_name,com_auth_name
from company_main cm
join 
(select bcu.customer_id,bcu.customer_name
from
customer bcu
where bcu.customer_name != '公司' and  company_certificate!=''
) bc on regexp_replace(regexp_replace(regexp_replace(regexp_replace(cm.com_name,'）',')'),' ',''),'公司',''),'股份','') = regexp_replace(regexp_replace(regexp_replace(regexp_replace(bc.customer_name,'）',')'),' ',''),'公司',''),'股份','')
union all 
select cm.com_id,bc.customer_id,bc.customer_name,com_name,com_auth_name
from company_main cm
join 
(select bcu.customer_id,bcu.customer_name
from
customer bcu
where bcu.customer_name != '公司' and  company_certificate!=''
) bc on regexp_replace(regexp_replace(regexp_replace(regexp_replace(cm.com_auth_name,'）',')'),' ',''),'公司',''),'股份','') = regexp_replace(regexp_replace(regexp_replace(regexp_replace(bc.customer_name,'）',')'),' ',''),'公司',''),'股份','')
)com
join 
(select job_id,createtime,job_publish_time,job_com_id,job_salary_low,job_title,job_url_encode,
       (case when job_salary_low >= 10 or (job_salary_low = 0 and ((contains_any(job_title,'COO','CTO','CDO',
	   'CEO','CFO','架构师','经理','总监','VP','Manager','Supervisor','厂长','行长','院长','校长') and not contains_any(job_title,'专员','客户经理')) or 
	   (job_title like '%高级%工程师%' or  job_title like '%高级%开发%' or job_title like '%高级%研发%' ))) then '1' else '0' end) as job_level  
from job_main
where (regexp_replace(substr(createtime,1,10),'-','') between 20160905 and 20160911
or regexp_replace(substr(job_publish_time,1,10),'-','') between 20160905 and 20160911)
) jm on com.com_id = jm.job_com_id

////////////////////////////////////////////////////////////////////////////////////////////

select count(distinct com.id)
from  

(
select cm.com_id,bc.id,bc.name,com_name,com_auth_name
from company_main cm
join 
(select bcu.id,bcu.name
from
dw_erp_d_customer_base_new bcu
where bcu.delete_flag =0 
	and bcu.name != '公司'
) bc on regexp_replace(regexp_replace(regexp_replace(regexp_replace(cm.com_name,'）',')'),' ',''),'公司',''),'股份','') = regexp_replace(regexp_replace(regexp_replace(regexp_replace(bc.name,'）',')'),' ',''),'公司',''),'股份','')
union all 
select cm.com_id,bc.id,bc.name,com_name,com_auth_name
from company_main cm
join 
(select bcu.id,bcu.name
from
dw_erp_d_customer_base_new bcu
where bcu.delete_flag =0 
	and bcu.name != '公司'
) bc on regexp_replace(regexp_replace(regexp_replace(regexp_replace(cm.com_auth_name,'）',')'),' ',''),'公司',''),'股份','') = regexp_replace(regexp_replace(regexp_replace(regexp_replace(bc.name,'）',')'),' ',''),'公司',''),'股份','')
)com
join 
(select distinct 
 	id as customer_id
  from dw_erp_d_customer_base_new
where delete_flag = 0
	and rsc_delete_flag = 0
	and company_certificate is not null
) bcc on com.id = bcc.customer_id
join 
(select job_id,createtime,job_publish_time,job_com_id,job_salary_low,job_title,job_url_encode,
       (case when job_salary_low >= 10 or (job_salary_low = 0 and ((contains_any(job_title,'COO','CTO','CDO',
	   'CEO','CFO','架构师','经理','总监','VP','Manager','Supervisor','厂长','行长','院长','校长') and not contains_any(job_title,'专员','客户经理')) or 
	   (job_title like '%高级%工程师%' or  job_title like '%高级%开发%' or job_title like '%高级%研发%' ))) then '1' else '0' end) as job_level  
from job_main
where (regexp_replace(substr(createtime,1,10),'-','') between 20160905 and 20160911
or regexp_replace(substr(job_publish_time,1,10),'-','') between 20160905 and 20160911)
) jm on com.com_id = jm.job_com_id