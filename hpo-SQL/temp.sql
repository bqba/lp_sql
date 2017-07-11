create table if not exists dw_erp_d_salesuser_act
(
	sales_id int,
	sales_name string,
	sales_group string,
	entrydate string,
	formaldate string,
	position_id int,
	position_name string,
	position_channel string,
	position_level string,
	org_id int,
	org_name string,
	repertory_industry string,
	call_time_long float,
	call_cus_cnt int,
	call_rec_cnt int,
	visit_cus_cnt int,
	input_cus_cnt int,
	contract_new_cnt int,
	contract_new_amount float,
	cus_contract_cnt int,
	cus_expire_cnt int,
	cus_break_cnt int,
	noincome_effect_cus_cnt int,
	lpt_income float,
	all_income float
)
partitioned by (p_date int);

insert overwrite table dw_erp_d_salesuser_act  partition (p_date = $date$)
select
	base.id as sales_id,
	base.name as sales_name,
	null as sales_group ,	
	base.entrydate ,
	base.formaldate ,
	base.position_id ,
	base.position_name ,
	base.position_channel ,
	base.position_level ,
	base.org_id ,
	base.org_name ,
	base.repertory_industry ,
	call_record.call_time_long, --通话时长
	call_record.call_cus_cnt,--通话覆盖客户数
	call_record.call_rec_cnt,--通话数量，
	visit.visit_cus_cnt,--拜访客户数
	cus.input_cus_cnt,--新增录入客户数
	contract.contract_new_cnt, --新增签约合同数
	contract.contract_new_amount,--新增签约合同金额
	contract.cus_contract_cnt,	--合作中客户数
	contract.cus_expire_cnt, --到期客户数
	contract.cus_break_cnt, --断约客户数
	contract.noincome_effect_cus_cnt, --提前开通未回款客户数
	contract.lpt_income,--猎聘通合同回款金额
	contract.all_income,--合同回款金额	
	
from 
(select id ,
			name ,
			username,
			entrydate ,
			formaldate ,
			position_id ,
			position_name ,
			position_channel ,
			position_level ,
			org_id ,
			org_name ,
			repertory_industry 
   from  dw_erp_d_salesuser_base
  where p_date = 20160515) base 
left outer join 
(
	select 	presented_username,
				round(sum(time_long)/60,2) as call_time_long,
				count(distinct customer_id) as call_cus_cnt,
				count(id) call_rec_cnt
	  from call_record 
	where begin_time >='080000'
		and end_time <='200000'
		and time_long>45
		and customer_id >0
		and call_type = '0'
		and call_date='20160515'
		and presented_type = 1
	group by presented_username	  
) call_record
on  base.username = call_record.presented_username
left outer join 
(
	select ccv.creator_id,
				count(distinct ccv.customer_id) as visit_cus_cnt
	from crm_customer_visitplan ccv
	where ccv.visit_status=1
		and ccv.deleteflag=0
		and regexp_replace (substr (ccv.createtime,1,10),"-","") > 20160401   -----排除测试数据
		and ccv.visit_date='20160515'
	group by ccv.creator_id
) visit
on  base.id = visit.creator_id	
left outer join 
	(
		select sales_id,
		sum(is_contract_new) as contract_new_cnt ,
		sum(contract_new_amount) as contract_new_amount,
		sum(is_lpt_in_service) as cus_contract_cnt,
		sum(is_lpt_expire) as cus_expire_cnt,
		sum(is_lpt_break) as cus_break_cnt,
		sum(is_noincome_effect) as noincome_effect_cus_cnt,
		sum(lpt_income) as lpt_income,
		sum(all_income) as all_income
		from dw_erp_d_contract_act
		where p_date = 20160515
		group by sales_id			  
	) contract 
on base.id = contract.sales_id
left outer join 
(select  input_id,
				count(case when regexp_replace(substr(create_time,1,10),'-','')  = '20160515' then id else null end) input_cus_cnt,
				count(case when customer_category = 1 then id else null end) contract_cus_cnt,
				count(case when customer_category = 1 and ecomp_version= 2  then id else null end) jy_contract_cus_cnt,
				count(case when customer_category = 1 and ecomp_version= 3  then id else null end) bl_contract_cus_cnt,
				count(case when customer_category = 2 then id else null end) end_cus_cnt,
				count(case when customer_category = 2 and ecomp_version= 2  then id else null end) jy_end_cus_cnt,
				count(case when customer_category = 2 and ecomp_version= 3  then id else null end) bl_end_cus_cnt,	
				count(case when customer_category = 0 then id else null end) target_cus_cnt,	
				count(case when customer_category = 3 then id else null end) keep_cus_cnt
	  from  dw_erp_d_customer_base
	 where p_date =  20160515
	 group by input_id	    
) cus
on base.id = cus.input_id