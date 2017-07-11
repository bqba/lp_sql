CREATE TABLE dw_erp_d_salesuser_act_pre(
  d_date int COMMENT ' 统计日期 ', 
  sales_id int COMMENT ' 销售顾问主键 ', 
  sales_name string COMMENT ' 销售顾问姓名 ', 
  entrydate string COMMENT ' 入职日期 ', 
  formaldate string COMMENT ' 转正日期 ', 
  position_id int COMMENT ' 岗位主键 ', 
  position_name string COMMENT ' 岗位名称 ', 
  position_channel string COMMENT ' 岗位渠道 ', 
  position_level string COMMENT ' 岗位级别 ', 
  org_id int COMMENT ' 组织主键 ', 
  org_name string COMMENT ' 组织名称 ', 
  repertory_industry string COMMENT ' 深耕行业 ', 
  parent_salesuser_id int COMMENT ' 汇报对象主键 ', 
  parent_salesuser_name string COMMENT ' 汇报对象名称 ', 
  parent_salesuser_id_list string COMMENT ' 汇报对象及所有上级列表 ', 
  grade int COMMENT ' 级次 ', 
  is_sales_agent int COMMENT ' 是否基础销售 ', 
  is_work_on int COMMENT ' 是否在职 ', 
  call_time_long float COMMENT ' 有效通话时长 ', 
  call_cus_cnt int COMMENT ' 有效通话客户数 ', 
  call_rec_cnt int COMMENT ' 有效通话次数 ', 
  visit_cus_cnt int COMMENT ' 拜访客户数 ', 
  input_cus_cnt int COMMENT ' 录入客户数 ', 
  contract_new_cnt int COMMENT ' 已签合同数 ', 
  contract_new_amount float COMMENT ' 已签约金额 ', 
  cus_contract_cnt int COMMENT ' 合作中客户数 ', 
  cus_expire_cnt int COMMENT ' 到期客户数 ', 
  cus_break_cnt int COMMENT ' 断约客户数 ', 
  noincome_effect_cus_cnt int COMMENT ' 提前开通未回款客户数 ', 
  lpt_income float COMMENT ' 猎聘通合同回款金额 ', 
  all_income float COMMENT ' 所有合同回款金额 ', 
  add_cus_cnt int COMMENT ' 面试快当日新增客户数 ', 
  add_ejob_cnt int COMMENT ' 面试快当日新增职位数 ', 
  service_cus_cnt int COMMENT ' 面试快发起客户数 ', 
  service_ejob_cnt int COMMENT ' 面试快发起职位数 ', 
  visit_cus_cnt_m int COMMENT ' 月累计拜访客户数 ', 
  input_cus_cnt_m int COMMENT ' 月累计录入客户数 ', 
  contract_new_cnt_m int COMMENT ' 月累计已签合同数 ', 
  contract_new_amount_m float COMMENT ' 月累计已签约金额 ', 
  all_income_m float COMMENT ' 月累计所有合同回款金额 ', 
  creation_timestamp timestamp COMMENT ' 时间戳 ', 
  income_target_amount float COMMENT '回款金额目标值', 
  salesposition int COMMENT '销售岗位级别', 
  salesposition_name string COMMENT '销售岗位级别名称', 
  input_cert_cus_cnt_m int COMMENT '月累计新增录入认证客户数', 
  receivable_new_acount_m int COMMENT '月累计应收金额')
PARTITIONED BY (p_date int);


alter table dw_erp_d_salesuser_act change lpt_income lpt_income float comment'猎聘通合同回款金额-字段废弃';
alter table dw_erp_d_salesuser_act change all_income all_income float comment'所有合同回款金额-字段废弃';
alter table dw_erp_d_salesuser_act change all_income_m all_income_m float comment '	月累计所有合同回款金额-字段废弃';

alter table dw_erp_d_salesuser_act add columns(income_target float comment '回款金额目标值') cascade;

alter table dw_erp_d_salesuser_act add (income_target_amount float comment '回款金额目标值');

alter table dw_erp_d_salesuser_act add columns(input_cert_cus_cnt_m int comment '月累计新增录入认证客户数') cascade;

alter table dw_erp_d_salesuser_act add (input_cert_cus_cnt_m int default 0 comment '月累计新增录入认证客户数');

alter table dw_erp_d_salesuser_act change income_target income_target_amount float comment '回款金额目标值';

alter table dw_erp_d_salesuser_act add columns (receivable_new_acount_m int default 0 comment '月累计应收金额') cascade;
alter table dw_erp_d_salesuser_act add (receivable_new_acount_m int default 0 comment '月累计应收金额');


insert overwrite table dw_erp_d_salesuser_act partition (p_date = $date$)
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
    nvl(regexp_replace(base.org_name,'  ',' ') ,'未知') as org_name,
    nvl(base.repertory_industry ,'-1')  as repertory_industry,
    nvl(base.parent_salesuser_id,-1)  as parent_salesuser_id,
    nvl(base.parent_salesuser_name ,'未知') as parent_salesuser_name,
    nvl(base.parent_salesuser_id_list ,'-1') as parent_salesuser_id_list,
    nvl(base.grade,-1) as grade ,
    nvl(case when position_channel in ('A0000484','A0000485','A0000486','A0000821') then 1 else 0 end,-1) as is_sales_agent,
    nvl(case when base.status  in (0,1)  then 1 else 0 end,-1) as is_work_on,
    nvl(call_record.call_time_long,0) as call_time_long, --通话时长
    nvl(call_record.call_cus_cnt,0) as call_cus_cnt,--通话覆盖客户数
    nvl(call_record.call_rec_cnt,0) as call_rec_cnt,--通话数量，
    nvl(visit.visit_cus_cnt,0) as visit_cus_cnt,--拜访客户数
    nvl(cus.input_cus_cnt,0) as input_cus_cnt,--新增录入客户数
    nvl(contract.contract_new_cnt,0) as contract_new_cnt, --新增签约合同数
    nvl(contract.contract_new_amount,0) as contract_new_amount,--新增签约合同金额
    nvl(contract_cus.cus_contract_cnt,0) as cus_contract_cnt, --合作中客户数
    nvl(contract_cus.cus_expire_cnt,0) as cus_expire_cnt, --到期客户数
    nvl(contract_cus.cus_break_cnt,0) as cus_break_cnt, --断约客户数
    nvl(contract.noincome_effect_cus_cnt,0) as noincome_effect_cus_cnt, --提前开通未回款客户数
    nvl(income.lpt_income,0) as lpt_income,--猎聘通合同回款金额
    nvl(income.all_income,0) as all_income,--合同回款金额
    nvl(godjob.add_cus_cnt,0) as add_cus_cnt, --当天新增面试快客户数
    nvl(godjob.add_ejob_cnt,0) as add_ejob_cnt ,--当天新增面试快职位数
    nvl(godjob.service_cus_cnt,0) as service_cus_cnt,--累计服务中面试快客户数
    nvl(godjob.service_ejob_cnt,0) as service_ejob_cnt ,--累计服务中面试快职位数
    nvl(visit.visit_cus_cnt_m,0) as visit_cus_cnt_m ,--月累计拜访客户数
    nvl(cus.input_cus_cnt_m,0) as input_cus_cnt_m,--月累计新增录入客户数
    nvl(contract.contract_new_cnt_m,0)  contract_new_cnt_m , --月累计新增签约合同数
    nvl(contract.contract_new_amount_m,0)  contract_new_amount_m , --新增签约合同金额
    nvl(income.all_income_m ,0) as all_income_m,
    from_unixtime(unix_timestamp()) as creation_timestamp,
    nvl(target.target_amount,0) as income_target_amount,
    base.salesposition as salesposition,
    base.salesposition_name as salesposition_name,
    nvl(cus.input_cert_cus_cnt_m,0) as input_cert_cus_cnt_m,
    nvl(recv.receivable_new_acount_m,0) as receivable_new_acount_m
from
(
  select id ,
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
        status,
        salesposition,
        salesposition_name
  from  dw_erp_d_salesuser_base
  where p_date = $date$
  and (is_saleuser =1 or position_channel in ('A0000528','A0000567','A0000641'))
  and parent_salesuser_id <> -1
) base
left outer join
(
  select  presented_username,
          sum(case when time_long/60 > 30 then 30.00 else round(time_long/60 ,2) end ) as call_time_long,
          count(distinct customer_id) as call_cus_cnt,
          count(id) call_rec_cnt
  from call_record
  where  begin_time >='080000'
  and end_time <='200000'
  and time_long>45
  and customer_id >0
  and call_date='$date$'
  group by presented_username
) call_record
on  base.username = call_record.presented_username
left outer join
(
  select ccv.creator_id,
        count(distinct case when  visit_date = '$date$' then ccv.customer_id else null end) as visit_cus_cnt,
        count(distinct ccv.customer_id) as visit_cus_cnt_m
  from crm_customer_visitplan ccv
  where ccv.visit_status=1
  and ccv.deleteflag=0
  and regexp_replace (substr (ccv.createtime,1,10),"-","") > 20160401   -----排除测试数据
  and ccv.visit_date between concat(substr('$date$',1,6),'01' )  and '$date$'
  group by ccv.creator_id
) visit
on  base.id = visit.creator_id
left outer join
(
  select sales_id,
          sum(is_contract_new) as contract_new_cnt ,
          sum(contract_new_amount) as contract_new_amount,
          sum(is_noincome_effect) as noincome_effect_cus_cnt,
          count (distinct case when contract_createtime between  concat(substr('$date$',1,6),'01' )  and  '$date$' then contract_id else null end) as contract_new_cnt_m,
          sum(case when contract_createtime between  concat(substr('$date$',1,6),'01') and  '$date$' then contract_money else cast(0 as float) end) as contract_new_amount_m
  from dw_erp_d_contract_act
  where p_date = $date$
  group by sales_id
) contract
on base.id = contract.sales_id
left outer join
(
  select sales_id,
          count (distinct case when is_lpt_in_service = 1 then customer_id else null end) as cus_contract_cnt,
          count (distinct case when is_lpt_expire = 1 then customer_id else null end) as cus_expire_cnt,
          count (distinct case when is_lpt_break = 1 then customer_id else null end) as cus_break_cnt
  from dw_erp_d_customer_status
  where p_date = $date$
  group by sales_id
) contract_cus
on base.id = contract_cus.sales_id
left outer join
(select  input_id,
      count(case when regexp_replace(substr(createtime,1,10),'-','')  = '$date$' then id else null end) input_cus_cnt,
      count(case when regexp_replace(substr(createtime,1,10),'-','')  between concat(substr('$date$',1,6),'01') and '$date$' then id else null end) input_cus_cnt_m,
      count(case when regexp_replace(substr(createtime,1,10),'-','')  between concat(substr('$date$',1,6),'01') and '$date$' and (company_certificate not in ('','-1')) then id else null end) input_cert_cus_cnt_m
  from  dw_erp_d_customer_base
  where p_date =  $date$
  group by input_id
) cus
on base.id = cus.input_id
left outer join
(
    select  sales_id,
            count(distinct case when is_add = 1 then ecomp_root_id else null end) add_cus_cnt,
            count(distinct case when is_add = 1 then ejob_id else null end) add_ejob_cnt,
            count(distinct case when ge_status = 1 then ecomp_root_id else null end) service_cus_cnt,
            count(distinct case when ge_status = 1 then ejob_id else null end) service_ejob_cnt
    from dw_erp_d_godjob_list
    where p_date = $date$
    group by sales_id
) godjob
on base.id = godjob.sales_id
left outer join
(   
    select sales_id,sum(money) money,
          sum(case when regexp_replace(substr(pay_time,1,10),'-','')  =  '$date$' and biz_type = 0 then money else '0' end) as  lpt_income, --猎聘通合同回款金额
          sum(case when regexp_replace(substr(pay_time,1,10),'-','')  =  '$date$' then money else '0' end)  as all_income,  --合同回款金额
          sum(case when (regexp_replace(substr(pay_time,1,10),'-','')  between concat(substr('$date$',1,6),'01')  and '$date$') and biz_type = 0 then money else '0' end) as  lpt_income_m, --猎聘通合同回款金额
          sum(case when regexp_replace(substr(pay_time,1,10),'-','')  between concat(substr('$date$',1,6),'01')  and '$date$' then money else '0' end) as all_income_m  --合同回款金额
    from dw_erp_a_crmfinance_income
    where money > 0
    group by sales_id
)  income
on base.id = income.sales_id
left outer join
(
  select
      role3.id,role3.name,role3.target_amount
  from (
        select
            role2.id,role2.type,cat.target_amount,role2.name,
            row_number()over(distribute by role2.id sort by cat.id ) as rn
        from
        (
          select
              role1.id,
              role1.name,
              case when role1.min_level = 5 then 1 else 0 end as type,
              case when role1.min_level  = 5 then id
              when role1.min_level  = 2 and role1.level <> 5 then org_id
              when role1.min_level  = 1 then 1
              end as object_id
          from (
              select pe.id,pe.name,pe.org_id as ownorg,per.org_id,prp.level,
                      min(prp.level) over(distribute by pe.id) as min_level
              from portal_permission pp
              join portal_role_permission prp
              on pp.id = prp.permission_id
              and prp.deleteflag = 0
              join portal_employee_role per
              on per.role_id = prp.role_id
              and per.deleteflag = 0
              join portal_employee pe
              on pe.id = per.employee_id
              and pe.deleteflag = 0
              left join (select parent_salesuser_id
              from dw_erp_d_salesuser_base
              where p_date = $date$
              group by parent_salesuser_id) child
              on pe.id = child.parent_salesuser_id
              where pp.code='CRM_SALE_TARGET_LIST'
              and prp.level in (1,2,5)
              and !(child.parent_salesuser_id is null and pe.status = 2)
          ) role1
          union all
          select id,name,0 as type,1 as object_id
          from dw_erp_d_salesuser_base
          where p_date = $date$
          and position_channel in ('A0000567','A0000528')
          and status <> 2
          and account_status = 0
        ) role2
      join (
        select id,object_id,type,target_amount
        from (
        select id,object_id,type,
        double(nvl(case substr('$date$',5,2)
        when '01' then get_json_object(target_amount_detail,'$.jan_amount')
        when '02' then get_json_object(target_amount_detail,'$.feb_amount')
        when '03' then get_json_object(target_amount_detail,'$.mar_amount')
        when '04' then get_json_object(target_amount_detail,'$.apr_amount')
        when '05' then get_json_object(target_amount_detail,'$.may_amount')
        when '06' then get_json_object(target_amount_detail,'$.jun_amount')
        when '07' then get_json_object(target_amount_detail,'$.jul_amount')
        when '08' then get_json_object(target_amount_detail,'$.aug_amount')
        when '09' then get_json_object(target_amount_detail,'$.sep_amount')
        when '10' then get_json_object(target_amount_detail,'$.oct_amount')
        when '11' then get_json_object(target_amount_detail,'$.nov_amount')
        when '12' then get_json_object(target_amount_detail,'$.dec_amount')
        end ,0 )) * 10000 as target_amount,
        row_number()over(distribute by object_id,type,year sort by id desc) as rn
        from crm_target_management
        where deleteflag = 0
        and year = substr('$date$',1,4)
        )  ctm
        where ctm.rn = 1
      )  cat
      on role2.object_id = cat.object_id
      and role2.type = cat.type
    ) role3
  where rn =1
) target
on base.id = target.id
left outer join
(
  select act.sales_id,
        sum(act.paying_money) as receivable_new_acount_m
  from dw_erp_d_contract_act act
  where act.p_date = $date$
  group by act.sales_id
) recv
on base.id = recv.sales_id













insert overwrite table dw_erp_d_salesuser_act partition (p_date)
select d_date, sales_id, sales_name, entrydate, formaldate, position_id, position_name, position_channel, position_level, org_id, org_name, repertory_industry, parent_salesuser_id, parent_salesuser_name, parent_salesuser_id_list, grade, is_sales_agent, is_work_on, call_time_long, call_cus_cnt, call_rec_cnt, visit_cus_cnt, input_cus_cnt, contract_new_cnt, contract_new_amount, cus_contract_cnt, cus_expire_cnt, cus_break_cnt, noincome_effect_cus_cnt, lpt_income, all_income, add_cus_cnt, add_ejob_cnt, service_cus_cnt, service_ejob_cnt, visit_cus_cnt_m, input_cus_cnt_m, contract_new_cnt_m, contract_new_amount_m, all_income_m, creation_timestamp, income_target_amount, salesposition, salesposition_name, input_cert_cus_cnt_m, 0 as receivable_new_acount_m, p_date
from dw_erp_d_salesuser_act
where p_date between {{start_date}} and {{end_date}}


create table dw_erp_d_salesuser_act
(
d_date int comment ' 统计日期 ',
sales_id int comment ' 销售顾问主键 ',
sales_name varchar(100) comment ' 销售顾问姓名 ',
entrydate varchar(10) comment ' 入职日期 ',
formaldate varchar(10) comment ' 转正日期 ',
position_id int comment ' 岗位主键 ',
position_name varchar(100) comment ' 岗位名称 ',
position_channel varchar(100) comment ' 岗位渠道 ',
position_level varchar(100) comment ' 岗位级别 ',
org_id int comment ' 组织主键 ',
org_name varchar(300) comment ' 组织名称 ',
repertory_industry varchar(50) comment ' 深耕行业 ',
parent_salesuser_id int comment ' 汇报对象主键 ',
parent_salesuser_name varchar(100) comment ' 汇报对象名称 ',
parent_salesuser_id_list varchar(100) comment ' 汇报对象及所有上级列表 ',
grade int comment ' 级次 ',
is_sales_agent int comment ' 是否基础销售 ',
is_work_on int comment ' 是否在岗 ',
call_time_long float comment ' 有效通话时长 ',
call_cus_cnt int comment ' 有效通话客户数 ',
call_rec_cnt int comment ' 有效通话次数 ',
visit_cus_cnt int comment ' 拜访客户数 ',
input_cus_cnt int comment ' 录入客户数 ',
contract_new_cnt int comment ' 已签合同数 ',
contract_new_amount float comment ' 已签约金额 ',
cus_contract_cnt int comment ' 合作中客户数 ',
cus_expire_cnt int comment ' 到期客户数 ',
cus_break_cnt int comment ' 断约客户数 ',
noincome_effect_cus_cnt int comment ' 提前开通未回款客户数 ',
lpt_income float comment ' 猎聘通合同回款金额 ',
all_income float comment ' 所有合同回款金额 ',
add_cus_cnt int comment ' 面试快当日新增客户数 ',
add_ejob_cnt int comment ' 面试快当日新增职位数 ',
service_cus_cnt int comment ' 面试快发起客户数 ',
service_ejob_cnt int comment ' 面试快发起职位数 ',
visit_cus_cnt_m int comment ' 月累计拜访客户数 ',
input_cus_cnt_m int comment ' 月累计录入客户数 ',
contract_new_cnt_m int comment ' 月累计已签合同数 ',
contract_new_amount_m float comment ' 月累计已签约金额 ',
all_income_m float comment ' 月累计所有合同回款金额 ',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment ' 时间戳 ',
primary key (d_date, sales_id)
);

create table if not exists fact_h_erp_a_salesuser_real
(
	d_date int comment ' 统计日期 ',
	sales_id int comment ' 销售顾问主键 ',
	sales_name string comment ' 销售顾问姓名 ',
	all_income float comment ' 所有合同回款金额 ',
	all_income_m float comment ' 月累计所有合同回款金额 ',
	input_cus_cnt int comment ' 新增客户数 ',
	input_cus_cnt_m int comment ' 月累计新增客户数 ',
	input_cert_cus_cnt int comment ' 新增认证客户数 ',
	input_cert_cus_cnt_m int comment ' 月累计新增认证客户数 ',	
	visit_cus_cnt int comment ' 拜访客户数 ',
	visit_cus_cnt_m int comment ' 月累计拜访客户数 ',	
	visit_cus_plan_cnt int comment ' 拜访客户次数 ',
	visit_cus_plan_cnt_m int comment ' 月累计拜访客户次数 ',	
	creation_timestamp timestamp comment ' 时间戳 '
) comment '销售顾问-需全量更新指标';

create table if not exists fact_h_erp_a_salesuser_real
(
	d_date int comment ' 统计日期 ',
	sales_id int comment ' 销售顾问主键 ',
	sales_name varchar(50) comment ' 销售顾问姓名 ',
	all_income float comment ' 所有合同回款金额 ',
	all_income_m float comment ' 月累计所有合同回款金额 ',
	input_cus_cnt int comment ' 新增客户数 ',
	input_cus_cnt_m int comment ' 月累计新增客户数 ',
	input_cert_cus_cnt int comment ' 新增认证客户数 ',
	input_cert_cus_cnt_m int comment ' 月累计新增认证客户数 ',	
	visit_cus_cnt int comment ' 拜访客户数 ',
	visit_cus_cnt_m int comment ' 月累计拜访客户数 ',	
	visit_cus_plan_cnt int comment ' 拜访客户次数 ',
	visit_cus_plan_cnt_m int comment ' 月累计拜访客户次数 ',	
  	creation_timestamp timestamp default current_timestamp comment '时间戳',
  	primary key(d_date,sales_id)
) comment '销售顾问-需全量更新指标';

alter table fact_h_erp_a_salesuser_real  

insert overwrite table fact_h_erp_a_salesuser_real
select
	d_date,
	sales_id,
	sales_name,
	all_income,
	all_income_m,
	input_cus_cnt,
	input_cus_cnt_m,
	input_cert_cus_cnt,
	input_cert_cus_cnt_m,
	0 as visit_cus_cnt,
	0 as visit_cus_cnt_m,
	0 as visit_cus_plan_cnt,
	0 as visit_cus_plan_cnt_m,
	from_unixtime(unix_timestamp()) as creation_timestamp
from (
	select 
		d_date, 
		sales_id,
		sales_name,
		is_sales,
		is_work_on,
		money as all_income,
		sum(money) over(distribute by sales_id,d_month sort by d_date rows between unbounded preceding and current row) as all_income_m,
		input_cus_cnt as input_cus_cnt,
		sum(input_cus_cnt) over(distribute by sales_id,d_month sort by d_date rows between unbounded preceding and current row) as input_cus_cnt_m,
		input_cert_cus_cnt as input_cert_cus_cnt,
		sum(input_cert_cus_cnt) over(distribute by sales_id,d_month sort by d_date rows between unbounded preceding and current row) as input_cert_cus_cnt_m
	from (
	  select all_user.sales_id,
	  		 all_user.sales_name,
	  		 all_user.d_date,
	  		 all_user.is_sales,
	  		 all_user.is_work_on,
	  		 substr(all_user.d_date,1,6) as d_month,
	  		 nvl(income_user.money,0) as money,
	  		 nvl(input_cus.input_cus_cnt,0) as input_cus_cnt,
	  		 nvl(input_cus.input_cert_cus_cnt,0) as input_cert_cus_cnt
	  from 
	  (
		select suser.sales_id,suser.sales_name,suser.is_sales,suser.is_work_on,dim_date.d_date
		from 
		(select id as sales_id,
			   name as sales_name,
			   nvl(case when position_channel in ('A0000484','A0000485','A0000486','A0000821','A0000487','A0000489') then 1 else 0 end,-1) as is_sales, 
			   nvl(case when status in (0,1) then 1 else 0 end,-1) as is_work_on
		from dw_erp_d_salesuser_base
		where p_date = '$date$'
		) suser 
		join dim_date on d_date between 20161001 and '$date$'
	    and 1 = 1
	  ) all_user
	  left join 
	  (select d_date, 
				substr(d_date,1,6) as d_month,
				sales_id,
				sales_name,	
				sum(money) money	
	     from dw_erp_a_crmfinance_income
		where money > 0 
		group by d_date,
				sales_id,
				sales_name
	  ) income_user
	  on all_user.sales_id = income_user.sales_id
	  and all_user.d_date = income_user.d_date
	  left join 
	  (select d_date,
	  		  substr(d_date,1,6) as d_month,
	  		  input_id as sales_id,
	  		  input_name as sales_name,
	  		  count(customer_id) as input_cus_cnt,
	  		  count(case when status = 1 then customer_id else null end) as input_cert_cus_cnt
	  	 from dw_erp_a_customer_input
	  	group by d_date,input_id,input_name
	  ) input_cus 
	  on all_user.sales_id = input_cus.sales_id
	  and all_user.d_date = input_cus.d_date
	) user_day
) filter_user
where (all_income_m + input_cus_cnt_m + input_cert_cus_cnt_m) > 0 or (is_work_on = 1 and is_sales = 1);
