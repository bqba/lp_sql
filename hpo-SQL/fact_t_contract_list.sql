insert overwrite table fact_t_contract_list partition (p_date = $date$)
select
d_date,
if(e.sign_id is null,0,e.sign_id) as d_sales_id,
if(e.contractno is null,0,e.contractno) as d_contract_no,
if(e.tag is null,0,e.tag) as d_account_tag,
if(pu.entrydate is null,0,pu.entrydate) as sales_entry_date,
if(pp.position_channel is null,0,pp.position_channel) as sales_position_channel,
if(pp.position_level is null,0,pp.position_level) as sales_position_level,
if(pu.org_id is null,0,pu.org_id) as sales_org_id,
if(pu.status is null,9,pu.status) as sales_status,
if(e.cust_id is null,0,e.cust_id) as cust_id,
if(e.contract_type is null,999,e.contract_type) as contract_type,
if(e.is_junior_contract is null,999,e.is_junior_contract) as is_junior_contract,
if(bc.industry is null,999,bc.industry) as comp_industry,
if(e.money is null,0,e.money) as contract_money,
from_unixtime(unix_timestamp())
from
(select '$date$' as d_date,d.tag,d.contractno,d.cust_id,d.contract_type,d.money,d.sign_id,d.is_junior_contract
from
(
select 'income' as tag,bf.contract_no as contractno,bf.customer_id as cust_id,substr(bf.pay_time,1,8) as pay_time as time1,
cc.type as contract_type,sum(bf.money) as money,bf.creator_id as sign_id,ccl.is_junior_contract
from crm_finance_income as bf
left outer join crm_contract cc on bf.contract_id = cc.id
left outer join crm_contract_lpt ccl on ccl.contract_id = bf.contract_id
where substr(bf.pay_time,1,8) as pay_time = '$date$'
and bf.money>0
and bf.deleteflag =0
group by bf.contract_no,'income',bf.customer_id,substr(bf.pay_time,1,8) as pay_time,cc.type,bf.creator_id,
ccl.is_junior_contract
union all
select 'signed' as tag,lp.contract_no as contractno,lp.customer_id as cust_id,
regexp_replace(substr(br.createtime,1,10),"-","") as time1,
lp.type as contract_type,sum(br.money) as money,lp.secondparty_sign_id as sign_id,ccl.is_junior_contract
from crm_finance_receivables br
join crm_contract lp on lp.id = br.contract_id
left outer join crm_contract_lpt ccl on ccl.contract_id = lp.id
where regexp_replace(substr(br.createtime,1,10),"-","") = '$date$'
and br.money>0
group by 'signed',lp.contract_no,lp.customer_id,regexp_replace(substr(br.createtime,1,10),"-",""),
lp.type,lp.secondparty_sign_id,ccl.is_junior_contract
union all
select 'invoice' as tag,lp.contract_no as contractno,lp.customer_id as cust_id,
regexp_replace(substr(cfi.modifytime,1,10),"-","") as time1,
lp.type as contract_type,sum(cfi.money) as money,lp.secondparty_sign_id as sign_id,ccl.is_junior_contract
from crm_finance_invoice cfi
join crm_contract lp on cfi.object_id = lp.id
left outer join crm_contract_lpt ccl on ccl.contract_id = lp.id
where lp.type <> 14
and cfi.status = 1
and cfi.money>0
and regexp_replace(substr(cfi.modifytime,1,10),"-","") = '$date$'
group by 'invoice',lp.contract_no,lp.customer_id,regexp_replace(substr(cfi.modifytime,1,10),"-",""),
lp.type,lp.secondparty_sign_id,ccl.is_junior_contract
) d
) e
left outer join portal_employee pu on pu.id = e.sign_id
left outer join portal_position pp on pu.position_id = pp.id
left outer join dw_erp_d_customer_base_new bc on e.cust_id =bc.id
