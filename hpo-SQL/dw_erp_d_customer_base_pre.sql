create table if not exists dw_erp_d_customer_base_pre(
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
) 
partitioned by (p_date int);

insert overwrite table dw_erp_d_customer_base_pre partition(p_date)
select 
nvl(biz_customer.id,-1) as id,
nvl(biz_customer.name,'未知') as name,
nvl(biz_customer.dq,-1) as dq,
nvl(biz_customer.source,-1) as source,
nvl(-1,-1) as sign_lpt_type,
nvl(biz_customer.comp_industry,-1) as industry,
nvl(biz_customer.comp_scale,-1) as company_scale,
nvl(biz_customer.comp_kind,-1) as company_kind,
nvl(case when biz_customer_certification.id is null then '' else '1' end ,'-1') as company_certificate,
nvl('','-1') as cachet_certificate,
nvl(biz_customer.reg_cap,-1) as reg_cap,
nvl(biz_customer.reg_date,'1900-01-01') as reg_date,
nvl(biz_customer.fax,-1) as fax,
nvl(biz_customer.addr,-1) as addr,
nvl(biz_customer.zip,-1) as zip,
nvl(biz_customer.web,-1) as web,
nvl(biz_customer.description,-1) as memo,
nvl(reformat_date(biz_customer.lock_time),'1900-01-01') as last_lock_time,
nvl(biz_customer.input_id,-1) as input_id,
nvl(biz_customer.create_time,'1900-01-01 00:00:00') as createtime,
nvl(biz_customer.modify_time,'1900-01-01 00:00:00') as modifytime,
nvl(biz_customer.ecomp_id,-1) as ecomp_id,
nvl(ecomp.ecomp_root_id,-1) as ecomp_root_id,
nvl(biz_customer.parent_id,-1) as parent_customer_id,
nvl(case when biz_customer.packagecust_id = '-1' then 0 else 1 end ,-1) as is_sub_package_customer,
nvl(biz_customer.ecomp_version,-1) as ecomp_version,
nvl(biz_customer.creator_id,-1) as sales_user_id,
nvl(portal_employee.name,'未知') as sales_user_name,
nvl(biz_customer.org_id,-1) as sales_org_id,
nvl(dim_org.org_name,'未知') as sales_org_name,
nvl(dim_org.branch_id,-1) as sales_branch_id,
nvl(dim_org.branch_name,'未知') as sales_branch_name,
nvl(biz_customer.repertoryindustry,-1) as repertory_industry,
nvl(biz_customer.repertorykind,-1) as base_type,
nvl(biz_customer.repertorylevel,-1) as repertory_level,
nvl(biz_customer.repertorybranch_id,-1) as repertory_branch_id,
nvl(-1,-1) as is_reserved,
nvl(-1,-1) as sales_tag_ids,
nvl('1900-01-01',-1) as release_date,
nvl(biz_customer.service_user_id,-1) as serviceuser_id,
nvl(suser.name,'未知') as serviceuser_name,
nvl(crm_rsc_customer.teamorg_id,-1) as service_teamorg_id,
nvl(sorg.org_name,'未知') as service_teamorg_name,
nvl(sorg.branch_id,-1) as service_branch_id,
nvl(sorg.branch_name,'未知') as service_branch_name,
nvl(-1,-1) as rps_service_version,
nvl(crm_rsc_customer.allocation_type,-1) as rsc_allocation_type,
nvl(crm_rsc_customer.valid_status,-1) as rsc_valid_status,
nvl(crm_rsc_customer.valid_reason,-1) as rsc_valid_reason,
nvl(biz_customer.delete_flag,-1) as delete_flag,
nvl(crm_rsc_customer.deleteflag,-1) as rsc_delete_flag,
from_unixtime(unix_timestamp())  as creation_timestamp,
biz_customer.p_date
from recovery.biz_customer_history_20160101_20160510 biz_customer
left join recovery.biz_customer_certification_history_20160303_20160715 biz_customer_certification
on biz_customer.id = biz_customer_certification.customer_id
and biz_customer_certification.deleteflag = 0
and biz_customer.p_date = biz_customer_certification.p_date
left join recovery.crm_rsc_customer_history_20160101_20160715 crm_rsc_customer
on biz_customer.id = crm_rsc_customer.customer_id
and crm_rsc_customer.deleteflag = 0
and biz_customer.p_date = crm_rsc_customer.p_date
left join dim_org
on biz_customer.org_id = dim_org.d_org_id
left join dim_org sorg 
on crm_rsc_customer.teamorg_id = sorg.d_org_id 
left join dw_b_d_ecomp_base ecomp 
on biz_customer.ecomp_id = ecomp.ecomp_id
and biz_customer.p_date=ecomp.p_date
left join portal_employee 
on biz_customer.creator_id = portal_employee.id 
and portal_employee.deleteflag = 0
left join portal_employee suser 
on suser.deleteflag = 0
and biz_customer.service_user_id = suser.id
left outer join dw_erp_a_test_account test 
on biz_customer.id = test.id 
and test.type = 1
where biz_customer.p_date between 20160303 and 20160331
and test.id is null ;

biz_customer_history_20160511_20160611
biz_customer_history_20160612_20160612
biz_customer_history_20160613_20160715



insert overwrite table dw_erp_d_customer_base_pre partition(p_date)
select 
nvl(biz_customer.id,-1) as id,
nvl(biz_customer.name,'未知') as name,
nvl(biz_customer.dq,-1) as dq,
nvl(biz_customer.source,-1) as source,
nvl(-1,-1) as sign_lpt_type,
nvl(biz_customer.comp_industry,-1) as industry,
nvl(biz_customer.comp_scale,-1) as company_scale,
nvl(biz_customer.comp_kind,-1) as company_kind,
nvl(case when biz_customer_certification.id is null then '' else '1' end ,'-1') as company_certificate,
nvl('','-1') as cachet_certificate,
nvl(biz_customer.reg_cap,-1) as reg_cap,
nvl(biz_customer.reg_date,'1900-01-01') as reg_date,
nvl(biz_customer.fax,-1) as fax,
nvl(biz_customer.addr,-1) as addr,
nvl(biz_customer.zip,-1) as zip,
nvl(biz_customer.web,-1) as web,
nvl(biz_customer.description,-1) as memo,
nvl(reformat_date(biz_customer.lock_time),'1900-01-01') as last_lock_time,
nvl(biz_customer.input_id,-1) as input_id,
nvl(biz_customer.create_time,'1900-01-01 00:00:00') as createtime,
nvl(biz_customer.modify_time,'1900-01-01 00:00:00') as modifytime,
nvl(biz_customer.ecomp_id,-1) as ecomp_id,
nvl(ecomp.ecomp_root_id,-1) as ecomp_root_id,
nvl(biz_customer.parent_id,-1) as parent_customer_id,
nvl(case when crm_customer_package.id is null then 0 else 1 end ,-1) as is_sub_package_customer,
nvl(biz_customer.ecomp_version,-1) as ecomp_version,
nvl(biz_customer.creator_id,-1) as sales_user_id,
nvl(portal_employee.name,'未知') as sales_user_name,
nvl(biz_customer.org_id,-1) as sales_org_id,
nvl(dim_org.org_name,'未知') as sales_org_name,
nvl(dim_org.branch_id,-1) as sales_branch_id,
nvl(dim_org.branch_name,'未知') as sales_branch_name,
nvl(-1,-1) as repertory_industry,
nvl(-1,-1) as base_type,
nvl(-1,-1) as repertory_level,
nvl(-1,-1) as repertory_branch_id,
nvl(-1,-1) as is_reserved,
nvl(-1,-1) as sales_tag_ids,
nvl('1900-01-01',-1) as release_date,
nvl(biz_customer.service_user_id,-1) as serviceuser_id,
nvl(suser.name,'未知') as serviceuser_name,
nvl(crm_rsc_customer.teamorg_id,-1) as service_teamorg_id,
nvl(sorg.org_name,'未知') as service_teamorg_name,
nvl(sorg.branch_id,-1) as service_branch_id,
nvl(sorg.branch_name,'未知') as service_branch_name,
nvl(-1,-1) as rps_service_version,
nvl(crm_rsc_customer.allocation_type,-1) as rsc_allocation_type,
nvl(crm_rsc_customer.valid_status,-1) as rsc_valid_status,
nvl(crm_rsc_customer.valid_reason,-1) as rsc_valid_reason,
nvl(biz_customer.delete_flag,-1) as delete_flag,
nvl(crm_rsc_customer.deleteflag,-1) as rsc_delete_flag,
from_unixtime(unix_timestamp())  as creation_timestamp,
biz_customer.p_date
from recovery.biz_customer_history_20160511_20160611 biz_customer
left join recovery.biz_customer_certification_history_20160303_20160715 biz_customer_certification
on biz_customer.id = biz_customer_certification.customer_id
and biz_customer_certification.deleteflag = 0
and biz_customer.p_date = biz_customer_certification.p_date
left join recovery.crm_rsc_customer_history_20160101_20160715 crm_rsc_customer
on biz_customer.id = crm_rsc_customer.customer_id
and crm_rsc_customer.deleteflag = 0
and biz_customer.p_date = crm_rsc_customer.p_date
left join dim_org
on biz_customer.org_id = dim_org.d_org_id
left join dim_org sorg 
on crm_rsc_customer.teamorg_id = sorg.d_org_id 
left join dw_b_d_ecomp_base ecomp 
on biz_customer.ecomp_id = ecomp.ecomp_id
and biz_customer.p_date=ecomp.p_date
left join portal_employee 
on biz_customer.creator_id = portal_employee.id 
and portal_employee.deleteflag = 0
left join portal_employee suser 
on suser.deleteflag = 0
and biz_customer.service_user_id = suser.id
left outer join dw_erp_a_test_account test 
on biz_customer.id = test.id 
and test.type = 1
left join crm_customer_package 
on biz_customer.id = crm_customer_package.member_customer_id
and crm_customer_package.deleteflag = 0
where biz_customer.p_date between 20160511 and 20160611
and test.id is null ;




insert overwrite table dw_erp_d_customer_base_pre partition(p_date)
select 
nvl(biz_customer.id,-1) as id,
nvl(biz_customer.name,'未知') as name,
nvl(biz_customer.dq,-1) as dq,
nvl(biz_customer.source,-1) as source,
nvl(-1,-1) as sign_lpt_type,
nvl(biz_customer.comp_industry,-1) as industry,
nvl(biz_customer.comp_scale,-1) as company_scale,
nvl(biz_customer.comp_kind,-1) as company_kind,
nvl(case when biz_customer_certification.id is null then '' else '1' end ,'-1') as company_certificate,
nvl('','-1') as cachet_certificate,
nvl(biz_customer.reg_cap,-1) as reg_cap,
nvl(biz_customer.reg_date,'1900-01-01') as reg_date,
nvl(biz_customer.fax,-1) as fax,
nvl(biz_customer.addr,-1) as addr,
nvl(biz_customer.zip,-1) as zip,
nvl(biz_customer.web,-1) as web,
nvl(biz_customer.description,-1) as memo,
nvl(reformat_date(biz_customer.lock_time),'1900-01-01') as last_lock_time,
nvl(biz_customer.input_id,-1) as input_id,
nvl(biz_customer.create_time,'1900-01-01 00:00:00') as createtime,
nvl(biz_customer.modify_time,'1900-01-01 00:00:00') as modifytime,
nvl(biz_customer.ecomp_id,-1) as ecomp_id,
nvl(ecomp.ecomp_root_id,-1) as ecomp_root_id,
nvl(biz_customer.parent_id,-1) as parent_customer_id,
nvl(case when crm_customer_package.id is null then 0 else 1 end ,-1) as is_sub_package_customer,
nvl(biz_customer.ecomp_version,-1) as ecomp_version,
nvl(biz_customer.creator_id,-1) as sales_user_id,
nvl(portal_employee.name,'未知') as sales_user_name,
nvl(biz_customer.org_id,-1) as sales_org_id,
nvl(dim_org.org_name,'未知') as sales_org_name,
nvl(dim_org.branch_id,-1) as sales_branch_id,
nvl(dim_org.branch_name,'未知') as sales_branch_name,
nvl(biz_customer.repertoryindustry,-1) as repertory_industry,
nvl(biz_customer.repertorykind,-1) as base_type,
nvl(biz_customer.repertorylevel,-1) as repertory_level,
nvl(biz_customer.repertorybranch_id,-1) as repertory_branch_id,
nvl(-1,-1) as is_reserved,
nvl(-1,-1) as sales_tag_ids,
nvl('1900-01-01',-1) as release_date,
nvl(biz_customer.service_user_id,-1) as serviceuser_id,
nvl(suser.name,'未知') as serviceuser_name,
nvl(crm_rsc_customer.teamorg_id,-1) as service_teamorg_id,
nvl(sorg.org_name,'未知') as service_teamorg_name,
nvl(sorg.branch_id,-1) as service_branch_id,
nvl(sorg.branch_name,'未知') as service_branch_name,
nvl(-1,-1) as rps_service_version,
nvl(crm_rsc_customer.allocation_type,-1) as rsc_allocation_type,
nvl(crm_rsc_customer.valid_status,-1) as rsc_valid_status,
nvl(crm_rsc_customer.valid_reason,-1) as rsc_valid_reason,
nvl(biz_customer.delete_flag,-1) as delete_flag,
nvl(crm_rsc_customer.deleteflag,-1) as rsc_delete_flag,
from_unixtime(unix_timestamp())  as creation_timestamp,
biz_customer.p_date
from recovery.biz_customer_history_20160613_20160715 biz_customer
left join recovery.biz_customer_certification_history_20160303_20160715 biz_customer_certification
on biz_customer.id = biz_customer_certification.customer_id
and biz_customer_certification.deleteflag = 0
and biz_customer.p_date = biz_customer_certification.p_date
left join recovery.crm_rsc_customer_history_20160101_20160715 crm_rsc_customer
on biz_customer.id = crm_rsc_customer.customer_id
and crm_rsc_customer.deleteflag = 0
and biz_customer.p_date = crm_rsc_customer.p_date
left join dim_org
on biz_customer.org_id = dim_org.d_org_id
left join dim_org sorg 
on crm_rsc_customer.teamorg_id = sorg.d_org_id 
left join dw_b_d_ecomp_base ecomp 
on biz_customer.ecomp_id = ecomp.ecomp_id
and biz_customer.p_date=ecomp.p_date
left join portal_employee 
on biz_customer.creator_id = portal_employee.id 
and portal_employee.deleteflag = 0
left join portal_employee suser 
on suser.deleteflag = 0
and biz_customer.service_user_id = suser.id
left outer join dw_erp_a_test_account test 
on biz_customer.id = test.id 
and test.type = 1
left join crm_customer_package 
on biz_customer.id = crm_customer_package.member_customer_id
and crm_customer_package.deleteflag = 0
where biz_customer.p_date between 20160613 and 20160715
and test.id is null ;

insert overwrite table dw_erp_d_customer_base_pre partition(p_date)
select 
nvl(biz_customer.id,-1) as id,
nvl(biz_customer.name,'未知') as name,
nvl(biz_customer.dq,-1) as dq,
nvl(biz_customer.source,-1) as source,
nvl(-1,-1) as sign_lpt_type,
nvl(biz_customer.compindustry,-1) as industry,
nvl(biz_customer.compscale,-1) as company_scale,
nvl(biz_customer.compkind,-1) as company_kind,
nvl(case when biz_customer_certification.id is null then '' else '1' end ,'-1') as company_certificate,
nvl('','-1') as cachet_certificate,
nvl(biz_customer.regcap,-1) as reg_cap,
nvl(biz_customer.regdate,'1900-01-01') as reg_date,
nvl(biz_customer.fax,-1) as fax,
nvl(biz_customer.addr,-1) as addr,
nvl(biz_customer.zip,-1) as zip,
nvl(biz_customer.web,-1) as web,
nvl(biz_customer.description,-1) as memo,
nvl(reformat_date(biz_customer.locktime),'1900-01-01') as last_lock_time,
nvl(biz_customer.input_id,-1) as input_id,
nvl(biz_customer.createtime,'1900-01-01 00:00:00') as createtime,
nvl(biz_customer.modifytime,'1900-01-01 00:00:00') as modifytime,
nvl(biz_customer.ecomp_id,-1) as ecomp_id,
nvl(ecomp.ecomp_root_id,-1) as ecomp_root_id,
nvl(biz_customer.parent_id,-1) as parent_customer_id,
nvl(case when crm_customer_package.id is null then 0 else 1 end ,-1) as is_sub_package_customer,
nvl(biz_customer.ecompversion,-1) as ecomp_version,
nvl(biz_customer.creator_id,-1) as sales_user_id,
nvl(portal_employee.name,'未知') as sales_user_name,
nvl(biz_customer.org_id,-1) as sales_org_id,
nvl(dim_org.org_name,'未知') as sales_org_name,
nvl(dim_org.branch_id,-1) as sales_branch_id,
nvl(dim_org.branch_name,'未知') as sales_branch_name,
nvl(biz_customer.repertoryindustry,-1) as repertory_industry,
nvl(biz_customer.repertorykind,-1) as base_type,
nvl(biz_customer.repertorylevel,-1) as repertory_level,
nvl(biz_customer.repertorybranch_id,-1) as repertory_branch_id,
nvl(-1,-1) as is_reserved,
nvl(-1,-1) as sales_tag_ids,
nvl('1900-01-01',-1) as release_date,
nvl(biz_customer.serviceuser_id,-1) as serviceuser_id,
nvl(suser.name,'未知') as serviceuser_name,
nvl(crm_rsc_customer.teamorg_id,-1) as service_teamorg_id,
nvl(sorg.org_name,'未知') as service_teamorg_name,
nvl(sorg.branch_id,-1) as service_branch_id,
nvl(sorg.branch_name,'未知') as service_branch_name,
nvl(-1,-1) as rps_service_version,
nvl(crm_rsc_customer.allocation_type,-1) as rsc_allocation_type,
nvl(crm_rsc_customer.valid_status,-1) as rsc_valid_status,
nvl(crm_rsc_customer.valid_reason,-1) as rsc_valid_reason,
nvl(biz_customer.deleteflag,-1) as delete_flag,
nvl(crm_rsc_customer.deleteflag,-1) as rsc_delete_flag,
from_unixtime(unix_timestamp())  as creation_timestamp,
biz_customer.p_date
from recovery.biz_customer_history_20160612_20160612 biz_customer
left join recovery.biz_customer_certification_history_20160303_20160715 biz_customer_certification
on biz_customer.id = biz_customer_certification.customer_id
and biz_customer_certification.deleteflag = 0
and biz_customer.p_date = biz_customer_certification.p_date
left join recovery.crm_rsc_customer_history_20160101_20160715 crm_rsc_customer
on biz_customer.id = crm_rsc_customer.customer_id
and crm_rsc_customer.deleteflag = 0
and biz_customer.p_date = crm_rsc_customer.p_date
left join dim_org
on biz_customer.org_id = dim_org.d_org_id
left join dim_org sorg 
on crm_rsc_customer.teamorg_id = sorg.d_org_id 
left join dw_b_d_ecomp_base ecomp 
on biz_customer.ecomp_id = ecomp.ecomp_id
and biz_customer.p_date=ecomp.p_date
left join portal_employee 
on biz_customer.creator_id = portal_employee.id 
and portal_employee.deleteflag = 0
left join portal_employee suser 
on suser.deleteflag = 0
and biz_customer.serviceuser_id = suser.id
left outer join dw_erp_a_test_account test 
on biz_customer.id = test.id 
and test.type = 1
left join crm_customer_package 
on biz_customer.id = crm_customer_package.member_customer_id
and crm_customer_package.deleteflag = 0
where biz_customer.p_date between 20160612 and 20160612
and test.id is null ;


insert overwrite table dw_erp_d_customer_base partition (p_date)
select 
base2.id,
base2.name,
base2.dq,
base2.source,
base2.sign_lpt_type,
base2.industry,
base2.company_scale,
base2.company_kind,
base2.company_certificate,
base2.cachet_certificate,
base2.reg_cap,
base2.reg_date,
base2.fax,
base2.addr,
base2.zip,
base2.web,
base2.memo,
base2.last_lock_time,
base2.input_id,
base2.createtime,
base2.modifytime,
base2.ecomp_id,
base2.ecomp_root_id,
base2.parent_customer_id,
base2.is_sub_package_customer,
base2.ecomp_version,
base2.sales_user_id,
base2.sales_user_name,
base2.sales_org_id,
base2.sales_org_name,
base2.sales_branch_id,
base2.sales_branch_name,
base2.repertory_industry,
base2.base_type,
base2.repertory_level,
base2.repertory_branch_id,
base2.is_reserved,
base2.sales_tag_ids,
base2.release_date,
base2.serviceuser_id,
base2.serviceuser_name,
base2.service_teamorg_id,
base2.service_teamorg_name,
base2.service_branch_id,
base2.service_branch_name,
base2.rps_service_version,
base2.rsc_allocation_type,
base2.rsc_valid_status,
base2.rsc_valid_reason,
base2.delete_flag,
base2.rsc_delete_flag,
base2.creation_timestamp,
base2.top_mark,
base2.top_mark_date,
base2.p_date
from (
select 
base.id,
base.name,
base.dq,
base.source,
base.sign_lpt_type,
base.industry,
base.company_scale,
base.company_kind,
base.company_certificate,
base.cachet_certificate,
base.reg_cap,
base.reg_date,
base.fax,
base.addr,
base.zip,
base.web,
base.memo,
base.last_lock_time,
base.input_id,
base.createtime,
base.modifytime,
base.ecomp_id,
base.ecomp_root_id,
base.parent_customer_id,
base.is_sub_package_customer,
base.ecomp_version,
base.sales_user_id,
base.sales_user_name,
base.sales_org_id,
base.sales_org_name,
base.sales_branch_id,
base.sales_branch_name,
base.repertory_industry,
base.base_type,
base.repertory_level,
base.repertory_branch_id,
base.is_reserved,
base.sales_tag_ids,
base.release_date,
base.serviceuser_id,
base.serviceuser_name,
base.service_teamorg_id,
base.service_teamorg_name,
base.service_branch_id,
base.service_branch_name,
base.rps_service_version,
base.rsc_allocation_type,
base.rsc_valid_status,
base.rsc_valid_reason,
base.delete_flag,
base.rsc_delete_flag,
base.creation_timestamp,
base.top_mark,
base.top_mark_date,
base.p_date,
row_number()over(distribute by base.id,base.p_date) as rn 
from dw_erp_d_customer_base base
where base.p_date between 20160716 and 20160731
) base2
where rn = 1;