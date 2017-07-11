---2016年1-9月GCDC意向数据
-- 1. 反馈客户结果
select 	 d_month,
		 sum(release_cnt) as release_cnt,
		 sum(pub_track_cnt) as pub_track_cnt,
		 sum(high_pub_track_cnt) as high_pub_track_cnt,
		 sum(mid_pub_track_cnt) as mid_pub_track_cnt,
		 sum(low_pub_track_cnt) as low_pub_track_cnt,
		 sum(none_pub_track_cnt) as none_pub_track_cnt,
		 sum(invalid_track_cnt) as invalid_track_cnt
from (
select substr(regexp_replace(createtime,'-',''),1,6) as d_month,
	   count(id) as release_cnt,
		0 as pub_track_cnt,
		0 as high_pub_track_cnt,
		0 as mid_pub_track_cnt,
		0 as low_pub_track_cnt,
		0 as none_pub_track_cnt,
		0 as invalid_track_cnt
from rsc_intention
where deleteflag = 0
and intention_type in (1,2)
and substr(regexp_replace(createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(createtime,'-',''),1,6)
union all 
select  substr(committime,1,6) as d_month,
	    0 as release_cnt,
	    count(case when result in (1,2,3,4) then id else null end)  as pub_track_cnt,
	    count(case when result =1 then id else null end) as high_pub_track_cnt,
		count(case when result =2 then id else null end) as mid_pub_track_cnt,
		count(case when result =3 then id else null end) as low_pub_track_cnt,
		count(case when result =4 then id else null end) as none_pub_track_cnt,
		count(case when result =6 then id else null end) as invalid_track_cnt
from rsc_intention
where deleteflag = 0
and intention_type in (1,2)
and result in (1,2,3,4,6)
and substr(committime,1,6) between 201601 and 201609
group by substr(committime,1,6)
) intention
group by d_month


--2. C端跟进结果
select 	 d_month,
		 sum(release_cnt) as release_cnt,
		 sum(pub_track_cnt) as pub_track_cnt,
		 sum(high_pub_track_cnt) as high_pub_track_cnt,
		 sum(mid_pub_track_cnt) as mid_pub_track_cnt,
		 sum(low_pub_track_cnt) as low_pub_track_cnt,
		 sum(none_pub_track_cnt) as none_pub_track_cnt,
		 sum(invalid_track_cnt) as invalid_track_cnt
from (
select substr(regexp_replace(createtime,'-',''),1,6) as d_month,
	   count(id) as release_cnt,
		0 as pub_track_cnt,
		0 as high_pub_track_cnt,
		0 as mid_pub_track_cnt,
		0 as low_pub_track_cnt,
		0 as none_pub_track_cnt,
		0 as invalid_track_cnt
from rsc_intention_task_c
where deleteflag = 0
and intention_type in (1,2)
and substr(regexp_replace(createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(createtime,'-',''),1,6)
union all 
select  substr(regexp_replace(createtime,'-',''),1,6) as d_month,
	    0 as release_cnt,
	    count(case when result in (1,2,3,4) then id else null end)  as pub_track_cnt,
	    count(case when result =1 then id else null end) as high_pub_track_cnt,
		count(case when result =2 then id else null end) as mid_pub_track_cnt,
		count(case when result =3 then id else null end) as low_pub_track_cnt,
		count(case when result =4 then id else null end) as none_pub_track_cnt,
		count(case when result =6 then id else null end) as invalid_track_cnt
from rsc_intention_task_c_log
where deleteflag = 0
and intention_type in (1,2)
and status = 1
and result in (1,2,3,4,6)
and substr(regexp_replace(createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(createtime,'-',''),1,6)
) intention
group by d_month;

--3. B端收回数据跟进结果


select 	 d_month,
		 sum(retrieve_cnt) as retrieve_cnt,
		 sum(pub_track_cnt) as pub_track_cnt,
		 sum(high_pub_track_cnt) as high_pub_track_cnt,
		 sum(mid_pub_track_cnt) as mid_pub_track_cnt,
		 sum(low_pub_track_cnt) as low_pub_track_cnt,
		 sum(none_pub_track_cnt) as none_pub_track_cnt,
		 sum(invalid_track_cnt) as invalid_track_cnt
from (
select substr(regexp_replace(createtime,'-',''),1,6) as d_month,
	   count(id) as retrieve_cnt,
		0 as pub_track_cnt,
		0 as high_pub_track_cnt,
		0 as mid_pub_track_cnt,
		0 as low_pub_track_cnt,
		0 as none_pub_track_cnt,
		0 as invalid_track_cnt
from rsc_intention_task_c_log
where deleteflag = 0
and intention_type in (1,2)
and status = 3
and substr(regexp_replace(createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(createtime,'-',''),1,6)
union all 
select  substr(regexp_replace(log.createtime,'-',''),1,6) as d_month,
	    0 as retrieve_cnt,
	    count(case when log.result in (1,2,3,4) then log.rsc_intention_task_b_id else null end)  as pub_track_cnt,
	    count(case when log.result =1 then log.rsc_intention_task_b_id else null end) as high_pub_track_cnt,
		count(case when log.result =2 then log.rsc_intention_task_b_id else null end) as mid_pub_track_cnt,
		count(case when log.result =3 then log.rsc_intention_task_b_id else null end) as low_pub_track_cnt,
		count(case when log.result =4 then log.rsc_intention_task_b_id else null end) as none_pub_track_cnt,
		count(case when log.result =6 then log.rsc_intention_task_b_id else null end) as invalid_track_cnt
from rsc_intention_task_b_log log 
join rsc_intention_task_c task 
on task.status = 3
and log.rsc_intention_task_b_id = task.rsc_intention_task_b_id 
where log.deleteflag = 0
and log.intention_type in (1,2)
and log.result in (1,2,3,4,6)
and substr(regexp_replace(log.createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(log.createtime,'-',''),1,6)
) intention
group by d_month;



select 	 d_month,
		 sum(retrieve_cnt) as retrieve_cnt,
		 sum(pub_track_cnt) as pub_track_cnt,
		 sum(high_pub_track_cnt) as high_pub_track_cnt,
		 sum(mid_pub_track_cnt) as mid_pub_track_cnt,
		 sum(low_pub_track_cnt) as low_pub_track_cnt,
		 sum(none_pub_track_cnt) as none_pub_track_cnt,
		 sum(invalid_track_cnt) as invalid_track_cnt
from (
select substr(regexp_replace(modifytime,'-',''),1,6) as d_month,
	   count(id) as retrieve_cnt,
		0 as pub_track_cnt,
		0 as high_pub_track_cnt,
		0 as mid_pub_track_cnt,
		0 as low_pub_track_cnt,
		0 as none_pub_track_cnt,
		0 as invalid_track_cnt
from rsc_intention_task_c_log
where deleteflag = 0
and intention_type in (1,2)
and status = 3
and substr(regexp_replace(modifytime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(modifytime,'-',''),1,6)
union all 
select  substr(regexp_replace(log.createtime,'-',''),1,6) as d_month,
	    0 as retrieve_cnt,
	    count(case when log.result in (1,2,3,4) then log.rsc_intention_task_b_id else null end)  as pub_track_cnt,
	    count(case when log.result =1 then log.rsc_intention_task_b_id else null end) as high_pub_track_cnt,
		count(case when log.result =2 then log.rsc_intention_task_b_id else null end) as mid_pub_track_cnt,
		count(case when log.result =3 then log.rsc_intention_task_b_id else null end) as low_pub_track_cnt,
		count(case when log.result =4 then log.rsc_intention_task_b_id else null end) as none_pub_track_cnt,
		count(case when log.result =6 then log.rsc_intention_task_b_id else null end) as invalid_track_cnt
from rsc_intention_task_b_log log 
join rsc_intention_task_c task 
on task.status = 3
and log.rsc_intention_task_b_id = task.rsc_intention_task_b_id 
where log.deleteflag = 0
and log.intention_type in (1,2)
and log.result in (1,2,3,4,6)
and substr(regexp_replace(log.createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(log.createtime,'-',''),1,6)
) intention
group by d_month;


--4. 客户签约金额维度

select 	 d_month,
		 money_level,
		 sum(new_intention_cnt) as new_intention_cnt,
		 sum(release_cnt) as release_cnt,
		 sum(pub_track_cnt) as pub_track_cnt,
		 sum(high_pub_track_cnt) as high_pub_track_cnt,
		 sum(mid_pub_track_cnt) as mid_pub_track_cnt,
		 sum(low_pub_track_cnt) as low_pub_track_cnt,
		 sum(none_pub_track_cnt) as none_pub_track_cnt,
		 sum(invalid_track_cnt) as invalid_track_cnt,
		 sum(avg_pay_days) as avg_pay_days
from (

select substr(regexp_replace(task.createtime,'-',''),1,6) as d_month,
		case when contract.money < 8000 then '客户签约金额 8k以下' 
			 when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
		end as money_level,
	   count(task.id) as new_intention_cnt,
	    0 as release_cnt,
		0 as pub_track_cnt,
		0 as high_pub_track_cnt,
		0 as mid_pub_track_cnt,
		0 as low_pub_track_cnt,
		0 as none_pub_track_cnt,
		0 as invalid_track_cnt,
		0 as avg_pay_days
from rsc_intention task 
left join 
(select customer_id,avg(money) as money
		from dw_erp_d_contract_base
		where type = 0
		and status in (2,3)
		and regexp_replace(lpt_service_expired_date,'-','') >=20160101
		and regexp_replace(lpt_service_effect_date,'-','') <=20160930
		and p_date = 20160930
		group by customer_id) contract 
on task.customer_id = contract.customer_id
where task.deleteflag = 0
and task.intention_type in (1,2)
and substr(regexp_replace(task.createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(task.createtime,'-',''),1,6),
		case when contract.money < 8000 then '客户签约金额 8k以下' 
			 when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
		end 

union all 
select substr(regexp_replace(task.createtime,'-',''),1,6) as d_month,
		case when contract.money < 8000 then '客户签约金额 8k以下' 
			 when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
		end as money_level,
		0 as new_intention_cnt,
	   count(task.id) as release_cnt,
		0 as pub_track_cnt,
		0 as high_pub_track_cnt,
		0 as mid_pub_track_cnt,
		0 as low_pub_track_cnt,
		0 as none_pub_track_cnt,
		0 as invalid_track_cnt,
		0 as avg_pay_days
from rsc_intention_task_c task 
left join 
(select customer_id,sum(money) as money
		from crm_contract
		where type = 0
		and status in (2,3)
		and deleteflag = 0
		group by customer_id) contract 
on task.customer_id = contract.customer_id
where task.deleteflag = 0
and task.intention_type in (1,2)
and substr(regexp_replace(task.createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(task.createtime,'-',''),1,6),
		case when contract.money < 8000 then '客户签约金额 8k以下' 
			 when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
		end 

union all 

select  substr(regexp_replace(log.createtime,'-',''),1,6) as d_month,
		case when contract.money < 8000 then '客户签约金额 8k以下' 
			 when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
		end as money_level,
		0 as new_intention_cnt,
	    0 as release_cnt,
	    count(case when log.result in (1,2,3,4) then log.rsc_intention_task_c_id else null end)  as pub_track_cnt,
	    count(case when log.result =1 then log.rsc_intention_task_c_id else null end) as high_pub_track_cnt,
		count(case when log.result =2 then log.rsc_intention_task_c_id else null end) as mid_pub_track_cnt,
		count(case when log.result =3 then log.rsc_intention_task_c_id else null end) as low_pub_track_cnt,
		count(case when log.result =4 then log.rsc_intention_task_c_id else null end) as none_pub_track_cnt,
		count(case when log.result =6 then log.rsc_intention_task_c_id else null end) as invalid_track_cnt,
		avg(datediff(log.createtime,task.createtime)) as avg_pay_days
from rsc_intention_task_c_log log 
join rsc_intention_task_c task 
on log.rsc_intention_task_c_id = task.id
and task.deleteflag = 0 
left join (select customer_id,sum(money) as money
		from crm_contract
		where type = 0
		and status in (2,3)
		and deleteflag = 0
		group by customer_id) contract 
on task.customer_id = contract.customer_id
where log.deleteflag = 0
and log.intention_type in (1,2)
and log.status = 1
and log.result in (1,2,3,4,6)
and substr(regexp_replace(log.createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(log.createtime,'-',''),1,6),
		case when contract.money < 8000 then '客户签约金额 8k以下' 
			 when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
		end 
) intention
group by d_month,money_level;


------new 
select 	 d_month,
		 money_level,
		 sum(new_intention_cnt) as new_intention_cnt,
		 sum(release_cnt) as release_cnt,
		 sum(pub_track_cnt) as pub_track_cnt,
		 sum(high_pub_track_cnt) as high_pub_track_cnt,
		 sum(mid_pub_track_cnt) as mid_pub_track_cnt,
		 sum(low_pub_track_cnt) as low_pub_track_cnt,
		 sum(none_pub_track_cnt) as none_pub_track_cnt,
		 sum(invalid_track_cnt) as invalid_track_cnt,
		 sum(avg_pay_days) as avg_pay_days
from (

select substr(regexp_replace(task.createtime,'-',''),1,6) as d_month,
		case when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
			 else '客户签约金额 8k以下' 
		end as money_level,
	   count(task.id) as new_intention_cnt,
	    0 as release_cnt,
		0 as pub_track_cnt,
		0 as high_pub_track_cnt,
		0 as mid_pub_track_cnt,
		0 as low_pub_track_cnt,
		0 as none_pub_track_cnt,
		0 as invalid_track_cnt,
		0 as avg_pay_days
from rsc_intention task 
left join 
(select  cust.id as customer_id,
		 case when parent_customer_id <> 0  then parent_customer_id
		 	  when master_customer_id <> member_customer_id then  master_customer_id
		 	  else cust.id
		 end as parent_id
	from dw_erp_d_customer_base_new cust 
	left join crm_customer_package package 
	on cust.id = package.member_customer_id) cust
on task.customer_id = cust.customer_id
left join 
(select customer_id,avg(money) as money
		from dw_erp_d_contract_base
		where type = 0
		and status in (2,3)
		and regexp_replace(lpt_service_expired_date,'-','') >=20160101
		and regexp_replace(lpt_service_effect_date,'-','') <=20160930
		and p_date = 20160930
		and money > 0
		group by customer_id) contract 
on cust.parent_id = contract.customer_id
where task.deleteflag = 0
and task.intention_type in (1,2)
and substr(regexp_replace(task.createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(task.createtime,'-',''),1,6),
		case when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
			 else '客户签约金额 8k以下' 
		end

union all 
select substr(regexp_replace(task.createtime,'-',''),1,6) as d_month,
		case when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
			 else '客户签约金额 8k以下' 
		end as  money_level,
		0 as new_intention_cnt,
	   count(task.id) as release_cnt,
		0 as pub_track_cnt,
		0 as high_pub_track_cnt,
		0 as mid_pub_track_cnt,
		0 as low_pub_track_cnt,
		0 as none_pub_track_cnt,
		0 as invalid_track_cnt,
		0 as avg_pay_days
from rsc_intention_task_c task 
left join 
(select  cust.id as customer_id,
		 case when parent_customer_id <> 0  then parent_customer_id
		 	  when master_customer_id <> member_customer_id then  master_customer_id
		 	  else cust.id
		 end as parent_id
	from dw_erp_d_customer_base_new cust 
	left join crm_customer_package package 
	on cust.id = package.member_customer_id) cust
on task.customer_id = cust.customer_id
left join 
(select customer_id,avg(money) as money
		from dw_erp_d_contract_base
		where type = 0
		and status in (2,3)
		and regexp_replace(lpt_service_expired_date,'-','') >=20160101
		and regexp_replace(lpt_service_effect_date,'-','') <=20160930
		and p_date = 20160930
		and money > 0
		group by customer_id) contract 
on cust.parent_id = contract.customer_id
where task.deleteflag = 0
and task.intention_type in (1,2)
and substr(regexp_replace(task.createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(task.createtime,'-',''),1,6),
		case when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
			 else '客户签约金额 8k以下' 
		end

union all 

select  substr(regexp_replace(log.createtime,'-',''),1,6) as d_month,
		case when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
			 else '客户签约金额 8k以下' 
		end as money_level,
		0 as new_intention_cnt,
	    0 as release_cnt,
	    count(case when log.result in (1,2,3,4) then log.rsc_intention_task_c_id else null end)  as pub_track_cnt,
	    count(case when log.result =1 then log.rsc_intention_task_c_id else null end) as high_pub_track_cnt,
		count(case when log.result =2 then log.rsc_intention_task_c_id else null end) as mid_pub_track_cnt,
		count(case when log.result =3 then log.rsc_intention_task_c_id else null end) as low_pub_track_cnt,
		count(case when log.result =4 then log.rsc_intention_task_c_id else null end) as none_pub_track_cnt,
		count(case when log.result =6 then log.rsc_intention_task_c_id else null end) as invalid_track_cnt,
		avg(datediff(log.createtime,task.createtime)) as avg_pay_days
from rsc_intention_task_c_log log 
join rsc_intention_task_c task 
on log.rsc_intention_task_c_id = task.id
and task.deleteflag = 0 
left join 
(select  cust.id as customer_id,
		 case when parent_customer_id <> 0  then parent_customer_id
		 	  when master_customer_id <> member_customer_id then  master_customer_id
		 	  else cust.id
		 end as parent_id
	from dw_erp_d_customer_base_new cust 
	left join crm_customer_package package 
	on cust.id = package.member_customer_id) cust
on task.customer_id = cust.customer_id
left join (select customer_id,avg(money) as money
		from dw_erp_d_contract_base
		where type = 0
		and status in (2,3)
		and regexp_replace(lpt_service_expired_date,'-','') >=20160101
		and regexp_replace(lpt_service_effect_date,'-','') <=20160930
		and p_date = 20160930
		and money > 0
		group by customer_id) contract 
on cust.parent_id = contract.customer_id
where log.deleteflag = 0
and log.intention_type in (1,2)
and log.status = 1
and log.result in (1,2,3,4,6)
and substr(regexp_replace(log.createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(log.createtime,'-',''),1,6),
		case when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
			 else '客户签约金额 8k以下' 
		end
) intention
group by d_month,money_level;

---5. 2016年 1-9月 GCDC 意向数据

select 	 d_month,
		 money_level,
		 sum(release_cnt) as release_cnt,
		 sum(open_track_cnt) as open_track_cnt,
		 sum(close_track_cnt) as close_track_cnt,
		 sum(fail_track_cnt) as fail_track_cnt
from (
select substr(regexp_replace(task.createtime,'-',''),1,6) as d_month,
		case when contract.money < 8000 then '客户签约金额 8k以下' 
			 when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
		end as money_level,
	   count(task.id) as release_cnt,
		0 as open_track_cnt,
		0 as close_track_cnt,
		0 as fail_track_cnt
from rsc_intention_task_c task 
left join 
(select  cust.id as customer_id,
		 case when parent_customer_id <> 0  then parent_customer_id
		 	  when master_customer_id <> member_customer_id then  master_customer_id
		 	  else cust.id
		 end as parent_id
	from dw_erp_d_customer_base_new cust 
	left join crm_customer_package package 
	on cust.id = package.member_customer_id) cust
on task.customer_id = cust.customer_id
left join 
(select customer_id,avg(money) as money
		from dw_erp_d_contract_base
		where type = 0
		and status in (2,3)
		and regexp_replace(lpt_service_expired_date,'-','') >=20160101
		and regexp_replace(lpt_service_effect_date,'-','') <=20160930
		and p_date = 20160930
		and money > 0
		group by customer_id) contract 
on cust.parent_id = contract.customer_id
where task.deleteflag = 0
and task.intention_type = 0
and substr(regexp_replace(task.createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(task.createtime,'-',''),1,6),
		case when contract.money < 8000 then '客户签约金额 8k以下' 
			 when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
		end 

union all 

select  substr(regexp_replace(log.createtime,'-',''),1,6) as d_month,
		case when contract.money < 8000 then '客户签约金额 8k以下' 
			 when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
		end as money_level,
	    0 as release_cnt,
	    count(case when log.demand_concat_result =1 then log.rsc_intention_task_c_id else null end) as open_track_cnt,
		count(case when log.demand_concat_result =2 then log.rsc_intention_task_c_id else null end) as close_track_cnt,
		count(case when log.demand_concat_result =4 then log.rsc_intention_task_c_id else null end) as fail_track_cnt
from rsc_intention_task_c_log log 
join rsc_intention_task_c task 
on log.rsc_intention_task_c_id = task.id
and task.deleteflag = 0 
left join 
(select  cust.id as customer_id,
		 case when parent_customer_id <> 0  then parent_customer_id
		 	  when master_customer_id <> member_customer_id then  master_customer_id
		 	  else cust.id
		 end as parent_id
	from dw_erp_d_customer_base_new cust 
	left join crm_customer_package package 
	on cust.id = package.member_customer_id) cust
on task.customer_id = cust.customer_id
left join 
(select customer_id,avg(money) as money
		from dw_erp_d_contract_base
		where type = 0
		and status in (2,3)
		and regexp_replace(lpt_service_expired_date,'-','') >=20160101
		and regexp_replace(lpt_service_effect_date,'-','') <=20160930
		and p_date = 20160930
		and money > 0
		group by customer_id) contract 
on cust.parent_id = contract.customer_id
where log.intention_type = 0
and log.deleteflag = 0
and log.demand_concat_result in (1,2,4)
and log.status = 1
and substr(regexp_replace(log.createtime,'-',''),1,6) between 201601 and 201609
group by substr(regexp_replace(log.createtime,'-',''),1,6),
		case when contract.money < 8000 then '客户签约金额 8k以下' 
			 when contract.money between 8000 and 30000 then '客户签约金额 8k-3w' 
			 when contract.money > 30000 then '客户签约金额 3w以上' 
		end 
) intention
group by d_month,money_level;

--简历编号	人选简历行业	人选简历职位	人选简历地区	推荐企业行业	推荐人选职位	推荐职位地区	无效原因	无效提交时间	最后更新简历时间	负责顾问	顾问所在小组
select
'简历编号',
'人选简历行业',
'人选简历职位',
'人选简历地区',
'推荐企业行业',
'推荐人选职位',
'推荐职位地区',
'无效原因',
'无效提交时间',
'最后更新简历时间',
'负责顾问',
'顾问所在小组'
from dummy;
select 	
		ctask.res_id,
		--res.c_industry,
		nvl(c_industry.d_sub_industry,cc_industry.d_sub_industry),
		--res.c_jobtitle,
		nvl(c_jobtitle.d_ch_name,cc_jobtitle.d_ch_name),
		--res.c_dq,
		nvl(c_dq.d_ch_name,cc_dq.d_ch_name),			
		--ctask.rsc_ejob_id,
		--ejob.ejob_id,
		--ejob.ecomp_industry_first,
		e_industry.d_sub_industry,
		ejob.ejob_title,
		--ejob.ejob_dq_first,
		e_dq.d_ch_name,
		clog.content,		
		clog.createtime,
		res.res_modifiedtime,		
		--clog.creator_id,
		user.name,
		--clog.org_id,
		dim_org.org_name
from (
	select rsc_intention_task_c_id,content,createtime,creator_id,org_id,status
	from (
		select rsc_intention_task_c_id,content,createtime,creator_id,org_id,status,
			row_number()over(distribute by rsc_intention_task_c_id sort by modifytime desc) as rn 
		from rsc_intention_task_c_log
		where substr(regexp_replace(createtime,'-',''),1,6) between 201601 and 201606
		and result = 6
		and deleteflag = 0
	) unique_log
	where rn = 1
) clog
join rsc_intention_task_c ctask
on clog.rsc_intention_task_c_id = ctask.id
and ctask.deleteflag = 0
left join rsc_ejob rjob
on ctask.rsc_ejob_id = rjob.id
and rjob.deleteflag = 0
left join 
(select ejob_id,ecomp_industry_first,ejob_title,ejob_dq_first
   from dw_b_d_ejob_base 
  where p_date = 20160901 ) ejob
on rjob.ejob_id = ejob.ejob_id
left join 
(select res_id,c_industry,c_jobtitle,c_dq,res_modifiedtime
   from dw_c_d_res_base
  where p_date = 20160901) res
on ctask.res_id = res.res_id
left join dim_org
on clog.org_id = dim_org.d_org_id
left join (
	select id,name
	from dw_erp_d_salesuser_base
	where p_date = 20160901
) user
on clog.creator_id = user.id
left join dim_industry c_industry
on res.c_industry = c_industry.d_ind_code
left join dim_industry e_industry
on ejob.ecomp_industry_first = e_industry.d_ind_code
left join dim_jobtitle c_jobtitle
on res.c_jobtitle = c_jobtitle.d_code
left join dim_dq c_dq
on res.c_dq = c_dq.d_code
left join dim_dq e_dq
on ejob.ejob_dq_first = e_dq.d_code
left join res_profile 
on ctask.res_id = res_profile.res_id
left join dim_dq cc_dq
on res_profile.res_dq = cc_dq.d_code
left join dim_industry cc_industry
on res_profile.res_industry = cc_industry.d_ind_code
left join dim_jobtitle cc_jobtitle
on res_profile.res_jobtitle = cc_jobtitle.d_code



--无效明细数据测试
select 	
		case when user_id = 0 then 0 else 1 end ,count(1)
from (
	select rsc_intention_task_c_id,content,createtime,creator_id,org_id,status
	from (
		select rsc_intention_task_c_id,content,createtime,creator_id,org_id,status,
			row_number()over(distribute by rsc_intention_task_c_id sort by modifytime desc) as rn 
		from rsc_intention_task_c_log
		where substr(regexp_replace(createtime,'-',''),1,6) between 201601 and 201606
		and result = 6
		and deleteflag = 0
	) unique_log
	where rn = 1
) clog
join rsc_intention_task_c ctask
on clog.rsc_intention_task_c_id = ctask.id
and ctask.deleteflag = 0
left join 
(select res_id,user_id
   from res_user) res
on ctask.res_id = res.res_id
group by case when user_id = 0 then 0 else 1 end 

select res_profile.res_dq,count(1)
from 
res_profile left join 
(select res_id,c_industry,c_jobtitle,c_dq,res_modifiedtime
   from dw_c_d_res_base
  where p_date = 20160901) res
on res_profile.res_id = res.res_id
where res.res_id is null 
group by res_profile.res_dq


--时间维表设置
create table temp_gcdc_dtime_grade
(dtime string,
dtime_grade string)
row format delimited fields terminated by '\t';

select concat(hour,min,'00') as dtime ,
   case 
    when concat(hour,min) between '0900' and '1100' then '9:00-11:00' 
    when concat(hour,min) between '1101' and '1330' then '11:00-13:30' 
    when concat(hour,min) between '1331' and '1630' then '13:30-16:30'
    when concat(hour,min) between '1631' and '1800' then '16:30-18:00'
    when concat(hour,min) between '1801' and '2000' then '18:00-20:00'
    else  '20:00-9:00'
   end as dtime_grade
from  dim_time

--分时段数据获取
select 
'统计月份',
'时段',
'释放数（RPS）',
'释放数（企业）',
'呼出数',
'接通数',
'有效沟通数',
'完成数',
'意向度高',
'意向度中',
'意向度低',
'意向度无',
'无效',
'未知',
'未知清扫数（完成数）',
'未知清扫数（无效）'
from dummy;

select 
	d_month,
	d_grade,
	sum(release_cnt) as release_cnt,
	sum(release_cust_cnt) as release_cust_cnt,	
	sum(call_out_cnt) as call_out_cnt,
	sum(call_answer_cnt) as call_answer_cnt,
	sum(call_is_valid) as call_is_valid,
	sum(pub_track_cnt) as pub_track_cnt,
	sum(high_pub_track_cnt) as high_pub_track_cnt,
	sum(mid_pub_track_cnt) as mid_pub_track_cnt,
	sum(low_pub_track_cnt) as low_pub_track_cnt,
	sum(none_pub_track_cnt) as none_pub_track_cnt,
	sum(invalid_track_cnt) as invalid_track_cnt,
	sum(unknow_track_cnt) as unknow_track_cnt,
	sum(unknow_valid_cnt) as unknow_valid_cnt,
	sum(unknow_invalid_cnt) as unknow_invalid_cnt
from 
(
	select
		substr(regexp_replace(log.createtime,'-',''),1,6) as d_month,
		dtime.dtime_grade as d_grade,
		sum(case when log.status = 0 then 1 else 0 end) as release_cnt,
		count(distinct case when log.status = 0 then task.customer_id else null end) as release_cust_cnt,	
		0 as call_out_cnt,
		0 as call_answer_cnt,
		0 as call_is_valid,
		sum(case when log.result in (1,2,3,4) then 1 else 0 end) as pub_track_cnt,
		sum(case when log.result =1 then 1 else 0 end) as high_pub_track_cnt,
		sum(case when log.result =2 then 1 else 0 end) as mid_pub_track_cnt,
		sum(case when log.result =3 then 1 else 0 end) as low_pub_track_cnt,
		sum(case when log.result =4 then 1 else 0 end) as none_pub_track_cnt,
		sum(case when log.result =6 then 1 else 0 end) as invalid_track_cnt,
		sum(case when log.result =5 then 1 else 0 end) as unknow_track_cnt,
		0 as unknow_valid_cnt,
		0 as unknow_invalid_cnt
	from rsc_intention_task_c_log log
	join rsc_intention_task_c task 
	on log.rsc_intention_task_c_id = task.id	
	join temp_gcdc_dtime_grade dtime 
	on substr(regexp_replace(regexp_replace(log.createtime,'-',''),':',''),10,4) = dtime.dtime 
	where substr(regexp_replace(log.createtime,'-',''),1,6) between 201603 and 201607
	group by substr(regexp_replace(log.createtime,'-',''),1,6),dtime.dtime_grade

	union all 

	select substr(call_date,1,6) as d_month,
		   dtime.dtime_grade as d_grade,
			0 as release_cnt,
			0 as release_cust_cnt,	
		   sum(1) as call_out_cnt,
		   sum(case when answer_status = 1 then 1 else 0 end) as call_answer_cnt,
		   sum(case when time_long > 60 then 1 else 0 end) as call_is_valid,
			0 as pub_track_cnt,
			0 as high_pub_track_cnt,
			0 as mid_pub_track_cnt,
			0 as low_pub_track_cnt,
			0 as none_pub_track_cnt,
			0 as invalid_track_cnt,
			0 as unknow_track_cnt,		
			0 as unknow_valid_cnt, 
			0 as unknow_invalid_cnt
		from (
				select org_id,begin_time,call_date,answer_status,time_long
				from call_record 
				where deleteflag  = 0
				and call_type = 0
				and call_date between 20160412 and 20160731
				union all 
				select org_id,begin_time,call_date,answer_status,time_long
				from call_record_archive 
				where deleteflag  = 0
				and call_type = 0
				and call_date between 20160301 and 20160411 
			) call 
		join temp_gcdc_dtime_grade dtime 
		  on substr(call.begin_time,1,4) = dtime.dtime 
		join dim_org
		on call.org_id = dim_org.d_org_id
		and dim_org.parent_id = 10357 
		group by substr(call_date,1,6),dtime.dtime_grade
	
	union all 

	select  
		substr(regexp_replace(used.createtime,'-',''),1,6) as d_month,
		dtime.dtime_grade d_grade,
		0 as release_cnt,
		0 as release_cust_cnt,	
		0 as call_out_cnt,
		0 as call_answer_cnt,
		0 as call_is_valid,
		0 as pub_track_cnt,
		0 as high_pub_track_cnt,
		0 as mid_pub_track_cnt,
		0 as low_pub_track_cnt,
		0 as none_pub_track_cnt,
		0 as invalid_track_cnt,
		0 as unknow_track_cnt,		
		count(distinct case when used.result in (1,2,3,4) then noused.rsc_intention_task_c_id else null end) as unknow_valid_cnt, 
		count(distinct case when used.result = 6 then noused.rsc_intention_task_c_id else null end) as unknow_invalid_cnt
	from 
	 (select  tasklog.id, tasklog.result,tasklog.rsc_intention_task_c_id
		from rsc_intention_task_c_log tasklog
	 	where tasklog.deleteflag = 0
		  and tasklog.result = '5'
		  and substr(regexp_replace(tasklog.createtime,'-',''),1,6) between 201603 and 201607
	) noused
	join 
	( select  tasklog.id, tasklog.result,tasklog.rsc_intention_task_c_id,tasklog.createtime
	   from rsc_intention_task_c_log tasklog
		where tasklog.deleteflag = 0
		 and tasklog.result in ('1','2','3','4','6')
		 and substr(regexp_replace(tasklog.createtime,'-',''),1,6) between 201603 and 201607
	) used 
	on noused.rsc_intention_task_c_id = used.rsc_intention_task_c_id
	join temp_gcdc_dtime_grade dtime 
	on substr(regexp_replace(regexp_replace(used.createtime,'-',''),':',''),10,4) = dtime.dtime
	group by substr(regexp_replace(used.createtime,'-',''),1,6),dtime.dtime_grade
) fact 
group by d_month,d_grade;



--9月"意向沟通“与”意向沟通+索要联系方式“意向类型数据统计
 select 
'统计日期',
'职业顾问',
'所属Team',
'完成数',
'意向度高',
'意向度中',
'意向度低',
'意向度无',
'未成功沟通数'
from dummy;
  select 
    intention.d_date,
    suser.name,
    dim_org.org_name,
    intention.pub_track_cnt,
    intention.high_pub_track_cnt,
    intention.mid_pub_track_cnt,
    intention.low_pub_track_cnt,
    intention.none_pub_track_cnt,
    intention.invalid_track_cnt
  from 
  (
    select
      substr(regexp_replace(log.createtime,'-',''),1,8) as d_date,
      log.creator_id,
      log.org_id,
      sum(case when log.result in (1,2,3,4) then 1 else 0 end) as pub_track_cnt,
      sum(case when log.result =1 then 1 else 0 end) as high_pub_track_cnt,
      sum(case when log.result =2 then 1 else 0 end) as mid_pub_track_cnt,
      sum(case when log.result =3 then 1 else 0 end) as low_pub_track_cnt,
      sum(case when log.result =4 then 1 else 0 end) as none_pub_track_cnt,
      sum(case when log.result =6 then 1 else 0 end) as invalid_track_cnt
    from rsc_intention_task_c_log log
    join rsc_intention_task_c task 
    on log.rsc_intention_task_c_id = task.id
    where substr(regexp_replace(log.createtime,'-',''),1,6) = '201609'
    and log.intention_type in (1,2)
    and log.deleteflag = 0
    and log.status = 1
    group by substr(regexp_replace(log.createtime,'-',''),1,8),log.creator_id,log.org_id
  ) intention
  join dw_erp_d_salesuser_base suser 
  on intention.creator_id = suser.id 
  and suser.p_date = 20160930
  join dim_org 
  on intention.org_id = dim_org.d_org_id;

--
select task.deleteflag,task.createtime,task.id,task.creator_id,log.*
  from rsc_intention_task_c_log log
    join rsc_intention_task_c task 
    on log.rsc_intention_task_c_id = task.id
    where (substr(regexp_replace(log.createtime,'-',''),1,6) = '201609'
    or substr(regexp_replace(task.createtime,'-',''),1,6) = '201609')
    and log.deleteflag = 0
    and task.creator_id = 29306
    and log.creator_id <> 29306

select log.*
from rsc_intention_task_c_log log
    join rsc_intention_task_c task 
    on log.rsc_intention_task_c_id = task.id
    where substr(regexp_replace(log.createtime,'-',''),1,6) = '201609'
    and log.intention_type in (1,2)
    and log.deleteflag = 0
    and log.creator_id = 29489
    


 --9月"意向沟通“与”意向沟通+索要联系方式“意向类型数据统计
 select 
'统计日期',
'职业顾问',
'所属Team',
'开发数',
'不开放数',
'未成功沟通数'
from dummy;
  select 
    intention.d_date,
    suser.name,
    dim_org.org_name,
    intention.open_cnt,
    intention.close_cnt,
    intention.fail_cnt
  from 
  (
    select
      substr(regexp_replace(log.createtime,'-',''),1,8) as d_date,
      log.creator_id,
      log.org_id,
      sum(case when log.demand_concat_result =1 then 1 else 0 end) as open_cnt,
      sum(case when log.demand_concat_result =2 then 1 else 0 end) as close_cnt,
      sum(case when log.demand_concat_result =4 then 1 else 0 end) as fail_cnt
    from rsc_intention_task_c_log log
    join rsc_intention_task_c task 
    on log.rsc_intention_task_c_id = task.id
    where substr(regexp_replace(log.createtime,'-',''),1,6) = '201609'
    and log.intention_type = 0
    and log.deleteflag = 0
    and log.demand_concat_result in (1,2,4)
    and log.status = 1
    group by substr(regexp_replace(log.createtime,'-',''),1,8),log.creator_id,log.org_id
  ) intention
  join dw_erp_d_salesuser_base suser 
  on intention.creator_id = suser.id 
  and suser.p_date = 20160930
  join dim_org 
  on intention.org_id = dim_org.d_org_id;

