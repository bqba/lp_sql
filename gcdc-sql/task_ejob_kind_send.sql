--task_ejob_kind_send
select  dim_org.branch_name,
        cand.serviceuser_id,
        cand.serviceuser_name,
        cand.org_name,
        suser.position_level_name,
        count(distinct case when ejob.kind = 1 then ejob.ejob_id else null end) as bole_mtd_recommend_ejob_num,
        count(case when ejob.kind = 1 then cand.res_id else null end) as bole_mtd_recommend_resume_num,
        count(case when ejob.kind = 1 and cand.feedback <> 1 and substr(regexp_replace(cand.handletime,'-',''),1,6) = '201611' then cand.res_id else null end) as bole_mtd_recommend_deal_num,
         count(distinct case when ejob.kind = 8 then ejob.ejob_id else null end) as all_mtd_recommend_ejob_num,
        count(case when ejob.kind = 8 then cand.res_id else null end) as all_mtd_recommend_resume_num,
        count(case when ejob.kind = 8 and cand.feedback <> 1 and substr(regexp_replace(cand.handletime,'-',''),1,6) = '201611' then cand.res_id else null end) as all_mtd_recommend_deal_num,
                count(distinct case when ejob.kind = 9 then ejob.ejob_id else null end) as rps_mtd_recommend_ejob_num,
        count(case when ejob.kind = 9 then cand.res_id else null end) as rps_mtd_recommend_resume_num,
        count(case when ejob.kind = 9 and cand.feedback <> 1 and substr(regexp_replace(cand.handletime,'-',''),1,6) = '201611' then cand.res_id else null end) as rps_mtd_recommend_deal_num      
 from 
      dw_erp_d_ejob_candidate cand
      join dw_erp_d_ejob ejob
      on cand.ejob_id = ejob.ejob_id
      and ejob.p_date = 20161130
      and ejob.kind in (1,8,9)
      join dw_erp_d_salesuser_base suser 
      on suser.id = cand.serviceuser_id
      and suser.p_date = 20161130
      join dim_org 
      on cand.org_id = dim_org.d_org_id
 where cand.p_date = '20161130'
    and substr(regexp_replace(cand.createtime,'-',''),1,8) between concat(substr('20161130',1,6),'01') and '20161130'
  group by dim_org.branch_name,cand.serviceuser_id,cand.serviceuser_name,cand.org_name,suser.position_level_name