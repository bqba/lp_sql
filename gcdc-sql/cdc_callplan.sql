--2016年7-9月GCDC意向数据(意向沟通中高占比低于60%，无效占比高于10%的意向数据)
--企业名称	企业所在地区	企业所在行业	职位名称	职位所在地点	简历编号	人选简历行业	人选简历地点	人选简历职位	交付效果	最后更新简历时间
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
'简历编号',
'C顾问所在城市',
'B顾问所在城市',


'企业名称',
'中高占比',
'无效占比',
'企业所在地区',
'企业所在行业',
'企业规模',
'企业性质',
'职位名称',
'职位所在地点',

'人选简历行业',
'人选简历地点',
'人选简历职位',
'最后更新简历时间',
'交付效果',
'提交企业时间',
'C顾问姓名',
'C顾问所在组别',

'C顾问岗位名称',
'B顾问姓名',
'B顾问所在组别',

'B顾问岗位名称'
from dummy;

select 
cust.name,
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
(select task.id,
		task.customer_id,
		task.res_id,
		task.rsc_ejob_id,
		taskblog.result,
		taskblog.demand_concat_result,
		taskblog.intention_type,
		taskb.creator_id as rps_id,
		taskc.creator_id as cdc_id,
		taskblog.createtime
from rsc_intention task 
join rsc_intention_task_b taskb
on taskb.rsc_intention_id = task.id
join (select    
		tasklog.id,
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
     where result in ('1','2','3','4') or demand_concat_result in (1,2,4,5)
       and deleteflag = 0
       --and intention_type in ('1','2')
       and substr(regexp_replace(tracktime,'-',''),1,6) between 201701 and 201706
       ) tasklog
  where rn = 1
) taskblog
on taskb.id = taskblog.rsc_intention_task_b_id
left join rsc_intention_task_c taskc 
on taskc.rsc_intention_task_b_id = taskb.id 
and taskc.status = 4 
) task 
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
on cdc.org_id = cdc_org.d_org_id;
















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

from 
(select id,customer_id,res_id,rsc_ejob_id,result
  from rsc_intention 
	where deleteflag = 0
	and substr(createtime,1,7) between '2016-07' and '2016-09'
	and result in (1,2,3,4,6)
) task 
join (
select 
	customer_id,
	count(case when result in (1,2) then id else null end) as h_m_cnt,
	count(case when result =4 then id else null end) as n_cnt,
	count(id) as  all_cnt,
	round(count(case when result in (1,2) then id else null end) / count(case when result in (1,2,3,4) then id else null end),2) *100 as h_m_ratio,
	round(count(case when result = 6 then id else null end) / count(id),2) *100 as n_ratio
from rsc_intention
where deleteflag = 0
	and intention_type in (1,2)
	and result in (1,2,3,4,6)
	and substr(createtime,1,7) between '2016-07' and '2016-09'
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
and res.p_date = '20161026'
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
on res2.res_jobtitle = c_jobtitle2.d_code;


select task.id,task.customer_id,task.res_id,task.rsc_ejob_id,taskblog.result
from rsc_intention task 
join rsc_intention_task_b taskb
on taskb.rsc_intention_id = task.id
join (
	( select    tasklog.id,
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
		 where (result in ('1','2','3','4','6')
		   and deleteflag = 0
		   and intention_type in ('1','2')
		   and substr(regexp_replace(tracktime,'-',''),1,6) = '201610'
	) tasklog
	where rn = 1
) taskblog
left join rsc_intention_task_c taskc 
on taskc.rsc_intention_task_b_id = taskb.id ;


--2016年7-9月GCDC意向数据(意向沟通中高占比低于60%，无效占比高于10%的意向数据)
select 
	cust.name as cust_name,
	cust_dq.d_ch_name as cust_dq_name,
	cust_industry.d_main_industry as cust_industry_name,
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
	round(count(case when task.result in (1,2) then task.id else null end) / count(case when task.result in (1,2,3,4) then task.id else null end),2) *100 as h_m_ratio,
	round(count(case when task.result = 6 then task.id else null end) / count(task.id),2) *100 as n_ratio,
	count(case when nvl(res.c_jobtitle,res2.res_jobtitle) = ejob.ejob_jobtitle then task.res_id else null end) as fit_jobtitle_cnt,
	count(case when nvl(res.c_jobtitle,res2.res_jobtitle) <> ejob.ejob_jobtitle then task.res_id else null end) as nofit_jobtitle_cnt,	
	count(case when nvl(c_dq.d_ch_name,c_dq2.d_ch_name) = ejob_dq.d_ch_name then task.res_id else null end) as fit_dq_cnt,
	count(case when nvl(c_dq.d_ch_name,c_dq2.d_ch_name) <> ejob_dq.d_ch_name then task.res_id else null end) as nofit_dq_cnt,
	count(case when substr(nvl(res.res_modifiedtime,res2.modifiedtime),1,4) = 2013 then task.res_id else null end) as res_13_cnt,
	count(case when substr(nvl(res.res_modifiedtime,res2.modifiedtime),1,4) = 2014 then task.res_id else null end) as res_14_cnt,
	count(case when substr(nvl(res.res_modifiedtime,res2.modifiedtime),1,4) = 2015 then task.res_id else null end) as res_15_cnt,
	count(case when substr(nvl(res.res_modifiedtime,res2.modifiedtime),1,4) = 2016 then task.res_id else null end) as res_16_cnt
from rsc_intention task
left join dw_erp_d_customer_base_new cust 
on task.customer_id = cust.id 
left join rsc_ejob  
on task.rsc_ejob_id = rsc_ejob.id 
left join ejob
on rsc_ejob.ejob_id = ejob.ejob_id
left join dim_dq ejob_dq 
on ejob.ejob_dq = ejob_dq.d_code
left join dw_c_d_res_base res
on task.res_id =  res.res_id
and res.p_date = '20161026'
left join dim_dq c_dq 
on res.c_dq = c_dq.d_code 
left join res_profile res2
on task.res_id =  res2.res_id
left join dim_dq c_dq2 
on res2.res_dq = c_dq2.d_code
left join dim_industry cust_industry
on cust.industry = cust_industry.d_ind_code
left join dim_dq cust_dq
on cust.dq = cust_dq.d_code
where task.deleteflag = 0
and substr(task.createtime,1,7) between '2016-07' and '2016-09'
and task.result in (1,2,3,4,6)
group by cust.name,cust_dq.d_ch_name,cust_industry.d_main_industry,cust.company_scale,cust.company_kind




--2016年7-9月GCDC意向数据(意向沟通中高占比低于60%，无效占比高于10%的意向数据)
select 
	fact.name ,
	dim_dq.d_ch_name as cust_dq_name,
	dim_jobtitle.d_ch_name as dim_jobtitle,
	ejob_dq.d_ch_name as ejob_dq_name,
	sum(case when fact.industry = '互联网' then high_cnt else 0 end) as hlw_high_cnt,
	sum(case when fact.industry = '互联网' then mid_cnt else 0 end) as hlw_mid_cnt,
	sum(case when fact.industry = '互联网' then low_cnt else 0 end) as hlw_low_cnt,
	sum(case when fact.industry = '互联网' then none_cnt else 0 end) as hlw_none_cnt,
	sum(case when fact.industry = '互联网' then invalid_cnt else 0 end) as hlw_invalid_cnt,
	sum(case when fact.industry = '金融' then high_cnt else 0 end) as jr_high_cnt,
	sum(case when fact.industry = '金融' then mid_cnt else 0 end) as jr_mid_cnt,
	sum(case when fact.industry = '金融' then low_cnt else 0 end) as jr_low_cnt,
	sum(case when fact.industry = '金融' then none_cnt else 0 end) as jr_none_cnt,
	sum(case when fact.industry = '金融' then invalid_cnt else 0 end) as jr_invalid_cnt,
	sum(case when fact.industry = '医疗' then high_cnt else 0 end) as yl_high_cnt,
	sum(case when fact.industry = '医疗' then mid_cnt else 0 end) as yl_mid_cnt,
	sum(case when fact.industry = '医疗' then low_cnt else 0 end) as yl_low_cnt,
	sum(case when fact.industry = '医疗' then none_cnt else 0 end) as yl_none_cnt,
	sum(case when fact.industry = '医疗' then invalid_cnt else 0 end) as yl_invalid_cnt,
	sum(case when fact.industry = '消费品' then high_cnt else 0 end) as xfp_high_cnt,
	sum(case when fact.industry = '消费品' then mid_cnt else 0 end) as xfp_mid_cnt,
	sum(case when fact.industry = '消费品' then low_cnt else 0 end) as xfp_low_cnt,
	sum(case when fact.industry = '消费品' then none_cnt else 0 end) as xfp_none_cnt,
	sum(case when fact.industry = '消费品' then invalid_cnt else 0 end) as xfp_invalid_cnt,
	sum(case when fact.industry = '制造业' then high_cnt else 0 end) as zzy_high_cnt,
	sum(case when fact.industry = '制造业' then mid_cnt else 0 end) as zzy_mid_cnt,
	sum(case when fact.industry = '制造业' then low_cnt else 0 end) as zzy_low_cnt,
	sum(case when fact.industry = '制造业' then none_cnt else 0 end) as zzy_none_cnt,
	sum(case when fact.industry = '制造业' then invalid_cnt else 0 end) as zzy_invalid_cnt,
	sum(case when fact.industry = '地产' then high_cnt else 0 end) as dc_high_cnt,
	sum(case when fact.industry = '地产' then mid_cnt else 0 end) as dc_mid_cnt,
	sum(case when fact.industry = '地产' then low_cnt else 0 end) as dc_low_cnt,
	sum(case when fact.industry = '地产' then none_cnt else 0 end) as dc_none_cnt,
	sum(case when fact.industry = '地产' then invalid_cnt else 0 end) as dc_invalid_cnt,
	sum(case when fact.industry = '其他' then high_cnt else 0 end) as qt_high_cnt,
	sum(case when fact.industry = '其他' then mid_cnt else 0 end) as qt_mid_cnt,
	sum(case when fact.industry = '其他' then low_cnt else 0 end) as qt_low_cnt,
	sum(case when fact.industry = '其他' then none_cnt else 0 end) as qt_none_cnt,
	sum(case when fact.industry = '其他' then invalid_cnt else 0 end) as qt_invalid_cnt,
	sum(nofit_dq_cnt),
	sum(nofit_jobtitle_cnt),
	sum(invalid_self_cnt)
from (
select 
	cust.name,cust.dq,get_first_code(ejob.ejob_jobtitle,',') as ejob_jobtitle,ejob.ejob_dq,
	case when res.c_industry in ('10', '040', '420', '010', '030') then '互联网'
		 when res.c_industry in ('13', '500', '130', '430', '150', '140') then '金融'
		 when res.c_industry in ('19', '270', '280', '290') then '医疗'
		 when res.c_industry in ('210', '220', '14', '190', '240', '470', '200', '460') then '消费品'
		 when res.c_industry in ('340', '15', '370', '180', '360', '350') then '制造业'
		 when res.c_industry in ('12', '080', '090', '100') then '地产'
		 else '其他'
    end industry,
	count(case when task.result = 1 then task.id else null end) as high_cnt,
	count(case when task.result = 2 then task.id else null end) as mid_cnt,
	count(case when task.result = 3 then task.id else null end) as low_cnt,
	count(case when task.result = 4 then task.id else null end) as none_cnt,
	count(case when task.result = 6 then task.id else null end) as invalid_cnt,
	count(case when nvl(c_dq.d_ch_name,c_dq2.d_ch_name) <> ejob_dq.d_ch_name then task.res_id else null end) as nofit_dq_cnt,
	count(case when nvl(res.c_jobtitle,res2.res_jobtitle) <> ejob.ejob_jobtitle then task.res_id else null end) as nofit_jobtitle_cnt,
	count(case when nvl(invalid1.invalid_b_cnt,0) +  nvl(invalid1.invalid_c_cnt,0) > 0 then task.res_id else null end) as invalid_self_cnt
from rsc_intention task
join (
		select 
			customer_id,
			count(case when result in (1,2) then id else null end) as h_m_cnt,
			count(case when result =4 then id else null end) as n_cnt,
			count(id) as  all_cnt
		from rsc_intention
		where deleteflag = 0
			and intention_type in (1,2)
			and result in (1,2,3,4,6)
			and substr(createtime,1,7) between '2016-07' and '2016-09'
		group by customer_id
		having count(case when result in (1,2) then id else null end) / count(id) < 0.6
				and count(case when result =4 then id else null end)  / count(id) > 0.1
	  ) target
on task.customer_id = target.customer_id
left join dw_erp_d_customer_base_new cust 
on task.customer_id = cust.id 
left join rsc_ejob  
on task.rsc_ejob_id = rsc_ejob.id 
left join ejob
on rsc_ejob.ejob_id = ejob.ejob_id
left join dim_dq ejob_dq 
on ejob.ejob_dq = ejob_dq.d_code
left join dw_c_d_res_base res
on task.res_id =  res.res_id
and res.p_date = '20161026'
left join dim_dq c_dq 
on res.c_dq = c_dq.d_code 
left join res_profile res2
on task.res_id =  reres2s.res_id
left join dim_dq c_dq2 
on res2.res_dq = c_dq2.d_code
left join 
(
	select 
		task.id,
		count(logb.id) as invalid_b_cnt,
		count(logc.id) as invalid_c_cnt
	from rsc_intention task 
	left join rsc_intention_task_b taskb
	on task.id = taskb.rsc_intention_id
	left join 
	(select id,rsc_intention_task_b_id
	   from rsc_intention_task_b_log
	  where result = 6
	    and (instr(content,'空号') > 0 or instr(content,'停机') > 0 or instr(content,'易主') > 0 )
	) logb
	on logb.rsc_intention_task_b_id = taskb.id
	left join rsc_intention_task_c taskc 
	on taskc.rsc_intention_task_b_id = taskb.id
	left join (select id,rsc_intention_task_c_id
	   from rsc_intention_task_c_log
	  where result = 6
	    and (instr(content,'空号') > 0 or instr(content,'停机') > 0 or instr(content,'易主') > 0 )
	) logc 
	on logc.rsc_intention_task_c_id = taskc.id  
	where substr(task.createtime,1,7) between '2016-07' and '2016-09'
	and task.result = 6
	group by task.id
) invalid1
on task.id = invalid1.id
where task.deleteflag = 0
and substr(task.createtime,1,7) between '2016-07' and '2016-09'
and task.result in (1,2,3,4,6)
group by cust.name,cust.dq,get_first_code(ejob.ejob_jobtitle,','),ejob.ejob_dq,res.c_industry

) fact 
left join dim_jobtitle 
on fact.ejob_jobtitle = dim_jobtitle.d_code
left join dim_dq 
on fact.dq = dim_dq.d_code
left join dim_dq  ejob_dq
on fact.ejob_dq = ejob_dq.d_code
group by 
fact.name,
dim_dq.d_ch_name,
dim_jobtitle.d_ch_name,
ejob_dq.d_ch_name;


--2016年7-9月GCDC意向数据(意向沟通中高占比低于60%，无效占比高于10%的意向数据)
--企业名称	企业所在地区	企业所在行业	职位名称	职位所在地点	简历编号	人选简历行业	人选简历地点	人选简历职位	交付效果	最后更新简历时间
		

select 
cust.name,
cust_dq.d_ch_name,
cust_industry.d_main_industry,

dim_jobtitle.d_ch_name,
ejob_dq.d_ch_name,

nvl(res.res_id,res2.res_id),
nvl(c_industry.d_main_industry,c_industry2.d_main_industry),
nvl(c_dq.d_ch_name,c_dq2.d_ch_name),
nvl(c_jobtitle.d_ch_name,c_jobtitle2.d_ch_name),
case task.result
	when 1 then '高'
	when 2 then '中'
	when 3 then '低'
	when 4 then '无'
	when 6 then '未成功沟通-无效人选'
end as result,
substr(res.res_modifiedtime,1,7)
from 
(select id,customer_id,res_id,rsc_ejob_id,result
  from rsc_intention 
	where deleteflag = 0
	and substr(createtime,1,7) between '2016-07' and '2016-09'
	and result in (1,2,3,4,6)
) task 
join (
select 
	customer_id,
	count(case when result in (1,2) then id else null end) as h_m_cnt,
	count(case when result =4 then id else null end) as n_cnt,
	count(id) as  all_cnt,
	round(count(case when result in (1,2) then id else null end) / count(id),2) *100 as h_m_ratio,
	round(count(case when result = 4 then id else null end) / count(id),2) *100 as n_ratio,

from rsc_intention
where deleteflag = 0
	and intention_type in (1,2)
	and result in (1,2,3,4,6)
	and substr(createtime,1,7) between '2016-07' and '2016-09'
group by customer_id
having count(case when result in (1,2) then id else null end) / count(id) < 0.6
		and count(case when result =4 then id else null end)  / count(id) > 0.1
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
and res.p_date = '20161026'
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
on res2.res_jobtitle = c_jobtitle2.d_code;


--月初月末生成拨打计划列表

case rsc.source when 0 then '手动录入'
when 1 then '招服划转生成'
when 2 then '客服要求采取非电话形式沟通'
when 3 then '意向沟通生成'
when 4 then '客户满意度回访生成TL'
when 5 then '新签客户生成'
when 6 then '到期客户生成'
when 7 then '浅度客户生成'
when 8 then '活跃客户生成'
when 9 then '中度客户生成'
end as source,
case rsc.status
when 0 then '未拨打'
when 1 then '已拨打'
when 2 then '已过期未拨打' 
when 3 then '手动无效计划'
when 4 then '已合并'
when 5 then '系统无效计划'
end as source


select '客户名称	客户行业	负责招服	招服所在团队	招服城市	手动生成拨打计划数	系统生成拨打计划数	过期未拨打数	拨打计划已拨打数	系统无效拨打计划数	手动无效拨打计划数	拨打计划完成率'
from dummy;
select 
cus.name,
dim_industry.d_main_industry,
pu.name,
dim_org.org_name,
dim_org.branch_name,
count(case when rsc.source = 0 then rsc.id else null end) as manual_cnt,
count(case when rsc.source <> 0 then rsc.id else null end) as auto_cnt,
count(case when rsc.status = 2 then rsc.id else null end) as expire_cnt,
count(case when rsc.status = 1 then rsc.id else null end) as dial_cnt,
count(case when rsc.status = 5 then rsc.id else null end) as auto_invalid_cnt,
count(case when rsc.status = 3 then rsc.id else null end) as manul_invalid_cnt,
count(case when rsc.status = 1 then rsc.id else null end) /(count(case when rsc.status = 1 then rsc.id else null end) + count(case when rsc.status = 2 then rsc.id else null end)) as finish_ratio
from
rsc_callplan rsc
left join dw_erp_d_customer_base_new as cus on rsc.customer_id = cus.id
left join portal_employee pu on pu.id = rsc.creator_id
left join dim_org on rsc.org_id = dim_org.d_org_id
left join dim_industry on cus.industry = dim_industry.d_ind_code
where substr(rsc.calltime,1,8) between '20161001' and '20161031'
and rsc.deleteflag = 0 
and rsc.creator_id != 346 
group by cus.name,
dim_industry.d_main_industry,
pu.name,
dim_org.org_name,
dim_org.branch_name;

select base.name,
		base.serviceuser_name,
		base.service_teamorg_name,
		case rsc.customer_type
			when '0' then '新签客户'
			when '1' then '到期客户'
			when '2' then 'A类活跃客户'
			when '3' then 'B类活跃客'
			when '4' then 'C类活跃客户'
			when '5' then '浅度休眠客户'
			when '6' then '中度休眠客户'
			when '7' then '深度休眠客户'
			when '8' then '其他客户'
			else '未知'
		end 
from dw_erp_d_customer_base base 
join rsc_customer rsc 
on base.id = rsc.customer_id
left join 
(select customer_id
  from rsc_callplan rsc
  where substr(rsc.calltime,1,8) between '20161001' and '20161031'
and rsc.deleteflag = 0 
and rsc.creator_id != 346 
and rsc.source <> 0) callplan 
on base.id = callplan.customer_id
where base.p_date = 20161130
and base.rsc_valid_status = 1
and rps_service_version in (1,3)
and callplan.customer_id is null 




select 
	dim_org.org_name,
	count(userc_id),
	count(case when low4=1 then userc_id else null end),
	count(case when equal4=1 then userc_id else null end),
	count(case when big4=1 then userc_id else null end)
from (
	select org_id,userc_id,id,
		case when is_current_state+is_manage_message+is_trend+is_salary+is_evaluate+is_dq+is_job_intention+is_family+is_intention+is_time_message+is_content < 4 then 1 else 0 end low4,
		case when is_current_state+is_manage_message+is_trend+is_salary+is_evaluate+is_dq+is_job_intention+is_family+is_intention+is_time_message+is_content = 4 then 1 else 0 end equal4,
		case when is_current_state+is_manage_message+is_trend+is_salary+is_evaluate+is_dq+is_job_intention+is_family+is_intention+is_time_message+is_content > 4 then 1 else 0 end big4
	from 
	(
		select org_id,userc_id,id,
		case when (get_json_object(current_state,'$.compName')  is not null and 
				  get_json_object(current_state,'$.compName') != '' ) or 
				  (get_json_object(current_state,'$.currentState')  is not null and 
				  get_json_object(current_state,'$.currentState') != '' ) or 
				  (get_json_object(current_state,'$.reason')  is not null and 
				  get_json_object(current_state,'$.reason') != '' ) or
				  (get_json_object(current_state,'$.time')  is not null and 
				  get_json_object(current_state,'$.time') != '' ) or
				  (get_json_object(current_state,'$.state')  is not null and 
				  get_json_object(current_state,'$.state') != '' )
				  then 1 else 0 end as is_current_state ,
		case when (get_json_object(manage_message,'$.duty')  is not null and 
				  get_json_object(manage_message,'$.duty') != '' ) or 
				  (get_json_object(manage_message,'$.obj')  is not null and 
				  get_json_object(manage_message,'$.obj') != '' )
				  then 1 else 0 end as is_manage_message ,
		case when trend is not null and trend != '' then 1 else 0 end as is_trend ,
		case when (get_json_object(salary,'$.current')  is not null and 
				  get_json_object(salary,'$.current') != '' ) or 
				  (get_json_object(salary,'$.base')  is not null and 
				  get_json_object(salary,'$.base') != '' ) or 
				  (get_json_object(salary,'$.other')  is not null and 
				  get_json_object(salary,'$.other') != '' ) or 
				  (get_json_object(salary,'$.expectation')  is not null and 
				  get_json_object(salary,'$.expectation') != '' ) or
				  (get_json_object(salary,'$.month')  is not null and 
				  get_json_object(salary,'$.month') != '' ) or
				  (get_json_object(salary,'$.type')  is not null and 
				  get_json_object(salary,'$.type') != '' )		  
				  then 1 else 0 end as is_salary ,
		case when evaluate is not null and evaluate != '' then 1 else 0 end as is_evaluate ,
		case when (get_json_object(dq,'$.current')  is not null and 
				  get_json_object(dq,'$.current') != '' ) or 
				  (get_json_object(dq,'$.expectation')  is not null and 
				  get_json_object(dq,'$.expectation') != '' ) or 
				  (get_json_object(dq,'$.hj')  is not null and 
				  get_json_object(dq,'$.hj') != '' ) or 
				  (get_json_object(dq,'$.job')  is not null and 
				  get_json_object(dq,'$.job') != '' )   
				  then 1 else 0 end as is_dq ,
		case when (get_json_object(job_intention,'$.detail')  is not null and 
				  get_json_object(job_intention,'$.detail') != '' ) or 
				  (get_json_object(job_intention,'$.industry')  is not null and 
				  get_json_object(job_intention,'$.industry') != '' ) or 
				  (get_json_object(job_intention,'$.other')  is not null and 
				  get_json_object(job_intention,'$.other') != '' ) or 
				  (get_json_object(job_intention,'$.expectation')  is not null and 
				  get_json_object(job_intention,'$.expectation') != '' ) or
				  (get_json_object(job_intention,'$.noThink')  is not null and 
				  get_json_object(job_intention,'$.noThink') != '' ) or 
				  (get_json_object(job_intention,'$.target')  is not null and 
				  get_json_object(job_intention,'$.target') != '' ) 
				  then 1 else 0 end as is_job_intention ,
		case when (get_json_object(family,'$.other')  is not null and 
				  get_json_object(family,'$.other') != '' ) 
				  then 1 else 0 end as is_family, 
		case when (get_json_object(intention,'$.other')  is not null and 
				  get_json_object(intention,'$.other') != '' ) 
				  then 1 else 0 end as is_intention, 
		case when (get_json_object(time_message,'$.communication')  is not null and 
				  get_json_object(time_message,'$.communication') != '' ) or 
				  (get_json_object(time_message,'$.interview')  is not null and 
				  get_json_object(time_message,'$.interview') != '' ) or 
				  (get_json_object(time_message,'$.toJob')  is not null and 
				  get_json_object(time_message,'$.toJob') != '' ) 
				  then 1 else 0 end as is_time_message,
		case when content is not null and content != '' then 1 else 0 end as is_content		  
		from candidate_track
		where communicated_flag = 1
		and deleteflag = 0
		and instr(content,'LongList') = 0
		and substr(createtime,1,10) between '2016-09-19' and '2016-10-26'
	) track 
) track2
left join dim_org 
on track2.org_id = dim_org.d_org_id
group by dim_org.org_name;



	
select dim_org.org_name,ct_cnt
from 
(
	select org_id,count(id) as ct_cnt
	from candidate_track
	where communicated_flag = 1
	and deleteflag = 0
	and instr(content,'LongList') = 0
	and substr(createtime,1,10) between '2016-09-19' and '2016-09-28'
	group by org_id 
) track 
left join dim_org 
on track.org_id = dim_org.d_org_id




select *
	from candidate_track
	where  deleteflag = 0
	and instr(content,'LongList') = 0
	and substr(createtime,1,10) between '2016-10-19' and '2016-10-26'
	limit 100 



---金卡顾问拨打计划
select
	'经理人ID',
	'金卡',
	'拨打计划来源',
	'计划拨打日期',
	'拨打状态',
	'完成时间',
	'备注信息',
	'当前维护人员姓名',
	'所在部门名称',
	'创建时间'
from dummy;
select 
	task.userc_id,
	case when goldcard.user_id is not null then '是' else '否' end as goldcard,
	case task.source 
		when '1' then '金卡会员呼叫'
		when '2' then '金卡会员首期'
		when '3' then '手动添加'
		when '4' then '核心用户'
		when '5' then '金卡会员职业测评'
	end as source,
	reformat_date(task.calltime),
	case task.callstatus
		when '0' then '未拨打'
		when '1' then '已拨打'
		when '2' then '已合并'
	end as callstatus,
	reformat_date(task.finishtime),
	task.memo,
	base.name as sales_name,
	org.org_name,
	task.createtime
from cdc_callplan_task task
left join dw_erp_d_salesuser_base base 
on task.creator_id = base.id 
and base.p_date = $date$
left join dim_org org 
on task.org_id = org.d_org_id
left join goldcard 
on task.userc_id = goldcard.user_id 
and goldcard.effect_flag = 1
where substr(regexp_replace(task.createtime,'-',''),1,6) = substr($date$,1,6)

--入职确认拨打计划
select
	'经理人姓名',
	'拨打状态',
	'计划拨打日期',
	'完成时间',
	'备注',
	'当前维护人员姓名',
	'所在部门名称',
	'拨打时间'
from dummy;

select 
entry.userc_name,
case entry.callstatus
	 when 0 then '未拨打'
	 when 1 then '已拨打'
	 when 2 then '已合并'
	 else '其他'
end as callstatus,
reformat_date(entry.calltime),
reformat_date(entry.finishtime),
entry.memo,
base.name as creator_name,
org.org_name as org_name,
entry.createtime
from cdc_callplan_entryconfirm entry
left join dw_erp_d_salesuser_base base 
on entry.creator_id = base.id 
and base.p_date = $date$
left join dim_org org 
on entry.org_id = org.d_org_id
where substr(regexp_replace(entry.createtime,'-',''),1,6) = substr($date$,1,6);

--意向沟通c 未沟通
select
'经理人简历',
'企业',
'类型',
'职位',
'意向类型',
'意向',
'索要联系方式结果',
'招服专员B',
'招服专员C',
'最后操作时间',
'释放时间',
'最后状态'
from dummy;

select 
task.res_id,
cust.customer_name as customer_name,
case  cust.customer_type 
	when 0 then '新签客户'
	when 1 then '到期客户'
	when 2 then 'A类活跃客户'
	when 3 then 'B类活跃客户'
	when 4 then 'C类活跃客户'
	when 5 then '浅度休眠客户'
	when 6 then '中度休眠客户'
	when 7 then '深度休眠客户'
	when 8 then '其他客户'
	else '未知'
end as customer_type,
ejob.job_title as rsc_ejob_title,
case task.intention_type
	when 0 then '索要联系方式'
	when 1 then '意向沟通'
	when 2 then '索要电话+意向沟通'
end as intention_type,
case task.result
	when 0 then '未沟通'
	when 1 then '高'
	when 2 then '中'
	when 3 then '低'
	when 4 then '无'
	when 5 then '未知'
	when 6 then '未成功沟通-无效人选'
end as result,
case task.demand_concat_result
	when 0 then '未沟通'
	when 1 then '开放'
	when 2 then '不开放'
	when 3 then '沟通中'
	when 4 then '未成功沟通'
	end as demand_concat_result,
emb.name as rps_name,
emc.name as cdc_name,
task.modifytime,
task.createtime,
case task.status
	when 0 then '待沟通'
	when 1 then '已提交'
	when 2 then '已驳回'
	when 3 then '已收回'
	when 4 then '已采纳'
	end as status
from rsc_intention_task_c task
left join rsc_intention_task_b taskb 
on task.rsc_intention_task_b_id = taskb.id
left join rsc_customer cust 
on task.customer_id = cust.customer_id 
left join rsc_ejob ejob 
on task.rsc_ejob_id = ejob.id 
left join portal_employee emc
on task.creator_id = emc.id 
left join portal_employee emb
on taskb.creator_id = emb.id
where substr(task.createtime,1,7) = '2016-10'
and task.status = 0
and task.deleteflag = 0;

--意向沟通c 已沟通
select
'经理人简历',
'企业',
'类型',
'职位',
'意向类型',
'意向',
'索要联系方式结果',
'招服专员B',
'招服专员C',
'最后操作时间',
'释放时间',
'最后状态',
'沟通时间'
from dummy;

select 
task.res_id,
cust.customer_name as customer_name,
case  cust.customer_type 
	when 0 then '新签客户'
	when 1 then '到期客户'
	when 2 then 'A类活跃客户'
	when 3 then 'B类活跃客户'
	when 4 then 'C类活跃客户'
	when 5 then '浅度休眠客户'
	when 6 then '中度休眠客户'
	when 7 then '深度休眠客户'
	when 8 then '其他客户'
	else '未知'
end as customer_type,
ejob.job_title as rsc_ejob_title,
case task.intention_type
	when 0 then '索要联系方式'
	when 1 then '意向沟通'
	when 2 then '索要电话+意向沟通'
end as intention_type,
case task.result
	when 0 then '未沟通'
	when 1 then '高'
	when 2 then '中'
	when 3 then '低'
	when 4 then '无'
	when 5 then '未知'
	when 6 then '未成功沟通-无效人选'
end as result,
case task.demand_concat_result
	when 0 then '未沟通'
	when 1 then '开放'
	when 2 then '不开放'
	when 3 then '沟通中'
	when 4 then '未成功沟通'
	end as demand_concat_result,
emb.name as rps_name,
emc.name as cdc_name,
task.modifytime,
task.createtime,
case task.status
	when 0 then '待沟通'
	when 1 then '已提交'
	when 2 then '已驳回'
	when 3 then '已收回'
	when 4 then '已采纳'
	end as status,
reformat_date(task.tracktime)
from rsc_intention_task_c task
left join rsc_intention_task_b taskb 
on task.rsc_intention_task_b_id = taskb.id
left join rsc_customer cust 
on task.customer_id = cust.customer_id 
left join rsc_ejob ejob 
on task.rsc_ejob_id = ejob.id 
left join portal_employee emc
on task.creator_id = emc.id 
left join portal_employee emb
on taskb.creator_id = emb.id
where substr(task.createtime,1,7) = '2016-10'
and task.deleteflag = 0
and task.status <> 0 ;


select count(1)
from rsc_intention_task_c task
where substr(task.createtime,1,7) = '2016-09'
and task.status <> 0
and task.deleteflag = 0;

select intention_type,count(1)
from rsc_intention_task_c task
join rsc_intention_task_c_log log 
on task.rsc_intention_task_b_id = taskb.id
where taskb.id is null 
and task.deleteflag = 0
group by intention_type