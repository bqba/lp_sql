如沟通，下面是续约率和资源消耗指标调整说明，如有问题随时沟通：
消耗进程调整：
1.日目标=在名下的客户的所有目标值加和
2.月目标=日目标求和
3.合同日目标=合同中的所有资源/合同执行天数
4.客户日目标=执行中的合同日目标的求和 
（合同未到期，资源已消耗完，客户目标中不计算此合同；合同过期，合同尚未开始不计算在客户目标中）
5.客户月目标=客户日目标累加

消耗进程=顾问名下客户的日实际消耗/顾问日目标
本月N号的简历消耗率=（1-N号的实际消耗求和）/(1-N号的客户日目标求和)+（N号到31号的顾问N号名下的客户目标求和）
注：消耗进程，过年期间需要考虑指标打折情况，在每月平均值的基础上，年前1月乘以月平均0.7  过年当月乘以0.5  年后一个月乘以1.2，12月乘以1.4-1.5，此指标今年暂不调整。


create table dw_erp_d_customer_consume_target_pre
(
d_date int comment '分析日期',
customer_id int comment '客户id',
customer_name string comment '客户名称',
serviceuser_id int comment '招服id',
serviceuser_name string comment '招服姓名',
allresource int comment '总资源数',
left_cnt int comment '剩余资源数',
startdate int comment '资源有效开始时间',
enddate int comment '资源有效结束时间',
workdays int comment '工作日服务天数',
day_consume_cv_target_cnt float comment '日消耗目标值',
tm_day_consume_cv_target_cnt float comment '当月消耗目标值',
tm_left_day_consume_cv_target_cnt float comment '当月剩余消耗目标值',
creation_timestamp timestamp comment '时间戳')
comment '客户资源消耗日目标值'
partitioned by ( p_date int);

alter table dw_erp_d_customer_consume_target rename to dw_erp_d_customer_consume_target_0105;
alter table dw_erp_d_customer_consume_target_pre rename to dw_erp_d_customer_consume_target;

insert overwrite table dw_erp_d_customer_consume_target partition (p_date = $date$)
select 
  $date$ as d_date,
  salesconfirm2.customer_id,
  cus.name as customer_name,
  cus.serviceuser_id,
  cus.serviceuser_name,
  salesconfirm2.allresource,
  salesconfirm2.total_cnt - salesconfirm2.used_cnt as left_cnt,
  salesconfirm2.startdate,
  salesconfirm2.enddate,
  salesconfirm2.workdays, 
  salesconfirm2.allresource / salesconfirm2.workdays as day_consume_cv_target_cnt,
  (salesconfirm2.allresource / salesconfirm2.workdays) * (work_hour_diff(mtd_start_date,mtd_end_date)/24+1) as tm_day_consume_cv_target_cnt,
  (salesconfirm2.allresource / salesconfirm2.workdays) * (work_hour_diff('$date$',mtd_end_date)/24) as tm_left_day_consume_cv_target_cnt,
  from_unixtime(unix_timestamp()) as creation_timestamp,
  salesconfirm2.all_cv_cnt ,
  salesconfirm2.used_cv_cnt 
  from (
    select
      salesconfirm.customer_id,
      salesconfirm.startdate,
      salesconfirm.enddate,
      salesconfirm.allresource,
      sum(holiday.is_workday)over(partition by salesconfirm.customer_id) as workdays,
      row_number()over(distribute by salesconfirm.customer_id sort by salesconfirm.startdate) as rn,
      salesconfirm.total_cnt as total_cnt,
      salesconfirm.used_cnt as used_cnt,
      salesconfirm.total_cv_cnt as all_cv_cnt ,
      salesconfirm.used_cv_cnt as used_cv_cnt,     
      case when salesconfirm.startdate <  concat(substr('$date$',1,6),'01') then concat(substr('$date$',1,6),'01') else salesconfirm.startdate end as mtd_start_date,
      case when salesconfirm.enddate > regexp_replace(last_day(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-','01')),'-','') then regexp_replace(last_day(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-','01')),'-','') else salesconfirm.enddate end as mtd_end_date
    from 
      (select customer_id,
            min(startdate) as startdate,
            max(enddate) as enddate,
            sum(allresource) as allresource,
            sum(total_cnt) as total_cnt,
            sum(used_cnt) as used_cnt,
            sum(total_cv_cnt) as total_cv_cnt,
            sum(used_cv_cnt) as used_cv_cnt           
        from (
          select
            salesconfirm0.customer_id,
            min(salesconfirm0.startdate) as startdate,
            max(salesconfirm0.enddate) as enddate,
            sum(salesconfirm0.total_cnt) + sum(salesconfirm0.coupon_cnt) as allresource,
            sum(salesconfirm0.total_cnt) as total_cnt,
            sum(salesconfirm0.used_cnt) as used_cnt,
            sum(salesconfirm0.total_cv_cnt) as total_cv_cnt,
            sum(salesconfirm0.used_cv_cnt) as used_cv_cnt
          from 
            (select 
              cfs.comp_id as ecomp_id,
              cc.customer_id as customer_id,
              case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end as ht_id,
              min(cfsr.resource_start_time) as startdate,
              max(cfsr.resource_timeout_time) as enddate,
              sum(case when cfsr.resource_kind = 2 then cfsr.used_cnt end) as used_cv_cnt,
              sum(case when cfsr.resource_kind = 2 then cfsr.total_cnt end) as total_cv_cnt,
              sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*5 + (nvl(case when cfsr.resource_kind = 9 then cfsr.used_cnt end,0) )*5) as used_cnt,
              sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*5 + (nvl(case when cfsr.resource_kind = 9 then cfsr.total_cnt end,0) )*5) as total_cnt,
              sum(case when cfsr.resource_kind = 2 then ccl.download_coupon_cnt + ccl.interview_coupon_cnt*50 else 0 end) as coupon_cnt     
            from crm_finance_saleconfirm cfs
              join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id and cfsr.deleteflag = 0
              join crm_contract cc on cfs.business_id = cc.id and cc.deleteflag = 0
              join crm_contract_lpt ccl on ccl.contract_id = cc.id and ccl.deleteflag = 0
              join dw_erp_d_customer_base cus on cc.customer_id = cus.id and cus.p_date = '$date$'
            where cfs.business_kind in (0,4) and ccl.is_junior_contract = 0 
              and cus.rsc_valid_status = 1
              and cus.rps_service_version = 1
              and cfs.deleteflag = 0
            group by cfs.comp_id ,cc.customer_id,
            case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end
            ) salesconfirm0
          where salesconfirm0.total_cnt + salesconfirm0.coupon_cnt > 0
            and salesconfirm0.enddate >= salesconfirm0.startdate
            and salesconfirm0.startdate <= '$date$'
            and salesconfirm0.startdate >=20150115 --销售确认上线时间，此前数据不处理
            and salesconfirm0.enddate >= '$date$'
            and salesconfirm0.total_cnt > salesconfirm0.used_cnt
          group by salesconfirm0.customer_id
          union all 
          select 
            cus.id as customer_id,
            min(cfsr.resource_start_time) as startdate,
            max(cfsr.resource_timeout_time) as enddate,
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*5 + (nvl(case when cfsr.resource_kind = 9 then cfsr.total_cnt end,0) )*5) as allresource,
           sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*5 + (nvl(case when cfsr.resource_kind = 9 then cfsr.total_cnt end,0) )*5) as total_cnt,
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*5 + (nvl(case when cfsr.resource_kind = 9 then cfsr.used_cnt end,0) )*5) as used_cnt,            
            sum(case when cfsr.resource_kind = 2 then cfsr.total_cnt end) as total_cv_cnt,              
            sum(case when cfsr.resource_kind = 2 then cfsr.used_cnt end) as used_cv_cnt   
          from crm_finance_saleconfirm cfs
          join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id and cfsr.deleteflag = 0
          join dw_erp_d_customer_base cus on cfs.comp_id  = cus.ecomp_id and cus.p_date = '$date$'
          where cfs.business_kind = 5
            and cus.rsc_valid_status = 1
            and cus.rps_service_version =1
              and cfsr.resource_timeout_time >= cfsr.resource_start_time
              and cfsr.resource_start_time <= '$date$'
              and cfsr.resource_start_time >=20150115
              and cfsr.resource_timeout_time >= '$date$'
              and cfs.deleteflag = 0
          group by cus.id
        ) fd group by customer_id
      ) salesconfirm
      join dim_date_holiday holiday on 1=1
      where salesconfirm.allresource > 0
        and salesconfirm.total_cnt > salesconfirm.used_cnt
        and holiday.d_date >= salesconfirm.startdate
        and holiday.d_date <= salesconfirm.enddate
    ) salesconfirm2
  join dw_erp_d_customer_base cus on salesconfirm2.customer_id = cus.id and cus.p_date = '$date$'
  where rn = 1
;

--11月消耗顾问粒度 -月累计bug
select	suser.id,
		suser.name,
		suser.position_name,
		suser.org_name,
		suser_act.consume_cv_total_cnt,
		suser_act.mtd_consume_cv_target_cnt,
		suser_act.consume_cv_total_cnt / (suser_act.mtd_consume_cv_target_cnt+suser_act.tm_left_day_consume_cv_target_cnt)
   from (
		    select 
				base.serviceuser_id,
				sum(act.consume_cv_total_cnt+nvl(act.exchange_cv2lowcv,0)) as consume_cv_total_cnt,
				sum((case when target.left_cnt > 0 then target.day_consume_cv_target_cnt else 0 end) * holiday.is_workday) as mtd_consume_cv_target_cnt,
				sum(case when base.p_date = '$date$' then target.tm_left_day_consume_cv_target_cnt else 0 end) as tm_left_day_consume_cv_target_cnt
			from dw_erp_d_customer_base base 
			left join dw_erp_d_customer_consume_target target 
			on base.id = target.customer_id
			and target.p_date = 20170131
			left join dw_erp_d_customer_act act 
			on base.id = act.customer_id
			and base.p_date = act.p_date
			join dim_date_holiday holiday on base.p_date = holiday.d_date
			where base.p_date between  20170101 and 20170131
			and base.rps_service_version = 1
			and base.rsc_valid_status = 1 
			group by base.serviceuser_id
   ) suser_act
  	join dw_erp_d_salesuser_base suser
	on suser_act.serviceuser_id = suser.id 
	and suser.p_date = 20170131


--12月消耗客户粒度 -月累计bug

select 
	base.name,base.serviceuser_name,suser.position_name,base.service_teamorg_name,
	sum(act.consume_cv_total_cnt+nvl(act.exchange_cv2lowcv,0)) as consume_cv_total_cnt,
	sum((case when target.left_cnt > 0 then target.day_consume_cv_target_cnt else 0 end) * holiday.is_workday) as mtd_consume_cv_target_cnt,
	sum(act.consume_cv_total_cnt+nvl(act.exchange_cv2lowcv,0)) / sum((case when target.left_cnt > 0 then target.day_consume_cv_target_cnt else 0 end) * holiday.is_workday) as ff,
  target.allresource,
  target.left_cnt,
  target.startdate,
  target.enddate,
  target.workdays,
  target.day_consume_cv_target_cnt
from dw_erp_d_customer_base base 
left join dw_erp_d_customer_consume_target target 
on base.id = target.customer_id
and target.p_date = 20170228
left join dw_erp_d_customer_act act 
on base.id = act.customer_id
and base.p_date = act.p_date
join dim_date_holiday holiday on base.p_date = holiday.d_date
join dw_erp_d_salesuser_base suser
on base.serviceuser_id = suser.id 
and suser.p_date = 20170228
where base.p_date between  20170201 and 20170228
and base.rps_service_version = 1
and base.rsc_valid_status = 1
group by base.name,base.serviceuser_name,suser.position_name,base.service_teamorg_name,
target.allresource,
target.left_cnt,
target.startdate,
target.enddate,
target.workdays,
target.day_consume_cv_target_cnt


select 
      cust_target.name,
      cust_target.sales_user_name,
      cust_target.sales_org_name,
      cust_target.sales_branch_name,
      cust_target.consume_cv_total_cnt,
      cust_target.mtd_consume_cv_target_cnt,
      cust_target.consume_ratio,
      cust_target.allresource,
      cust_target.left_cnt,
      cust_target.startdate,
      cust_target.enddate,
      cust_target.workdays,
      cust_target.day_consume_cv_target_cnt
from (
    select 
            base.name,base.id,
            base.sales_user_name,
            base.sales_org_name,
            base.sales_branch_name,
            sum(act.consume_cv_total_cnt+nvl(act.exchange_cv2lowcv,0)) as consume_cv_total_cnt,
            sum((case when target.left_cnt > 0 then target.day_consume_cv_target_cnt else 0 end) * holiday.is_workday) as mtd_consume_cv_target_cnt,
            sum(act.consume_cv_total_cnt+nvl(act.exchange_cv2lowcv,0)) / sum((case when target.left_cnt > 0 then target.day_consume_cv_target_cnt else 0 end) * holiday.is_workday) as consume_ratio,
            target.allresource,
            target.left_cnt,
            target.startdate,
            target.enddate,
            target.workdays,
            target.day_consume_cv_target_cnt
    from dw_erp_d_customer_base base 
    left join dw_erp_d_customer_consume_target target 
    on base.id = target.customer_id
    and target.p_date = 20170228
    left join dw_erp_d_customer_act act 
    on base.id = act.customer_id
    and base.p_date = act.p_date
    join dim_date_holiday holiday on base.p_date = holiday.d_date
    join dw_erp_d_salesuser_base suser
    on base.serviceuser_id = suser.id 
    and suser.p_date = 20170228
    where base.p_date between  20170201 and 20170228
    and base.rps_service_version = 1
    and base.rsc_valid_status = 1
    and base.sales_branch_name in ('北京','天津','青岛','大连','郑州')
    group by base.name,base.id,
              base.sales_user_name,
              base.sales_org_name,
              base.sales_branch_name,
              target.allresource,
              target.left_cnt,
              target.startdate,
              target.enddate,
              target.workdays,
              target.day_consume_cv_target_cnt
) cust_target 
join (
  select customer_id
    from dw_erp_d_contract_base 
   where p_date = 20170305 
     and (case when type in (10,11) and status in (1,2,3) then 1 
          when type not in (10,11) and status in (2,3) then 1 
          else 0
          end) = 1
     and substr(lpt_service_expired_date,1,7) in ('2017-03','2017-04','2017-05','2017-06')
    group by customer_id
) contract 
on cust_target.id = contract.customer_id


create table dw_erp_d_customer_consume_target
(
d_date int comment '分析日期',
customer_id int comment '客户id',
customer_name string comment '客户名称',
serviceuser_id int comment '招服id',
serviceuser_name string comment '招服姓名',
allresource int comment '总资源数',
left_cnt int comment '剩余资源数',
startdate int comment '资源有效开始时间',
enddate int comment '资源有效结束时间',
workdays int comment '工作日服务天数',
day_consume_cv_target_cnt float comment '日消耗目标值',
tm_day_consume_cv_target_cnt float comment '当月日消耗目标值',
creation_timestamp timestamp comment '时间戳')
comment '客户资源消耗日目标值'
partitioned by ( p_date int);

alter table dw_erp_d_customer_consume_target add columns(
all_cv_cnt int comment '总精英简历资源数',
left_cv_cnt int comment '剩余精英简历资源数') cascade;

alter table dw_erp_d_customer_consume_target change left_cv_cnt used_cv_cnt int comment '已消耗精英简历资源数' cascade;



insert overwrite table dw_erp_d_customer_consume_target partition (p_date = $date$)
select 
  $date$ as d_date,
  salesconfirm2.customer_id,
  cus.name as customer_name,
  cus.serviceuser_id,
  cus.serviceuser_name,
  salesconfirm2.allresource,
  salesconfirm2.total_cnt - salesconfirm2.used_cnt as left_cnt,
  salesconfirm2.startdate,
  salesconfirm2.enddate,
  salesconfirm2.workdays, 
  salesconfirm2.allresource / salesconfirm2.workdays as day_consume_cv_target_cnt,
  (salesconfirm2.allresource / salesconfirm2.workdays) * (work_hour_diff(mtd_start_date,mtd_end_date)/24+1)  as tm_day_consume_cv_target_cnt,
  from_unixtime(unix_timestamp()) as creation_timestamp,
  salesconfirm2.all_cv_cnt ,
  salesconfirm2.used_cv_cnt 
  from (
    select
      salesconfirm.customer_id,
      salesconfirm.startdate,
      salesconfirm.enddate,
      salesconfirm.allresource,
      sum(holiday.is_workday)over(partition by salesconfirm.customer_id) as workdays,
      row_number()over(distribute by salesconfirm.customer_id sort by salesconfirm.startdate) as rn,
      salesconfirm.total_cnt as total_cnt,
      salesconfirm.used_cnt as used_cnt,
      salesconfirm.total_cv_cnt as all_cv_cnt,
      salesconfirm.used_cv_cnt as used_cv_cnt,
      case when salesconfirm.startdate <  concat(substr('$date$',1,6),'-','01') then concat(substr('$date$',1,6),'-','01') else salesconfirm.startdate end as mtd_start_date,
      case when salesconfirm.enddate > regexp_replace(last_day(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-','01')),'-','') then regexp_replace(last_day(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-','01')),'-','') else salesconfirm.enddate end as mtd_end_date
    from 
      (select customer_id,
            min(startdate) as startdate,
            max(enddate) as enddate,
            sum(allresource) as allresource,
            sum(total_cnt) as total_cnt,
            sum(used_cnt) as used_cnt,
            sum(used_cv_cnt) as used_cv_cnt,
            sum(total_cv_cnt) as total_cv_cnt           
        from (
          select
            salesconfirm0.customer_id,
            min(salesconfirm0.startdate) as startdate,
            max(salesconfirm0.enddate) as enddate,
            sum(salesconfirm0.total_cnt) + sum(salesconfirm0.coupon_cnt) as allresource,
            sum(salesconfirm0.total_cnt) as total_cnt,
            sum(salesconfirm0.used_cnt) as used_cnt,
            sum(salesconfirm0.used_cv_cnt) as used_cv_cnt,
            sum(salesconfirm0.total_cv_cnt) as total_cv_cnt
          from 
            (select 
              cfs.comp_id as ecomp_id,
              cc.customer_id as customer_id,
              case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end as ht_id,
              min(cfsr.resource_start_time) as startdate,
              max(cfsr.resource_timeout_time) as enddate,
              sum(case when cfsr.resource_kind = 2 then cfsr.used_cnt end) as used_cv_cnt,
              sum(case when cfsr.resource_kind = 2 then cfsr.total_cnt end) as total_cv_cnt,
              sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*50 ) as used_cnt,
              sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as total_cnt,
              sum(case when cfsr.resource_kind = 2 then ccl.download_coupon_cnt + ccl.interview_coupon_cnt*50 else 0 end) as coupon_cnt     
            from crm_finance_saleconfirm cfs
              join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id
              join crm_contract cc on cfs.business_id = cc.id
              join crm_contract_lpt ccl on ccl.contract_id = cc.id
              join dw_erp_d_customer_base cus on cc.customer_id = cus.id and cus.p_date = '$date$'
            where cfs.business_kind in (0,4) and ccl.is_junior_contract = 0 
              and cus.rsc_valid_status = 1
              and cus.rps_service_version in (1,3)
            group by cfs.comp_id ,cc.customer_id,
            case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end
            ) salesconfirm0
          where salesconfirm0.total_cnt + salesconfirm0.coupon_cnt > 0
            and salesconfirm0.enddate >= salesconfirm0.startdate
            and salesconfirm0.startdate <= regexp_replace(last_day(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-','01')),'-','')
            and salesconfirm0.startdate >=20150115
            and salesconfirm0.enddate >= concat(substr('$date$',1,6),'-','01')
          group by salesconfirm0.customer_id
          union all 
          select 
            cus.id as customer_id,
            min(cfsr.resource_start_time) as startdate,
            max(cfsr.resource_timeout_time) as enddate,
            sum(case when cfsr.resource_kind = 2 then cfsr.used_cnt end) as used_cv_cnt,
            sum(case when cfsr.resource_kind = 2 then cfsr.total_cnt end) as total_cv_cnt,            
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as allresource,
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*50 ) as used_cnt,
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as total_cnt
          from crm_finance_saleconfirm cfs
          join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id
          join dw_erp_d_customer_base cus on cfs.comp_id  = cus.ecomp_id and cus.p_date = '$date$'
          where cfs.business_kind = 5
            and cus.rsc_valid_status = 1
            and cus.rps_service_version in (1,3)
              and cfsr.resource_timeout_time >= cfsr.resource_start_time
              and cfsr.resource_start_time <= regexp_replace(last_day(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-','01')),'-','')
              and cfsr.resource_start_time >=20150115
              and cfsr.resource_timeout_time >= concat(substr('$date$',1,6),'-','01')
          group by cus.id
        ) fd group by customer_id
      ) salesconfirm
      join dim_date_holiday holiday on 1=1
      where salesconfirm.allresource > 0
        and salesconfirm.total_cnt > salesconfirm.used_cnt
        and holiday.d_date >= salesconfirm.startdate
        and holiday.d_date <= salesconfirm.enddate
    ) salesconfirm2
  join dw_erp_d_customer_base cus on salesconfirm2.customer_id = cus.id and cus.p_date = '$date$'
  where rn = 1


--11月消耗顾问粒度 -月累计bug
select	suser.id,
		suser.name,
		suser.position_name,
		suser.org_name,
		suser_act.consume_cv_total_cnt,
		suser_act.mtd_consume_cv_target_cnt,
		suser_act.consume_cv_total_cnt / suser_act.mtd_consume_cv_target_cnt
   from (
		    select 
				base.serviceuser_id,
				sum(act.consume_cv_total_cnt) as consume_cv_total_cnt,
				sum((case when target.left_cnt > 0 then target.day_consume_cv_target_cnt else 0 end) * holiday.is_workday) as mtd_consume_cv_target_cnt
			from 
			dw_erp_d_customer_base base 
			left join dw_erp_d_customer_consume_target target 
			on base.id = target.customer_id
			and base.p_date = target.p_date
			left join dw_erp_d_customer_act act 
			on base.id = act.customer_id
			and base.p_date = act.p_date
			join dim_date_holiday holiday on base.p_date = holiday.d_date
			where base.p_date between  20161101 and 20161130
			and base.rps_service_version in (1,3)
			and base.rsc_valid_status = 1 
			group by base.serviceuser_id
   ) suser_act
  	join dw_erp_d_salesuser_base suser
	on suser_act.serviceuser_id = suser.id 
	and suser.p_date = 20161130


--12月消耗客户粒度 -月累计bug

select 
	base.name,base.serviceuser_name,suser.position_name,base.service_teamorg_name,
	sum(act.consume_cv_total_cnt) as consume_cv_total_cnt,
	sum((case when target.left_cnt > 0 then target.day_consume_cv_target_cnt else 0 end) * holiday.is_workday) as mtd_consume_cv_target_cnt,
	sum(act.consume_cv_total_cnt) / sum((case when target.left_cnt > 0 then target.day_consume_cv_target_cnt else 0 end) * holiday.is_workday)	
from dw_erp_d_customer_base base 
left join dw_erp_d_customer_consume_target target 
on base.id = target.customer_id
and base.p_date = target.p_date
left join dw_erp_d_customer_act act 
on base.id = act.customer_id
and base.p_date = act.p_date
join dim_date_holiday holiday on base.p_date = holiday.d_date
join dw_erp_d_salesuser_base suser
on base.serviceuser_id = suser.id 
and suser.p_date = 20161130
where base.p_date between  20161101 and 20161130
and base.rps_service_version in (1,3)
and base.rsc_valid_status = 1
group by base.name,base.serviceuser_name,suser.position_name,base.service_teamorg_name;



--old
select	suser.id,
		suser.name,
		suser.position_name,
		suser.org_name,
		suser_act.consume_cv_total_cnt,
		suser_act.mtd_consume_cv_target_cnt,
		suser_act.consume_cv_total_cnt / suser_act.mtd_consume_cv_target_cnt
   from (
		    select cust_act.serviceuser_id,
		    	   sum(cust_act.consume_cv_total_cnt) as consume_cv_total_cnt,
		    	   sum(target_consume.day_consume_cv_target_cnt*holiday.is_workday) as mtd_consume_cv_target_cnt
		    from  dw_erp_d_customer_consume_target target_consume
			join 
			(   select act.customer_id,base.serviceuser_id,act.consume_cv_total_cnt,act.p_date
				  from dw_erp_d_customer_act act 
				  join dw_erp_d_customer_base base 
				  on act.customer_id = base.id 
				  and act.p_date = base.p_date
				  and base.rsc_valid_status = 1
				 where act.p_date = 20161208
			) cust_act 
			on target_consume.customer_id = cust_act.customer_id
			join dim_date_holiday holiday on cust_act.p_date = holiday.d_date
			where target_consume.left_cnt > 0
			and target_consume.p_date = 20161208
			group by cust_act.serviceuser_id
   ) suser_act
  	join dw_erp_d_salesuser_base suser
	on suser_act.serviceuser_id = suser.id 
	and suser.p_date = 20161208

--12月消耗客户粒度 -新表替换
  select cust_act.customer_name,
    		cust_act.serviceuser_name,
    		suser.position_name,
    		cust_act.service_teamorg_name,
    	   sum(cust_act.consume_cv_total_cnt) as consume_cv_total_cnt,
    	   sum(target_consume.day_consume_cv_target_cnt*holiday.is_workday) as mtd_consume_cv_target_cnt,
    	   sum(cust_act.consume_cv_total_cnt) / sum(target_consume.day_consume_cv_target_cnt*holiday.is_workday)
   from (select customer_id,day_consume_cv_target_cnt
      	      from dw_erp_d_customer_consume_target 
      	      where left_cnt > 0
			    and p_date = 20161208
      	   ) target_consume   
	join 
	(   select act.customer_id,act.consume_cv_total_cnt,act.p_date,
			   base.serviceuser_id,
			   base.serviceuser_name,
			   base.service_teamorg_name,
			   base.name as customer_name
		  from dw_erp_d_customer_act act 
		  join dw_erp_d_customer_base base 
		  on act.customer_id = base.id 
		  and act.p_date = base.p_date
		  and base.rsc_valid_status = 1
		 where act.p_date = 20161208) cust_act 
	on target_consume.customer_id = cust_act.customer_id
	join dim_date_holiday holiday on cust_act.p_date = holiday.d_date
	join dw_erp_d_salesuser_base suser on cust_act.serviceuser_id = suser.id and suser.p_date = 20161208
	group by cust_act.customer_name,cust_act.serviceuser_name,suser.position_name,cust_act.service_teamorg_name

--12月消耗顾问粒度 -新表替换
select	suser.id,
		suser.name,
		suser.position_name,
		suser.org_name,
		suser_act.consume_cv_total_cnt,
		suser_act.mtd_consume_cv_target_cnt,
		suser_act.consume_cv_total_cnt / suser_act.mtd_consume_cv_target_cnt
   from (
		    select cust_act.serviceuser_id,
		    	   sum(cust_act.consume_cv_total_cnt) as consume_cv_total_cnt,
		    	   sum(target_consume.day_consume_cv_target_cnt*holiday.is_workday) as mtd_consume_cv_target_cnt
		    from  dw_erp_d_customer_consume_target target_consume
			join 
			(   select act.customer_id,base.serviceuser_id,act.consume_cv_total_cnt,act.p_date
				  from dw_erp_d_customer_act act 
				  join dw_erp_d_customer_base base 
				  on act.customer_id = base.id 
				  and act.p_date = base.p_date
				  and base.rsc_valid_status = 1
				 where act.p_date between 20161201 and 20161208
			) cust_act 
			on target_consume.customer_id = cust_act.customer_id
			join dim_date_holiday holiday on cust_act.p_date = holiday.d_date
			where target_consume.left_cnt > 0
			and target_consume.p_date = 20161208
			group by cust_act.serviceuser_id
   ) suser_act
  	join dw_erp_d_salesuser_base suser
	on suser_act.serviceuser_id = suser.id 
	and suser.p_date = 20161208

--12月消耗客户粒度 -新表替换
  select cust_act.customer_name,
    		cust_act.serviceuser_name,
    		suser.position_name,
    		cust_act.service_teamorg_name,
    	   sum(cust_act.consume_cv_total_cnt) as consume_cv_total_cnt,
    	   sum(target_consume.day_consume_cv_target_cnt*holiday.is_workday) as mtd_consume_cv_target_cnt,
    	   sum(cust_act.consume_cv_total_cnt) / sum(target_consume.day_consume_cv_target_cnt*holiday.is_workday)
   from (select customer_id,day_consume_cv_target_cnt
      	      from dw_erp_d_customer_consume_target 
      	      where left_cnt > 0
			    and p_date = 20161208
      	   ) target_consume   
	join 
	(   select act.customer_id,act.consume_cv_total_cnt,act.p_date,
			   base.serviceuser_id,
			   base.serviceuser_name,
			   base.service_teamorg_name,
			   base.name as customer_name
		  from dw_erp_d_customer_act act 
		  join dw_erp_d_customer_base base 
		  on act.customer_id = base.id 
		  and act.p_date = base.p_date
		  and base.rsc_valid_status = 1
		 where act.p_date between 20161201 and 20161208) cust_act 
	on target_consume.customer_id = cust_act.customer_id
	join dim_date_holiday holiday on cust_act.p_date = holiday.d_date
	join dw_erp_d_salesuser_base suser on cust_act.serviceuser_id = suser.id and suser.p_date = 20161208
	group by cust_act.customer_name,cust_act.serviceuser_name,suser.position_name,cust_act.service_teamorg_name

--11月消耗顾问粒度
select	suser.id,
			suser.name,
			suser.position_name,
			suser.org_name,
			suser_act.consume_cv_total_cnt,
			suser_act.mtd_consume_cv_target_cnt,
			suser_act.consume_cv_total_cnt / suser_act.mtd_consume_cv_target_cnt
   from (
    select cust_act.serviceuser_id,
    	   sum(cust_act.consume_cv_total_cnt) as consume_cv_total_cnt,
    	   sum(target_consume.day_consume_cv_target_cnt*holiday.is_workday) as mtd_consume_cv_target_cnt
      from 
	(
	select 
				salesconfirm2.customer_id,
				salesconfirm2.startdate,
				salesconfirm2.enddate,
				salesconfirm2.allresource,
				salesconfirm2.allresource / salesconfirm2.workdays as day_consume_cv_target_cnt,
				(salesconfirm2.allresource / salesconfirm2.workdays) * (work_hour_diff(mtd_start_date,mtd_end_date)/24)  as mtd_consume_cv_target_cnt
		from (
			select
				salesconfirm.customer_id,
				salesconfirm.startdate,
				salesconfirm.enddate,
				salesconfirm.allresource,
				sum(holiday.is_workday)over(partition by salesconfirm.customer_id) as workdays,
				row_number()over(distribute by salesconfirm.customer_id sort by salesconfirm.startdate) as rn,
				salesconfirm.total_cnt as total_cnt,
				salesconfirm.used_cnt as used_cnt,
				case when salesconfirm.startdate < concat(substr('20161208',1,4),'-',substr('20161208',5,2),'-','01') then concat(substr('20161208',1,4),'-',substr('20161208',5,2),'-','01') else salesconfirm.startdate end as mtd_start_date,
				case when salesconfirm.enddate > regexp_replace(last_day(concat(substr('20161208',1,4),'-',substr('20161208',5,2),'-','01')),'-','') then regexp_replace(last_day(concat(substr('20161208',1,4),'-',substr('20161208',5,2),'-','01')),'-','') else salesconfirm.enddate end as mtd_end_date

			from 
				(select
						salesconfirm0.customer_id,
						min(salesconfirm0.startdate) as startdate,
						max(salesconfirm0.enddate) as enddate,
						sum(salesconfirm0.total_cnt) + sum(salesconfirm0.coupon_cnt)  as allresource,
						sum(salesconfirm0.total_cnt) as total_cnt,
						sum(salesconfirm0.used_cnt) as used_cnt
					from 
						(select 
							cfs.comp_id as ecomp_id,
							cc.customer_id as customer_id,
							case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end as ht_id,
							min(cfsr.resource_start_time) as startdate,
							max(cfsr.resource_timeout_time) as enddate,
							sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*50 ) as used_cnt,
							sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as total_cnt,
							sum(case when cfsr.resource_kind = 2 then ccl.download_coupon_cnt + ccl.interview_coupon_cnt*50 else 0 end) as coupon_cnt			
						from crm_finance_saleconfirm cfs
							join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id
							join crm_contract cc on cfs.business_id = cc.id
							join crm_contract_lpt ccl on ccl.contract_id = cc.id
							join dw_erp_d_customer_base cus on cc.customer_id = cus.id and cus.p_date = '20161208'
						where cfs.business_kind in (0,4) and ccl.is_junior_contract = 0 
						  and cus.rsc_valid_status = 1
						group by cfs.comp_id ,cc.customer_id,
						case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end
						) salesconfirm0
					where salesconfirm0.coupon_cnt+ salesconfirm0.total_cnt> 0
					  and salesconfirm0.enddate >= salesconfirm0.startdate
					  and salesconfirm0.startdate <=20161231
					  and salesconfirm0.startdate >=20150115
					  and salesconfirm0.enddate >=20161201
					group by salesconfirm0.customer_id
				) salesconfirm
				join dim_date_holiday holiday on 1=1
				where salesconfirm.allresource > 0
				  and holiday.d_date >= salesconfirm.startdate
				  and holiday.d_date <= salesconfirm.enddate
			) salesconfirm2
		where rn = 1
		and total_cnt > used_cnt
		) target_consume
	join 
	(   select act.customer_id,base.serviceuser_id,act.consume_cv_total_cnt,act.p_date
		  from dw_erp_d_customer_act act 
		  join dw_erp_d_customer_base base 
		  on act.customer_id = base.id 
		  and act.p_date = base.p_date
		 where act.p_date between 20161201 and 20161208
		 ) cust_act 
	on target_consume.customer_id = cust_act.customer_id
	join dim_date_holiday holiday on cust_act.p_date = holiday.d_date
	group by cust_act.serviceuser_id
  ) suser_act
  	join dw_erp_d_salesuser_base suser
	on suser_act.serviceuser_id = suser.id 
	and suser.p_date = 20161208;

--11月消耗客户明细
    select cust_act.customer_name,rsc_valid_status,
    		cust_act.serviceuser_name,
    		suser.position_name,
    		cust_act.service_teamorg_name,
    	   sum(cust_act.consume_cv_total_cnt) as consume_cv_total_cnt,
    	   sum(target_consume.day_consume_cv_target_cnt*holiday.is_workday) as mtd_consume_cv_target_cnt,
    	   sum(cust_act.consume_cv_total_cnt) / sum(target_consume.day_consume_cv_target_cnt*holiday.is_workday)
      from 
	(
	select 
				salesconfirm2.customer_id,rsc_valid_status,
				salesconfirm2.startdate,
				salesconfirm2.enddate,
				salesconfirm2.allresource,
				salesconfirm2.allresource / salesconfirm2.workdays as day_consume_cv_target_cnt,
				(salesconfirm2.allresource / salesconfirm2.workdays) * (work_hour_diff(mtd_start_date,mtd_end_date)/24)  as mtd_consume_cv_target_cnt
		from (
			select
				salesconfirm.customer_id,
				salesconfirm.startdate,
				salesconfirm.enddate,
				salesconfirm.allresource,rsc_valid_status,
				sum(holiday.is_workday)over(partition by salesconfirm.customer_id) as workdays,
				row_number()over(distribute by salesconfirm.customer_id sort by salesconfirm.startdate) as rn,
				salesconfirm.total_cnt as total_cnt,
				salesconfirm.used_cnt as used_cnt,
				case when salesconfirm.startdate < concat(substr('20161208',1,4),'-',substr('20161208',5,2),'-','01') then concat(substr('20161208',1,4),'-',substr('20161208',5,2),'-','01') else salesconfirm.startdate end as mtd_start_date,
				case when salesconfirm.enddate > regexp_replace(last_day(concat(substr('20161208',1,4),'-',substr('20161208',5,2),'-','01')),'-','') then regexp_replace(last_day(concat(substr('20161208',1,4),'-',substr('20161208',5,2),'-','01')),'-','') else salesconfirm.enddate end as mtd_end_date
			from 
				(select
						salesconfirm0.customer_id,rsc_valid_status,
						min(salesconfirm0.startdate) as startdate,
						max(salesconfirm0.enddate) as enddate,
						sum(salesconfirm0.total_cnt) + sum(salesconfirm0.coupon_cnt)  as allresource,
						sum(salesconfirm0.total_cnt) as total_cnt,
						sum(salesconfirm0.used_cnt) as used_cnt
					from 
						(select 
							cfs.comp_id as ecomp_id,
							cc.customer_id as customer_id,rsc_valid_status,
							case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end as ht_id,
							min(cfsr.resource_start_time) as startdate,
							max(cfsr.resource_timeout_time) as enddate,
						sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*50 ) as used_cnt,
						sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as total_cnt,
						sum(case when cfsr.resource_kind = 2 then ccl.download_coupon_cnt + ccl.interview_coupon_cnt*50 else 0 end) as coupon_cnt		
						from crm_finance_saleconfirm cfs
							join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id
							join crm_contract cc on cfs.business_id = cc.id
							join crm_contract_lpt ccl on ccl.contract_id = cc.id
							join dw_erp_d_customer_base cus on cc.customer_id = cus.id and cus.p_date = '20161208'
						where cfs.business_kind = 0 and ccl.is_junior_contract = 0 
						group by cfs.comp_id ,cc.customer_id,
						case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end,rsc_valid_status
						) salesconfirm0
					where salesconfirm0.coupon_cnt+ salesconfirm0.total_cnt> 0
					  and salesconfirm0.enddate >= salesconfirm0.startdate
					  and salesconfirm0.startdate <=20161231
					  and salesconfirm0.startdate >=20150115
					  and salesconfirm0.enddate >=20161201
					group by salesconfirm0.customer_id,rsc_valid_status
				) salesconfirm
				join dim_date_holiday holiday on 1=1
				where salesconfirm.allresource > 0
				  and salesconfirm.total_cnt > salesconfirm.used_cnt
				  and holiday.d_date >= salesconfirm.startdate
				  and holiday.d_date <= salesconfirm.enddate
			) salesconfirm2
		where rn = 1
		and total_cnt > used_cnt
		) target_consume
	join 
	(   select act.customer_id,act.consume_cv_total_cnt,act.p_date,
			   base.serviceuser_id,
			   base.serviceuser_name,
			   base.service_teamorg_name,
			   base.name as customer_name
		  from dw_erp_d_customer_act act 
		  join dw_erp_d_customer_base base 
		  on act.customer_id = base.id 
		  and act.p_date = base.p_date
		 where act.p_date between 20161201 and 20161208
		   and base.rsc_valid_status = 1) cust_act 
	on target_consume.customer_id = cust_act.customer_id
	join dim_date_holiday holiday on cust_act.p_date = holiday.d_date
	join dw_erp_d_salesuser_base suser on cust_act.serviceuser_id = suser.id and suser.p_date = 20161208
	group by cust_act.customer_name,rsc_valid_status,cust_act.serviceuser_name,suser.position_name,cust_act.service_teamorg_name



 --12月客户目标消耗
	select base.name,
			base.rps_service_version,
			base.serviceuser_id,
			base.serviceuser_name,
			suser.position_name,
			base.service_teamorg_name,
			target_consume.startdate,
			target_consume.enddate,
			target_consume.allresource,
			target_consume.day_consume_cv_target_cnt,
			target_consume.mtd_consume_cv_target_cnt
	from (
	select 
				salesconfirm2.customer_id,
				salesconfirm2.startdate,
				salesconfirm2.enddate,
				salesconfirm2.allresource,
				salesconfirm2.allresource / salesconfirm2.workdays as day_consume_cv_target_cnt,
				(salesconfirm2.allresource / salesconfirm2.workdays) * (work_hour_diff(mtd_start_date,'20161231')/24)  as mtd_consume_cv_target_cnt
		from (
			select
				salesconfirm.customer_id,
				salesconfirm.startdate,
				salesconfirm.enddate,
				salesconfirm.allresource,
				sum(holiday.is_workday)over(partition by salesconfirm.customer_id) as workdays,
				row_number()over(distribute by salesconfirm.customer_id sort by salesconfirm.startdate) as rn,
				salesconfirm.total_cnt as total_cnt,
				salesconfirm.used_cnt as used_cnt,
				case when salesconfirm.startdate < '20161201' then '20161201' else salesconfirm.startdate end as mtd_start_date
			from 
				(select
						salesconfirm0.customer_id,
						min(salesconfirm0.startdate) as startdate,
						max(salesconfirm0.enddate) as enddate,
						sum(salesconfirm0.allresource) as allresource,
						sum(salesconfirm0.total_cnt) as total_cnt,
						sum(salesconfirm0.used_cnt) as used_cnt
					from 
						(select 
							cfs.comp_id as ecomp_id,
							cc.customer_id as customer_id,
							case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end as ht_id,
							min(cfsr.resource_start_time) as startdate,
							max(cfsr.resource_timeout_time) as enddate,
							sum(cfsr.total_cnt) as total_cnt,
							sum(cfsr.used_cnt) as used_cnt,
							sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 + nvl(ccl.download_coupon_cnt,0)+nvl(ccl.interview_coupon_cnt,0)*50) as allresource
						from crm_finance_saleconfirm cfs
							join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id
							join crm_contract cc on cfs.business_id = cc.id
							join crm_contract_lpt ccl on ccl.contract_id = cc.id
							join dw_erp_d_customer_base cus on cc.customer_id = cus.id and cus.p_date = '20161130'
						where cfs.business_kind = 0 and ccl.is_junior_contract = 0 
						  and cus.ecomp_version = 2 
						  and cus.rsc_valid_status = 1
						group by cfs.comp_id ,cc.customer_id,
						case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end
						) salesconfirm0
					where salesconfirm0.allresource > 0
					  and salesconfirm0.enddate >= salesconfirm0.startdate
					  and salesconfirm0.startdate <=20161201
					  and salesconfirm0.startdate >=20150115
					  and salesconfirm0.enddate >=20161231
					group by salesconfirm0.customer_id
				) salesconfirm
				join dim_date_holiday holiday on 1=1
				where salesconfirm.allresource > 0
				  and salesconfirm.total_cnt > salesconfirm.used_cnt
				  and holiday.d_date >= salesconfirm.startdate
				  and holiday.d_date <= salesconfirm.enddate
			) salesconfirm2
		where rn = 1
		and total_cnt > used_cnt
		) target_consume
	join dw_erp_d_customer_base base
	on target_consume.customer_id = base.id 
	and base.p_date = 20161130
	join dw_erp_d_salesuser_base suser
	on base.serviceuser_id = suser.id 
	and suser.p_date = 20161130;

select 
		cfs.comp_id as ecomp_id,
		cc.customer_id as customer_id,
		cus.name as customer_name,
		cfs.business_id,
		cc.relation_contract_id,
		cc.contract_no,
		case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end as ht_id,		
		cfsr.resource_start_time as startdate,
		cfsr.resource_timeout_time as enddate,
		cfsr.resource_kind,
		cfsr.total_cnt as total_cnt,
		cfsr.used_cnt as used_cnt,
		nvl(ccl.download_coupon_cnt,0)+nvl(ccl.interview_coupon_cnt,0)*50
		from crm_finance_saleconfirm cfs
		join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id
		join crm_contract cc on cfs.business_id = cc.id
		join crm_contract_lpt ccl on ccl.contract_id = cc.id
		join dw_erp_d_customer_base cus on cc.customer_id = cus.id and cus.p_date = '20161208'
	where cfs.business_kind in (0,4) and ccl.is_junior_contract = 0 
	 -- and cus.ecomp_version = 2 
	  and cus.name in ('上海蔚来汽车有限公司')

	select 
		cfs.comp_id as ecomp_id,
		cc.customer_id as customer_id,
		cus.name as customer_name,
		cfs.business_id,
		cc.relation_contract_id,
		cc.contract_no,
		case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end as ht_id,		
		cfsr.resource_start_time as startdate,
		cfsr.resource_timeout_time as enddate,
		cfsr.resource_kind,
		cfsr.total_cnt as total_cnt,
		cfsr.used_cnt as used_cnt,
		nvl(ccl.download_coupon_cnt,0)+nvl(ccl.interview_coupon_cnt,0)*50
		from crm_finance_saleconfirm cfs
		join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id
		join crm_contract cc on cfs.business_id = cc.id
		join crm_contract_lpt ccl on ccl.contract_id = cc.id
		join dw_erp_d_customer_base cus on cc.customer_id = cus.id and cus.p_date = '20161208'
	where cfs.business_kind in (0,4) and ccl.is_junior_contract = 0 
	 -- and cus.ecomp_version = 2 
	  and cus.name in ('上海腾瑞制药有限公司')


	  select 
		cfs.comp_id as ecomp_id,
		cc.customer_id as customer_id,
		cus.name,
		rsc_valid_status,
		case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end as ht_id,
		min(cfsr.resource_start_time) as startdate,
		max(cfsr.resource_timeout_time) as enddate,
	sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*50 ) as used_cnt,
	sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as total_cnt,
	sum(case when cfsr.resource_kind = 2 then ccl.download_coupon_cnt + ccl.interview_coupon_cnt*50 else 0 end) as coupon_cnt		
	from crm_finance_saleconfirm cfs
		join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id
		join crm_contract cc on cfs.business_id = cc.id
		join crm_contract_lpt ccl on ccl.contract_id = cc.id
		join dw_erp_d_customer_base cus on cc.customer_id = cus.id and cus.p_date = '20161130'
	where cfs.business_kind = 0 and ccl.is_junior_contract = 0 
	and cus.name in ('上海一起作业信息科技有限公司',
'上海万丰文化传播有限公司',
'上海三银投资管理有限公司',
'上海东伽文化传播有限公司',
'上海东伽文化传播有限公司',
'上海东正汽车金融有限责任公司',
'上海东正汽车金融有限责任公司',
'上海乐挚信息科技有限公司',
'上海互加文化传播有限公司',
'上海优刻得信息科技有限公司',
'上海佑隆生物科技有限公司',
'上海倍通医药科技咨询有限公司',
'上海凯诘电子商务股份有限公司',
'上海分尚网络科技有限公司',
'上海利得财富资产管理有限公司',
'上海卓领通讯技术有限公司',
'上海同豪土木工程咨询有限公司',
'上海唐木商务咨询有限公司',
'上海国富光启云计算科技股份有限公司',
'上海埃林哲软件系统股份有限公司',
'上海复兆信息技术有限公司',
'上海天律信息技术有限公司',
'上海奥多信息科技有限公司',
'上海安硕信息技术股份有限公司',
'上海小蚁科技有限公司',
'上海居尚工贸有限公司',
'上海广茂达光艺科技股份有限公司')
	group by cfs.comp_id ,cc.customer_id,cus.name,
	case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end,rsc_valid_status


	group by cfs.comp_id ,cc.customer_id,
	case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end
	) salesconfirm0


2105374	101757	70596	0	201412161823272633-00	70596	20150104	20170103	0	0	
2105374	101757	70596	0	201412161823272633-00	70596	20150104	20170103	1000	440	
2105374	101757	70596	0	201412161823272633-00	70596	20150104	20170103	220	0	
2105374	101757	160733	0	LPT20160224022332010466-00	160733	20160224	20160524	0	0	
2105374	101757	160733	0	LPT20160224022332010466-00	160733	20160224	20160524	50	50	
2105374	101757	2433	0	20120504021ZHF-00	2433	20120518	20170103	600	600	
2105374	101757	2433	0	20120504021ZHF-00	2433	20120518	20170103	0	0	
2105374	101757	2433	0	20120504021ZHF-00	2433	20120518	20170103	80	80	
2105374	101757	2433	0	20120504021ZHF-00	2433	20120518	20170103	50	50	
2105374	101757	160733	0	LPT20160224022332010466-00	160733	20160224	20160524	0	0	
2105374	101757	160733	0	LPT20160224022332010466-00	160733	20160224	20160524	0	0	
2105374	101757	70596	0	201412161823272633-00	70596	20150104	20170103	100	16	



'上海一起作业信息科技有限公司',
'上海万丰文化传播有限公司',
'上海三银投资管理有限公司',
'上海东伽文化传播有限公司',
'上海东伽文化传播有限公司',
'上海东正汽车金融有限责任公司',
'上海东正汽车金融有限责任公司',
'上海乐挚信息科技有限公司',
'上海互加文化传播有限公司',
'上海优刻得信息科技有限公司',
'上海佑隆生物科技有限公司',
'上海倍通医药科技咨询有限公司',
'上海凯诘电子商务股份有限公司',
'上海分尚网络科技有限公司',
'上海利得财富资产管理有限公司',
'上海卓领通讯技术有限公司',
'上海同豪土木工程咨询有限公司',
'上海唐木商务咨询有限公司',
'上海国富光启云计算科技股份有限公司',
'上海埃林哲软件系统股份有限公司',
'上海复兆信息技术有限公司',
'上海天律信息技术有限公司',
'上海奥多信息科技有限公司',
'上海安硕信息技术股份有限公司',
'上海小蚁科技有限公司',
'上海居尚工贸有限公司',
'上海广茂达光艺科技股份有限公司'

select 
	cfs.comp_id as ecomp_id,
	cc.customer_id as customer_id,
	case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end as ht_id,
	min(cfsr.resource_start_time) as startdate,
	max(cfsr.resource_timeout_time) as enddate,
	sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*50 ) as used_cnt,
	sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as total_cnt,
	sum(case when cfsr.resource_kind = 2 then ccl.download_coupon_cnt + ccl.interview_coupon_cnt*50 else 0 end)	as coupon_cnt			
from crm_finance_saleconfirm cfs
	join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id
	join crm_contract cc on cfs.business_id = cc.id
	join crm_contract_lpt ccl on ccl.contract_id = cc.id
	join dw_erp_d_customer_base cus on cc.customer_id = cus.id and cus.p_date = '20161209'
where cfs.business_kind in (0,4) and ccl.is_junior_contract = 0 
  and cus.rsc_valid_status = 1
group by cfs.comp_id ,cc.customer_id,case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end
having sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*50 ) as used_cnt,
 > 0;

 select *
 from dw_erp_d_customer_base base 		  
 where base.p_date between 20161201 and 20161208
 and base.name = '慧与(中国)有限公司'

 select 
              cfs.comp_id as ecomp_id,
              cc.customer_id as customer_id,
              case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end as ht_id,
              min(cfsr.resource_start_time) as startdate,
              max(cfsr.resource_timeout_time) as enddate,
              sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*50 ) as used_cnt,
              sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as total_cnt,
              sum(case when cfsr.resource_kind = 2 then ccl.download_coupon_cnt + ccl.interview_coupon_cnt*50 else 0 end) as coupon_cnt     
            from crm_finance_saleconfirm cfs
              join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id
              join crm_contract cc on cfs.business_id = cc.id
              join crm_contract_lpt ccl on ccl.contract_id = cc.id
              join dw_erp_d_customer_base cus on cc.customer_id = cus.id and cus.p_date = '20170309'
            where cfs.business_kind in (0,4) and ccl.is_junior_contract = 0 
              and cus.rsc_valid_status = 1
              and cus.rps_service_version in (1,3)
              -- and cus.name in ('广州博鳌纵横网络科技有限公司','上海葡萄纬度科技有限公司')
              and cus.id = 1871519
            group by cfs.comp_id ,cc.customer_id,
            case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end


select 
            cus.id as customer_id,
            min(cfsr.resource_start_time) as startdate,
            max(cfsr.resource_timeout_time) as enddate,
            sum(case when cfsr.resource_kind = 2 then cfsr.used_cnt end) as used_cv_cnt,
            sum(case when cfsr.resource_kind = 2 then cfsr.total_cnt end) as total_cv_cnt,            
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as allresource,
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*50 ) as used_cnt,
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as total_cnt
          from crm_finance_saleconfirm cfs
          join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id and cfsr.deleteflag = 0
          join dw_erp_d_customer_base cus on cfs.comp_id  = cus.ecomp_id and cus.p_date = '$date$'
          where cfs.business_kind = 5
            and cus.rsc_valid_status = 1
            and cus.rps_service_version =1
              and cfsr.resource_timeout_time >= cfsr.resource_start_time
              and cfsr.resource_start_time <= '$date$'
              and cfsr.resource_start_time >=20150115
              and cfsr.resource_timeout_time >= '$date$'
              and cfs.deleteflag = 0
              group by cus.id
              having cus.id = 1871519

select 
            cus.id as customer_id,
            min(cfsr.resource_start_time) as startdate,
            max(cfsr.resource_timeout_time) as enddate,
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as allresource,
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*50 ) as used_cnt,
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as total_cnt
          from crm_finance_saleconfirm cfs
          join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id
          join dw_erp_d_customer_base cus on cfs.comp_id  = cus.ecomp_id and cus.p_date = '20170301'
          where cfs.business_kind = 5
            and cus.rsc_valid_status = 1
            and cus.rps_service_version in (1,3)
              and cfsr.resource_timeout_time >= cfsr.resource_start_time
              and cfsr.resource_start_time <= regexp_replace(last_day(concat(substr('20170301',1,4),'-',substr('20170301',5,2),'-','01')),'-','')
              and cfsr.resource_start_time >=20150115
              and cfsr.resource_timeout_time >= concat(substr('20170301',1,4),'-',substr('20170301',5,2),'-','01')
           --   and cus.name = '上海华策医院管理有限公司'
              and cus.id = 1871519
          group by cus.id;

select 
            cus.id as customer_id,
            min(cfsr.resource_start_time) as startdate,
            max(cfsr.resource_timeout_time) as enddate,
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as allresource,
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*50 ) as used_cnt,
            sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as total_cnt
          from crm_finance_saleconfirm cfs
          join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id
          join dw_erp_d_customer_base cus on cfs.comp_id  = cus.ecomp_id and cus.p_date = '20170301'
          where cfs.business_kind = 5
            and cus.rsc_valid_status = 1
            and cus.rps_service_version in (1,3)
              and cfsr.resource_timeout_time >= cfsr.resource_start_time
              and cfsr.resource_start_time <= regexp_replace(last_day(concat(substr('20170301',1,4),'-',substr('20170301',5,2),'-','01')),'-','')
              and cfsr.resource_start_time >=20150115
              and cfsr.resource_timeout_time >= concat(substr('20170301',1,4),'-',substr('20170301',5,2),'-','01')
           --   and cus.name = '上海华策医院管理有限公司'
              and cus.id = 1871519
          group by cus.id;


select
            salesconfirm0.customer_id,
            min(salesconfirm0.startdate) as startdate,
            max(salesconfirm0.enddate) as enddate,
            sum(salesconfirm0.total_cnt) + sum(salesconfirm0.coupon_cnt) as allresource,
            sum(salesconfirm0.total_cnt) as total_cnt,
            sum(salesconfirm0.used_cnt) as used_cnt
          from 
            (select 
              cfs.comp_id as ecomp_id,
              cc.customer_id as customer_id,
              case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end as ht_id,
              min(cfsr.resource_start_time) as startdate,
              max(cfsr.resource_timeout_time) as enddate,
              sum((nvl(case when cfsr.resource_kind = 2 then cfsr.used_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.used_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.used_cnt end,0) )*50 ) as used_cnt,
              sum((nvl(case when cfsr.resource_kind = 2 then cfsr.total_cnt end,0 ))+(nvl(case when cfsr.resource_kind = 3 then cfsr.total_cnt end,0) )*2+(nvl(case when cfsr.resource_kind = 6 then cfsr.total_cnt end,0) )*50 ) as total_cnt,
              sum(case when cfsr.resource_kind = 2 then ccl.download_coupon_cnt + ccl.interview_coupon_cnt*50 else 0 end) as coupon_cnt     
            from crm_finance_saleconfirm cfs
              join crm_finance_saleconfirm_resource cfsr on cfs.id = cfsr.saleconfirm_id
              join crm_contract cc on cfs.business_id = cc.id
              join crm_contract_lpt ccl on ccl.contract_id = cc.id
              join dw_erp_d_customer_base cus on cc.customer_id = cus.id and cus.p_date = '20161201'
            where cfs.business_kind in (0,4) and ccl.is_junior_contract = 0 
              and cus.rsc_valid_status = 1
              and cus.rps_service_version in (1,3)
            group by cfs.comp_id ,cc.customer_id,
            case when cc.relation_contract_id = 0 then cfs.business_id else cc.relation_contract_id end
            ) salesconfirm0
          where salesconfirm0.total_cnt + salesconfirm0.coupon_cnt > 0
            and salesconfirm0.enddate >= salesconfirm0.startdate
            and salesconfirm0.startdate <= regexp_replace(last_day(concat(substr('20161201',1,4),'-',substr('20161201',5,2),'-','01')),'-','')
            and salesconfirm0.startdate >=20150115
            and salesconfirm0.enddate >= concat(substr('20161201',1,4),'-',substr('20161201',5,2),'-','01')
            and customer_id = 572818
          group by salesconfirm0.customer_id