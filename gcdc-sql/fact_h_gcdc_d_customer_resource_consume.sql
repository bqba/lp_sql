CREATE TABLE fact_h_gcdc_d_customer_resource_consume(
  d_date int COMMENT '统计日期', 
  customer_id int COMMENT '客户id', 
  customer_name string COMMENT '客户名称', 
  industry_code string COMMENT '客户所在行业', 
  industry_name string COMMENT '客名所在行业名称', 
  rps_id int COMMENT '招服id', 
  rps_name string COMMENT '招服姓名', 
  rps_org_id int COMMENT '招服团队id', 
  rps_org_name string COMMENT '招服团队名称', 
  rps_branch_id int COMMENT '招服所属城市', 
  rps_branch_name string COMMENT '招服所属城市名称', 
  sales_id int COMMENT '销售id', 
  sales_name string COMMENT '销售姓名', 
  sales_branch_id int COMMENT '销售所属城市', 
  sales_branch_name string COMMENT '销售所属城市名称', 
  cv_cnt int COMMENT '简历下载数', 
  exchangelowcv_cv_cnt int COMMENT '兑换白领简历消耗的精英简历下载数', 
  cvcoupon_cnt int COMMENT '简历下载券数', 
  intention_cnt int COMMENT '意向沟通数', 
  invitation_cnt int COMMENT '邀请应聘数', 
  mskcoupon_cnt int COMMENT '面试快券数', 
  jobrecommendcoupon_cnt int COMMENT '精准推送数', 
  intention_cv_cnt int COMMENT '意向沟通消耗简历数', 
  invitation_cv_cnt int COMMENT '邀请应聘消耗简历数', 
  ergency_cv_cnt int COMMENT '急聘消耗简历数', 
  msk_cv_cnt int COMMENT '面试快消耗简历数', 
  mskplus_cv_cnt int COMMENT '面试快+消耗简历数', 
  rzk_cv_cnt int COMMENT '入职快消耗简历数', 
  total int COMMENT '合计消耗资源数（折算成简历数）', 
  create_timestamp timestamp COMMENT '时间戳')
PARTITIONED BY (  p_date int) ;


alter table fact_h_gcdc_d_customer_resource_consume add columns (total_target_cnt int COMMENT '综合消耗目标数') cascade;
alter table fact_h_gcdc_d_customer_resource_consume add (total_target_cnt int COMMENT '综合消耗数') ;

alter table fact_h_gcdc_d_customer_resource_consume change total_target_cnt total_target_cnt float COMMENT '综合消耗目标数';

alter table fact_h_gcdc_d_customer_resource_consume add columns (rsc_valid_status int COMMENT '客户有效状态') cascade;
alter table fact_h_gcdc_d_customer_resource_consume add (rsc_valid_status int COMMENT '客户有效状态') ;

insert overwrite table fact_h_gcdc_d_customer_resource_consume partition (p_date = $date$)
select $date$ as d_date,
  nvl(cbn.id,-1) as customer_id,
  nvl(cbn.name,'未知') as customer_name,
  nvl(di.d_ind_code, '999') as industry_code,
  nvl(di.d_sub_industry, '未知') as industry_name,
  nvl(cbn.serviceuser_id, -1) as rps_id,
  nvl(cbn.serviceuser_name, '未知') as rps_name,
  nvl(cbn.service_teamorg_id, -1) as rps_org_id,
  nvl(cbn.service_teamorg_name, '未知') as rps_org_name,
  nvl(cbn.service_branch_id, -1) as rps_branch_id,
  nvl(cbn.service_branch_name, '未知') as rps_branch_name,
  nvl(cbn.sales_user_id, -1) as sales_id,
  nvl(cbn.sales_user_name, '未知') as sales_name,
  nvl(cbn.sales_branch_id, -1) as sales_branch_id,
  nvl(cbn.sales_branch_name, '未知') as sales_branch_name,
  nvl(rsc.cv_cnt,0) as cv_cnt,
  nvl(rsc.exchangelowcv_cv_cnt,0) as exchangelowcv_cv_cnt,
  nvl(rsc.cvcoupon_cnt,0) as cvcoupon_cnt,
  nvl(rsc.intention_cnt,0) as intention_cnt,
  nvl(rsc.invitation_cnt,0) as invitation_cnt,
  nvl(rsc.mskcoupon_cnt,0) as mskcoupon_cnt,
  nvl(rsc.jobrecommendcoupon_cnt,0) as jobrecommendcoupon_cnt,
  nvl(rsc.intention_cv_cnt,0) as intention_cv_cnt,
  nvl(rsc.invitation_cv_cnt,0) as invitation_cv_cnt,
  nvl(rsc.urgent_cv_cnt,0) as urgent_cv_cnt,
  nvl(rsc.msk_cv_cnt,0) as msk_cv_cnt,
  nvl(rsc.mskplus_cv_cnt,0) as mskplus_cv_cnt,
  nvl(rsc.rzk_cv_cnt,0) as rzk_cv_cnt,
  nvl(rsc.total,0) as total,
  from_unixtime(unix_timestamp()) as create_timestamp,
  nvl(target.day_consume_cv_target_cnt,0) as total_target_cnt,
  nvl(cbn.rsc_valid_status,-1) as rsc_valid_status
from dw_erp_d_customer_base cbn
left join 
(
  select ecomp_root_id,
    sum(consume_cv) as cv_cnt,
    sum(consume_cvcoupon) as cvcoupon_cnt,
    sum(consume_intention) as intention_cnt,
    sum(consume_invite) as invitation_cnt,
    sum(consume_mskcoupon) as mskcoupon_cnt,
    sum(consume_jobrecommendcoupon) as jobrecommendcoupon_cnt,
    sum(consume_intention_cv) as intention_cv_cnt,
    sum(consume_invite_cv) as invitation_cv_cnt,
    sum(consume_urgent_cv) as urgent_cv_cnt,
    sum(consume_msk_cv) as msk_cv_cnt,
    sum(consume_mskplus_cv) as mskplus_cv_cnt,
    sum(consume_rzk_cv) as rzk_cv_cnt,
    sum(exchange_cv2lowcv) as exchangelowcv_cv_cnt,
    sum(consume_cv + consume_cvcoupon + consume_intention * 2 + consume_invite * 50 + consume_mskcoupon * 50 + consume_intention_cv + consume_invite_cv + consume_urgent_cv + consume_msk_cv + consume_mskplus_cv + consume_rzk_cv+exchange_cv2lowcv) as total
  from dw_b_d_resource_consume
  where p_date = $date$
  group by ecomp_root_id
  having jobrecommendcoupon_cnt+total>0
  ) rsc
on rsc.ecomp_root_id = cbn.ecomp_id
left join 
  (
    select ct.customer_id,ct.day_consume_cv_target_cnt
      from dw_erp_d_customer_consume_target ct 
      join dim_date_holiday dh 
      on dh.d_date = '$date$'
      and is_workday = 1
      and ct.p_date = dh.d_date
     where ct.p_date = '$date$'
  ) target 
on cbn.id = target.customer_id
left join dim_industry di
on cbn.industry = di.d_ind_code
where cbn.p_date = $date$
and (rsc.ecomp_root_id is not null or target.customer_id is not null);




SELECT
  crc.d_date as d_date,
  crc.customer_id as customer_id,
  crc.customer_name as customer_name,
  crc.industry_code as industry_code,
  crc.industry_name as industry_name,
  crc.rsc_valid_status as cust_valid_status,
  crc.rps_id as rps_id,
  crc.rps_name as rps_name,
  crc.rps_org_id as rps_org_id,
  crc.rps_org_name as rps_org_name,
  crc.rps_branch_id as rps_branch_id,
  crc.rps_branch_name as rps_branch_name,
  gcdccustomer.sales_user_id as sales_id,
  gcdccustomer.sales_user_name as sales_name,
  gcdccustomer.sales_org_id as sales_org_id,
  gcdccustomer.sales_org_name as sales_org_name,
  gcdccustomer.sales_branch_id as sales_branch_id,
  gcdccustomer.sales_branch_name as sales_branch_name,
  sum(crc.cv_cnt) as cv_cnt,
  sum(crc.exchangelowcv_cv_cnt) as exchangelowcv_cv_cnt,
  sum(crc.cvcoupon_cnt) as cvcoupon_cnt,
  sum(crc.intention_cnt) as intention_cnt,
  sum(crc.invitation_cnt) as invitation_cnt,
  sum(crc.jobrecommendcoupon_cnt) as jobrecommendcoupon_cnt,
  sum(crc.mskcoupon_cnt) as mskcoupon_cnt,
  sum(crc.intention_cv_cnt) as intention_cv_cnt,
  sum(crc.invitation_cv_cnt) as invitation_cv_cnt,
  sum(crc.ergency_cv_cnt) as ergency_cv_cnt,
  sum(crc.msk_cv_cnt) as msk_cv_cnt,
  sum(crc.mskplus_cv_cnt) as mskplus_cv_cnt,
  sum(crc.rzk_cv_cnt) as rzk_cv_cnt,
  sum(crc.total) as total,
  sum(crc.total_target_cnt) as cust_resource_target_cnt 
FROM 
  fact_h_gcdc_d_customer_resource_consume crc
  join dim_gcdc_customer gcdccustomer 
    on crc.customer_id = gcdccustomer.id
WHERE
  crc.d_date >= ${start_date}
  AND crc.d_date <= ${end_date}
  AND crc.rsc_valid_status = IF(${cust_valid_status}=2,crc.rsc_valid_status,${cust_valid_status})
  AND crc.customer_name LIKE IF(#{customer_name} = 'null',crc.customer_name ,concat(#{customer_name},'%'))
  AND crc.industry_code = IF(${industry} is null,crc.industry_code,#{industry})
  AND crc.rps_branch_id = IF(${rps_branch_id}=0,crc.rps_branch_id ,${rps_branch_id})
  AND gcdccustomer.sales_branch_id = IF(${sales_branch_id}=0,gcdccustomer.sales_branch_id ,${sales_branch_id})
  AND crc.rps_id = IF(${employee_id}=0,crc.rps_id,${employee_id})
  AND crc.rps_org_id = IF(${org_id}=0,crc.rps_org_id,${org_id})
  AND (case when #{withSecurityCreatorIds} = 0 then 0 ELSE crc.rps_id END) IN (${withSecurityCreatorIds})
  AND (case when #{withSecurityOrgIds} = 0 then 0 ELSE crc.rps_org_id END) IN (${withSecurityOrgIds})
GROUP BY customer_id, rsc_valid_status,
			crc.rps_id,
			crc.rps_org_id,
			crc.rps_branch_id
limit ${current_page},${page_size}



SELECT
  count(1) as total_count
FROM
(
  SELECT
    customer_id
  FROM 
    fact_h_gcdc_d_customer_resource_consume crc
    join dim_gcdc_customer gcdccustomer 
      on crc.customer_id = gcdccustomer.id
  WHERE
    crc.d_date >= ${start_date}
    AND crc.d_date <= ${end_date}
    AND crc.rsc_valid_status = IF(${cust_valid_status}=2,crc.rsc_valid_status,${cust_valid_status})
    AND crc.customer_name LIKE IF(#{customer_name} = 'null' ,crc.customer_name ,concat(#{customer_name},'%'))
    AND crc.industry_code = IF(${industry} is null,crc.industry_code ,#{industry})
    AND crc.rps_branch_id = IF(${rps_branch_id}=0,crc.rps_branch_id ,${rps_branch_id})
    AND gcdccustomer.sales_branch_id = IF(${sales_branch_id}=0,gcdccustomer.sales_branch_id ,${sales_branch_id})
    AND crc.rps_id = IF(${employee_id}=0,crc.rps_id,${employee_id})
    AND crc.rps_org_id = IF(${org_id}=0,crc.rps_org_id,${org_id})
    AND (case when #{withSecurityCreatorIds} = 0 then 0 ELSE crc.rps_id END) IN (${withSecurityCreatorIds})
    AND (case when #{withSecurityOrgIds} = 0 then 0 ELSE crc.rps_org_id END) IN (${withSecurityOrgIds})
  GROUP BY customer_id,rsc_valid_status,
  			crc.rps_id,
			crc.rps_org_id,
			crc.rps_branch_id
) temp