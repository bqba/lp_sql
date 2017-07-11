
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
on jgzj.sales_user_id = yyxl.sales_user_id;








select 
jgzj.branch_name,
jgzj.suser_cnt,	
jgzj.this_target, -- 本月业绩目标
jgzj.income_money, -- 本月回款金额
jgzj.income_ratio,	 -- 本月回款达成率
jgzj.gqhk_money, -- 去年同期回款金额
jgzj.ytoy_ratio, -- 同比增长
jgzj.income_mom_ratio, -- 环比增长
jgzj.person_money, -- 月人均单产
jgzj.income_year_ratio,	 -- 年度任务达成率
jgzj.income_year_ratio_rank, -- 年度任务达成率全国排名
jgzj.profit_target,	 -- 利润率目标
jgzj.profit_target_ratio,	 -- 利润率达成率
jgzj.profit_target_ratio_rank,			 -- 利润率达成率全国排名
jgzj.next_target, -- 下月目标回款
jgzj.receivable_money, -- 待回款
jgzj.first_quarter_amount, -- 季度回款目标
jgzj.gap, -- 本季度GAP
nvl(hyfx.hlw_cust_cnt,0) as hlw_cust_cnt , --回款客户数
nvl(hyfx.hlw_cust_money,0) as hlw_cust_money , --回款金额
nvl(hyfx.hlw_in_cust_cnt,0) as hlw_in_cust_cnt , --合作中总客户数
nvl(hyfx.hlw_in_cust_money,0) as hlw_in_cust_money , --合作中总客户金额
nvl(hyfx.hlw_cert_cust_cnt,0) as hlw_cert_cust_cnt , --库中总客户数（认证）
nvl(hyfx.fdc_cust_cnt,0) as fdc_cust_cnt , --回款客户数
nvl(hyfx.fdc_cust_money,0) as fdc_cust_money , --回款金额
nvl(hyfx.fdc_in_cust_cnt,0) as fdc_in_cust_cnt , --合作中总客户数
nvl(hyfx.fdc_in_cust_money,0) as fdc_in_cust_money , --合作中总客户金额
nvl(hyfx.fdc_cert_cust_cnt,0) as fdc_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.jr_cust_cnt,0) as jr_cust_cnt , --回款客户数
nvl(hyfx.jr_cust_money,0) as jr_cust_money , --回款金额
nvl(hyfx.jr_in_cust_cnt,0) as jr_in_cust_cnt , --合作中总客户数
nvl(hyfx.jr_in_cust_money,0) as jr_in_cust_money , --合作中总客户金额
nvl(hyfx.jr_cert_cust_cnt,0) as jr_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.xfp_cust_cnt,0) as xfp_cust_cnt , --回款客户数
nvl(hyfx.xfp_cust_money,0) as xfp_cust_money , --回款金额
nvl(hyfx.xfp_in_cust_cnt,0) as xfp_in_cust_cnt , --合作中总客户数
nvl(hyfx.xfp_in_cust_money,0) as xfp_in_cust_money , --合作中总客户金额
nvl(hyfx.xfp_cert_cust_cnt,0) as xfp_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.qc_cust_cnt,0) as qc_cust_cnt , --回款客户数
nvl(hyfx.qc_cust_money,0) as qc_cust_money , --回款金额
nvl(hyfx.qc_in_cust_cnt,0) as qc_in_cust_cnt , --合作中总客户数
nvl(hyfx.qc_in_cust_money,0) as qc_in_cust_money , --合作中总客户金额
nvl(hyfx.qc_cert_cust_cnt,0) as qc_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.qt_cust_cnt,0) as qt_cust_cnt , --回款客户数
nvl(hyfx.qt_cust_money,0) as qt_cust_money , --回款金额
nvl(hyfx.qt_in_cust_cnt,0) as qt_in_cust_cnt , --合作中总客户数
nvl(hyfx.qt_in_cust_money,0) as qt_in_cust_money , --合作中总客户金额
nvl(hyfx.qt_cert_cust_cnt,0) as qt_cert_cust_cnt , --库中总客户数（认证）
nvl(hyfx.cert_cust_cnt,0) as cert_cust_cnt , -- 库中客户总量（认证）
nvl(hyfx.income_cust_cnt,0) as income_cust_cnt , -- 回款客户数
nvl(hyfx.in_cust_cnt,0) as in_cust_cnt , -- 合作中客户数
nvl(yyxl.cover_ratio,0) as cover_ratio, -- 客户覆盖率
nvl(yyxl.trans_ratio,0) as trans_ratio, -- 新签客户电话客户转化率
nvl(renew.money_renewal_ratio,0) as money_renewal_ratio, -- 金额续约率
nvl(renew.cnt_renewal_ratio,0) as cnt_renewal_ratio, -- 单数续约率
nvl(hyfx.10w_cust_cnt,0) as 10w_cust_cnt ,  -- 十万以上客户数
nvl(hyfx.10w_cust_money,0) as 10w_cust_money ,  -- 十万以上客户金额
nvl(hyfx.100w_cust_cnt,0) as 100w_cust_cnt , -- 百万以上客户数
nvl(hyfx.100w_cust_money,0) as 100w_cust_money  -- 百万以上客户金额
from (
	select 
		coalesce(target.branch_name,income2.branch_name,recv.branch_name) as branch_name,
		sum(recv.suser_cnt) as suser_cnt,	
		sum(target.this_target) as this_target,
		sum(income2.income_money) as income_money,
		round(sum(income2.income_money)/sum(target.this_target),4) as income_ratio,	
		'去年同期回款金额不提供' as gqhk_money,
		'同比增长不提供' as ytoy_ratio,
		round((sum(income2.income_money)-sum(income2.last_money))/sum(income2.last_money),4) as income_mom_ratio,
		round(sum(income2.income_money)/sum(recv.suser_cnt),2) as person_money,
		round(sum(income2.year_money)/sum(target.year_target),4) as income_year_ratio,	
		'年度任务达成率全国排名' as income_year_ratio_rank,
		'利润率目标不提供' as profit_target,	
		'利润率达成率不提供' as profit_target_ratio,	
		'利润率达成率全国排名不提供' as profit_target_ratio_rank,			
		sum(target.next_target) as next_target,
		sum(recv.receivable_money) as receivable_money,
		sum(target.first_quarter_amount) as first_quarter_amount,
		'本季度GAP不提供' as gap
	from 
	(						
	  select dim_org.org_name as branch_name,
	  		object_id,
	  		nvl(last_target,0) as last_target,
	  		nvl(this_target,0) as this_target,
	  		nvl(next_target,0) as next_target,
	    	nvl(year_target,0) as year_target,
	      	nvl(first_quarter_amount,0) as first_quarter_amount	
	    from (
		select id,object_id,type,
		  double(get_json_object(target_amount_detail,'$.year_amount'))* 10000 as year_target,
		  double(get_json_object(target_amount_detail,'$.first_quarter_amount'))* 10000 as first_quarter_amount,
		  0 as last_target,
		  double(get_json_object(target_amount_detail,'$.jan_amount'))* 10000 as this_target,
		  0 as next_target,
		  row_number()over(distribute by object_id,type,year sort by id desc) as rn
		from crm_target_management
		where deleteflag = 0 
		 and year = 2017
		 and type = 0
	   )  ctm
	   join dim_org 
	   on ctm.object_id = dim_org.d_org_id 
	   and dim_org.d_org_id = dim_org.branch_id
	  where ctm.rn = 1
	)  target 
	full join 
	(	select new.sales_branch_name as branch_name,
				sum(case when substr(income.d_date,1,6) = 201701 then money else 0 end) as income_money,
				sum(case when substr(income.d_date,1,6) = 201612 then money else 0 end) as last_money,
				sum(case when substr(income.d_date,1,6) = 201701 then money else 0 end) as year_money
		  from dw_erp_a_crmfinance_income income 
		  join dw_erp_d_customer_base new on income.customer_id = new.id  and new.p_date = 20170131
		  where substr(income.d_date,1,6) between 201612 and 201701
		  group by new.sales_branch_name
	) income2
	on target.branch_name = income2.branch_name
	full join
	(
	 select dim_org.branch_name,
	 		count(case when status in (0,1) and is_saleuser = 1 and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售') then id else null end) as suser_cnt ,
	 		sum(receivable_money) as receivable_money
	 from dw_erp_d_salesuser_base suser 
	 join dim_org on suser.org_id = dim_org.d_org_id
	 left join 
	 (select creator_id,sum(money) as receivable_money
	  from recovery.crm_finance_receivables_history_20170228_20170228
	  where deleteflag = 0
	  and status = 0
	  group by creator_id
	 ) receivables
	on suser.id = receivables.creator_id
	 where p_date = 20170131
	 group by dim_org.branch_name
	) recv 
	on target.branch_name = recv.branch_name
	group by coalesce(target.branch_name,income2.branch_name,recv.branch_name)
) jgzj 
full join 
(

--签约客户行业分析
select 
	dim_org.branch_name,
	count(case when di.d_main_industry = '互联网.游戏.软件' then income.customer_id else null end) as hlw_cust_cnt,
	sum(case when di.d_main_industry = '互联网.游戏.软件' then thie_money else 0 end) as hlw_cust_money,
	'合作中总客户数不提供' as hlw_in_cust_cnt,
	'合作中总客户金额不提供' as hlw_in_cust_money,
	count(case when di.d_main_industry = '互联网.游戏.软件' then new.id else null end) as hlw_cert_cust_cnt,
	count(case when di.d_main_industry = '房地产.建筑.物业' then income.customer_id else null end) as fdc_cust_cnt,
	sum(case when di.d_main_industry = '房地产.建筑.物业' then thie_money else 0 end) as fdc_cust_money,
	'合作中总客户数不提供' as fdc_in_cust_cnt,
	'合作中总客户金额不提供' as fdc_in_cust_money,
	count(case when di.d_main_industry = '房地产.建筑.物业' then new.id else null end) as fdc_cert_cust_cnt,	
	count(case when di.d_main_industry = '金融' then income.customer_id else null end) as jr_cust_cnt,
	sum(case when di.d_main_industry = '金融' then thie_money else 0 end) as jr_cust_money,
	'合作中总客户数不提供' as jr_in_cust_cnt,
	'合作中总客户金额不提供' as jr_in_cust_money,
	count(case when di.d_main_industry = '金融' then new.id else null end) as jr_cert_cust_cnt,	
	count(case when di.d_main_industry = '消费品' then income.customer_id else null end) as xfp_cust_cnt,
	sum(case when di.d_main_industry = '消费品' then thie_money else 0 end) as xfp_cust_money,
	'合作中总客户数不提供' as xfp_in_cust_cnt,
	'合作中总客户金额不提供' as xfp_in_cust_money,
	count(case when di.d_main_industry = '消费品' then new.id else null end) as xfp_cert_cust_cnt,	
	count(case when di.d_main_industry = '汽车.机械.制造' then income.customer_id else null end) as qc_cust_cnt,
	sum(case when di.d_main_industry = '汽车.机械.制造' then thie_money else 0 end) as qc_cust_money,
	'合作中总客户数不提供' as qc_in_cust_cnt,
	'合作中总客户金额不提供' as qc_in_cust_money,
	count(case when di.d_main_industry = '汽车.机械.制造' then new.id else null end) as qc_cert_cust_cnt,	
	count(case when di.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造')  then income.customer_id else null end) as qt_cust_cnt,
	sum(case when di.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造')  then thie_money else 0 end) as qt_cust_money,
	'合作中总客户数不提供' as qt_in_cust_cnt,
	'合作中总客户金额不提供' as qt_in_cust_money,
	count(case when di.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造')  then new.id else null end) as qt_cert_cust_cnt,
	count(new.id) as cert_cust_cnt,
	count(income.customer_id) as income_cust_cnt,
	'合作中客户数不提供' as in_cust_cnt,
	count(case when income.all_money/10000 >=10 then income.customer_id else null end) as 10w_cust_cnt,
	sum(case when income.all_money/10000 >=10 then income.all_money else 0 end) as 10w_cust_money,
	count(case when income.all_money/10000 >=100 then income.customer_id else null end) as 100w_cust_cnt,
	sum(case when income.all_money/10000 >=100 then income.all_money else 0 end) as 100w_cust_money
from dw_erp_d_customer_base new
left join dim_industry di 
  on new.industry = di.d_ind_code
left join dim_org
on new.repertory_branch_id = dim_org.d_org_id
and dim_org.d_org_id = dim_org.branch_id
left join 
(select customer_id,
	   sum(case when substr(d_date,1,6) = 201701 then money else 0 end) as thie_money,
	   sum(money) as all_money
from dw_erp_a_crmfinance_income
where d_date >= 20160201
group by customer_id) income
on new.id = income.customer_id
where new.company_certificate not in ('','-1')
and new.p_date = 20170131
group by dim_org.branch_name
) hyfx
on jgzj.branch_name = hyfx.branch_name
full join 
(
--客户运营效率

select 
	dim_org.branch_name,
	round(count(cover.customer_id) / count(new.id),4) as cover_ratio,
	round(count(contract.customer_id) / count(cover.customer_id),4) as trans_ratio
from dw_erp_d_customer_base new
join dw_erp_d_salesuser_base suser 
  on new.sales_user_id = suser.id 
 and suser.p_date = 20170131 
 and suser.position_channel_name = 'LPT销售'
join dim_org
on suser.org_id = dim_org.d_org_id
left join (
  	select customer_id,creator_id
  	  from call_record
  	 where substr(call_date,1,6) = '201701'
  	   and time_long >45
  	 group by customer_id,creator_id
  	 union 
	select ccv.customer_id,ccv.creator_id
	from crm_customer_visitplan ccv
	where ccv.visit_status=1
		and ccv.deleteflag=0
		and regexp_replace (substr (ccv.createtime,1,10),"-","") > 20160401   -----排除测试数据
		and substr(ccv.visit_date,1,6) = '201701'
	group by ccv.customer_id,ccv.creator_id
  	) cover
on new.id = cover.customer_id
and suser.id = cover.creator_id
left join 
(select customer_id,secondparty_sign_id
   from dw_erp_d_contract_base
  where substr(regexp_replace(sign_date,'-',''),1,6) = '201701'
  group by customer_id,secondparty_sign_id
) contract 
on new.id = contract.customer_id
and suser.id = contract.secondparty_sign_id
where new.p_date = 20170131
 and new.company_certificate not in ('','-1')
group by dim_org.branch_name
) yyxl
on jgzj.branch_name = yyxl.branch_name
full join 
(
  select 
    base.sales_branch_name as branch_name,
    (sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as cnt_renewal_ratio,
	'金额续约率不提供'  as money_renewal_ratio
    from dw_erp_d_gcdc_contract_list_rpsuser contract
    join dw_erp_d_customer_base base on contract.customer_id = base.id and base.p_date = 20170131
    where contract.p_date = 20170131
    group by base.sales_branch_name

) renew 
on jgzj.branch_name = renew.branch_name
;



























select 
jgzj.branch_name,
jgzj.suser_cnt,	
jgzj.this_target, -- 本月业绩目标
jgzj.income_money, -- 本月回款金额
jgzj.income_ratio,	 -- 本月回款达成率
jgzj.gqhk_money, -- 去年同期回款金额
jgzj.ytoy_ratio, -- 同比增长
jgzj.income_mom_ratio, -- 环比增长
jgzj.person_money, -- 月人均单产
jgzj.income_year_ratio,	 -- 年度任务达成率
jgzj.income_year_ratio_rank, -- 年度任务达成率全国排名
jgzj.profit_target,	 -- 利润率目标
jgzj.profit_target_ratio,	 -- 利润率达成率
jgzj.profit_target_ratio_rank,			 -- 利润率达成率全国排名
jgzj.next_target, -- 下月目标回款
jgzj.receivable_money, -- 待回款
jgzj.first_quarter_amount, -- 季度回款目标
jgzj.gap, -- 本季度GAP
nvl(hyfx.hlw_cust_cnt,0) as hlw_cust_cnt , --回款客户数
nvl(hyfx.hlw_cust_money,0) as hlw_cust_money , --回款金额
nvl(hyfx.hlw_in_cust_cnt,0) as hlw_in_cust_cnt , --合作中总客户数
nvl(hyfx.hlw_in_cust_money,0) as hlw_in_cust_money , --合作中总客户金额
nvl(hyfx.hlw_cert_cust_cnt,0) as hlw_cert_cust_cnt , --库中总客户数（认证）
nvl(hyfx.fdc_cust_cnt,0) as fdc_cust_cnt , --回款客户数
nvl(hyfx.fdc_cust_money,0) as fdc_cust_money , --回款金额
nvl(hyfx.fdc_in_cust_cnt,0) as fdc_in_cust_cnt , --合作中总客户数
nvl(hyfx.fdc_in_cust_money,0) as fdc_in_cust_money , --合作中总客户金额
nvl(hyfx.fdc_cert_cust_cnt,0) as fdc_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.jr_cust_cnt,0) as jr_cust_cnt , --回款客户数
nvl(hyfx.jr_cust_money,0) as jr_cust_money , --回款金额
nvl(hyfx.jr_in_cust_cnt,0) as jr_in_cust_cnt , --合作中总客户数
nvl(hyfx.jr_in_cust_money,0) as jr_in_cust_money , --合作中总客户金额
nvl(hyfx.jr_cert_cust_cnt,0) as jr_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.xfp_cust_cnt,0) as xfp_cust_cnt , --回款客户数
nvl(hyfx.xfp_cust_money,0) as xfp_cust_money , --回款金额
nvl(hyfx.xfp_in_cust_cnt,0) as xfp_in_cust_cnt , --合作中总客户数
nvl(hyfx.xfp_in_cust_money,0) as xfp_in_cust_money , --合作中总客户金额
nvl(hyfx.xfp_cert_cust_cnt,0) as xfp_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.qc_cust_cnt,0) as qc_cust_cnt , --回款客户数
nvl(hyfx.qc_cust_money,0) as qc_cust_money , --回款金额
nvl(hyfx.qc_in_cust_cnt,0) as qc_in_cust_cnt , --合作中总客户数
nvl(hyfx.qc_in_cust_money,0) as qc_in_cust_money , --合作中总客户金额
nvl(hyfx.qc_cert_cust_cnt,0) as qc_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.qt_cust_cnt,0) as qt_cust_cnt , --回款客户数
nvl(hyfx.qt_cust_money,0) as qt_cust_money , --回款金额
nvl(hyfx.qt_in_cust_cnt,0) as qt_in_cust_cnt , --合作中总客户数
nvl(hyfx.qt_in_cust_money,0) as qt_in_cust_money , --合作中总客户金额
nvl(hyfx.qt_cert_cust_cnt,0) as qt_cert_cust_cnt , --库中总客户数（认证）
nvl(hyfx.cert_cust_cnt,0) as cert_cust_cnt , -- 库中客户总量（认证）
nvl(hyfx.income_cust_cnt,0) as income_cust_cnt , -- 回款客户数
nvl(hyfx.in_cust_cnt,0) as in_cust_cnt , -- 合作中客户数
nvl(yyxl.cover_ratio,0) as cover_ratio, -- 客户覆盖率
nvl(yyxl.trans_ratio,0) as trans_ratio, -- 新签客户电话客户转化率
nvl(renew.money_renewal_ratio,0) as money_renewal_ratio, -- 金额续约率
nvl(renew.cnt_renewal_ratio,0) as cnt_renewal_ratio, -- 单数续约率
nvl(hyfx.10w_cust_cnt,0) as 10w_cust_cnt ,  -- 十万以上客户数
nvl(hyfx.10w_cust_money,0) as 10w_cust_money ,  -- 十万以上客户金额
nvl(hyfx.100w_cust_cnt,0) as 100w_cust_cnt , -- 百万以上客户数
nvl(hyfx.100w_cust_money,0) as 100w_cust_money  -- 百万以上客户金额
from (
	select 
		coalesce(target.branch_name,income2.branch_name,recv.branch_name) as branch_name,
		sum(recv.suser_cnt) as suser_cnt,	
		sum(target.this_target) as this_target,
		sum(income2.income_money) as income_money,
		round(sum(income2.income_money)/sum(target.this_target),4) as income_ratio,	
		'去年同期回款金额不提供' as gqhk_money,
		'同比增长不提供' as ytoy_ratio,
		round((sum(income2.income_money)-sum(income2.last_money))/sum(income2.last_money),4) as income_mom_ratio,
		round(sum(income2.income_money)/sum(recv.suser_cnt),2) as person_money,
		round(sum(income2.year_money)/sum(target.year_target),4) as income_year_ratio,	
		'年度任务达成率全国排名' as income_year_ratio_rank,
		'利润率目标不提供' as profit_target,	
		'利润率达成率不提供' as profit_target_ratio,	
		'利润率达成率全国排名不提供' as profit_target_ratio_rank,			
		sum(target.next_target) as next_target,
		sum(recv.receivable_money) as receivable_money,
		sum(target.first_quarter_amount) as first_quarter_amount,
		'本季度GAP不提供' as gap
	from 
	(						
	  select dim_org.org_name as branch_name,
	  		object_id,
	  		nvl(last_target,0) as last_target,
	  		nvl(this_target,0) as this_target,
	  		nvl(next_target,0) as next_target,
	    	nvl(year_target,0) as year_target,
	      	nvl(first_quarter_amount,0) as first_quarter_amount	
	    from (
		select id,object_id,type,
		  double(get_json_object(target_amount_detail,'$.year_amount'))* 10000 as year_target,
		  double(get_json_object(target_amount_detail,'$.first_quarter_amount'))* 10000 as first_quarter_amount,
		  double(get_json_object(target_amount_detail,'$.jan_amount'))* 10000 as last_target,
		  double(get_json_object(target_amount_detail,'$.feb_amount'))* 10000 as this_target,
		  double(get_json_object(target_amount_detail,'$.mar_amount'))* 10000 as next_target,
		  row_number()over(distribute by object_id,type,year sort by id desc) as rn
		from crm_target_management
		where deleteflag = 0 
		 and year = 2017
		 and type = 0
	   )  ctm
	   join dim_org 
	   on ctm.object_id = dim_org.d_org_id 
	   and dim_org.d_org_id = dim_org.branch_id
	  where ctm.rn = 1
	)  target 
	full join 
	(
		select sales_branch_name as branch_name,dmonth,income_money,last_money,year_money
		from (
			select sales_branch_name,dmonth,income_money,
			row_number()over(distribute by sales_branch_name sort by dmonth desc) as rn,
			lead(income_money,1,0)over(distribute by sales_branch_name sort by dmonth desc) as last_money,
			sum(income_money)over(distribute by sales_branch_name) as year_money
			from (
				select sales_branch_name,substr(income.d_date,1,6) as dmonth,sum(money) as income_money
				  from dw_erp_a_crmfinance_income income 
				  left join dw_erp_d_customer_base_new new 
				  on income.customer_id = new.id 
				  where substr(income.d_date,1,6) between 201701 and 201702
				  group by new.sales_branch_name,substr(income.d_date,1,6)
			) income0
		) income1
		where rn = 1
	) income2
	on target.branch_name = income2.branch_name
	full join
	(
	 select dim_org.branch_name,
	 		count(case when status in (0,1) and is_saleuser = 1 and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售') then id else null end) as suser_cnt ,
	 		sum(receivable_money) as receivable_money
	 from dw_erp_d_salesuser_base suser 
	 join dim_org on suser.org_id = dim_org.d_org_id
	 left join 
	 (select creator_id,sum(money) as receivable_money
	  from recovery.crm_finance_receivables_history_20170228_20170228
	  where deleteflag = 0
	  and status = 0
	  group by creator_id
	 ) receivables
	on suser.id = receivables.creator_id
	 where p_date = 20170228
	 group by dim_org.branch_name
	) recv 
	on target.branch_name = recv.branch_name
	group by coalesce(target.branch_name,income2.branch_name,recv.branch_name)
) jgzj 
full join 
(

--签约客户行业分析
select 
	dim_org.branch_name,
	count(case when di.d_main_industry = '互联网.游戏.软件' then income.customer_id else null end) as hlw_cust_cnt,
	sum(case when di.d_main_industry = '互联网.游戏.软件' then thie_money else 0 end) as hlw_cust_money,
	'合作中总客户数不提供' as hlw_in_cust_cnt,
	'合作中总客户金额不提供' as hlw_in_cust_money,
	count(case when di.d_main_industry = '互联网.游戏.软件' then new.id else null end) as hlw_cert_cust_cnt,
	count(case when di.d_main_industry = '房地产.建筑.物业' then income.customer_id else null end) as fdc_cust_cnt,
	sum(case when di.d_main_industry = '房地产.建筑.物业' then thie_money else 0 end) as fdc_cust_money,
	'合作中总客户数不提供' as fdc_in_cust_cnt,
	'合作中总客户金额不提供' as fdc_in_cust_money,
	count(case when di.d_main_industry = '房地产.建筑.物业' then new.id else null end) as fdc_cert_cust_cnt,	
	count(case when di.d_main_industry = '金融' then income.customer_id else null end) as jr_cust_cnt,
	sum(case when di.d_main_industry = '金融' then thie_money else 0 end) as jr_cust_money,
	'合作中总客户数不提供' as jr_in_cust_cnt,
	'合作中总客户金额不提供' as jr_in_cust_money,
	count(case when di.d_main_industry = '金融' then new.id else null end) as jr_cert_cust_cnt,	
	count(case when di.d_main_industry = '消费品' then income.customer_id else null end) as xfp_cust_cnt,
	sum(case when di.d_main_industry = '消费品' then thie_money else 0 end) as xfp_cust_money,
	'合作中总客户数不提供' as xfp_in_cust_cnt,
	'合作中总客户金额不提供' as xfp_in_cust_money,
	count(case when di.d_main_industry = '消费品' then new.id else null end) as xfp_cert_cust_cnt,	
	count(case when di.d_main_industry = '汽车.机械.制造' then income.customer_id else null end) as qc_cust_cnt,
	sum(case when di.d_main_industry = '汽车.机械.制造' then thie_money else 0 end) as qc_cust_money,
	'合作中总客户数不提供' as qc_in_cust_cnt,
	'合作中总客户金额不提供' as qc_in_cust_money,
	count(case when di.d_main_industry = '汽车.机械.制造' then new.id else null end) as qc_cert_cust_cnt,	
	count(case when di.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造')  then income.customer_id else null end) as qt_cust_cnt,
	sum(case when di.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造')  then thie_money else 0 end) as qt_cust_money,
	'合作中总客户数不提供' as qt_in_cust_cnt,
	'合作中总客户金额不提供' as qt_in_cust_money,
	count(case when di.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造')  then new.id else null end) as qt_cert_cust_cnt,
	count(new.id) as cert_cust_cnt,
	count(income.customer_id) as income_cust_cnt,
	'合作中客户数不提供' as in_cust_cnt,
	count(case when income.all_money/10000 >=10 then income.customer_id else null end) as 10w_cust_cnt,
	sum(case when income.all_money/10000 >=10 then income.all_money else 0 end) as 10w_cust_money,
	count(case when income.all_money/10000 >=100 then income.customer_id else null end) as 100w_cust_cnt,
	sum(case when income.all_money/10000 >=100 then income.all_money else 0 end) as 100w_cust_money
from dw_erp_d_customer_base new
left join dim_industry di 
  on new.industry = di.d_ind_code
left join dim_org
on new.repertory_branch_id = dim_org.d_org_id
and dim_org.d_org_id = dim_org.branch_id
left join 
(select customer_id,
	   sum(case when substr(d_date,1,6) = 201702 then money else 0 end) as thie_money,
	   sum(money) as all_money
from dw_erp_a_crmfinance_income
where d_date >= 20160301
group by customer_id) income
on new.id = income.customer_id
where new.company_certificate not in ('','-1')
and new.p_date = 20170228
group by dim_org.branch_name
) hyfx
on jgzj.branch_name = hyfx.branch_name
full join 
(
--客户运营效率

select 
	dim_org.branch_name,
	round(count(cover.customer_id) / count(new.id),4) as cover_ratio,
	round(count(contract.customer_id) / count(cover.customer_id),4) as trans_ratio
from dw_erp_d_customer_base new
join dw_erp_d_salesuser_base suser 
  on new.sales_user_id = suser.id 
 and suser.p_date = 20170228 
 and suser.position_channel_name = 'LPT销售'
join dim_org
on suser.org_id = dim_org.d_org_id
left join (
  	select customer_id,creator_id
  	  from call_record
  	 where substr(call_date,1,6) = '201702'
  	   and time_long >45
  	 group by customer_id,creator_id
  	 union 
	select ccv.customer_id,ccv.creator_id
	from crm_customer_visitplan ccv
	where ccv.visit_status=1
		and ccv.deleteflag=0
		and regexp_replace (substr (ccv.createtime,1,10),"-","") > 20160401   -----排除测试数据
		and substr(ccv.visit_date,1,6) = '201702'
	group by ccv.customer_id,ccv.creator_id  	 
  	) cover
on new.id = cover.customer_id
and suser.id = cover.creator_id
left join 
(select customer_id,secondparty_sign_id
   from dw_erp_d_contract_base
  where substr(regexp_replace(sign_date,'-',''),1,6) = '201702'
  group by customer_id,secondparty_sign_id
) contract 
on new.id = contract.customer_id
and suser.id = contract.secondparty_sign_id
where new.p_date = 20170228
 and new.company_certificate not in ('','-1')
group by dim_org.branch_name
) yyxl
on jgzj.branch_name = yyxl.branch_name
full join 
(
  select 
    base.sales_branch_name as branch_name,
    (sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as cnt_renewal_ratio,
	'金额续约率不提供'  as money_renewal_ratio
    from dw_erp_d_gcdc_contract_list_rpsuser contract
    join dw_erp_d_customer_base base on contract.customer_id = base.id and base.p_date = 20170228
    where contract.p_date = 20170228
    group by base.sales_branch_name

) renew 
on jgzj.branch_name = renew.branch_name
























select 
jgzj.branch_name,
jgzj.suser_cnt,	
jgzj.this_target, -- 本月业绩目标
jgzj.income_money, -- 本月回款金额
jgzj.income_ratio,	 -- 本月回款达成率
jgzj.gqhk_money, -- 去年同期回款金额
jgzj.ytoy_ratio, -- 同比增长
jgzj.income_mom_ratio, -- 环比增长
jgzj.person_money, -- 月人均单产
jgzj.income_year_ratio,	 -- 年度任务达成率
jgzj.income_year_ratio_rank, -- 年度任务达成率全国排名
jgzj.profit_target,	 -- 利润率目标
jgzj.profit_target_ratio,	 -- 利润率达成率
jgzj.profit_target_ratio_rank,			 -- 利润率达成率全国排名
jgzj.next_target, -- 下月目标回款
jgzj.receivable_money, -- 待回款
jgzj.first_quarter_amount, -- 季度回款目标
jgzj.gap, -- 本季度GAP
nvl(hyfx.hlw_cust_cnt,0) as hlw_cust_cnt , --回款客户数
nvl(hyfx.hlw_cust_money,0) as hlw_cust_money , --回款金额
nvl(hyfx.hlw_in_cust_cnt,0) as hlw_in_cust_cnt , --合作中总客户数
nvl(hyfx.hlw_in_cust_money,0) as hlw_in_cust_money , --合作中总客户金额
nvl(hyfx.hlw_cert_cust_cnt,0) as hlw_cert_cust_cnt , --库中总客户数（认证）
nvl(hyfx.fdc_cust_cnt,0) as fdc_cust_cnt , --回款客户数
nvl(hyfx.fdc_cust_money,0) as fdc_cust_money , --回款金额
nvl(hyfx.fdc_in_cust_cnt,0) as fdc_in_cust_cnt , --合作中总客户数
nvl(hyfx.fdc_in_cust_money,0) as fdc_in_cust_money , --合作中总客户金额
nvl(hyfx.fdc_cert_cust_cnt,0) as fdc_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.jr_cust_cnt,0) as jr_cust_cnt , --回款客户数
nvl(hyfx.jr_cust_money,0) as jr_cust_money , --回款金额
nvl(hyfx.jr_in_cust_cnt,0) as jr_in_cust_cnt , --合作中总客户数
nvl(hyfx.jr_in_cust_money,0) as jr_in_cust_money , --合作中总客户金额
nvl(hyfx.jr_cert_cust_cnt,0) as jr_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.xfp_cust_cnt,0) as xfp_cust_cnt , --回款客户数
nvl(hyfx.xfp_cust_money,0) as xfp_cust_money , --回款金额
nvl(hyfx.xfp_in_cust_cnt,0) as xfp_in_cust_cnt , --合作中总客户数
nvl(hyfx.xfp_in_cust_money,0) as xfp_in_cust_money , --合作中总客户金额
nvl(hyfx.xfp_cert_cust_cnt,0) as xfp_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.qc_cust_cnt,0) as qc_cust_cnt , --回款客户数
nvl(hyfx.qc_cust_money,0) as qc_cust_money , --回款金额
nvl(hyfx.qc_in_cust_cnt,0) as qc_in_cust_cnt , --合作中总客户数
nvl(hyfx.qc_in_cust_money,0) as qc_in_cust_money , --合作中总客户金额
nvl(hyfx.qc_cert_cust_cnt,0) as qc_cert_cust_cnt ,	 --库中总客户数（认证）
nvl(hyfx.qt_cust_cnt,0) as qt_cust_cnt , --回款客户数
nvl(hyfx.qt_cust_money,0) as qt_cust_money , --回款金额
nvl(hyfx.qt_in_cust_cnt,0) as qt_in_cust_cnt , --合作中总客户数
nvl(hyfx.qt_in_cust_money,0) as qt_in_cust_money , --合作中总客户金额
nvl(hyfx.qt_cert_cust_cnt,0) as qt_cert_cust_cnt , --库中总客户数（认证）
nvl(hyfx.cert_cust_cnt,0) as cert_cust_cnt , -- 库中客户总量（认证）
nvl(hyfx.income_cust_cnt,0) as income_cust_cnt , -- 回款客户数
nvl(hyfx.in_cust_cnt,0) as in_cust_cnt , -- 合作中客户数
nvl(yyxl.cover_ratio,0) as cover_ratio, -- 客户覆盖率
nvl(yyxl.trans_ratio,0) as trans_ratio, -- 新签客户电话客户转化率
nvl(renew.money_renewal_ratio,0) as money_renewal_ratio, -- 金额续约率
nvl(renew.cnt_renewal_ratio,0) as cnt_renewal_ratio, -- 单数续约率
nvl(hyfx.10w_cust_cnt,0) as 10w_cust_cnt ,  -- 十万以上客户数
nvl(hyfx.10w_cust_money,0) as 10w_cust_money ,  -- 十万以上客户金额
nvl(hyfx.100w_cust_cnt,0) as 100w_cust_cnt , -- 百万以上客户数
nvl(hyfx.100w_cust_money,0) as 100w_cust_money  -- 百万以上客户金额
from (
	select 
		coalesce(target.branch_name,income2.branch_name,recv.branch_name) as branch_name,
		sum(recv.suser_cnt) as suser_cnt,	
		sum(target.this_target) as this_target,
		sum(income2.income_money) as income_money,
		round(sum(income2.income_money)/sum(target.this_target),4) as income_ratio,	
		'去年同期回款金额不提供' as gqhk_money,
		'同比增长不提供' as ytoy_ratio,
		round((sum(income2.income_money)-sum(income2.last_money))/sum(income2.last_money),4) as income_mom_ratio,
		round(sum(income2.income_money)/sum(recv.suser_cnt),2) as person_money,
		round(sum(income2.year_money)/sum(target.year_target),4) as income_year_ratio,	
		'年度任务达成率全国排名' as income_year_ratio_rank,
		'利润率目标不提供' as profit_target,	
		'利润率达成率不提供' as profit_target_ratio,	
		'利润率达成率全国排名不提供' as profit_target_ratio_rank,			
		sum(target.next_target) as next_target,
		sum(recv.receivable_money) as receivable_money,
		sum(target.first_quarter_amount) as first_quarter_amount,
		'本季度GAP不提供' as gap
	from 
	(						
	  select dim_org.org_name as branch_name,
	  		object_id,
	  		nvl(last_target,0) as last_target,
	  		nvl(this_target,0) as this_target,
	  		nvl(next_target,0) as next_target,
	    	nvl(year_target,0) as year_target,
	      	nvl(first_quarter_amount,0) as first_quarter_amount	
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
		 and year = 2017
		 and type = 0
	   )  ctm
	   join dim_org 
	   on ctm.object_id = dim_org.d_org_id 
	   and dim_org.d_org_id = dim_org.branch_id
	  where ctm.rn = 1
	)  target 
	full join 
	(
		select sales_branch_name as branch_name,dmonth,income_money,last_money,year_money
		from (
			select sales_branch_name,dmonth,income_money,
			row_number()over(distribute by sales_branch_name sort by dmonth desc) as rn,
			lead(income_money,1,0)over(distribute by sales_branch_name sort by dmonth desc) as last_money,
			sum(income_money)over(distribute by sales_branch_name) as year_money
			from (
				select sales_branch_name,substr(income.d_date,1,6) as dmonth,sum(money) as income_money
				  from dw_erp_a_crmfinance_income income 
				  left join dw_erp_d_customer_base_new new 
				  on income.customer_id = new.id 
				  where substr(income.d_date,1,6) between 201701 and 201703
				  group by new.sales_branch_name,substr(income.d_date,1,6)
			) income0
		) income1
		where rn = 1
	) income2
	on target.branch_name = income2.branch_name
	full join
	(
	 select dim_org.branch_name,
	 		count(case when status in (0,1) and is_saleuser = 1 and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售') then id else null end) as suser_cnt ,
	 		sum(receivable_money) as receivable_money
	 from dw_erp_d_salesuser_base suser 
	 join dim_org on suser.org_id = dim_org.d_org_id
	 left join 
	 (select creator_id,sum(money) as receivable_money
	  from crm_finance_receivables
	  where deleteflag = 0
	  and status = 0
	  group by creator_id
	 ) receivables
	on suser.id = receivables.creator_id
	 where p_date = 20170331
	 group by dim_org.branch_name
	) recv 
	on target.branch_name = recv.branch_name
	group by coalesce(target.branch_name,income2.branch_name,recv.branch_name)
) jgzj 
full join 
(

--签约客户行业分析
select 
	dim_org.branch_name,
	count(case when di.d_main_industry = '互联网.游戏.软件' then income.customer_id else null end) as hlw_cust_cnt,
	sum(case when di.d_main_industry = '互联网.游戏.软件' then thie_money else 0 end) as hlw_cust_money,
	'合作中总客户数不提供' as hlw_in_cust_cnt,
	'合作中总客户金额不提供' as hlw_in_cust_money,
	count(case when di.d_main_industry = '互联网.游戏.软件' then new.id else null end) as hlw_cert_cust_cnt,
	count(case when di.d_main_industry = '房地产.建筑.物业' then income.customer_id else null end) as fdc_cust_cnt,
	sum(case when di.d_main_industry = '房地产.建筑.物业' then thie_money else 0 end) as fdc_cust_money,
	'合作中总客户数不提供' as fdc_in_cust_cnt,
	'合作中总客户金额不提供' as fdc_in_cust_money,
	count(case when di.d_main_industry = '房地产.建筑.物业' then new.id else null end) as fdc_cert_cust_cnt,	
	count(case when di.d_main_industry = '金融' then income.customer_id else null end) as jr_cust_cnt,
	sum(case when di.d_main_industry = '金融' then thie_money else 0 end) as jr_cust_money,
	'合作中总客户数不提供' as jr_in_cust_cnt,
	'合作中总客户金额不提供' as jr_in_cust_money,
	count(case when di.d_main_industry = '金融' then new.id else null end) as jr_cert_cust_cnt,	
	count(case when di.d_main_industry = '消费品' then income.customer_id else null end) as xfp_cust_cnt,
	sum(case when di.d_main_industry = '消费品' then thie_money else 0 end) as xfp_cust_money,
	'合作中总客户数不提供' as xfp_in_cust_cnt,
	'合作中总客户金额不提供' as xfp_in_cust_money,
	count(case when di.d_main_industry = '消费品' then new.id else null end) as xfp_cert_cust_cnt,	
	count(case when di.d_main_industry = '汽车.机械.制造' then income.customer_id else null end) as qc_cust_cnt,
	sum(case when di.d_main_industry = '汽车.机械.制造' then thie_money else 0 end) as qc_cust_money,
	'合作中总客户数不提供' as qc_in_cust_cnt,
	'合作中总客户金额不提供' as qc_in_cust_money,
	count(case when di.d_main_industry = '汽车.机械.制造' then new.id else null end) as qc_cert_cust_cnt,	
	count(case when di.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造')  then income.customer_id else null end) as qt_cust_cnt,
	sum(case when di.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造')  then thie_money else 0 end) as qt_cust_money,
	'合作中总客户数不提供' as qt_in_cust_cnt,
	'合作中总客户金额不提供' as qt_in_cust_money,
	count(case when di.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造')  then new.id else null end) as qt_cert_cust_cnt,
	count(new.id) as cert_cust_cnt,
	count(income.customer_id) as income_cust_cnt,
	'合作中客户数不提供' as in_cust_cnt,
	count(case when income.all_money/10000 >=10 then income.customer_id else null end) as 10w_cust_cnt,
	sum(case when income.all_money/10000 >=10 then income.all_money else 0 end) as 10w_cust_money,
	count(case when income.all_money/10000 >=100 then income.customer_id else null end) as 100w_cust_cnt,
	sum(case when income.all_money/10000 >=100 then income.all_money else 0 end) as 100w_cust_money
from dw_erp_d_customer_base new
left join dim_industry di 
  on new.industry = di.d_ind_code
left join dim_org
on new.repertory_branch_id = dim_org.d_org_id
and dim_org.d_org_id = dim_org.branch_id
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
group by dim_org.branch_name
) hyfx
on jgzj.branch_name = hyfx.branch_name
full join 
(
--客户运营效率

select 
	dim_org.branch_name,
	round(count(cover.customer_id) / count(new.id),4) as cover_ratio,
	round(count(contract.customer_id) / count(cover.customer_id),4) as trans_ratio
from dw_erp_d_customer_base new
join dw_erp_d_salesuser_base suser 
  on new.sales_user_id = suser.id 
 and suser.p_date = 20170331 
 and suser.position_channel_name = 'LPT销售'
join dim_org
on suser.org_id = dim_org.d_org_id
left join (
  	select customer_id,creator_id
  	  from call_record
  	 where substr(call_date,1,6) = '201703'
  	   and time_long >45
  	 group by customer_id,creator_id
  	 union 
	select ccv.customer_id,ccv.creator_id
	from crm_customer_visitplan ccv
	where ccv.visit_status=1
		and ccv.deleteflag=0
		and regexp_replace (substr (ccv.createtime,1,10),"-","") > 20160401   -----排除测试数据
		and substr(ccv.visit_date,1,6) = '201703'
	group by ccv.customer_id,ccv.creator_id  	 
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
group by dim_org.branch_name
) yyxl
on jgzj.branch_name = yyxl.branch_name
full join 
(
  select 
    base.sales_branch_name as branch_name,
    (sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as cnt_renewal_ratio,
	'金额续约率不提供'  as money_renewal_ratio
    from dw_erp_d_gcdc_contract_list_rpsuser contract
    join dw_erp_d_customer_base base on contract.customer_id = base.id and base.p_date = 20170331
    where contract.p_date = 20170331
    group by base.sales_branch_name

) renew 
on jgzj.branch_name = renew.branch_name




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
	round((sum(suser_act.cover_cnt)+sum(visit.visit_cust_cnt))/sum(suser_act.cert_cust_cnt),4) as cover_ratio,
	sum(suser_act.trans_cust_cnt) as trans_cust_cnt,
	round(sum(suser_act.trans_cust_cnt)/(sum(suser_act.cover_cnt)+sum(visit.visit_cust_cnt)),4) as trans_ratio,
	'金额续约率不提供'  as money_renewal_ratio,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as cnt_renewal_ratio,
	sum(suser_act.w1_cust_cnt) as w1_cust_cnt,
	sum(suser_act.w2_cust_cnt) as w2_cust_cnt,
	sum(suser_act.w3_cust_cnt) as w3_cust_cnt,
	sum(suser_act.w5_cust_cnt) + sum(suser_act.g5w_cust_cnt) as g3w_cust_cnt,
	sum(suser_act.w1_cust_cnt) + sum(suser_act.w2_cust_cnt) +  sum(suser_act.w3_cust_cnt) as l3w_cust_cnt,
	sum(suser_act.w5_cust_cnt) as w5_cust_cnt,
	sum(suser_act.g5w_cust_cnt) as g5w_cust_cnt,
	round(count(case when nvl(suser_act.income_money,0) >= 20000 then su2.id else null end) / count(su2.id),4) as w2_suser_ratio,
    round(count(case when nvl(suser_act.income_money,0) >= 50000 then su2.id else null end) / count(su2.id),4) as w5_suser_ratio
from temp_mancj_20170406112328 target--target
join (
	select id,name,parent_id
    from (
    select id,name,parent_salesuser_id_list
    from dw_erp_d_salesuser_base  
    where status in (0,1)
    and is_saleuser = 1 
    and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售')
    and p_date = 20170131
    ) su
    lateral view explode(split(parent_salesuser_id_list,',')) i as parent_id
) su2 
on target.id = su2.parent_id
left join 
(select sales_user_id, income_money, last_money, year_money, receivable_money, 
	--hlw_cust_cnt, hlw_cust_money, hlw_cert_cust_cnt, fdc_cust_cnt, fdc_cust_money, fdc_cert_cust_cnt, jr_cust_cnt, jr_cust_money, jr_cert_cust_cnt, xfp_cust_cnt, xfp_cust_money, xfp_cert_cust_cnt, qc_cust_cnt, qc_cust_money, qc_cert_cust_cnt, qt_cust_cnt, qt_cust_money, qt_cert_cust_cnt, 
	cert_cust_cnt, income_cust_cnt, w1_cust_cnt, w1_cust_money, w2_cust_cnt, w2_cust_money, w3_cust_cnt, w3_cust_money, w5_cust_cnt, w5_cust_money, g5w_cust_cnt, g5w_cust_money, cover_cnt, trans_cust_cnt
from temp_mancj_20170406110903  suser_act
) suser_act
on su2.id = suser_act.sales_user_id
left join 
(
  select 
    base.sales_user_id,
    sum(is_expire_renewal) as is_expire_renewal, 
    sum(is_pre_expire_renewal) as is_pre_expire_renewal,
    sum(is_expire) as is_expire,  
    sum(is_expire_pre_renewal) as is_expire_pre_renewal
    from dw_erp_d_gcdc_contract_list_rpsuser contract
    join dw_erp_d_customer_base base on contract.customer_id = base.id and base.p_date = 20170131
    where contract.p_date = 20170131
    group by base.sales_user_id
) renew 
on su2.id = renew.sales_user_id
left join 
(
	select count(ccv.customer_id) as visit_cust_cnt,ccv.creator_id
	from crm_customer_visitplan ccv
	where ccv.visit_status=1
		and ccv.deleteflag=0
		and regexp_replace (substr (ccv.createtime,1,10),"-","") > 20160401   -----排除测试数据
		and substr(ccv.visit_date,1,6) = '201701'
	group by ccv.creator_id
) visit 
on su2.id = visit.creator_id

left join 
(	select target.id,count(su2.id) as last_user_cnt
	from temp_mancj_20170406112328  target--target
	join (
		select id,name,parent_id
	    from (
	    select id,name,parent_salesuser_id_list
	    from dw_erp_d_salesuser_base  
	    where status in (0,1)
	    and is_saleuser = 1 
	    and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售')
	    and p_date = 20161231
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


--1月绩效
select 
	target.name,
	target.title,
	target.branch,
	target.id,
	count(su2.id) as user_cnt,
	sum(case when nvl(suser_act.income_money,0) = 0 
			and su2.position_level not in ('B0002149','B0002153','B0002141') then 1 else 0 end) as none_kpi,
	sum(case when target.branch in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > 0
					and nvl(suser_act.income_money,0) < tst.first_value then 1
			when target.branch not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > 0
					and nvl(suser_act.income_money,0) < tst.second_value then 1
		    else 0 end) as low_kpi,
	sum(case when target.branch in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) >= tst.first_value 
					and nvl(suser_act.income_money,0) < tst.l_first_value  then 1
			when target.branch not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) >= tst.second_value 
					and nvl(suser_act.income_money,0) < tst.l_second_value  then 1
		    else 0 end) as mid_kpi,	
	sum(case when target.branch in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > tst.l_first_value  then 1
			when target.branch not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > tst.l_second_value  then 1
		    else 0 end) as high_kpi
from temp_mancj_20170406112328 target--target
join (
	select id,name,parent_id,position_level
    from (
    select id,name,parent_salesuser_id_list,position_level
    from dw_erp_d_salesuser_base  
    where status in (0,1)
    and is_saleuser = 1 
    and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售')
    and p_date = 20170131
    ) su
    lateral view explode(split(parent_salesuser_id_list,',')) i as parent_id
) su2 
on target.id = su2.parent_id
left join 
(select sales_user_id, income_money
	from temp_mancj_20170406110903  suser_act
) suser_act
on su2.id = suser_act.sales_user_id
left join temp_sales_task tst 
on su2.position_level = tst.position_level
group by target.name,
target.title,
target.branch,
target.id



select 
	su2.branch_name,
	count(su2.id) as user_cnt,
	sum(case when nvl(suser_act.income_money,0) = 0 
			and su2.position_level not in ('B0002149','B0002153','B0002141') then 1 else 0 end) as none_kpi,
	sum(case when su2.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > 0
					and nvl(suser_act.income_money,0) < tst.first_value then 1
			when su2.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > 0
					and nvl(suser_act.income_money,0) < tst.second_value then 1
		    else 0 end) as low_kpi,
	sum(case when su2.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) >= tst.first_value 
					and nvl(suser_act.income_money,0) < tst.l_first_value  then 1
			when su2.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) >= tst.second_value 
					and nvl(suser_act.income_money,0) < tst.l_second_value  then 1
		    else 0 end) as mid_kpi,	
	sum(case when su2.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > tst.l_first_value  then 1
			when su2.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > tst.l_second_value  then 1
		    else 0 end) as high_kpi
from (
	select dim_org.branch_name, id,name,position_level
	 from dw_erp_d_salesuser_base suser 
	 join dim_org on suser.org_id = dim_org.d_org_id
	 where p_date = 20170131
	   and status in (0,1)
	    and is_saleuser = 1 
	    and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售')
) su2 
left join 
(select sales_user_id, income_money
	from temp_mancj_20170406110903  suser_act
) suser_act
on su2.id = suser_act.sales_user_id
left join temp_sales_task tst 
on su2.position_level = tst.position_level
group by su2.branch_name



--2月总监数据
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
	round((sum(suser_act.cover_cnt)+sum(visit.visit_cust_cnt))/sum(suser_act.cert_cust_cnt),4) as cover_ratio,
	sum(suser_act.trans_cust_cnt) as trans_cust_cnt,
	round(sum(suser_act.trans_cust_cnt)/(sum(suser_act.cover_cnt)+sum(visit.visit_cust_cnt)),4) as trans_ratio,
	'金额续约率不提供'  as money_renewal_ratio,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as cnt_renewal_ratio,
	sum(suser_act.w1_cust_cnt) as w1_cust_cnt,
	sum(suser_act.w2_cust_cnt) as w2_cust_cnt,
	sum(suser_act.w3_cust_cnt) as w3_cust_cnt,
	sum(suser_act.w5_cust_cnt) + sum(suser_act.g5w_cust_cnt) as g3w_cust_cnt,
	sum(suser_act.w1_cust_cnt) + sum(suser_act.w2_cust_cnt) +  sum(suser_act.w3_cust_cnt) as l3w_cust_cnt,
	sum(suser_act.w5_cust_cnt) as w5_cust_cnt,
	sum(suser_act.g5w_cust_cnt) as g5w_cust_cnt,
	round(count(case when nvl(suser_act.income_money,0) >= 20000 then su2.id else null end) / count(su2.id),4) as w2_suser_ratio,
    round(count(case when nvl(suser_act.income_money,0) >= 50000 then su2.id else null end) / count(su2.id),4) as w5_suser_ratio
from temp_mancj_20170405230209 target--target
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
left join 
(select sales_user_id, income_money, last_money, year_money, receivable_money, 
	--hlw_cust_cnt, hlw_cust_money, hlw_cert_cust_cnt, fdc_cust_cnt, fdc_cust_money, fdc_cert_cust_cnt, jr_cust_cnt, jr_cust_money, jr_cert_cust_cnt, xfp_cust_cnt, xfp_cust_money, xfp_cert_cust_cnt, qc_cust_cnt, qc_cust_money, qc_cert_cust_cnt, qt_cust_cnt, qt_cust_money, qt_cert_cust_cnt, 
	cert_cust_cnt, income_cust_cnt, w1_cust_cnt, w1_cust_money, w2_cust_cnt, w2_cust_money, w3_cust_cnt, w3_cust_money, w5_cust_cnt, w5_cust_money, g5w_cust_cnt, g5w_cust_money, cover_cnt, trans_cust_cnt
from temp_mancj_20170405231407 suser_act
) suser_act
on su2.id = suser_act.sales_user_id
left join 
(
  select 
    base.sales_user_id,
    sum(is_expire_renewal) as is_expire_renewal, 
    sum(is_pre_expire_renewal) as is_pre_expire_renewal,
    sum(is_expire) as is_expire,  
    sum(is_expire_pre_renewal) as is_expire_pre_renewal
    from dw_erp_d_gcdc_contract_list_rpsuser contract
    join dw_erp_d_customer_base base on contract.customer_id = base.id and base.p_date = 20170228
    where contract.p_date = 20170228
    group by base.sales_user_id
) renew 
on su2.id = renew.sales_user_id
left join 
(
	select count(ccv.customer_id) as visit_cust_cnt,ccv.creator_id
	from crm_customer_visitplan ccv
	where ccv.visit_status=1
		and ccv.deleteflag=0
		and regexp_replace (substr (ccv.createtime,1,10),"-","") > 20160401   -----排除测试数据
		and substr(ccv.visit_date,1,6) = '201702'
	group by ccv.creator_id
) visit 
on su2.id = visit.creator_id
left join 
(	select target.id,count(su2.id) as last_user_cnt
	from temp_mancj_20170405230209 target--target
	join (
		select id,name,parent_id
	    from (
	    select id,name,parent_salesuser_id_list
	    from dw_erp_d_salesuser_base  
	    where status in (0,1)
	    and is_saleuser = 1 
	    and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售')
	    and p_date = 20170131
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

--2月组织绩效
select 
	target.name,
	target.title,
	target.branch,
	target.id,
	count(su2.id) as user_cnt,
	sum(case when nvl(suser_act.income_money,0) = 0 
			and su2.position_level not in ('B0002149','B0002153','B0002141') then 1 else 0 end) as none_kpi,
	sum(case when target.branch in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > 0
					and nvl(suser_act.income_money,0) < tst.first_value then 1
			when target.branch not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > 0
					and nvl(suser_act.income_money,0) < tst.second_value then 1
		    else 0 end) as low_kpi,
	sum(case when target.branch in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) >= tst.first_value 
					and nvl(suser_act.income_money,0) < tst.l_first_value  then 1
			when target.branch not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) >= tst.second_value 
					and nvl(suser_act.income_money,0) < tst.l_second_value  then 1
		    else 0 end) as mid_kpi,	
	sum(case when target.branch in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > tst.l_first_value  then 1
			when target.branch not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > tst.l_second_value  then 1
		    else 0 end) as high_kpi
from temp_mancj_20170405230209 target--target
join (
	select id,name,parent_id,position_level
    from (
    select id,name,parent_salesuser_id_list,position_level
    from dw_erp_d_salesuser_base  
    where status in (0,1)
    and is_saleuser = 1 
    and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售')
    and p_date = 20170228
    ) su
    lateral view explode(split(parent_salesuser_id_list,',')) i as parent_id
) su2 
on target.id = su2.parent_id
left join 
(select sales_user_id, income_money
	from temp_mancj_20170405231407  suser_act
) suser_act
on su2.id = suser_act.sales_user_id
left join temp_sales_task tst 
on su2.position_level = tst.position_level
group by target.name,
target.title,
target.branch,
target.id;


select 
	su2.branch_name,
	count(su2.id) as user_cnt,
	sum(case when nvl(suser_act.income_money,0) = 0 
			and su2.position_level not in ('B0002149','B0002153','B0002141') then 1 else 0 end) as none_kpi,
	sum(case when su2.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > 0
					and nvl(suser_act.income_money,0) < tst.first_value then 1
			when su2.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > 0
					and nvl(suser_act.income_money,0) < tst.second_value then 1
		    else 0 end) as low_kpi,
	sum(case when su2.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) >= tst.first_value 
					and nvl(suser_act.income_money,0) < tst.l_first_value  then 1
			when su2.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) >= tst.second_value 
					and nvl(suser_act.income_money,0) < tst.l_second_value  then 1
		    else 0 end) as mid_kpi,	
	sum(case when su2.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > tst.l_first_value  then 1
			when su2.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > tst.l_second_value  then 1
		    else 0 end) as high_kpi
from (
	select dim_org.branch_name, id,name,position_level
	 from dw_erp_d_salesuser_base suser 
	 join dim_org on suser.org_id = dim_org.d_org_id
	 where p_date = 20170228
	   and status in (0,1)
	    and is_saleuser = 1 
	    and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售')
) su2 
left join 
(select sales_user_id, income_money
	from temp_mancj_20170405231407  suser_act
) suser_act
on su2.id = suser_act.sales_user_id
left join temp_sales_task tst 
on su2.position_level = tst.position_level
group by su2.branch_name







--3月总监指标
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
	round((sum(suser_act.cover_cnt)+sum(visit.visit_cust_cnt))/sum(suser_act.cert_cust_cnt),4) as cover_ratio,
	sum(suser_act.trans_cust_cnt) as trans_cust_cnt,
	round(sum(suser_act.trans_cust_cnt)/(sum(suser_act.cover_cnt)+sum(visit.visit_cust_cnt)),4) as trans_ratio,
	'金额续约率不提供'  as money_renewal_ratio,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as cnt_renewal_ratio,
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
from temp_mancj_20170405231628 suser_act
) suser_act
on su2.id = suser_act.sales_user_id
left join 
(
  select 
    base.sales_user_id,
    sum(is_expire_renewal) as is_expire_renewal, 
    sum(is_pre_expire_renewal) as is_pre_expire_renewal,
    sum(is_expire) as is_expire,  
    sum(is_expire_pre_renewal) as is_expire_pre_renewal
    from dw_erp_d_gcdc_contract_list_rpsuser contract
    join dw_erp_d_customer_base base on contract.customer_id = base.id and base.p_date = 20170331
    where contract.p_date = 20170331
    group by base.sales_user_id
) renew 
on su2.id = renew.sales_user_id
left join 
(
	select count(ccv.customer_id) as visit_cust_cnt,ccv.creator_id
	from crm_customer_visitplan ccv
	where ccv.visit_status=1
		and ccv.deleteflag=0
		and regexp_replace (substr (ccv.createtime,1,10),"-","") > 20160401   -----排除测试数据
		and substr(ccv.visit_date,1,6) = '201703'
	group by ccv.creator_id
) visit 
on su2.id = visit.creator_id
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

--3月总监绩效
select 
	target.name,
	target.title,
	target.branch,
	target.id,
	count(su2.id) as user_cnt,
	sum(case when nvl(suser_act.income_money,0) = 0 
			and su2.position_level not in ('B0002149','B0002153','B0002141') then 1 else 0 end) as none_kpi,
	sum(case when target.branch in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > 0
					and nvl(suser_act.income_money,0) < tst.first_value then 1
			when target.branch not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > 0
					and nvl(suser_act.income_money,0) < tst.second_value then 1
		    else 0 end) as low_kpi,
	sum(case when target.branch in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) >= tst.first_value 
					and nvl(suser_act.income_money,0) < tst.l_first_value  then 1
			when target.branch not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) >= tst.second_value 
					and nvl(suser_act.income_money,0) < tst.l_second_value  then 1
		    else 0 end) as mid_kpi,	
	sum(case when target.branch in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > tst.l_first_value  then 1
			when target.branch not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > tst.l_second_value  then 1
		    else 0 end) as high_kpi
from temp_mancj_20170403223300 target--target
join (
	select id,name,parent_id,position_level
    from (
    select id,name,parent_salesuser_id_list,position_level
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
(select sales_user_id, income_money
	from temp_mancj_20170405231628  suser_act
) suser_act
on su2.id = suser_act.sales_user_id
left join temp_sales_task tst 
on su2.position_level = tst.position_level
group by target.name,
target.title,
target.branch,
target.id;

--3月城市绩效

select 
	su2.branch_name，
	count(su2.id) as user_cnt,
	sum(case when nvl(suser_act.income_money,0) = 0 
			and su2.position_level not in ('B0002149','B0002153','B0002141') then 1 else 0 end) as none_kpi,
	sum(case when su2.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > 0
					and nvl(suser_act.income_money,0) < tst.first_value then 1
			when su2.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > 0
					and nvl(suser_act.income_money,0) < tst.second_value then 1
		    else 0 end) as low_kpi,
	sum(case when su2.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) >= tst.first_value 
					and nvl(suser_act.income_money,0) < tst.l_first_value  then 1
			when su2.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) >= tst.second_value 
					and nvl(suser_act.income_money,0) < tst.l_second_value  then 1
		    else 0 end) as mid_kpi,	
	sum(case when su2.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > tst.l_first_value  then 1
			when su2.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
					and tst.position_level is not null 
					and nvl(suser_act.income_money,0) > tst.l_second_value  then 1
		    else 0 end) as high_kpi
from (
	select dim_org.branch_name,
 	  id,name,position_level
	 from dw_erp_d_salesuser_base suser 
	 join dim_org on suser.org_id = dim_org.d_org_id
	 where p_date = 20170331
	   and status in (0,1)
	    and is_saleuser = 1 
	    and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售')
) su2 
on target.id = su2.parent_id
left join 
(select sales_user_id, income_money
	from temp_mancj_20170405231628  suser_act
) suser_act
on su2.id = suser_act.sales_user_id
left join temp_sales_task tst 
on su2.position_level = tst.position_level
group by su2.branch_name
;






--产品组成
select
prod.branch_name,
contract_cnt,
rpo_cnt,
xy_cnt,
srp_cnt,
ad_cnt,
bc_cnt,
no_std_cnt,
a_suit,
b_suit,
c_suit
from (
select dim_org.branch_name,
	count(contract.id) as contract_cnt,
	count(case when contract.type = 10 then contract.id else null end) as xy_cnt,
	count(case when contract.type = 11 then contract.id else null end) as rpo_cnt,
	count(case when contract.lpt_products_instance in (0,'{"contractsuits":}') and nvl(it.haslptresource,0) = 0 and (contract.srp_products_instance not in (0,'{"contractsuits":}') or nvl(it.srp_cnt,0) > 0 ) then contract.id else null end) as srp_cnt,
	count(case when contract.lpt_products_instance in (0,'{"contractsuits":}') and nvl(it.haslptresource,0) = 0 and (contract.ad_products_instance not in (0,'{"contractsuits":}') or nvl(it.ad_cnt,0) > 0) then contract.id else null end) as ad_cnt,
	count(case when (contract.lpt_products_instance in (0,'{"contractsuits":}') and nvl(it.haslptresource,0) = 0 and nvl(it.bc_cnt,0) > 0 ) or   then contract.id else null end) as bc_cnt,
	count(case when contract.lpt_products_instance not in (0,'{"contractsuits":}') and nvl(it.haslptresource,0) = 0 then contract.id else null end) as no_std_cnt
from 
(select contract_id,
	    sum(money) as this_money
from dw_erp_a_crmfinance_income
where substr(d_date,1,6) = 201702
group by contract_id) income 
join dw_erp_d_contract_base contract 
on income.contract_id = contract.id 
and contract.p_date = 20170228
left join 
( select contract_id,
		 sum(case when haslptresource > 0 then 1 else 0 end) as haslptresource,
		 sum(case when instr(suitname,'广告') > 0 then 1 else 0 end) as ad_cnt,
		 sum(case when instr(suitname,'商业中心') > 0 then 1 else 0 end) as bc_cnt,
		 sum(case when instr(suitname,'薪酬报告') > 0 then 1 else 0 end) as srp_cnt
	from dw_erp_a_contract_saleitem 
	group by contract_id
) it 
on contract.id = it.contract_id
left join dim_org 
on contract.secondparty_sign_org = dim_org.d_org_id
group by dim_org.branch_name
) prod 
left join 
(
select branch_name,
	   max(case when rn = 1 then contract_cnt else null end) as a_suit,
	   max(case when rn = 2 then contract_cnt else null end) as b_suit,
	   max(case when rn = 3 then contract_cnt else null end) as c_suit
from (
	select
		branch_name,suitname,contract_cnt,
		row_number()over(distribute by branch_name sort by this_money desc) as rn 
	from (
		select dim_org.branch_name,it.suitname,
			   sum(income.this_money) as this_money,
			   count(it.contract_id) as contract_cnt
		from 
		(select contract_id,
			    sum(money) as this_money
		from dw_erp_a_crmfinance_income
		where substr(d_date,1,6) = 201702
		group by contract_id) income 
		join dw_erp_d_contract_base contract 
		on income.contract_id = contract.id 
		and contract.p_date = 20170228
		join 
		( select contract_id,suitid,suitname
			from dw_erp_a_contract_saleitem 
		   where haslptresource > 0
			group by contract_id,suitid,suitname
		) it 
		on contract.id = it.contract_id
		left join dim_org 
		on contract.secondparty_sign_org = dim_org.d_org_id
		group by dim_org.branch_name,it.suitname
	 ) fact0
) fact1
group by branch_name
) suit 
on prod.branch_name = suit.branch_name



alter table dw_erp_d_contract_base change object_suit_id object_suit_id int	comment '套餐id-弃用';


--套餐组成
select 
    dim_org.branch_name ,
	nvl(it.suitname,'非标'),
	count(contract.id) as contract_cnt				   
from 
(select contract_id,
	    sum(money) as this_money
from dw_erp_a_crmfinance_income
where substr(d_date,1,6) = 201703
group by contract_id) income 
join dw_erp_d_contract_base contract 
on income.contract_id = contract.id 
and contract.p_date = 20170331
left join 
( select contract_id,
		 case when sum(haslptresource) > 0 then 1 else 0 end as is_lpt_suit
	from dw_erp_a_contract_saleitem 
	group by contract_id
)it 
on contract.id = it.contract_id
left join dim_org 
on contract.secondparty_sign_org = dim_org.d_org_id
group by dim_org.branch_name ,nvl(it.suitname,'非标');




--合同明细
select dim_org.branch_name,
	count(contract.id) as contract_cnt,
	count(case when contract.type = 10 then contract.id else null end) as xy_cnt,
	count(case when contract.type = 11 then contract.id else null end) as rpo_cnt,
	count(case when contract.lpt_products_instance in (0,'{"contractsuits":}') and nvl(it.haslptresource,0) = 0 and (contract.srp_products_instance not in (0,'{"contractsuits":}') or nvl(it.srp_cnt,0) > 0 ) then contract.id else null end) as srp_cnt,
	count(case when contract.lpt_products_instance in (0,'{"contractsuits":}') and nvl(it.haslptresource,0) = 0 and (contract.ad_products_instance not in (0,'{"contractsuits":}') or nvl(it.ad_cnt,0) > 0) then contract.id else null end) as ad_cnt,
	count(case when (contract.lpt_products_instance in (0,'{"contractsuits":}') and nvl(it.haslptresource,0) = 0 and nvl(it.bc_cnt,0) > 0 ) or   then contract.id else null end) as bc_cnt,
	count(case when contract.lpt_products_instance not in (0,'{"contractsuits":}') and nvl(it.haslptresource,0) = 0 then contract.id else null end) as no_std_cnt
from 
(
	select income.contract_id,
		   sum(item.money) as income_money,
		   sum(case when item.type = 0 then item.money else 0 end) as online_money,
		   sum(case when item.type = 1 then item.money else 0 end) as rpo_money
	from dw_erp_a_crmfinance_income income 
	join crm_finance_receivables recv 
	on income.receivable_id = recv.id 
	and recv.status = 1
	and recv.deleteflag = 0
	join crm_finance_receivable_item item  
	on income.receivable_id = item.receivable_id
	and item.deleteflag = 0
	where substr(d_date,1,6) = 201703
	group by  income.contract_id
) income 
join dw_erp_d_contract_base contract 
on income.contract_id = contract.id 
and contract.p_date = 20170228
left join 
( select contract_id,
		 sum(case when haslptresource > 0 then money else 0 end) as lpt_suit_moeny,
		 sum(case when instr(suitname,'广告') > 0 then 1 else 0 end) as ad_money,
		 sum(case when instr(suitname,'商业中心') > 0 then 1 else 0 end) as bc_money,
		 sum(case when instr(suitname,'薪酬报告') > 0 then 1 else 0 end) as srp_money
	from dw_erp_a_contract_saleitem 
	group by contract_id
) it 
on contract.id = it.contract_id
left join dim_org 
on contract.secondparty_sign_org = dim_org.d_org_id;


select income.contract_id,
	   sum(item.money) as income_money,
	   sum(case when item.type = 0 then item.money else 0 end) as online_money,
	   sum(case when item.type = 1 then item.money else 0 end) as rpo_money
from dw_erp_a_crmfinance_income income 
join crm_finance_receivables recv 
on income.receivable_id = recv.id 
and recv.status = 1
and recv.deleteflag = 0
join crm_finance_receivable_item item  
on income.receivable_id = item.receivable_id
and item.deleteflag = 0
where substr(d_date,1,6) = 201703
group by  income.contract_id



select d_date,
d_month,
d_week,
row_number()over(distribute by d_year sort by d_month desc,d_week asc) as rn 
from dim_date 
where d_date like '201603%' or d_date like '201604%';


