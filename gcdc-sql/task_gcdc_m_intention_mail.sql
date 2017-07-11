select 
'企业名称',
'中高占比',
'无效占比',
'企业所在地区',
'企业所在行业',
'企业规模',
'企业性质',
'职位名称',
'职位所在地点',
'简历编号',
'人选简历行业',
'人选简历地点',
'人选简历职位',
'最后更新简历时间',
'交付效果',
'提交企业时间',
'C顾问姓名',
'C顾问所在组别',
'C顾问所在城市',
'C顾问岗位名称',
'B顾问姓名',
'B顾问所在组别',
'B顾问所在城市',
'B顾问岗位名称'
from dummy;

select 
cust.name,
target.h_m_ratio,
target.n_ratio,
cust_dq.d_ch_name,
cust_industry.d_main_industry,
case  cust.company_scale
    when '010' then '1-49人'
    when '020' then '50-99人'
    when '030' then '100-499人'
    when '040' then '500-999人'
    when '050' then '1000-2000人'
    when '080' then '2000-5000人'
    when '060' then '5000-10000人'
    when '070' then '10000人以上'
    else '未知'
end as company_scale,
case  cust.company_kind
    when '010' then '外商独资/外企办事处'
    when '020' then '中外合营(合资/合作)'
    when '030' then '私营/民营企业'
    when '040' then '国有企业'
    when '050' then '国内上市公司'
    when '080' then '政府机关／非盈利机构'
    when '060' then '事业单位'
    when '070' then '其他'
     else '未知'
end as company_kind, 
dim_jobtitle.d_ch_name,
ejob_dq.d_ch_name,
nvl(res.res_id,res2.res_id),
nvl(c_industry.d_main_industry,c_industry2.d_main_industry),
nvl(c_dq.d_ch_name,c_dq2.d_ch_name),
nvl(c_jobtitle.d_ch_name,c_jobtitle2.d_ch_name),
substr(res.res_modifiedtime,1,7),
case task.result
when 1 then '高'
  when 2 then '中'
  when 3 then '低'
  when 4 then '无'
  when 6 then '未成功沟通-无效人选'
end as result,
task.createtime,
rps.name,
rps.org_name,
rps_org.branch_name,
rps.position_name,
cdc.name,
cdc.org_name,
cdc_org.org_name,
cdc_org.branch_name,
cdc.position_name
from 
(select task.id,task.customer_id,task.res_id,task.rsc_ejob_id,taskblog.result,taskb.creator_id as rps_id,taskc.creator_id as cdc_id,taskblog.createtime
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
        tasklog.createtime
    from (
    select id,result,creator_id,org_id,intention_type,rsc_intention_task_b_id,demand_concat_result,createtime,
         row_number()over(distribute by rsc_intention_task_b_id sort by createtime desc) rn 
      from rsc_intention_task_b_log
     where result in ('1','2','3','4','6')
       and deleteflag = 0
       and intention_type in ('1','2')
       and substr(regexp_replace(tracktime,'-',''),1,6) = substr('$date$',1,6)
       ) tasklog
  where rn = 1
) taskblog
on taskb.id = taskblog.rsc_intention_task_b_id
left join rsc_intention_task_c taskc 
on taskc.rsc_intention_task_b_id = taskb.id 
and taskc.status = 4 
) task 
join (
select 
  task.customer_id,
  count(case when taskblog.result in (1,2) then task.id else null end) as h_m_cnt,
  round(count(case when taskblog.result in (1,2) then task.id else null end) / count(case when taskblog.result in (1,2,3,4) then task.id else null end),2) *100 as h_m_ratio,
  round(count(case when taskblog.result = 6 then task.id else null end) / count(task.id),2) *100 as n_ratio
from rsc_intention task 
join rsc_intention_task_b taskb on taskb.rsc_intention_id = task.id 
join (select    tasklog.id,
        tasklog.result,
        tasklog.creator_id,
        tasklog.org_id,
        tasklog.rsc_intention_task_b_id,
        tasklog.intention_type,
        tasklog.demand_concat_result
    from (
    select id,result,creator_id,org_id,intention_type,rsc_intention_task_b_id,demand_concat_result,
         row_number()over(distribute by rsc_intention_task_b_id sort by createtime desc) rn 
      from rsc_intention_task_b_log
     where result in ('1','2','3','4','6')
       and deleteflag = 0
       and intention_type in ('1','2')
       and substr(regexp_replace(tracktime,'-',''),1,6) = substr('$date$',1,6)
       ) tasklog
  where rn = 1
) taskblog
on taskb.id = taskblog.rsc_intention_task_b_id
where task.deleteflag = 0
group by customer_id
) target
on task.customer_id = target.customer_id
join dw_erp_d_customer_base_new cust 
on task.customer_id = cust.id 
left join rsc_ejob  
on task.rsc_ejob_id = rsc_ejob.id 
left join ejob
on rsc_ejob.ejob_id = ejob.ejob_id
left join dw_c_d_res_base res
on task.res_id =  res.res_id
and res.p_date = '$date$'
left join dim_jobtitle 
on get_first_code(ejob.ejob_jobtitle,',') = dim_jobtitle.d_code
left join dim_dq cust_dq
on cust.dq = cust_dq.d_code
left join dim_dq  ejob_dq
on ejob.ejob_dq = ejob_dq.d_code
left join dim_industry cust_industry
on cust.industry = cust_industry.d_ind_code
left join dim_industry c_industry
on res.c_industry = c_industry.d_ind_code
left join dim_dq c_dq 
on res.c_dq = c_dq.d_code
left join dim_jobtitle c_jobtitle
on res.c_jobtitle = c_jobtitle.d_code
left join res_profile res2
on task.res_id =  res2.res_id
left join dim_industry c_industry2
on res2.res_industry = c_industry2.d_ind_code
left join dim_dq c_dq2
on res2.res_dq = c_dq2.d_code
left join dim_jobtitle c_jobtitle2
on res2.res_jobtitle = c_jobtitle2.d_code
left join dw_erp_d_salesuser_base rps 
on task.rps_id = rps.id 
and rps.p_date = '$date$'
left join dim_org rps_org
on rps.org_id = rps_org.d_org_id
left join dw_erp_d_salesuser_base cdc 
on task.cdc_id = cdc.id 
and cdc.p_date = '$date$'
left join dim_org cdc_org
on cdc.org_id = cdc_org.d_org_id;



select 
'企业名称',
'中高占比',
'无效占比',
'企业所在地区',
'企业所在行业',
'企业规模',
'企业性质',
'职位名称',
'职位所在地点',
'简历编号',
'人选简历行业',
'人选简历地点',
'人选简历职位',
'最后更新简历时间',
'交付效果',
'提交企业时间',
'C顾问姓名',
'C顾问所在组别',
'C顾问所在城市',
'C顾问岗位名称',
'B顾问姓名',
'B顾问所在组别',
'B顾问所在城市',
'B顾问岗位名称'
from dummy;

select 
cust.name,
target.h_m_ratio,
target.n_ratio,
cust_dq.d_ch_name,
cust_industry.d_main_industry,
case  cust.company_scale
    when '010' then '1-49人'
    when '020' then '50-99人'
    when '030' then '100-499人'
    when '040' then '500-999人'
    when '050' then '1000-2000人'
    when '080' then '2000-5000人'
    when '060' then '5000-10000人'
    when '070' then '10000人以上'
    else '未知'
end as company_scale,
case  cust.company_kind
    when '010' then '外商独资/外企办事处'
    when '020' then '中外合营(合资/合作)'
    when '030' then '私营/民营企业'
    when '040' then '国有企业'
    when '050' then '国内上市公司'
    when '080' then '政府机关／非盈利机构'
    when '060' then '事业单位'
    when '070' then '其他'
     else '未知'
end as company_kind, 
dim_jobtitle.d_ch_name,
ejob_dq.d_ch_name,
nvl(res.res_id,res2.res_id),
nvl(c_industry.d_main_industry,c_industry2.d_main_industry),
nvl(c_dq.d_ch_name,c_dq2.d_ch_name),
nvl(c_jobtitle.d_ch_name,c_jobtitle2.d_ch_name),
substr(res.res_modifiedtime,1,7),
case task.result
when 1 then '高'
  when 2 then '中'
  when 3 then '低'
  when 4 then '无'
  when 6 then '未成功沟通-无效人选'
end as result,
task.createtime,
rps.name,
rps.org_name,
rps_org.branch_name,
rps.position_name,
cdc.name,
cdc.org_name,
cdc_org.org_name,
cdc_org.branch_name,
cdc.position_name
from 
(select task.id,task.customer_id,task.res_id,task.rsc_ejob_id,taskblog.result,taskb.creator_id as rps_id,taskc.creator_id as cdc_id,taskblog.createtime
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
        tasklog.createtime
    from (
    select id,result,creator_id,org_id,intention_type,rsc_intention_task_b_id,demand_concat_result,createtime,
         row_number()over(distribute by rsc_intention_task_b_id sort by createtime desc) rn 
      from rsc_intention_task_b_log
     where result in ('1','2','3','4','6')
       and deleteflag = 0
       and intention_type in ('1','2')
       and substr(regexp_replace(tracktime,'-',''),1,4) = 2016
       ) tasklog
  where rn = 1
) taskblog
on taskb.id = taskblog.rsc_intention_task_b_id
left join rsc_intention_task_c taskc 
on taskc.rsc_intention_task_b_id = taskb.id 
and taskc.status = 4 
) task 
join (
select 
  task.customer_id,
  count(case when taskblog.result in (1,2) then task.id else null end) as h_m_cnt,
  round(count(case when taskblog.result in (1,2) then task.id else null end) / count(case when taskblog.result in (1,2,3,4) then task.id else null end),2) *100 as h_m_ratio,
  round(count(case when taskblog.result = 6 then task.id else null end) / count(task.id),2) *100 as n_ratio
from rsc_intention task 
join rsc_intention_task_b taskb on taskb.rsc_intention_id = task.id 
join (select    tasklog.id,
        tasklog.result,
        tasklog.creator_id,
        tasklog.org_id,
        tasklog.rsc_intention_task_b_id,
        tasklog.intention_type,
        tasklog.demand_concat_result
    from (
    select id,result,creator_id,org_id,intention_type,rsc_intention_task_b_id,demand_concat_result,
         row_number()over(distribute by rsc_intention_task_b_id sort by createtime desc) rn 
      from rsc_intention_task_b_log
     where result in ('1','2','3','4','6')
       and deleteflag = 0
       and intention_type in ('1','2')
       and substr(regexp_replace(tracktime,'-',''),1,4) = 2016
       ) tasklog
  where rn = 1
) taskblog
on taskb.id = taskblog.rsc_intention_task_b_id
where task.deleteflag = 0
group by customer_id
) target
on task.customer_id = target.customer_id
join dw_erp_d_customer_base_new cust 
on task.customer_id = cust.id 
left join rsc_ejob  
on task.rsc_ejob_id = rsc_ejob.id 
left join ejob
on rsc_ejob.ejob_id = ejob.ejob_id
left join dw_c_d_res_base res
on task.res_id =  res.res_id
and res.p_date = '20170207'
left join dim_jobtitle 
on get_first_code(ejob.ejob_jobtitle,',') = dim_jobtitle.d_code
left join dim_dq cust_dq
on cust.dq = cust_dq.d_code
left join dim_dq  ejob_dq
on ejob.ejob_dq = ejob_dq.d_code
left join dim_industry cust_industry
on cust.industry = cust_industry.d_ind_code
left join dim_industry c_industry
on res.c_industry = c_industry.d_ind_code
left join dim_dq c_dq 
on res.c_dq = c_dq.d_code
left join dim_jobtitle c_jobtitle
on res.c_jobtitle = c_jobtitle.d_code
left join res_profile res2
on task.res_id =  res2.res_id
left join dim_industry c_industry2
on res2.res_industry = c_industry2.d_ind_code
left join dim_dq c_dq2
on res2.res_dq = c_dq2.d_code
left join dim_jobtitle c_jobtitle2
on res2.res_jobtitle = c_jobtitle2.d_code
left join dw_erp_d_salesuser_base rps 
on task.rps_id = rps.id 
and rps.p_date = '20170207'
left join dim_org rps_org
on rps.org_id = rps_org.d_org_id
left join dw_erp_d_salesuser_base cdc 
on task.cdc_id = cdc.id 
and cdc.p_date = '20170207'
left join dim_org cdc_org
on cdc.org_id = cdc_org.d_org_id