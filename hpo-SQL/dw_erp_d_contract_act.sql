CREATE TABLE dw_erp_d_contract_act(
  d_date int COMMENT ' 统计日期 ', 
  contract_id int COMMENT ' 合同主键 ', 
  contract_no string COMMENT ' 合同号 ', 
  contract_type string COMMENT ' 合同类型 ', 
  contract_money float COMMENT ' 合同签约金额 ', 
  contract_status string COMMENT ' 合同状态 ', 
  contract_sign_date string COMMENT ' 合同签约时间 ', 
  contract_createtime string COMMENT ' 合同创建创建时间 ', 
  service_effect_date string COMMENT ' 服务生效时间 ', 
  service_expired_date string COMMENT ' 服务失效时间 ', 
  sales_id int COMMENT ' 销售顾问主键 ', 
  sales_name string COMMENT ' 销售顾问名称 ', 
  sales_group_id int COMMENT ' 销售顾问汇报对象 ', 
  sales_group_name string COMMENT ' 销售顾问汇报对象名称 ', 
  position_level string COMMENT ' 销售顾问级别 ', 
  position_level_name string COMMENT ' 销售顾问级别名称 ', 
  org_id int COMMENT ' 部门主键 ', 
  org_name string COMMENT ' 部门名称 ', 
  customer_id int COMMENT ' 客户主键 ', 
  customer_name string COMMENT ' 客户名称 ', 
  comp_industry_code string COMMENT ' 客户行业编码 ', 
  comp_industry_name string COMMENT ' 客户行业名称 ', 
  customer_sales_id int COMMENT ' 合同客户所属销售ID ', 
  customer_sales_name string COMMENT ' 合同客户所属销售姓名 ', 
  customer_position_level string COMMENT ' 合同客户所属销售级次 ', 
  customer_position_level_name string COMMENT ' 合同客户所属销售级次名称 ', 
  customer_org_id int COMMENT ' 合同客户所属部门ID ', 
  customer_org_name string COMMENT ' 合同客户所属部门名称 ', 
  is_contract_new int COMMENT ' 是否新签 ', 
  contract_new_amount float COMMENT ' 新签合同金额 ', 
  is_lpt_in_service int COMMENT ' 是否合作中猎聘通客户 ', 
  is_lpt_expire int COMMENT ' 是否到期 ', 
  is_lpt_break int COMMENT ' 是否断约 ', 
  is_noincome_effect int COMMENT ' 是否提前开通未回款 ', 
  lpt_income float COMMENT ' 猎聘通合同回款金额 ', 
  all_income float COMMENT ' 合同回款金额 ', 
  lpt_income_m float COMMENT ' 月累计猎聘通合同回款金额 ', 
  all_income_m float COMMENT ' 月累计合同回款金额 ', 
  creation_timestamp timestamp COMMENT ' 时间戳 ')
PARTITIONED BY ( p_date int);

alter table dw_erp_d_contract_act add columns (receivable_money float comment '应收金额',income_money float comment '回款金额',paying_money float comment '待收回款',is_openservice_pre int comment '是否提前开通 ') cascade;

alter table dw_erp_d_contract_act add  (receivable_money float comment '应收金额',income_money float comment '回款金额',paying_money float comment '待收回款',is_openservice_pre int comment '是否提前开通 ') ;

alter table dw_erp_d_contract_act add (invoice_flag int comment '是否已开票',push_lpt_flag int comment '猎聘通服务是否已开通') ;
alter table dw_erp_d_contract_act add columns (push_lpt_flag int comment '猎聘通服务是否已开通') cascade;

insert overwrite table dw_erp_d_contract_act partition (p_date = $date$)
select
$date$ as d_date,
base.id as contract_id,
base.contract_no as contract_no,
nvl(type_enum.enum_name,'未知') as contract_type,
nvl(base.money,0) as contract_money,
nvl(case when base.status = 2 then '已回执'  else '已生效' end,'未知' ) as contract_status,
nvl(base.sign_date,'1900-01-01') as contract_sign_date,
nvl(substr(regexp_replace(base.createtime,'-',''),1,10),'19000101') as contract_createtime,
nvl(base.lpt_service_effect_date,'19000101') as service_effect_date,
nvl(base.lpt_service_expired_date,'19000101') as service_expired_date,
nvl(salesuser.sales_id,-1) as sales_id,
nvl(salesuser.name,'未知') as sales_name,
nvl(salesuser.parent_salesuser_id,-1 ) as sales_group_id ,
nvl(salesuser.parent_salesuser_name,'未知') as sales_group_name,
nvl(salesuser.position_level ,'-1') as position_level,
nvl(plevel_enum.enum_name,'未知') as position_level_name,
nvl(salesuser.org_id,-1) as org_id,
nvl(salesuser.org_name,'未知') as org_name,
nvl(cus.id,-1) as  customer_id,
nvl(cus.name,'未知') as  customer_name,
nvl(cus.industry_code,'999' ) as comp_industry_code,
nvl(cus.industry_name,'未知' ) as comp_industry_name,
nvl(cus.sales_user_id , -1) as customer_sales_id ,
nvl(cus.sales_user_name ,'未知' ) as customer_sales_name ,
nvl(cus.position_level ,'-1' ) as customer_position_level ,
nvl(cus.position_level_name ,'未知' ) as customer_position_level_name ,
nvl(cus.sales_org_id , -1) as customer_org_id ,
nvl(cus.sales_org_name ,'未知' ) as customer_org_name  ,
case when base.createtime  = '$date$' then 1 else 0 end as is_contract_new,--是否新签
case when base.createtime  = '$date$' then base.money else cast (0 as float) end as contract_new_amount,--新签约金额
case when '$date$' between  regexp_replace(substr(lpt_service_effect_date,1,10),'-','')  and regexp_replace(substr(lpt_service_expired_date,1,10),'-','') then 1 else 0 end is_lpt_in_service , --是否合作中客户
case when cal_days('$date$' ,regexp_replace(lpt_service_expired_date,'-','')) between 0 and 90  then 1 else 0 end as is_lpt_expire,--是否到期
case when cal_days(regexp_replace(lpt_service_expired_date,'-',''),'$date$' ) between 0 and 90 then 1 else 0 end as is_lpt_break,--是否断约
case when '$date$' between  regexp_replace(substr(lpt_service_effect_date,1,10),'-','')  and regexp_replace(substr(lpt_service_expired_date,1,10),'-','')  and income.contract_id is null and nvl(base.money,0.0) >0 then 1 else 0 end is_noincome_effect, --是否提前开通未回款
nvl(income.lpt_income ,0) as lpt_income, --猎聘通合同回款金额
nvl(income.all_income,0) as all_income, --合同回款金额
nvl(income.lpt_income_m ,0) as lpt_income_m, --猎聘通合同回款金额
nvl(income.all_income_m,0) as all_income_m, --合同回款金额
from_unixtime(unix_timestamp()) as creation_timestamp,
nvl(rec1.receivable_money,0) as receivable_money,
nvl(income.income_money,0) as income_money,
case when substr(regexp_replace(base.createtime,'-',''),1,6) > '201606' and base.type in (0,1) and (nvl(invoice.invoice_flag ,-1) = 1 or base.push_lpt_flag = 1) then base.money-nvl(income.income_money,0)  -- 猎聘通-诚猎通合同 待收=合同金额-已回款金额
      when substr(regexp_replace(base.createtime,'-',''),1,6) > '201606' and base.type in (10,11) then nvl(rec1.receivable_money,0)-nvl(income.income_money,0) --RPO/校园合同 应收金额-已回款金额
     when substr(regexp_replace(base.createtime,'-',''),1,6) > '201606' and base.type = 15 then nvl(rec1.receivable_money,0)-nvl(income.income_money,0) 
     else 0 end as paying_money,
case when apply.contract_id is not null then 1 else 0 end as is_openservice_pre,
nvl(invoice.invoice_flag ,-1) as invoice_flag,
base.push_lpt_flag
from
(select 
  id,sign_date,money,customer_id,creator_id,contract_no,
regexp_replace(substr(createtime,1,10),'-','')  as createtime,
type,status,secondparty_sign_id,
lpt_service_effect_date,lpt_service_expired_date,
min(lpt_service_effect_date) over(partition by customer_id  rows between unbounded preceding and  unbounded following) as lpt_service_effect_date2,
max(lpt_service_expired_date) over(partition by customer_id  rows between unbounded preceding and  unbounded following) as lpt_service_expired_date2,
rpo_inner_money,push_lpt_flag
from dw_erp_d_contract_base
where p_date =  $date$
and subaction = 0
and (case when type in (10,11) and status in (1,2,3) then 1
when type not in (10,11) and status in (2,3) then 1
else 0
end) = 1
) base   --猎聘通和诚猎通(已生效，已回执，不考虑资源置换 ) 校园和RPO线下合同(我方盖章完成，已生效)
inner join
(
select id as sales_id,name,position_level,parent_salesuser_id,parent_salesuser_name,org_id,org_name
from dw_erp_d_salesuser_base
where p_date =  $date$
and is_saleuser =1
) salesuser
on base.secondparty_sign_id = salesuser.sales_id
inner join
(
select dw_erp_d_customer_base.id,name,industry as industry_code,d_main_industry as industry_name,
sales_user_id,sales_user_name,sales.position_level,sales.position_level_name, sales_org_id,sales_org_name
from dw_erp_d_customer_base
left outer join dim_industry
on dw_erp_d_customer_base.industry = dim_industry.d_ind_code
left outer join
(select  id, position_level,position_level_name
from dw_erp_d_salesuser_base
where p_date = $date$) sales
on dw_erp_d_customer_base.sales_user_id = sales.id
where p_date =  $date$
) cus
on base.customer_id = cus.id
left outer join
(   
  select contract_id,sum(money) as income_money,
  sum(case when substr(regexp_replace(pay_time,'-',''),1,8)  =  '$date$' and biz_type = 0 then money else '0' end) as  lpt_income, --猎聘通合同回款金额
  sum(case when substr(regexp_replace(pay_time,'-',''),1,8)  =  '$date$' then money else '0' end)  as all_income,  --合同回款金额
  sum(case when (substr(regexp_replace(pay_time,'-',''),1,8)  between concat(substr('$date$',1,6),'01')  and '$date$') and biz_type = 0 then money else '0' end) as  lpt_income_m, --猎聘通合同回款金额
  sum(case when substr(regexp_replace(pay_time,'-',''),1,8)  between concat(substr('$date$',1,6),'01')  and '$date$' then money else '0' end) as all_income_m  --合同回款金额
  from dw_erp_a_crmfinance_income cfi
  where money > 0
  group by contract_id
)  income
on base.id = income.contract_id

left outer join 
(select contract_id
   from crm_contract_openservice_apply
   where approve_status = 2
   and deleteflag = 0
   group by contract_id 
) apply 
on base.id = apply.contract_id 
left outer join 
(select rec.contract_id,
        sum(rec.money) as receivable_money
  from crm_finance_receivables rec 
 where rec.deleteflag = 0
  group by rec.contract_id) rec1
on base.id = rec1.contract_id
left join 
(select object_id as contract_id,1 as invoice_flag
  from crm_finance_invoice
  where status = 2
  and deleteflag = 0
  and type = 0
 group by object_id) invoice
on base.id = invoice.contract_id
left outer join pub_enum_list type_enum
on type_enum.enum_type = 'type'
and type_enum.src_table = 'crm_contract'
and type_enum.is_default = '1'
and base.type = type_enum.enum_code
left outer join pub_enum_list plevel_enum
on plevel_enum.enum_type = 'position_level'
and plevel_enum.src_table = 'portal_position'
and plevel_enum.is_default = '1'
and salesuser.position_level = plevel_enum.enum_code
;

合同金额
内部结算总金额
综合合同的线上部分总金额
综合合同的线上部分内部结算总金额
综合合同的线下部分总金额
综合合同的线下部分内部结算总金额
应收总金额
应收线上金额
应收RPO金额
回款金额

select
20170418 as d_date,
base.id as contract_id,
base.contract_no as contract_no,
nvl(type_enum.enum_name,'未知') as contract_type,
nvl(case when base.status = 2 then '已回执'  else '已生效' end,'未知' ) as contract_status,
nvl(base.sign_date,'1900-01-01') as contract_sign_date,
nvl(substr(regexp_replace(base.createtime,'-',''),1,10),'19000101') as contract_createtime,
nvl(base.lpt_service_effect_date,'19000101') as service_effect_date,
nvl(base.lpt_service_expired_date,'19000101') as service_expired_date,
nvl(salesuser.sales_id,-1) as sales_id,
nvl(salesuser.name,'未知') as sales_name,
nvl(salesuser.org_id,-1) as org_id,
nvl(salesuser.org_name,'未知') as org_name,
nvl(cus.id,-1) as  customer_id,
nvl(cus.name,'未知') as  customer_name,
nvl(base.money,0) as contract_money,
nvl(rec1.receivable_money,0) as receivable_money,
nvl(income.income_money,0) as income_money,
case when substr(regexp_replace(base.createtime,'-',''),1,6) > '201606' and base.type in (0,1) and (nvl(invoice.invoice_flag ,-1) = 1 or base.push_lpt_flag = 1) then base.money-nvl(income.income_money,0)  -- 猎聘通-诚猎通合同 待收=合同金额-已回款金额
      when substr(regexp_replace(base.createtime,'-',''),1,6) > '201606' and base.type in (10,11) then nvl(rec1.receivable_money,0)-nvl(income.income_money,0) --RPO/校园合同 应收金额-已回款金额
     when substr(regexp_replace(base.createtime,'-',''),1,6) > '201606' and base.type = 15 then nvl(rec1.receivable_money,0)-nvl(income.income_money,0) 
     else 0 end as paying_money,case when apply.contract_id is not null then 1 else 0 end as is_openservice_pre,
nvl(invoice.invoice_flag ,-1) as invoice_flag,
base.rpo_inner_money,
base.contract_rpo_money,
base.contract_online_inner_money,
base.contract_online_money,
rec2.online_money,
rec2.rpo_money
from
(select 
  id,sign_date,money,customer_id,creator_id,contract_no,
regexp_replace(substr(createtime,1,10),'-','')  as createtime,
type,status,
lpt_service_effect_date,lpt_service_expired_date,
min(lpt_service_effect_date) over(partition by customer_id  rows between unbounded preceding and  unbounded following) as lpt_service_effect_date2,
max(lpt_service_expired_date) over(partition by customer_id  rows between unbounded preceding and  unbounded following) as lpt_service_expired_date2,
rpo_inner_money,
rpo_money as contract_rpo_money,
online_inner_money as contract_online_inner_money,
online_money as contract_online_money,push_lpt_flag
from dw_erp_d_contract_base
where p_date =  20170418
and subaction = 0
and (case when type in (10,11) and status in (1,2,3) then 1
when type not in (10,11) and status in (2,3) then 1
else 0
end) = 1
) base   --猎聘通和诚猎通(已生效，已回执，不考虑资源置换 ) 校园和RPO线下合同(我方盖章完成，已生效)
inner join
(
select id as sales_id,name,position_level,parent_salesuser_id,parent_salesuser_name,org_id,org_name
from dw_erp_d_salesuser_base
where p_date =  20170418
and is_saleuser =1
) salesuser
on base.creator_id = salesuser.sales_id
inner join
(
select dw_erp_d_customer_base.id,name,industry as industry_code,d_main_industry as industry_name,
sales_user_id,sales_user_name,sales.position_level,sales.position_level_name, sales_org_id,sales_org_name
from dw_erp_d_customer_base
left outer join dim_industry
on dw_erp_d_customer_base.industry = dim_industry.d_ind_code
left outer join
(select  id, position_level,position_level_name
from dw_erp_d_salesuser_base
where p_date = 20170418) sales
on dw_erp_d_customer_base.sales_user_id = sales.id
where p_date =  20170418
) cus
on base.customer_id = cus.id
left outer join
(   
  select contract_id,sum(money) as income_money,
  sum(case when substr(regexp_replace(pay_time,'-',''),1,8)  =  '20170418' and biz_type = 0 then money else '0' end) as  lpt_income, --猎聘通合同回款金额
  sum(case when substr(regexp_replace(pay_time,'-',''),1,8)  =  '20170418' then money else '0' end)  as all_income,  --合同回款金额
  sum(case when (substr(regexp_replace(pay_time,'-',''),1,8)  between concat(substr('20170418',1,6),'01')  and '20170418') and biz_type = 0 then money else '0' end) as  lpt_income_m, --猎聘通合同回款金额
  sum(case when substr(regexp_replace(pay_time,'-',''),1,8)  between concat(substr('20170418',1,6),'01')  and '20170418' then money else '0' end) as all_income_m  --合同回款金额
  from dw_erp_a_crmfinance_income cfi
  where money > 0
  group by contract_id
)  income
on base.id = income.contract_id
left outer join 
(select contract_id
   from crm_contract_openservice_apply
   where approve_status = 2
   and deleteflag = 0
   group by contract_id 
) apply 
on base.id = apply.contract_id 
left outer join 
(select rec.contract_id,
        sum(rec.money) as receivable_money
  from crm_finance_receivables rec 
 where rec.deleteflag = 0
  group by rec.contract_id) rec1
on base.id = rec1.contract_id
left outer join 
(select rec.contract_id,
        sum(case when item.type = 0 then item.money else 0 end) as online_money,
        sum(case when item.type = 1 then item.money else 0 end) as rpo_money,
        sum(case when item.type = 2 then item.money else 0 end) as xy_money,
        sum(case when item.type = 3 then item.money else 0 end) as cp_money
  from crm_finance_receivables rec 
  left join crm_finance_receivable_item item 
  on rec.id = item.receivable_id
 where rec.deleteflag = 0
  and item.deleteflag = 0
  group by rec.contract_id) rec2 
on base.id = rec2.contract_id
left join 
(select object_id as contract_id,1 as invoice_flag
  from crm_finance_invoice
  where status = 2
  and deleteflag = 0
  and type = 0
 group by object_id) invoice
on base.id = invoice.contract_id
left outer join pub_enum_list type_enum
on type_enum.enum_type = 'type'
and type_enum.src_table = 'crm_contract'
and type_enum.is_default = '1'
and base.type = type_enum.enum_code
left outer join pub_enum_list plevel_enum
on plevel_enum.enum_type = 'position_level'
and plevel_enum.src_table = 'portal_position'
and plevel_enum.is_default = '1'
and salesuser.position_level = plevel_enum.enum_code





insert overwrite table dw_erp_d_contract_act partition (p_date = $date$)
select
$date$ as d_date,
base.id as contract_id,
base.contract_no as contract_no,
nvl(type_enum.enum_name,'未知') as contract_type,
nvl(base.money,0) as contract_money,
nvl(case when base.status = 2 then '已回执'  else '已生效' end,'未知' ) as contract_status,
nvl(base.sign_date,'1900-01-01') as contract_sign_date,
nvl(substr(regexp_replace(base.createtime,'-',''),1,10),'19000101') as contract_createtime,
nvl(base.lpt_service_effect_date,'19000101') as service_effect_date,
nvl(base.lpt_service_expired_date,'19000101') as service_expired_date,
nvl(salesuser.sales_id,-1) as sales_id,
nvl(salesuser.name,'未知') as sales_name,
nvl(salesuser.parent_salesuser_id,-1 ) as sales_group_id ,
nvl(salesuser.parent_salesuser_name,'未知') as sales_group_name,
nvl(salesuser.position_level ,'-1') as position_level,
nvl(plevel_enum.enum_name,'未知') as position_level_name,
nvl(salesuser.org_id,-1) as org_id,
nvl(salesuser.org_name,'未知') as org_name,
nvl(cus.id,-1) as  customer_id,
nvl(cus.name,'未知') as  customer_name,
nvl(cus.industry_code,'999' ) as comp_industry_code,
nvl(cus.industry_name,'未知' ) as comp_industry_name,
nvl(cus.sales_user_id , -1) as customer_sales_id ,
nvl(cus.sales_user_name ,'未知' ) as customer_sales_name ,
nvl(cus.position_level ,'-1' ) as customer_position_level ,
nvl(cus.position_level_name ,'未知' ) as customer_position_level_name ,
nvl(cus.sales_org_id , -1) as customer_org_id ,
nvl(cus.sales_org_name ,'未知' ) as customer_org_name  ,
case when base.createtime  = '$date$' then 1 else 0 end as is_contract_new,--是否新签
case when base.createtime  = '$date$' then base.money else cast (0 as float) end as contract_new_amount,--新签约金额
case when '$date$' between  regexp_replace(substr(lpt_service_effect_date,1,10),'-','')  and regexp_replace(substr(lpt_service_expired_date,1,10),'-','') then 1 else 0 end is_lpt_in_service , --是否合作中客户
case when cal_days('$date$' ,regexp_replace(lpt_service_expired_date,'-','')) between 0 and 90  then 1 else 0 end as is_lpt_expire,--是否到期
case when cal_days(regexp_replace(lpt_service_expired_date,'-',''),'$date$' ) between 0 and 90 then 1 else 0 end as is_lpt_break,--是否断约
case when '$date$' between  regexp_replace(substr(lpt_service_effect_date,1,10),'-','')  and regexp_replace(substr(lpt_service_expired_date,1,10),'-','')  and income.contract_id is null and nvl(base.money,0.0) >0 then 1 else 0 end is_noincome_effect, --是否提前开通未回款
nvl(income.lpt_income ,0) as lpt_income, --猎聘通合同回款金额
nvl(income.all_income,0) as all_income, --合同回款金额
nvl(income.lpt_income_m ,0) as lpt_income_m, --猎聘通合同回款金额
nvl(income.all_income_m,0) as all_income_m, --合同回款金额
from_unixtime(unix_timestamp()) as creation_timestamp,
nvl(rec1.receivable_money,0) as receivable_money,
nvl(income.income_money,0) as income_money,
case when substr(regexp_replace(base.createtime,'-',''),1,6) > '201606' and base.type in (0,1) and (nvl(invoice.invoice_flag ,-1) = 1 or base.push_lpt_flag = 1) then base.money-nvl(income.income_money,0)  -- 猎聘通-诚猎通合同 待收=合同金额-已回款金额
      when substr(regexp_replace(base.createtime,'-',''),1,6) > '201606' and base.type in (10,11) then nvl(rec1.receivable_money,0)-nvl(income.income_money,0) --RPO/校园合同 应收金额-已回款金额
     when substr(regexp_replace(base.createtime,'-',''),1,6) > '201606' and base.type = 15 then nvl(rec1.receivable_money,0)-nvl(income.income_money,0) 
     else 0 end as paying_money,
case when apply.contract_id is not null then 1 else 0 end as is_openservice_pre,
nvl(invoice.invoice_flag ,-1) as invoice_flag,
base.push_lpt_flag
from
(select 
  id,sign_date,money,customer_id,creator_id,contract_no,
regexp_replace(substr(createtime,1,10),'-','')  as createtime,
type,status,
lpt_service_effect_date,lpt_service_expired_date,
min(lpt_service_effect_date) over(partition by customer_id  rows between unbounded preceding and  unbounded following) as lpt_service_effect_date2,
max(lpt_service_expired_date) over(partition by customer_id  rows between unbounded preceding and  unbounded following) as lpt_service_expired_date2,
rpo_inner_money,push_lpt_flag
from dw_erp_d_contract_base
where p_date =  $date$
and subaction = 0
and (case when type in (10,11) and status in (1,2,3) then 1
when type not in (10,11) and status in (2,3) then 1
else 0
end) = 1
) base   --猎聘通和诚猎通(已生效，已回执，不考虑资源置换 ) 校园和RPO线下合同(我方盖章完成，已生效)
inner join
(
select id as sales_id,name,position_level,parent_salesuser_id,parent_salesuser_name,org_id,org_name
from dw_erp_d_salesuser_base
where p_date =  $date$
and is_saleuser =1
) salesuser
on base.creator_id = salesuser.sales_id
inner join
(
select dw_erp_d_customer_base.id,name,industry as industry_code,d_main_industry as industry_name,
sales_user_id,sales_user_name,sales.position_level,sales.position_level_name, sales_org_id,sales_org_name
from dw_erp_d_customer_base
left outer join dim_industry
on dw_erp_d_customer_base.industry = dim_industry.d_ind_code
left outer join
(select  id, position_level,position_level_name
from dw_erp_d_salesuser_base
where p_date = $date$) sales
on dw_erp_d_customer_base.sales_user_id = sales.id
where p_date =  $date$
) cus
on base.customer_id = cus.id
left outer join
(   
  select contract_id,sum(money) as income_money,
  sum(case when substr(regexp_replace(pay_time,'-',''),1,8)  =  '$date$' and biz_type = 0 then money else '0' end) as  lpt_income, --猎聘通合同回款金额
  sum(case when substr(regexp_replace(pay_time,'-',''),1,8)  =  '$date$' then money else '0' end)  as all_income,  --合同回款金额
  sum(case when (substr(regexp_replace(pay_time,'-',''),1,8)  between concat(substr('$date$',1,6),'01')  and '$date$') and biz_type = 0 then money else '0' end) as  lpt_income_m, --猎聘通合同回款金额
  sum(case when substr(regexp_replace(pay_time,'-',''),1,8)  between concat(substr('$date$',1,6),'01')  and '$date$' then money else '0' end) as all_income_m  --合同回款金额
  from dw_erp_a_crmfinance_income cfi
  where money > 0
  group by contract_id
)  income
on base.id = income.contract_id

left outer join 
(select contract_id
   from crm_contract_openservice_apply
   where approve_status = 2
   and deleteflag = 0
   group by contract_id 
) apply 
on base.id = apply.contract_id 
left outer join 
(select rec.contract_id,
        sum(rec.money) as receivable_money
  from crm_finance_receivables rec 
 where rec.deleteflag = 0
  group by rec.contract_id) rec1
on base.id = rec1.contract_id
left outer join 
(select rec.contract_id,
        sum(case when item.type = 0 then item.money else 0 end) as online_money,
        sum(case when item.type = 1 then item.money else 0 end) as rpo_money,
        sum(case when item.type = 2 then item.money else 0 end) as xy_money,
        sum(case when item.type = 3 then item.money else 0 end) as cp_money
  from crm_finance_receivables rec 
  left join crm_finance_receivable_item item 
  on rec.id = item.receivable_id
 where rec.deleteflag = 0
  and item.deleteflag = 0
  group by rec.contract_id) rec2 
on base.id = rec2.contract_id
left join 
(select object_id as contract_id,1 as invoice_flag
  from crm_finance_invoice
  where status = 2
  and deleteflag = 0
  and type = 0
 group by object_id) invoice
on base.id = invoice.contract_id
left outer join pub_enum_list type_enum
on type_enum.enum_type = 'type'
and type_enum.src_table = 'crm_contract'
and type_enum.is_default = '1'
and base.type = type_enum.enum_code
left outer join pub_enum_list plevel_enum
on plevel_enum.enum_type = 'position_level'
and plevel_enum.src_table = 'portal_position'
and plevel_enum.is_default = '1'
and salesuser.position_level = plevel_enum.enum_code