--总监显示数据
select 
  m4.sd_name
, m4.sd_level
, m4.branch_name
, m4.id
, m4.sales_cnt
, m4.month_target
, m4.month_income_money
, m4.month_target_ratio
, sum(m4.year_income_money)over(distribute by m4.sd_name) / m4.year_target year_target_ratio
, rank()over(distribute by m4.sd_level sort by sum(m4.year_income_money)over(distribute by m4.sd_name) / m4.year_target desc) as  rank_year_target_ratio
, m4.month_person_income
, (m4.month_person_income - m3.month_person_income) / m3.month_person_income as ratio_month_person_income
, rank()over(distribute by m4.sd_level sort by m4.month_person_income desc) as rank_month_person_income
, m4.cust_cnt
, m4.cust_cover_ratio
, m4.cover_cust_cnt
, m4.low6_new_contract_trans_ratio
, m4.low12_new_contract_trans_ratio
, m4.big12_new_contract_trans_ratio
, m4.new_month_income_money
, m4.new_month_income_contract_cnt
, m4.renew_month_income_money
, m4.renew_month_income_contract_cnt
, m4.expire_no_renewal_cust_cnt
, m4.expire_no_renewal_cust_money
, m4.renewal_money_ratio
, m4.renewal_cnt_ratio
, m4.income_1w_below_cust_cnt
, m4.income_1w_2w_cust_cnt
, m4.income_2w_3w_cust_cnt
, m4.income_3w_above_cust_cnt
, m4.s_a_suit_cnt_name
, m4.s_a_suit_cnt
, m4.s_a_suit_money
, m4.s_b_suit_cnt_name
, m4.s_b_suit_cnt
, m4.s_b_suit_money
, m4.s_c_suit_cnt_name
, m4.s_c_suit_cnt
, m4.s_c_suit_money
, m4.s_other_cnt
, m4.s_other_money
, m4.s_ad_item_cnt
, m4.s_ad_item_money
, m4.income_3w_below_cust_cnt
, m4.income_3w_5w_cust_cnt
, m4.income_5w_above_cust_cnt
, m4.ss_a_suit_cnt_name
, m4.ss_a_suit_cnt
, m4.ss_a_suit_money
, m4.ss_b_suit_cnt_name
, m4.ss_b_suit_cnt
, m4.ss_b_suit_money
, m4.ss_c_suit_cnt_name
, m4.ss_c_suit_cnt
, m4.ss_c_suit_money
, m4.ss_other_cnt
, m4.ss_other_money
, m4.ss_ad_item_cnt
, m4.ss_ad_item_money
, m4.none_kpi
, m4.low_kpi
, m4.mid_kpi
, m4.high_kpi
, m4.avg_call_rec_cnt
, m4.avg_call_time_long
, m4.avg_input_cert_cust_cnt
, m4.income_2w_above_sales_cnt
, m4.avg_visit_cust_cnt
, m4.income_5w_above_sales_cnt
from temp_mancj_20170505222556   m4 --4月
left join temp_mancj_20170505113324 m3 --3月
on m4.sd_name = m3.sd_name
and m4.sd_level = m3.sd_level



--月度总监review基础指标  temp_mancj_20170505222556
select 
	   coalesce(sd_kpi.sd_name,prod.sd_name,suit.sd_name) as sd_name,
	   coalesce(sd_kpi.sd_level,prod.sd_level,suit.sd_level) as sd_level,
	   suser.branch_name,
	   suser.id,
	   	nvl(sd_kpi.sales_cnt,0) as sales_cnt,
		nvl(target.month_target,0) as month_target,			   	
		nvl(sd_kpi.month_income_money,0) as month_income_money,
		nvl(sd_kpi.month_income_money,0) / nvl(target.month_target,0) as month_target_ratio,
		nvl(sd_kpi.year_income_money,0) as year_income_money,
		nvl(target.year_target,0) as year_target,
		nvl(sd_kpi.year_income_money,0) / nvl(target.year_target,0) as year_target_ratio,
		'年度任务达成率全国排名' as rank_year_target_ratio,
		nvl(sd_kpi.month_person_income,0) as month_person_income,
		'月人均单产环比增长' as ratio_month_person_income,
		'月人均单产排名' as rank_month_person_income,
		nvl(sd_kpi.cust_cnt,0) as cust_cnt,
		nvl(sd_kpi.cust_cover_ratio,0) as cust_cover_ratio,
		nvl(sd_kpi.cover_cust_cnt,0) as cover_cust_cnt,
		nvl(sd_kpi.low6_new_contract_trans_ratio,0) as low6_new_contract_trans_ratio,
		nvl(sd_kpi.low12_new_contract_trans_ratio,0) as low12_new_contract_trans_ratio,
		nvl(sd_kpi.big12_new_contract_trans_ratio,0) as big12_new_contract_trans_ratio,
		nvl(sd_kpi.new_month_income_money,0) as new_month_income_money,
		nvl(sd_kpi.new_month_income_contract_cnt,0) as new_month_income_contract_cnt,
		nvl(sd_kpi.renew_month_income_money,0) as renew_month_income_money,
		nvl(sd_kpi.renew_month_income_contract_cnt,0) as renew_month_income_contract_cnt,
		nvl(sd_kpi.expire_no_renewal_cust_cnt,0) as expire_no_renewal_cust_cnt,
		nvl(sd_kpi.expire_no_renewal_cust_money,0) as expire_no_renewal_cust_money,
		nvl(sd_kpi.renewal_money_ratio,0) as renewal_money_ratio,
		nvl(sd_kpi.renewal_cnt_ratio,0) as renewal_cnt_ratio,
		nvl(sd_kpi.income_1w_below_cust_cnt,0) as income_1w_below_cust_cnt,
		nvl(sd_kpi.income_1w_2w_cust_cnt,0) as income_1w_2w_cust_cnt,
		nvl(sd_kpi.income_2w_3w_cust_cnt,0) as income_2w_3w_cust_cnt,
		nvl(sd_kpi.income_3w_above_cust_cnt,0) as income_3w_above_cust_cnt,
	   	nvl(case when suit.sd_level = 'S' then suit.string_a_suit_cnt else 0 end,0) as s_a_suit_cnt_name ,
	   	nvl(case when suit.sd_level = 'S' then suit.a_suit_cnt else 0 end,0) as s_a_suit_cnt ,			   				   
	   	nvl(case when suit.sd_level = 'S' then suit.a_suit_cnt_money else 0 end,0) as s_a_suit_money ,
	   	nvl(case when suit.sd_level = 'S' then suit.string_b_suit_cnt else 0 end,0) as s_b_suit_cnt_name ,
	   	nvl(case when suit.sd_level = 'S' then suit.b_suit_cnt else 0 end,0) as s_b_suit_cnt ,			   				   
	   	nvl(case when suit.sd_level = 'S' then suit.b_suit_cnt_money else 0 end,0) as s_b_suit_money ,
	   	nvl(case when suit.sd_level = 'S' then suit.string_c_suit_cnt else 0 end,0) as s_c_suit_cnt_name ,
	   	nvl(case when suit.sd_level = 'S' then suit.c_suit_cnt else 0 end,0) as s_c_suit_cnt ,			   				   
	   	nvl(case when suit.sd_level = 'S' then suit.c_suit_cnt_money else 0 end,0) as s_c_suit_money ,	

		nvl(case when prod.sd_level = 'S' then prod.online_contract_cnt else 0 end,0) - nvl(case when suit.sd_level = 'S' then suit.a_suit_cnt else 0 end,0) - nvl(case when suit.sd_level = 'S' then suit.b_suit_cnt else 0 end,0)-nvl(case when suit.sd_level = 'S' then suit.c_suit_cnt else 0 end,0) - nvl(case when prod.sd_level = 'S' then prod.ad_item_cnt else 0 end,0) as S_other_cnt,
	   	nvl(case when prod.sd_level = 'S' then  prod.online_contract_money else 0 end,0) - nvl(case when suit.sd_level = 'S' then suit.a_suit_money else 0 end,0) - nvl(case when suit.sd_level = 'S' then suit.b_suit_money else 0 end,0)-nvl(case when suit.sd_level = 'S' then suit.c_suit_money else 0 end,0) - nvl(case when prod.sd_level = 'S' then prod.ad_item_money else 0 end,0) as s_other_money,
	   	nvl(case when prod.sd_level = 'S' then prod.ad_item_cnt else 0 end,0) as s_ad_item_cnt,				   	
	   	nvl(case when prod.sd_level = 'S' then prod.ad_item_money else 0 end,0) as s_ad_item_money ,

	    nvl(sd_kpi.income_3w_below_cust_cnt,0) as income_3w_below_cust_cnt,
	    nvl(sd_kpi.income_3w_5w_cust_cnt,0) as income_3w_5w_cust_cnt,
	    nvl(sd_kpi.income_5w_above_cust_cnt,0) as income_5w_above_cust_cnt,
	   	nvl(case when suit.sd_level = 'SS' then suit.string_a_suit_cnt else 0 end,0) as ss_a_suit_cnt_name ,
	   	nvl(case when suit.sd_level = 'SS' then suit.a_suit_cnt else 0 end,0) as ss_a_suit_cnt ,			   				   
	   	nvl(case when suit.sd_level = 'SS' then suit.a_suit_cnt_money else 0 end,0) as ss_a_suit_money ,
	   	nvl(case when suit.sd_level = 'SS' then suit.string_b_suit_cnt else 0 end,0) as ss_b_suit_cnt_name ,
	   	nvl(case when suit.sd_level = 'SS' then suit.b_suit_cnt else 0 end,0) as ss_b_suit_cnt ,			   				   
	   	nvl(case when suit.sd_level = 'SS' then suit.b_suit_cnt_money else 0 end,0) as ss_b_suit_money ,
	   	nvl(case when suit.sd_level = 'SS' then suit.string_c_suit_cnt else 0 end,0) as ss_c_suit_cnt_name ,
	   	nvl(case when suit.sd_level = 'SS' then suit.c_suit_cnt else 0 end,0) as ss_c_suit_cnt ,			   				   
	   	nvl(case when suit.sd_level = 'SS' then suit.c_suit_cnt_money else 0 end,0) as ss_c_suit_money ,	
   	   	nvl(case when prod.sd_level = 'SS' then prod.online_contract_cnt else 0 end,0) - nvl(case when suit.sd_level = 'SS' then suit.a_suit_cnt else 0 end,0) - nvl(case when suit.sd_level = 'SS' then suit.b_suit_cnt else 0 end,0) - nvl(case when suit.sd_level = 'SS' then suit.c_suit_cnt else 0 end,0) - nvl(case when prod.sd_level = 'SS' then prod.ad_item_cnt else 0 end,0)  as ss_other_cnt,
	   	nvl(case when prod.sd_level = 'SS' then prod.online_contract_money else 0 end,0) - nvl(case when suit.sd_level = 'SS' then suit.a_suit_money else 0 end,0) - nvl(case when suit.sd_level = 'SS' then suit.b_suit_money else 0 end,0)-nvl(case when suit.sd_level = 'SS' then suit.c_suit_money else 0 end,0) - nvl(case when prod.sd_level = 'SS' then prod.ad_item_money else 0 end,0) as ss_other_money,
	   	nvl(case when prod.sd_level = 'SS' then prod.ad_item_cnt else 0 end,0) as ss_ad_item_cnt,				   	
	   	nvl(case when prod.sd_level = 'SS' then prod.ad_item_money else 0 end,0) as ss_ad_item_money ,
		nvl(sd_kpi.none_kpi,0) as none_kpi,
		nvl(sd_kpi.low_kpi,0) as low_kpi,
		nvl(sd_kpi.mid_kpi,0) as mid_kpi,
		nvl(sd_kpi.high_kpi,0) as high_kpi,
		nvl(sd_kpi.avg_call_rec_cnt,0) as avg_call_rec_cnt,				
		nvl(sd_kpi.avg_call_time_long,0) as avg_call_time_long,
		nvl(sd_kpi.avg_input_cert_cust_cnt,0) as avg_input_cert_cust_cnt,
		nvl(sd_kpi.income_2w_above_sales_cnt,0)   as income_2w_above_sales_cnt,
		nvl(sd_kpi.avg_visit_cust_cnt,0) as avg_visit_cust_cnt,
		nvl(sd_kpi.income_5w_above_sales_cnt,0)   as income_5w_above_sales_cnt
from (
	select 			
		coalesce(base.sr_sd_name,base.sd_name) as sd_name,
		base.sd_level,
		count(case when is_sd = 0 and status in (0,1) then base.id else null end) as sales_cnt,
		sum(income.month_income_money) as month_income_money,
		sum(income.year_income_money) as year_income_money,
		sum(income.month_income_money) / count(case when is_sd = 0 and status in (0,1) then base.id else null end)  as month_person_income,
		sum(cust.cust_cnt) as cust_cnt,
		sum(cover.cover_cust_cnt) as cover_cust_cnt,
		sum(cover.cover_cust_cnt) / sum(cust.cust_cnt) as cust_cover_ratio,
		sum(income.month_income_cust_cnt) as month_income_cust_cnt,
		case when base.sd_level = 'S' then sum(case when base.lp_age < 6 then cover.cover_cust_cnt else 0 end) else 0 end  / case when base.sd_level = 'S' then sum(case when base.lp_age < 6 then income.month_income_cust_cnt else 0 end) else 0 end as low6_new_contract_trans_ratio,
		case when base.sd_level = 'S' then sum(case when base.lp_age < 12 and base.lp_age >=6 then cover.cover_cust_cnt else 0 end) else 0 end / case when base.sd_level = 'S' then sum(case when base.lp_age < 12 and base.lp_age >=6 then income.month_income_cust_cnt else 0 end) else 0 end as low12_new_contract_trans_ratio,
		case when base.sd_level = 'S' then sum(case when base.lp_age >= 12 then cover.cover_cust_cnt else 0 end) else 0 end / case when base.sd_level = 'S' then sum(case when base.lp_age >= 12 then income.month_income_cust_cnt else 0 end) else 0 end as big12_new_contract_trans_ratio,
		sum(new_month_income_money) as new_month_income_money,
		sum(new_month_income_contract_cnt) as new_month_income_contract_cnt,
		sum(renew_month_income_money) as renew_month_income_money,
		sum(renew_month_income_contract_cnt) as renew_month_income_contract_cnt,
		sum(expire_no_renewal_cust_cnt) as expire_no_renewal_cust_cnt,
		sum(expire_no_renewal_cust_money) as expire_no_renewal_cust_money,
		sum(renewal_money_ratio_dm) / sum(renewal_money_ratio_nm) as renewal_money_ratio,
		sum(renewal_cnt_ratio_dm) / sum(renewal_cnt_ratio_nm) as renewal_cnt_ratio,
		case when base.sd_level = 'S' then sum(income_1w_below_cust_cnt ) else 0 end as income_1w_below_cust_cnt,
		case when base.sd_level = 'S' then sum(income_1w_2w_cust_cnt ) else 0 end as income_1w_2w_cust_cnt,
		case when base.sd_level = 'S' then sum(income_2w_3w_cust_cnt ) else 0 end as income_2w_3w_cust_cnt,
		case when base.sd_level = 'S' then sum(income_3w_above_cust_cnt ) else 0 end as income_3w_above_cust_cnt,
		case when base.sd_level = 'SS' then sum(income_3w_below_cust_cnt ) else 0 end as income_3w_below_cust_cnt,
		case when base.sd_level = 'SS' then sum(income_3w_5w_cust_cnt ) else 0 end as income_3w_5w_cust_cnt,
		case when base.sd_level = 'SS' then sum(income_5w_above_cust_cnt ) else 0 end as income_5w_above_cust_cnt,
		count(distinct case when nvl(income.month_income_money,0) = 0 and base.is_sd = 0 and status in (0,1) 
				and base.position_level not in ('B0002149','B0002153','B0002141') then base.id else null end) as none_kpi,
		count(distinct case when base.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
						and tst.position_level is not null and base.is_sd = 0 and status in (0,1) 
						and nvl(income.month_income_money,0) > 0
						and nvl(income.month_income_money,0) < tst.first_value then base.id
				when base.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
						and tst.position_level is not null and base.is_sd = 0 and status in (0,1) 
						and nvl(income.month_income_money,0) > 0
						and nvl(income.month_income_money,0) < tst.second_value then base.id
			    else null end) as low_kpi,
		count(distinct case when base.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
						and tst.position_level is not null and base.is_sd = 0 and status in (0,1) 
						and nvl(income.month_income_money,0) >= tst.first_value 
						and nvl(income.month_income_money,0) < tst.l_first_value  then base.id
				when base.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
						and tst.position_level is not null and base.is_sd = 0 and status in (0,1) 
						and nvl(income.month_income_money,0) >= tst.second_value 
						and nvl(income.month_income_money,0) < tst.l_second_value  then base.id
			    else null end) as mid_kpi,	
		count(distinct case when base.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
						and tst.position_level is not null and base.is_sd = 0 and status in (0,1) 
						and nvl(income.month_income_money,0) > tst.l_first_value  then base.id
				when base.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
						and tst.position_level is not null and base.is_sd = 0 and status in (0,1) 
						and nvl(income.month_income_money,0) > tst.l_second_value  then base.id
			    else null end) as high_kpi,
		sum(call_rec_cnt) / count(case when is_sd = 0 and status in (0,1) then base.id else null end) as avg_call_rec_cnt,
		sum(call_time_long) / count(case when is_sd = 0 and status in (0,1) then base.id else null end) as avg_call_time_long,
		sum(input_cert_cust_cnt) / count(case when is_sd = 0 and status in (0,1) then base.id else null end) as avg_input_cert_cust_cnt,
		sum(is_income_2w_above) / count(case when is_sd = 0 and status in (0,1) then base.id else null end) as income_2w_above_sales_cnt,
		sum(case when base.lp_age > 6 then visit_cust_cnt else 0 end) / count(case when is_sd = 0 and status in (0,1) and lp_age > 6 then base.id else null end) as avg_visit_cust_cnt,
		sum(is_income_5w_above) / count(case when is_sd = 0 and status in (0,1) then base.id else null end) as income_5w_above_sales_cnt
		from
		(select id,
				is_sd,status,lp_age,
				sd_id,sr_sd_id,sr_sd_name,sd_name,branch_name,
				position_level,
				case when instr(org_name,'SS') > 0 then 'SS'
					 when instr(org_name,'S') > 0 then 'S'
					 when instr(org_name,'KA') > 0 then 'KA'
				else '其他' end as sd_level
		  from dw_erp_d_salesuser_to_sd
		  where p_date = '20170430'
		   and (instr(org_name,'S') > 0 or instr(org_name,'KA') > 0)
		) base
	left join 
	(
	  select income1.sales_id,
		    sum(month_income_money) as month_income_money,
			sum(quarter_income_money) as quarter_income_money,
			sum(year_income_money) as year_income_money,
			sum(is_new_cust*month_income_money) as new_month_income_money,
			sum(is_new_cust*contract_cnt) as new_month_income_contract_cnt,
			sum(month_income_money) - sum(is_new_cust*month_income_money) as renew_month_income_money,
			sum(contract_cnt) - sum(is_new_cust*contract_cnt) as renew_month_income_contract_cnt,
			count(case when month_income_money > 0 then customer_id else null end) as month_income_cust_cnt,
			count(case when quarter_income_money > 0 then customer_id else null end) as quarter_income_cust_cnt,
			count(case when month_income_money < 10000 and month_income_money > 0 then customer_id else null end) as income_1w_below_cust_cnt ,
			count(case when month_income_money < 20000 and month_income_money >= 10000 then customer_id else null end) as income_1w_2w_cust_cnt ,
			count(case when month_income_money < 30000 and month_income_money >= 20000 then customer_id else null end) as income_2w_3w_cust_cnt ,
			count(case when month_income_money >= 30000 then customer_id else null end) as income_3w_above_cust_cnt ,
			count(case when month_income_money < 30000 and month_income_money > 0 then customer_id else null end) as income_3w_below_cust_cnt ,
			count(case when month_income_money < 50000 and month_income_money >= 30000 then customer_id else null end) as income_3w_5w_cust_cnt ,
			count(case when month_income_money >= 50000 then customer_id else null end) as income_5w_above_cust_cnt ,
			count(case when month_income_money < 50000 and  month_income_money > 0 then customer_id else null end) as income_5w_below_cust_cnt ,
			count(case when month_income_money < 100000 and month_income_money >= 50000 then customer_id else null end) as income_5w_10w_cust_cnt ,
			count(case when month_income_money < 500000 and month_income_money >= 100000 then customer_id else null end) as income_10w_50w_cust_cnt ,
			count(case when month_income_money >= 500000 then customer_id else null end) as income_50w_above_cust_cnt,
			count(case when month_income_money >= 100000 then customer_id else null end) as income_10w_above_cust_cnt,
			count(case when month_income_money >= 1000000 then customer_id else null end) as income_100w_above_cust_cnt,
			sum(case when month_income_money >= 500000 then month_income_money else 0 end) as income_50w_above_money,
			sum(case when month_income_money >= 100000 then month_income_money else 0 end) as income_10w_above_money,
			sum(case when month_income_money >= 1000000 then month_income_money else 0 end) as income_100w_above_money,
			sum(case when month_income_money >= 50000 then month_income_money else 0 end) as income_5w_above_money
	  from (
			  select income.sales_id,income.customer_id,
				   sum(case when income.d_date between concat(substr('20170430',1,6),'01') and '20170430' then money else 0 end) as month_income_money,
				   0 as quarter_income_money,
				   sum(case when income.d_date between concat(substr('20170430',1,4),'0101') and '20170430' then money else 0 end) as year_income_money,
				   case when min(substr(income.d_date,1,6)) = substr('20170430',1,6) then 1 else 0 end as is_new_cust,
				   count(distinct case when income.d_date between concat(substr('20170430',1,6),'01') and '20170430' then contract_id else null end) as contract_cnt 
			  from dw_erp_d_crmfinance_income income 
			  where p_date = 20170430
			  group by income.sales_id,income.customer_id
		  ) income1  
	  group by income1.sales_id
	 ) income 
	 on base.id = income.sales_id
	 left join 
		(select sales_user_id,count(id) as cust_cnt
		from dw_erp_d_customer_base new
		where new.company_certificate not in ('','-1')
		and new.p_date = '20170430'
		group by new.sales_user_id
		) cust
	 on base.id = cust.sales_user_id			
	left join 
	(
		select  sales_id,
				sum(is_expire_no_renewal) as expire_no_renewal_cust_cnt,
				sum(is_expire_no_renewal*contract_money) as expire_no_renewal_cust_money,
				(sum(is_expire_renewal) + sum(is_pre_expire_renewal) + sum(is_90day_on_expire_renewal))  as renewal_cnt_ratio_dm,
				(sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)+ sum(is_90day_on_expire_renewal))  as renewal_cnt_ratio_nm,
				(sum(is_expire_renewal*next_income_money) + sum(is_pre_expire_renewal*next_income_money)+ sum(is_90day_on_expire_renewal*next_income_money) ) as renewal_money_ratio_dm,
				(sum(is_expire*income_money) + sum(is_pre_expire_renewal*income_money) - sum(is_expire_pre_renewal*income_money)+ sum(is_90day_on_expire_renewal*income_money) ) as renewal_money_ratio_nm
		from dw_erp_d_sales_renewal_flag
		where p_date = '20170430'
		and d_date = '20170430'
		group by sales_id
	) renewal 
	on base.id = renewal.sales_id
	left join 
	(
		select sales_id,
				sum(call_rec_cnt) as call_rec_cnt,
				sum(call_time_long) as call_time_long, 
				max(visit_cus_cnt_m) as visit_cust_cnt
		 from dw_erp_d_salesuser_act 
		 where p_date between concat(substr('20170430',1,6),'01') and '20170430'
		 group by sales_id
	) act  
	on  base.id = act.sales_id
	left join 
	(
		select sales_id, input_cert_cus_cnt_m as input_cert_cust_cnt,
				case when all_income_m > 20000 then 1 else 0 end as is_income_2w_above,
				case when all_income_m > 50000 then 1 else 0 end as is_income_5w_above
		  from fact_h_erp_a_salesuser_real
		   where d_date = '20170430'
	) fr 
	on base.id = fr.sales_id
	left join 
	(
		select sales_id, mtd_cover_cus_cnt as cover_cust_cnt
		  from fact_h_erp_d_customer_cover
		   where d_date = '20170430'
	) cover 
	on base.id = cover.sales_id
	left join temp_sales_task tst 
	on base.position_level = tst.position_level
	group by base.sr_sd_name,base.sd_name,base.sd_level
	grouping sets((base.sr_sd_name,base.sd_level),(base.sd_name,base.sd_level))
) sd_kpi 
full join  
(  
	select 
		coalesce(base.sr_sd_name,base.sd_name) as sd_name,
		base.sd_level,
		sum(is_have_lpt_suit*suit_money) as lpt_suit_money,
		sum(is_have_lpt_suit) as lpt_suit_cnt,
		sum(lpt_item_money) as lpt_item_money,
		count(case when ad_item_money > 0 then contract_id else null end) as ad_item_cnt,
		sum(ad_item_money) as ad_item_money,
		sum(rpo_item_money) as rpo_item_money,
		sum(xy_item_money) as xy_item_money,
		sum(bc_item_money) as bc_item_money,
		sum(srp_item_money) as srp_item_money,
		count(case when is_have_lpt_suit*suit_money+ lpt_item_money+ ad_item_money> 0 then contract_id else null end) as online_contract_cnt,
		sum(case when is_have_lpt_suit*suit_money+ lpt_item_money+ ad_item_money> 0 then contract_money else null end) as online_contract_money	
	from (select id,
			is_sd,status,
			sd_id,sr_sd_id,sr_sd_name,sd_name,branch_name,
			position_level,
			case when instr(org_name,'SS') > 0 then 'SS'
				 when instr(org_name,'S') > 0 then 'S'
				 when instr(org_name,'KA') > 0 then 'KA'
			else '其他' end as sd_level
	  from dw_erp_d_salesuser_to_sd
	  where p_date = '20170430'
	  and (instr(org_name,'S') > 0 or instr(org_name,'KA') > 0)
	) base
	join dw_erp_a_contract_product prod 
	on base.id = prod.sales_id
	and regexp_replace(prod.income_date,'-','') between concat(substr('20170430',1,6),'01') and '20170430'
	group by base.sr_sd_name,base.sd_name,base.sd_level
	grouping sets((base.sr_sd_name,base.sd_level),(base.sd_name,base.sd_level))
) prod 
on sd_kpi.sd_name = prod.sd_name
and sd_kpi.sd_level = prod.sd_level
full join 
(
	select sd_name,
		   sd_level,
		   max(case when income_rn = 1 then concat(suit_name,':',online_income_money) else null end) as string_a_suit_money,
		   max(case when income_rn = 2 then concat(suit_name,':',online_income_money) else null end) as string_b_suit_money,
		   max(case when income_rn = 3 then concat(suit_name,':',online_income_money) else null end) as string_c_suit_money,				   
		   max(case when income_rn = 1 then online_income_money else null end) as a_suit_money,
		   max(case when income_rn = 2 then online_income_money else null end) as b_suit_money,
		   max(case when income_rn = 3 then online_income_money else null end) as c_suit_money,
		   max(case when cnt_rn = 1 then suit_name else null end) as string_a_suit_cnt,
		   max(case when cnt_rn = 2 then suit_name else null end) as string_b_suit_cnt,
		   max(case when cnt_rn = 3 then suit_name else null end) as string_c_suit_cnt,
		   max(case when cnt_rn = 1 then online_contract_cnt else null end) as a_suit_cnt,
		   max(case when cnt_rn = 2 then online_contract_cnt else null end) as b_suit_cnt,
		   max(case when cnt_rn = 3 then online_contract_cnt else null end) as c_suit_cnt,
		   max(case when cnt_rn = 1 then online_income_money else null end) as a_suit_cnt_money,
		   max(case when cnt_rn = 2 then online_income_money else null end) as b_suit_cnt_money,
		   max(case when cnt_rn = 3 then online_income_money else null end) as c_suit_cnt_money				   				   			   
	from (
		select  suit0.sd_name,
				suit0.suit_name,
				suit0.online_income_money,
				suit0.sd_level,
				suit0.online_contract_cnt,
				row_number()over(distribute by suit0.sd_name,suit0.sd_level sort by suit0.online_income_money desc) as income_rn,
				row_number()over(distribute by suit0.sd_name,suit0.sd_level sort by suit0.online_contract_cnt desc) as cnt_rn
		from (
		select 
			coalesce(base.sd_name,base.sr_sd_name) as sd_name,
			prod.suit_name,
			base.sd_level,
			sum(is_have_lpt_suit*contract_money) as online_income_money,
			count(is_have_lpt_suit) as online_contract_cnt
		from (select id,
					is_sd,status,
					sd_id,sr_sd_id,sr_sd_name,sd_name,branch_name,
					position_level,
					case when instr(org_name,'SS') > 0 then 'SS'
						 when instr(org_name,'S') > 0 then 'S'
						 when instr(org_name,'KA') > 0 then 'KA'
					else '其他' end as sd_level
			  from dw_erp_d_salesuser_to_sd
			  where p_date = '20170430'
			  and (instr(org_name,'S') > 0 or instr(org_name,'KA') > 0)
	    	) base
		join dw_erp_a_contract_product prod 
		on base.id = prod.sales_id
		and prod.is_have_lpt_suit = 1
		and regexp_replace(prod.income_date,'-','') between concat(substr('20170430',1,6),'01') and '20170430'
		group by base.sd_name,base.sr_sd_name,prod.suit_name,base.sd_level
		grouping sets((base.sd_name,base.sd_level,prod.suit_name),(base.sr_sd_name,base.sd_level,prod.suit_name))
		) suit0
	) suit1
	group by sd_name,sd_level
) suit 
on sd_kpi.sd_name = suit.sd_name 
and sd_kpi.sd_level = suit.sd_level
 full join 
 ( select sales_id,sales_name,
  		 case substr('20170430',5,2) 
  		 	  when '01' then jan_amount
  		 	  when '02' then feb_amount
			  when '03' then mar_amount
			  when '04' then apr_amount
			  when '05' then may_amount
			  when '06' then jun_amount
			  when '07' then jul_amount
			  when '08' then aug_amount
			  when '09' then sep_amount
			  when '10' then oct_amount
			  when '11' then nov_amount
			  when '12' then dec_amount
	    end as month_target,
	    case substr('20170430',5,2) 
  		 	  when '01' then first_quarter_amount
  		 	  when '02' then first_quarter_amount
			  when '03' then first_quarter_amount
			  when '04' then second_quarter_amount
			  when '05' then second_quarter_amount
			  when '06' then second_quarter_amount
			  when '07' then third_quarter_amount
			  when '08' then third_quarter_amount
			  when '09' then third_quarter_amount
			  when '10' then fourth_quarter_amount
			  when '11' then fourth_quarter_amount
			  when '12' then fourth_quarter_amount
	    end as quarter_target,
	    year_amount as year_target
  from dw_erp_d_sales_target
  where p_date = '20170430'
  and target_year = substr('20170430',1,4)
  ) target
 on sd_kpi.sd_name = target.sales_name
left join dw_erp_d_salesuser_to_sd suser 
on sd_kpi.sd_name = suser.name 
and suser.p_date = '20170430'
and suser.is_sd = 1
where coalesce(sd_kpi.sd_name,prod.sd_name,suit.sd_name) not in ('-1','未知')
and nvl(sd_kpi.month_income_money,0) > 0














--城市显示数据
select 
  branch_name
, hlw_income_cust_cnt
, hlw_income_money
, hlw_service_cust_cnt
, hlw_cust_cnt
, hlw_last_year_income_money
, hlw_last_income_cust_cnt
, hlw_last_income_money
, fdc_income_cust_cnt
, fdc_income_money
, fdc_service_cust_cnt
, fdc_cust_cnt
, fdc_last_year_income_money
, fdc_last_income_cust_cnt
, fdc_last_income_money
, jr_income_cust_cnt
, jr_income_money
, jr_service_cust_cnt
, jr_cust_cnt
, jr_last_year_income_money
, jr_last_income_cust_cnt
, jr_last_income_money
, xfp_income_cust_cnt
, xfp_income_money
, xfp_service_cust_cnt
, xfp_cust_cnt
, xfp_last_year_income_money
, xfp_last_income_cust_cnt
, xfp_last_income_money
, qc_income_cust_cnt
, qc_income_money
, qc_service_cust_cnt
, qc_cust_cnt
, qc_last_year_income_money
, qc_last_income_cust_cnt
, qc_last_income_money
, zy_income_cust_cnt
, zy_income_money
, zy_service_cust_cnt
, zy_cust_cnt
, zy_last_year_income_money
, zy_last_income_cust_cnt
, zy_last_income_money
, qt_income_cust_cnt
, qt_income_money
, qt_service_cust_cnt
, qt_cust_cnt
, qt_last_year_income_money
, qt_last_income_cust_cnt
, qt_last_income_money
, cust_cnt
, cust_cover_ratio
, low6_new_contract_trans_ratio
, low12_new_contract_trans_ratio
, big12_new_contract_trans_ratio
, new_month_income_money
, new_month_income_contract_cnt
, renew_month_income_money
, renew_month_income_contract_cnt
, expire_no_renewal_cust_cnt
, expire_no_renewal_cust_money
, renewal_money_ratio
, renewal_cnt_ratio
, online_contract_cnt
, online_contract_money
, xy_item_cnt
, xy_item_money
, rpo_item_cnt
, rpo_item_money
, test_item_cnt
, test_item_money
, srp_item_cnt
, srp_item_money
, a_suit_cnt
, a_suit_money
, b_suit_cnt
, b_suit_money
, c_suit_cnt
, c_suit_money
, string_c_suit_cnt
, string_b_suit_cnt
, string_a_suit_cnt
, ad_item_cnt
, ad_item_money
, other_online_cnt
, other_online_money
, none_kpi
, low_kpi
, mid_kpi
, high_kpi
, ka_hlw_income_cust_cnt
, ka_hlw_income_money
, ka_hlw_service_cust_cnt
, ka_hlw_cust_cnt
, ka_hlw_last_year_income_money
, ka_hlw_last_income_cust_cnt
, ka_hlw_last_income_money
, ka_fdc_income_cust_cnt
, ka_fdc_income_money
, ka_fdc_service_cust_cnt
, ka_fdc_cust_cnt
, ka_fdc_last_year_income_money
, ka_fdc_last_income_cust_cnt
, ka_fdc_last_income_money
, ka_jr_income_cust_cnt
, ka_jr_income_money
, ka_jr_service_cust_cnt
, ka_jr_cust_cnt
, ka_jr_last_year_income_money
, ka_jr_last_income_cust_cnt
, ka_jr_last_income_money
, ka_xfp_income_cust_cnt
, ka_xfp_income_money
, ka_xfp_service_cust_cnt
, ka_xfp_cust_cnt
, ka_xfp_last_year_income_money
, ka_xfp_last_income_cust_cnt
, ka_xfp_last_income_money
, ka_qc_income_cust_cnt
, ka_qc_income_money
, ka_qc_service_cust_cnt
, ka_qc_cust_cnt
, ka_qc_last_year_income_money
, ka_qc_last_income_cust_cnt
, ka_qc_last_income_money
, ka_zy_income_cust_cnt
, ka_zy_income_money
, ka_zy_service_cust_cnt
, ka_zy_cust_cnt
, ka_zy_last_year_income_money
, ka_zy_last_income_cust_cnt
, ka_zy_last_income_money
, ka_qt_income_cust_cnt
, ka_qt_income_money
, ka_qt_service_cust_cnt
, ka_qt_cust_cnt
, ka_qt_last_year_income_money
, ka_qt_last_income_cust_cnt
, ka_qt_last_income_money
from temp_mancj_20170505222450 


--月度城市总review基础指标  temp_mancj_20170505222450
		
select 
	branch_kpi.branch_name,
	nvl(branch_kpi.hlw_income_cust_cnt,0) as hlw_income_cust_cnt,
	nvl(branch_kpi.hlw_income_money,0) as hlw_income_money,
	nvl(branch_kpi.hlw_service_cust_cnt,0) as hlw_service_cust_cnt,
	nvl(branch_kpi.hlw_service_cust_income,0) as hlw_service_cust_income,
	nvl(branch_kpi.hlw_cust_cnt,0) as hlw_cust_cnt,
	nvl(branch_kpi.hlw_last_year_income_money,0) as hlw_last_year_income_money,
	nvl(branch_kpi.hlw_last_income_cust_cnt,0) as hlw_last_income_cust_cnt,
	nvl(branch_kpi.hlw_last_income_money,0) as hlw_last_income_money,
	nvl(branch_kpi.fdc_income_cust_cnt,0) as fdc_income_cust_cnt,
	nvl(branch_kpi.fdc_income_money,0) as fdc_income_money,
	nvl(branch_kpi.fdc_service_cust_cnt,0) as fdc_service_cust_cnt,
	nvl(branch_kpi.fdc_service_cust_income,0) as fdc_service_cust_income,
	nvl(branch_kpi.fdc_cust_cnt,0) as fdc_cust_cnt,
	nvl(branch_kpi.fdc_last_year_income_money,0) as fdc_last_year_income_money,
	nvl(branch_kpi.fdc_last_income_cust_cnt,0) as fdc_last_income_cust_cnt,
	nvl(branch_kpi.fdc_last_income_money,0) as fdc_last_income_money,
	nvl(branch_kpi.jr_income_cust_cnt,0) as jr_income_cust_cnt,
	nvl(branch_kpi.jr_income_money,0) as jr_income_money,
	nvl(branch_kpi.jr_service_cust_cnt,0) as jr_service_cust_cnt,
	nvl(branch_kpi.jr_service_cust_income,0) as jr_service_cust_income,
	nvl(branch_kpi.jr_cust_cnt,0) as jr_cust_cnt,
	nvl(branch_kpi.jr_last_year_income_money,0) as jr_last_year_income_money,
	nvl(branch_kpi.jr_last_income_cust_cnt,0) as jr_last_income_cust_cnt,
	nvl(branch_kpi.jr_last_income_money,0) as jr_last_income_money,
	nvl(branch_kpi.xfp_income_cust_cnt,0) as xfp_income_cust_cnt,
	nvl(branch_kpi.xfp_income_money,0) as xfp_income_money,
	nvl(branch_kpi.xfp_service_cust_cnt,0) as xfp_service_cust_cnt,
	nvl(branch_kpi.xfp_service_cust_income,0) as xfp_service_cust_income,
	nvl(branch_kpi.xfp_cust_cnt,0) as xfp_cust_cnt,
	nvl(branch_kpi.xfp_last_year_income_money,0) as xfp_last_year_income_money,
	nvl(branch_kpi.xfp_last_income_cust_cnt,0) as xfp_last_income_cust_cnt,
	nvl(branch_kpi.xfp_last_income_money,0) as xfp_last_income_money,
	nvl(branch_kpi.qc_income_cust_cnt,0) as qc_income_cust_cnt,
	nvl(branch_kpi.qc_income_money,0) as qc_income_money,
	nvl(branch_kpi.qc_service_cust_cnt,0) as qc_service_cust_cnt,
	nvl(branch_kpi.qc_service_cust_income,0) as qc_service_cust_income,
	nvl(branch_kpi.qc_cust_cnt,0) as qc_cust_cnt,
	nvl(branch_kpi.qc_last_year_income_money,0) as qc_last_year_income_money,
	nvl(branch_kpi.qc_last_income_cust_cnt,0) as qc_last_income_cust_cnt,
	nvl(branch_kpi.qc_last_income_money,0) as qc_last_income_money,

	nvl(branch_kpi.zy_income_cust_cnt,0) as zy_income_cust_cnt,
	nvl(branch_kpi.zy_income_money,0) as zy_income_money,
	nvl(branch_kpi.zy_service_cust_cnt,0) as zy_service_cust_cnt,
	nvl(branch_kpi.zy_service_cust_income,0) as zy_service_cust_income,
	nvl(branch_kpi.zy_cust_cnt,0) as zy_cust_cnt,
	nvl(branch_kpi.zy_last_year_income_money,0) as zy_last_year_income_money,
	nvl(branch_kpi.zy_last_income_cust_cnt,0) as zy_last_income_cust_cnt,
	nvl(branch_kpi.zy_last_income_money,0) as zy_last_income_money,

	nvl(branch_kpi.qt_income_cust_cnt,0) as qt_income_cust_cnt,
	nvl(branch_kpi.qt_income_money,0) as qt_income_money,
	nvl(branch_kpi.qt_service_cust_cnt,0) as qt_service_cust_cnt,
	nvl(branch_kpi.qt_service_cust_income,0) as qt_service_cust_income,
	nvl(branch_kpi.qt_cust_cnt,0) as qt_cust_cnt,
	nvl(branch_kpi.qt_last_year_income_money,0) as qt_last_year_income_money,
	nvl(branch_kpi.qt_last_income_cust_cnt,0) as qt_last_income_cust_cnt,
	nvl(branch_kpi.qt_last_income_money,0) as qt_last_income_money,

	nvl(branch_kpi.cust_cnt,0) as cust_cnt,
	nvl(branch_kpi.cust_cover_ratio,0) as cust_cover_ratio,
	nvl(branch_kpi.low6_new_contract_trans_ratio,0) as low6_new_contract_trans_ratio,
	nvl(branch_kpi.low12_new_contract_trans_ratio,0) as low12_new_contract_trans_ratio,
	nvl(branch_kpi.big12_new_contract_trans_ratio,0) as big12_new_contract_trans_ratio,					
	nvl(branch_kpi.new_month_income_money,0) as new_month_income_money,
	nvl(branch_kpi.new_month_income_contract_cnt,0) as new_month_income_contract_cnt,
	nvl(branch_kpi.renew_month_income_money,0) as renew_month_income_money,
	nvl(branch_kpi.renew_month_income_contract_cnt,0) as renew_month_income_contract_cnt,
	nvl(branch_kpi.expire_no_renewal_cust_cnt,0) as expire_no_renewal_cust_cnt,
	nvl(branch_kpi.expire_no_renewal_cust_money,0) as expire_no_renewal_cust_money,
	nvl(branch_kpi.renewal_money_ratio,0) as renewal_money_ratio,
	nvl(branch_kpi.renewal_cnt_ratio,0) as renewal_cnt_ratio,

	nvl(prod.online_contract_cnt,0) as online_contract_cnt,
	nvl(prod.lpt_suit_money +prod.lpt_item_money +prod.ad_item_money,0) as online_contract_money,
	nvl(prod.xy_item_cnt,0) as xy_item_cnt,
	nvl(prod.xy_item_money,0) as xy_item_money,
	nvl(prod.rpo_item_cnt,0) as rpo_item_cnt,
	nvl(prod.rpo_item_money,0) as rpo_item_money,
	nvl(prod.test_item_cnt,0) as test_item_cnt,
	nvl(prod.test_item_money,0) as test_item_money,
	nvl(prod.srp_item_cnt,0) as srp_item_cnt,
	nvl(prod.srp_item_money,0) as srp_item_money,
	nvl(suit.string_a_suit_cnt,0) as string_a_suit_cnt ,	
	nvl(suit.a_suit_cnt,0) as a_suit_cnt ,			   
	nvl(suit.a_suit_money,0) as a_suit_money ,
	nvl(suit.string_b_suit_cnt,0) as string_b_suit_cnt ,	
	nvl(suit.b_suit_cnt,0) as b_suit_cnt ,		
	nvl(suit.b_suit_money,0) as b_suit_money ,
	nvl(suit.string_c_suit_cnt,0) as string_c_suit_cnt ,	
	nvl(suit.c_suit_cnt,0) as c_suit_cnt ,		   
	nvl(suit.c_suit_money,0) as c_suit_money ,
	nvl(prod.ad_item_cnt,0) as ad_item_cnt,				   	
	nvl(prod.ad_item_money,0) as ad_item_money ,
	nvl(prod.online_contract_cnt,0) - nvl(suit.a_suit_cnt,0) - nvl(suit.b_suit_cnt,0)-nvl(suit.c_suit_cnt,0)- nvl(prod.ad_item_cnt,0) as other_online_cnt,
	nvl(prod.lpt_suit_money+prod.lpt_item_money+prod.ad_item_money,0) - nvl(suit.a_suit_money,0) - nvl(suit.b_suit_money,0)-nvl(suit.c_suit_money,0)-nvl(prod.ad_item_money,0) as other_online_money,

	nvl(branch_kpi.none_kpi,0) as none_kpi,
	nvl(branch_kpi.low_kpi,0) as low_kpi,
	nvl(branch_kpi.mid_kpi,0) as mid_kpi,
	nvl(branch_kpi.high_kpi,0) as high_kpi,


	nvl(branch_kpi.ka_hlw_income_cust_cnt,0) as ka_hlw_income_cust_cnt,
	nvl(branch_kpi.ka_hlw_income_money,0) as ka_hlw_income_money,
	nvl(branch_kpi.ka_hlw_service_cust_cnt,0) as ka_hlw_service_cust_cnt,
	nvl(branch_kpi.ka_hlw_service_cust_income,0) as ka_hlw_service_cust_income,
	nvl(branch_kpi.ka_hlw_cust_cnt,0) as ka_hlw_cust_cnt,
	nvl(branch_kpi.ka_hlw_last_year_income_money,0) as ka_hlw_last_year_income_money,
	nvl(branch_kpi.ka_hlw_last_income_cust_cnt,0) as ka_hlw_last_income_cust_cnt,
	nvl(branch_kpi.ka_hlw_last_income_money,0) as ka_hlw_last_income_money,
	nvl(branch_kpi.ka_fdc_income_cust_cnt,0) as ka_fdc_income_cust_cnt,
	nvl(branch_kpi.ka_fdc_income_money,0) as ka_fdc_income_money,
	nvl(branch_kpi.ka_fdc_service_cust_cnt,0) as ka_fdc_service_cust_cnt,
	nvl(branch_kpi.ka_fdc_service_cust_income,0) as ka_fdc_service_cust_income,
	nvl(branch_kpi.ka_fdc_cust_cnt,0) as ka_fdc_cust_cnt,
	nvl(branch_kpi.ka_fdc_last_year_income_money,0) as ka_fdc_last_year_income_money,
	nvl(branch_kpi.ka_fdc_last_income_cust_cnt,0) as ka_fdc_last_income_cust_cnt,
	nvl(branch_kpi.ka_fdc_last_income_money,0) as ka_fdc_last_income_money,
	nvl(branch_kpi.ka_jr_income_cust_cnt,0) as ka_jr_income_cust_cnt,
	nvl(branch_kpi.ka_jr_income_money,0) as ka_jr_income_money,
	nvl(branch_kpi.ka_jr_service_cust_cnt,0) as ka_jr_service_cust_cnt,
	nvl(branch_kpi.ka_jr_service_cust_income,0) as ka_jr_service_cust_income,
	nvl(branch_kpi.ka_jr_cust_cnt,0) as ka_jr_cust_cnt,
	nvl(branch_kpi.ka_jr_last_year_income_money,0) as ka_jr_last_year_income_money,
	nvl(branch_kpi.ka_jr_last_income_cust_cnt,0) as ka_jr_last_income_cust_cnt,
	nvl(branch_kpi.ka_jr_last_income_money,0) as ka_jr_last_income_money,
	nvl(branch_kpi.ka_xfp_income_cust_cnt,0) as ka_xfp_income_cust_cnt,
	nvl(branch_kpi.ka_xfp_income_money,0) as ka_xfp_income_money,
	nvl(branch_kpi.ka_xfp_service_cust_cnt,0) as ka_xfp_service_cust_cnt,
	nvl(branch_kpi.ka_xfp_service_cust_income,0) as ka_xfp_service_cust_income,
	nvl(branch_kpi.ka_xfp_cust_cnt,0) as ka_xfp_cust_cnt,
	nvl(branch_kpi.ka_xfp_last_year_income_money,0) as ka_xfp_last_year_income_money,
	nvl(branch_kpi.ka_xfp_last_income_cust_cnt,0) as ka_xfp_last_income_cust_cnt,
	nvl(branch_kpi.ka_xfp_last_income_money,0) as ka_xfp_last_income_money,
	nvl(branch_kpi.ka_qc_income_cust_cnt,0) as ka_qc_income_cust_cnt,
	nvl(branch_kpi.ka_qc_income_money,0) as ka_qc_income_money,
	nvl(branch_kpi.ka_qc_service_cust_cnt,0) as ka_qc_service_cust_cnt,
	nvl(branch_kpi.ka_qc_service_cust_income,0) as ka_qc_service_cust_income,
	nvl(branch_kpi.ka_qc_cust_cnt,0) as ka_qc_cust_cnt,
	nvl(branch_kpi.ka_qc_last_year_income_money,0) as ka_qc_last_year_income_money,
	nvl(branch_kpi.ka_qc_last_income_cust_cnt,0) as ka_qc_last_income_cust_cnt,
	nvl(branch_kpi.ka_qc_last_income_money,0) as ka_qc_last_income_money,

	nvl(branch_kpi.ka_zy_income_cust_cnt,0) as ka_zy_income_cust_cnt,
	nvl(branch_kpi.ka_zy_income_money,0) as ka_zy_income_money,
	nvl(branch_kpi.ka_zy_service_cust_cnt,0) as ka_zy_service_cust_cnt,
	nvl(branch_kpi.ka_zy_service_cust_income,0) as ka_zy_service_cust_income,
	nvl(branch_kpi.ka_zy_cust_cnt,0) as ka_zy_cust_cnt,
	nvl(branch_kpi.ka_zy_last_year_income_money,0) as ka_zy_last_year_income_money,
	nvl(branch_kpi.ka_zy_last_income_cust_cnt,0) as ka_zy_last_income_cust_cnt,
	nvl(branch_kpi.ka_zy_last_income_money,0) as ka_zy_last_income_money,

	nvl(branch_kpi.ka_qt_income_cust_cnt,0) as ka_qt_income_cust_cnt,
	nvl(branch_kpi.ka_qt_income_money,0) as ka_qt_income_money,
	nvl(branch_kpi.ka_qt_service_cust_cnt,0) as ka_qt_service_cust_cnt,
	nvl(branch_kpi.ka_qt_service_cust_income,0) as ka_qt_service_cust_income,
	nvl(branch_kpi.ka_qt_cust_cnt,0) as ka_qt_cust_cnt,
	nvl(branch_kpi.ka_qt_last_year_income_money,0) as ka_qt_last_year_income_money,
	nvl(branch_kpi.ka_qt_last_income_cust_cnt,0) as ka_qt_last_income_cust_cnt,
	nvl(branch_kpi.ka_qt_last_income_money,0) as ka_qt_last_income_money
from 
(
	 select
		base.branch_name,
		sum(cust.cust_cnt) as cust_cnt,
		sum(cover.cover_cust_cnt) / sum(cust.cust_cnt) as cust_cover_ratio,
		sum(case when base.sd_level = 'S' and base.lp_age < 6 then cover.cover_cust_cnt else 0 end) / sum(case when base.sd_level = 'S' and base.lp_age < 6 then income.month_income_cust_cnt else 0 end) as low6_new_contract_trans_ratio,
		sum(case when base.sd_level = 'S' and base.lp_age < 12 and base.lp_age >=6 then cover.cover_cust_cnt else 0 end) / sum(case when base.sd_level = 'S' and base.lp_age < 12 and base.lp_age >=6 then income.month_income_cust_cnt else 0 end)  as low12_new_contract_trans_ratio,
		sum(case when base.sd_level = 'S' and base.lp_age >= 12 then cover.cover_cust_cnt else 0 end) / sum(case when base.sd_level = 'S' and base.lp_age >= 12 then income.month_income_cust_cnt else 0 end) as big12_new_contract_trans_ratio,					
		sum(new_month_income_money) as new_month_income_money,
		sum(new_month_income_contract_cnt) as new_month_income_contract_cnt,
		sum(renew_month_income_money) as renew_month_income_money,
		sum(renew_month_income_contract_cnt) as renew_month_income_contract_cnt,
		sum(expire_no_renewal_cust_cnt) as expire_no_renewal_cust_cnt,
		sum(expire_no_renewal_cust_money) as expire_no_renewal_cust_money,
		sum(renewal_money_ratio_dm) / sum(renewal_money_ratio_nm) as renewal_money_ratio,
		sum(renewal_cnt_ratio_dm) / sum(renewal_cnt_ratio_nm) as renewal_cnt_ratio,
		sum(hlw_income_cust_cnt) as hlw_income_cust_cnt,
		sum(hlw_income_money) as hlw_income_money,
		sum(hlw_service_cust_cnt) as hlw_service_cust_cnt,
		sum(hlw_service_cust_income) as hlw_service_cust_income,
		sum(hlw_cust_cnt) as hlw_cust_cnt,
		sum(hlw_last_year_income_money) as hlw_last_year_income_money,
		sum(hlw_last_income_cust_cnt) as hlw_last_income_cust_cnt,
		sum(hlw_last_income_money) as hlw_last_income_money,
		sum(fdc_income_cust_cnt) as fdc_income_cust_cnt,
		sum(fdc_income_money) as fdc_income_money,
		sum(fdc_service_cust_cnt) as fdc_service_cust_cnt,
		sum(fdc_service_cust_income) as fdc_service_cust_income,
		sum(fdc_cust_cnt) as fdc_cust_cnt,
		sum(fdc_last_year_income_money) as fdc_last_year_income_money,
		sum(fdc_last_income_cust_cnt) as fdc_last_income_cust_cnt,
		sum(fdc_last_income_money) as fdc_last_income_money,
		sum(jr_income_cust_cnt) as jr_income_cust_cnt,
		sum(jr_income_money) as jr_income_money,
		sum(jr_service_cust_cnt) as jr_service_cust_cnt,
		sum(jr_service_cust_income) as jr_service_cust_income,
		sum(jr_cust_cnt) as jr_cust_cnt,
		sum(jr_last_year_income_money) as jr_last_year_income_money,
		sum(jr_last_income_cust_cnt) as jr_last_income_cust_cnt,
		sum(jr_last_income_money) as jr_last_income_money,
		sum(xfp_income_cust_cnt) as xfp_income_cust_cnt,
		sum(xfp_income_money) as xfp_income_money,
		sum(xfp_service_cust_cnt) as xfp_service_cust_cnt,
		sum(xfp_service_cust_income) as xfp_service_cust_income,
		sum(xfp_cust_cnt) as xfp_cust_cnt,
		sum(xfp_last_year_income_money) as xfp_last_year_income_money,
		sum(xfp_last_income_cust_cnt) as xfp_last_income_cust_cnt,
		sum(xfp_last_income_money) as xfp_last_income_money,
		sum(qc_income_cust_cnt) as qc_income_cust_cnt,
		sum(qc_income_money) as qc_income_money,
		sum(qc_service_cust_cnt) as qc_service_cust_cnt,
		sum(qc_service_cust_income) as qc_service_cust_income,
		sum(qc_cust_cnt) as qc_cust_cnt,
		sum(qc_last_year_income_money) as qc_last_year_income_money,
		sum(qc_last_income_cust_cnt) as qc_last_income_cust_cnt,
		sum(qc_last_income_money) as qc_last_income_money,
		sum(zy_income_cust_cnt) as zy_income_cust_cnt,
		sum(zy_income_money) as zy_income_money,
		sum(zy_service_cust_cnt) as zy_service_cust_cnt,
		sum(zy_service_cust_income) as zy_service_cust_income,
		sum(zy_cust_cnt) as zy_cust_cnt,
		sum(zy_last_year_income_money) as zy_last_year_income_money,
		sum(zy_last_income_cust_cnt) as zy_last_income_cust_cnt,
		sum(zy_last_income_money) as zy_last_income_money,		
		sum(qt_income_cust_cnt) as qt_income_cust_cnt,
		sum(qt_income_money) as qt_income_money,
		sum(qt_service_cust_cnt) as qt_service_cust_cnt,
		sum(qt_service_cust_income) as qt_service_cust_income,
		sum(qt_cust_cnt) as qt_cust_cnt,
		sum(qt_last_year_income_money) as qt_last_year_income_money,
		sum(qt_last_income_cust_cnt) as qt_last_income_cust_cnt,
		sum(qt_last_income_money) as qt_last_income_money,
		sum(ka_hlw_income_cust_cnt) as ka_hlw_income_cust_cnt,
		sum(ka_hlw_income_money) as ka_hlw_income_money,
		sum(ka_hlw_service_cust_cnt) as ka_hlw_service_cust_cnt,
		sum(ka_hlw_service_cust_income) as ka_hlw_service_cust_income,
		sum(ka_hlw_cust_cnt) as ka_hlw_cust_cnt,
		sum(ka_hlw_last_year_income_money) as ka_hlw_last_year_income_money,
		sum(ka_hlw_last_income_cust_cnt) as ka_hlw_last_income_cust_cnt,
		sum(ka_hlw_last_income_money) as ka_hlw_last_income_money,
		sum(ka_fdc_income_cust_cnt) as ka_fdc_income_cust_cnt,
		sum(ka_fdc_income_money) as ka_fdc_income_money,
		sum(ka_fdc_service_cust_cnt) as ka_fdc_service_cust_cnt,
		sum(ka_fdc_service_cust_income) as ka_fdc_service_cust_income,
		sum(ka_fdc_cust_cnt) as ka_fdc_cust_cnt,
		sum(ka_fdc_last_year_income_money) as ka_fdc_last_year_income_money,
		sum(ka_fdc_last_income_cust_cnt) as ka_fdc_last_income_cust_cnt,
		sum(ka_fdc_last_income_money) as ka_fdc_last_income_money,
		sum(ka_jr_income_cust_cnt) as ka_jr_income_cust_cnt,
		sum(ka_jr_income_money) as ka_jr_income_money,
		sum(ka_jr_service_cust_cnt) as ka_jr_service_cust_cnt,
		sum(ka_jr_service_cust_income) as ka_jr_service_cust_income,
		sum(ka_jr_cust_cnt) as ka_jr_cust_cnt,
		sum(ka_jr_last_year_income_money) as ka_jr_last_year_income_money,
		sum(ka_jr_last_income_cust_cnt) as ka_jr_last_income_cust_cnt,
		sum(ka_jr_last_income_money) as ka_jr_last_income_money,
		sum(ka_xfp_income_cust_cnt) as ka_xfp_income_cust_cnt,
		sum(ka_xfp_income_money) as ka_xfp_income_money,
		sum(ka_xfp_service_cust_cnt) as ka_xfp_service_cust_cnt,
		sum(ka_xfp_service_cust_income) as ka_xfp_service_cust_income,
		sum(ka_xfp_cust_cnt) as ka_xfp_cust_cnt,
		sum(ka_xfp_last_year_income_money) as ka_xfp_last_year_income_money,
		sum(ka_xfp_last_income_cust_cnt) as ka_xfp_last_income_cust_cnt,
		sum(ka_xfp_last_income_money) as ka_xfp_last_income_money,
		sum(ka_qc_income_cust_cnt) as ka_qc_income_cust_cnt,
		sum(ka_qc_income_money) as ka_qc_income_money,
		sum(ka_qc_service_cust_cnt) as ka_qc_service_cust_cnt,
		sum(ka_qc_service_cust_income) as ka_qc_service_cust_income,
		sum(ka_qc_cust_cnt) as ka_qc_cust_cnt,
		sum(ka_qc_last_year_income_money) as ka_qc_last_year_income_money,
		sum(ka_qc_last_income_cust_cnt) as ka_qc_last_income_cust_cnt,
		sum(ka_qc_last_income_money) as ka_qc_last_income_money,

		sum(ka_zy_income_cust_cnt) as ka_zy_income_cust_cnt,
		sum(ka_zy_income_money) as ka_zy_income_money,
		sum(ka_zy_service_cust_cnt) as ka_zy_service_cust_cnt,
		sum(ka_zy_service_cust_income) as ka_zy_service_cust_income,
		sum(ka_zy_cust_cnt) as ka_zy_cust_cnt,
		sum(ka_zy_last_year_income_money) as ka_zy_last_year_income_money,
		sum(ka_zy_last_income_cust_cnt) as ka_zy_last_income_cust_cnt,
		sum(ka_zy_last_income_money) as ka_zy_last_income_money,

		sum(ka_qt_income_cust_cnt) as ka_qt_income_cust_cnt,
		sum(ka_qt_income_money) as ka_qt_income_money,
		sum(ka_qt_service_cust_cnt) as ka_qt_service_cust_cnt,
		sum(ka_qt_service_cust_income) as ka_qt_service_cust_income,
		sum(ka_qt_cust_cnt) as ka_qt_cust_cnt,
		sum(ka_qt_last_year_income_money) as ka_qt_last_year_income_money,
		sum(ka_qt_last_income_cust_cnt) as ka_qt_last_income_cust_cnt,
		sum(ka_qt_last_income_money) as ka_qt_last_income_money,
		count(distinct case when nvl(income.month_income_money,0) = 0 and base.is_sd = 0 and status in (0,1) 
							and base.position_level not in ('B0002149','B0002153','B0002141') then base.id else null end) as none_kpi,
		count(distinct case when base.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
						and tst.position_level is not null and base.is_sd = 0 and status in (0,1) 
						and nvl(income.month_income_money,0) > 0
						and nvl(income.month_income_money,0) < tst.first_value then base.id
				when base.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
						and tst.position_level is not null and base.is_sd = 0 and status in (0,1) 
						and nvl(income.month_income_money,0) > 0
						and nvl(income.month_income_money,0) < tst.second_value then base.id
			    else null end) as low_kpi,
		count(distinct case when base.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
						and tst.position_level is not null and base.is_sd = 0 and status in (0,1) 
						and nvl(income.month_income_money,0) >= tst.first_value 
						and nvl(income.month_income_money,0) < tst.l_first_value  then base.id
				when base.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
						and tst.position_level is not null and base.is_sd = 0 and status in (0,1) 
						and nvl(income.month_income_money,0) >= tst.second_value 
						and nvl(income.month_income_money,0) < tst.l_second_value  then base.id
			    else null end) as mid_kpi,	
		count(distinct case when base.branch_name in ('北京','上海','广州','深圳','杭州','南京','天津') 
						and tst.position_level is not null and base.is_sd = 0 and status in (0,1) 
						and nvl(income.month_income_money,0) > tst.l_first_value  then base.id
				when base.branch_name not in ('北京','上海','广州','深圳','杭州','南京','天津') 
						and tst.position_level is not null and base.is_sd = 0 and status in (0,1) 
						and nvl(income.month_income_money,0) > tst.l_second_value  then base.id
			    else null end) as high_kpi
	from 
	(select id,
				is_sd,status,lp_age,
				sd_id,sr_sd_id,sr_sd_name,sd_name,branch_name,
				position_level,
				case when instr(org_name,'SS') > 0 then 'SS'
					 when instr(org_name,'S') > 0 then 'S'
					 when instr(org_name,'KA') > 0 then 'KA'
				else '其他' end as sd_level
		  from dw_erp_d_salesuser_to_sd
		  where p_date = '20170430'
		) base
	left join 
	(
	  select income1.sales_id,
		    sum(month_income_money) as month_income_money,
			sum(quarter_income_money) as quarter_income_money,
			sum(year_income_money) as year_income_money,
			sum(is_new_cust*month_income_money) as new_month_income_money,
			sum(is_new_cust*contract_cnt) as new_month_income_contract_cnt,
			sum(month_income_money) - sum(is_new_cust*month_income_money) as renew_month_income_money,
			sum(contract_cnt) - sum(is_new_cust*contract_cnt) as renew_month_income_contract_cnt,
			count( case when month_income_money > 0 then customer_id else null end) as month_income_cust_cnt
	  from (
			  select income.sales_id,income.customer_id,
				   sum(case when income.d_date between concat(substr('20170430',1,6),'01') and '20170430' then money else 0 end) as month_income_money,
				   0 as quarter_income_money,
				   sum(case when income.d_date between concat(substr('20170430',1,4),'0101') and '20170430' then money else 0 end) as year_income_money,
				   case when min(substr(income.d_date,1,6)) = substr('20170430',1,6) then 1 else 0 end as is_new_cust,
				   count(distinct case when income.d_date between concat(substr('20170430',1,6),'01') and '20170430' then contract_id else null end) as contract_cnt 
			  from dw_erp_d_crmfinance_income income 
			  where p_date = '20170430'
			  group by income.sales_id,income.customer_id
		  ) income1  
	  group by income1.sales_id
	 ) income 
	 on base.id = income.sales_id
	 left join 
		(select sales_user_id,count(id) as cust_cnt
		from dw_erp_d_customer_base new
		where new.company_certificate not in ('','-1')
		and new.p_date = '20170430'
		group by new.sales_user_id
		) cust
	 on base.id = cust.sales_user_id
		left join 
		(
			select sales_id, mtd_cover_cus_cnt as cover_cust_cnt
			  from fact_h_erp_d_customer_cover
			   where d_date = '20170430'
		) cover 
		on base.id = cover.sales_id
	left join 
	(
		select  sales_id,
				sum(is_expire_no_renewal) as expire_no_renewal_cust_cnt,
				sum(is_expire_no_renewal*contract_money) as expire_no_renewal_cust_money,
				(sum(is_expire_renewal) + sum(is_pre_expire_renewal) + sum(is_90day_on_expire_renewal))  as renewal_cnt_ratio_dm,
				(sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)+ sum(is_90day_on_expire_renewal))  as renewal_cnt_ratio_nm,
				(sum(is_expire_renewal*next_income_money) + sum(is_pre_expire_renewal*next_income_money)+ sum(is_90day_on_expire_renewal*next_income_money) ) as renewal_money_ratio_dm,
				(sum(is_expire*income_money) + sum(is_pre_expire_renewal*income_money) - sum(is_expire_pre_renewal*income_money)+ sum(is_90day_on_expire_renewal*income_money) ) as renewal_money_ratio_nm
		from dw_erp_d_sales_renewal_flag
		where p_date = '20170430'
		and d_date = '20170430'
		group by sales_id
	) renewal 
	on base.id = renewal.sales_id
	left join 
	(
		select
			cust.sales_user_id,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '互联网.游戏.软件' and income1.month_income_money > 0 then income1.customer_id else null end) as hlw_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '互联网.游戏.软件' then income1.month_income_money else 0 end) as hlw_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '互联网.游戏.软件' and cust.in_service = 1 then cust.id else null end) as hlw_service_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '互联网.游戏.软件' and cust.in_service = 1 then income1.day365_income_money else 0 end) as hlw_service_cust_income,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '互联网.游戏.软件' then cust.id else null end) as hlw_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '互联网.游戏.软件' then income1.last_year_income_money else 0 end) as hlw_last_year_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '互联网.游戏.软件' and income1.last_month_income_money > 0 then income1.customer_id else null end) as hlw_last_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '互联网.游戏.软件' then income1.last_month_income_money else 0 end) as hlw_last_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '房地产.建筑.物业' and income1.month_income_money > 0 then income1.customer_id else null end) as fdc_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '房地产.建筑.物业' then income1.month_income_money else 0 end) as fdc_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '房地产.建筑.物业' and cust.in_service = 1 then cust.id else null end) as fdc_service_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '房地产.建筑.物业' and cust.in_service = 1 then income1.day365_income_money else 0 end) as fdc_service_cust_income,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '房地产.建筑.物业' then cust.id else null end) as fdc_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '房地产.建筑.物业' then income1.last_year_income_money else 0 end) as fdc_last_year_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '房地产.建筑.物业' and income1.last_month_income_money > 0 then income1.customer_id else null end) as fdc_last_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '房地产.建筑.物业' then income1.last_month_income_money else 0 end) as fdc_last_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '金融' and income1.month_income_money > 0 then income1.customer_id else null end) as jr_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '金融' then income1.month_income_money else 0 end) as jr_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '金融' and cust.in_service = 1 then cust.id else null end) as jr_service_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '金融' and cust.in_service = 1 then income1.day365_income_money else 0 end) as jr_service_cust_income,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '金融' then cust.id else null end) as jr_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '金融' then income1.last_year_income_money else 0 end) as jr_last_year_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '金融' and income1.last_month_income_money > 0 then income1.customer_id else null end) as jr_last_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '金融' then income1.last_month_income_money else 0 end) as jr_last_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '消费品' and income1.month_income_money > 0 then income1.customer_id else null end) as xfp_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '消费品' then income1.month_income_money else 0 end) as xfp_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '消费品' and cust.in_service = 1 then cust.id else null end) as xfp_service_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '消费品' and cust.in_service = 1 then income1.day365_income_money else 0 end) as xfp_service_cust_income,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '消费品' then cust.id else null end) as xfp_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '消费品' then income1.last_year_income_money else 0 end) as xfp_last_year_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '消费品' and income1.last_month_income_money > 0 then income1.customer_id else null end) as xfp_last_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '消费品' then income1.last_month_income_money else 0 end) as xfp_last_income_money,
		    count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '汽车.机械.制造' and income1.month_income_money > 0 then income1.customer_id else null end) as qc_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '汽车.机械.制造' then income1.month_income_money else 0 end) as qc_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '汽车.机械.制造' and cust.in_service = 1 then cust.id else null end) as qc_service_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '汽车.机械.制造' and cust.in_service = 1 then income1.day365_income_money else 0 end) as qc_service_cust_income,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '汽车.机械.制造' then cust.id else null end) as qc_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '汽车.机械.制造' then income1.last_year_income_money else 0 end) as qc_last_year_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '汽车.机械.制造' and income1.last_month_income_money > 0 then income1.customer_id else null end) as qc_last_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '汽车.机械.制造' then income1.last_month_income_money else 0 end) as qc_last_income_money,

		    count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '制药.医疗' and income1.month_income_money > 0 then income1.customer_id else null end) as zy_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '制药.医疗' then income1.month_income_money else 0 end) as zy_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '制药.医疗' and cust.in_service = 1 then cust.id else null end) as zy_service_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '制药.医疗' and cust.in_service = 1 then income1.day365_income_money else 0 end) as zy_service_cust_income,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '制药.医疗' then cust.id else null end) as zy_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '制药.医疗' then income1.last_year_income_money else 0 end) as zy_last_year_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry = '制药.医疗' and income1.last_month_income_money > 0 then income1.customer_id else null end) as zy_last_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry = '制药.医疗' then income1.last_month_income_money else 0 end) as zy_last_income_money,

		    count(case when cust.repertory_level in (0,1) and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  and income1.month_income_money > 0 then income1.customer_id else null end) as qt_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  then income1.month_income_money else 0 end) as qt_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  and cust.in_service = 1 then cust.id else null end) as qt_service_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  and cust.in_service = 1 then income1.day365_income_money else 0 end) as qt_service_cust_income,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  then cust.id else null end) as qt_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  then income1.last_year_income_money else 0 end) as qt_last_year_income_money,
			count(case when cust.repertory_level in (0,1) and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  and income1.last_month_income_money > 0 then income1.customer_id else null end) as qt_last_income_cust_cnt,
			sum(case when cust.repertory_level in (0,1) and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  then income1.last_month_income_money else 0 end) as qt_last_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '互联网.游戏.软件' and income1.month_income_money > 0 then income1.customer_id else null end) as ka_hlw_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '互联网.游戏.软件' then income1.month_income_money else 0 end) as ka_hlw_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '互联网.游戏.软件' and cust.in_service = 1 then cust.id else null end) as ka_hlw_service_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '互联网.游戏.软件' and cust.in_service = 1 then income1.day365_income_money else 0 end) as ka_hlw_service_cust_income,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '互联网.游戏.软件' then cust.id else null end) as ka_hlw_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '互联网.游戏.软件' then income1.last_year_income_money else 0 end) as ka_hlw_last_year_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '互联网.游戏.软件' and income1.last_month_income_money > 0 then income1.customer_id else null end) as ka_hlw_last_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '互联网.游戏.软件' then income1.last_month_income_money else 0 end) as ka_hlw_last_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '房地产.建筑.物业' and income1.month_income_money > 0 then income1.customer_id else null end) as ka_fdc_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '房地产.建筑.物业' then income1.month_income_money else 0 end) as ka_fdc_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '房地产.建筑.物业' and cust.in_service = 1 then cust.id else null end) as ka_fdc_service_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '房地产.建筑.物业' and cust.in_service = 1 then income1.day365_income_money else 0 end) as ka_fdc_service_cust_income,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '房地产.建筑.物业' then cust.id else null end) as ka_fdc_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '房地产.建筑.物业' then income1.last_year_income_money else 0 end) as ka_fdc_last_year_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '房地产.建筑.物业' and income1.last_month_income_money > 0 then income1.customer_id else null end) as ka_fdc_last_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '房地产.建筑.物业' then income1.last_month_income_money else 0 end) as ka_fdc_last_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '金融' and income1.month_income_money > 0 then income1.customer_id else null end) as ka_jr_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '金融' then income1.month_income_money else 0 end) as ka_jr_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '金融' and cust.in_service = 1 then cust.id else null end) as ka_jr_service_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '金融' and cust.in_service = 1 then income1.day365_income_money else 0 end) as ka_jr_service_cust_income,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '金融' then cust.id else null end) as ka_jr_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '金融' then income1.last_year_income_money else 0 end) as ka_jr_last_year_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '金融' and income1.last_month_income_money > 0 then income1.customer_id else null end) as ka_jr_last_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '金融' then income1.last_month_income_money else 0 end) as ka_jr_last_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '消费品' and income1.month_income_money > 0 then income1.customer_id else null end) as ka_xfp_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '消费品' then income1.month_income_money else 0 end) as ka_xfp_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '消费品' and cust.in_service = 1 then cust.id else null end) as ka_xfp_service_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '消费品' and cust.in_service = 1 then income1.day365_income_money else 0 end) as ka_xfp_service_cust_income,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '消费品' then cust.id else null end) as ka_xfp_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '消费品' then income1.last_year_income_money else 0 end) as ka_xfp_last_year_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '消费品' and income1.last_month_income_money > 0 then income1.customer_id else null end) as ka_xfp_last_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '消费品' then income1.last_month_income_money else 0 end) as ka_xfp_last_income_money,
		    count(case when cust.repertory_level = 2 and cust.d_main_industry = '汽车.机械.制造' and income1.month_income_money > 0 then income1.customer_id else null end) as ka_qc_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '汽车.机械.制造' then income1.month_income_money else 0 end) as ka_qc_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '汽车.机械.制造' and cust.in_service = 1 then cust.id else null end) as ka_qc_service_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '汽车.机械.制造' and cust.in_service = 1 then income1.day365_income_money else 0 end) as ka_qc_service_cust_income,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '汽车.机械.制造' then cust.id else null end) as ka_qc_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '汽车.机械.制造' then income1.last_year_income_money else 0 end) as ka_qc_last_year_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '汽车.机械.制造' and income1.last_month_income_money > 0 then income1.customer_id else null end) as ka_qc_last_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '汽车.机械.制造' then income1.last_month_income_money else 0 end) as ka_qc_last_income_money,

		    count(case when cust.repertory_level = 2 and cust.d_main_industry = '制药.医疗' and income1.month_income_money > 0 then income1.customer_id else null end) as ka_zy_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '制药.医疗' then income1.month_income_money else 0 end) as ka_zy_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '制药.医疗' and cust.in_service = 1 then cust.id else null end) as ka_zy_service_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '制药.医疗' and cust.in_service = 1 then income1.day365_income_money else 0 end) as ka_zy_service_cust_income,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '制药.医疗' then cust.id else null end) as ka_zy_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '制药.医疗' then income1.last_year_income_money else 0 end) as ka_zy_last_year_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry = '制药.医疗' and income1.last_month_income_money > 0 then income1.customer_id else null end) as ka_zy_last_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry = '制药.医疗' then income1.last_month_income_money else 0 end) as ka_zy_last_income_money,

		    count(case when cust.repertory_level = 2 and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  and income1.month_income_money > 0 then income1.customer_id else null end) as ka_qt_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  then income1.month_income_money else 0 end) as ka_qt_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  and cust.in_service = 1 then cust.id else null end) as ka_qt_service_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  and cust.in_service = 1 then income1.day365_income_money else 0 end) as ka_qt_service_cust_income,
			count(case when cust.repertory_level = 2 and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  then cust.id else null end) as ka_qt_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  then income1.last_year_income_money else 0 end) as ka_qt_last_year_income_money,
			count(case when cust.repertory_level = 2 and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  and income1.last_month_income_money > 0 then income1.customer_id else null end) as ka_qt_last_income_cust_cnt,
			sum(case when cust.repertory_level = 2 and cust.d_main_industry not in ('互联网.游戏.软件','房地产.建筑.物业','消费品','金融','汽车.机械.制造','制药.医疗')  then income1.last_month_income_money else 0 end) as ka_qt_last_income_money
		from
		(select new.id,new.repertory_level,di.d_main_industry,sales_user_id,
				1 as is_cust,
				case when (rpo.customer_id is not null or new.ecomp_version in (2,3) ) and parent_customer_id = 0  then 1 else 0 end as in_service
			from dw_erp_d_customer_base new
			left join dim_industry di 
		  	on new.industry = di.d_ind_code
			left join (
				select get_first_code(customer_ids,',') as customer_id
				  from dw_god_d_rpo_project
				  where p_date = '20170430'
				   and status = 2
				  ) rpo 
			on new.id = rpo.customer_id
			where new.company_certificate not in ('','-1')
			and new.p_date = '20170430'
		) cust
		left join 
		(
		 select income.customer_id,
			   sum(case when income.d_date between concat(substr('20170430',1,6),'01') and '20170430' then money else 0 end) as month_income_money,
			   sum(case when income.d_date between concat(substr('20170430',1,4),'0101') and '20170430' then money else 0 end) as year_income_money,
			   sum(case when substr(income.d_date,1,6) =  concat(int(substr('20170430',1,4))-1,substr('20170430',5,2)) then money else 0 end) as last_month_income_money,
			   sum(case when dim_date.d_year = int(substr('20170430',1,4))-1 then money else 0 end) as last_year_income_money,
			   sum(case when income.d_date between concat(int(substr('20170430',1,4))-1,substr('20170430',5,4)) and '20170430' then money else 0 end) as day365_income_money
		  from dw_erp_d_crmfinance_income income 
		  join (select d_date,d_year
		  	     from dim_date
		  	     where d_date between 20160101 and '20170430') as dim_date
		  on income.d_date = dim_date.d_date
		  where income.p_date = '20170430'
		  group by income.customer_id
		) income1
		on cust.id = income1.customer_id
		group by cust.sales_user_id
	) ind 
	on base.id = ind.sales_user_id
	left join temp_sales_task tst 
	on base.position_level = tst.position_level
	group by base.branch_name
) branch_kpi
full join  
(  
	select 
		base.branch_name,
		count(1) as contract_cnt,
		sum(contract_money) as contract_money,
		sum(is_have_lpt_suit*suit_money) as lpt_suit_money,
		sum(is_have_lpt_suit) as lpt_suit_cnt,
		sum(lpt_item_money) as lpt_item_money,
		count(case when ad_item_money > 0 then contract_id else null end) as ad_item_cnt,
		sum(ad_item_money) as ad_item_money,
		count(case when is_have_rpo > 0 then contract_id else null end) as rpo_item_cnt,
		sum(rpo_item_money) as rpo_item_money,
		count(case when is_have_xy > 0 then contract_id else null end) as xy_item_cnt,
		sum(xy_item_money) as xy_item_money,
		count(case when is_have_test > 0 then contract_id else null end) as test_item_cnt,
		sum(test_item_money) as test_item_money,		
		sum(bc_item_money) as bc_item_money,
		count(case when is_have_srp > 0 then contract_id else null end) as srp_item_cnt,
		sum(srp_item_money) as srp_item_money,
		count(case when is_have_lpt_suit*suit_money+ lpt_item_money+ ad_item_money> 0 then contract_id else null end) as online_contract_cnt,
		sum(case when is_have_lpt_suit*suit_money+ lpt_item_money+ ad_item_money> 0 then contract_money else null end) as online_contract_money			
	from (select id,
			is_sd,status,
			sd_id,sr_sd_id,sr_sd_name,sd_name,branch_name,
			position_level,
			case when instr(org_name,'SS') > 0 then 'SS'
				 when instr(org_name,'S') > 0 then 'S'
				 when instr(org_name,'KA') > 0 then 'KA'
			else '其他' end as sd_level
	  from dw_erp_d_salesuser_to_sd
	  where p_date = '20170430'
	  and (instr(org_name,'S') > 0 or instr(org_name,'KA') > 0)
	) base
	join dw_erp_a_contract_product prod 
	on base.id = prod.sales_id
	and regexp_replace(prod.income_date,'-','') between concat(substr('20170430',1,6),'01') and '20170430'
	group by base.branch_name
) prod 
on branch_kpi.branch_name = prod.branch_name
full join 
(
	select branch_name,
		   max(case when income_rn = 1 then concat(suit_name) else null end) as string_a_suit_money,
		   max(case when income_rn = 2 then concat(suit_name) else null end) as string_b_suit_money,
		   max(case when income_rn = 3 then concat(suit_name) else null end) as string_c_suit_money,				   
		   max(case when cnt_rn = 1 then online_income_money else null end) as a_suit_money,
		   max(case when cnt_rn = 2 then online_income_money else null end) as b_suit_money,
		   max(case when cnt_rn = 3 then online_income_money else null end) as c_suit_money,
		   max(case when cnt_rn = 1 then concat(suit_name) else null end) as string_a_suit_cnt,
		   max(case when cnt_rn = 2 then concat(suit_name) else null end) as string_b_suit_cnt,
		   max(case when cnt_rn = 3 then concat(suit_name) else null end) as string_c_suit_cnt,
		   max(case when cnt_rn = 1 then online_contract_cnt else null end) as a_suit_cnt,
		   max(case when cnt_rn = 2 then online_contract_cnt else null end) as b_suit_cnt,
		   max(case when cnt_rn = 3 then online_contract_cnt else null end) as c_suit_cnt					   			   
	from (
		select  suit0.branch_name,
				suit0.suit_name,
				suit0.online_income_money,
				suit0.online_contract_cnt,
				row_number()over(distribute by suit0.branch_name sort by suit0.online_income_money desc) as income_rn,
				row_number()over(distribute by suit0.branch_name sort by suit0.online_contract_cnt desc) as cnt_rn
		from (
		select 
			base.branch_name,prod.suit_name,
			sum(is_have_lpt_suit*contract_money) as online_income_money,
			count(is_have_lpt_suit) as online_contract_cnt
		from (select id,
					is_sd,status,
					sd_id,sr_sd_id,sr_sd_name,sd_name,branch_name,
					position_level,
					case when instr(org_name,'SS') > 0 then 'SS'
						 when instr(org_name,'S') > 0 then 'S'
						 when instr(org_name,'KA') > 0 then 'KA'
					else '其他' end as sd_level
			  from dw_erp_d_salesuser_to_sd
			  where p_date = '20170430'
			  and (instr(org_name,'S') > 0 or instr(org_name,'KA') > 0)
	    	) base
		join dw_erp_a_contract_product prod 
		on base.id = prod.sales_id
		and is_have_lpt_suit = 1
		and regexp_replace(prod.income_date,'-','') between concat(substr('20170430',1,6),'01') and '20170430'
		group by base.branch_name,prod.suit_name
		) suit0
	) suit1
	group by branch_name
) suit 
on branch_kpi.branch_name = suit.branch_name