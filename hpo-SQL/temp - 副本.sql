	
select
	d_date,
	base.id ,
	base.name ,
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
	contract.noincome_invoice_cus_cnt, --已开票未回款客户数
	contract.lpt_income,--猎聘通合同回款金额
	contract.all_income--合同回款金额		
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
   from  dw_erp_d_saleuser_base
  where p_date = $date$) base 
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
		and call_date='$date$'
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
		and ccv.visit_date='$date$'
	group by ccv.creator_id
) visit
on  base.id = visit.creator_id	
left outer join 
	(
		select  base.creator_id,
					count(case when regexp_replace(substr(base.sign_date,1,10),'-','')  = '$date$' then base.id else null end) contract_new_cnt, --已签约合同数
					sum(case when regexp_replace(substr(base.sign_date,1,10),'-','')  = '$date$' then base.money else null end) contract_new_amount,--已签约金额
					count(distinct case when '$date$' between  regexp_replace(substr(lpt_service_effect_date,1,10),'-','')  and regexp_replace(substr(lpt_service_expired_date,1,10),'-','') then base.customer_id else null end) cus_contract_cnt,	--合作中客户数		
					count(distinct case when regexp_replace(date_add(substr(lpt_service_expired_date,10),90) ,'-','') < '$date$'  then base.customer_id else null end) as cus_expire_cnt, --到期客户数
					count(distinct case when regexp_replace(date_add(substr(lpt_service_expired_date,10),-90) ,'-','') > '$date$'  then base.customer_id else null end ) as cus_break_cnt, --断约客户数
					count(distinct case when '$date$' between  regexp_replace(substr(lpt_service_effect_date,1,10),'-','')  and regexp_replace(substr(lpt_service_expired_date,1,10),'-','')  and income.contract_id is null  then base.customer_id else null end) as  noincome_effect_cus_cnt, --提前开通未回款客户数
					count(distinct case when income.contract_id is null and invoice.id is not null  then base.customer_id else null end) as noincome_invoice_cus_cnt, --已开票未回款客户数
					sum(income.lpt_income) as lpt_income, --猎聘通合同回款金额
					sum(income.all_income) as all_income --合同回款金额
			from  
			(select id,sign_date,money,lpt_service_effect_date,customer_id,creator_id,lpt_service_expired_date
			 from dw_erp_d_contract_base
			  where p_date =  $date$) base 			  
			left outer join 
			  (   select contract_id,sum(money) money,
							sum(case when regexp_replace(substr(pay_time,1,10),'-','')  =  '$date$' and biz_type = 0 then money else '0' end) as  lpt_income, --猎聘通合同回款金额
							sum(case when regexp_replace(substr(pay_time,1,10),'-','')  =  '$date$' then money else '0' end)  as all_income  --合同回款金额
					from crm_finance_income
				   group by contract_id
				)  income
			on base.id = income.contract_id
			left outer join 
			(select id,object_id as contract_id
			 from crm_finance_invoice) invoice
			on base.id = invoice.contract_id			
			group by base.creator_id	  
	) contract 
on base.id = contract.creator_id
left outer join 
(select  input_id,
				count(case when regexp_replace(substr(create_time,1,10)'-','')  = '$date$' then id else null end) input_cus_cnt,
				count(case when customerCategory = 1 then id else null end) contract_cus_cnt,
				count(case when customerCategory = 1 and ecompversion= 2  then id else null end) jy_contract_cus_cnt,
				count(case when customerCategory = 1 and ecompversion= 3  then id else null end) bl_contract_cus_cnt,
				count(case when customerCategory = 2 then id else null end) end_cus_cnt,
				count(case when customerCategory = 2 and ecompversion= 2  then id else null end) jy_end_cus_cnt,
				count(case when customerCategory = 2 and ecompversion= 3  then id else null end) bl_end_cus_cnt,	
				count(case when customerCategory = 0 then id else null end) target_cus_cnt,	
				count(case when customerCategory = 3 then id else null end) keep_cus_cnt
	  from  dw_erp_d_customer_base
	 where p_date =  $date$
	 group by input_id	    
) cus
on base.id = cus.input_id
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  	--当天应收金额
	  left outer join 
	  (   select creator_id,
					  sum(case when biz_type = 0  then money else 0 end) lpt_receivables,
					  sum(money)  all_reveivables
			from crm_finance_receivables
			where regexp_replace(substr(expect_pay_date,1,10),'-','')  =  '$date$'
		   group by creator_id
		)  reveivables
	  on base.id = reveivables.creator_id	
	  --当天开票金额
	  left outer join
	  (
		 select creator_id,
					  sum(case when biz_type = 0  then money else 0 end) lpt_invoice,
					  sum(money)  all_invoice
			from crm_finance_invoice
			where regexp_replace(substr(expect_pay_date,1,10),'-','')  =  '$date$'
		   group by creator_id
	   ) invoice
	  on base.id =  invoice.creator_id                          
		
		
id	主键ID	int
customer_id	客户ID	int
contract_id	合同ID	int
contract_no	合同号	varchar
biz_type	业务类型:猎聘通,诚猎通,校园,RPO,薪酬报告	tinyint
money	应收金额	float
expect_pay_date	预计付款日期	char
status	状态:未入账,已入账	tinyint
creator_id	当前维护人	int
org_id	所属部门	int
createtime	创建日期	timestamp
modifytime	修改日期	timestamp
deleteflag		tinyint

		   
		   
		   select cu.customer_Category,count(ct.id),count(cu.id),
		   count(distinct case when '2016-05-15 00:00:00.000' between  lpt_service_effect_date  and lpt_service_expired_date then cu.id else null end ),
		   count(distinct cu.id)
		   from (		   
		   	select id,customer_id,lpt_service_effect_date,lpt_service_expired_date
			  from dw_erp_d_contract_base  
			  where p_date = 20160515
			  and type = 0			  
			  --and '2016-05-15 00:00:00.000' between  lpt_service_effect_date  and lpt_service_expired_date
		   ) ct			 
			 inner join 
			 (select  id,customer_Category
			     from dw_erp_d_customer_base
				 where  p_date = 20160515
				 ) cu
		    on ct.customer_id = cu.id 
			group by cu.customer_Category
		   
		   
		   
		   union all
(
	select  input_id,
				count(case when regexp_replace(substr(create_time,1,10)'-','')  = '$date$' then id else null end) input_cus_cnt,
				count(case when customerCategory = 1 then id else null end) contract_cus_cnt,
				count(case when customerCategory = 1 and ecompversion= 2  then id else null end) jy_contract_cus_cnt,
				count(case when customerCategory = 1 and ecompversion= 3  then id else null end) bl_contract_cus_cnt,
				count(case when customerCategory = 2 then id else null end) end_cus_cnt,
				count(case when customerCategory = 2 and ecompversion= 2  then id else null end) jy_end_cus_cnt,
				count(case when customerCategory = 2 and ecompversion= 3  then id else null end) bl_end_cus_cnt,	
				count(case when customerCategory = 0 then id else null end) target_cus_cnt,	
				count(case when customerCategory = 3 then id else null end) keep_cus_cnt
	  from  dw_erp_d_customer_base
	 where p_date =  $date$
	    and 
     group by input_id	    
)
union all

	    
