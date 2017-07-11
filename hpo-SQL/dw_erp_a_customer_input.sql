CREATE TABLE dw_erp_a_customer_input(
  d_date int COMMENT ' 统计月份 ',  
  input_date int COMMENT ' 统计月份 ',   
  customer_id int COMMENT ' 客户主键 ', 
  customer_name string COMMENT ' 客户名称 ',   
  status int comment ' 0-未认证，1-已认证',
  input_id int COMMENT ' 录入销售顾问主键 ', 
  input_name string COMMENT ' 录入销售顾问名称 ', 
  input_org_id int COMMENT ' 录入销售顾问组别 ', 
  input_org_name string COMMENT ' 录入销售顾问组别名称 ',  
  creation_timestamp timestamp COMMENT ' 时间戳 ')
comment '新增客户明细表';


CREATE TABLE dw_erp_a_customer_input(
  d_date int COMMENT ' 统计月份 ',  
  input_date int COMMENT ' 录入日期 ',   
  customer_id int COMMENT ' 客户主键 ', 
  customer_name varchar(150) COMMENT ' 客户名称 ',   
  status int comment ' 0-未认证，1-已认证',
  input_id int COMMENT ' 录入销售顾问主键 ', 
  input_name varchar(50) COMMENT ' 录入销售顾问名称 ', 
  input_org_id int COMMENT ' 录入销售组别 ', 
  input_org_name varchar(150) COMMENT ' 录入销售顾问组别名称 ',  
  creation_timestamp timestamp default current_timestamp COMMENT ' 时间戳 ',
  primary key (customer_id)
  ) comment '新增客户明细表';

alter table dw_erp_a_customer_input change status status int comment ' 0-未认证，1-已认证';

insert overwrite table dw_erp_a_customer_input 
select substr(regexp_replace(cust.createtime,'-',''),1,8) as d_date,
       substr(regexp_replace(cust.createtime,'-',''),1,8) as input_date,
       cust.id as customer_id,
       cust.name as customer_name,
       if(company_certificate not in ('','-1'),1,0) as status,
       cust.input_id,
       suser.name as input_name,
       suser.org_id as input_org_id,
       suser.org_name as input_org_name,
       current_timestamp as creation_timestamp
  from dw_erp_d_customer_base cust 
  join dw_erp_d_salesuser_base suser
    on cust.input_id = suser.id
    and suser.p_date = $date$
 where cust.p_date =  $date$
   and substr(regexp_replace(cust.createtime,'-',''),1,4)  >= 2016;