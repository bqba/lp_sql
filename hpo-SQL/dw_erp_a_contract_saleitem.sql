select 
	contract_id,suitid,money
from 
(
	select contract_id, get_json_object(suit,'$.suitId') as suitid,get_json_object(suit,'$.price') as money
	from (
	select 
	array(get_json_object(suit_products_instance,'$.contractsuits\[0]'),get_json_object(suit_products_instance,'$.contractsuits\[1]'),get_json_object(suit_products_instance,'$.contractsuits\[2]')) as suits,
	suit_products_instance,
	contract_id
	from crm_contract_saleitem ) saleitem
	lateral view explode(suits) subview as suit
) item where suitid is not null 


create table if not exists dw_erp_a_contract_saleitem
(id int comment '主键', 
 contract_id int comment '合同主键',
 suitid int  comment '套餐主键',
 suitname string comment '套餐名称',
 money float  comment '套餐金额',
 creator_id int comment '创建者ID',
 org_id int comment '所属部门',
 createtime string comment '创建时间',
 modifytime string comment '创建时间',
 creation_timestamp timestamp 
 );


insert overwrite table dw_erp_a_contract_saleitem
select 
	id,
	contract_id,
	suitid,
	suitname,
	money,
	creator_id,
	org_id,
	createtime,
	modifytime,
	from_unixtime(unix_timestamp()) as creation_timestamp,
	nvl(hasLptResource,-1),
	nvl(isJunior,-1)
from 
(
	select contract_id,creator_id,org_id,createtime,modifytime,id,
			 get_json_object(suit,'$.suitId') as suitid,
			 get_json_object(suit,'$.suitName') as suitname,
			 get_json_object(suit,'$.itemMoney') as money,
			 get_json_object(suit,'$.hasLptResource') as hasLptResource,
			 get_json_object(suit,'$.isJunior') as isJunior

	from (
	select 
	array(get_json_object(suit_products_instance,'$.contractsuits\[0]'),get_json_object(suit_products_instance,'$.contractsuits\[1]'),get_json_object(suit_products_instance,'$.contractsuits\[2]'),get_json_object(suit_products_instance,'$.contractsuits\[3]'),get_json_object(suit_products_instance,'$.contractsuits\[4]'),get_json_object(suit_products_instance,'$.contractsuits\[5]'),get_json_object(suit_products_instance,'$.contractsuits\[6]'),get_json_object(suit_products_instance,'$.contractsuits\[7]'),get_json_object(suit_products_instance,'$.contractsuits\[8]'),get_json_object(suit_products_instance,'$.contractsuits\[9]')) as suits,
	contract_id,creator_id,org_id,createtime,modifytime,id
	from crm_contract_saleitem ) saleitem
	lateral view explode(suits) subview as suit
) item where suitid is not null ;



create table dw_erp_a_contract_product
( contract_id int COMMENT ' 合同主键 ', 
  contract_no string COMMENT ' 合同号 ', 
  contract_type string COMMENT ' 合同类型 ', 
  contract_money float COMMENT ' 合同签约金额 ', 
  contract_sign_date string COMMENT ' 合同签约时间 ', 
  sales_id int COMMENT '签约销售ID', 
  sales_branch string COMMENT '签约销售所属分公司', 
  customer_id int COMMENT '客户ID', 
  is_have_lpt int COMMENT '是否有猎聘通产品', 
  is_have_lpt_suit int COMMENT '是否有猎聘通产品套餐', 
  is_have_lpt_no_std int COMMENT '是否有猎聘通非标套餐', 
  lpt_item_money float COMMENT '猎聘通产品合同金额', 
  is_have_xy int COMMENT '是否有校园产品', 
  xy_item_money float COMMENT '校园产品金额', 
  is_have_rpo int COMMENT '是否有RPO产品', 
  rpo_item_money float COMMENT 'RPO产品金额', 
  is_have_ad int COMMENT '是否有广告产品', 
  ad_item_money float COMMENT '广告产品金额', 
  is_have_bc int COMMENT '是否有商业中心产品', 
  bc_item_money float COMMENT '商业中心产品金额', 
  is_have_srp int COMMENT '是否有薪酬报告产品', 
  srp_item_money float COMMENT '薪酬报告产品金额', 
  is_have_test int COMMENT '是否有测评产品', 
  test_item_money float COMMENT '测评产品金额', 
  suit_id int COMMENT '套餐ID', 
  suit_name string COMMENT '套餐名称', 
  suit_money float COMMENT '套餐金额', 
  online_income_money float COMMENT '线上产品回款金额', 
  rpo_income_moeny float COMMENT '线下RPO回款金额', 
  xy_income_moeny float COMMENT '线下校园回款金额',   
  income_money float COMMENT '产品回款金额', 
  income_date string COMMENT '最近回款日期', 
  creation_timestamp timestamp COMMENT ' 时间戳 ')
 comment '合同产品结构分析';

 alter table dw_erp_a_contract_product change lpt_item_money lpt_item_money float comment '猎聘通非套餐金额';

--合同明细
insert overwrite table dw_erp_a_contract_product
select 
	contract.id as contract_id,
	contract.contract_no,
	contract.type as contract_type,
	contract.money as contract_money,
	contract.sign_date as contract_sign_date,
	contract.secondparty_sign_id as sales_id,
	dim_org.branch_name as sales_branch,
	contract.customer_id,
	case when contract.lpt_products_instance not in (0,'{"contractsuits":}') or nvl(st_lpt.is_have_lpt,0) = 1 then 1 else 0 end as is_have_lpt,
	case when nvl(st_lpt.is_have_lpt,0) = 1 then 1 else 0 end as is_have_lpt_suit,
	case when contract.lpt_products_instance not in (0,'{"contractsuits":}')  then 1 else 0 end as is_have_lpt_no_std,
	case when contract.lpt_products_instance not in (0,'{"contractsuits":}') then 
			nvl(get_json_object(lpt_products_instance,'$.contractsuits\[0].itemMoney'),0) + 
	        nvl(get_json_object(lpt_products_instance,'$.contractsuits\[1].itemMoney'),0)+
	        nvl(get_json_object(lpt_products_instance,'$.contractsuits\[2].itemMoney'),0)+
	        nvl(get_json_object(lpt_products_instance,'$.contractsuits\[3].itemMoney'),0)+ 
	        nvl(get_json_object(lpt_products_instance,'$.contractsuits\[4].itemMoney'),0)+
	        nvl(get_json_object(lpt_products_instance,'$.contractsuits\[5].itemMoney'),0)+
	        nvl(get_json_object(lpt_products_instance,'$.contractsuits\[6].itemMoney'),0)+ 
	        nvl(get_json_object(lpt_products_instance,'$.contractsuits\[7].itemMoney'),0)+
	        nvl(get_json_object(lpt_products_instance,'$.contractsuits\[8].itemMoney'),0)
		 else 0 end as lpt_item_money,
	case when contract.type = 10 then 1 else 0 end is_have_xy,
	case when contract.type = 10 then contract.money
		 when contract.type = 15 then income.xy_money
		 else 0 end xy_item_money,
	case when contract.type in (11,15) then 1 else 0 end is_have_rpo,
	case when contract.type = 11 then contract.money 
		 when contract.type = 15 then income.rpo_money 
		 else 0 end rpo_item_money,
	case when contract.ad_products_instance not in (0,'{"contractsuits":}') or nvl(st_ad.ad_money,0) > 0 then 1 else 0 end as is_have_ad,
	case when contract.ad_products_instance not in (0,'{"contractsuits":}') then nvl(get_json_object(ad_products_instance,'$.contractsuits\[0].itemMoney'),0) + nvl(get_json_object(ad_products_instance,'$.contractsuits\[1].itemMoney'),0)+ nvl(get_json_object(ad_products_instance,'$.contractsuits\[2].itemMoney'),0)
		 else nvl(st_ad.ad_money,0) end as ad_item_money,
	case when contract.bc_products_instance not in (0,'{"contractsuits":}') or nvl(st_bc.bc_money,0) > 0 then 1 else 0 end as is_have_bc,
	case when contract.bc_products_instance not in (0,'{"contractsuits":}') then nvl(get_json_object(bc_products_instance,'$.contractsuits\[0].itemMoney'),0) + nvl(get_json_object(bc_products_instance,'$.contractsuits\[1].itemMoney'),0)+nvl(get_json_object(bc_products_instance,'$.contractsuits\[2].itemMoney'),0)
		 else nvl(st_bc.bc_money,0) end as bc_item_money,
	case when contract.srp_products_instance not in (0,'{"contractsuits":}') or nvl(st_srp.srp_money,0) > 0 then 1 else 0 end as is_have_srp,
	case when contract.srp_products_instance not in (0,'{"contractsuits":}') then nvl(get_json_object(srp_products_instance,'$.contractsuits\[0].itemMoney'),0) + nvl(get_json_object(srp_products_instance,'$.contractsuits\[1].itemMoney'),0)+ nvl(get_json_object(srp_products_instance,'$.contractsuits\[2].itemMoney'),0)
		 else nvl(st_srp.srp_money,0) end as srp_item_money,
	case when contract.test_products_instance not in (0,'{"contractsuits":}') or nvl(st_test.test_money,0) > 0 then 1 else 0 end as is_have_test,
	case when contract.test_products_instance not in (0,'{"contractsuits":}') then nvl(get_json_object(test_products_instance,'$.contractsuits\[0].itemMoney'),0) + nvl(get_json_object(test_products_instance,'$.contractsuits\[1].itemMoney'),0)+ nvl(get_json_object(test_products_instance,'$.contractsuits\[2].itemMoney'),0)
		 else nvl(st_test.test_money,0) end as test_item_money,		 
	coalesce(st_lpt.suit_id,st_ad.suit_id,st_bc.suit_id,st_srp.suit_id,st_test.suit_id,-1) as suit_id,
	coalesce(st_lpt.suit_name,st_ad.suit_name,st_bc.suit_name,st_srp.suit_name,st_test.suit_name,'未知') as suit_name,
	coalesce(st_lpt.lpt_suit_moeny,st_ad.ad_money,st_bc.bc_money,st_srp.srp_money,st_test.test_money,'未知') as suit_money,
	nvl(income.online_money,0) as online_income_money,
	nvl(income.rpo_money,0) as rpo_income_moeny,
	nvl(income.xy_money,0) as xy_income_moeny,	
	nvl(income.income_money,0) as income_money,
	nvl(income.pay_time,'1900-01-01') as income_date,
	current_timestamp as creation_timestamp
from 
(
	select 
	   income.contract_id,
	   income.pay_time,
	   income.income_money,
	   case when income.income_money >= recv.online_money then recv.online_money 
	   		else income.income_money end as online_money,
	   case when income.income_money >= recv.online_money + recv.rpo_money then recv.rpo_money 
	   		when income.income_money > recv.online_money and income.income_money < recv.online_money + recv.rpo_money then income.income_money - recv.online_money
	   		when income.income_money < recv.online_money then 0
	   		else 0 end as rpo_money,
	   case when income.income_money >= recv.online_money + recv.rpo_money + recv.xy_money then recv.xy_money 
	   		when income.income_money > recv.online_money + recv.rpo_money and income.income_money < recv.online_money + recv.rpo_money + recv.xy_money  then income.income_money - recv.online_money - recv.rpo_money
	   		when income.income_money < recv.online_money + recv.rpo_money then 0
	   		else 0 end as xy_money
	from 
	(	select income.contract_id,
				sum(income.money) as income_money,
				max(pay_time) as pay_time
		from dw_erp_a_crmfinance_income income
		group by income.contract_id) income
	left join 
	(	select recv.contract_id,
			   sum(case when item.type = 0 then item.money else 0 end) as online_money,
			   sum(case when item.type = 1 then item.money else 0 end) as rpo_money,
			   sum(case when item.type = 2 then item.money else 0 end) as xy_money		   
		  from crm_finance_receivables recv 
		  left join crm_finance_receivable_item item
		  on recv.id = item.receivable_id
		  and item.deleteflag = 0
		  where recv.deleteflag = 0 
		   and recv.pay_status <> 3
		  group by recv.contract_id) recv
	on income.contract_id = recv.contract_id
) income 
join dw_erp_d_contract_base contract 
on income.contract_id = contract.id 
and contract.p_date = '$date$'

left join 
( 
	select contract_id,suit_name,suit_id,lpt_suit_moeny,is_have_lpt
	from 
	(	select contract_id,
			 row_number()over(distribute by contract_id sort by haslptresource desc,money desc) as rn,
			 1 as is_have_lpt,
			 suitid as suit_id,
			 suitname as suit_name,
			 money as lpt_suit_moeny
		from dw_erp_a_contract_saleitem 
		where haslptresource > 0) lpt0
	where rn = 1
) st_lpt 
on contract.id = st_lpt.contract_id

left join 
( 
	select contract_id,suit_name,suit_id,ad_money,is_have_lpt
	from 
	(	select contract_id,
			 row_number()over(distribute by contract_id sort by haslptresource desc,money desc) as rn,
			 0 as is_have_lpt,
			 suitid as suit_id,
			 suitname as suit_name,
			 money as ad_money
		from dw_erp_a_contract_saleitem 
		where haslptresource = 0
		and instr(suitname,'广告') > 0
	) lpt0
	where rn = 1
) st_ad 
on contract.id = st_ad.contract_id

left join 
( 
	select contract_id,suit_name,suit_id,bc_money,is_have_lpt
	from 
	(	select contract_id,
			 row_number()over(distribute by contract_id sort by haslptresource desc,money desc) as rn,
			 0 as is_have_lpt,
			 suitid as suit_id,
			 suitname as suit_name,
			 money as bc_money
		from dw_erp_a_contract_saleitem 
		where haslptresource = 0
		and instr(suitname,'商业中心') > 0
	) lpt0
	where rn = 1
) st_bc 
on contract.id = st_bc.contract_id

left join 
( 
	select contract_id,suit_name,suit_id,srp_money,is_have_lpt
	from 
	(	select contract_id,
			 row_number()over(distribute by contract_id sort by haslptresource desc,money desc) as rn,
			 0 as is_have_lpt,
			 suitid as suit_id,
			 suitname as suit_name,
			 money as srp_money
		from dw_erp_a_contract_saleitem 
		where haslptresource = 0
		and instr(suitname,'薪酬报告') > 0
	) lpt0
	where rn = 1
) st_srp 
on contract.id = st_srp.contract_id

left join 
( 
	select contract_id,suit_name,suit_id,test_money,is_have_lpt
	from 
	(	select contract_id,
			 row_number()over(distribute by contract_id sort by haslptresource desc,money desc) as rn,
			 0 as is_have_lpt,
			 suitid as suit_id,
			 suitname as suit_name,
			 money as test_money
		from dw_erp_a_contract_saleitem 
		where haslptresource = 0
		and instr(suitname,'测评') > 0
	) lpt0
	where rn = 1
) st_test 
on contract.id = st_test.contract_id

left join dim_org 
on contract.secondparty_sign_org = dim_org.d_org_id;