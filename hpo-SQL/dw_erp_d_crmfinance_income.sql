CREATE TABLE dw_erp_a_crmfinance_income(
  d_date int comment '回款日期:YYYYMMDD',
  id int COMMENT ' 主键ID ', 
  name string COMMENT ' 账款名称 ', 
  customer_id int COMMENT ' 客户ID ', 
  customer_name string COMMENT ' 客户名称 ', 
  customer_industry string COMMENT ' 客户行业 ', 
  customer_industry_name string COMMENT ' 客户行业名称', 
  contract_id int COMMENT ' 合同ID ', 
  contract_no string COMMENT ' 合同号 ', 
  contract_type string COMMENT ' 合同类型 ', 
  contract_money float COMMENT ' 合同签约金额 ', 
  contract_sign_date string COMMENT ' 合同签约日期 ', 
  contract_status string COMMENT ' 合同状态 ', 
  contract_createtime string COMMENT ' 合同创建日期 ', 
  biz_type int COMMENT ' 合同类型:猎聘通,诚猎通,校园,RPO,薪酬报告 ', 
  income_type int COMMENT ' 入账类型 0：系统入账； 1：手工入账； ', 
  trade_code string COMMENT ' 银行交易码,手工入账则填写 ', 
  money float COMMENT ' 实付金额 ', 
  pay_time string COMMENT ' 实付时间 ', 
  receivable_id int COMMENT ' 应收ID ', 
  sales_id int COMMENT ' 当前维护人 ', 
  sales_name string COMMENT ' 当前维护人姓名 ', 
  parent_salesuser_id int COMMENT ' 汇报上级ID ', 
  parent_salesuser_name string COMMENT ' 汇报上级姓名 ', 
  is_sales_agent int comment ' 是否基础销售 ',
  is_work_on int comment ' 是否在岗 ',
  position_id int COMMENT ' 岗位ID ', 
  position_name string COMMENT ' 岗位名称 ', 
  position_level string COMMENT ' 岗位级别 ', 
  position_level_name string COMMENT ' 岗位级别名称 ', 
  position_channel string COMMENT ' 岗位渠道 ', 
  position_channel_name string COMMENT ' 岗位渠道名称 ', 
  org_id int COMMENT ' 所属部门 ', 
  org_name string COMMENT ' 所属部门名称 ', 
  createtime string COMMENT ' 创建日期 ', 
  modifytime string COMMENT ' 修改日期 ', 
  creation_timestamp timestamp) comment '财务回款收入明细表';


create table dw_erp_a_crmfinance_income(
  d_date int comment '回款日期:yyyymmdd',
  id int comment ' 主键id ', 
  name varchar(100) comment ' 账款名称 ', 
  customer_id int comment ' 客户id ', 
  customer_name varchar(100) comment ' 客户名称 ', 
  customer_industry varchar(100) comment ' 客户行业 ', 
  customer_industry_name varchar(50) comment ' 客户行业名称', 
  contract_id int comment ' 合同id ', 
  contract_no varchar(100) comment ' 合同号 ', 
  contract_type varchar(30) comment ' 合同类型 ', 
  contract_money float comment ' 合同签约金额 ', 
  contract_sign_date varchar(30) comment ' 合同签约日期 ', 
  contract_status varchar(30) comment ' 合同状态 ', 
  contract_createtime varchar(30) comment ' 合同创建日期 ', 
  biz_type int comment ' 合同类型:猎聘通,诚猎通,校园,rpo,薪酬报告 ', 
  income_type int comment ' 入账类型 0：系统入账； 1：手工入账； ', 
  trade_code varchar(100) comment ' 银行交易码,手工入账则填写 ', 
  money float comment ' 实付金额 ', 
  pay_time varchar(30) comment ' 实付时间 ', 
  receivable_id int comment ' 应收id ', 
  sales_id int comment ' 当前维护人 ', 
  sales_name varchar(30) comment ' 当前维护人姓名 ', 
  parent_salesuser_id int comment ' 汇报上级id ', 
  parent_salesuser_name varchar(30) comment ' 汇报上级姓名 ', 
  is_sales_agent int comment ' 是否基础销售 ',
  is_work_on int comment ' 是否在岗 ',
  position_id int comment ' 岗位id ', 
  position_name varchar(30) comment ' 岗位名称 ', 
  position_level varchar(30) comment ' 岗位级别 ', 
  position_level_name varchar(30) comment ' 岗位级别名称 ', 
  position_channel varchar(30) comment ' 岗位渠道 ', 
  position_channel_name varchar(30) comment ' 岗位渠道名称 ', 
  org_id int comment ' 所属部门 ', 
  org_name varchar(100) comment ' 所属部门名称 ', 
  createtime varchar(30) comment ' 创建日期 ', 
  modifytime varchar(30) comment ' 修改日期 ', 
  creation_timestamp timestamp default current_timestamp comment '时间戳',
  primary key (id)
  ) comment '财务回款收入明细表';


insert overwrite table dw_erp_a_crmfinance_income
select
substr(regexp_replace(pay_time,'-',''),1,8) as d_date,
income.id as id ,
null as name,
income.customer_id as customer_id,
nvl(customer.name,'未知') as customer_name,
nvl(customer.industry,'999') as customer_industry,
nvl(dim_industry.d_main_industry,'未知') as customer_industry_name,
income.contract_id  as  contract_id,
nvl(contract.contract_no ,'-1') as contract_no,
nvl(type_enum.enum_name,'未知' ) as contract_type,
nvl(contract.money,0.0) as contract_money,
nvl(contract.sign_date,'1900-01-01') as contract_sign_date ,
nvl(contract.status,'-1') as contract_status ,
nvl(cast(contract.createtime as string),'1900-01-01 00:00:00.000') as contract_createtime,
nvl(contract.type,-1)  as biz_type,
nvl(income.income_type,-1)  as income_type,
nvl(income.trade_code,'-1')  as trade_code,
nvl(income.money,0)  as money,
nvl(concat(substr(income.pay_time,1,4),'-',substr(income.pay_time,5,2),'-',substr(income.pay_time,7,2)),'1900-01-01')  as pay_time,
nvl(income.receivable_id,-1)  as receivable_id,
nvl(income.creator_id,-1) as sales_id,
nvl(salesuser.name,'未知') as sales_name,
nvl(salesuser.parent_salesuser_id,-1) as sales_group_id,
nvl(salesuser.parent_salesuser_name,'未知') as sales_group_name,
nvl(salesuser.position_id,-1) as position_id ,
nvl(salesuser.position_name,'未知') as position_name ,
nvl(salesuser.position_level,'-1') as position_level ,
nvl(salesuser.position_level_name,'未知') as position_level_name ,
nvl(salesuser.position_channel,'-1') as position_channel ,
nvl(salesuser.position_channel_name,'未知') as position_channel_name ,
nvl(case when salesuser.position_channel in ('A0000484','A0000485','A0000486','A0000821') then 1 else 0 end,-1) as is_sales_agent,
nvl(case when salesuser.status in (0,1) then 1 else 0 end,-1) as is_work_on,
nvl(income.org_id,-1) as org_id ,
nvl(salesuser.org_name,'未知') as org_name ,
income.createtime as createtime ,
income.modifytime as modifytime ,
from_unixtime(unix_timestamp()) as creation_timestamp,
min(nvl(concat(substr(income.pay_time,1,4),'-',substr(income.pay_time,5,2),'-',substr(income.pay_time,7,2)),'1900-01-01')) over(distribute by income.customer_id) as first_pay_time
from crm_finance_income income
inner join dw_erp_d_salesuser_base salesuser
on income.creator_id = salesuser.id
and salesuser.p_date = greatest(substr(regexp_replace(pay_time,'-',''),1,8),'20160501')
left outer join dw_erp_d_contract_base contract
on income.contract_id = contract.id
and contract.p_date = $date$
left outer join dw_erp_d_customer_base customer
on income.customer_id = customer.id
and customer.p_date = $date$
left outer join dim_industry
on customer.industry = dim_industry.d_ind_code
left outer join pub_enum_list type_enum
on type_enum.enum_type = 'type'
and type_enum.src_table = 'crm_contract'
and type_enum.is_default = '1'
and contract.type = type_enum.enum_code
left outer join dw_erp_a_test_account test
on income.customer_id = test.id
and test.type = 1
where income.deleteflag = 0
and income.status = 0
and test.id is null;




CREATE TABLE dw_erp_d_crmfinance_income(
  d_date int COMMENT '回款日期:yyyymmdd', 
  id int COMMENT ' 主键id ', 
  name string COMMENT ' 账款名称 ', 
  customer_id int COMMENT ' 客户id ', 
  customer_name string COMMENT ' 客户名称 ', 
  customer_industry string COMMENT ' 客户行业 ', 
  customer_industry_name string COMMENT ' 客户行业名称', 
  contract_id int COMMENT ' 合同id ', 
  contract_no string COMMENT ' 合同号 ', 
  contract_type string COMMENT ' 合同类型 ', 
  contract_money float COMMENT ' 合同签约金额 ', 
  contract_sign_date string COMMENT ' 合同签约日期 ', 
  contract_status string COMMENT ' 合同状态 ', 
  contract_createtime string COMMENT ' 合同创建日期 ', 
  biz_type int COMMENT ' 合同类型:猎聘通,诚猎通,校园,rpo,薪酬报告 ', 
  income_type int COMMENT ' 入账类型 0：系统入账； 1：手工入账； ', 
  trade_code string COMMENT ' 银行交易码,手工入账则填写 ', 
  money float COMMENT ' 实付金额 ', 
  pay_time string COMMENT ' 实付时间 ', 
  receivable_id int COMMENT ' 应收id ', 
  sales_id int COMMENT ' 当前维护人 ', 
  sales_name string COMMENT ' 当前维护人姓名 ', 
  parent_salesuser_id int COMMENT ' 汇报上级id ', 
  parent_salesuser_name string COMMENT ' 汇报上级姓名 ', 
  is_sales_agent int COMMENT ' 是否基础销售 ', 
  is_work_on int COMMENT ' 是否在岗 ', 
  position_id int COMMENT ' 岗位id ', 
  position_name string COMMENT ' 岗位名称 ', 
  position_level string COMMENT ' 岗位级别 ', 
  position_level_name string COMMENT ' 岗位级别名称 ', 
  position_channel string COMMENT ' 岗位渠道 ', 
  position_channel_name string COMMENT ' 岗位渠道名称 ', 
  org_id int COMMENT ' 所属部门 ', 
  org_name string COMMENT ' 所属部门名称 ', 
  createtime string COMMENT ' 创建日期 ', 
  modifytime string COMMENT ' 修改日期 ', 
  creation_timestamp timestamp)
COMMENT '财务回款收入明细表'
partitioned by (p_date int);

alter table dw_erp_d_crmfinance_income add columns (first_pay_time string '首次回款时间');

insert overwrite table dw_erp_d_crmfinance_income partition (p_date = $date$)
select
substr(regexp_replace(pay_time,'-',''),1,8) as d_date,
income.id as id ,
null as name,
income.customer_id as customer_id,
nvl(customer.name,'未知') as customer_name,
nvl(customer.industry,'999') as customer_industry,
nvl(dim_industry.d_main_industry,'未知') as customer_industry_name,
income.contract_id  as  contract_id,
nvl(contract.contract_no ,'-1') as contract_no,
nvl(type_enum.enum_name,'未知' ) as contract_type,
nvl(contract.money,0.0) as contract_money,
nvl(contract.sign_date,'1900-01-01') as contract_sign_date ,
nvl(contract.status,'-1') as contract_status ,
nvl(cast(contract.createtime as string),'1900-01-01 00:00:00.000') as contract_createtime,
nvl(contract.type,-1)  as biz_type,
nvl(income.income_type,-1)  as income_type,
nvl(income.trade_code,'-1')  as trade_code,
nvl(income.money,0)  as money,
nvl(concat(substr(income.pay_time,1,4),'-',substr(income.pay_time,5,2),'-',substr(income.pay_time,7,2)),'1900-01-01')  as pay_time,
nvl(income.receivable_id,-1)  as receivable_id,
nvl(income.creator_id,-1) as sales_id,
nvl(salesuser.name,'未知') as sales_name,
nvl(salesuser.parent_salesuser_id,-1) as sales_group_id,
nvl(salesuser.parent_salesuser_name,'未知') as sales_group_name,
nvl(salesuser.position_id,-1) as position_id ,
nvl(salesuser.position_name,'未知') as position_name ,
nvl(salesuser.position_level,'-1') as position_level ,
nvl(salesuser.position_level_name,'未知') as position_level_name ,
nvl(salesuser.position_channel,'-1') as position_channel ,
nvl(salesuser.position_channel_name,'未知') as position_channel_name ,
nvl(case when salesuser.position_channel in ('A0000484','A0000485','A0000486','A0000821') then 1 else 0 end,-1) as is_sales_agent,
nvl(case when salesuser.status in (0,1) then 1 else 0 end,-1) as is_work_on,
nvl(income.org_id,-1) as org_id ,
nvl(salesuser.org_name,'未知') as org_name ,
income.createtime as createtime ,
income.modifytime as modifytime ,
from_unixtime(unix_timestamp()) as creation_timestamp,
min(nvl(concat(substr(income.pay_time,1,4),'-',substr(income.pay_time,5,2),'-',substr(income.pay_time,7,2)),'1900-01-01')) over(distribute by income.customer_id) as first_pay_time
from crm_finance_income income
inner join dw_erp_d_salesuser_base salesuser
on income.creator_id = salesuser.id
and salesuser.p_date = greatest(substr(regexp_replace(pay_time,'-',''),1,8),'20160501')
left outer join dw_erp_d_contract_base contract
on income.contract_id = contract.id
and contract.p_date = $date$
left outer join dw_erp_d_customer_base customer
on income.customer_id = customer.id
and customer.p_date = $date$
left outer join dim_industry
on customer.industry = dim_industry.d_ind_code
left outer join pub_enum_list type_enum
on type_enum.enum_type = 'type'
and type_enum.src_table = 'crm_contract'
and type_enum.is_default = '1'
and contract.type = type_enum.enum_code
left outer join dw_erp_a_test_account test
on income.customer_id = test.id
and test.type = 1
where income.deleteflag = 0
and income.status = 0
and test.id is null;




insert overwrite table dw_erp_d_crmfinance_income partition (p_date = $date$)
select
substr(regexp_replace(pay_time,'-',''),1,8) as d_date,
income.id as id ,
null as name,
income.customer_id as customer_id,
nvl(customer.name,'未知') as customer_name,
nvl(customer.industry,'999') as customer_industry,
nvl(dim_industry.d_main_industry,'未知') as customer_industry_name,
income.contract_id  as  contract_id,
nvl(contract.contract_no ,'-1') as contract_no,
nvl(type_enum.enum_name,'未知' ) as contract_type,
nvl(contract.money,0.0) as contract_money,
nvl(contract.sign_date,'1900-01-01') as contract_sign_date ,
nvl(contract.status,'-1') as contract_status ,
nvl(cast(contract.createtime as string),'1900-01-01 00:00:00.000') as contract_createtime,
nvl(contract.type,-1)  as biz_type,
nvl(income.income_type,-1)  as income_type,
nvl(income.trade_code,'-1')  as trade_code,
nvl(income.money,0)  as money,
nvl(concat(substr(income.pay_time,1,4),'-',substr(income.pay_time,5,2),'-',substr(income.pay_time,7,2)),'1900-01-01')  as pay_time,
nvl(income.receivable_id,-1)  as receivable_id,
nvl(income.creator_id,-1) as sales_id,
nvl(salesuser.name,'未知') as sales_name,
nvl(salesuser.parent_salesuser_id,-1) as sales_group_id,
nvl(salesuser.parent_salesuser_name,'未知') as sales_group_name,
nvl(salesuser.position_id,-1) as position_id ,
nvl(salesuser.position_name,'未知') as position_name ,
nvl(salesuser.position_level,'-1') as position_level ,
nvl(salesuser.position_level_name,'未知') as position_level_name ,
nvl(salesuser.position_channel,'-1') as position_channel ,
nvl(salesuser.position_channel_name,'未知') as position_channel_name ,
nvl(case when salesuser.position_channel in ('A0000484','A0000485','A0000486','A0000821') then 1 else 0 end,-1) as is_sales_agent,
nvl(case when salesuser.status in (0,1) then 1 else 0 end,-1) as is_work_on,
nvl(income.org_id,-1) as org_id ,
nvl(salesuser.org_name,'未知') as org_name ,
income.createtime as createtime ,
income.modifytime as modifytime ,
from_unixtime(unix_timestamp()) as creation_timestamp
from crm_finance_income income
inner join dw_erp_d_salesuser_base salesuser
on income.creator_id = salesuser.id
and salesuser.p_date = greatest(substr(regexp_replace(pay_time,'-',''),1,8),'20160501')
left outer join dw_erp_d_contract_base contract
on income.contract_id = contract.id
and contract.p_date = $date$
left outer join dw_erp_d_customer_base customer
on income.customer_id = customer.id
and customer.p_date = $date$
left outer join dim_industry
on customer.industry = dim_industry.d_ind_code
left outer join pub_enum_list type_enum
on type_enum.enum_type = 'type'
and type_enum.src_table = 'crm_contract'
and type_enum.is_default = '1'
and contract.type = type_enum.enum_code
left outer join dw_erp_a_test_account test
on income.customer_id = test.id
and test.type = 1
where income.deleteflag = 0
and income.status = 0
and test.id is null;



insert overwrite table dw_erp_d_crmfinance_income partition (p_date)
select d_date
, id
, name
, customer_id
, customer_name
, customer_industry
, customer_industry_name
, contract_id
, contract_no
, contract_type
, contract_money
, contract_sign_date
, contract_status
, contract_createtime
, biz_type
, income_type
, trade_code
, money
, pay_time
, receivable_id
, sales_id
, sales_name
, parent_salesuser_id
, parent_salesuser_name
, is_sales_agent
, is_work_on
, position_id
, position_name
, position_level
, position_level_name
, position_channel
, position_channel_name
, org_id
, org_name
, createtime
, modifytime
, creation_timestamp
, min(pay_time) over(distribute by customer_id) as first_pay_time
, p_date
from dw_erp_d_crmfinance_income
where p_date between {{start_date}} and {{end_date}}