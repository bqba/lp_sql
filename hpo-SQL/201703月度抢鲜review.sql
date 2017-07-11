


select d_date, id, name, this_income, last_income, before_income, sid, sname, orgname,sm.name as sm_name
from temp_reivew rv 
left join 
(
select target.id,target.name,su2.id as sid
from temp_mancj_20170403223300 target--target
join (
	select id,name,parent_id
    from (
    select id,name,parent_salesuser_id_list
    from dw_erp_d_salesuser_base  
    where p_date = 20170331
    ) su
    lateral view explode(split(parent_salesuser_id_list,',')) i as parent_id
) su2 
on target.id = su2.parent_id
) sm 
on rv.sid = sm.sid



--销售总监review数据
select 
	target.name,
	target.title,
	target.branch,
	target.id,
	count(su2.id) as user_cnt,
	max(target.this_target) as this_target,
	sum(suser_act.income_money) as income_money,
	round(sum(suser_act.income_money) / max(target.this_target) ,4) as income_ratio,
	round(sum(suser_act.year_money) / max(target.year_target),4) as income_year_ratio,
	'年度任务达成率全国排名不提供' as income_year_ratio_rank,
	sum(suser_act.income_money) / count(su2.id) as person_money,
	round((sum(suser_act.income_money) / count(su2.id)-(sum(suser_act.last_money)/ max(last_user.last_user_cnt))) /(sum(suser_act.last_money)/ max(last_user.last_user_cnt)),4)        as mom_person_money_ratio,
	'月人均单产排名' as mom_person_money_rank,
	sum(suser_act.cert_cust_cnt) as cert_cust_cnt,
	round(sum(suser_act.cover_cnt)/sum(suser_act.cert_cust_cnt),4) as cover_ratio,
	sum(suser_act.trans_cust_cnt) as trans_cust_cnt,
	round(sum(suser_act.trans_cust_cnt)/sum(suser_act.cover_cnt),4) as trans_ratio,
	'金额续约率不提供'  as money_renewal_ratio,
	'单数续约率不提供'  as cnt_renewal_ratio,
	sum(suser_act.w1_cust_cnt) as w1_cust_cnt,
	sum(suser_act.w2_cust_cnt) as w2_cust_cnt,
	sum(suser_act.w3_cust_cnt) as w3_cust_cnt,
	sum(suser_act.w5_cust_cnt) + sum(suser_act.g5w_cust_cnt) as g3w_cust_cnt,
	sum(suser_act.w1_cust_cnt) + sum(suser_act.w2_cust_cnt) +  sum(suser_act.w3_cust_cnt) as l3w_cust_cnt,
	sum(suser_act.w5_cust_cnt) as w5_cust_cnt,
	sum(suser_act.g5w_cust_cnt) as g5w_cust_cnt,
	round(count(case when nvl(suser_act.income_money,0) >= 20000 then su2.id else null end) / count(su2.id),4) as w2_suser_ratio,
    round(count(case when nvl(suser_act.income_money,0) >= 50000 then su2.id else null end) / count(su2.id),4) as w5_suser_ratio
from temp_mancj_20170403223300 target--target
join (
	select id,name,parent_id
    from (
    select id,name,parent_salesuser_id_list
    from dw_erp_d_salesuser_base  
    where status in (0,1)
    and is_saleuser = 1 
    and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售')
    and p_date = 20170331
    ) su
    lateral view explode(split(parent_salesuser_id_list,',')) i as parent_id
) su2 
on target.id = su2.parent_id
left join 
(select sales_user_id, income_money, last_money, year_money, receivable_money, 
	--hlw_cust_cnt, hlw_cust_money, hlw_cert_cust_cnt, fdc_cust_cnt, fdc_cust_money, fdc_cert_cust_cnt, jr_cust_cnt, jr_cust_money, jr_cert_cust_cnt, xfp_cust_cnt, xfp_cust_money, xfp_cert_cust_cnt, qc_cust_cnt, qc_cust_money, qc_cert_cust_cnt, qt_cust_cnt, qt_cust_money, qt_cert_cust_cnt, 
	cert_cust_cnt, income_cust_cnt, w1_cust_cnt, w1_cust_money, w2_cust_cnt, w2_cust_money, w3_cust_cnt, w3_cust_money, w5_cust_cnt, w5_cust_money, g5w_cust_cnt, g5w_cust_money, cover_cnt, trans_cust_cnt
from temp_mancj_20170403222351 suser_act
) suser_act
on su2.id = suser_act.sales_user_id
left join 
(	select target.id,count(su2.id) as last_user_cnt
	from temp_mancj_20170403223300 target--target
	join (
		select id,name,parent_id
	    from (
	    select id,name,parent_salesuser_id_list
	    from dw_erp_d_salesuser_base  
	    where status in (0,1)
	    and is_saleuser = 1 
	    and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售')
	    and p_date = 20170228
	    ) su
	    lateral view explode(split(parent_salesuser_id_list,',')) i as parent_id
	) su2 
	on target.id = su2.parent_id
	group by target.id
) last_user 
on target.id = last_user.id
group by target.name,
target.title,
target.branch,
target.id;



select target.name,su2.org_name
from temp_mancj_20170403223300 target--target
join (
	select id,name,parent_id,org_name
    from (
    select id,name,parent_salesuser_id_list,org_name
    from dw_erp_d_salesuser_base  
    where status in (0,1)
    and is_saleuser = 1 
    and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售')
    and p_date = 20170331
    ) su
    lateral view explode(split(parent_salesuser_id_list,',')) i as parent_id
) su2 
on target.id = su2.parent_id
group by target.name,su2.org_name



--是否改进
select 
	target.name,
	target.title,
	target.branch,
	target.id,
	count(case when su2.status in (0,1) and su2.is_saleuser = 1 and su2.position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售') then su2.id else null end) as user_cnt,
	max(target.this_target) as this_target,
	sum(suser_act.income_money) as income_money,
	round(sum(suser_act.income_money) / max(target.this_target) ,4) as income_ratio,
	round(sum(suser_act.year_money) / max(target.year_target),4) as income_year_ratio,
	'年度任务达成率全国排名不提供' as income_year_ratio_rank,
	sum(suser_act.income_money) / count(su2.id) as person_money,
	round((sum(suser_act.income_money) / count(su2.id)-(sum(suser_act.last_money)/ max(last_user.last_user_cnt))) /(sum(suser_act.last_money)/ max(last_user.last_user_cnt)),4)        as mom_person_money_ratio,
	'月人均单产排名' as mom_person_money_rank,
	sum(suser_act.cert_cust_cnt) as cert_cust_cnt,
	round(sum(suser_act.cover_cnt)/sum(suser_act.cert_cust_cnt),4) as cover_ratio,
	sum(suser_act.trans_cust_cnt) as trans_cust_cnt,
	round(sum(suser_act.trans_cust_cnt)/sum(suser_act.cover_cnt),4) as trans_ratio,
	'金额续约率不提供'  as money_renewal_ratio,
	'单数续约率不提供'  as cnt_renewal_ratio,
	sum(suser_act.w1_cust_cnt) as w1_cust_cnt,
	sum(suser_act.w2_cust_cnt) as w2_cust_cnt,
	sum(suser_act.w3_cust_cnt) as w3_cust_cnt,
	sum(suser_act.w5_cust_cnt) + sum(suser_act.g5w_cust_cnt) as g3w_cust_cnt,
	sum(suser_act.w1_cust_cnt) + sum(suser_act.w2_cust_cnt) +  sum(suser_act.w3_cust_cnt) as l3w_cust_cnt,
	sum(suser_act.w5_cust_cnt) as w5_cust_cnt,
	sum(suser_act.g5w_cust_cnt) as g5w_cust_cnt,
	count(case when case when su2.status in (0,1) and su2.is_saleuser = 1 and su2.position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售') and nvl(suser_act.income_money,0) > 20000 then su2.id else null end)	

from temp_mancj_20170403223300 target--target
left join (
	select id,name,parent_salesuser_id_list,status,is_saleuser,position_channel_name,parent_id
    from (
    select id,name,parent_salesuser_id_list,status,is_saleuser,position_channel_name
    from dw_erp_d_salesuser_base  
    where p_date = 20170331
    ) su
    lateral view explode(split(parent_salesuser_id_list,',')) i as parent_id
) su2 
on target.id = su2.parent_id
left join 
(select sales_user_id, income_money, last_money, year_money, receivable_money, 
	--hlw_cust_cnt, hlw_cust_money, hlw_cert_cust_cnt, fdc_cust_cnt, fdc_cust_money, fdc_cert_cust_cnt, jr_cust_cnt, jr_cust_money, jr_cert_cust_cnt, xfp_cust_cnt, xfp_cust_money, xfp_cert_cust_cnt, qc_cust_cnt, qc_cust_money, qc_cert_cust_cnt, qt_cust_cnt, qt_cust_money, qt_cert_cust_cnt, 
	cert_cust_cnt, income_cust_cnt, w1_cust_cnt, w1_cust_money, w2_cust_cnt, w2_cust_money, w3_cust_cnt, w3_cust_money, w5_cust_cnt, w5_cust_money, g5w_cust_cnt, g5w_cust_money, cover_cnt, trans_cust_cnt
from temp_mancj_20170403222351 suser_act
) suser_act
on su2.id = suser_act.sales_user_id
left join 
(	select target.id,count(su2.id) as last_user_cnt
	from temp_mancj_20170403223300 target--target
	join (
		select id,name,parent_id
	    from (
	    select id,name,parent_salesuser_id_list
	    from dw_erp_d_salesuser_base  
	    where status in (0,1)
	    and is_saleuser = 1 
	    and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售')
	    and p_date = 20170228
	    ) su
	    lateral view explode(split(parent_salesuser_id_list,',')) i as parent_id
	) su2 
	on target.id = su2.parent_id
	group by target.id
) last_user 
on target.id = last_user.id
group by target.name,
target.title,
target.branch,
target.id



--销售总监的销售目标  temp_mancj_20170403223300 
select 
base.id,base.name,base.title,base.position_name,substr(base.org_name,1,2) as branch,
nvl(target.year_target,0) as year_target,
nvl(target.first_quarter_amount,0) as first_quarter_amount,
nvl(target.this_target,0) as this_target,
nvl(target.last_target,0) as last_target,
nvl(target.next_target,00) as next_target
from 
(select id,name,position_name,org_name,
case when name in ('付晓磊',
'郑立彬',
'顾玺翱',
'郑建东',
'陈秀芳',
'李明泉',
'郑伟特',
'邓小通') then 'S'
when name in ('付娆',
'谢爽',
'彭岩',
'程思洋',
'俞峰',
'王嘉',
'苏莹',
'杨朝霞',
'李刚涛',
'王利强',
'徐兆') then 'SS'
when name in 
(
'李佳男',
'崔涵祺',
'张宁',
'史峰凯',
'任建飞',
'付亚楠',
'徐传侃',
'金丹丹',
'周绪涛',
'杨朝霞',
'李刚涛',
'葛潇靖') then 'KA'
end as title
from dw_erp_d_salesuser_base
where name in 
('付晓磊',
'郑立彬',
'顾玺翱',
'郑建东',
'陈秀芳',
'李明泉',
'郑伟特',
'邓小通',

'付娆',
'谢爽',
'彭岩',
'程思洋',
'俞峰',
'王嘉',
'苏莹',
'杨朝霞',
'李刚涛',
'王利强',
'徐兆',

'李佳男',
'崔涵祺',
'张宁',
'史峰凯',
'任建飞',
'付亚楠',
'徐传侃',
'金丹丹',
'周绪涛',
'杨朝霞',
'李刚涛',
'葛潇靖')
and p_date = 20170331
) base 
left join 
(
		select 
			role3.id,role3.name,role3.year_target,first_quarter_amount,last_target,this_target,next_target
		from (
				select 
					role2.id,role2.type,cat.year_target,first_quarter_amount,last_target,this_target,next_target,role2.name,
					  row_number()over(distribute by role2.id sort by cat.id ) as rn
				from 
				(
					select 
					    role1.id,
					    role1.name,
						case when role1.min_level = 5 then 1 else 0 end as type,
						   (
					        CASE
					        WHEN role1.min_level  = 5 THEN
					          id
					        WHEN role1.min_level  = 2 and role1.level <> 5 THEN
					          org_id
					        WHEN role1.min_level  = 1 THEN
					          1
					        END
					      ) AS object_id
					from (
							select pe.id,pe.name,pe.org_id as ownorg,per.org_id,prp.level,
						    min(prp.level) over(distribute by pe.id) as min_level
						    from portal_permission pp 
						    join portal_role_permission prp
						    on pp.id = prp.permission_id
						    and prp.deleteflag = 0
						    join portal_employee_role per 
						    on per.role_id = prp.role_id
						    and per.deleteflag = 0
						    join portal_employee pe 
						    on pe.id = per.employee_id
						    and pe.deleteflag = 0 		
						    left join (select parent_salesuser_id
						    	   from dw_erp_d_salesuser_base
						    	   where p_date = 20170331
						    	   group by parent_salesuser_id) child
						    on pe.id = child.parent_salesuser_id 
						    where pp.code='CRM_SALE_TARGET_LIST'
						    and prp.level in (1,2,5)
						    and !(child.parent_salesuser_id is null and pe.status = 2)
					    ) role1 
					union all 
					select id,name,0 as type,1 as object_id
					  from dw_erp_d_salesuser_base
					  where p_date = 20170331
					    and position_channel in ('A0000567','A0000528')
					    and status <> 2 
					    and account_status = 0
				) role2
			    join (
						
			    	  select id,object_id,type,year_target,first_quarter_amount,last_target,this_target,next_target
			    	    from (
						select id,object_id,type,
							  double(get_json_object(target_amount_detail,'$.year_amount'))* 10000 as year_target,
							  double(get_json_object(target_amount_detail,'$.first_quarter_amount'))* 10000 as first_quarter_amount,
							  double(get_json_object(target_amount_detail,'$.feb_amount'))* 10000 as last_target,
							  double(get_json_object(target_amount_detail,'$.mar_amount'))* 10000 as this_target,
							  double(get_json_object(target_amount_detail,'$.apr_amount'))* 10000 as next_target,
						  row_number()over(distribute by object_id,type,year sort by id desc) as rn
						from crm_target_management
						where deleteflag = 0 
						 and year = substr('20170331',1,4)
					   )  ctm
			    	where ctm.rn = 1
				)  cat 
			    on role2.object_id = cat.object_id
			    and role2.type = cat.type
		   ) role3 
		   where rn =1
) target
on base.id = target.id 




-- temp_mancj_20170403222351 	销售粒度review基础表

select 
jgzj.sales_user_id,
jgzj.income_money, -- 本月回款金额
jgzj.last_money, -- 上月回款金额
jgzj.year_money, -- 年累计回款金额
jgzj.receivable_money, -- 未回款金额
nvl(hyfx.hlw_cust_cnt,0) as hlw_cust_cnt , --回款客户数
nvl(hyfx.hlw_cust_money,0) as hlw_cust_money , --回款金额
nvl(hyfx.hlw_cert_cust_cnt,0) as hlw_cert_cust_cnt , --库中总客户数（认证）
nvl(hyfx.fdc_cust_cnt,0) as fdc_cust_cnt , --回款客户数
nvl(hyfx.fdc_cust_money,0) as fdc_cust_money , --回款金额
nvl(hyfx.fdc_cert_cust_cnt,0) as fdc_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.jr_cust_cnt,0) as jr_cust_cnt , --回款客户数
nvl(hyfx.jr_cust_money,0) as jr_cust_money , --回款金额
nvl(hyfx.jr_cert_cust_cnt,0) as jr_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.xfp_cust_cnt,0) as xfp_cust_cnt , --回款客户数
nvl(hyfx.xfp_cust_money,0) as xfp_cust_money , --回款金额
nvl(hyfx.xfp_cert_cust_cnt,0) as xfp_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.qc_cust_cnt,0) as qc_cust_cnt , --回款客户数
nvl(hyfx.qc_cust_money,0) as qc_cust_money , --回款金额
nvl(hyfx.qc_cert_cust_cnt,0) as qc_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.qt_cust_cnt,0) as qt_cust_cnt , --回款客户数
nvl(hyfx.qt_cust_money,0) as qt_cust_money , --回款金额
nvl(hyfx.qt_cert_cust_cnt,0) as qt_cert_cust_cnt , --库中总客户数（认证）
nvl(hyfx.cert_cust_cnt,0) as cert_cust_cnt , -- 库中客户总量（认证）
nvl(hyfx.income_cust_cnt,0) as income_cust_cnt , -- 回款客户数
nvl(hyfx.w1_cust_cnt,0) as w1_cust_cnt,	
nvl(hyfx.w1_cust_money,0) as w1_cust_money,
nvl(hyfx.w2_cust_cnt,0) as w2_cust_cnt,
nvl(hyfx.w2_cust_money,0) as w2_cust_money,
nvl(hyfx.w3_cust_cnt,0) as w3_cust_cnt,	
nvl(hyfx.w3_cust_money,0) as w3_cust_money,
nvl(hyfx.w5_cust_cnt,0) as w5_cust_cnt,
nvl(hyfx.w5_cust_money,0) as w5_cust_money,
nvl(hyfx.g5w_cust_cnt,0) as g5w_cust_cnt,
nvl(hyfx.g5w_cust_money,0) as g5w_cust_money,		
nvl(cover_cnt,0) as cover_cnt,
nvl(trans_cust_cnt,0) as trans_cust_cnt

from (
	select 
		coalesce(income2.sales_user_id , recv.sales_user_id) as sales_user_id,
		sum(income2.income_money) as income_money,
		sum(income2.last_money) as last_money,
		sum(income2.year_money) as year_money,
		sum(recv.receivable_money) as receivable_money
	from  
	(
		select creator_id as sales_user_id,dmonth,income_money,last_money,year_money
		from (
			select creator_id,dmonth,income_money,
			row_number()over(distribute by creator_id sort by dmonth desc) as rn,
			lead(income_money,1,0)over(distribute by creator_id sort by dmonth desc) as last_money,
			sum(income_money)over(distribute by creator_id) as year_money
			from (
				select income.sales_id as creator_id,substr(income.d_date,1,6) as dmonth,sum(money) as income_money
				  from dw_erp_a_crmfinance_income income 
				  where substr(income.d_date,1,6) between 201701 and 201703
				  group by income.sales_id,substr(income.d_date,1,6)
			) income0
		) income1
		where rn = 1
	) income2
	full join	 
	 (select creator_id as sales_user_id,sum(money) as receivable_money
	  from crm_finance_receivables
	  where deleteflag = 0
	  and status = 0
	  group by creator_id
	 ) recv 
	on income2.sales_user_id = recv.sales_user_id
	group by coalesce(income2.sales_user_id , recv.sales_user_id)
) jgzj 
full join 
(
--签约客户行业分析
select 
	new.sales_user_id,
	count(case when di.d_main_industry = '互联网.游戏.软件' then income.customer_id else null end) as hlw_cust_cnt,
	sum(case when di.d_main_industry = '互联网.游戏.软件' then thie_money else 0 end) as hlw_cust_money,
	0 as hlw_in_cust_cnt,
	0 as hlw_in_cust_money,
	count(case when di.d_main_industry = '互联网.游戏.软件' then new.id else null end) as hlw_cert_cust_cnt,
	count(case when di.d_main_industry = '房地产.建筑.物业' then income.customer_id else null end) as fdc_cust_cnt,
	sum(case when di.d_main_industry = '房地产.建筑.物业' then thie_money else 0 end) as fdc_cust_money,
	0 as fdc_in_cust_cnt,
	0 as fdc_in_cust_money,
	count(case when di.d_main_industry = '房地产.建筑.物业' then new.id else null end) as fdc_cert_cust_cnt,	
	count(case when di.d_main_industry = '金融' then income.customer_id else null end) as jr_cust_cnt,
	sum(case when di.d_main_industry = '金融' then thie_money else 0 end) as jr_cust_money,
	0 as jr_in_cust_cnt,
	0 as jr_in_cust_money,
	count(case when di.d_main_industry = '金融' then new.id else null end) as jr_cert_cust_cnt,	
	count(case when di.d_main_industry = '消费品' then income.customer_id else null end) as xfp_cust_cnt,
	sum(case when di.d_main_industry = '消费品' then thie_money else 0 end) as xfp_cust_money,
	0 as xfp_in_cust_cnt,
	0 as xfp_in_cust_money,
	count(case when di.d_main_industry = '消费品' then new.id else null end) as xfp_cert_cust_cnt,	
	count(case when di.d_main_industry = '汽车.机械.制造' then income.customer_id else null end) as qc_cust_cnt,
	sum(case when di.d_main_industry = '汽车.机械.制造' then thie_money else 0 end) as qc_cust_money,
	0 as qc_in_cust_cnt,
	0 as qc_in_cust_money,
	count(case when di.d_main_industry = '汽车.机械.制造' then new.id else null end) as qc_cert_cust_cnt,	
	count(case when di.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造')  then income.customer_id else null end) as qt_cust_cnt,
	sum(case when di.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造')  then thie_money else 0 end) as qt_cust_money,
	0 as qt_in_cust_cnt,
	0 as qt_in_cust_money,
	count(case when di.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造')  then new.id else null end) as qt_cert_cust_cnt,
	count(new.id) as cert_cust_cnt,
	count(income.customer_id) as income_cust_cnt,
	0 as in_cust_cnt,
	count(case when income.all_money/10000 <1 then income.customer_id else null end) as w1_cust_cnt,	
	sum(case when income.all_money/10000 <1 then income.all_money else 0 end) as w1_cust_money,
	count(case when income.all_money/10000 >= 1 and income.all_money/10000 < 2 then income.customer_id else null end) as w2_cust_cnt,
	sum(case when income.all_money/10000 >= 1 and income.all_money/10000 < 2 then income.all_money else 0 end) as w2_cust_money,
	count(case when income.all_money/10000 >= 2 and income.all_money/10000 < 3 then income.customer_id else null end) as w3_cust_cnt,	
	sum(case when income.all_money/10000 >= 2 and income.all_money/10000 < 3 then income.all_money else 0 end) as w3_cust_money,
	count(case when income.all_money/10000 >= 3 and income.all_money/10000 < 5 then income.customer_id else null end) as w5_cust_cnt,
	sum(case when income.all_money/10000 >= 3 and income.all_money/10000 < 5 then income.all_money else 0 end) as w5_cust_money,
	count(case when income.all_money/10000 >=5 then income.customer_id else null end) as g5w_cust_cnt,	
	sum(case when income.all_money/10000 >=5 then income.all_money else 0 end) as g5w_cust_money	
from dw_erp_d_customer_base new
left join dim_industry di 
  on new.industry = di.d_ind_code
left join 
(select customer_id,
	   sum(case when substr(d_date,1,6) = 201703 then money else 0 end) as thie_money,
	   sum(money) as all_money
from dw_erp_a_crmfinance_income
where d_date >= 20160401
group by customer_id) income
on new.id = income.customer_id
where new.company_certificate not in ('','-1')
and new.p_date = 20170331
group by new.sales_user_id
) hyfx
on jgzj.sales_user_id = hyfx.sales_user_id
full join 
(
--客户运营效率
select 
	new.sales_user_id,
	count(cover.customer_id) as cover_cnt,
	count(contract.customer_id) as trans_cust_cnt
from dw_erp_d_customer_base new
join dw_erp_d_salesuser_base suser 
  on new.sales_user_id = suser.id 
 and suser.p_date = 20170331 
 and suser.position_channel_name = 'LPT销售'
left join (
  	select customer_id,creator_id
  	  from call_record
  	 where substr(call_date,1,6) = '201703'
  	   and time_long >45
  	 group by customer_id,creator_id
  	) cover
on new.id = cover.customer_id
and suser.id = cover.creator_id
left join 
(select customer_id,secondparty_sign_id
   from dw_erp_d_contract_base
  where substr(regexp_replace(sign_date,'-',''),1,6) = '201703'
  group by customer_id,secondparty_sign_id
) contract 
on new.id = contract.customer_id
and suser.id = contract.secondparty_sign_id
where new.p_date = 20170331
 and new.company_certificate not in ('','-1')
group by new.sales_user_id
) yyxl
on jgzj.sales_user_id = yyxl.sales_user_id