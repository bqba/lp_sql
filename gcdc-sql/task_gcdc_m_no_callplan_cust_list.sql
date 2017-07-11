--task_gcdc_m_no_callplan_cust_list
select '客户名称','招服名称','招服团队','客户类型' from dummy;
select base.name,
		base.serviceuser_name,
		base.service_teamorg_name,
		case rsc.customer_type
			when '0' then '新签客户'
			when '1' then '到期客户'
			when '2' then 'A类活跃客户'
			when '3' then 'B类活跃客'
			when '4' then 'C类活跃客户'
			when '5' then '浅度休眠客户'
			when '6' then '中度休眠客户'
			when '7' then '深度休眠客户'
			when '8' then '其他客户'
			else '未知'
		end 
from dw_erp_d_customer_base base 
join rsc_customer rsc 
on base.id = rsc.customer_id
left join 
(select customer_id
  from rsc_callplan rsc
  where substr(rsc.calltime,1,8) between  regexp_replace(date_add(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-','01'),1),'-','') and regexp_replace(last_day(date_add(reformat_datetime('$date$','yyyy-MM-dd'),1)),'-','')
and rsc.deleteflag = 0 
and rsc.creator_id != 346 
and rsc.source <> 0) callplan 
on base.id = callplan.customer_id
where base.p_date = '$date$'
and base.rsc_valid_status = 1
and rps_service_version in (1,3)
and callplan.customer_id is null ;