alter table dw_erp_d_ejob add columns (deleteflag int comment '删除标记') cascade;
alter table dw_erp_d_ejob add columns (serviceuser_name string comment '所属招服名称') cascade;
alter table dw_erp_d_ejob add columns (org_name string comment '所属招服组织名称') cascade;
insert overwrite table dw_erp_d_ejob partition (p_date = $date$)
  select 
    nvl(ejob.id, -1) as id,
    nvl(ejob.ejob_id, -1) as ejob,
    nvl(ejob.customer_id, -1) as customer_id,
    nvl(customerbase.ecomp_id, -1) as ecomp_id,
    nvl(ejob.job_title, '未知') as job_title,
    nvl(ejob.usere_id, -1) as usere_id,
    nvl(ejob.status, -1) as status,
    nvl(ejob.kind, -1) as kind,
    nvl(ejob.job_label, '-1') as job_label,
    nvl(ejob.job_target_comp, '未知') as job_target_comp,
    nvl(ejob.total, 0) as total,
    nvl(ejob.accepted, 0) as accepted,
    nvl(ejob.unaccepted, 0) as unaccepted,
    nvl(concat(substr(ejob.recomdate,1,4),'-',substr(ejob.recomdate,5,2),'-',substr(ejob.recomdate,7,2)) , '1900-01-01' ) as recomdate,
    nvl(customerbase.serviceuser_id , -1) as serviceuser_id ,
    nvl(customerbase.service_teamorg_id, -1) as org_id, 
    ejob.createtime as createtime,
    ejob.modifytime as modifytime,
    from_unixtime(unix_timestamp()) as creation_timestamp,
    deleteflag,
    nvl(suser.name,'未知') as serviceuser_name,
    nvl(dim_org.org_name,'未知') as org_name
  from
    rsc_ejob ejob 
  left join dw_erp_d_customer_base customerbase on ejob.customer_id = customerbase.id and customerbase.p_date = $date$
  left join dw_erp_d_salesuser_base suser on customerbase.serviceuser_id = suser.id and suser.p_date = $date$
  left join dim_org on customerbase.service_teamorg_id = dim_org.d_org_id;


alter table dw_erp_d_ejob_candidate add columns(ejob_deleteflag int comment '职位删除标记') cascade;
alter table dw_erp_d_ejob_candidate add columns(ejob_deleteflag int comment '职位删除标记') cascade;
alter table dw_erp_d_ejob_candidate add columns(ejob_deleteflag int comment '职位删除标记') cascade;
alter table dw_erp_d_ejob_candidate add columns(ejob_deleteflag int comment '职位删除标记') cascade;
alter table dw_erp_d_ejob_candidate add columns(rps_service_version int comment '客户服务版本') cascade;
alter table dw_erp_d_ejob_candidate add columns(rsc_valid_status int comment '客户服务状态') cascade;

--改成增量之后的新版本恢复数据版本


CREATE TABLE dw_erp_d_ejob_candidate(
  id int COMMENT '主键', 
  ecomp_root_id int COMMENT '集团ID', 
  ecomp_id int COMMENT '企业ID', 
  customer_id int COMMENT '客户ID', 
  usere_id int COMMENT '企业HR ID', 
  ejob_id int COMMENT '企业职位ID', 
  job_title string COMMENT '职位名称', 
  res_id int COMMENT '推荐的简历ID', 
  readflag string COMMENT '简历查阅状态.0:未读,1:已读', 
  feedback string COMMENT '简历处理状态.1:未处理,2:满意,4:满意并下载,9:不满意', 
  readtime string COMMENT '简历查阅时间', 
  handletime string COMMENT '简历处理时间', 
  createtime string COMMENT '简历推荐时间', 
  modifytime string COMMENT '记录修改时间', 
  source int COMMENT '推荐来源.0:顾问推荐,4:系统推荐', 
  score string COMMENT '简历由于职位相似度打分', 
  reason string COMMENT '不满意原因', 
  serviceuser_id int COMMENT '招服ID', 
  serviceuser_name string COMMENT '招服姓名', 
  org_id int COMMENT '招服所属机构ID', 
  org_name string COMMENT '招服所属机构姓名', 
  creaton_timestamp timestamp COMMENT '时间戳', 
  res_type int COMMENT '简历类型:1-白领，2-精英', 
  ejob_deleteflag int COMMENT '职位删除标记', 
  rps_service_version int COMMENT '客户服务版本', 
  rsc_valid_status int COMMENT '客户服务状态')
PARTITIONED BY ( 
  p_date int)

alter table dw_erp_d_ejob_candidate add columns (
  recmd_rps_id int COMMENT '推荐时招服ID',
  recmd_rps_name string COMMENT '推荐时招服姓名',
  recmd_org_id int COMMENT '推荐时招服所属机构ID',
  recmd_org_name string COMMENT '推荐时招服所属机构姓名')

insert overwrite table dw_erp_d_ejob_candidate partition (p_date = $date$)
select
  nvl(bolerecommend.id, -1) as id ,
  nvl(bolerecommend.ecomp_root_id, -1) as ecomp_root_id,
  nvl(bolerecommend.ecomp_id, -1) as ecomp_id,
  nvl(customer.id, -1) as customer_id,
  nvl(bolerecommend.usere_id, -1) as usere_id,
  nvl(bolerecommend.ejob_id, -1) as ejob_id,
  nvl(ejob.ejob_title, '未知') as job_title,
  nvl(bolerecommend.res_id, -1) as res_id,
  nvl(bolerecommend.readflag, '-1') as readflag,
  nvl(bolerecommend.feedback, '-1') as feedback,
  nvl(bolerecommend.readtime,'1900-01-01') as readtime,
  nvl(bolerecommend.handletime,'1900-01-01') as handletime,
  bolerecommend.createtime as createtime,
  bolerecommend.modifytime as modifytime, 
  nvl(bolerecommend.source, -1) as source,
  nvl(bolerecommend.score, '-1') as score,
  nvl(bolerecommend.reason, '未知') as reason,
  nvl(case when bolerecommend.source = 0 then rpsuser.creator_id else customer.serviceuser_id  end ,-1) as serviceuser_id,
  nvl(case when bolerecommend.source = 0 then suser.name else customer.serviceuser_name end ,'未知') as serviceuser_name,
  nvl(case when bolerecommend.source = 0 then rpsuser.org_id else customer.service_teamorg_id  end ,-1) as org_id,
  nvl(case when bolerecommend.source = 0 then dim_org.org_name else customer.service_teamorg_name end ,'未知') as org_name,  
  from_unixtime(unix_timestamp()) as creation_timestamp,
  case when res.res_level > 1 then 2 else 1 end as res_type,
  nvl(ejob.delflag,-1) as ejob_deleteflag,
  nvl(customer.rps_service_version,-1) as rps_service_version,
  nvl(customer.rsc_valid_status,-1) as rsc_valid_status,

  nvl(fq_cust.serviceuser_id,'-1') as recmd_rps_id,
  nvl(fq_cust.serviceuser_name,'-1') as recmd_rps_name,
  nvl(fq_cust.service_teamorg_id,'-1') as recmd_org_id,
  nvl(fq_cust.service_teamorg_name,'-1') as recmd_org_name,

  nvl(fq_cust.sales_user_id,'-1') as recmd_sales_user_id,
  nvl(fq_cust.sales_user_name,'-1') as recmd_sales_user_name,
  nvl(fq_cust.sales_org_id,'-1') as recmd_sales_org_id,
  nvl(fq_cust.sales_org_name,'-1') as recmd_sales_org_name
from (
    select 
        nvl(bole.id,candidate.id) as id,
        nvl(bole.ecomp_root_id,candidate.ecomp_root_id) as ecomp_root_id,
        nvl(bole.ecomp_id,candidate.ecomp_id) as ecomp_id,
        nvl(bole.usere_id,candidate.usere_id) as usere_id,
        nvl(bole.ejob_id,candidate.ejob_id) as ejob_id,
        nvl(bole.res_id,candidate.res_id) as res_id,
        nvl(bole.readflag,candidate.readflag) as readflag,
        nvl(bole.feedback,candidate.feedback) as feedback,
          (case when candidate.readflag is null and bole.readflag = '1'  then concat(substr($date$,1,4),'-',substr($date$,5,2),'-',substr($date$,7,2))
              when candidate.readflag is null and bole.readflag = '0'  then '1900-01-01'
              when candidate.readflag ='0' and bole.readflag = '1' then concat(substr($date$,1,4),'-',substr($date$,5,2),'-',substr($date$,7,2))
              when candidate.readflag ='1'  then nvl(candidate.readtime, '1901-01-01') 
              when bole.id is null then candidate.readtime
          end) as readtime,
          (case when candidate.feedback is null and  bole.feedback <> '1' then  concat(substr($date$,1,4),'-',substr($date$,5,2),'-',substr($date$,7,2))
              when candidate.feedback is null and  bole.feedback =  '1'   then  '1900-01-01'
              when candidate.feedback ='1' and bole.feedback = '1'  then  '1900-01-01'
              when candidate.feedback ='1' and bole.feedback <> '1'  then concat(substr($date$,1,4),'-',substr($date$,5,2),'-',substr($date$,7,2))
              when candidate.feedback <> '1' and bole.feedback <> '1'  then nvl(candidate.handletime, '1901-01-01')
              when bole.id is null then candidate.handletime
          end) as handletime,
        nvl(bole.createtime,candidate.createtime) as createtime,
        nvl(bole.modifytime,candidate.modifytime) as modifytime,
        nvl(bole.source,candidate.source) as source,
        nvl(bole.score,candidate.score) as score,
        nvl(bole.reason,candidate.reason) as reason,
        substr(regexp_replace(nvl(bole.createtime,candidate.createtime),'-',''),1,8) as fq_createtime
    from (select  id, ecomp_root_id,ecomp_id,usere_id,ejob_id,res_id,readflag,feedback,readtime,handletime,createtime,modifytime,source,score,reason
          from dw_erp_d_ejob_candidate where  p_date =  {{delta(date,-1)}}) candidate
    full join e_bole_recommend_info bole 
    on candidate.id = bole.id 
) bolerecommend
left join 
  (
    select  ejob_id, res_id, creator_id, org_id
    from 
    (
    select ejob.ejob_id, 
            ejobcandidate.res_id, 
            ejobcandidate.creator_id, 
            ejobcandidate.org_id, 
            row_number()over(distribute by ejobcandidate.res_id,ejobcandidate.rsc_ejob_id sort by ejobcandidate.modifytime desc) rn
      from rsc_ejob_candidate ejobcandidate 
      join rsc_ejob ejob on ejobcandidate.rsc_ejob_id = ejob.id
     where ejobcandidate.deleteflag = 0
    ) rsc 
    where rn = 1
  ) rpsuser 
on bolerecommend.ejob_id = rpsuser.ejob_id
and bolerecommend.res_id = rpsuser.res_id
left join dw_erp_d_customer_base customer 
    on bolerecommend.ecomp_id = customer.ecomp_id 
    and customer.p_date = $date$
left join dw_erp_d_customer_base fq_cust 
    on bolerecommend.ecomp_id = fq_cust.ecomp_id 
    and fq_cust.p_date = bolerecommend.fq_createtime
    and fq_cust.p_date between 20160801 and $date$
left join ejob ejob on ejob.ejob_id = bolerecommend.ejob_id 
left join dw_c_d_res_base res on bolerecommend.res_id = res.res_id and res.p_date = $date$
left join dw_erp_d_salesuser_base suser on rpsuser.creator_id = suser.id and suser.p_date = $date$
left join dim_org on rpsuser.org_id = dim_org.d_org_id;



CREATE TABLE fact_h_gcdc_d_ejob_candidate(
  d_date int COMMENT '统计日期', 
  serviceuser_id int COMMENT '招服专员ID', 
  serviceuser_name string COMMENT '招服专员姓名', 
  position_id int COMMENT '岗位id', 
  position_name string COMMENT '岗位名称',  
  serviceuser_org_id int COMMENT '招服所属部门ID', 
  serviceuser_org_name string COMMENT '招服所属部门名称', 
  org_id int COMMENT '部门ID', 
  org_name string COMMENT '部门名称', 
  branch_id int COMMENT 'rps区域ID', 
  branch_name string COMMENT 'rps区域名称', 
  source int COMMENT '推荐来源.0:顾问推荐,4:系统推荐', 
  res_type int COMMENT '简历类型:0-全部,1-白领,2-精英',
  current_ejob_num int COMMENT '客户在招职位数', 
  recommend_customer_num int COMMENT '推荐客户数', 
  recommend_ejob_num int COMMENT '推荐职位数', 
  recommend_resume_num int COMMENT '推荐简历数', 
  satisfied_download_num int COMMENT '满意并下载数', 
  satisfied_intention_num int COMMENT '满意并发起意向沟通数', 
  unsatisfied_num int COMMENT '不满意数', 
  recommend_undeal_num int COMMENT '推荐未处理数', 
  mtd_current_ejob_num int COMMENT '月度累计客户在招职位数', 
  mtd_recommend_customer_num int COMMENT '月度累计推荐客户数', 
  mtd_recommend_ejob_num int COMMENT '月度累计推荐职位数', 
  mtd_recommend_resume_num int COMMENT '月度累计推荐简历数', 
  mtd_satisfied_download_num int COMMENT '月度累计满意并下载数', 
  mtd_satisfied_intention_num int COMMENT '月度累计满意并发起意向沟通数', 
  mtd_unsatisfied_num int COMMENT '月度累计不满意数', 
  mtd_recommend_undeal_num int COMMENT '月度累计推荐未处理数', 
  tm_satisfied_download_num int comment '本月推荐本月处理-满意并下载数',
  tm_satisfied_intention_num int comment '本月推荐本月处理-满意并发起意向沟通数',
  tm_unsatisfied_num int comment '本月推荐本月处理-不满意数',
  mtd_tm_satisfied_download_num int comment '月度累计本月推荐本月处理-满意并下载数',
  mtd_tm_satisfied_intention_num int comment '月度累计本月推荐本月处理-满意并发起意向沟通数',
  mtd_tm_unsatisfied_num int comment '月度累计本月推荐本月处理-不满意数',  
  creation_timestamp timestamp COMMENT '时间戳')
comment 'GCDC职位推荐统计日报表'
PARTITIONED BY ( p_date int);

CREATE TABLE fact_h_gcdc_d_ejob_candidate(
  d_date int COMMENT '统计日期', 
  serviceuser_id int COMMENT '招服专员ID', 
  serviceuser_name varchar(50) COMMENT '招服专员姓名', 
  position_id int COMMENT '岗位id', 
  position_name varchar(50) COMMENT '岗位名称',  
  serviceuser_org_id int COMMENT '招服所属部门ID', 
  serviceuser_org_name varchar(50) COMMENT '招服所属部门名称', 
  org_id int COMMENT '部门ID', 
  org_name varchar(50) COMMENT '部门名称', 
  branch_id int COMMENT 'rps区域ID', 
  branch_name varchar(50) COMMENT 'rps区域名称', 
  source int COMMENT '推荐来源.0:顾问推荐,4:系统推荐', 
  res_type int default 0 COMMENT '简历类型:0-全部,1-白领,2-精英',
  current_ejob_num int default 0 COMMENT '客户在招职位数', 
  recommend_customer_num int default 0 COMMENT '推荐客户数', 
  recommend_ejob_num int default 0 COMMENT '推荐职位数', 
  recommend_resume_num int default 0 COMMENT '推荐简历数', 
  satisfied_download_num int default 0 COMMENT '满意并下载数', 
  satisfied_intention_num int default 0 COMMENT '满意并发起意向沟通数', 
  unsatisfied_num int default 0 COMMENT '不满意数', 
  recommend_undeal_num int default 0 COMMENT '推荐未处理数', 
  mtd_current_ejob_num int default 0 COMMENT '月度累计客户在招职位数', 
  mtd_recommend_customer_num int default 0 COMMENT '月度累计推荐客户数', 
  mtd_recommend_ejob_num int default 0 COMMENT '月度累计推荐职位数', 
  mtd_recommend_resume_num int default 0 COMMENT '月度累计推荐简历数', 
  mtd_satisfied_download_num int default 0 COMMENT '月度累计满意并下载数', 
  mtd_satisfied_intention_num int default 0 COMMENT '月度累计满意并发起意向沟通数', 
  mtd_unsatisfied_num int default 0 COMMENT '月度累计不满意数', 
  mtd_recommend_undeal_num int default 0 COMMENT '月度累计推荐未处理数', 
  tm_satisfied_download_num int default 0 comment '本月推荐本月处理-满意并下载数',
  tm_satisfied_intention_num int default 0 comment '本月推荐本月处理-满意并发起意向沟通数',
  tm_unsatisfied_num int default 0 comment '本月推荐本月处理-不满意数',
  mtd_tm_satisfied_download_num int default 0 comment '月度累计本月推荐本月处理-满意并下载数',
  mtd_tm_satisfied_intention_num int default 0 comment '月度累计本月推荐本月处理-满意并发起意向沟通数',
  mtd_tm_unsatisfied_num int default 0 comment '月度累计本月推荐本月处理-不满意数',  
  creation_timestamp timestamp default current_timestamp comment '时间戳',
  primary key (d_date, serviceuser_id, org_id,serviceuser_org_id,source,res_type)
  ) comment 'GCDC职位推荐统计日报表';

alter table fact_h_gcdc_d_ejob_candidate change source source int comment '推荐来源.0:顾问推荐,1:系统推荐,2:全部' cascade;
alter table fact_h_gcdc_w_ejob_candidate change source source int comment '推荐来源.0:顾问推荐,1:系统推荐,2:全部' cascade;

alter table fact_h_gcdc_d_ejob_candidate change source source int comment '推荐来源.0:顾问推荐,1:系统推荐,2:全部';
alter table fact_h_gcdc_w_ejob_candidate change source source int comment '推荐来源.0:顾问推荐,1:系统推荐,2:全部';

insert overwrite table fact_h_gcdc_d_ejob_candidate partition (p_date = $date$)
    select
      $date$ as d_date,
      nvl(cand_fact.serviceuser_id,-1) as serviceuser_id,
      nvl(salesuserbase.name, '未知') as serviceuser_name,
      nvl(salesuserbase.position_id, -1) as position_id,
      nvl(salesuserbase.position_name, '未知') as position_name,      
      nvl(salesuserbase.org_id, -1) as serviceuser_org_id,
      nvl(salesuserbase.org_name, '未知') as serviceuser_org_name,
      nvl(cand_fact.org_id,-1) as org_id,
      nvl(gcdcorg.org_name, '未知') as org_name,
      nvl(gcdcorg.branch_id, -1) as branch_id,
      nvl(gcdcorg.branch_name, '未知') as branch_name,
      case cand_fact.source when 0 then 0 when 4 then 1 when 2 then 2 end as source,
      nvl(cand_fact.res_type,0) as res_type,
      nvl(cand_fact.current_ejob_num, 0) as current_ejob_num,
      nvl(cand_fact.recommend_customer_num, 0) as recommend_customer_num,
      nvl(cand_fact.recommend_ejob_num, 0) as recommend_ejob_num,
      nvl(cand_fact.recommend_resume_num, 0) as recommend_resume_num,
      nvl(cand_fact.satisfied_download_num, 0) as satisfied_download_num,
      nvl(cand_fact.satisfied_intention_num, 0) as satisfied_intention_num,
      nvl(cand_fact.unsatisfied_num, 0) as unsatisfied_num,
      nvl(cand_fact.recommend_undeal_num, 0) as recommend_undeal_num,
      nvl(cand_fact.current_ejob_num, 0) as mtd_current_ejob_num,
      nvl(cand_fact.mtd_recommend_customer_num, 0) as mtd_recommend_customer_num,
      nvl(cand_fact.mtd_recommend_ejob_num, 0) as mtd_recommend_ejob_num,
      nvl(cand_fact.mtd_recommend_resume_num, 0) as mtd_recommend_resume_num,
      nvl(cand_fact.mtd_satisfied_download_num, 0) as mtd_satisfied_download_num,
      nvl(cand_fact.mtd_satisfied_intention_num, 0) as mtd_satisfied_intention_num,
      nvl(cand_fact.mtd_unsatisfied_num, 0) as mtd_unsatisfied_num,
      nvl(cand_fact.mtd_recommend_undeal_num, 0) as mtd_recommend_undeal_num,
      nvl(cand_fact.tm_satisfied_download_num,0) as tm_satisfied_download_num,
      nvl(cand_fact.tm_satisfied_intention_num,0) as tm_satisfied_intention_num,
      nvl(cand_fact.tm_unsatisfied_num,0) as tm_unsatisfied_num,
      nvl(cand_fact.mtd_tm_satisfied_download_num,0) as mtd_tm_satisfied_download_num,
      nvl(cand_fact.mtd_tm_satisfied_intention_num,0) as mtd_tm_satisfied_intention_num,
      nvl(cand_fact.mtd_tm_unsatisfied_num,0) as mtd_tm_unsatisfied_num,
      from_unixtime(unix_timestamp()) as creation_timestamp
    from
     (
       select 
          coalesce(fact0.serviceuser_id,fact1.serviceuser_id,fact2.serviceuser_id) as serviceuser_id,
          coalesce(fact0.org_id,fact1.org_id,fact2.org_id) as org_id,
          coalesce(fact0.source,fact1.source,fact2.source) as source,
          coalesce(fact0.res_type,fact1.res_type,fact2.res_type) as res_type,
          sum(nvl(current_ejob_num,0)) as current_ejob_num,
          sum(nvl(recommend_customer_num,0)) as recommend_customer_num,
          sum(nvl(recommend_ejob_num,0)) as recommend_ejob_num,
          sum(nvl(recommend_resume_num,0)) as recommend_resume_num,
          sum(nvl(satisfied_download_num,0)) as satisfied_download_num,
          sum(nvl(satisfied_intention_num,0)) as satisfied_intention_num,
          sum(nvl(unsatisfied_num,0)) as unsatisfied_num,
          sum(nvl(recommend_undeal_num,0)) as recommend_undeal_num,
          sum(nvl(mtd_recommend_customer_num,0)) as mtd_recommend_customer_num,
          sum(nvl(mtd_recommend_ejob_num,0)) as mtd_recommend_ejob_num,
          sum(nvl(mtd_recommend_resume_num,0)) as mtd_recommend_resume_num,
          sum(nvl(mtd_satisfied_download_num,0)) as mtd_satisfied_download_num,
          sum(nvl(mtd_satisfied_intention_num,0)) as mtd_satisfied_intention_num,
          sum(nvl(mtd_unsatisfied_num,0)) as mtd_unsatisfied_num,
          sum(nvl(mtd_recommend_undeal_num,0)) as mtd_recommend_undeal_num,
          sum(nvl(tm_satisfied_download_num,0)) as tm_satisfied_download_num,
          sum(nvl(tm_satisfied_intention_num,0)) as tm_satisfied_intention_num,
          sum(nvl(tm_unsatisfied_num,0)) as tm_unsatisfied_num,
          sum(nvl(mtd_tm_satisfied_download_num,0)) as mtd_tm_satisfied_download_num,
          sum(nvl(mtd_tm_satisfied_intention_num,0)) as mtd_tm_satisfied_intention_num,
          sum(nvl(mtd_tm_unsatisfied_num,0)) as mtd_tm_unsatisfied_num      
      from 
      (
          select base2.serviceuser_id,base2.org_id,base2.current_ejob_num,all_type.source,all_type.res_type
          from 
          (
            select 
              dwejob.serviceuser_id, dwejob.org_id, 
              nvl(count(dwejob.ejob_id),0) as current_ejob_num
            from 
            dw_erp_d_ejob dwejob 
            where dwejob.p_date = $date$ 
            and dwejob.status = 0
            group by dwejob.serviceuser_id, dwejob.org_id
           ) base2
          join (
                  select source,res_type
                  from (select explode(array(0,2,4)) as source from dummy) source
                  join (select explode(array(0,1,2)) as res_type from dummy) res
                  on 1=1
          ) all_type 
          on 1=1
       ) fact0
       full join 
       (
          select
          dwejobcandidate.serviceuser_id,
          dwejobcandidate.org_id,
          all_type.source,all_type.res_type,
          count(distinct(case when substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) = '$date$' then dwejobcandidate.customer_id else null end)) as recommend_customer_num,
          count(distinct(case when substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) = '$date$' then dwejobcandidate.ejob_id else null end)) as recommend_ejob_num,
          count(case when substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) = '$date$' then dwejobcandidate.res_id else null end) as recommend_resume_num,
          sum(case when substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) = '$date$' and dwejobcandidate.feedback = 1 then 1 else 0 end) as recommend_undeal_num,
          count(distinct(dwejobcandidate.customer_id )) as mtd_recommend_customer_num,
          count(distinct(dwejobcandidate.ejob_id )) as mtd_recommend_ejob_num,
          count(dwejobcandidate.res_id ) as mtd_recommend_resume_num,
          sum(case when dwejobcandidate.feedback = 1 then 1 else 0 end) as mtd_recommend_undeal_num,
          sum(case when substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) = '$date$' and dwejobcandidate.feedback = 4 then 1 else 0 end) as tm_satisfied_download_num,
          sum(case when substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) = '$date$' and dwejobcandidate.feedback in (2,5) then 1 else 0 end) as tm_satisfied_intention_num,
          sum(case when substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) = '$date$' and dwejobcandidate.feedback in (9,6) then 1 else 0 end) as tm_unsatisfied_num,  
          sum(case when dwejobcandidate.feedback = 4 then 1 else 0 end) as mtd_tm_satisfied_download_num,
          sum(case when dwejobcandidate.feedback in (2,5) then 1 else 0 end) as mtd_tm_satisfied_intention_num,
          sum(case when dwejobcandidate.feedback in (9,6) then 1 else 0 end) as mtd_tm_unsatisfied_num
        from 
        dw_erp_d_ejob_candidate dwejobcandidate
        join (
          select source,res_type
          from (select explode(array(0,2,4)) as source from dummy) source
          join (select explode(array(0,1,2)) as res_type from dummy) res
          on 1=1
      ) all_type 
     on 1=1
     where ( (all_type.source = 2 and all_type.res_type = 0 ) or --全选
            (all_type.source = dwejobcandidate.source and all_type.res_type = 0 ) or --顾问或系统，简历全选
            (all_type.source = 2 and all_type.res_type = dwejobcandidate.res_type) or --推荐全选,白领或精英
            (all_type.source = dwejobcandidate.source and all_type.res_type = dwejobcandidate.res_type) --顾问或系统，白领或精英
          )
        and dwejobcandidate.p_date = '$date$'
        and substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
        and dwejobcandidate.source in (0,4)
      group by dwejobcandidate.serviceuser_id, dwejobcandidate.org_id,all_type.source,all_type.res_type

        ) fact1
        on fact0.serviceuser_id = fact1.serviceuser_id
        and fact0.org_id = fact1.org_id
        and fact0.source = fact1.source
        and fact0.res_type = fact1.res_type
        full join 
        (
          select
              dwejobcandidate.serviceuser_id,
              dwejobcandidate.org_id,
              all_type.source,all_type.res_type,  
              sum(case when substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) = $date$ and dwejobcandidate.feedback = 4 then 1 else 0 end) as satisfied_download_num,
              sum(case when substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) = $date$ and dwejobcandidate.feedback in (2,5) then 1 else 0 end) as satisfied_intention_num,
              sum(case when substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) = $date$ and dwejobcandidate.feedback in (9,6) then 1 else 0 end) as unsatisfied_num,
              sum(case when dwejobcandidate.feedback = 4 then 1 else 0 end) as mtd_satisfied_download_num,
              sum(case when dwejobcandidate.feedback in (2,5) then 1 else 0 end) as mtd_satisfied_intention_num,
              sum(case when dwejobcandidate.feedback in (9,6) then 1 else 0 end) as mtd_unsatisfied_num
              from 
              dw_erp_d_ejob_candidate dwejobcandidate
            join (
                    select source,res_type
                    from (select explode(array(0,2,4)) as source from dummy) source
                    join (select explode(array(0,1,2)) as res_type from dummy) res
                    on 1=1
            ) all_type 
            on 1=1
            where ( (all_type.source = 2 and all_type.res_type = 0) or --全选
                    (all_type.source = dwejobcandidate.source and all_type.res_type = 0) or --顾问或系统，简历全选
                    (all_type.source = 2 and all_type.res_type = dwejobcandidate.res_type) or --推荐全选,白领或精英
                    (all_type.source = dwejobcandidate.source and all_type.res_type = dwejobcandidate.res_type) --顾问或系统，白领或精英
                  )
            and dwejobcandidate.p_date = $date$
            and substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) between concat(substr($date$,1,6),'01') and $date$ 
            and dwejobcandidate.source in (0,4)              
            group by dwejobcandidate.serviceuser_id,dwejobcandidate.org_id,all_type.source,all_type.res_type
        ) fact2
        on fact0.serviceuser_id = fact2.serviceuser_id
        and fact0.org_id = fact2.org_id
        and fact0.source = fact2.source
        and fact0.res_type = fact2.res_type 
        group by 
          coalesce(fact0.serviceuser_id,fact1.serviceuser_id,fact2.serviceuser_id),
          coalesce(fact0.org_id,fact1.org_id,fact2.org_id),
          coalesce(fact0.source,fact1.source,fact2.source),
          coalesce(fact0.res_type,fact1.res_type,fact2.res_type)
     ) cand_fact 
    left join dw_erp_d_salesuser_base salesuserbase on salesuserbase.id = cand_fact.serviceuser_id and salesuserbase.p_date = $date$
    left join dim_org gcdcorg on gcdcorg.d_org_id = cand_fact.org_id 
    where nvl(cand_fact.serviceuser_id,-1) not in (0,-1);



CREATE TABLE fact_h_gcdc_w_ejob_candidate(
  d_date int COMMENT '统计日期', 
  week int comment '周',  
  serviceuser_id int COMMENT '招服专员ID', 
  serviceuser_name string COMMENT '招服专员姓名', 
  position_id int COMMENT '岗位id', 
  position_name string COMMENT '岗位名称',  
  serviceuser_org_id int COMMENT '招服所属部门ID', 
  serviceuser_org_name string COMMENT '招服所属部门名称', 
  org_id int COMMENT '部门ID', 
  org_name string COMMENT '部门名称', 
  branch_id int COMMENT 'rps区域ID', 
  branch_name string COMMENT 'rps区域名称', 
  source int COMMENT '推荐来源.0:顾问推荐,4:系统推荐', 
  res_type int COMMENT '简历类型:0-全部,1-白领,2-精英',
  current_ejob_num int COMMENT '客户在招职位数', 
  recommend_customer_num int COMMENT '推荐客户数', 
  recommend_ejob_num int COMMENT '推荐职位数', 
  recommend_resume_num int COMMENT '推荐简历数', 
  satisfied_download_num int COMMENT '满意并下载数', 
  satisfied_intention_num int COMMENT '满意并发起意向沟通数', 
  unsatisfied_num int COMMENT '不满意数', 
  recommend_undeal_num int COMMENT '推荐未处理数', 
  tm_satisfied_download_num int comment '本月推荐本月处理-满意并下载数',
  tm_satisfied_intention_num int comment '本月推荐本月处理-满意并发起意向沟通数',
  tm_unsatisfied_num int comment '本月推荐本月处理-不满意数',
  creation_timestamp timestamp COMMENT '时间戳')
comment 'GCDC职位推荐统计周报表'
PARTITIONED BY ( p_date int);


create table fact_h_gcdc_w_ejob_candidate
(
  d_date int comment '统计日期',
  week int comment '周',
  serviceuser_id int comment '招服专员id',
  serviceuser_name varchar(32) comment '招服专员姓名',
  position_id int COMMENT '岗位id',
  position_name varchar(32) COMMENT '岗位名称',
  serviceuser_org_id int comment '招服所属部门id',
  serviceuser_org_name varchar(32) comment '招服所属部门名称',
  org_id int comment '部门id',
  org_name varchar(100) comment '部门名称',
  branch_id int comment 'rps区域id',
  branch_name varchar(32) comment 'rps区域名称',
  source int comment '推荐来源.0:顾问推荐,4:系统推荐',
  res_type int COMMENT '简历类型:0-全部,1-白领,2-精英',  
  current_ejob_num int comment '客户在招职位数',
  recommend_customer_num int comment '推荐客户数',
  recommend_ejob_num int comment '推荐职位数',
  recommend_resume_num int comment '推荐简历数',
  satisfied_download_num int comment '满意并下载数',
  satisfied_intention_num int comment '满意并发起意向沟通数',
  unsatisfied_num int comment '不满意数',
  recommend_undeal_num int comment '推荐未处理数',
  tm_satisfied_download_num int comment '本月推荐本月处理-满意并下载数',
  tm_satisfied_intention_num int comment '本月推荐本月处理-满意并发起意向沟通数',
  tm_unsatisfied_num int comment '本月推荐本月处理-不满意数',
  creation_timestamp timestamp default current_timestamp comment '时间戳',
  primary key (d_date, serviceuser_id, org_id)
) comment 'GCDC职位推荐统计周报表';

alter table fact_h_gcdc_w_ejob_candidate drop primary key;
alter table fact_h_gcdc_w_ejob_candidate add primary key(d_date, serviceuser_id, org_id,serviceuser_org_id,source,res_type);

insert overwrite table fact_h_gcdc_w_ejob_candidate partition (p_date = $date$)
 select
      $date$ as d_date,
      concat(dimdate.d_year,dimdate.d_week) AS week,
      nvl(cand_fact.serviceuser_id,-1) as serviceuser_id,
      nvl(salesuserbase.name, '未知') as serviceuser_name,
      nvl(salesuserbase.position_id, -1) as position_id,
      nvl(salesuserbase.position_name, '未知') as position_name,      
      nvl(salesuserbase.org_id, -1) as serviceuser_org_id,
      nvl(salesuserbase.org_name, '未知') as serviceuser_org_name,
      nvl(cand_fact.org_id,-1) as org_id,
      nvl(gcdcorg.org_name, '未知') as org_name,
      nvl(gcdcorg.branch_id, -1) as branch_id,
      nvl(gcdcorg.branch_name, '未知') as branch_name,
      case cand_fact.source when 0 then 0 when 4 then 1 when 2 then 2 end as source,
      nvl(cand_fact.res_type,0) as res_type,
      nvl(cand_fact.current_ejob_num, 0) as current_ejob_num,
      nvl(cand_fact.recommend_customer_num, 0) as recommend_customer_num,
      nvl(cand_fact.recommend_ejob_num, 0) as recommend_ejob_num,
      nvl(cand_fact.recommend_resume_num, 0) as recommend_resume_num,
      nvl(cand_fact.satisfied_download_num, 0) as satisfied_download_num,
      nvl(cand_fact.satisfied_intention_num, 0) as satisfied_intention_num,
      nvl(cand_fact.unsatisfied_num, 0) as unsatisfied_num,
      nvl(cand_fact.recommend_undeal_num, 0) as recommend_undeal_num,
      nvl(cand_fact.tm_satisfied_download_num,0) as tm_satisfied_download_num,
      nvl(cand_fact.tm_satisfied_intention_num,0) as tm_satisfied_intention_num,
      nvl(cand_fact.tm_unsatisfied_num,0) as tm_unsatisfied_num,
      from_unixtime(unix_timestamp()) as creation_timestamp
    from
     (
       select 
          coalesce(fact0.serviceuser_id,fact1.serviceuser_id,fact2.serviceuser_id) as serviceuser_id,
          coalesce(fact0.org_id,fact1.org_id,fact2.org_id) as org_id,
          coalesce(fact0.source,fact1.source,fact2.source) as source,
          coalesce(fact0.res_type,fact1.res_type,fact2.res_type) as res_type,
          sum(nvl(current_ejob_num,0)) as current_ejob_num,
          sum(nvl(recommend_customer_num,0)) as recommend_customer_num,
          sum(nvl(recommend_ejob_num,0)) as recommend_ejob_num,
          sum(nvl(recommend_resume_num,0)) as recommend_resume_num,
          sum(nvl(satisfied_download_num,0)) as satisfied_download_num,
          sum(nvl(satisfied_intention_num,0)) as satisfied_intention_num,
          sum(nvl(unsatisfied_num,0)) as unsatisfied_num,
          sum(nvl(recommend_undeal_num,0)) as recommend_undeal_num,
          sum(nvl(tm_satisfied_download_num,0)) as tm_satisfied_download_num,
          sum(nvl(tm_satisfied_intention_num,0)) as tm_satisfied_intention_num,
          sum(nvl(tm_unsatisfied_num,0)) as tm_unsatisfied_num   
      from 
      (
          select base2.serviceuser_id,base2.org_id,base2.current_ejob_num,all_type.source,all_type.res_type
          from 
          (
            select 
              dwejob.serviceuser_id, dwejob.org_id, 
              nvl(count(dwejob.ejob_id),0) as current_ejob_num
            from 
            dw_erp_d_ejob dwejob 
            where dwejob.p_date = $date$ 
            and dwejob.status = 0
            group by dwejob.serviceuser_id, dwejob.org_id
           ) base2
          join (
                  select source,res_type
                  from (select explode(array(0,2,4)) as source from dummy) source
                  join (select explode(array(0,1,2)) as res_type from dummy) res
                  on 1=1
          ) all_type 
          on 1=1
       ) fact0
       full join 
       (
          select
          dwejobcandidate.serviceuser_id,
          dwejobcandidate.org_id,
          all_type.source,all_type.res_type,
          count(distinct(dwejobcandidate.customer_id )) as recommend_customer_num,
          count(distinct(dwejobcandidate.ejob_id )) as recommend_ejob_num,
          count(dwejobcandidate.res_id ) as recommend_resume_num,
          sum(case when dwejobcandidate.feedback = 1 then 1 else 0 end) as recommend_undeal_num,
          sum(case when dwejobcandidate.feedback = 4 then 1 else 0 end) as tm_satisfied_download_num,
          sum(case when dwejobcandidate.feedback in (2,5) then 1 else 0 end) as tm_satisfied_intention_num,
          sum(case when dwejobcandidate.feedback in (9,6) then 1 else 0 end) as tm_unsatisfied_num
        from 
        dw_erp_d_ejob_candidate dwejobcandidate
        join (
          select source,res_type
          from (select explode(array(0,2,4)) as source from dummy) source
          join (select explode(array(0,1,2)) as res_type from dummy) res
          on 1=1
      ) all_type 
     on 1=1
     where ( (all_type.source = 2 and all_type.res_type = 0) or --全选
            (all_type.source = dwejobcandidate.source and all_type.res_type = 0) or --顾问或系统，简历全选
            (all_type.source = 2 and all_type.res_type = dwejobcandidate.res_type) or --推荐全选,白领或精英
            (all_type.source = dwejobcandidate.source and all_type.res_type = dwejobcandidate.res_type) --顾问或系统，白领或精英
          )
        and dwejobcandidate.p_date = '$date$'
        and dwejobcandidate.source in (0,4)   
        and substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) between {{delta(date,-6)}} and $date$
      group by dwejobcandidate.serviceuser_id, dwejobcandidate.org_id,all_type.source,all_type.res_type

        ) fact1
        on fact0.serviceuser_id = fact1.serviceuser_id
        and fact0.org_id = fact1.org_id
        and fact0.source = fact1.source
        and fact0.res_type = fact1.res_type
        full join 
        (
          select
              dwejobcandidate.serviceuser_id,
              dwejobcandidate.org_id,
              all_type.source,all_type.res_type,  
              sum(case when dwejobcandidate.feedback = 4 then 1 else 0 end) as satisfied_download_num,
              sum(case when dwejobcandidate.feedback in (2,5) then 1 else 0 end) as satisfied_intention_num,
              sum(case when dwejobcandidate.feedback in (9,6) then 1 else 0 end) as unsatisfied_num
              from 
              dw_erp_d_ejob_candidate dwejobcandidate
            join (
                    select source,res_type
                    from (select explode(array(0,2,4)) as source from dummy) source
                    join (select explode(array(0,1,2)) as res_type from dummy) res
                    on 1=1
            ) all_type 
            on 1=1
            where ( (all_type.source = 2 and all_type.res_type = 0) or --全选
                    (all_type.source = dwejobcandidate.source and all_type.res_type = 0) or --顾问或系统，简历全选
                    (all_type.source = 2 and all_type.res_type = dwejobcandidate.res_type) or --推荐全选,白领或精英
                    (all_type.source = dwejobcandidate.source and all_type.res_type = dwejobcandidate.res_type) --顾问或系统，白领或精英
                  )
            and dwejobcandidate.p_date = $date$
            and dwejobcandidate.source in (0,4)   
            and substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) between {{delta(date,-6)}} and $date$             
            group by dwejobcandidate.serviceuser_id,dwejobcandidate.org_id,all_type.source,all_type.res_type
        ) fact2
        on fact0.serviceuser_id = fact2.serviceuser_id
        and fact0.org_id = fact2.org_id
        and fact0.source = fact2.source
        and fact0.res_type = fact2.res_type 
        group by 
          coalesce(fact0.serviceuser_id,fact1.serviceuser_id,fact2.serviceuser_id),
          coalesce(fact0.org_id,fact1.org_id,fact2.org_id),
          coalesce(fact0.source,fact1.source,fact2.source),
          coalesce(fact0.res_type,fact1.res_type,fact2.res_type)
     ) cand_fact 
    left join dw_erp_d_salesuser_base salesuserbase on salesuserbase.id = cand_fact.serviceuser_id and salesuserbase.p_date = $date$
    left join dim_org gcdcorg on gcdcorg.d_org_id = cand_fact.org_id 
    left join dim_date dimdate on dimdate.d_date = $date$
    where nvl(cand_fact.serviceuser_id,-1)  not in (0,-1);








CREATE TABLE fact_h_gcdc_d_ejob_candidate_pre2(
  d_date int COMMENT '统计日期', 
  serviceuser_id int COMMENT '招服专员id', 
  serviceuser_name string COMMENT '招服专员姓名', 
  position_id int COMMENT '岗位id', 
  position_name string COMMENT '岗位名称', 
  serviceuser_org_id int COMMENT '招服所属部门id', 
  serviceuser_org_name string COMMENT '招服所属部门名称', 
  org_id int COMMENT '部门id', 
  org_name string COMMENT '部门名称', 
  branch_id int COMMENT 'rps区域id', 
  branch_name string COMMENT 'rps区域名称', 
  source int COMMENT '推荐来源.0:顾问推荐,1:系统推荐,2:全部', 
  res_type int COMMENT '简历类型:0-全部,1-白领,2-精英', 
  current_ejob_num int COMMENT '客户在招职位数', 
  recommend_customer_num int COMMENT '推荐客户数', 
  recommend_ejob_num int COMMENT '推荐职位数', 
  recommend_resume_num int COMMENT '推荐简历数', 
  satisfied_download_num int COMMENT '满意并下载数', 
  satisfied_intention_num int COMMENT '满意并发起意向沟通数', 
  unsatisfied_num int COMMENT '不满意数', 
  recommend_undeal_num int COMMENT '推荐未处理数', 
  mtd_current_ejob_num int COMMENT '月度累计客户在招职位数', 
  mtd_recommend_customer_num int COMMENT '月度累计推荐客户数', 
  mtd_recommend_ejob_num int COMMENT '月度累计推荐职位数', 
  mtd_recommend_resume_num int COMMENT '月度累计推荐简历数', 
  mtd_satisfied_download_num int COMMENT '月度累计满意并下载数', 
  mtd_satisfied_intention_num int COMMENT '月度累计满意并发起意向沟通数', 
  mtd_unsatisfied_num int COMMENT '月度累计不满意数', 
  mtd_recommend_undeal_num int COMMENT '月度累计推荐未处理数', 
  tm_satisfied_download_num int COMMENT '本月推荐本月处理-满意并下载数', 
  tm_satisfied_intention_num int COMMENT '本月推荐本月处理-满意并发起意向沟通数', 
  tm_unsatisfied_num int COMMENT '本月推荐本月处理-不满意数', 
  mtd_tm_satisfied_download_num int COMMENT '月度累计本月推荐本月处理-满意并下载数', 
  mtd_tm_satisfied_intention_num int COMMENT '月度累计本月推荐本月处理-满意并发起意向沟通数', 
  mtd_tm_unsatisfied_num int COMMENT '月度累计本月推荐本月处理-不满意数', 
  creation_timestamp timestamp COMMENT '时间戳')
COMMENT '职位推荐统计日报表'
PARTITIONED BY ( p_date int);


insert overwrite table fact_h_gcdc_d_ejob_candidate_pre2 partition (p_date = $date$)
    select
      $date$ as d_date,
      nvl(cand_fact.serviceuser_id,-1) as serviceuser_id,
      nvl(salesuserbase.name, '未知') as serviceuser_name,
      nvl(salesuserbase.position_id, -1) as position_id,
      nvl(salesuserbase.position_name, '未知') as position_name,      
      nvl(salesuserbase.org_id, -1) as serviceuser_org_id,
      nvl(salesuserbase.org_name, '未知') as serviceuser_org_name,
      nvl(cand_fact.org_id,-1) as org_id,
      nvl(gcdcorg.org_name, '未知') as org_name,
      nvl(gcdcorg.branch_id, -1) as branch_id,
      nvl(gcdcorg.branch_name, '未知') as branch_name,
      case cand_fact.source when 0 then 0 when 4 then 1 when 2 then 2 end as source,
      nvl(cand_fact.res_type,0) as res_type,
      nvl(cand_fact.current_ejob_num, 0) as current_ejob_num,
      nvl(cand_fact.recommend_customer_num, 0) as recommend_customer_num,
      nvl(cand_fact.recommend_ejob_num, 0) as recommend_ejob_num,
      nvl(cand_fact.recommend_resume_num, 0) as recommend_resume_num,
      nvl(cand_fact.satisfied_download_num, 0) as satisfied_download_num,
      nvl(cand_fact.satisfied_intention_num, 0) as satisfied_intention_num,
      nvl(cand_fact.unsatisfied_num, 0) as unsatisfied_num,
      nvl(cand_fact.recommend_undeal_num, 0) as recommend_undeal_num,
      nvl(cand_fact.current_ejob_num, 0) as mtd_current_ejob_num,
      nvl(cand_fact.mtd_recommend_customer_num, 0) as mtd_recommend_customer_num,
      nvl(cand_fact.mtd_recommend_ejob_num, 0) as mtd_recommend_ejob_num,
      nvl(cand_fact.mtd_recommend_resume_num, 0) as mtd_recommend_resume_num,
      nvl(cand_fact.mtd_satisfied_download_num, 0) as mtd_satisfied_download_num,
      nvl(cand_fact.mtd_satisfied_intention_num, 0) as mtd_satisfied_intention_num,
      nvl(cand_fact.mtd_unsatisfied_num, 0) as mtd_unsatisfied_num,
      nvl(cand_fact.mtd_recommend_undeal_num, 0) as mtd_recommend_undeal_num,
      nvl(cand_fact.tm_satisfied_download_num,0) as tm_satisfied_download_num,
      nvl(cand_fact.tm_satisfied_intention_num,0) as tm_satisfied_intention_num,
      nvl(cand_fact.tm_unsatisfied_num,0) as tm_unsatisfied_num,
      nvl(cand_fact.mtd_tm_satisfied_download_num,0) as mtd_tm_satisfied_download_num,
      nvl(cand_fact.mtd_tm_satisfied_intention_num,0) as mtd_tm_satisfied_intention_num,
      nvl(cand_fact.mtd_tm_unsatisfied_num,0) as mtd_tm_unsatisfied_num,
      from_unixtime(unix_timestamp()) as creation_timestamp
    from
     (
       select 
          coalesce(fact0.serviceuser_id,fact1.serviceuser_id,fact2.serviceuser_id) as serviceuser_id,
          coalesce(fact0.org_id,fact1.org_id,fact2.org_id) as org_id,
          coalesce(fact0.source,fact1.source,fact2.source) as source,
          coalesce(fact0.res_type,fact1.res_type,fact2.res_type) as res_type,
          sum(nvl(current_ejob_num,0)) as current_ejob_num,
          sum(nvl(recommend_customer_num,0)) as recommend_customer_num,
          sum(nvl(recommend_ejob_num,0)) as recommend_ejob_num,
          sum(nvl(recommend_resume_num,0)) as recommend_resume_num,
          sum(nvl(satisfied_download_num,0)) as satisfied_download_num,
          sum(nvl(satisfied_intention_num,0)) as satisfied_intention_num,
          sum(nvl(unsatisfied_num,0)) as unsatisfied_num,
          sum(nvl(recommend_undeal_num,0)) as recommend_undeal_num,
          sum(nvl(mtd_recommend_customer_num,0)) as mtd_recommend_customer_num,
          sum(nvl(mtd_recommend_ejob_num,0)) as mtd_recommend_ejob_num,
          sum(nvl(mtd_recommend_resume_num,0)) as mtd_recommend_resume_num,
          sum(nvl(mtd_satisfied_download_num,0)) as mtd_satisfied_download_num,
          sum(nvl(mtd_satisfied_intention_num,0)) as mtd_satisfied_intention_num,
          sum(nvl(mtd_unsatisfied_num,0)) as mtd_unsatisfied_num,
          sum(nvl(mtd_recommend_undeal_num,0)) as mtd_recommend_undeal_num,
          sum(nvl(tm_satisfied_download_num,0)) as tm_satisfied_download_num,
          sum(nvl(tm_satisfied_intention_num,0)) as tm_satisfied_intention_num,
          sum(nvl(tm_unsatisfied_num,0)) as tm_unsatisfied_num,
          sum(nvl(mtd_tm_satisfied_download_num,0)) as mtd_tm_satisfied_download_num,
          sum(nvl(mtd_tm_satisfied_intention_num,0)) as mtd_tm_satisfied_intention_num,
          sum(nvl(mtd_tm_unsatisfied_num,0)) as mtd_tm_unsatisfied_num      
      from 
      (
          select base2.serviceuser_id,base2.org_id,base2.current_ejob_num,all_type.source,all_type.res_type
          from 
          (
            select 
              dwejob.serviceuser_id, dwejob.org_id, 
              nvl(count(dwejob.ejob_id),0) as current_ejob_num
            from dw_erp_d_ejob dwejob 
            where dwejob.p_date = $date$ 
            and dwejob.status = 0
            group by dwejob.serviceuser_id, dwejob.org_id
           ) base2
          join (
                  select source,res_type
                  from (select explode(array(0,2,4)) as source from dummy) source
                  join (select explode(array(0,1,2)) as res_type from dummy) res
                  on 1=1
          ) all_type 
          on 1=1
       ) fact0
       full join 
       (
          select
            dwejobcandidate.recmd_rps_id as serviceuser_id,
            dwejobcandidate.recmd_org_id as org_id,
            all_type.source,all_type.res_type,
            count(distinct(case when substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) = '$date$' and cust.parent_customer_id = 0 then dwejobcandidate.customer_id else null end)) as recommend_customer_num,
            count(distinct(case when substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) = '$date$' then dwejobcandidate.ejob_id else null end)) as recommend_ejob_num,
            count(case when substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) = '$date$' then dwejobcandidate.res_id else null end) as recommend_resume_num,
            sum(case when substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) = '$date$' and dwejobcandidate.feedback = 1 then 1 else 0 end) as recommend_undeal_num,
            count(distinct(case when cust.parent_customer_id = 0 then dwejobcandidate.customer_id else null end)) as mtd_recommend_customer_num,
            count(distinct(dwejobcandidate.ejob_id )) as mtd_recommend_ejob_num,
            count(dwejobcandidate.res_id ) as mtd_recommend_resume_num,
            sum(case when dwejobcandidate.feedback = 1 then 1 else 0 end) as mtd_recommend_undeal_num,
            sum(case when substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) = '$date$' and dwejobcandidate.feedback = 4 then 1 else 0 end) as tm_satisfied_download_num,
            sum(case when substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) = '$date$' and dwejobcandidate.feedback in (2,5) then 1 else 0 end) as tm_satisfied_intention_num,
            sum(case when substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) = '$date$' and dwejobcandidate.feedback in (9,6) then 1 else 0 end) as tm_unsatisfied_num,  
            sum(case when dwejobcandidate.feedback = 4 then 1 else 0 end) as mtd_tm_satisfied_download_num,
            sum(case when dwejobcandidate.feedback in (2,5) then 1 else 0 end) as mtd_tm_satisfied_intention_num,
            sum(case when dwejobcandidate.feedback in (9,6) then 1 else 0 end) as mtd_tm_unsatisfied_num
          from dw_erp_d_ejob_candidate dwejobcandidate
          join dw_erp_d_customer_base_new cust on dwejobcandidate.customer_id = cust.id 
          join (
                  select source,res_type
                  from (select explode(array(0,2,4)) as source from dummy) source
                  join (select explode(array(0,1,2)) as res_type from dummy) res
                  on 1=1
              ) all_type 
             on 1=1
         where ( (all_type.source = 2 and all_type.res_type = 0 ) or --全选
                (all_type.source = dwejobcandidate.source and all_type.res_type = 0 ) or --顾问或系统，简历全选
                (all_type.source = 2 and all_type.res_type = dwejobcandidate.res_type) or --推荐全选,白领或精英
                (all_type.source = dwejobcandidate.source and all_type.res_type = dwejobcandidate.res_type) --顾问或系统，白领或精英
              )
            and dwejobcandidate.p_date = '$date$'
            and substr(regexp_replace(dwejobcandidate.createtime,'-',''),1,8) between concat(substr('$date$',1,6),'01') and '$date$'
            and dwejobcandidate.source in (0,4)
          group by dwejobcandidate.recmd_rps_id, dwejobcandidate.recmd_org_id,all_type.source,all_type.res_type

        ) fact1
        on fact0.serviceuser_id = fact1.serviceuser_id
        and fact0.org_id = fact1.org_id
        and fact0.source = fact1.source
        and fact0.res_type = fact1.res_type
        full join 
        (
          select
              dwejobcandidate.recmd_rps_id as serviceuser_id,
              dwejobcandidate.recmd_org_id as org_id,
              all_type.source,all_type.res_type,  
              sum(case when substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) = $date$ and dwejobcandidate.feedback = 4 then 1 else 0 end) as satisfied_download_num,
              sum(case when substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) = $date$ and dwejobcandidate.feedback in (2,5) then 1 else 0 end) as satisfied_intention_num,
              sum(case when substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) = $date$ and dwejobcandidate.feedback in (9,6) then 1 else 0 end) as unsatisfied_num,
              sum(case when dwejobcandidate.feedback = 4 then 1 else 0 end) as mtd_satisfied_download_num,
              sum(case when dwejobcandidate.feedback in (2,5) then 1 else 0 end) as mtd_satisfied_intention_num,
              sum(case when dwejobcandidate.feedback in (9,6) then 1 else 0 end) as mtd_unsatisfied_num
              from 
              dw_erp_d_ejob_candidate dwejobcandidate
            join (
                    select source,res_type
                    from (select explode(array(0,2,4)) as source from dummy) source
                    join (select explode(array(0,1,2)) as res_type from dummy) res
                    on 1=1
            ) all_type 
            on 1=1
            where ( (all_type.source = 2 and all_type.res_type = 0) or --全选
                    (all_type.source = dwejobcandidate.source and all_type.res_type = 0) or --顾问或系统，简历全选
                    (all_type.source = 2 and all_type.res_type = dwejobcandidate.res_type) or --推荐全选,白领或精英
                    (all_type.source = dwejobcandidate.source and all_type.res_type = dwejobcandidate.res_type) --顾问或系统，白领或精英
                  )
            and dwejobcandidate.p_date = $date$
            and substr(regexp_replace(dwejobcandidate.handletime,'-',''),1,8) between concat(substr($date$,1,6),'01') and $date$ 
            and dwejobcandidate.source in (0,4)              
            group by dwejobcandidate.recmd_rps_id,dwejobcandidate.recmd_org_id,all_type.source,all_type.res_type
        ) fact2
        on fact0.serviceuser_id = fact2.serviceuser_id
        and fact0.org_id = fact2.org_id
        and fact0.source = fact2.source
        and fact0.res_type = fact2.res_type 
        group by 
          coalesce(fact0.serviceuser_id,fact1.serviceuser_id,fact2.serviceuser_id),
          coalesce(fact0.org_id,fact1.org_id,fact2.org_id),
          coalesce(fact0.source,fact1.source,fact2.source),
          coalesce(fact0.res_type,fact1.res_type,fact2.res_type)
     ) cand_fact 
    left join dw_erp_d_salesuser_base salesuserbase on salesuserbase.id = cand_fact.serviceuser_id and salesuserbase.p_date = $date$
    left join dim_org gcdcorg on gcdcorg.d_org_id = cand_fact.org_id 
    where nvl(cand_fact.serviceuser_id,-1) not in (0,-1);