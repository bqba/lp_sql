select '全年合计','全部推简历职位数','RPS推简历职位数','伯乐推简历职位数' from dummy;
select 
	case when contract.avg_money < 8000 then '<8000'
			  when contract.avg_money >= 8000 and contract.avg_money  <15000  then '8000-15000'
			  when contract.avg_money >= 15000 and contract.avg_money  <=30000  then '15000-30000'
			  when contract.avg_money >= 30000 then '>30000'
		 end as  avg_money_level,
	sum(recom_cnt),
	sum(rps_cnt),
	sum(bole_cnt)
from 
(select customer_id,avg(money) as avg_money
from dw_erp_d_contract_base
where p_date = 20161020
and type =  0
and status in (2,3)
and subaction = 0
and substr(regexp_replace(createtime,'-',''),1,6) between 201509 and 201609
and money > 3000
group by customer_id
) contract 
left join 
(
select customer_id,
	   count(distinct ejob_id) as recom_cnt,
	   count(distinct case when source = 0 then ejob_id else null end) as rps_cnt,
	   count(distinct case when source = 4 then ejob_id else null end) as bole_cnt
from dw_erp_d_ejob_candidate
where substr(regexp_replace(createtime,'-',''),1,6)  between 201509 and 201609
and p_date = 20161020
group by customer_id
) recom 
on contract.customer_id = recom.customer_id
group by case when contract.avg_money < 8000 then '<8000'
			  when contract.avg_money >= 8000 and contract.avg_money  <15000  then '8000-15000'
			  when contract.avg_money >= 15000 and contract.avg_money  <=30000  then '15000-30000'
			  when contract.avg_money >= 30000 then '>30000'
		 end 


--1. 销售业绩数据表
--月份	销售	入职时间（日期）	大区	城市	部门	团队	销售总监	高级总监	回款金额	回款单量	回款客户数

select '月份','销售ID', '销售', '入职时间（日期）', '大区', '城市', '团队ID','团队', '回款金额', '回款单量', '回款客户数' from dummy;
select
	substr(regexp_replace(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),'-',''),1,6)  as d_month,
	income.sales_id,
	salesuser.name,
	salesuser.entrydate,
	dim_org.area_name,
	dim_org.branch_name,	
	salesuser.org_id,
	dim_org.org_name,
	nvl(income_amount,0),
	nvl(contract_cnt,0),
	nvl(cus_cnt,0)
from (
	select 
	sales_id,
	count(distinct customer_id) as cus_cnt,
	count(distinct contract_id) as contract_cnt,
	sum(money) as income_amount
	from dw_erp_d_crmfinance_income
	where p_date = 20161001
	and pay_time between concat(substr(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),1,7),'-01' ) and date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1)
	group by sales_id
) income
left join 
(select id,name,org_id,org_name,entrydate
from dw_erp_d_salesuser_base
where p_date = regexp_replace(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),'-','')
) salesuser
on income.sales_id = salesuser.id
left join  dim_org
on salesuser.org_id = dim_org.d_org_id;

--2.销售行为数据表											
--月份	销售	入职时间（日期）	大区	城市	部门	团队	销售总监	高级总监	电话时长	电话个数	日均电话时长
select '月份', '销售ID','销售', '入职时间（日期）', '大区', '城市', '团队ID','团队', '电话时长', '电话个数', '日均电话时长' from dummy;
select
	substr(regexp_replace(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),'-',''),1,6)  as d_month,
	callrecord.sales_id,
	salesuser.name,
	salesuser.entrydate,
	dim_org.area_name,
	dim_org.branch_name,	
	salesuser.org_id,
	dim_org.org_name,
	nvl(call_time_long,0),
	nvl(call_rec_cnt,0),
	nvl(call_time_long,0) / workdays.workdays
from (select creator_id as sales_id,
			sum(case when time_long/60 > 30 then 30.00 else round(time_long/60 ,2) end ) as call_time_long,
			count(id) call_rec_cnt
	  from call_record 	  
	where  begin_time >='080000'
		and end_time <='200000'
	    and time_long>45
		and customer_id >0
		and call_date between concat(substr(regexp_replace(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),'-',''),1,6),'01' ) and regexp_replace(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),'-','')
	group by creator_id
	) callrecord 
	left join 
	(select id,name,org_id,org_name,entrydate
	from dw_erp_d_salesuser_base
	where p_date = regexp_replace(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),'-','')
	) salesuser
	on callrecord.sales_id = salesuser.id
	left join  dim_org
	on salesuser.org_id = dim_org.d_org_id
	join temp_sales_workdays workdays
	on substr(20161001,1,6) = workdays.d_month

-- 3.销售团队行为数据表									
-- 月份	团队	大区	城市	部门	销售总监	高级总监	人数	人均电话时长	人均电话个数
select '月份', '大区', '城市', '团队ID', '团队',  '人数', '人均电话时长', '人均电话个数' from dummy;
select
	substr(regexp_replace(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),'-',''),1,6)  as d_month,
	dim_org.area_name,
	dim_org.branch_name,	
	callrecord.org_id,
	dim_org.org_name,
	nvl(salesuser.sales_cnt,0),
	nvl((callrecord.call_time_long / salesuser.sales_cnt) / workdays.workdays,0),
	nvl((callrecord.call_rec_cnt / salesuser.sales_cnt) / workdays.workdays,0)
from (select org_id as org_id,
			sum(case when time_long/60 > 30 then 30.00 else round(time_long/60 ,2) end ) as call_time_long,
			count(id) call_rec_cnt
	  from call_record 	  
	where  begin_time >='080000'
		and end_time <='200000'
	    and time_long>45
		and customer_id >0
		and call_date between concat(substr(regexp_replace(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),'-',''),1,6),'01' ) and regexp_replace(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),'-','')
	group by org_id
	) callrecord 
	left join 
	(select org_id,count(id) /2 as sales_cnt
	from dw_erp_d_salesuser_base
	where p_date in (concat(substr(regexp_replace(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),'-',''),1,6),'01' ) ,regexp_replace(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),'-','')) 
	  and status in (0,1)
	  and position_channel in ('A0000484','A0000485','A0000486','A0000821') 
	group by org_id
	) salesuser
	on callrecord.org_id = salesuser.org_id
	left join  dim_org
	on salesuser.org_id = dim_org.d_org_id
	join temp_sales_workdays workdays
	on workdays.d_month = substr(regexp_replace(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),'-',''),1,6) ;

-- 4.合同类型业绩数据表			
-- 月份	合同类型	城市	回款金额
--合同类型: 0-猎聘通网上综合合同，1-诚聘通合同，2-薪酬报告，10-校园，11-rpo，12-广告，13-猎聘通，14-白领在线支付合同
select '月份', '合同类型', '城市', '回款金额' from dummy;
select
	substr(regexp_replace(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),'-',''),1,6)  as d_month,
	enum.enum_name, 
	dim_org.branch_name,
	nvl(sum(income_amount),0)
from (
	select org_id,biz_type,
	sum(money) as income_amount
	from dw_erp_d_crmfinance_income
	where p_date = 20161001
	and pay_time between concat(substr(date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1),1,7),'-01' ) and date_add(concat(substr(20161001,1,4),'-',substr(20161001,5,2),'-01'),-1)
	group by org_id,biz_type
) income
left join dim_org
on income.org_id = dim_org.d_org_id
left join pub_enum_list enum
on income.biz_type = enum.enum_code
and enum.is_default = 1
and enum.src_table = 'crm_contract'
and enum.enum_type = 'type'
group by enum.enum_name, dim_org.branch_name

