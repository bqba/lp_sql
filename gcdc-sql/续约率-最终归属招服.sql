create table fact_h_gcdc_d_expire_check_rpsorg
(
  d_date int comment '统计日期',
  org_id  int comment '招聘服务小组id',
  org_name  string  comment '招聘服务小组名称',
  org_grade int comment '组织级次',
  is_last int comment '是否末级节点',
  parent_org_id int comment '上级招聘服务小组id',
  parent_org_name string  comment '上级招聘服务小组名称',
  renew_intention int comment '续约意向度:1-无,2-低,3-中,4-高',
  contract_money_level int comment '到期合同金额: 1-(0-8k),2-[8k,30k],3-30k以上',
  expire_cust_cnt int  comment '到期客户数', 
  expire_no_renewal_cust_cnt int comment '当月到期未续约客户',
  expire_is_renewal_cust_cnt int comment '当月到期已续约客户',
  expire_renewal_cust_cnt int  comment '当月到期当月续约客户数', 
  expire_pre_renewal_cust_cnt int  comment '当月到期提前续约客户数', 
  creation_timestamp  timestamp comment '时间戳'
) comment '到期客户盘点-RPS_TL看板'
partitioned by (p_date int);

create table fact_h_gcdc_d_expire_check_rpsorg
(
  d_date int comment '统计日期',
  org_id  int comment '招聘服务小组id',
  org_name  varchar(100)  comment '招聘服务小组名称',
  org_grade int comment '组织级次',
  is_last int comment '是否末级节点',
  parent_org_id int comment '上级招聘服务小组id',
  parent_org_name string  comment '上级招聘服务小组名称',
  renew_intention int comment '续约意向度:1-无,2-低,3-中,4-高',
  contract_money_level int comment '到期合同金额: 1-(0-8k),2-[8k,30k],3-30k以上',
  expire_cust_cnt int  comment '到期客户数', 
  expire_no_renewal_cust_cnt int comment '当月到期未续约客户',
  expire_is_renewal_cust_cnt int comment '当月到期已续约客户',
  expire_renewal_cust_cnt int  comment '当月到期当月续约客户数', 
  expire_pre_renewal_cust_cnt int  comment '当月到期提前续约客户数', 
  creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
  primary key (d_date,org_id,renew_intention,contract_money_level)
)  comment '到期客户盘点-RPS_TL看板';

insert overwrite table fact_h_gcdc_d_expire_check_rpsorg partition(p_date = $date$)
select 
$date$ as d_date,
dol.d_org_id as org_id,
dol.org_name as org_name,
dol.grade as org_grade ,
dol.is_last as is_last ,
dol.parent_id as parent_org_id ,
dol.parent_name as parent_org_name,
expire2.renew_intention,
expire2.contract_money_level,
expire2.expire_cust_cnt,
expire2.expire_no_renewal_cust_cnt,
expire2.expire_is_renewal_cust_cnt,
expire2.expire_renewal_cust_cnt,
expire2.expire_pre_renewal_cust_cnt,
from_unixtime(unix_timestamp()) as creation_timestamp
from (
  select 
    coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
    expire1.renew_intention,
    expire1.contract_money_level,
     sum(expire1.expire_cust_cnt) as expire_cust_cnt,
     sum(expire1.expire_no_renewal_cust_cnt) as expire_no_renewal_cust_cnt,
     sum(expire1.expire_is_renewal_cust_cnt) as expire_is_renewal_cust_cnt,
     sum(expire1.expire_renewal_cust_cnt) as expire_renewal_cust_cnt,       
     sum(expire1.expire_pre_renewal_cust_cnt) as expire_pre_renewal_cust_cnt,
     sum(expire1.contract_money) as contract_money  
  from (
    select 
      rps_org_id,
      renew_intention, 
      contract_money_level,     
         sum(expire0.expire_cust_cnt) as expire_cust_cnt,
         sum(expire0.expire_no_renewal_cust_cnt) as expire_no_renewal_cust_cnt,
         sum(expire0.expire_pre_renewal_cust_cnt + expire0.expire_renewal_cust_cnt) as expire_is_renewal_cust_cnt,
         sum(expire0.expire_renewal_cust_cnt) as expire_renewal_cust_cnt,       
         sum(expire0.expire_pre_renewal_cust_cnt) as expire_pre_renewal_cust_cnt,
         sum(expire0.contract_money) as contract_money
    from (
    select nvl(list.expire_rps_org_id,-1) as rps_org_id,
           nvl(list.renew_intention,0) as renew_intention,
           case when contract_money < 10000 then 1 when contract_money>=10000 and contract_money<=30000 then 2 when contract_money>30000 then 3 else 0 end as contract_money_level,
             sum(is_expire) as expire_cust_cnt,         
             sum(is_expire_no_renewal) as expire_no_renewal_cust_cnt,                
             sum(is_expire_pre_renewal) as expire_pre_renewal_cust_cnt,
             sum(is_expire_renewal) as expire_renewal_cust_cnt,         
             sum(is_expire*contract_money) as contract_money
      from dw_erp_d_gcdc_contract_list_rpsuser list 
      where list.p_date = '$date$'
      and d_date = '$date$'
      group by nvl(list.expire_rps_org_id,-1),list.renew_intention,case when contract_money < 10000 then 1 when contract_money>=10000 and contract_money<=30000 then 2 when contract_money>30000 then 3 else 0 end
    ) expire0 
    group by rps_org_id,renew_intention,contract_money_level
  ) expire1 
  join  dim_org_level dol 
    on expire1.rps_org_id = dol.d_org_id
   and dol.p_date = $date$
  group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level,expire1.renew_intention,expire1.contract_money_level
  grouping sets((dol.first_level,expire1.renew_intention,expire1.contract_money_level),(dol.second_level,expire1.renew_intention,expire1.contract_money_level),(dol.third_level,expire1.renew_intention,expire1.contract_money_level),(dol.forth_level,expire1.renew_intention,expire1.contract_money_level))
) expire2
join dim_org_level dol 
on expire2.org_id = dol.d_org_id
and dol.p_date = $date$;



alter table dw_erp_d_customer_base add columns(renew_intention int comment '招服标记的续约意向度') cascade;
alter table dw_erp_d_customer_base_new add columns(renew_intention int comment '招服标记的续约意向度');

select 
'客户有效状态',
'合同id',
'当前合同号',
'当前合同回款日期',
'客户id',
'上份合同id',
'上份合同号',
'上份合同回款日期',
'上份合同金额',
'上份合同过期日期',
'下份合同id',
'下份合同号',
'下份合同回款日期',
'下份合同过期日期',
'下份合同金额',
'合同金额',
'合同过期日期',
'客户名称',
'12月31日所属招服id',
'12月31日招服名称',
'12月31日招服部门',
'目前所属招服id',
'招服名称',
'招服部门',
'招服岗位名称',
'到期所属招服',
'到期所属名称',
'到期所属招服团队',
'到期所属招服团队名称',
'续约所属招服',
'续约所属招服名称'
'续约所属招服',
'续约所属招服团队名称'
from dummy;

select 
case when list.customer_valid_reason = 0 then 1 else 0 end,
list.contract_id,
list.contract_no,
list.d_date,
list.cust_id,
list.before_contract_id,
list.before_contract_no,
list.before_accounted_date,
list.before_countract_money,
list.contract_before_expire_date,
list.next_contract_id,
list.next_contract_no,
list.next_accounted_date,
list.contract_next_expire_date,
list.next_countract_money,
list.contract_money,
list.contract_expire_date,
list.customer_name,
cust.serviceuser_id,
cust.serviceuser_name,
cust.service_teamorg_name,
list.adviser_id,
list.adviser_name,
list.adviser_group,
list.adviser_job_title,
list.expire_rps_user_id,
exp.name,
list.expire_rps_org_id,
exporg.name,
list.renewal_rps_user_id,
renew.name,
list.renewal_rps_org_id,
reneworg.name
from dw_erp_d_gcdc_contract_list list
left join portal_employee exp  on list.expire_rps_user_id = exp.id
left join portal_org  exporg on list.expire_rps_org_id = exporg.id 
left join portal_employee renew  on list.renewal_rps_user_id = renew.id
left join portal_org  reneworg on list.renewal_rps_org_id = reneworg.id 
left join dw_erp_d_customer_base cust on list.cust_id = cust.id and cust.p_date = 20170116
where list.p_date = 20170116;



续约率调整：
1.原月续约率口径:
月底在谁身上就算谁的续约率
2.调整后续约率口径：
入账前20天在谁名下就算到对应招服的续约率
到期前20天在谁名下就算到对应招服的到期

create table dw_erp_d_gcdc_customer_package
(customer_id int comment '客户ID',
 pack_customerid string comment '客户打包ID集合，逗号分隔',
 creation_timestamp timestamp
) comment 'GCDC打包客户映射表'
partitioned by (p_date int);

insert overwrite table dw_erp_d_gcdc_customer_package partition(p_date = $date$)
select 
	distinct customer_id,
	regexp_replace(customer_ids,'\t','') as pack_customerid,
	from_unixtime(unix_timestamp()) as creation_timestamp
from (select split(customer_ids,',') as customers ,customer_ids
		from rsc_customer_package
		where deleteflag = 0
	 ) package 
lateral view explode(customers) subview as customer_id
where regexp_replace(customer_id,'\t','') <> '';

alter table dw_erp_d_gcdc_contract_list add columns 
(expire_rps_user_id int comment '到期所属招服',
expire_rps_org_id int comment '到期所属招服团队',
renewal_rps_user_id int comment '续约所属招服',
renewal_rps_org_id int comment '续约所属招服团队'
) cascade;

alter table dw_erp_d_gcdc_contract_list add  
(expire_rps_user_id int comment '到期所属招服',
expire_rps_org_id int comment '到期所属招服团队',
renewal_rps_user_id int comment '续约所属招服',
renewal_rps_org_id int comment '续约所属招服团队'
) ;

CREATE TABLE dw_erp_d_gcdc_contract_list(
  contract_no string COMMENT '合同号', 
  d_date int COMMENT '回款日期', 
  rownumber int COMMENT '客户合同序号', 
  cust_id int COMMENT '客户id', 
  before_accounted_date int COMMENT '上份合同回款日期', 
  next_accounted_date int COMMENT '下份合同回款日期', 
  contract_money float COMMENT '合同金额', 
  before_countract_money float COMMENT '上份合同金额', 
  next_countract_money float COMMENT '下份合同金额', 
  contract_expire_date int COMMENT '合同过期日期', 
  contract_next_expire_date int COMMENT '下份合同过期日期', 
  contract_before_expire_date int COMMENT '上份合同过期日期', 
  contract_status int COMMENT '合同状态', 
  contract_days int COMMENT '服务周期', 
  contract_sign_date int COMMENT '合同签约日期', 
  contract_effect_date int COMMENT '合同生效日期', 
  contract_start_date int COMMENT 'lpt服务生效日期', 
  suit_name string COMMENT '产品套餐名称', 
  sign_id int COMMENT '签约人名称', 
  sign_name string COMMENT '签约人名称', 
  sign_group string COMMENT '签约人部门名称', 
  sign_department string COMMENT '签约人岗位通道', 
  customer_name string COMMENT '客户名称', 
  customer_source int COMMENT '客户来源', 
  customer_dq string COMMENT '客户地区', 
  customer_industry string COMMENT '客户行业', 
  customer_main_industry string COMMENT '客户主行业', 
  companyscale string COMMENT '客户企业规模', 
  companykind string COMMENT '客户企业性质', 
  sales_id int COMMENT '所属销售名称',
  sales_name string COMMENT '所属销售名称', 
  sales_group string COMMENT '所属销售部门名称', 
  sales_department string COMMENT '所属销售岗位通道', 
  adviser_id int COMMENT '招服ID',  
  adviser_name string COMMENT '招服名称', 
  customer_valid_reason int COMMENT '客户无效原因', 
  adviser_group string COMMENT '招服部门', 
  lp_privilege_start_date int COMMENT 'lpt服务生效日期', 
  lp_privilege_end_date int COMMENT 'lpt服务失效日期', 
  adviser_job_title string COMMENT '招服岗位名称', 
  before_contract_no string COMMENT '上份合同号', 
  next_contract_no string COMMENT '下份合同号', 
  contract_id int COMMENT '合同id', 
  before_contract_id int COMMENT '上份合同id', 
  next_contract_id int COMMENT '下份合同id', 
  creation_timestamp string COMMENT '时间戳')
COMMENT '客户新签lpt合同明细表-用于计算续约率'
PARTITIONED BY ( 
  p_date int);

CREATE TABLE dw_erp_d_gcdc_contract_list(
  contract_no varchar(100) COMMENT '合同号', 
  d_date int COMMENT '回款日期', 
  rownumber int COMMENT '客户合同序号', 
  cust_id int COMMENT '客户id', 
  before_accounted_date int COMMENT '上份合同回款日期', 
  next_accounted_date int COMMENT '下份合同回款日期', 
  contract_money float COMMENT '合同金额', 
  before_countract_money float COMMENT '上份合同金额', 
  next_countract_money float COMMENT '下份合同金额', 
  contract_expire_date int COMMENT '合同过期日期', 
  contract_next_expire_date int COMMENT '下份合同过期日期', 
  contract_before_expire_date int COMMENT '上份合同过期日期', 
  contract_status int COMMENT '合同状态', 
  contract_days int COMMENT '服务周期', 
  contract_sign_date int COMMENT '合同签约日期', 
  contract_effect_date int COMMENT '合同生效日期', 
  contract_start_date int COMMENT 'lpt服务生效日期', 
  suit_name varchar(100) COMMENT '产品套餐名称', 
  sign_id int COMMENT '签约人名称', 
  sign_name varchar(50) COMMENT '签约人名称', 
  sign_group varchar(100) COMMENT '签约人部门名称', 
  sign_department varchar(100) COMMENT '签约人岗位通道', 
  customer_name varchar(200) COMMENT '客户名称', 
  customer_source int COMMENT '客户来源', 
  customer_dq varchar(50) COMMENT '客户地区', 
  customer_industry varchar(50) COMMENT '客户行业', 
  customer_main_industry varchar(50) COMMENT '客户主行业', 
  companyscale varchar(50) COMMENT '客户企业规模', 
  companykind varchar(50) COMMENT '客户企业性质', 
  sales_id int COMMENT '所属销售名称',
  sales_name varchar(50) COMMENT '所属销售名称', 
  sales_group varchar(100) COMMENT '所属销售部门名称', 
  sales_department varchar(100) COMMENT '所属销售岗位通道', 
  adviser_id int COMMENT '招服ID',  
  adviser_name varchar(50) COMMENT '招服名称', 
  customer_valid_reason int COMMENT '客户无效原因', 
  adviser_group varchar(100) COMMENT '招服部门', 
  lp_privilege_start_date int COMMENT 'lpt服务生效日期', 
  lp_privilege_end_date int COMMENT 'lpt服务失效日期', 
  adviser_job_title varchar(100) COMMENT '招服岗位名称', 
  before_contract_no varchar(100) COMMENT '上份合同号', 
  next_contract_no varchar(100) COMMENT '下份合同号', 
  contract_id int COMMENT '合同id', 
  before_contract_id int COMMENT '上份合同id', 
  next_contract_id int COMMENT '下份合同id',
  creation_timestamp timestamp default CURRENT_TIMESTAMP comment'时间戳',
  primary key (contract_no)
 ) COMMENT '客户新签lpt合同明细表-用于计算续约率';

insert overwrite table dw_erp_d_gcdc_contract_list partition(p_date = $date$)
select
nvl(d.contract_no,0) as contract_no,
d.time1 as d_date,
nvl(d.rownum2,0) as rownumber,
nvl(d.customer_id,0) as cust_id,
nvl(d.beforedate,0) as before_accounted_date,
nvl(d.nextdate,0) as next_accounted_date,
nvl(d.money,0) as contract_money,
nvl(d.beforemoney,0) as before_contract_money,
nvl(d.nextmoney,0) as next_contract_money,
nvl(d.expiredate,0) as contract_expire_date,
nvl(d.nextexpiredate,0) as contract_next_expire_date,
nvl(d.beforeexpiredate,0) as contract_before_expire_date,
nvl(d.status,0) as contract_status,
nvl(d.service_days,0) as contract_days ,
nvl(d.sign_date,0) as contract_sign_date,
nvl(d.contract_effect_time,0) as contract_effect_date,
nvl(d.lpt_service_effect_date,0) as contract_start_date,
nvl(bls.suit_name,0) as suit_name,
nvl(su.id,0)as sign_id,
nvl(su.name,0)as sign_name,
nvl(su.org_name,0)as sign_group,
nvl(su.position_channel,0)as sign_department,
nvl(bc.name,0)as customer_name,
nvl(bc.source,0) as customer_source,
nvl(sd.d_ch_area,0) as customer_dq,
nvl(di.d_sub_industry,0)as customer_industry,
nvl(di.d_main_industry,0)as customer_main_industry,
nvl(bc.company_scale,0)as companyscale,
nvl(bc.company_kind,0)as companykind,
nvl(saleuser.id,0)as sales_id,
nvl(saleuser.name,0)as sales_name,
nvl(saleuser.org_name,0)as sales_group,
nvl(saleuser.position_channel,0)as sales_department,
nvl(bc.serviceuser_id,0) as adviser_id,
nvl(bc.serviceuser_name,0) as adviser_name,
nvl(bc.rsc_valid_reason,0)as customer_valid_reason,
nvl(bc.service_teamorg_name,0)as adviser_group,
nvl(d.lpt_service_effect_date,0) as lp_privilege_start_date,
nvl(d.expiredate,0) as lp_privilege_end_date,
nvl(serviceuser.position_name,0)as serviceuser_job_title,
nvl(d.before_contract_no,0) as before_contract_no,
nvl(d.next_contract_no,0) as next_contract_no,
nvl(d.contract_id,0) as contract_id ,
nvl(d.before_contract_id,0) as before_contract_id,
nvl(d.next_contract_id,0) as next_contract_id,
from_unixtime(unix_timestamp()),
nvl(exp.serviceuser_id,case when regexp_replace(date_sub(reformat_datetime(d.expiredate,'yyyy-MM-dd'),20),'-','') <20160101 then old.serviceuser_id when d.expiredate > '$date$' then bc.serviceuser_id end) as expire_rps_user_id,
nvl(exp.service_teamorg_id,case when regexp_replace(date_sub(reformat_datetime(d.expiredate,'yyyy-MM-dd'),20),'-','') <20160101 then old.service_teamorg_id when d.expiredate > '$date$' then bc.service_teamorg_id end) as expire_rps_org_id,
nvl(renew.serviceuser_id,case when regexp_replace(date_sub(reformat_datetime(d.time1,'yyyy-MM-dd'),20),'-','') <20160101 then old.serviceuser_id when d.time1 > '$date$' then bc.serviceuser_id end) as renewal_rps_user_id,
nvl(renew.service_teamorg_id,case when regexp_replace(date_sub(reformat_datetime(d.time1,'yyyy-MM-dd'),20),'-','') <20160101 then old.service_teamorg_id when d.time1 > '$date$' then bc.service_teamorg_id end) as renewal_rps_org_id
from(
select bb.contract_no,bb.status,bb.contract_effect_time,bb.lpt_service_effect_date,bb.sign_date,bb.contract_id,
bb.money,bb.service_days,bb.customer_id,bb.time1,bb.org_id,bb.object_suit_id,bb.secondparty_sign_id,bb.expiredate,
row_number() over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1,bb.expiredate) as rownum2,
lead(bb.expiredate,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as nextexpiredate,
lead(bb.time1,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as nextdate,
lead(bb.money,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as nextmoney,
lead(bb.contract_no,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as next_contract_no,
lead(bb.contract_id,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as next_contract_id,
lag(bb.expiredate,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as beforeexpiredate,
lag(bb.time1,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as beforedate,
lag(bb.money,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as beforemoney,
lag(bb.contract_no,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as before_contract_no,
lag(bb.contract_id,1,0) over (distribute by nvl(package.pack_customerid,bb.customer_id) sort by bb.time1 ) as before_contract_id,
nvl(package.pack_customerid,bb.customer_id) as master_customer
from (
select aa.contract_no,aa.status,aa.contract_effect_time,aa.lpt_service_effect_date,aa.contract_id,
aa.sign_date,aa.money,aa.service_days,aa.customer_id,aa.time1,aa.rownum1,aa.expiredate,aa.org_id,aa.object_suit_id,aa.secondparty_sign_id
from
(select lp.contract_no,lp.status,ccl.contract_effect_time,ccl.lpt_service_effect_date,lp.sign_date,lp.money,
ccl.service_days,lp.customer_id,bf.pay_time as time1,ccl.org_id,lp.object_suit_id,lp.secondparty_sign_id,
row_number() over (distribute by lp.contract_no sort by bf.pay_time) as rownum1,
ccl.lpt_service_expired_date as expiredate,lp.id as contract_id
from
(select regexp_replace(bf.pay_time,'-','') as pay_time ,bf.receivable_id
from dw_erp_a_crmfinance_income as bf
) bf
join crm_finance_receivables as br on bf.receivable_id = br.id and br.deleteflag=0
join crm_contract lp on lp.id = br.contract_id and lp.deleteflag = 0
join crm_contract_lpt ccl on ccl.contract_id = lp.id and ccl.deleteflag = 0
where lp.deleteflag= 0
and lp.money!=0
and br.deleteflag = 0
and ccl.service_days!=0
and ccl.is_junior_contract=0
and lp.type in (0,15)
and (ccl.res_cnt<>0
or ccl.intention_cnt<>0
or ccl.invite_apply_cnt<>0
or ccl.download_coupon_cnt<>0
or ccl.interview_coupon_cnt<>0)
) aa
where aa.rownum1 = 1
) bb
left join dw_erp_d_gcdc_customer_package package
on bb.customer_id = package.customer_id
and package.p_date = '$date$'
) d
left join crm_product_suit bls on d.object_suit_id = bls.id
left join dw_erp_d_salesuser_base su on d.secondparty_sign_id = su.id and su.p_date = '$date$'
left join dw_erp_d_customer_base bc on d.customer_id =bc.id and bc.p_date = '$date$'
left join dim_dq sd on bc.dq = sd.d_code
left join dw_erp_d_salesuser_base saleuser on bc.sales_user_id = saleuser.id and saleuser.p_date = '$date$'
left join dim_industry di on bc.industry =di.d_ind_code
left join dw_erp_d_salesuser_base serviceuser on bc.serviceuser_id = serviceuser.id and serviceuser.p_date = '$date$'
left join dw_erp_d_customer_base exp on d.customer_id =exp.id and exp.p_date = regexp_replace(date_sub(reformat_datetime(d.expiredate,'yyyy-MM-dd'),20),'-','')
left join dw_erp_d_customer_base renew on d.customer_id =renew.id and renew.p_date = regexp_replace(date_sub(reformat_datetime(d.nextdate,'yyyy-MM-dd'),20),'-','')
left join dw_erp_d_customer_base old on d.customer_id =old.id and old.p_date = '20160101';




未到期提前续约客户：最终归属招服为续约招服
断约挽回客户：最终归属招服为续约招服
当月到期提前续约招服：最终归属招服为到期招服
当月到期当月续约招服：最终归属招服为续约招服
当月到期未续约招服：最终归属招服为到期招服



create table dw_erp_d_gcdc_contract_list_rpsuser
( d_date int comment '统计日期',
  customer_id int comment '客户ID',
  customer_name string comment '客户名称',
  contract_id int comment '当前合同ID',
  contract_no string comment '当前合同编号',
  contract_money float comment '当前合同金额', 
  contract_expire_date int comment '当前合同到期日期',
  contract_account_date int comment '当前合同回款日期',
  next_contract_id int comment '下份合同ID',
  next_contract_no string comment '下份合同编号', 
  next_contract_money float comment '下份合同金额', 
  next_contract_expire_date int comment '下份合同到期日期', 
  next_contract_account_date int comment '下份合同回款日期', 
  before_contract_id int comment '上份份合同ID',
  before_contract_no string comment '上份合同编号', 
  before_contract_money float comment '上份份合同金额', 
  before_contract_expire_date int comment '上份份合同到期日期', 
  before_contract_account_date int comment '上份份合同回款日期', 
  rps_user_id int comment '最终所属招服ID',
  rps_user_name string comment '最终所属招服名称',
  rps_org_id int comment '最终所属招服组织',
  rps_org_name string comment '最终所属招服组织名称',
  expire_rps_user_id int comment '过期所属招服',
  expire_rps_org_id int comment '过期所属招服组织',
  renewal_rps_user_id int comment '续约所属招服',
  renewal_rps_org_id int comment '续约所属招服组织',
  is_expire int comment '是否当月过期客户',
  is_expire_pre_renewal int comment '是否当月过期提前续约客户',
  is_expire_renewal int comment '是否当月过期当月续约客户',
  is_expire_no_renewal int comment '是否当月过期未续约客户',
  is_pre_expire_renewal int comment '是否未过期提前本月续约客户',
  is_on_expire_renewal int comment '是否断约挽回客户',
  creation_timestamp  timestamp comment '时间戳'
) comment '续约率明细-最终归属招服版'
partitioned by (p_date int);

--当月到期
insert overwrite table dw_erp_d_gcdc_contract_list_rpsuser partition(p_date = $date$)
select 
    base1.d_date,
    base1.customer_id,
    base1.customer_name,
    base1.contract_id,
    base1.contract_no,
    base1.contract_money,
    base1.contract_expire_date,
    base1.contract_account_date,
    base1.next_contract_id,
    base1.next_contract_no,
    base1.next_contract_money,
    base1.next_contract_expire_date,
    base1.next_contract_account_date,
    base1.before_contract_id,
    base1.before_contract_no,
    base1.before_contract_money,
    base1.before_contract_expire_date,
    base1.before_contract_account_date,
    base1.rps_user_id,
    suser.name as rps_user_name,
    base1.rps_org_id,
    dim_org.org_name as rps_org_name,
    base1.expire_rps_user_id,
    base1.expire_rps_org_id,
    base1.renewal_rps_user_id,
    base1.renewal_rps_org_id,
    case when sum(base1.is_expire) > 0 then 1 else 0 end as is_expire,
    case when sum(base1.is_expire_pre_renewal) > 0 then 1 else 0 end as is_expire_pre_renewal,
    case when sum(base1.is_expire_renewal) > 0 then 1 else 0 end as is_expire_renewal,
    case when sum(base1.is_expire_no_renewal) > 0 then 1 else 0 end as is_expire_no_renewal,
    case when sum(base1.is_pre_expire_renewal) > 0 then 1 else 0 end as is_pre_expire_renewal,
    case when sum(base1.is_on_expire_renewal) > 0 then 1 else 0 end as is_on_expire_renewal,
    from_unixtime(unix_timestamp()) as creation_timestamp,
    dim_org.branch_id,
    dim_org.branch_name,
    suser.position_id,
    suser.position_name,
    case when base1.renew_intention = -1 then 0 else base1.renew_intention end as renew_intention
from (
  select d_month.d_date as d_date,
         list.cust_id as customer_id,
         cust.name as customer_name,
         list.contract_id,
         list.contract_no,
         list.contract_money,
         list.contract_expire_date,
         list.d_date as contract_account_date,
         list.next_contract_id,
         list.next_contract_no,
         list.next_countract_money as next_contract_money,
         list.contract_next_expire_date as next_contract_expire_date,
         list.next_accounted_date as next_contract_account_date,       
         list.before_contract_id,
         list.before_contract_no,
         list.before_countract_money before_contract_money,
         list.contract_before_expire_date as before_contract_expire_date,
         list.before_accounted_date as before_contract_account_date,       
         case when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) and substr(list.contract_expire_date,1,6) > substr(list.next_accounted_date,1,6) and list.next_accounted_date > 0  then list.expire_rps_user_id --当月到期提前续约招服：最终归属招服为到期招服
              when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) and substr(list.contract_expire_date,1,6) = substr(list.next_accounted_date,1,6) and list.next_accounted_date <= d_month.d_date then list.renewal_rps_user_id --当月到期并续约 归续约招服
              when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) and list.next_accounted_date = 0 or list.next_accounted_date > d_month.d_date then list.expire_rps_user_id --当月到期未续约招服：最终归属招服为到期招服
              when substr(list.contract_expire_date,1,6) > substr('$date$',1,6) and substr(list.next_accounted_date,1,6) = substr('$date$',1,6) and list.next_accounted_date <= d_month.d_date then list.renewal_rps_user_id --未到期提前续约客户：最终归属招服为续约招服
              when substr(list.contract_expire_date,1,6) < substr('$date$',1,6) and substr(list.next_accounted_date,1,6) = substr('$date$',1,6) and list.next_accounted_date <= d_month.d_date then list.renewal_rps_user_id --断约挽回客户：最终归属招服为续约招服
         end as rps_user_id,
         case when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) and substr(list.contract_expire_date,1,6) > substr(list.next_accounted_date,1,6) and list.next_accounted_date > 0  then list.expire_rps_org_id --当月到期提前续约招服：最终归属招服为到期招服
              when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) and substr(list.contract_expire_date,1,6) = substr(list.next_accounted_date,1,6) and list.next_accounted_date <= d_month.d_date then list.renewal_rps_org_id --当月到期并续约 归续约招服
              when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) and list.next_accounted_date = 0 or list.next_accounted_date > d_month.d_date then list.expire_rps_org_id --当月到期未续约招服：最终归属招服为到期招服
              when substr(list.contract_expire_date,1,6) > substr('$date$',1,6) and substr(list.next_accounted_date,1,6) = substr('$date$',1,6) and list.next_accounted_date <= d_month.d_date then list.renewal_rps_org_id --未到期提前续约客户：最终归属招服为续约招服
              when substr(list.contract_expire_date,1,6) < substr('$date$',1,6) and substr(list.next_accounted_date,1,6) = substr('$date$',1,6) and list.next_accounted_date <= d_month.d_date then list.renewal_rps_org_id --断约挽回客户：最终归属招服为续约招服
         end as rps_org_id,
         list.expire_rps_user_id,
         list.expire_rps_org_id,
         list.renewal_rps_user_id,
         list.renewal_rps_org_id,       
         case when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) then 1 else 0 end as is_expire,       
         case when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) and substr(list.contract_expire_date,1,6) > substr(list.next_accounted_date,1,6) and list.next_accounted_date > 0 then 1 else 0 end as is_expire_pre_renewal,
         case when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) and substr(list.contract_expire_date,1,6) = substr(list.next_accounted_date,1,6) and list.next_accounted_date <= d_month.d_date then 1 else 0 end as is_expire_renewal,
         case when substr(list.contract_expire_date,1,6) = substr('$date$',1,6) and (list.next_accounted_date = 0 or list.next_accounted_date > d_month.d_date) then 1 else 0 end as is_expire_no_renewal,
         case when substr(list.contract_expire_date,1,6) > substr('$date$',1,6) and substr(list.next_accounted_date,1,6) = substr('$date$',1,6) and list.next_accounted_date <= d_month.d_date then 1 else 0 end as is_pre_expire_renewal,
         case when substr(list.contract_expire_date,1,6) < substr('$date$',1,6) and substr(list.next_accounted_date,1,6) = substr('$date$',1,6) and list.next_accounted_date <= d_month.d_date then 1 else 0 end as is_on_expire_renewal,
         cust.renew_intention
    from dw_erp_d_gcdc_contract_list list 
    join dw_erp_d_customer_base cust on list.cust_id = cust.id and cust.rsc_valid_status = 1 and cust.p_date = $date$
    join 
    (select d_date,
           substr(d_date,1,6) as d_month,
           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end
    from dim_date 
    where d_date <= '$date$'
      and substr(d_date,1,6) = substr('$date$',1,6)
    ) d_month on 1=1
    where list.p_date = '$date$'
      and (substr(list.contract_expire_date,1,6) = substr('$date$',1,6) or substr(list.next_accounted_date,1,6) = substr('$date$',1,6))
  union all    
  --历史过期
  select d_month.d_month_end as d_date,
         list.cust_id as customer_id,
         cust.name as customer_name,
         list.contract_id,
         list.contract_no,
         list.contract_money,
         list.contract_expire_date,
         list.d_date as contract_account_date,
         list.next_contract_id,
         list.next_contract_no,
         list.next_countract_money as next_contract_money,
         list.contract_next_expire_date as next_contract_expire_date,
         list.next_accounted_date as next_contract_account_date,       
         list.before_contract_id,
         list.before_contract_no,
         list.before_countract_money before_contract_money,
         list.contract_before_expire_date as before_contract_expire_date,
         list.before_accounted_date as before_contract_account_date,
         case when substr(list.contract_expire_date,1,6) > substr(list.next_accounted_date,1,6) and list.next_accounted_date > 0 then list.expire_rps_user_id --当月到期提前续约招服：最终归属招服为到期招服
              when substr(list.contract_expire_date,1,6) = substr(list.next_accounted_date,1,6) then list.renewal_rps_user_id --当月到期并续约 归续约招服
              when substr(list.next_accounted_date,1,6) = 0 or substr(list.contract_expire_date,1,6) < substr(list.next_accounted_date,1,6) then list.expire_rps_user_id --当月到期未续约招服：最终归属招服为到期招服
         end as rps_user_id,
         case when substr(list.contract_expire_date,1,6) > substr(list.next_accounted_date,1,6) and list.next_accounted_date > 0 then list.expire_rps_org_id --当月到期提前续约招服：最终归属招服为到期招服
              when substr(list.contract_expire_date,1,6) = substr(list.next_accounted_date,1,6) then list.renewal_rps_org_id --当月到期并续约 归续约招服
              when substr(list.next_accounted_date,1,6) = 0 or substr(list.contract_expire_date,1,6) < substr(list.next_accounted_date,1,6) then list.expire_rps_org_id --当月到期未续约招服：最终归属招服为到期招服
         end as rps_org_id,
         list.expire_rps_user_id,
         list.expire_rps_org_id,
         list.renewal_rps_user_id,
         list.renewal_rps_org_id,
         1 as is_expire,
         case when substr(list.contract_expire_date,1,6) > substr(list.next_accounted_date,1,6) and list.next_accounted_date > 0 then 1 else 0 end as is_expire_pre_renewal,
         case when substr(list.contract_expire_date,1,6) = substr(list.next_accounted_date,1,6) then 1 else 0 end as is_expire_renewal,
         case when substr(list.next_accounted_date,1,6) = 0 or substr(list.contract_expire_date,1,6) < substr(list.next_accounted_date,1,6) then 1 else 0 end as is_expire_no_renewal,
         0 as is_pre_expire_renewal,
         0 as is_on_expire_renewal,
         cust.renew_intention
    from dw_erp_d_gcdc_contract_list list 
    join dw_erp_d_customer_base cust on list.cust_id = cust.id and cust.rsc_valid_status = 1 and cust.p_date = '$date$'
    join 
    (select substr(d_date,1,6) as d_month,
           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end
      from dim_date 
      where d_date = regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','')
      and substr(d_date,1,6) < substr('$date$',1,6)
    ) d_month on substr(list.contract_expire_date,1,6) = d_month.d_month
    where list.p_date = '$date$'
  union all 
  --历史续约
  select d_month.d_month_end as d_date,
         list.cust_id as customer_id,
         cust.name as customer_name,
         list.contract_id,
         list.contract_no,
         list.contract_money,
         list.contract_expire_date,
         list.d_date as contract_account_date,
         list.next_contract_id,
         list.next_contract_no,
         list.next_countract_money as next_contract_money,
         list.contract_next_expire_date as next_contract_expire_date,
         list.next_accounted_date as next_contract_account_date,       
         list.before_contract_id,
         list.before_contract_no,
         list.before_countract_money before_contract_money,
         list.contract_before_expire_date as before_contract_expire_date,
         list.before_accounted_date as before_contract_account_date,
         case when substr(list.contract_expire_date,1,6) > substr(list.next_accounted_date,1,6) then list.renewal_rps_user_id --未到期提前续约客户：最终归属招服为续约招服
              when substr(list.contract_expire_date,1,6) < substr(list.next_accounted_date,1,6) then list.renewal_rps_user_id --断约挽回客户：最终归属招服为续约招服
              when substr(list.contract_expire_date,1,6) = substr(list.next_accounted_date,1,6) then list.renewal_rps_user_id --当月到期并续约,最终归属招服为续约招服            
         end as rps_user_id,
         case when substr(list.contract_expire_date,1,6) > substr(list.next_accounted_date,1,6) then list.renewal_rps_org_id --未到期提前续约客户：最终归属招服为续约招服
              when substr(list.contract_expire_date,1,6) < substr(list.next_accounted_date,1,6) then list.renewal_rps_org_id --断约挽回客户：最终归属招服为续约招服
              when substr(list.contract_expire_date,1,6) = substr(list.next_accounted_date,1,6) then list.renewal_rps_org_id --当月到期并续约,最终归属招服为续约招服            
         end as rps_org_id,    
         list.expire_rps_user_id,
         list.expire_rps_org_id,
         list.renewal_rps_user_id,
         list.renewal_rps_org_id,
         0 as is_expire,
         0 as is_expire_pre_renewal,
         case when substr(list.contract_expire_date,1,6) = substr(list.next_accounted_date,1,6) then 1 else 0 end as is_expire_renewal,  
         0 as is_expire_no_renewal,
         case when substr(list.contract_expire_date,1,6) > substr(list.next_accounted_date,1,6) then 1 else 0 end as is_pre_expire_renewal,
         case when substr(list.contract_expire_date,1,6) < substr(list.next_accounted_date,1,6) then 1 else 0 end as is_on_expire_renewal,
         cust.renew_intention
    from dw_erp_d_gcdc_contract_list list 
    join dw_erp_d_customer_base cust on list.cust_id = cust.id and cust.rsc_valid_status = 1 and cust.p_date = '$date$'
    join 
    (select substr(d_date,1,6) as d_month,
           regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','') as d_month_end
    from dim_date 
    where d_date = regexp_replace(last_day(reformat_datetime(string(d_date),'yyyy-MM-dd')),'-','')
      and substr(d_date,1,6) < substr('$date$',1,6)
    ) d_month on substr(list.next_accounted_date,1,6) = d_month.d_month
    where list.p_date = '$date$' 
) base1 
join dw_erp_d_salesuser_base suser on base1.rps_user_id = suser.id and suser.p_date = $date$
join dim_org on base1.rps_org_id = dim_org.d_org_id
group by 
  base1.d_date,
  base1.customer_id,
  base1.customer_name,
  base1.contract_id,
  base1.contract_no,
  base1.contract_money,
  base1.contract_expire_date,
  base1.contract_account_date,
  base1.next_contract_id,
  base1.next_contract_no,
  base1.next_contract_money,
  base1.next_contract_expire_date,
  base1.next_contract_account_date,
  base1.before_contract_id,
  base1.before_contract_no,
  base1.before_contract_money,
  base1.before_contract_expire_date,
  base1.before_contract_account_date,
  base1.rps_user_id,
  suser.name,
  base1.rps_org_id,
  dim_org.org_name,
  base1.expire_rps_user_id,
  base1.expire_rps_org_id,
  base1.renewal_rps_user_id,
  base1.renewal_rps_org_id,
  dim_org.branch_id,
  dim_org.branch_name,
  suser.position_id,
  suser.position_name,
  base1.renew_intention

create table dw_erp_a_gcdc_contract_list_rpsuser
( d_date int comment '统计日期',
  customer_id int comment '客户ID',
  customer_name string comment '客户名称',
  contract_id int comment '当前合同ID',
  contract_no string comment '当前合同编号',
  contract_money float comment '当前合同金额', 
  contract_expire_date int comment '当前合同到期日期',
  contract_account_date int comment '当前合同回款日期',
  next_contract_id int comment '下份合同ID',
  next_contract_no string comment '下份合同编号', 
  next_contract_money float comment '下份合同金额', 
  next_contract_expire_date int comment '下份合同到期日期', 
  next_contract_account_date int comment '下份合同回款日期', 
  before_contract_id int comment '上份份合同ID',
  before_contract_no string comment '上份合同编号', 
  before_contract_money float comment '上份份合同金额', 
  before_contract_expire_date int comment '上份份合同到期日期', 
  before_contract_account_date int comment '上份份合同回款日期', 
  rps_user_id int comment '最终所属招服ID',
  rps_user_name string comment '最终所属招服名称',
  rps_org_id int comment '最终所属招服组织',
  rps_org_name string comment '最终所属招服组织名称',
  expire_rps_user_id int comment '过期所属招服',
  expire_rps_org_id int comment '过期所属招服组织',
  renewal_rps_user_id int comment '续约所属招服',
  renewal_rps_org_id int comment '续约所属招服组织',
  is_expire int comment '是否当月过期客户',
  is_expire_pre_renewal int comment '是否当月过期提前续约客户',
  is_expire_renewal int comment '是否当月过期当月续约客户',
  is_expire_no_renewal int comment '是否当月过期未续约客户',
  is_pre_expire_renewal int comment '是否未过期提前本月续约客户',
  is_on_expire_renewal int comment '是否断约挽回客户',
  creation_timestamp  timestamp comment '时间戳'
) comment '续约率明细-最终归属招服版';

create table dw_erp_a_gcdc_contract_list_rpsuser
( d_date int comment '统计日期',
  customer_id int comment '客户ID',
  customer_name varchar(128) comment '客户名称',
  contract_id int comment '当前合同ID',
  contract_no varchar(128) comment '当前合同编号',
  contract_money float comment '当前合同金额', 
  contract_expire_date int comment '当前合同到期日期',
  contract_account_date int comment '当前合同回款日期',
  next_contract_id int comment '下份合同ID',
  next_contract_no varchar(128) comment '下份合同编号', 
  next_contract_money float comment '下份合同金额', 
  next_contract_expire_date int comment '下份合同到期日期', 
  next_contract_account_date int comment '下份合同回款日期', 
  before_contract_id int comment '上份份合同ID',
  before_contract_no varchar(128) comment '上份合同编号', 
  before_contract_money float comment '上份份合同金额', 
  before_contract_expire_date int comment '上份份合同到期日期', 
  before_contract_account_date int comment '上份份合同回款日期', 
  rps_user_id int comment '最终所属招服ID',
  rps_user_name varchar(128) comment '最终所属招服名称',
  rps_org_id int comment '最终所属招服组织',
  rps_org_name varchar(128) comment '最终所属招服组织名称',
  expire_rps_user_id int comment '过期所属招服',
  expire_rps_org_id int comment '过期所属招服组织',
  renewal_rps_user_id int comment '续约所属招服',
  renewal_rps_org_id int comment '续约所属招服组织',
  is_expire int comment '是否当月过期客户',
  is_expire_pre_renewal int comment '是否当月过期提前续约客户',
  is_expire_renewal int comment '是否当月过期当月续约客户',
  is_expire_no_renewal int comment '是否当月过期未续约客户',
  is_pre_expire_renewal int comment '是否未过期提前本月续约客户',
  is_on_expire_renewal int comment '是否断约挽回客户',
  creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
  primary key (d_date,customer_id,contract_id)
) comment '续约率明细-最终归属招服版';

alter table dw_erp_d_gcdc_contract_list_rpsuser add columns (rps_branch_id int comment '最终所属招服地区',rps_branch_name string comment '最终所属招服地区名称') cascade;
alter table dw_erp_a_gcdc_contract_list_rpsuser add columns (rps_branch_id int comment '最终所属招服地区',rps_branch_name string comment '最终所属招服地区名称');
alter table dw_erp_a_gcdc_contract_list_rpsuser add  (rps_branch_id int comment '最终所属招服地区',rps_branch_name varchar(50) comment '最终所属招服地区名称');

alter table dw_erp_d_gcdc_contract_list_rpsuser add columns (rps_position_id int comment '最终所属招服岗位',rps_position_name string comment '最终所属招服岗位名称') cascade;
alter table dw_erp_a_gcdc_contract_list_rpsuser add columns (rps_position_id int comment '最终所属招服岗位',rps_position_name string comment '最终所属招服岗位名称');
alter table dw_erp_a_gcdc_contract_list_rpsuser add  (rps_position_id int comment '最终所属招服岗位',rps_position_name varchar(50) comment '最终所属招服岗位名称');


alter table dw_erp_d_gcdc_contract_list_rpsuser add columns(renew_intention int comment '招服标记的续约意向度') cascade;
alter table dw_erp_a_gcdc_contract_list_rpsuser add columns(renew_intention int comment '续约意向度:1-无,2-低,3-中,4-高',contract_money_level int comment '到期合同金额: 1-(0-8k),2-[8k,30k],3-30k以上') ;

alter table dw_erp_a_gcdc_contract_list_rpsuser add columns(contract_money_level int comment '到期合同金额: 1-(0-8k),2-[8k,30k],3-30k以上') ;

insert overwrite table dw_erp_a_gcdc_contract_list_rpsuser
select d_date,
        customer_id,
        customer_name,
        contract_id,
        contract_no,
        contract_money,
        contract_expire_date,
        contract_account_date,
        next_contract_id,
        next_contract_no,
        next_contract_money,
        next_contract_expire_date,
        next_contract_account_date,
        before_contract_id,
        before_contract_no,
        before_contract_money,
        before_contract_expire_date,
        before_contract_account_date,
        rps_user_id,
        rps_user_name,
        rps_org_id,
        rps_org_name,
        expire_rps_user_id,
        expire_rps_org_id,
        renewal_rps_user_id,
        renewal_rps_org_id,
        is_expire,
        is_expire_pre_renewal,
        is_expire_renewal, is_expire_no_renewal, is_pre_expire_renewal, is_on_expire_renewal, creation_timestamp,
        rps_branch_id,rps_branch_name,rps_position_id,rps_position_name,nvl(renew_intention,0) as renew_intention,
        case when contract_money < 10000 then 1 when contract_money>=10000 and contract_money<=30000 then 2 when contract_money>30000 then 3 else 0 end as contract_money_level
from dw_erp_d_gcdc_contract_list_rpsuser
where p_date = $date$;





CREATE TABLE dim_rsc_customer(
  d_date int comment '统计日期',
  id int COMMENT ' 企业id ', 
  name string COMMENT ' 企业名称 ', 
  dq string COMMENT ' 地区 ', 
  industry string COMMENT ' 行业 ', 
  ecomp_id int COMMENT ' 机构id ', 
  ecomp_root_id int COMMENT ' 机构root_id ', 
  ecomp_version int COMMENT ' 企业版本 ', 
  sales_user_id int COMMENT ' 当前销售顾问id ', 
  sales_user_name string COMMENT ' 当前销售顾问姓名 ', 
  sales_org_id int COMMENT ' 当前销售部门id ', 
  sales_org_name string COMMENT ' 当前销售部门名称 ', 
  sales_branch_id int COMMENT ' 当前销售分公司 ', 
  sales_branch_name string COMMENT ' 当前销售分公司名称 ', 
  service_version string COMMENT ' RPS服务版本 ',
  valid_status string COMMENT ' 招服服务的客户有效标示 ',
  serviceuser_id int COMMENT ' 招服id ', 
  serviceuser_name string COMMENT ' 招服姓名 ', 
  serviceuser_position_id int COMMENT ' 招服岗位id ', 
  serviceuser_position_name string COMMENT ' 招服岗位名称 ',   
  service_teamorg_id int COMMENT ' 招服团队id ', 
  service_teamorg_name string COMMENT ' 招服团队名称 ', 
  service_branch_id int COMMENT '招服所属分公司', 
  service_branch_name string COMMENT '招服所属分公司名称', 
  creation_timestamp timestamp COMMENT ' 时间戳 '
  ) comment '客户招服关系维度表-带p_date'
partitioned by (p_date int);

CREATE TABLE dim_rsc_customer(
  d_date int comment '统计日期',
  id int COMMENT ' 企业id ', 
  name varchar(150) COMMENT ' 企业名称 ', 
  dq varchar(20) COMMENT ' 地区 ', 
  industry varchar(20) COMMENT ' 行业 ', 
  ecomp_id int COMMENT ' 机构id ', 
  ecomp_root_id int COMMENT ' 机构root_id ', 
  ecomp_version int COMMENT ' 企业版本 ', 
  sales_user_id int COMMENT ' 当前销售顾问id ', 
  sales_user_name varchar(20) COMMENT ' 当前销售顾问姓名 ', 
  sales_org_id int COMMENT ' 当前销售部门id ', 
  sales_org_name varchar(80) COMMENT ' 当前销售部门名称 ', 
  sales_branch_id int COMMENT ' 当前销售分公司 ', 
  sales_branch_name varchar(80) COMMENT ' 当前销售分公司名称 ', 
  service_version varchar(5) COMMENT ' RPS服务版本 ',
  valid_status varchar(5) COMMENT ' 招服服务的客户有效标示 ',
  serviceuser_id int COMMENT ' 招服id ', 
  serviceuser_name varchar(20) COMMENT ' 招服姓名 ', 
  serviceuser_position_id int COMMENT ' 招服岗位id ', 
  serviceuser_position_name varchar(50) COMMENT ' 招服岗位名称 ',   
  service_teamorg_id int COMMENT ' 招服团队id ', 
  service_teamorg_name varchar(80) COMMENT ' 招服团队名称 ', 
  service_branch_id int COMMENT '招服所属分公司', 
  service_branch_name varchar(80) COMMENT '招服所属分公司名称', 
  creation_timestamp timestamp COMMENT ' 时间戳 ',
  primary key (d_date,id)
  ) comment '客户招服关系维度表-带d_date';

insert overwrite table dim_rsc_customer partition (p_date = $date$)
select
'$date$' as d_date,
cust.id,
cust.name,
cust.dq,
cust.industry,
cust.ecomp_id,
cust.ecomp_root_id,
cust.ecomp_version,
cust.sales_user_id,
cust.sales_user_name,
cust.sales_org_id,
cust.sales_org_name,
cust.sales_branch_id,
cust.sales_branch_name,
cust.rps_service_version,
cust.rsc_valid_status,
cust.serviceuser_id,
cust.serviceuser_name,
rps.position_id,
rps.position_name,
cust.service_teamorg_id,
cust.service_teamorg_name,
cust.service_branch_id,
cust.service_branch_name,
from_unixtime(unix_timestamp()) as creation_timestamp
from dw_erp_d_customer_base cust 
left join dw_erp_d_salesuser_base rps 
on cust.serviceuser_id = rps.id 
and rps.p_date = '$date$'
where cust.p_date = '$date$'
and cust.serviceuser_id > 0;

CREATE TABLE fact_h_gcdc_d_renewal_rpsuser(
  d_date int COMMENT '统计日期', 
  rps_user_id int COMMENT '招服顾问id', 
  rps_user_name string COMMENT '招服顾问姓名', 
  org_id int COMMENT '招服顾问小组id', 
  org_name string COMMENT '招服顾问小组名称', 
  branch_id int COMMENT '地区id', 
  branch_name string COMMENT '地区名称', 
  position_id int COMMENT '岗位id', 
  position_name string COMMENT '岗位名称', 
  expire_cust_cnt int COMMENT '到期客户数', 
  expire_no_renewal_cust_cnt int COMMENT '当月到期未续约客户', 
  expire_renewal_cust_cnt int COMMENT '当月到期当月续约客户数', 
  expire_pre_renewal_cust_cnt int COMMENT '当月到期提前续约客户数', 
  on_expire_renewal_cust_cnt int COMMENT '断约挽回客户数', 
  pre_expire_renewal_cust_cnt int COMMENT '提前续约客户数', 
  renewal_ratio_numerator int COMMENT '合同期内续约客户数', 
  renewal_ratio_denominator int COMMENT '合同期内到期客户数', 
  renewal_ratio float COMMENT '合同期内续约率', 
  renewal_contract_amount float COMMENT '合同期内续约金额', 
  renewal_contract_price float COMMENT '合同期内续约单价', 
  universe_renewal_numerator int COMMENT '广义续约客户数', 
  universe_renewal_denominator int COMMENT '广义到期客户数', 
  universe_renewal_ratio float COMMENT '广义续约率', 
  universe_renewal_contract_amount float COMMENT '广义续约金额', 
  universe_renewal_contract_price float COMMENT '广义续约单价', 
  renewal_amount float COMMENT '当期续约合同金额', 
  renewal_contract_amount_ratio float COMMENT '金额续约率', 
  customer_ids string COMMENT '明细客户列表', 
  creation_timestamp timestamp COMMENT '时间戳')
COMMENT 'rps续约率报表-顾问维度';

create table fact_h_gcdc_d_renewal_rpsuser
(
  d_date int comment '统计日期',
  rps_user_id int comment '招服顾问ID',
  rps_user_name varchar(50) comment '招服顾问姓名',
  org_id int comment '招服顾问小组ID',
  org_name varchar(50) comment '招服顾问小组名称',
  branch_id int comment '地区ID',
  branch_name varchar(50) comment '地区名称',
  position_id int comment '岗位ID',
  position_name varchar(50) comment '岗位名称',   
  expire_cust_cnt int  comment '到期客户数', 
  expire_no_renewal_cust_cnt int comment '当月到期未续约客户',  
  expire_renewal_cust_cnt int  comment '当月到期当月续约客户数', 
  expire_pre_renewal_cust_cnt int  comment '当月到期提前续约客户数', 
  on_expire_renewal_cust_cnt int  comment '断约挽回客户数',  
  pre_expire_renewal_cust_cnt int  comment '提前续约客户数', 
  renewal_ratio_numerator int  comment '合同期内续约客户数', 
  renewal_ratio_denominator int  comment '合同期内到期客户数', 
  renewal_ratio float  comment '合同期内续约率', 
  renewal_contract_amount float  comment '合同期内续约金额',  
  renewal_contract_price float  comment '合同期内续约单价', 
  universe_renewal_numerator int  comment '广义续约客户数',  
  universe_renewal_denominator int  comment '广义到期客户数',
  universe_renewal_ratio float  comment '广义续约率',
  universe_renewal_contract_amount float  comment '广义续约金额', 
  universe_renewal_contract_price float  comment '广义续约单价',
  renewal_amount float  comment '当期续约合同金额',     
  renewal_contract_amount_ratio float  comment '金额续约率',
  customer_ids text comment '明细客户列表', 
  creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
  primary key (d_date,rps_user_id,org_id)
)  comment 'RPS续约率报表-顾问维度';

insert overwrite table fact_h_gcdc_d_renewal_rpsuser
select
  nvl(fact.d_date,19000101) as d_date,
  nvl(fact.rps_user_id,-1) as serviceuser_id,
  nvl(fact.rps_user_name,'未知') as serviceuser_name,
  nvl(fact.rps_org_id,-1) as service_teamorg_id,
  nvl(fact.rps_org_name,'未知') as service_teamorg_name,
  nvl(sorg.branch_id,-1) as service_branch_id,
  nvl(sorg.branch_name,'未知') as service_branch_name,
  nvl(suser.position_id,-1) as serviceuser_position_id,
  nvl(suser.position_name,'未知') as serviceuser_position_name,
  nvl(fact.expire_cust_cnt,0) as expire_cust_cnt,
  nvl(fact.expire_no_renewal_cust_cnt,0) as expire_no_renewal_cust_cnt,
  nvl(fact.expire_renewal_cust_cnt,0) as expire_renewal_cust_cnt,
  nvl(fact.expire_pre_renewal_cust_cnt,0) as expire_pre_renewal_cust_cnt,
  nvl(fact.on_expire_renewal_cust_cnt,0) as on_expire_renewal_cust_cnt,
  nvl(fact.pre_expire_renewal_cust_cnt,0) as pre_expire_renewal_cust_cnt,
  nvl(fact.renewal_ratio_numerator,0) as renewal_ratio_numerator,
  nvl(fact.renewal_ratio_denominator,0) as renewal_ratio_denominator,
  nvl(fact.renewal_ratio,0) as renewal_ratio,
  nvl(fact.renewal_contract_amount,0) as renewal_contract_amount,
  nvl(fact.renewal_contract_price,0) as renewal_contract_price,
  nvl(fact.universe_renewal_numerator,0) as universe_renewal_numerator,
  nvl(fact.universe_renewal_denominator,0) as universe_renewal_denominator,
  nvl(fact.universe_renewal_ratio,0) as universe_renewal_ratio,
  nvl(fact.universe_renewal_contract_amount,0) as universe_renewal_contract_amount,
  nvl(fact.universe_renewal_contract_price,0) as universe_renewal_contract_price,
  nvl(fact.renewal_amount,0) as renewal_amount,
  nvl(fact.renewal_contract_amount_ratio,0) as renewal_contract_amount_ratio,
  0 as customer_ids,
  from_unixtime(unix_timestamp()) as creation_timestamp
from (
    select 
    contract.d_date,
    contract.rps_user_id,
    contract.rps_user_name,
    contract.rps_org_id,
    contract.rps_org_name,
    sum(is_expire) as expire_cust_cnt,
    sum(is_expire_no_renewal) as expire_no_renewal_cust_cnt,
    sum(is_expire_renewal) as expire_renewal_cust_cnt,
    sum(is_expire_pre_renewal) as expire_pre_renewal_cust_cnt,
    sum(is_on_expire_renewal) as on_expire_renewal_cust_cnt,
    sum(is_pre_expire_renewal) as pre_expire_renewal_cust_cnt,
    (sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) as renewal_ratio_numerator,
    (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as renewal_ratio_denominator,
    (sum(is_expire_renewal) + sum(is_pre_expire_renewal) ) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal)) as renewal_ratio,
    sum(is_expire_renewal*contract_money) + sum(is_pre_expire_renewal*contract_money) as renewal_contract_amount,
    (sum(is_expire_renewal*contract_money) + sum(is_pre_expire_renewal*contract_money)) / (sum(is_expire_renewal) + sum(is_pre_expire_renewal)) as renewal_contract_price,
    sum(is_expire_renewal) + sum(is_pre_expire_renewal) + sum(is_on_expire_renewal) as universe_renewal_numerator,
    sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal) + sum(is_on_expire_renewal) as universe_renewal_denominator,
    (sum(is_expire_renewal) + sum(is_pre_expire_renewal) + sum(is_on_expire_renewal)) / (sum(is_expire) + sum(is_pre_expire_renewal) - sum(is_expire_pre_renewal) + sum(is_on_expire_renewal)) as universe_renewal_ratio,
    sum(is_expire_renewal*contract_money) + sum(is_pre_expire_renewal*contract_money) + sum(is_on_expire_renewal*contract_money) as universe_renewal_contract_amount,
    (sum(is_expire_renewal*contract_money) + sum(is_pre_expire_renewal*contract_money) + sum(is_on_expire_renewal*contract_money)) / (sum(is_expire_renewal) + sum(is_pre_expire_renewal) +  sum(is_on_expire_renewal)) as universe_renewal_contract_price,
    sum(is_expire_renewal*next_contract_money) + sum(is_pre_expire_renewal*next_contract_money) as renewal_amount,
    (sum(is_expire_renewal*next_contract_money) + sum(is_pre_expire_renewal*next_contract_money)) / (sum(is_expire_renewal*contract_money) + sum(is_pre_expire_renewal*contract_money)) as renewal_contract_amount_ratio
    from dw_erp_d_gcdc_contract_list_rpsuser contract
    where p_date = $date$
    group by contract.d_date,contract.rps_user_id,contract.rps_user_name,contract.rps_org_id,contract.rps_org_name
) fact 
left join dw_erp_d_salesuser_base suser
on fact.rps_user_id = suser.id
and suser.p_date = $date$
left join dim_org sorg 
on fact.rps_org_id = sorg.d_org_id


alter table fact_h_gcdc_d_renewal_rpsuser rename to fact_h_gcdc_d_renewal_rpsuser_0118;
alter table fact_h_gcdc_d_renewal_rpsuser rename to fact_h_gcdc_d_renewal_rpsuser;

,
  custcontract.renew_intention,
  custcontract.contract_money_level

--获取客户续约率统计明细信息【Rps名下】
select
  custcontract.contract_no as contract_no,
  custcontract.contract_id as contract_id,
  custcontract.contract_account_date as d_date,
  custcontract.customer_id as cust_id,
  custcontract.before_contract_account_date as before_accounted_date,
  custcontract.next_contract_account_date as next_accounted_date,
  custcontract.contract_money as contract_money,
  custcontract.before_contract_money as before_countract_money,
  custcontract.next_contract_money as next_countract_money,
  custcontract.contract_expire_date as contract_expire_date,
  custcontract.next_contract_expire_date as contract_next_expire_date,
  custcontract.before_contract_expire_date as contract_before_expire_date,
  custcontract.customer_name as customer_name,
  custcontract.before_contract_no as before_contract_no,
  custcontract.next_contract_no as next_contract_no,
  custcontract.rps_user_id as rps_user_id,
  custcontract.rps_user_name as rps_user_name,
  custcontract.rps_position_id as position_id,
  custcontract.rps_position_name as position_name,
  custcontract.rps_org_id as org_id,
  custcontract.rps_org_name as org_name,
  custcontract.rps_branch_id as branch_id,
  custcontract.rps_branch_name as branch_name,
  ${cust_renewal_kind} as cust_renewal_kind,
  custcontract.renew_intention,
  custcontract.contract_money_level
from 
  dw_erp_a_gcdc_contract_list_rpsuser custcontract 
where 
  custcontract.d_date = ${stat_date}
  and custcontract.rps_user_id = IF(${rps_user_id}=0,custcontract.rps_user_id,${rps_user_id})
  and custcontract.rps_org_id = IF(${org_id}=0,custcontract.rps_org_id,${org_id})
  and custcontract.rps_branch_id = IF(${branch_id}=0,custcontract.rps_branch_id,${branch_id}) 
  and (case ${cust_renewal_kind} 
        when 1 then is_expire
        when 2 then is_expire_renewal
        when 3 then is_expire_pre_renewal
        when 4 then is_expire_no_renewal
        when 5 then is_on_expire_renewal
        when 6 then is_pre_expire_renewal
      end) = 1
  limit ${current_page},${page_size}


--获取客户续约率统计明细信息【Rps名下】记录数
select
  count(1) as total_count 
from 
  dw_erp_a_gcdc_contract_list_rpsuser custcontract 
where 
  custcontract.d_date = ${stat_date}
  and custcontract.rps_user_id = IF(${rps_user_id}=0,custcontract.rps_user_id,${rps_user_id})
  and custcontract.rps_org_id = IF(${org_id}=0,custcontract.rps_org_id,${org_id})
  and custcontract.rps_branch_id = IF(${branch_id}=0,custcontract.rps_branch_id,${branch_id}) 
  and (case ${cust_renewal_kind} 
        when 1 then is_expire
        when 2 then is_expire_renewal
        when 3 then is_expire_pre_renewal
        when 4 then is_expire_no_renewal
        when 5 then is_on_expire_renewal
        when 6 then is_pre_expire_renewal
      end) = 1