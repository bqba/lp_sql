CREATE TABLE dw_erp_d_sales_contract_list(
d_date string comment '统计日期',
rownumber string comment '回款顺序号',
contract_id string comment '合同ID',
contract_no string comment '合同编号',
accounted_date string comment '回款日期',
contract_money float comment '合同金额',
income_money float comment '回款金额',
contract_start_date string comment '服务生效日期',
contract_expire_date string comment '服务失效日期',
contract_status string comment '合同状态',
contract_type string comment '合同类型',
contract_sign_date string comment '合同签约日期',
before_contract_id string comment '上一份合同ID',
before_contract_no string comment '上一份合同编号',
before_accounted_date string comment '上一份合同回款日期',
before_contract_money string comment '上一份合同金额',
before_contract_expire_date string comment '上一份合同到期日期',
before_income_money float comment '上一份合同回款金额',
next_contract_id string comment '下一份合同ID',
next_contract_no string comment '下一份合同编号',
next_accounted_date string comment '下一份合同回款日期',
next_contract_money string comment '下一份合同金额',
next_contract_expire_date string comment '下一份合同到期日期',
next_income_money float comment '下一份合同回款金额',
sign_id string comment '签约销售ID',
sign_name string comment '签约销售名称',
sign_group string comment '签约销售小组',
sign_branch string comment '签约销售分公司',
customer_id string comment '客户ID',
customer_name string comment '客户名称',
customer_source string comment '客户来源',
customer_dq string comment '客户地区',
customer_industry string comment '客户行业',
customer_main_industry string comment '客户大行业',
companyscale string comment '客户企业规模',
companykind string comment '客户企业性质',
sales_id string comment '客户所属销售ID',
sales_name string comment '客户所属销售名称',
sales_org string comment '客户所属销售小组',
sales_branch string comment '客户所属销售分公司',
serviceuser_id string comment '客户所属招服ID',
serviceuser_name string comment '客户所属招服名称',
serviceuser_group string comment '客户所属招服小组',
customer_valid_reason string comment '客户无效原因',
repertory_level int comment '深耕级别',
creation_timestamp string COMMENT '时间戳')
COMMENT '客户新签lpt合同明细表-用于销售计算续约率'
PARTITIONED BY ( p_date int);



insert overwrite table dw_erp_d_sales_contract_list partition(p_date = $date$)
select
d.time1 as d_date,
nvl(d.rownum2,0) as rownumber,
nvl(d.contract_id,0) as contract_id ,
nvl(d.contract_no,0) as contract_no,
d.time1 as accounted_date,
nvl(d.money,0) as contract_money,
nvl(d.income_money,0) as income_money,
nvl(d.effect_date,0) as contract_start_date,
nvl(d.expire_date,0) as contract_expire_date,
nvl(d.status,0) as contract_status,
nvl(d.type,0) as contract_type,
nvl(d.sign_date,0) as contract_sign_date,
nvl(d.before_contract_id,0) as before_contract_id,
nvl(d.before_contract_no,0) as before_contract_no,
nvl(d.beforedate,0) as before_accounted_date,
nvl(d.beforemoney,0) as before_contract_money,
nvl(d.beforeexpire_date,0) as before_contract_expire_date,
nvl(d.before_income_money,0) as before_income_money,
nvl(d.next_contract_id,0) as next_contract_id,
nvl(d.next_contract_no,0) as next_contract_no,
nvl(d.nextdate,0) as next_accounted_date,
nvl(d.nextmoney,0) as next_contract_money,
nvl(d.nextexpire_date,0) as next_contract_expire_date,
nvl(d.next_income_money,0) as next_income_money,
nvl(su.id,0)as sign_id,
nvl(su.name,0)as sign_name,
nvl(su.org_name,0)as sign_group,
nvl(dim_org.branch_name,'未知') as sign_branch,
nvl(d.customer_id,0) as customer_id,
nvl(bc.name,0)as customer_name,
nvl(bc.source,0) as customer_source,
nvl(sd.d_ch_area,0) as customer_dq,
nvl(di.d_sub_industry,0)as customer_industry,
nvl(di.d_main_industry,0)as customer_main_industry,
nvl(bc.company_scale,0)as companyscale,
nvl(bc.company_kind,0)as companykind,
nvl(bc.sales_user_id,0)as sales_id,
nvl(bc.sales_user_name,0)as sales_name,
nvl(bc.sales_org_name,0)as sales_org,
nvl(org2.branch_name,0)as sales_branch,
nvl(bc.serviceuser_id,0) as serviceuser_id,
nvl(bc.serviceuser_name,0) as serviceuser_name,
nvl(bc.service_teamorg_name,0)as serviceuser_group,
nvl(bc.rsc_valid_reason,0)as customer_valid_reason,
nvl(bc.repertory_level,0)as repertory_level,
from_unixtime(unix_timestamp())
from(
	select 
		bb.contract_no,
		bb.status,
		bb.type,
		bb.effect_date,
		bb.sign_date,
		bb.contract_id,
		bb.money,
		bb.customer_id,
		bb.time1,
		bb.secondparty_sign_id,
		bb.expire_date,
		bb.income_money,
		row_number() over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1,bb.expire_date) as rownum2,
		lead(bb.expire_date,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as nextexpire_date,
		lead(bb.time1,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as nextdate,
		lead(bb.money,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as nextmoney,
		lead(bb.contract_no,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as next_contract_no,
		lead(bb.contract_id,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as next_contract_id,
		lag(bb.expire_date,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as beforeexpire_date,
		lag(bb.time1,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as beforedate,
		lag(bb.money,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as beforemoney,
		lag(bb.contract_no,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as before_contract_no,
		lag(bb.contract_id,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as before_contract_id,
		nvl(package.pack_customerid,bb.customer_id) as master_customer,
		lead(bb.income_money,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as next_income_money,
		lag(bb.income_money,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as before_income_money

	from (
		  	 select 
					lp.id as contract_id,
					lp.contract_no,
					lp.customer_id,		
					lp.status,
					lp.type,
					lp.secondparty_sign_id,		
					lp.sign_date,
					lp.money,	
					case when lp.type in (0,14,15) then substr(ccl.contract_effect_time,1,8)
						 when lp.type = 1 then substr(clt.contract_effect_time,1,8)  
						 else income.pay_time 
					end as effect_date,		
					income.pay_time as time1,
					case when lp.type in (0,14,15) then ccl.lpt_service_expired_date 
						 when lp.type = 1 then clt.clt_service_expired_date 
						 else regexp_replace(date_add(pay_time2,365),'-','') 
					end as expire_date,
					income.income_money
				from				
				(
					select  br.contract_id,
							sum(bf.money) as income_money,
							regexp_replace(min(bf.pay_time),'-','') as pay_time ,
							min(bf.pay_time2) as pay_time2
					  from 
					  (select regexp_replace(bf.pay_time,'-','') as pay_time ,bf.receivable_id,bf.pay_time as pay_time2,money
						from dw_erp_a_crmfinance_income as bf
						where bf.money > 1000
					  ) bf
					  join crm_finance_receivables br 
						on bf.receivable_id = br.id 
						and br.deleteflag=0
					group by br.contract_id
				) income
				join crm_contract lp 
				on lp.id = income.contract_id 
				and lp.deleteflag = 0
				and lp.money > 0
				and lp.subaction = 0
				left join crm_contract_lpt ccl 
				on ccl.contract_id = lp.id 
				and ccl.deleteflag = 0
				and ccl.service_days!=0
				left join crm_contract_clt clt 
				on clt.contract_id = lp.id 
				and clt.deleteflag= 0
		) bb
	left join dw_erp_d_gcdc_customer_package package
	on bb.customer_id = package.customer_id
	and package.p_date = '$date$'
) d
left join dw_erp_d_salesuser_base su on d.secondparty_sign_id = su.id and su.p_date = '$date$'
left join dim_org on su.org_id = dim_org.d_org_id
left join dw_erp_d_customer_base bc on d.customer_id =bc.id and bc.p_date = '$date$'
left join dim_org org2 on bc.sales_org_id = org2.d_org_id
left join dim_dq sd on bc.dq = sd.d_code
left join dw_erp_d_salesuser_base saleuser on bc.sales_user_id = saleuser.id and saleuser.p_date = '$date$'
left join dim_industry di on bc.industry =di.d_ind_code;







CREATE TABLE dw_erp_d_sales_renewal_flag(
d_date string comment '统计日期',
contract_id string comment '合同ID',
contract_no string comment '合同编号',
accounted_date string comment '回款日期',
contract_money string comment '合同金额',
income_money float comment '回款金额',
contract_start_date string comment '服务生效日期',
contract_expire_date string comment '服务失效日期',
contract_status string comment '合同状态',
contract_type string comment '合同类型',
contract_sign_date string comment '合同签约日期',
before_contract_id string comment '上一份合同ID',
before_contract_no string comment '上一份合同编号',
before_accounted_date string comment '上一份合同回款日期',
before_contract_money string comment '上一份合同金额',
before_contract_expire_date string comment '上一份合同到期日期',
before_income_money float comment '上一份合同回款金额',
next_contract_id string comment '下一份合同ID',
next_contract_no string comment '下一份合同编号',
next_accounted_date string comment '下一份合同回款日期',
next_contract_money string comment '下一份合同金额',
next_contract_expire_date string comment '下一份合同到期日期',
next_income_money float comment '下一份合同回款金额',
sign_id string comment '签约销售ID',
sign_name string comment '签约销售名称',
sign_group string comment '签约销售小组',
sign_branch string comment '签约销售分公司',
customer_id string comment '客户ID',
customer_name string comment '客户名称',
customer_source string comment '客户来源',
customer_dq string comment '客户地区',
customer_industry string comment '客户行业',
customer_main_industry string comment '客户大行业',
companyscale string comment '客户企业规模',
companykind string comment '客户企业性质',
sales_id string comment '客户所属销售ID',
sales_name string comment '客户所属销售名称',
sales_org string comment '客户所属销售小组',
sales_branch string comment '客户所属销售小组',
serviceuser_id string comment '客户所属招服ID',
serviceuser_name string comment '客户所属招服名称',
serviceuser_group string comment '客户所属招服小组',
customer_valid_reason string comment '客户无效原因',
repertory_level int comment '深耕级别',
is_expire int comment '是否当月过期客户',
is_expire_pre_renewal int comment '是否当月过期提前续约客户',
is_expire_renewal int comment '是否当月过期当月续约客户',
is_expire_no_renewal int comment '是否当月过期未续约客户',
is_pre_expire_renewal int comment '是否未过期提前本月续约客户',
is_on_expire_renewal int comment '是否断约挽回客户',
is_90day_on_expire_renewal int comment '是否前三个月内到期在本月续约客户',
is_expire_90day_on_renewal int comment '是否本月到期且在未来3个月内续约客户',
creation_timestamp string COMMENT '时间戳')
COMMENT '客户新签lpt合同明细表-用于销售计算续约率-分子分母标识'
PARTITIONED BY ( p_date int);

insert overwrite table dw_erp_d_sales_renewal_flag partition(p_date = $date$)
select 
	base1.d_date,
	base1.contract_id,
	base1.contract_no,
	base1.accounted_date,
	base1.contract_money,
	base1.income_money,
	base1.contract_start_date,
	base1.contract_expire_date,
	base1.contract_status,
	base1.contract_type,
	base1.contract_sign_date,
	base1.before_contract_id,
	base1.before_contract_no,
	base1.before_accounted_date,
	base1.before_contract_money,
	base1.before_contract_expire_date,
	base1.before_income_money,
	base1.next_contract_id,
	base1.next_contract_no,
	base1.next_accounted_date,
	base1.next_contract_money,
	base1.next_contract_expire_date,
	base1.next_income_money,
	base1.sign_id,
	base1.sign_name,
	base1.sign_group,
	base1.sign_branch,
	base1.customer_id,
	base1.customer_name,
	base1.customer_source,
	base1.customer_dq,
	base1.customer_industry,
	base1.customer_main_industry,
	base1.companyscale,
	base1.companykind,
	base1.sales_id,
	base1.sales_name,
	base1.sales_org,
	base1.sales_branch,
	base1.serviceuser_id,
	base1.serviceuser_name,
	base1.serviceuser_group,
	base1.customer_valid_reason, 
	base1.repertory_level,
    case when sum(base1.is_expire) > 0 then 1 else 0 end as is_expire,
    case when sum(base1.is_expire_pre_renewal) > 0 then 1 else 0 end as is_expire_pre_renewal,
    case when sum(base1.is_expire_renewal) > 0 then 1 else 0 end as is_expire_renewal,
    case when sum(base1.is_expire_no_renewal) > 0 then 1 else 0 end as is_expire_no_renewal,
    case when sum(base1.is_pre_expire_renewal) > 0 then 1 else 0 end as is_pre_expire_renewal,
    case when sum(base1.is_on_expire_renewal) > 0 then 1 else 0 end as is_on_expire_renewal,
    case when sum(base1.is_90day_on_expire_renewal) > 0 then 1 else 0 end as is_90day_on_expire_renewal,
    case when sum(base1.is_expire_90day_on_renewal) > 0 then 1 else 0 end as is_expire_90day_on_renewal,    
    from_unixtime(unix_timestamp()) as creation_timestamp
from (
select d_month.d_date,
 		list.contract_id,
		list.contract_no,
		list.accounted_date,
		list.contract_money,
		list.income_money,
		list.contract_start_date,
		list.contract_expire_date,
		list.contract_status,
		list.contract_type,
		list.contract_sign_date,
		list.before_contract_id,
		list.before_contract_no,
		list.before_accounted_date,
		list.before_contract_money,
		list.before_contract_expire_date,
		list.before_income_money,
		list.next_contract_id,
		list.next_contract_no,
		list.next_accounted_date,
		list.next_contract_money,
		list.next_contract_expire_date,
		list.next_income_money,
		list.sign_id,
		list.sign_name,
		list.sign_group,
		list.sign_branch,
		list.customer_id,
		list.customer_name,
		list.customer_source,
		list.customer_dq,
		list.customer_industry,
		list.customer_main_industry,
		list.companyscale,
		list.companykind,
		list.sales_id,
		list.sales_name,
		list.sales_org,
		list.sales_branch,
		list.serviceuser_id,
		list.serviceuser_name,
		list.serviceuser_group,
		list.customer_valid_reason, 
		list.repertory_level,   
         case when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) then 1 else 0 end as is_expire,       
         case when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) and substr(list.contract_expire_date,1,6) > substr(list.next_accounted_date,1,6) and list.next_accounted_date > 0 then 1 else 0 end as is_expire_pre_renewal,
         case when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) and substr(list.contract_expire_date,1,6) = substr(list.next_accounted_date,1,6) and list.next_accounted_date <= d_month.d_date then 1 else 0 end as is_expire_renewal,
         case when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) and (list.next_accounted_date = 0 or list.next_accounted_date > d_month.d_date) then 1 else 0 end as is_expire_no_renewal,
         case when substr(list.contract_expire_date,1,6) > substr('$date$',1,6) and substr(list.next_accounted_date,1,6) = substr('$date$',1,6) and list.next_accounted_date <= d_month.d_date then 1 else 0 end as is_pre_expire_renewal,
         case when substr(list.contract_expire_date,1,6) < substr('$date$',1,6) and substr(list.next_accounted_date,1,6) = substr('$date$',1,6) and list.next_accounted_date <= d_month.d_date then 1 else 0 end as is_on_expire_renewal,
         case when list.contract_expire_date between d_month_start_3m and d_month_end_3m and substr(list.next_accounted_date,1,6) = substr('$date$',1,6) then 1 else 0 end as is_90day_on_expire_renewal,
         0 as is_expire_90day_on_renewal
    from dw_erp_d_sales_contract_list list 
    join 
    (select d_date,
           substr(d_date,1,6) as d_month,
           regexp_replace(concat(substr(date_format,1,7),'-','01'),'-','') as d_month_start,
           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end,
           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-3),'-','') as d_month_start_3m,
           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-1),'-','') as d_month_end_3m
    from dim_date 
    where d_date <= '$date$'
      and substr(d_date,1,6) = substr('$date$',1,6)
    ) d_month on 1=1
    where list.p_date = '$date$'
      and (substr(list.contract_expire_date,1,6) = substr('$date$',1,6) or substr(list.next_accounted_date,1,6) = substr('$date$',1,6))
  union all    
  --历史过期
select d_month.d_month_end as d_date,
 		list.contract_id,
		list.contract_no,
		list.accounted_date,
		list.contract_money,
		list.income_money,
		list.contract_start_date,
		list.contract_expire_date,
		list.contract_status,
		list.contract_type,
		list.contract_sign_date,
		list.before_contract_id,
		list.before_contract_no,
		list.before_accounted_date,
		list.before_contract_money,
		list.before_contract_expire_date,
		list.before_income_money,
		list.next_contract_id,
		list.next_contract_no,
		list.next_accounted_date,
		list.next_contract_money,
		list.next_contract_expire_date,
		list.next_income_money,
		list.sign_id,
		list.sign_name,
		list.sign_group,
		list.sign_branch,
		list.customer_id,
		list.customer_name,
		list.customer_source,
		list.customer_dq,
		list.customer_industry,
		list.customer_main_industry,
		list.companyscale,
		list.companykind,
		list.sales_id,
		list.sales_name,
		list.sales_org,
		list.sales_branch,
		list.serviceuser_id,
		list.serviceuser_name,
		list.serviceuser_group,
		list.customer_valid_reason, 
		list.repertory_level,  
          1 as is_expire,
         case when substr(list.contract_expire_date,1,6) > substr(list.next_accounted_date,1,6) and list.next_accounted_date > 0 then 1 else 0 end as is_expire_pre_renewal,
         case when substr(list.contract_expire_date,1,6) = substr(list.next_accounted_date,1,6) then 1 else 0 end as is_expire_renewal,
         case when substr(list.next_accounted_date,1,6) = 0 or substr(list.contract_expire_date,1,6) < substr(list.next_accounted_date,1,6) then 1 else 0 end as is_expire_no_renewal,
         0 as is_pre_expire_renewal,
         0 as is_on_expire_renewal,
         0 as is_90day_on_expire_renewal,
         case when list.next_accounted_date between d_month_start_3m_next and d_month_end_3m_next then 1 else 0 end as is_expire_90day_on_renewal
    from dw_erp_d_sales_contract_list list 
    join 
    (select substr(d_date,1,6) as d_month,
           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end,
           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-3),'-','') as d_month_start_3m,
           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-1),'-','') as d_month_end_3m,
           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),1),'-','') as d_month_start_3m_next,
           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),3),'-','') as d_month_end_3m_next           
      from dim_date 
      where d_date = regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','')
      and substr(d_date,1,6) < substr('$date$',1,6)
    ) d_month on substr(list.contract_expire_date,1,6) = d_month.d_month
    where list.p_date = '$date$'
  union all 
  --历史续约
  select d_month.d_month_end as d_date,
  		list.contract_id,
		list.contract_no,
		list.accounted_date,
		list.contract_money,
		list.income_money,
		list.contract_start_date,
		list.contract_expire_date,
		list.contract_status,
		list.contract_type,
		list.contract_sign_date,
		list.before_contract_id,
		list.before_contract_no,
		list.before_accounted_date,
		list.before_contract_money,
		list.before_contract_expire_date,
		list.before_income_money,
		list.next_contract_id,
		list.next_contract_no,
		list.next_accounted_date,
		list.next_contract_money,
		list.next_contract_expire_date,
		list.next_income_money,
		list.sign_id,
		list.sign_name,
		list.sign_group,
		list.sign_branch,
		list.customer_id,
		list.customer_name,
		list.customer_source,
		list.customer_dq,
		list.customer_industry,
		list.customer_main_industry,
		list.companyscale,
		list.companykind,
		list.sales_id,
		list.sales_name,
		list.sales_org,
		list.sales_branch,
		list.serviceuser_id,
		list.serviceuser_name,
		list.serviceuser_group,
		list.customer_valid_reason, 
		list.repertory_level, 
         0 as is_expire,
         0 as is_expire_pre_renewal,
         case when substr(list.contract_expire_date,1,6) = substr(list.next_accounted_date,1,6) then 1 else 0 end as is_expire_renewal,  
         0 as is_expire_no_renewal,
         case when substr(list.contract_expire_date,1,6) > substr(list.next_accounted_date,1,6) then 1 else 0 end as is_pre_expire_renewal,
         case when substr(list.contract_expire_date,1,6) < substr(list.next_accounted_date,1,6) then 1 else 0 end as is_on_expire_renewal,
         case when list.contract_expire_date between d_month_start_3m and d_month_end_3m then 1 else 0 end as is_90day_on_expire_renewal,
         0 as is_expire_90day_on_renewal
    from dw_erp_d_sales_contract_list list 
    join 
    (select substr(d_date,1,6) as d_month,
           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end,
           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-3),'-','') as d_month_start_3m,
           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-1),'-','') as d_month_end_3m
    from dim_date 
    where d_date = regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','')
      and substr(d_date,1,6) < substr('$date$',1,6)
    ) d_month on substr(list.next_accounted_date,1,6) = d_month.d_month
    where list.p_date = '$date$' 
) base1 
group by 
base1.d_date,
base1.contract_id,
base1.contract_no,
base1.accounted_date,
base1.contract_money,
base1.income_money,
base1.contract_start_date,
base1.contract_expire_date,
base1.contract_status,
base1.contract_type,
base1.contract_sign_date,
base1.before_contract_id,
base1.before_contract_no,
base1.before_accounted_date,
base1.before_contract_money,
base1.before_contract_expire_date,
base1.before_income_money,
base1.next_contract_id,
base1.next_contract_no,
base1.next_accounted_date,
base1.next_contract_money,
base1.next_contract_expire_date,
base1.next_income_money,
base1.sign_id,
base1.sign_name,
base1.sign_group,
base1.sign_branch,
base1.customer_id,
base1.customer_name,
base1.customer_source,
base1.customer_dq,
base1.customer_industry,
base1.customer_main_industry,
base1.companyscale,
base1.companykind,
base1.sales_id,
base1.sales_name,
base1.sales_org,
base1.sales_branch,
base1.serviceuser_id,
base1.serviceuser_name,
base1.serviceuser_group,
base1.customer_valid_reason, 
base1.repertory_level;

CREATE TABLE dw_erp_a_sales_renewal_flag(
  d_date string COMMENT '统计日期', 
  contract_id string COMMENT '合同id', 
  contract_no string COMMENT '合同编号', 
  accounted_date string COMMENT '回款日期', 
  contract_money float COMMENT '合同金额', 
  income_money float COMMENT '回款金额', 
  contract_start_date string COMMENT '服务生效日期', 
  contract_expire_date string COMMENT '服务失效日期', 
  contract_status string COMMENT '合同状态', 
  contract_type string COMMENT '合同类型', 
  contract_sign_date string COMMENT '合同签约日期', 
  before_contract_id string COMMENT '上一份合同id', 
  before_contract_no string COMMENT '上一份合同编号', 
  before_accounted_date string COMMENT '上一份合同回款日期', 
  before_contract_money float COMMENT '上一份合同金额', 
  before_contract_expire_date string COMMENT '上一份合同到期日期', 
  before_income_money float COMMENT '上一份合同回款金额', 
  next_contract_id string COMMENT '下一份合同id', 
  next_contract_no string COMMENT '下一份合同编号', 
  next_accounted_date string COMMENT '下一份合同回款日期', 
  next_contract_money float COMMENT '下一份合同金额', 
  next_contract_expire_date string COMMENT '下一份合同到期日期', 
  next_income_money float COMMENT '下一份合同回款金额', 
  sign_id string COMMENT '签约销售id', 
  sign_name string COMMENT '签约销售名称', 
  sign_group string COMMENT '签约销售小组', 
  sign_branch string COMMENT '签约销售分公司', 
  customer_id string COMMENT '客户id', 
  customer_name string COMMENT '客户名称', 
  customer_source string COMMENT '客户来源', 
  customer_dq string COMMENT '客户地区', 
  customer_industry string COMMENT '客户行业', 
  customer_main_industry string COMMENT '客户大行业', 
  companyscale string COMMENT '客户企业规模', 
  companykind string COMMENT '客户企业性质', 
  sales_id string COMMENT '客户所属销售id', 
  sales_name string COMMENT '客户所属销售名称', 
  sales_org string COMMENT '客户所属销售小组', 
  sales_branch string COMMENT '客户所属销售小组', 
  serviceuser_id string COMMENT '客户所属招服id', 
  serviceuser_name string COMMENT '客户所属招服名称', 
  serviceuser_group string COMMENT '客户所属招服小组', 
  customer_valid_reason string COMMENT '客户无效原因', 
  repertory_level int COMMENT '深耕级别', 
  is_expire int COMMENT '是否当月过期客户', 
  is_expire_pre_renewal int COMMENT '是否当月过期提前续约客户', 
  is_expire_renewal int COMMENT '是否当月过期当月续约客户', 
  is_expire_no_renewal int COMMENT '是否当月过期未续约客户', 
  is_pre_expire_renewal int COMMENT '是否未过期提前本月续约客户', 
  is_on_expire_renewal int COMMENT '是否断约挽回客户', 
  is_90day_on_expire_renewal int COMMENT '是否前三个月内到期在本月续约客户', 
  is_expire_90day_on_renewal int COMMENT '是否本月到期且在未来3个月内续约客户', 
  creation_timestamp string COMMENT '时间戳')
COMMENT '客户新签lpt合同明细表-用于销售计算续约率-分子分母标识';

CREATE TABLE dw_erp_a_sales_renewal_flag(
d_date int comment '统计日期',
contract_id varchar(100) comment '合同ID',
contract_no varchar(100) comment '合同编号',
accounted_date varchar(30) comment '回款日期',
contract_money float comment '合同金额',
income_money float comment '回款金额',
contract_start_date varchar(30) comment '服务生效日期',
contract_expire_date varchar(30) comment '服务失效日期',
contract_status varchar(30) comment '合同状态',
contract_type varchar(30) comment '合同类型',
contract_sign_date varchar(30) comment '合同签约日期',
before_contract_id varchar(100) comment '上一份合同ID',
before_contract_no varchar(100) comment '上一份合同编号',
before_accounted_date varchar(30) comment '上一份合同回款日期',
before_contract_money float comment '上一份合同金额',
before_contract_expire_date varchar(30) comment '上一份合同到期日期',
before_income_money float comment '上一份合同回款金额',
next_contract_id varchar(100) comment '下一份合同ID',
next_contract_no varchar(100) comment '下一份合同编号',
next_accounted_date varchar(30) comment '下一份合同回款日期',
next_contract_money float comment '下一份合同金额',
next_contract_expire_date varchar(30) comment '下一份合同到期日期',
next_income_money float comment '下一份合同回款金额',
sign_id varchar(30) comment '签约销售ID',
sign_name varchar(100) comment '签约销售名称',
sign_group varchar(200) comment '签约销售小组',
sign_branch varchar(100) comment '签约销售分公司',
customer_id varchar(30) comment '客户ID',
customer_name varchar(200) comment '客户名称',
customer_source varchar(30) comment '客户来源',
customer_dq varchar(100) comment '客户地区',
customer_industry varchar(100) comment '客户行业',
customer_main_industry varchar(100) comment '客户大行业',
companyscale varchar(100) comment '客户企业规模',
companykind varchar(100) comment '客户企业性质',
sales_id varchar(30) comment '客户所属销售ID',
sales_name varchar(100) comment '客户所属销售名称',
sales_org varchar(200) comment '客户所属销售小组',
sales_branch varchar(100) comment '客户所属销售小组',
serviceuser_id varchar(30) comment '客户所属招服ID',
serviceuser_name varchar(100) comment '客户所属招服名称',
serviceuser_group varchar(200) comment '客户所属招服小组',
customer_valid_reason varchar(100) comment '客户无效原因',
repertory_level int comment '深耕级别',
is_expire int comment '是否当月过期客户',
is_expire_pre_renewal int comment '是否当月过期提前续约客户',
is_expire_renewal int comment '是否当月过期当月续约客户',
is_expire_no_renewal int comment '是否当月过期未续约客户',
is_pre_expire_renewal int comment '是否未过期提前本月续约客户',
is_on_expire_renewal int comment '是否断约挽回客户',
is_90day_on_expire_renewal int comment '是否前三个月内到期在本月续约客户',
is_expire_90day_on_renewal int comment '是否本月到期且在未来3个月内续约客户',
creation_timestamp timestamp COMMENT '时间戳',
primary key (d_date,contract_id,customer_id))
COMMENT '客户新签lpt合同明细表-用于销售计算续约率-分子分母标识';

insert overwrite table dw_erp_a_sales_renewal_flag 
select d_date, contract_id, contract_no, accounted_date, contract_money, income_money, contract_start_date, contract_expire_date, contract_status, contract_type, contract_sign_date, before_contract_id, before_contract_no, before_accounted_date, before_contract_money, before_contract_expire_date, before_income_money, next_contract_id, next_contract_no, next_accounted_date, next_contract_money, next_contract_expire_date, next_income_money, sign_id, sign_name, sign_group, sign_branch, customer_id, customer_name, customer_source, customer_dq, customer_industry, customer_main_industry, companyscale, companykind, sales_id, sales_name, sales_org, sales_branch, serviceuser_id, serviceuser_name, serviceuser_group, customer_valid_reason, repertory_level, is_expire, is_expire_pre_renewal, is_expire_renewal, is_expire_no_renewal, is_pre_expire_renewal, is_on_expire_renewal, is_90day_on_expire_renewal, is_expire_90day_on_renewal, 
current_timestamp as creation_timestamp
from dw_erp_d_sales_renewal_flag
where p_date = $date$




--head:"月份	级别	城市	当期到期金额	当期到期合同数	当期到期已经提前续约的到期金额	当期到期已经提前续约的期合同数	当期未到期提前在当期续约的到期金额	当期未到期提前在当期续约的续约金额	当期未到期提前在当期续约的合同数	当期到期当期续约的续约金额	当期到期当期续约的合同数	前90天内到期在当期续约的到期金额	前90天内到期在当期续约的续约金额	前90天内到期在当期续约的合同数	合内单数续约率	合内金额续约率	90天单数续约率	90天金额续约率	前1-12月回款金额	前13-24月回款金额	12月滚动金额续约率	本月内到期在本月之后（N+1~N+3)月内续约的合同数	本月内到期，在本月之后（N+1~N+3)月内续约的合同新签约金额	当期到期已经提前续约的续约金额	90天单数续约率(以当月到期合同为总样本）	90天金额续约率(以当月到期合同为总样本）"

select 
substr(renewal.d_date,1,6) as d_month,
renewal.r_level,
renewal.sales_branch,
sum(expire_contract_money) as expire_contract_money,
sum(expire_cust_cnt) as expire_cust_cnt,
sum(expire_pre_renewal_contract_money) as expire_pre_renewal_contract_money,
sum(expire_pre_renewal_cust_cnt) as expire_pre_renewal_cust_cnt,
sum(pre_expire_renewal_contract_money) as pre_expire_renewal_contract_money,
sum(pre_expire_renewal_money) as pre_expire_renewal_money,
sum(pre_expire_renewal_cust_cnt) as pre_expire_renewal_cust_cnt,
sum(expire_renewal_money) as expire_renewal_money,
sum(expire_renewal_cust_cnt) as expire_renewal_cust_cnt,
sum(day90_on_expire_renewal_contract_money) as day90_on_expire_renewal_contract_money,
sum(day90_on_expire_renewal_money) as day90_on_expire_renewal_money,
sum(day90_on_expire_renewal_cust_cnt) as day90_on_expire_renewal_cust_cnt,
sum(renewal_cnt_ratio) as renewal_cnt_ratio,
sum(renewal_money_ratio) as renewal_money_ratio,
sum(day90_renewal_cnt_ratio) as day90_renewal_cnt_ratio,
sum(day90_renewal_money_ratio) as day90_renewal_money_ratio,
sum(m12_roll_renewal_dm) as m12_roll_renewal_dm,
sum(m12_roll_renewal_nm) as m12_roll_renewal_nm,
sum(m12_roll_renewal_ratio) as m12_roll_renewal_ratio,
sum(expire_90day_on_renewal_cust_cnt) as expire_90day_on_renewal_cust_cnt,
sum(expire_90day_on_renewal_money) as expire_90day_on_renewal_money,
sum(expire_pre_renewal_money) as expire_pre_renewal_money,
sum(day90_expire_cnt_ratio) as day90_expire_cnt_ratio,
sum(day90_expire_money_ratio) as day90_expire_money_ratio
from (

	select  d_date,
	case  repertory_level when 0 then 'S' when 1  then 'SS' when 2 then 'KA' when 3 then 'JS' else '其他' end as r_level,
	sales_branch,
	sum(is_expire*contract_money) as expire_contract_money,
	sum(is_expire) as expire_cust_cnt,
	sum(is_expire_pre_renewal*contract_money) as expire_pre_renewal_contract_money,
	sum(is_expire_pre_renewal) as expire_pre_renewal_cust_cnt,
	sum(is_pre_expire_renewal*contract_money) as pre_expire_renewal_contract_money,
	sum(is_pre_expire_renewal*next_contract_money) as pre_expire_renewal_money,
	sum(is_pre_expire_renewal) as pre_expire_renewal_cust_cnt,
	sum(is_expire_renewal*next_contract_money) as expire_renewal_money,
	sum(is_expire_renewal) as expire_renewal_cust_cnt,
	sum(is_90day_on_expire_renewal*contract_money) as day90_on_expire_renewal_contract_money,
	sum(is_90day_on_expire_renewal*next_contract_money) as day90_on_expire_renewal_money,
	sum(is_90day_on_expire_renewal) as day90_on_expire_renewal_cust_cnt,
	sum(is_expire_pre_renewal*next_contract_money) as expire_pre_renewal_money,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as renewal_cnt_ratio,
	(sum(is_expire_renewal*next_contract_money) + sum(is_pre_expire_renewal*next_contract_money) ) / (sum(is_expire*contract_money) + sum(is_pre_expire_renewal*contract_money) - sum(is_expire_pre_renewal*contract_money)) as renewal_money_ratio,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) + sum(is_90day_on_expire_renewal)) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)+ sum(is_90day_on_expire_renewal)) as day90_renewal_cnt_ratio,
	(sum(is_expire_renewal*next_contract_money) + sum(is_pre_expire_renewal*next_contract_money)+ sum(is_90day_on_expire_renewal*next_contract_money) ) / (sum(is_expire*contract_money) + sum(is_pre_expire_renewal*contract_money) - sum(is_expire_pre_renewal*contract_money)+ sum(is_90day_on_expire_renewal*contract_money) ) as day90_renewal_money_ratio,
	sum(is_expire_90day_on_renewal) as expire_90day_on_renewal_cust_cnt,
	sum(is_expire_90day_on_renewal*next_contract_money) as expire_90day_on_renewal_money,
	(sum(is_expire_renewal) + sum(is_expire_pre_renewal) + sum(is_expire_90day_on_renewal)) / sum(is_expire) as day90_expire_cnt_ratio,
	(sum(is_expire_renewal*next_contract_money) + sum(is_expire_pre_renewal*next_contract_money) + sum(is_expire_90day_on_renewal*next_contract_money)) / sum(is_expire*contract_money) as day90_expire_money_ratio,
	0 as m12_roll_renewal_dm,
	0 as m12_roll_renewal_nm,
	0 as m12_roll_renewal_ratio
	from dw_erp_d_sales_renewal_flag
	where p_date = 20170424
	and d_date < concat(substr('20170424',1,6),'01')
	group by  d_date,repertory_level,sales_branch

	union all 

	select nm.d_date,
		case  nm.repertory_level when 0 then 'S' when 1  then 'SS' when 2 then 'KA' when 3 then 'JS' else '其他' end as r_level,
		nm.sales_branch,
		0 as expire_contract_money,
		0 as expire_cust_cnt,
		0 as expire_pre_renewal_contract_money,
		0 as expire_pre_renewal_cust_cnt,
		0 as pre_expire_renewal_contract_money,
		0 as pre_expire_renewal_money,
		0 as pre_expire_renewal_cust_cnt,
		0 as expire_renewal_money,
		0 as expire_renewal_cust_cnt,
		0 as day90_on_expire_renewal_contract_money,
		0 as day90_on_expire_renewal_money,
		0 as day90_on_expire_renewal_cust_cnt,
		0 as expire_pre_renewal_money,
		0 as renewal_cnt_ratio,
		0 as renewal_money_ratio,
		0 as day90_renewal_cnt_ratio,
		0 as day90_renewal_money_ratio,
		0 as expire_90day_on_renewal_cust_cnt,
		0 as expire_90day_on_renewal_money,
		0 as day90_expire_cnt_ratio,
		0 as day90_expire_money_ratio,
		nvl(sum(dm.income_money),0) as m12_roll_renewal_dm,
		sum(nm.income_money) as m12_roll_renewal_nm,
		nvl(sum(dm.income_money),0)/sum(nm.income_money) as m12_roll_renewal_ratio
	from 
	(select d_month.d_date,list.customer_id,list.repertory_level,list.sales_branch,sum(list.income_money) as income_money
	from dw_erp_d_sales_contract_list list
	join 
	    (select substr(d_date,1,6) as d_month,
	    		d_date,
	           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end,
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-1),'-','') as d_month_start_1m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-12),'-','') as d_month_end_12m,          
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-13),'-','') as d_month_start_13m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-24),'-','') as d_month_end_24m
	    from dim_date 
	    where d_date < concat(substr('20170424',1,6),'01')
	      and d_date > 20130101
	      and d_date = regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','')
	    ) d_month
	on 1=1
	where list.p_date = 20170424
	and list.d_date between d_month.d_month_end_24m and d_month.d_month_start_13m
	group by d_month.d_date,list.customer_id,list.repertory_level,list.sales_branch
	) nm 
	left join 
	(select d_month.d_date,list.customer_id,list.repertory_level,list.sales_branch,sum(list.income_money) as income_money
	from dw_erp_d_sales_contract_list list
	join 
	    (select substr(d_date,1,6) as d_month,d_date,
	           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end,
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-1),'-','') as d_month_start_1m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-12),'-','') as d_month_end_12m,           
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-13),'-','') as d_month_start_13m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-24),'-','') as d_month_end_24m
	    from dim_date 
	    where d_date < concat(substr('20170424',1,6),'01')
	      and d_date > 20130101
	      and d_date = regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','')
	    ) d_month
	 on 1=1
	where list.p_date = 20170424
	and list.d_date between d_month.d_month_end_12m and d_month.d_month_start_1m
	group by d_month.d_date,list.customer_id,list.repertory_level,list.sales_branch
	) dm 
	on nm.customer_id = dm.customer_id
	and nm.d_date = dm.d_date
	group by  nm.d_date,nm.repertory_level,nm.sales_branch
) renewal
group by renewal.d_date,renewal.r_level,renewal.sales_branch;



--head:"月份	总监	城市	当期到期金额	当期到期合同数	当期到期已经提前续约的到期金额	当期到期已经提前续约的期合同数	当期未到期提前在当期续约的到期金额	当期未到期提前在当期续约的续约金额	当期未到期提前在当期续约的合同数	当期到期当期续约的续约金额	当期到期当期续约的合同数	前90天内到期在当期续约的到期金额	前90天内到期在当期续约的续约金额	前90天内到期在当期续约的合同数	合内单数续约率	合内金额续约率	90天单数续约率	90天金额续约率	前1-12月回款金额	前13-24月回款金额	12月滚动金额续约率	本月内到期在本月之后（N+1~N+3)月内续约的合同数	本月内到期，在本月之后（N+1~N+3)月内续约的合同新签约金额	当期到期已经提前续约的续约金额	90天单数续约率(以当月到期合同为总样本）	90天金额续约率(以当月到期合同为总样本）"
	
select 
substr(renewal.d_date,1,6) as d_date,
renewal.sd_name,
renewal.sales_branch,
sum(expire_contract_money) as expire_contract_money,
sum(expire_cust_cnt) as expire_cust_cnt,
sum(expire_pre_renewal_contract_money) as expire_pre_renewal_contract_money,
sum(expire_pre_renewal_cust_cnt) as expire_pre_renewal_cust_cnt,
sum(pre_expire_renewal_contract_money) as pre_expire_renewal_contract_money,
sum(pre_expire_renewal_money) as pre_expire_renewal_money,
sum(pre_expire_renewal_cust_cnt) as pre_expire_renewal_cust_cnt,
sum(expire_renewal_money) as expire_renewal_money,
sum(expire_renewal_cust_cnt) as expire_renewal_cust_cnt,
sum(day90_on_expire_renewal_contract_money) as day90_on_expire_renewal_contract_money,
sum(day90_on_expire_renewal_money) as day90_on_expire_renewal_money,
sum(day90_on_expire_renewal_cust_cnt) as day90_on_expire_renewal_cust_cnt,
sum(renewal_cnt_ratio) as renewal_cnt_ratio,
sum(renewal_money_ratio) as renewal_money_ratio,
sum(day90_renewal_cnt_ratio) as day90_renewal_cnt_ratio,
sum(day90_renewal_money_ratio) as day90_renewal_money_ratio,
sum(m12_roll_renewal_dm) as m12_roll_renewal_dm,
sum(m12_roll_renewal_nm) as m12_roll_renewal_nm,
sum(m12_roll_renewal_ratio) as m12_roll_renewal_ratio,
sum(expire_90day_on_renewal_cust_cnt) as expire_90day_on_renewal_cust_cnt,
sum(expire_90day_on_renewal_money) as expire_90day_on_renewal_money,
sum(expire_pre_renewal_money) as expire_pre_renewal_money,
sum(day90_expire_cnt_ratio) as day90_expire_cnt_ratio,
sum(day90_expire_money_ratio) as day90_expire_money_rati
from (

	select  
	flag.d_date,
	coalesce(sd.sr_sd_name,sd.sd_name) as sd_name,
	sales_branch,
	sum(is_expire*contract_money) as expire_contract_money,
	sum(is_expire) as expire_cust_cnt,
	sum(is_expire_pre_renewal*contract_money) as expire_pre_renewal_contract_money,
	sum(is_expire_pre_renewal) as expire_pre_renewal_cust_cnt,
	sum(is_pre_expire_renewal*contract_money) as pre_expire_renewal_contract_money,
	sum(is_pre_expire_renewal*next_contract_money) as pre_expire_renewal_money,
	sum(is_pre_expire_renewal) as pre_expire_renewal_cust_cnt,
	sum(is_expire_renewal*next_contract_money) as expire_renewal_money,
	sum(is_expire_renewal) as expire_renewal_cust_cnt,
	sum(is_90day_on_expire_renewal*contract_money) as day90_on_expire_renewal_contract_money,
	sum(is_90day_on_expire_renewal*next_contract_money) as day90_on_expire_renewal_money,
	sum(is_90day_on_expire_renewal) as day90_on_expire_renewal_cust_cnt,
	sum(is_expire_pre_renewal*next_contract_money) as expire_pre_renewal_money,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as renewal_cnt_ratio,
	(sum(is_expire_renewal*next_contract_money) + sum(is_pre_expire_renewal*next_contract_money) ) / (sum(is_expire*contract_money) + sum(is_pre_expire_renewal*contract_money) - sum(is_expire_pre_renewal*contract_money)) as renewal_money_ratio,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) + sum(is_90day_on_expire_renewal)) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)+ sum(is_90day_on_expire_renewal)) as day90_renewal_cnt_ratio,
	(sum(is_expire_renewal*next_contract_money) + sum(is_pre_expire_renewal*next_contract_money)+ sum(is_90day_on_expire_renewal*next_contract_money) ) / (sum(is_expire*contract_money) + sum(is_pre_expire_renewal*contract_money) - sum(is_expire_pre_renewal*contract_money)+ sum(is_90day_on_expire_renewal*contract_money) ) as day90_renewal_money_ratio,
	sum(is_expire_90day_on_renewal) as expire_90day_on_renewal_cust_cnt,
	sum(is_expire_90day_on_renewal*next_contract_money) as expire_90day_on_renewal_money,
	(sum(is_expire_renewal) + sum(is_expire_pre_renewal) + sum(is_expire_90day_on_renewal)) / sum(is_expire) as day90_expire_cnt_ratio,
	(sum(is_expire_renewal*next_contract_money) + sum(is_expire_pre_renewal*next_contract_money) + sum(is_expire_90day_on_renewal*next_contract_money)) / sum(is_expire*contract_money) as day90_expire_money_ratio,
	0 as m12_roll_renewal_dm,
	0 as m12_roll_renewal_nm,
	0 as m12_roll_renewal_ratio
	from dw_erp_d_sales_renewal_flag flag 
	left join dw_erp_d_salesuser_to_sd sd 
	on flag.sales_id = sd.id 
	and sd.p_date = 20170424
	where flag.p_date = 20170424
	and flag.d_date  < concat(substr('20170424',1,6),'01')
	group by  flag.d_date,sd.sd_name,sd.sr_sd_name,sales_branch
	grouping sets ((flag.d_date,sd.sr_sd_name,sales_branch),(flag.d_date,sd.sd_name,sales_branch))

	union all 

	select 
		nm.d_date,
		coalesce(sd.sr_sd_name,sd.sd_name) as sd_name,
		nm.sales_branch,
		0 as expire_contract_money,
		0 as expire_cust_cnt,
		0 as expire_pre_renewal_contract_money,
		0 as expire_pre_renewal_cust_cnt,
		0 as pre_expire_renewal_contract_money,
		0 as pre_expire_renewal_money,
		0 as pre_expire_renewal_cust_cnt,
		0 as expire_renewal_money,
		0 as expire_renewal_cust_cnt,
		0 as day90_on_expire_renewal_contract_money,
		0 as day90_on_expire_renewal_money,
		0 as day90_on_expire_renewal_cust_cnt,
		0 as expire_pre_renewal_money,
		0 as renewal_cnt_ratio,
		0 as renewal_money_ratio,
		0 as day90_renewal_cnt_ratio,
		0 as day90_renewal_money_ratio,
		0 as expire_90day_on_renewal_cust_cnt,
		0 as expire_90day_on_renewal_money,
		0 as day90_expire_cnt_ratio,
		0 as day90_expire_money_ratio,
		nvl(sum(dm.income_money),0) as m12_roll_renewal_dm,
		sum(nm.income_money) as m12_roll_renewal_nm,
		nvl(sum(dm.income_money),0)/sum(nm.income_money) as m12_roll_renewal_ratio
	from 
	(select d_month.d_date,list.customer_id,list.sales_id,list.sales_branch,sum(list.income_money) as income_money
	from dw_erp_d_sales_contract_list list
	join 
	    (select substr(d_date,1,6) as d_month,d_date,
	           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end,
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-1),'-','') as d_month_start_1m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-12),'-','') as d_month_end_12m,          
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-13),'-','') as d_month_start_13m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-24),'-','') as d_month_end_24m
	     from dim_date 
	    where d_date < concat(substr('20170424',1,6),'01')
	      and d_date > 20130101
	      and d_date = regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','')
	    ) d_month
	 on 1=1
	where list.p_date = 20170424
	and list.d_date between d_month.d_month_end_24m and d_month.d_month_start_13m
	group by d_month.d_date,list.customer_id,list.sales_id,list.sales_branch
	) nm 
	left join 
	(select d_month.d_date,list.customer_id,list.sales_id,list.sales_branch,sum(list.income_money) as income_money
	from dw_erp_d_sales_contract_list list 
	join 
	    (select substr(d_date,1,6) as d_month,d_date,
	           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end,
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-1),'-','') as d_month_start_1m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-12),'-','') as d_month_end_12m,           
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-13),'-','') as d_month_start_13m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-24),'-','') as d_month_end_24m
	     from dim_date 
	    where d_date < concat(substr('20170424',1,6),'01')
	      and d_date > 20130101
	      and d_date = regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','')
	    ) d_month
	 on 1=1
	where list.p_date = 20170424
	and list.d_date between d_month.d_month_end_12m and d_month.d_month_start_1m
	group by d_month.d_date,list.customer_id,list.sales_id,list.sales_branch
	) dm 
	on nm.customer_id = dm.customer_id
	and nm.d_date = dm.d_date
	left join dw_erp_d_salesuser_to_sd sd 
	on nm.sales_id =  sd.id
	and sd.p_date = 20170424
	group by  nm.d_date,sd.sd_name,sd.sr_sd_name,nm.sales_branch
	grouping sets ((nm.d_date,sd.sr_sd_name,nm.sales_branch),(nm.d_date,sd.sd_name,nm.sales_branch))
) renewal
group by renewal.d_date,renewal.sd_name,renewal.sales_branch
having nvl(renewal.sd_name,'未知') not in ('未知','-1') 
;


--head:"月份	总监	城市	当期到期金额	当期到期合同数	当期到期已经提前续约的到期金额	当期到期已经提前续约的期合同数	当期未到期提前在当期续约的到期金额	当期未到期提前在当期续约的续约金额	当期未到期提前在当期续约的合同数	当期到期当期续约的续约金额	当期到期当期续约的合同数	合内单数续约率	合内金额续约率"

select 
	coalesce(sd.sr_sd_name,sd.sd_name) as sd_name,
	sales_branch,
	sum(is_expire*contract_money) as expire_contract_money,
	sum(is_expire) as expire_cust_cnt,
	sum(is_expire_pre_renewal*contract_money) as expire_pre_renewal_contract_money,
	sum(is_expire_pre_renewal) as expire_pre_renewal_cust_cnt,
	sum(is_pre_expire_renewal*contract_money) as pre_expire_renewal_contract_money,
	sum(is_pre_expire_renewal*next_contract_money) as pre_expire_renewal_money,
	sum(is_pre_expire_renewal) as pre_expire_renewal_cust_cnt,
	sum(is_expire_renewal*next_contract_money) as expire_renewal_money,
	sum(is_expire_renewal) as expire_renewal_cust_cnt,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as renewal_cnt_ratio,
	(sum(is_expire_renewal*next_contract_money) + sum(is_pre_expire_renewal*next_contract_money) ) / (sum(is_expire*contract_money) + sum(is_pre_expire_renewal*contract_money) - sum(is_expire_pre_renewal*contract_money)) as renewal_money_ratio
from (
	select sales_id,sales_branch,
         case when substr(list.contract_expire_date,1,6) between 201701 and 201703 then  1  else 0 end as is_expire,
         case when substr(list.contract_expire_date,1,6) between 201701 and 201703 and list.next_accounted_date > 0 and substr(list.next_accounted_date,1,6) < 201701  then 1 else 0 end as is_expire_pre_renewal,
         case when substr(list.contract_expire_date,1,6) between 201701 and 201703 and  substr(list.next_accounted_date,1,6) between 201701 and 201703 then  1  else 0 end as is_expire_renewal,
         case when substr(list.contract_expire_date,1,6) > 201703 and substr(list.next_accounted_date,1,6) between 201701 and 201703 then 1 else 0 end as is_pre_expire_renewal,
         contract_money,next_contract_money
     from dw_erp_d_sales_contract_list list 
    where list.p_date = '20170424'
) fact 
left join dw_erp_d_salesuser_to_sd sd 
on fact.sales_id =  sd.id
and sd.p_date = 20170424
group by  sd.sd_name,sd.sr_sd_name,fact.sales_branch
grouping sets ((sd.sr_sd_name,fact.sales_branch),(sd.sd_name,fact.sales_branch))
having nvl(sd_name,'未知') <> '未知' 




--head:"月份	级别	城市	当期到期金额	当期到期合同数	当期到期已经提前续约的到期金额	当期到期已经提前续约的期合同数	当期未到期提前在当期续约的到期金额	当期未到期提前在当期续约的续约金额	当期未到期提前在当期续约的合同数	当期到期当期续约的续约金额	当期到期当期续约的合同数	合内单数续约率	合内金额续约率"

select 
	case  repertory_level when 0 then 'S' when 1  then 'SS' when 2 then 'KA' when 3 then 'JS' else '其他' end as r_level,
	sales_branch,
	sum(is_expire*contract_money) as expire_contract_money,
	sum(is_expire) as expire_cust_cnt,
	sum(is_expire_pre_renewal*contract_money) as expire_pre_renewal_contract_money,
	sum(is_expire_pre_renewal) as expire_pre_renewal_cust_cnt,
	sum(is_pre_expire_renewal*contract_money) as pre_expire_renewal_contract_money,
	sum(is_pre_expire_renewal*next_contract_money) as pre_expire_renewal_money,
	sum(is_pre_expire_renewal) as pre_expire_renewal_cust_cnt,
	sum(is_expire_renewal*next_contract_money) as expire_renewal_money,
	sum(is_expire_renewal) as expire_renewal_cust_cnt,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as renewal_cnt_ratio,
	(sum(is_expire_renewal*next_contract_money) + sum(is_pre_expire_renewal*next_contract_money) ) / (sum(is_expire*contract_money) + sum(is_pre_expire_renewal*contract_money) - sum(is_expire_pre_renewal*contract_money)) as renewal_money_ratio
from (
	select repertory_level,sales_branch,
         case when substr(list.contract_expire_date,1,6) between 201701 and 201703 then  1  else 0 end as is_expire,
         case when substr(list.contract_expire_date,1,6) between 201701 and 201703 and list.next_accounted_date > 0 and substr(list.next_accounted_date,1,6) < 201701  then 1 else 0 end as is_expire_pre_renewal,
         case when substr(list.contract_expire_date,1,6) between 201701 and 201703 and  substr(list.next_accounted_date,1,6) between 201701 and 201703 then  1  else 0 end as is_expire_renewal,
         case when substr(list.contract_expire_date,1,6) > 201703 and substr(list.next_accounted_date,1,6) between 201701 and 201703 then 1 else 0 end as is_pre_expire_renewal,
         contract_money,next_contract_money
     from dw_erp_d_sales_contract_list list 
    where list.p_date = '20170424'
) fact 
group by repertory_level,sales_branch;




create table temp_salesuser_to_manager
(
sales_name string comment '销售姓名',
td_code string comment '考勤卡号（同道码）',
org_name string comment '机构全名',
branch_name string comment '城市',
sales_manager_name string comment '销售经理',
sales_level string comment '级别'
) comment '201703销售与经理对应关系表';


select base.id,base.name,base.org_name,parent_salesuser_id,parent_salesuser_name,sm.sales_manager_name,sm.branch_name
from dw_erp_d_salesuser_base base 
join temp_salesuser_to_manager sm 
on base.name = sm.sales_name
and base.org_name = sm.org_name
where base.p_date = 20170507


select base.id,base.name,sm.branch_name,sm.sales_manager_name
from temp_salesuser_to_manager sm 
join dw_erp_d_salesuser_base base 
on base.name = sm.sales_name
and regexp_replace(base.org_name,'-','') = regexp_replace(sm.org_name,'/','')
and base.p_date = 20170331






--TL粒度数据
select 
renewal.d_date,renewal.branch_name,renewal.tl_name,
sum(expire_contract_money) as expire_contract_money,
sum(expire_cust_cnt) as expire_cust_cnt,
sum(expire_pre_renewal_contract_money) as expire_pre_renewal_contract_money,
sum(expire_pre_renewal_cust_cnt) as expire_pre_renewal_cust_cnt,
sum(pre_expire_renewal_contract_money) as pre_expire_renewal_contract_money,
sum(pre_expire_renewal_money) as pre_expire_renewal_money,
sum(pre_expire_renewal_cust_cnt) as pre_expire_renewal_cust_cnt,
sum(expire_renewal_money) as expire_renewal_money,
sum(expire_renewal_cust_cnt) as expire_renewal_cust_cnt,
sum(day90_on_expire_renewal_contract_money) as day90_on_expire_renewal_contract_money,
sum(day90_on_expire_renewal_money) as day90_on_expire_renewal_money,
sum(day90_on_expire_renewal_cust_cnt) as day90_on_expire_renewal_cust_cnt,
sum(renewal_cnt_ratio) as renewal_cnt_ratio,
sum(renewal_money_ratio) as renewal_money_ratio,
sum(day90_renewal_cnt_ratio) as day90_renewal_cnt_ratio,
sum(day90_renewal_money_ratio) as day90_renewal_money_ratio,
sum(m12_roll_renewal_dm) as m12_roll_renewal_dm,
sum(m12_roll_renewal_nm) as m12_roll_renewal_nm,
sum(m12_roll_renewal_ratio) as m12_roll_renewal_ratio,
sum(expire_90day_on_renewal_cust_cnt) as expire_90day_on_renewal_cust_cnt,
sum(expire_90day_on_renewal_money) as expire_90day_on_renewal_money,
sum(expire_pre_renewal_money) as expire_pre_renewal_money,
sum(day90_expire_cnt_ratio) as day90_expire_cnt_ratio,
sum(day90_expire_money_ratio) as day90_expire_money_rati
from (
select  
	flag.d_date,
	sd.branch_name,sd.tl_name,
	sum(is_expire*income_money) as expire_contract_money,
	sum(is_expire) as expire_cust_cnt,
	sum(is_expire_pre_renewal*income_money) as expire_pre_renewal_contract_money,
	sum(is_expire_pre_renewal) as expire_pre_renewal_cust_cnt,
	sum(is_pre_expire_renewal*income_money) as pre_expire_renewal_contract_money,
	sum(is_pre_expire_renewal*next_income_money) as pre_expire_renewal_money,
	sum(is_pre_expire_renewal) as pre_expire_renewal_cust_cnt,
	sum(is_expire_renewal*next_income_money) as expire_renewal_money,
	sum(is_expire_renewal) as expire_renewal_cust_cnt,
	sum(is_90day_on_expire_renewal*income_money) as day90_on_expire_renewal_contract_money,
	sum(is_90day_on_expire_renewal*next_income_money) as day90_on_expire_renewal_money,
	sum(is_90day_on_expire_renewal) as day90_on_expire_renewal_cust_cnt,
	sum(is_expire_pre_renewal*next_income_money) as expire_pre_renewal_money,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as renewal_cnt_ratio,
	(sum(is_expire_renewal*next_income_money) + sum(is_pre_expire_renewal*next_income_money) ) / (sum(is_expire*income_money) + sum(is_pre_expire_renewal*income_money) - sum(is_expire_pre_renewal*income_money)) as renewal_money_ratio,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) + sum(is_90day_on_expire_renewal)) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)+ sum(is_90day_on_expire_renewal)) as day90_renewal_cnt_ratio,
	(sum(is_expire_renewal*next_income_money) + sum(is_pre_expire_renewal*next_income_money)+ sum(is_90day_on_expire_renewal*next_income_money) ) / (sum(is_expire*income_money) + sum(is_pre_expire_renewal*income_money) - sum(is_expire_pre_renewal*income_money)+ sum(is_90day_on_expire_renewal*income_money) ) as day90_renewal_money_ratio,
	sum(is_expire_90day_on_renewal) as expire_90day_on_renewal_cust_cnt,
	sum(is_expire_90day_on_renewal*next_income_money) as expire_90day_on_renewal_money,
	(sum(is_expire_renewal) + sum(is_expire_pre_renewal) + sum(is_expire_90day_on_renewal)) / sum(is_expire) as day90_expire_cnt_ratio,
	(sum(is_expire_renewal*next_income_money) + sum(is_expire_pre_renewal*next_income_money) + sum(is_expire_90day_on_renewal*next_income_money)) / sum(is_expire*income_money) as day90_expire_money_ratio,
	0 as m12_roll_renewal_dm,
	0 as m12_roll_renewal_nm,
	0 as m12_roll_renewal_ratio
	from dw_erp_d_sales_renewal_flag flag 
	left join (select base.id,base.name,sm.branch_name,sm.sales_manager_name as tl_name
				from temp_salesuser_to_manager sm 
				join dw_erp_d_salesuser_base base 
				on base.name = sm.sales_name
				and regexp_replace(base.org_name,'-','') = regexp_replace(sm.org_name,'/','')
				and base.p_date = 20170331
				) sd 
	on flag.sales_id = sd.id 
	where flag.p_date = 20170430
	and flag.d_date  = 20170331
	group by flag.d_date, sd.branch_name,sd.tl_name

	union all 

	select 
		nm.d_date,sd.branch_name,sd.tl_name,
		0 as expire_contract_money,
		0 as expire_cust_cnt,
		0 as expire_pre_renewal_contract_money,
		0 as expire_pre_renewal_cust_cnt,
		0 as pre_expire_renewal_contract_money,
		0 as pre_expire_renewal_money,
		0 as pre_expire_renewal_cust_cnt,
		0 as expire_renewal_money,
		0 as expire_renewal_cust_cnt,
		0 as day90_on_expire_renewal_contract_money,
		0 as day90_on_expire_renewal_money,
		0 as day90_on_expire_renewal_cust_cnt,
		0 as expire_pre_renewal_money,
		0 as renewal_cnt_ratio,
		0 as renewal_money_ratio,
		0 as day90_renewal_cnt_ratio,
		0 as day90_renewal_money_ratio,
		0 as expire_90day_on_renewal_cust_cnt,
		0 as expire_90day_on_renewal_money,
		0 as day90_expire_cnt_ratio,
		0 as day90_expire_money_ratio,
		nvl(sum(dm.income_money),0) as m12_roll_renewal_dm,
		sum(nm.income_money) as m12_roll_renewal_nm,
		nvl(sum(dm.income_money),0)/sum(nm.income_money) as m12_roll_renewal_ratio
	from 
	(select d_month.d_date,list.customer_id,list.sales_id,list.sales_branch,sum(list.income_money) as income_money
	from dw_erp_d_sales_contract_list list
	join 
	    (select substr(d_date,1,6) as d_month,d_date,
	           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end,
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-1),'-','') as d_month_start_1m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-12),'-','') as d_month_end_12m,          
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-13),'-','') as d_month_start_13m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-24),'-','') as d_month_end_24m
	     from dim_date 
	    where d_date < concat(substr('20170424',1,6),'01')
	      and d_date > 20130101
	      and d_date = regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','')
	      and d_date = 20170331
	    ) d_month
	 on 1=1
	where list.p_date = 20170430
	and list.d_date between d_month.d_month_end_24m and d_month.d_month_start_13m
	group by d_month.d_date,list.customer_id,list.sales_id,list.sales_branch
	) nm 
	left join 
	(select d_month.d_date,list.customer_id,list.sales_id,list.sales_branch,sum(list.income_money) as income_money
	from dw_erp_d_sales_contract_list list 
	join 
	    (select substr(d_date,1,6) as d_month,d_date,
	           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end,
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-1),'-','') as d_month_start_1m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-12),'-','') as d_month_end_12m,           
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-13),'-','') as d_month_start_13m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-24),'-','') as d_month_end_24m
	     from dim_date 
	    where d_date < concat(substr('20170424',1,6),'01')
	      and d_date > 20130101
	      and d_date = regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','')
	      and d_date = 20170331
	    ) d_month
	 on 1=1
	where list.p_date = 20170430
	and list.d_date between d_month.d_month_end_12m and d_month.d_month_start_1m
	group by d_month.d_date,list.customer_id,list.sales_id,list.sales_branch
	) dm 
	on nm.customer_id = dm.customer_id
	and nm.d_date = dm.d_date
	left join (select base.id,base.name,sm.branch_name,sm.sales_manager_name as tl_name
				from temp_salesuser_to_manager sm 
				join dw_erp_d_salesuser_base base 
				on base.name = sm.sales_name
				and regexp_replace(base.org_name,'-','') = regexp_replace(sm.org_name,'/','')
				and base.p_date = 20170331
				) sd  
	on nm.sales_id =  sd.id
	group by  nm.d_date,sd.branch_name,sd.tl_name
) renewal
group by renewal.d_date,renewal.branch_name,renewal.tl_name;


select 
'月份',
'总监',
'level',
'城市',
'当期到期金额',
'当期到期合同数',
'当期到期已经提前续约的到期金额',
'当期到期已经提前续约的期合同数',
'当期未到期提前在当期续约的到期金额',
'当期未到期提前在当期续约的续约金额',
'当期未到期提前在当期续约的合同数',
'当期到期当期续约的续约金额',
'当期到期当期续约的合同数',
'前90天内到期在当期续约的到期金额',
'前90天内到期在当期续约的续约金额',
'前90天内到期在当期续约的合同数',
'合内单数续约率',
'合内金额续约率',
'90天单数续约率',
'90天金额续约率',
'前1-12月回款金额',
'前13-24月回款金额',
'12月滚动金额续约率',
'本月内到期在本月之后（N+1~N+3)月内续约的合同数',
'本月内到期，在本月之后（N+1~N+3)月内续约的合同新签约金额',
'当期到期已经提前续约的续约金额',
'90天单数续约率(以当月到期合同为总样本）',
'90天金额续约率(以当月到期合同为总样本）'
from dummy;

select 
substr(renewal.d_date,1,6) as d_date,
renewal.sd_name,
sd_level,
renewal.sales_branch,
sum(expire_contract_money) as expire_contract_money,
sum(expire_cust_cnt) as expire_cust_cnt,
sum(expire_pre_renewal_contract_money) as expire_pre_renewal_contract_money,
sum(expire_pre_renewal_cust_cnt) as expire_pre_renewal_cust_cnt,
sum(pre_expire_renewal_contract_money) as pre_expire_renewal_contract_money,
sum(pre_expire_renewal_money) as pre_expire_renewal_money,
sum(pre_expire_renewal_cust_cnt) as pre_expire_renewal_cust_cnt,
sum(expire_renewal_money) as expire_renewal_money,
sum(expire_renewal_cust_cnt) as expire_renewal_cust_cnt,
sum(day90_on_expire_renewal_contract_money) as day90_on_expire_renewal_contract_money,
sum(day90_on_expire_renewal_money) as day90_on_expire_renewal_money,
sum(day90_on_expire_renewal_cust_cnt) as day90_on_expire_renewal_cust_cnt,
sum(renewal_cnt_ratio) as renewal_cnt_ratio,
sum(renewal_money_ratio) as renewal_money_ratio,
sum(day90_renewal_cnt_ratio) as day90_renewal_cnt_ratio,
sum(day90_renewal_money_ratio) as day90_renewal_money_ratio,
sum(m12_roll_renewal_dm) as m12_roll_renewal_dm,
sum(m12_roll_renewal_nm) as m12_roll_renewal_nm,
sum(m12_roll_renewal_ratio) as m12_roll_renewal_ratio,
sum(expire_90day_on_renewal_cust_cnt) as expire_90day_on_renewal_cust_cnt,
sum(expire_90day_on_renewal_money) as expire_90day_on_renewal_money,
sum(expire_pre_renewal_money) as expire_pre_renewal_money,
sum(day90_expire_cnt_ratio) as day90_expire_cnt_ratio,
sum(day90_expire_money_ratio) as day90_expire_money_rati
from (

	select  
	flag.d_date,
	coalesce(sd.sr_sd_name,sd.sd_name) as sd_name,
	sd_level,
	sd.sales_branch,
	sum(is_expire*income_money) as expire_contract_money,
	sum(is_expire) as expire_cust_cnt,
	sum(is_expire_pre_renewal*income_money) as expire_pre_renewal_contract_money,
	sum(is_expire_pre_renewal) as expire_pre_renewal_cust_cnt,
	sum(is_pre_expire_renewal*income_money) as pre_expire_renewal_contract_money,
	sum(is_pre_expire_renewal*next_income_money) as pre_expire_renewal_money,
	sum(is_pre_expire_renewal) as pre_expire_renewal_cust_cnt,
	sum(is_expire_renewal*next_income_money) as expire_renewal_money,
	sum(is_expire_renewal) as expire_renewal_cust_cnt,
	sum(is_90day_on_expire_renewal*income_money) as day90_on_expire_renewal_contract_money,
	sum(is_90day_on_expire_renewal*next_income_money) as day90_on_expire_renewal_money,
	sum(is_90day_on_expire_renewal) as day90_on_expire_renewal_cust_cnt,
	sum(is_expire_pre_renewal*next_income_money) as expire_pre_renewal_money,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as renewal_cnt_ratio,
	(sum(is_expire_renewal*next_income_money) + sum(is_pre_expire_renewal*next_income_money) ) / (sum(is_expire*income_money) + sum(is_pre_expire_renewal*income_money) - sum(is_expire_pre_renewal*income_money)) as renewal_money_ratio,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) + sum(is_90day_on_expire_renewal)) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)+ sum(is_90day_on_expire_renewal)) as day90_renewal_cnt_ratio,
	(sum(is_expire_renewal*next_income_money) + sum(is_pre_expire_renewal*next_income_money)+ sum(is_90day_on_expire_renewal*next_income_money) ) / (sum(is_expire*income_money) + sum(is_pre_expire_renewal*income_money) - sum(is_expire_pre_renewal*income_money)+ sum(is_90day_on_expire_renewal*income_money) ) as day90_renewal_money_ratio,
	sum(is_expire_90day_on_renewal) as expire_90day_on_renewal_cust_cnt,
	sum(is_expire_90day_on_renewal*next_income_money) as expire_90day_on_renewal_money,
	(sum(is_expire_renewal) + sum(is_expire_pre_renewal) + sum(is_expire_90day_on_renewal)) / sum(is_expire) as day90_expire_cnt_ratio,
	(sum(is_expire_renewal*next_income_money) + sum(is_expire_pre_renewal*next_income_money) + sum(is_expire_90day_on_renewal*next_income_money)) / sum(is_expire*income_money) as day90_expire_money_ratio,
	0 as m12_roll_renewal_dm,
	0 as m12_roll_renewal_nm,
	0 as m12_roll_renewal_ratio
	from dw_erp_d_sales_renewal_flag flag 
	left join (select id,
				is_sd,status,lp_age,
				sd_id,sr_sd_id,sr_sd_name,sd_name,branch_name as sales_branch,
				position_level,
				sales_level as sd_level
		  from dw_erp_d_salesuser_to_sd
		  where p_date = '$date$') sd 
	on flag.sales_id = sd.id 
	where flag.p_date = '$date$'
	and flag.d_date  = regexp_replace(date_add(reformat_datetime(string({{date[:6]+'01'}}),'yyyy-MM-dd'),-1),'-','')
	group by  flag.d_date,sd.sd_name,sd.sr_sd_name,sd.sales_branch,sd_level
	grouping sets ((flag.d_date,sd.sr_sd_name,sd_level,sd.sales_branch),(flag.d_date,sd.sd_name,sd_level,sd.sales_branch))

	union all 

	select 
		nm.d_date,
		coalesce(sd.sr_sd_name,sd.sd_name) as sd_name,
		sd_level,
		sd.sales_branch,
		0 as expire_contract_money,
		0 as expire_cust_cnt,
		0 as expire_pre_renewal_contract_money,
		0 as expire_pre_renewal_cust_cnt,
		0 as pre_expire_renewal_contract_money,
		0 as pre_expire_renewal_money,
		0 as pre_expire_renewal_cust_cnt,
		0 as expire_renewal_money,
		0 as expire_renewal_cust_cnt,
		0 as day90_on_expire_renewal_contract_money,
		0 as day90_on_expire_renewal_money,
		0 as day90_on_expire_renewal_cust_cnt,
		0 as expire_pre_renewal_money,
		0 as renewal_cnt_ratio,
		0 as renewal_money_ratio,
		0 as day90_renewal_cnt_ratio,
		0 as day90_renewal_money_ratio,
		0 as expire_90day_on_renewal_cust_cnt,
		0 as expire_90day_on_renewal_money,
		0 as day90_expire_cnt_ratio,
		0 as day90_expire_money_ratio,
		nvl(sum(dm.income_money),0) as m12_roll_renewal_dm,
		sum(nm.income_money) as m12_roll_renewal_nm,
		nvl(sum(dm.income_money),0)/sum(nm.income_money) as m12_roll_renewal_ratio
	from 
	(select d_month.d_date,list.customer_id,list.sales_id,list.sales_branch,sum(list.income_money) as income_money
	from dw_erp_d_sales_contract_list list
	join 
	    (select substr(d_date,1,6) as d_month,d_date,
	           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end,
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-1),'-','') as d_month_start_1m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-12),'-','') as d_month_end_12m,          
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-13),'-','') as d_month_start_13m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-24),'-','') as d_month_end_24m
	     from dim_date 
	    where d_date = regexp_replace(date_add(reformat_datetime(string({{date[:6]+'01'}}),'yyyy-MM-dd'),-1),'-','')
	    ) d_month
	 on 1=1
	where list.p_date = '$date$'
	and list.d_date between d_month.d_month_end_24m and d_month.d_month_start_13m
	group by d_month.d_date,list.customer_id,list.sales_id,list.sales_branch
	) nm 
	left join 
	(select d_month.d_date,list.customer_id,list.sales_id,list.sales_branch,sum(list.income_money) as income_money
	from dw_erp_d_sales_contract_list list 
	join 
	    (select substr(d_date,1,6) as d_month,d_date,
	           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end,
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-1),'-','') as d_month_start_1m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-12),'-','') as d_month_end_12m,          
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-13),'-','') as d_month_start_13m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-24),'-','') as d_month_end_24m
	     from dim_date 
	    where d_date = regexp_replace(date_add(reformat_datetime(string({{date[:6]+'01'}}),'yyyy-MM-dd'),-1),'-','')
	    ) d_month
	 on 1=1
	where list.p_date = '$date$'
	and list.d_date between d_month.d_month_end_12m and d_month.d_month_start_1m
	group by d_month.d_date,list.customer_id,list.sales_id,list.sales_branch
	) dm 
	on nm.customer_id = dm.customer_id
	and nm.d_date = dm.d_date
	left join (select id,
					is_sd,status,lp_age,
					sd_id,sr_sd_id,sr_sd_name,sd_name,branch_name as sales_branch,
					position_level,
					sales_level as sd_level
			  from dw_erp_d_salesuser_to_sd
			  where p_date = '$date$') sd 
		on nm.sales_id = sd.id 
	group by  nm.d_date,sd.sd_name,sd.sr_sd_name,sd.sales_branch,sd.sd_level
	grouping sets ((nm.d_date,sd.sr_sd_name,sd.sd_level,sd.sales_branch),(nm.d_date,sd.sd_name,sd.sd_level,sd.sales_branch))
) renewal
group by renewal.d_date,renewal.sd_name,renewal.sd_level,renewal.sales_branch
having nvl(renewal.sd_name,'未知') not in ('未知','-1');



--客户级别  月度离线任务

select 
'月份',
'级别',
'城市',
'当期到期金额',
'当期到期合同数',
'当期到期已经提前续约的到期金额',
'当期到期已经提前续约的期合同数',
'当期未到期提前在当期续约的到期金额',
'当期未到期提前在当期续约的续约金额',
'当期未到期提前在当期续约的合同数',
'当期到期当期续约的续约金额',
'当期到期当期续约的合同数',
'前90天内到期在当期续约的到期金额',
'前90天内到期在当期续约的续约金额',
'前90天内到期在当期续约的合同数',
'合内单数续约率',
'合内金额续约率',
'90天单数续约率',
'90天金额续约率',
'前1-12月回款金额',
'前13-24月回款金额',
'12月滚动金额续约率',
'本月内到期在本月之后（N+1~N+3)月内续约的合同数',
'本月内到期，在本月之后（N+1~N+3)月内续约的合同新签约金额',
'当期到期已经提前续约的续约金额',
'90天单数续约率(以当月到期合同为总样本）',
'90天金额续约率(以当月到期合同为总样本）'
from dummy;

select 
substr(renewal.d_date,1,6) as d_month,
renewal.r_level,
renewal.sales_branch,
sum(expire_contract_money) as expire_contract_money,
sum(expire_cust_cnt) as expire_cust_cnt,
sum(expire_pre_renewal_contract_money) as expire_pre_renewal_contract_money,
sum(expire_pre_renewal_cust_cnt) as expire_pre_renewal_cust_cnt,
sum(pre_expire_renewal_contract_money) as pre_expire_renewal_contract_money,
sum(pre_expire_renewal_money) as pre_expire_renewal_money,
sum(pre_expire_renewal_cust_cnt) as pre_expire_renewal_cust_cnt,
sum(expire_renewal_money) as expire_renewal_money,
sum(expire_renewal_cust_cnt) as expire_renewal_cust_cnt,
sum(day90_on_expire_renewal_contract_money) as day90_on_expire_renewal_contract_money,
sum(day90_on_expire_renewal_money) as day90_on_expire_renewal_money,
sum(day90_on_expire_renewal_cust_cnt) as day90_on_expire_renewal_cust_cnt,
sum(renewal_cnt_ratio) as renewal_cnt_ratio,
sum(renewal_money_ratio) as renewal_money_ratio,
sum(day90_renewal_cnt_ratio) as day90_renewal_cnt_ratio,
sum(day90_renewal_money_ratio) as day90_renewal_money_ratio,
sum(m12_roll_renewal_dm) as m12_roll_renewal_dm,
sum(m12_roll_renewal_nm) as m12_roll_renewal_nm,
sum(m12_roll_renewal_ratio) as m12_roll_renewal_ratio,
sum(expire_90day_on_renewal_cust_cnt) as expire_90day_on_renewal_cust_cnt,
sum(expire_90day_on_renewal_money) as expire_90day_on_renewal_money,
sum(expire_pre_renewal_money) as expire_pre_renewal_money,
sum(day90_expire_cnt_ratio) as day90_expire_cnt_ratio,
sum(day90_expire_money_ratio) as day90_expire_money_ratio
from (

	select  d_date,
	case  repertory_level when 0 then 'S' when 1  then 'SS' when 2 then 'KA' when 3 then 'JS' else '其他' end as r_level,
	sales_branch,
	sum(is_expire*income_money) as expire_contract_money,
	sum(is_expire) as expire_cust_cnt,
	sum(is_expire_pre_renewal*income_money) as expire_pre_renewal_contract_money,
	sum(is_expire_pre_renewal) as expire_pre_renewal_cust_cnt,
	sum(is_pre_expire_renewal*income_money) as pre_expire_renewal_contract_money,
	sum(is_pre_expire_renewal*next_income_money) as pre_expire_renewal_money,
	sum(is_pre_expire_renewal) as pre_expire_renewal_cust_cnt,
	sum(is_expire_renewal*next_income_money) as expire_renewal_money,
	sum(is_expire_renewal) as expire_renewal_cust_cnt,
	sum(is_90day_on_expire_renewal*income_money) as day90_on_expire_renewal_contract_money,
	sum(is_90day_on_expire_renewal*next_income_money) as day90_on_expire_renewal_money,
	sum(is_90day_on_expire_renewal) as day90_on_expire_renewal_cust_cnt,
	sum(is_expire_pre_renewal*next_income_money) as expire_pre_renewal_money,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as renewal_cnt_ratio,
	(sum(is_expire_renewal*next_income_money) + sum(is_pre_expire_renewal*next_income_money) ) / (sum(is_expire*income_money) + sum(is_pre_expire_renewal*income_money) - sum(is_expire_pre_renewal*income_money)) as renewal_money_ratio,
	(sum(is_expire_renewal) + sum(is_pre_expire_renewal) + sum(is_90day_on_expire_renewal)) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)+ sum(is_90day_on_expire_renewal)) as day90_renewal_cnt_ratio,
	(sum(is_expire_renewal*next_income_money) + sum(is_pre_expire_renewal*next_income_money)+ sum(is_90day_on_expire_renewal*next_income_money) ) / (sum(is_expire*income_money) + sum(is_pre_expire_renewal*income_money) - sum(is_expire_pre_renewal*income_money)+ sum(is_90day_on_expire_renewal*income_money) ) as day90_renewal_money_ratio,
	sum(is_expire_90day_on_renewal) as expire_90day_on_renewal_cust_cnt,
	sum(is_expire_90day_on_renewal*next_income_money) as expire_90day_on_renewal_money,
	(sum(is_expire_renewal) + sum(is_expire_pre_renewal) + sum(is_expire_90day_on_renewal)) / sum(is_expire) as day90_expire_cnt_ratio,
	(sum(is_expire_renewal*next_income_money) + sum(is_expire_pre_renewal*next_income_money) + sum(is_expire_90day_on_renewal*next_income_money)) / sum(is_expire*income_money) as day90_expire_money_ratio,
	0 as m12_roll_renewal_dm,
	0 as m12_roll_renewal_nm,
	0 as m12_roll_renewal_ratio
	from dw_erp_d_sales_renewal_flag
	where p_date = '$date$'	
	  and d_date = regexp_replace(date_add(reformat_datetime(string({{date[:6]+'01'}}),'yyyy-MM-dd'),-1),'-','')
	group by  d_date,repertory_level,sales_branch

	union all 

	select nm.d_date,
		case  nm.repertory_level when 0 then 'S' when 1  then 'SS' when 2 then 'KA' when 3 then 'JS' else '其他' end as r_level,
		nm.sales_branch,
		0 as expire_contract_money,
		0 as expire_cust_cnt,
		0 as expire_pre_renewal_contract_money,
		0 as expire_pre_renewal_cust_cnt,
		0 as pre_expire_renewal_contract_money,
		0 as pre_expire_renewal_money,
		0 as pre_expire_renewal_cust_cnt,
		0 as expire_renewal_money,
		0 as expire_renewal_cust_cnt,
		0 as day90_on_expire_renewal_contract_money,
		0 as day90_on_expire_renewal_money,
		0 as day90_on_expire_renewal_cust_cnt,
		0 as expire_pre_renewal_money,
		0 as renewal_cnt_ratio,
		0 as renewal_money_ratio,
		0 as day90_renewal_cnt_ratio,
		0 as day90_renewal_money_ratio,
		0 as expire_90day_on_renewal_cust_cnt,
		0 as expire_90day_on_renewal_money,
		0 as day90_expire_cnt_ratio,
		0 as day90_expire_money_ratio,
		nvl(sum(dm.income_money),0) as m12_roll_renewal_dm,
		sum(nm.income_money) as m12_roll_renewal_nm,
		nvl(sum(dm.income_money),0)/sum(nm.income_money) as m12_roll_renewal_ratio
	from 
	(select d_month.d_date,list.customer_id,list.repertory_level,list.sales_branch,sum(list.income_money) as income_money
	from dw_erp_d_sales_contract_list list
	join 
	    (select substr(d_date,1,6) as d_month,d_date,
	           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end,
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-1),'-','') as d_month_start_1m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-12),'-','') as d_month_end_12m,          
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-13),'-','') as d_month_start_13m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-24),'-','') as d_month_end_24m
	     from dim_date 
	    where d_date = regexp_replace(date_add(reformat_datetime(string({{date[:6]+'01'}}),'yyyy-MM-dd'),-1),'-','')
	    ) d_month
	on 1=1
	where list.p_date = '$date$'
	and list.d_date between d_month.d_month_end_24m and d_month.d_month_start_13m
	group by d_month.d_date,list.customer_id,list.repertory_level,list.sales_branch
	) nm 
	left join 
	(select d_month.d_date,list.customer_id,list.repertory_level,list.sales_branch,sum(list.income_money) as income_money
	from dw_erp_d_sales_contract_list list
	join 
	    (select substr(d_date,1,6) as d_month,d_date,
	           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end,
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-1),'-','') as d_month_start_1m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-12),'-','') as d_month_end_12m,          
	           regexp_replace(add_months(concat(substr(date_format,1,7),'-','01'),-13),'-','') as d_month_start_13m,
	           regexp_replace(add_months(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),-24),'-','') as d_month_end_24m
	     from dim_date 
	    where d_date = regexp_replace(date_add(reformat_datetime(string({{date[:6]+'01'}}),'yyyy-MM-dd'),-1),'-','')
	    ) d_month
	 on 1=1
	where list.p_date = '$date$'
	and list.d_date between d_month.d_month_end_12m and d_month.d_month_start_1m
	group by d_month.d_date,list.customer_id,list.repertory_level,list.sales_branch
	) dm 
	on nm.customer_id = dm.customer_id
	and nm.d_date = dm.d_date
	group by  nm.d_date,nm.repertory_level,nm.sales_branch
) renewal
group by renewal.d_date,renewal.r_level,renewal.sales_branch;
