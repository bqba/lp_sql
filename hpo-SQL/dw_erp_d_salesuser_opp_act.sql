create table dw_erp_d_opportunity_base
(
	id int comment '主键',
	code string comment '编号',
	name string comment '名称',
	customer_id int comment 'customer客户表id',
	linkman_ids string comment '商机的联系人的id列表，逗号分开',
	is_new int comment '商机类型：0 新客户商机 1 老客户商机',
	biz_category int comment '业务类型：1 白领业务,2 猎聘通线上产品,3 RPO,4-校园,5-诚猎通,6-线上线下综合服务业务',
	money string comment '金额',
	delay_times int comment '延期次数',
	finish_date string comment '结束日期',
	expect_income_yyyymm string comment '预计回款年月',
	expect_income_week int comment '预计回款周',
	actual_income_date string comment '实际回款日期',
	is_finish int comment '是否已经结束：0 未结束 1 已结束',
	last_track_date string comment '最后跟进日期',
	process int comment '流程：1 A, 2 B, 3 C',
	process_status int comment '当前状态 1-潜在客户, 2-需求客户,3-有商机,4-已发方案,5-已发合同,6-已开发票,7-已回款,8-丢单,9-取消',
	giveup_reason string comment '丢单原因，只有丢单的时候才填写',
	rpo_manager_id int comment 'rpo行业经理id',
	creator_id int comment '当前维护人id',
	org_id int comment '部门id',
	createtime string comment '创建时间',
	modifytime string comment '修改时间',
	creation_timestamp timestamp comment '时间戳'
) comment '商机实体表'
partitioned by (p_date int);

insert overwrite table dw_erp_d_opportunity_base partition (p_date = $date$)
select
	nvl(id,-1) as id,
	nvl(code,'-1') as code,
	nvl(name,'未知') as name,
	nvl(customer_id,-1) as customer_id,
	nvl(linkman_ids,'-1') as linkman_ids,
	nvl(is_new,-1) as is_new,
	nvl(biz_category,-1) as biz_category,
	nvl(money,0.0) as money,
	nvl(delay_times,0) as delay_times,
	nvl(concat(substr(finish_date,1,4),'-',substr(finish_date,5,2),'-',substr(finish_date,7,2)),'1900-01-01') as finish_date,
	nvl(concat(substr(expect_income_yyyymm,1,4),'-',substr(expect_income_yyyymm,5,2)),'1900-01') as expect_income_yyyymm,
	nvl(expect_income_week,-1) as expect_income_week,
	nvl(concat(substr(actual_income_date,1,4),'-',substr(actual_income_date,5,2),'-',substr(actual_income_date,7,2)),'1900-01-01') as actual_income_date,
	nvl(is_finish,-1) as is_finish,
	nvl(concat(substr(last_track_date,1,4),'-',substr(last_track_date,5,2),'-',substr(last_track_date,7,2)),'1900-01-01') as last_track_date,
	nvl(process,-1) as process,
	nvl(process_status,-1) as process_status,
	nvl(remark,'-1') as remark,
	nvl(giveup_reason,'-1') as giveup_reason,
	nvl(rpo_manager_id,-1) as rpo_manager_id,
	nvl(creator_id,-1) as creator_id,
	nvl(org_id,-1) as org_id,
	nvl(createtime,'1900-01-01 00:00:00,000') as createtime,
	nvl(modifytime,'1900-01-01 00:00:00,000') as modifytime,
	from_unixtime(unix_timestamp()) as creation_timestamp
from crm_opportunity
where deleteflag = 0 ;


insert overwrite table dw_erp_d_opportunity_base partition (p_date)
select
	nvl(id,-1) as id,
	nvl(code,'-1') as code,
	nvl(name,'未知') as name,
	nvl(customer_id,-1) as customer_id,
	nvl(linkman_ids,'-1') as linkman_ids,
	nvl(is_new,-1) as is_new,
	nvl(biz_category,-1) as biz_category,
	nvl(money,0.0) as money,
	nvl(delay_times,0) as delay_times,
	nvl(concat(substr(finish_date,1,4),'-',substr(finish_date,5,2),'-',substr(finish_date,7,2)),'1900-01-01') as finish_date,
	nvl(concat(substr(expect_income_yyyymm,1,4),'-',substr(expect_income_yyyymm,5,2)),'1900-01') as expect_income_yyyymm,
	nvl(expect_income_week,-1) as expect_income_week,
	nvl(concat(substr(actual_income_date,1,4),'-',substr(actual_income_date,5,2),'-',substr(actual_income_date,7,2)),'1900-01-01') as actual_income_date,
	nvl(is_finish,-1) as is_finish,
	nvl(concat(substr(last_track_date,1,4),'-',substr(last_track_date,5,2),'-',substr(last_track_date,7,2)),'1900-01-01') as last_track_date,
	nvl(process,-1) as process,
	nvl(process_status,-1) as process_status,
	nvl(remark,'-1') as remark,
	nvl(giveup_reason,'-1') as giveup_reason,
	nvl(rpo_manager_id,-1) as rpo_manager_id,
	nvl(creator_id,-1) as creator_id,
	nvl(org_id,-1) as org_id,
	nvl(createtime,'1900-01-01 00:00:00,000') as createtime,
	nvl(modifytime,'1900-01-01 00:00:00,000') as modifytime,
	from_unixtime(unix_timestamp()) as creation_timestamp,
	p_date
from recovery.crm_opportunity_history_20160821_20160913
where deleteflag = 0 
and p_date between 20160821 and 20160912


create table dw_erp_d_salesuser_opp_act
(
 d_date int comment '统计日期',
 sales_id int comment '销售顾问主键',
 sales_name string comment '销售顾问姓名',
 entrydate string comment '入职日期',
 formaldate string comment '转正日期',
 position_id int comment '岗位主键',
 position_name string comment '岗位名称',
 position_channel string comment '岗位渠道',
 position_level string comment '岗位级别',
 org_id int comment '组织主键',
 org_name string comment '组织名称',
 repertory_industry string comment '深耕行业',
 parent_salesuser_id int comment '汇报对象主键',
 parent_salesuser_name string comment '汇报对象名称',
 parent_salesuser_id_list string comment '汇报对象及所有上级列表',
 grade int comment '级次',
 is_sales_agent int comment '是否基础销售',
 is_work_on int comment '是否在岗',
 biz_category int comment '商机业务类型',
 process_status int comment '商机进程状态',
 opp_cnt int comment '商机单数',
 opp_amount float comment '商机金额',
 opp_pre_amount float comment '商机预测金额',
 opp_contract_amount float comment '商机合同金额',
 opp_income_cnt int comment '本月商机回款单数', 
 opp_income_contract_amount float comment '本月商机回款金额', 
 opp_add_cnt int comment '本月新增商机单数', 
 opp_add_contract_amount float comment '本月新增商机金额',  
 creation_timestamp timestamp comment '时间戳'
) partitioned by (p_date int);

create table dw_erp_d_salesuser_opp_act
(
 d_date int comment '统计日期',
 sales_id int comment '销售顾问主键',
 sales_name varchar(100) comment '销售顾问姓名',
 entrydate varchar(100) comment '入职日期',
 formaldate varchar(100) comment '转正日期',
 position_id int comment '岗位主键',
 position_name varchar(100) comment '岗位名称',
 position_channel varchar(100) comment '岗位渠道',
 position_level varchar(100) comment '岗位级别',
 org_id int comment '组织主键',
 org_name varchar(100) comment '组织名称',
 repertory_industry varchar(100) comment '深耕行业',
 parent_salesuser_id int comment '汇报对象主键',
 parent_salesuser_name varchar(100) comment '汇报对象名称',
 parent_salesuser_id_list varchar(100) comment '汇报对象及所有上级列表',
 grade int comment '级次',
 is_sales_agent int comment '是否基础销售',
 is_work_on int comment '是否在岗',
 biz_category int comment '商机业务类型',
 process_status int comment '商机进度状态',
 opp_cnt int comment '本月预计回款商机单数',
 opp_amount float comment '本月预计回款商机金额',
 opp_pre_amount float comment '本月预计回款商机预测金额',
 opp_contract_amount float comment '本月预计回款商机合同金额',
 opp_income_cnt int comment '本月商机回款单数', 
 opp_income_contract_amount float comment '本月商机回款金额', 
 opp_add_cnt int comment '本月新增商机单数', 
 opp_add_contract_amount float comment '本月新增商机金额', 
 creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
 primary key (d_date,sales_id,org_id,biz_category,process_status)
);

alter table dw_erp_d_salesuser_opp_act change opp_amount opp_amount float comment '商机金额';

alter table dw_erp_d_salesuser_opp_act add columns(income_target float comment '回款金额目标值') cascade;

alter table dw_erp_d_salesuser_opp_act add (income_target float comment '回款金额目标值');

alter table dw_erp_d_salesuser_opp_act change income_target income_target_amount float comment '回款金额目标值';

--new version
insert overwrite table dw_erp_d_salesuser_opp_act partition (p_date = $date$)
select 
	$date$ as d_date,
	nvl(base.id,-1) as sales_id,
	nvl(base.name,'未知') as sales_name,
	nvl(base.entrydate,'1900-01-01') as entrydate,
	nvl(base.formaldate,'1900-01-01')  as formaldate,
	nvl(base.position_id,-1) as  position_id,
	nvl(base.position_name ,'未知') as position_name,
	nvl(base.position_channel,'-1') as position_channel ,
	nvl(base.position_level ,'-1')  as position_level,
	nvl(base.org_id,-1)  as org_id,
	nvl(regexp_replace(base.org_name,'	',' ') ,'未知') as org_name,
	nvl(base.repertory_industry ,'-1')  as repertory_industry,
	nvl(base.parent_salesuser_id,-1)  as parent_salesuser_id,
	nvl(base.parent_salesuser_name ,'未知') as parent_salesuser_name,
	nvl(base.parent_salesuser_id_list ,'-1') as parent_salesuser_id_list,
	nvl(base.grade,-1) as grade ,
	nvl(base.is_sales_agent,-1) as is_sales_agent,
	nvl(base.is_work_on,-1) as is_work_on,
	nvl(oppfact.biz_category,-1) as biz_category,
	nvl(oppfact.process_status,-1) as process_status,
	nvl(oppfact.opp_cnt,0) as opp_cnt,
	nvl(case when oppfact.process_status in (5,6,7) then oppfact.opp_contract_amount else oppfact.opp_pre_amount end,0) as opp_amount,
	nvl(oppfact.opp_pre_amount,0) as opp_pre_amount,
	nvl(oppfact.opp_contract_amount,0) as opp_contract_amount,
	nvl(oppfact.opp_income_cnt,0) as opp_income_cnt,
	nvl(oppfact.opp_income_contract_amount,0) as opp_income_contract_amount ,
	nvl(oppfact.opp_add_cnt,0) as opp_add_cnt ,
	nvl(case when oppfact.process_status in (5,6,7) then oppfact.opp_add_contract_amount else oppfact.opp_add_pre_amount end ,0) as opp_add_contract_amount,
	from_unixtime(unix_timestamp()) as creation_timestamp,
	nvl(base.income_target_amount,0) as income_target_amount
from 
(select sales_id as id ,
		sales_name as name ,
		entrydate ,
		formaldate ,
		position_id ,
		position_name ,
		position_channel ,
		position_level ,
		org_id ,
		org_name ,
		repertory_industry ,
		parent_salesuser_id ,
		parent_salesuser_name ,
		parent_salesuser_id_list ,
		grade ,
 		is_work_on,is_sales_agent,
		all_income_m,
	   income_target_amount
   from  dw_erp_d_salesuser_act
  where p_date = $date$
) base 
left join 
(select 
	opp.creator_id,
	opp.biz_category,
	opp.process_status,
	count(case when opp.biz_category <> 1 and substr(regexp_replace(opp.expect_income_yyyymm,'-',''),1,6) = substr($date$,1,6) then opp.id else null end) as opp_cnt,
	sum(case when opp.biz_category <> 1 and substr(regexp_replace(opp.expect_income_yyyymm,'-',''),1,6) = substr($date$,1,6) then cast(opp.money as float) else cast(0 as float) end) as opp_pre_amount,
	sum(case when opp.biz_category <> 1 and substr(regexp_replace(opp.expect_income_yyyymm,'-',''),1,6) = substr($date$,1,6) then contract.money else 0.0 end) as opp_contract_amount,
	count(case when substr(regexp_replace(opp.actual_income_date,'-',''),1,6) = substr($date$,1,6) then opp.id else null end) as opp_income_cnt,
	sum(case when substr(regexp_replace(opp.actual_income_date,'-',''),1,6) = substr($date$,1,6) then contract.money else 0.0 end) as opp_income_contract_amount,
	count(case when substr(regexp_replace(opp.createtime,'-',''),1,6) = substr($date$,1,6) then opp.id else null end) as opp_add_cnt,
	sum(case when substr(regexp_replace(opp.createtime,'-',''),1,6) = substr($date$,1,6) then cast(opp.money as float) else cast(0 as float) end) as opp_add_pre_amount,
	sum(case when substr(regexp_replace(opp.createtime,'-',''),1,6) = substr($date$,1,6) then contract.money else 0.0 end) as opp_add_contract_amount
from dw_erp_d_opportunity_base opp
left join 
(select opportunity_id,sum(money) as money
  from dw_erp_d_contract_base
  where status in (1,2,3)
    and p_date = $date$
  group by  opportunity_id
)  contract 
on opp.id = contract.opportunity_id
where p_date = $date$
group by opp.creator_id,
		opp.biz_category,
		opp.process_status
) oppfact
on oppfact.creator_id = base.id;


--20160921
insert overwrite table dw_erp_d_salesuser_opp_act partition (p_date = $date$)
select 
	$date$ as d_date,
	nvl(base.id,-1) as sales_id,
	nvl(base.name,'未知') as sales_name,
	nvl(base.entrydate,'1900-01-01') as entrydate,
	nvl(base.formaldate,'1900-01-01')  as formaldate,
	nvl(base.position_id,-1) as  position_id,
	nvl(base.position_name ,'未知') as position_name,
	nvl(base.position_channel,'-1') as position_channel ,
	nvl(base.position_level ,'-1')  as position_level,
	nvl(base.org_id,-1)  as org_id,
	nvl(regexp_replace(base.org_name,'	',' ') ,'未知') as org_name,
	nvl(base.repertory_industry ,'-1')  as repertory_industry,
	nvl(base.parent_salesuser_id,-1)  as parent_salesuser_id,
	nvl(base.parent_salesuser_name ,'未知') as parent_salesuser_name,
	nvl(base.parent_salesuser_id_list ,'-1') as parent_salesuser_id_list,
	nvl(base.grade,-1) as grade ,
	nvl(case when base.position_channel in ('A0000484','A0000485','A0000486','A0000821') then 1 else 0 end,-1) as is_sales_agent,
	nvl(case when base.status  in (0,1)  then 1 else 0 end,-1) as is_work_on,
	nvl(oppfact.biz_category,-1) as biz_category,
	nvl(oppfact.process_status,-1) as process_status,
	nvl(oppfact.opp_cnt,0) as opp_cnt,
	nvl(case when oppfact.process_status in (5,6,7) then oppfact.opp_contract_amount else oppfact.opp_pre_amount end,0) as opp_amount,
	nvl(oppfact.opp_pre_amount,0) as opp_pre_amount,
	nvl(oppfact.opp_contract_amount,0) as opp_contract_amount,
	nvl(oppfact.opp_income_cnt,0) as opp_income_cnt,
	nvl(oppfact.opp_income_contract_amount,0) as opp_income_contract_amount ,
	nvl(oppfact.opp_add_cnt,0) as opp_add_cnt ,
	nvl(case when oppfact.process_status in (5,6,7) then oppfact.opp_add_contract_amount else oppfact.opp_add_pre_amount end ,0) as opp_add_contract_amount,
	from_unixtime(unix_timestamp()) as creation_timestamp
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
		repertory_industry ,
		parent_salesuser_id ,
		parent_salesuser_name ,
		parent_salesuser_id_list ,
		grade ,
		status
   from  dw_erp_d_salesuser_base
  where p_date = $date$
) base 
left join 
(select 
	opp.creator_id,
	opp.biz_category,
	opp.process_status,
	count(case when opp.biz_category <> 1 and substr(regexp_replace(opp.expect_income_yyyymm,'-',''),1,6) = substr($date$,1,6) then opp.id else null end) as opp_cnt,
	sum(case when opp.biz_category <> 1 and substr(regexp_replace(opp.expect_income_yyyymm,'-',''),1,6) = substr($date$,1,6) then cast(opp.money as float) else cast(0 as float) end) as opp_pre_amount,
	sum(case when opp.biz_category <> 1 and substr(regexp_replace(opp.expect_income_yyyymm,'-',''),1,6) = substr($date$,1,6) then contract.money else 0.0 end) as opp_contract_amount,
	count(case when income.opportunity_id is not null then opp.id else null end) as opp_income_cnt,
	sum(case when income.opportunity_id is not null then contract.money else 0.0 end) as opp_income_contract_amount,
	count(case when substr(regexp_replace(opp.createtime,'-',''),1,6) = substr($date$,1,6) then opp.id else null end) as opp_add_cnt,
	sum(case when substr(regexp_replace(opp.createtime,'-',''),1,6) = substr($date$,1,6) then cast(opp.money as float) else cast(0 as float) end) as opp_add_pre_amount,
	sum(case when substr(regexp_replace(opp.createtime,'-',''),1,6) = substr($date$,1,6) then contract.money else 0.0 end) as opp_add_contract_amount
from dw_erp_d_opportunity_base opp
left join 
(select opportunity_id,sum(money) as money
  from dw_erp_d_contract_base
  where status in (1,2,3)
    and p_date = $date$
  group by  opportunity_id
)  contract 
on opp.id = contract.opportunity_id
left join 
(select contract.opportunity_id
  from dw_erp_d_contract_base contract
  join dw_erp_d_crmfinance_income income
  on contract.id = income.contract_id
  and income.p_date = $date$
  and regexp_replace(income.pay_time,'-','') between concat(substr($date$,1,6),'01') and $date$
  where contract.p_date = $date$
  and contract.status in (1,2,3)
  group by contract.opportunity_id
) income 
on opp.id = income.opportunity_id
where p_date = $date$
group by opp.creator_id,
		opp.biz_category,
		opp.process_status
) oppfact
on oppfact.creator_id = base.id;

