alter table dw_erp_d_customer_base_new change is_sub_package_customer is_sub_package_customer int comment ' 是否包成员客户';

create table if not exists dw_erp_d_customer_base_new(
id int comment ' 企业ID ',
name string comment ' 企业名称 ',
dq string comment ' 地区 ',
source int comment '来源1-51job,2:智联招聘',
sign_lpt_type int comment ' 签署合同类型  0 未签约 1 合作 2 断约 ',
industry string comment ' 行业 ',
company_scale string comment ' 公司规模 ',
company_kind string comment ' 公司性质 ',
company_certificate string comment ' 认证信息 ',
cachet_certificate string comment ' 红章营业执照 ',
reg_cap string comment ' 注册资金 ',
reg_date string comment ' 注册日期 ',
fax string comment ' 传真 ',
addr string comment ' 地址 ',
zip string comment ' 邮编 ',
web string comment ' 网址 ',
memo string comment ' 备注 ',
last_lock_time string comment ' 最后一次锁定时间 ',
input_id int comment ' 录入人ID ',
createtime string comment ' 创建时间 ',
modifytime string comment ' 修改时间 ',
ecomp_id int comment ' 机构id ',
ecomp_root_id int comment ' 机构root_id ',
parent_customer_id int comment ' 父客户id 为0时是父客户 ',
is_sub_package_customer int comment ' 是否包成员客户',
ecomp_version int comment ' 企业版本 ',
sales_user_id int comment ' 当前销售顾问id ',
sales_user_name string comment ' 当前销售顾问姓名 ',
sales_org_id int comment ' 当前销售部门id ',
sales_org_name string comment ' 当前销售部门名称 ',
sales_branch_id int comment ' 当前销售分公司 ',
sales_branch_name string comment ' 当前销售分公司名称 ',
repertory_industry string comment ' 客户深耕行业 ',
base_type int comment ' 客户库类型 ',
repertory_level int comment ' 客户深耕级别 ',
repertory_branch_id int comment ' 客户深耕所属分公司 ',
is_reserved int comment ' 是否保留：0 不保留，1 保留 ',
sales_tag_ids string comment ' 销售自定义标签，多个间用英文逗号分隔 ',
release_date string comment ' 客户释放时间 ',
serviceuser_id int comment ' 招服ID ',
serviceuser_name string comment ' 招服姓名 ',
service_teamorg_id int comment ' 招服团队ID ',
service_teamorg_name string comment ' 招服团队名称 ',
service_branch_id int comment '招服所属分公司',
service_branch_name string comment '招服所属分公司名称',
rps_service_version int comment ' RPS服务版本， 0：不服务 ,1：服务版, 2：服务过期版,3：服务版未到期 ',
rsc_allocation_type int comment ' 分配类型：1,系统自动分配、2,手动分配、3,待分配、4,完善交付信息、5,退回销售 ',
rsc_valid_status int comment ' 招服服务的客户有效标示：1:有效、0:无效客户 ',
rsc_valid_reason int comment ' 招服服务的客户无效原因 ',
delete_flag int comment ' CRM客户删除标记 ',
rsc_delete_flag int comment ' RSC客户删除标记 ',
creation_timestamp timestamp comment ' 时间戳 '
);

alter table dw_erp_d_customer_base add columns(top_mark string comment '客户TOP标识',top_mark_date string comment 'top_mark_date');

alter table dw_erp_d_customer_base add columns(rsc_service_startdate string comment '客户服务开始时间',rsc_service_enddate string comment '服务结束时间') cascade;
alter table dw_erp_d_customer_base_new add columns(rsc_service_startdate string comment '客户服务开始时间',rsc_service_enddate string comment '服务结束时间') ;

alter table dw_erp_d_customer_base add columns(my_customer_type int comment '客户类型:0-目标客户,1-保留客户,2-合作客户,3-在我名下断约客户') cascade;
alter table dw_erp_d_customer_base_new add columns(my_customer_type int comment '客户类型:0-目标客户,1-保留客户,2-合作客户,3-在我名下断约客户') ;
 

insert overwrite table dw_erp_d_customer_base_new
select 
nvl(customer.customer_id,-1) as id,
nvl(customer.customer_name,'未知') as name,
nvl(customer.dq,'999') as dq,
nvl(customer.source,-1) as source,
nvl(crm.sign_lpt_type,-1) as sign_lpt_type,
nvl(customer.industry,'999') as industry,
nvl(customer.company_scale,'-1') as company_scale,
nvl(customer.company_kind,'-1') as company_kind,
nvl(customer.company_certificate,'-1') as company_certificate,
nvl(customer.cachet_certificate,'-1') as cachet_certificate,
nvl(detail.reg_cap,'-1') as reg_cap,
nvl(detail.reg_date,'1900-01-01') as reg_date,
nvl(detail.fax,'-1') as fax,
nvl(detail.addr,'-1') as addr,
nvl(detail.zip,'-1') as zip,
nvl(detail.web,'-1') as web,
nvl(detail.memo,'-1') as memo,
nvl(crm.last_lock_time,'1900-01-01 00:00:00') as last_lock_time,
nvl(customer.input_id,-1) as input_id,
nvl(customer.createtime,'1900-01-01 00:00:00') as createtime,
nvl(customer.modifytime,'1900-01-01 00:00:00') as modifytime,
nvl(crm.ecomp_id,-1) as ecomp_id,
nvl(ecomp.ecomp_root_id,-1) as ecomp_root_id,
nvl(crm.parent_customer_id,-1) as parent_customer_id,
nvl(case when package.customer_id is not null then 1 else 0 end,-1) as is_sub_package_customer,
nvl(crm.ecomp_version,-1) as ecomp_version,
nvl(crm.creator_id,-1) as sales_user_id,
nvl(saleuser.name,'未知') as sales_user_name,
nvl(crm.org_id,-1) as sales_org_id,
nvl(salesorg.org_name,'未知') as sales_org_name,
nvl(salesorg.branch_id,-1) as sales_branch_id,
nvl(salesorg.branch_name,'未知') as sales_branch_name,
nvl(crm.repertory_industry,'999') as repertory_industry,
nvl(crm.base_type,-1) as base_type,
nvl(crm.repertory_level,-1) as repertory_level,
nvl(crm.repertory_branch_id,-1) as repertory_branch_id,
-1 as is_reserved,
nvl(crm.sales_tag_ids,'-1') as sales_tag_ids,
nvl(crm.release_date,'1900-01-01') as release_date,
nvl(rsc.serviceuser_id,-1) as serviceuser_id,
nvl(rscuser.name,'未知') as serviceuser_name,
nvl(rsc.org_id,-1) as service_teamorg_id,
nvl(serviceorg.org_name,'未知') as service_teamorg_name,
nvl(serviceorg.branch_id,-1) as service_branch_id,
nvl(serviceorg.branch_name,'未知') as service_branch_name,
nvl(rsc.service_version,-1) as rps_service_version,
nvl(rsc.allocation_type,-1) as rsc_allocation_type,
nvl(rsc.valid_status,-1) as rsc_valid_status,
nvl(rsc.valid_reason,-1) as rsc_valid_reason,
nvl(crm.deleteflag,-1) as delete_flag,
nvl(rsc.deleteflag,-1) as rsc_delete_flag,
from_unixtime(unix_timestamp())  as creation_timestamp,
nvl(crm.top_mark,'000000') as top_mark,
nvl(crm.top_mark_date,'1900-01-01') as top_mark_date,
nvl(rce.renew_intention,-1) as renew_intention,
case when rsc.customer_id is not null then reformat_datetime(rsc.service_startdate,'yyyy-MM-dd') else '1900-01-01' end as rsc_service_startdate,
case when rsc.customer_id is not null then reformat_datetime(rsc.service_enddate,'yyyy-MM-dd') else '1900-01-01' end as rsc_service_enddate,
nvl(crm.my_customer_type,-1) as my_customer_type,
nvl(customer.subsource,-1) as subsource,
nvl(rsc.service_center_flag,-1) as service_center_flag
from customer 
left join customer_detail detail 
on customer.customer_id = detail.customer_id
left join crm_customer crm
on customer.customer_id = crm.customer_id
left join rsc_customer rsc
on customer.customer_id = rsc.customer_id
left join rsc_customer_extension rce 
on customer.customer_id = rce.customer_id
left join 
(select distinct member_customer_id as customer_id
  from crm_customer_package
  where master_customer_id <> member_customer_id
    and deleteflag = 0) package
on customer.customer_id = package.customer_id
left outer join 
(select id, name,position_channel,org_id,org_name
from dw_erp_d_salesuser_base 
where p_date = $date$ ) saleuser
on crm.creator_id = saleuser.id
left outer join 
(select id, name,position_channel,org_id,org_name
from dw_erp_d_salesuser_base 
where p_date = $date$ ) rscuser
on rsc.serviceuser_id = rscuser.id
left outer join
(select ecomp_id, ecomp_root_id
from dw_b_d_ecomp_base 
where p_date = $date$ ) ecomp
on crm.ecomp_id = ecomp.ecomp_id
left outer join dim_org salesorg
on crm.org_id = salesorg.d_org_id
left outer join dim_org serviceorg
on rsc.org_id = serviceorg.d_org_id
left outer join dw_erp_a_test_account test 
on customer.customer_id = test.id 
and test.type = 1
where test.id is null ;


, case when base.id = 502900 and base.ecomp_id <> 0 then 31558
	   when base.id = 412680 and base.ecomp_id <> 0 then 94543
	   else parent_customer_id end as parent_customer_id

insert overwrite table dw_erp_d_customer_base partition (p_date)
select 
  base.id
, base.name
, base.dq
, base.source
, base.sign_lpt_type
, base.industry
, base.company_scale
, base.company_kind
, base.company_certificate
, base.cachet_certificate
, base.reg_cap
, base.reg_date
, base.fax
, base.addr
, base.zip
, base.web
, base.memo
, base.last_lock_time
, base.input_id
, base.createtime
, base.modifytime
, base.ecomp_id
, base.ecomp_root_id
, base.parent_customer_id
, base.is_sub_package_customer
, base.ecomp_version
, base.sales_user_id
, base.sales_user_name
, base.sales_org_id
, base.sales_org_name
, base.sales_branch_id
, base.sales_branch_name
, base.repertory_industry
, base.base_type
, base.repertory_level
, base.repertory_branch_id
, base.is_reserved
, base.sales_tag_ids
, base.release_date
, base.serviceuser_id
, base.serviceuser_name
, nvl(rsc.org_id,-1) as service_teamorg_id
, nvl(do.org_name,'未知') as service_teamorg_name
, nvl(do.branch_id,-1) service_branch_id
, nvl(do.branch_name,'未知') service_branch_name
, base.rps_service_version
, base.rsc_allocation_type
, base.rsc_valid_status
, base.rsc_valid_reason
, base.delete_flag
, base.rsc_delete_flag
, base.creation_timestamp
, base.top_mark
, base.top_mark_date
, base.renew_intention
, base.rsc_service_startdate
, base.rsc_service_enddate
, base.my_customer_type
, base.subsource
, nvl(rsc.service_center_flag,-1) as service_center_flag
, base.p_date
from dw_erp_d_customer_base base 
left join recovery.rsc_customer_history_20170201_20170708 rsc 
on base.id = rsc.customer_id 
and base.p_date = rsc.p_date
and rsc.p_date between {{start_date}} and {{end_date}}
left join dim_org do 
on rsc.org_id = do.d_org_id
where base.p_date between {{start_date}} and {{end_date}};




insert overwrite table dw_erp_d_customer_base partition (p_date)
select 
  base.id
, base.name
, base.dq
, base.source
, base.sign_lpt_type
, base.industry
, base.company_scale
, base.company_kind
, base.company_certificate
, base.cachet_certificate
, base.reg_cap
, base.reg_date
, base.fax
, base.addr
, base.zip
, base.web
, base.memo
, base.last_lock_time
, base.input_id
, base.createtime
, base.modifytime
, base.ecomp_id
, base.ecomp_root_id
, base.parent_customer_id
, base.is_sub_package_customer
, base.ecomp_version
, base.sales_user_id
, base.sales_user_name
, base.sales_org_id
, base.sales_org_name
, base.sales_branch_id
, base.sales_branch_name
, base.repertory_industry
, base.base_type
, base.repertory_level
, base.repertory_branch_id
, base.is_reserved
, base.sales_tag_ids
, base.release_date
, base.serviceuser_id
, base.serviceuser_name
, nvl(rsc.org_id,-1) as service_teamorg_id
, nvl(rsc.org_name,'未知') as service_teamorg_name
, nvl(rsc.branch_id,-1) service_branch_id
, nvl(rsc.branch_name,'未知') service_branch_name
, base.rps_service_version
, base.rsc_allocation_type
, base.rsc_valid_status
, base.rsc_valid_reason
, base.delete_flag
, base.rsc_delete_flag
, base.creation_timestamp
, base.top_mark
, base.top_mark_date
, base.renew_intention
, base.rsc_service_startdate
, base.rsc_service_enddate
, base.my_customer_type
, base.subsource
, nvl(rsc.service_center_flag,-1) as service_center_flag
, base.p_date
from dw_erp_d_customer_base base 
left join 
(select rsc.customer_id,rsc.org_id,do.org_name,do.branch_id,do.branch_name,service_center_flag,p_date
   from recovery.rsc_customer_history_20170201_20170708 rsc 
   left join dim_org do 
	on rsc.org_id = do.d_org_id
  where rsc.p_date between {{start_date}} and {{end_date}}
) rsc 
on base.id = rsc.customer_id 
and base.p_date = rsc.p_date
where base.p_date between {{start_date}} and {{end_date}}