insert overwrite table dw_c_d_res_base partition (p_date = $date$)
select 
ifempty( cast(res_user.res_id as int), -1) as res_id, 
ifempty( cast(res_user.user_id as int), -1) as user_id,
ifempty( res_user.res_caption, '-1') as res_caption,
ifempty( res_user.res_lockflag, '-1') as res_lockflag,
ifempty( res_user.res_langkind, '-1') as res_langkind,
ifempty( res_user.res_format, '-1') as res_format,
ifempty( res_user.res_source, '-1') as res_source,
ifempty( res_user.res_category, '-1') as res_category,
ifempty( res_user.createtime, '1900-01-01 00:00:00') as res_createtime,
ifempty( res_user.modifiedtime, '1900-01-01 00:00:01') as res_modifiedtime,
ifempty( case when substr(res_user.res_audittime,1,10) >= '2014-03-01' then  res_user.res_audittime else '2014-03-01 00:00:00' end, '1900-01-01 00:00:01') as res_audittime,
ifempty( case when substr(res_user.res_audittime,1,10)<'2014-03-01' then  res_user.res_audittime else '2014-02-28 23:59:59' end, '1900-01-01 00:00:02') as res_biz_audittime,
ifempty( res_user.default_flag, '-1') as res_default_flag,
ifempty( res_user.res_level, -1) as res_level,
ifempty( res_user.res_bgcheck, '-1') as res_bgcheck,
ifempty( res_user.res_type, '-1') as res_type,
ifempty( res_user.res_kind, '-1') as res_kind,
ifempty( ri.integrity_flag, '00000000') as res_integrity_flag,
ifempty( CALC_RES_COMPLETE_RATE(ifempty(cuser.integrity_flag,'0000000000'),ifempty(ri.integrity_flag,'0000000000')),-1) as integrity_flag,
ifempty( cuser.integrity_flag ,'00000000') as user_integrity_flag,
ifempty( cuser.createtime, '1900-01-01 00:00:00') as c_createtime,
ifempty( cuser.c_kind, '-1') as c_kind,
ifempty( nvl(cuser.c_industry,rp.res_industry), '999') as c_industry,
ifempty( nvl(cuser.c_jobtitle,rp.res_jobtitle), '999') as c_jobtitle,
ifempty( nvl(cuser.c_workyear,rp.res_workyear), 1900) as c_workyear,
ifempty( nvl(cuser.c_title,rp.res_title), '未知') as c_title,
ifempty( nvl(cuser.c_company,rp.res_company), '未知') as c_company,
ifempty( nvl(cuser.c_dq,rp.res_dq), '999') as c_dq,
ifempty( nvl(cuser.c_sex,rp.res_sex), '-1') as c_sex,
ifempty( nvl(cuser.c_edulevel,rp.res_edulevel), '-1') as c_edulevel,
ifempty( nvl(cuser.c_edulevel_tz,rp.res_edulevel_tz), '-1') as c_edulevel_tz,
ifempty( nvl(cuser.c_birth_year,string(rp.res_birth_year)), '1900') as c_birth_year,
ifempty( nvl(cuser.c_marriage,rp.res_marriage), '-1') as c_marriage,
ifempty( nvl(cuser.c_nowsalary,rp.res_nowsalary),-1 ) as c_nowsalary,
ifempty( nvl(cuser.c_salmonths,rp.res_salmonths),-1 ) as c_salmonths,
ifempty( nvl(cuser.c_hope,rp.res_hope), '-1') as c_hope,
ifempty( cuser.c_namecardflag, '-1') as c_namecardflag,
ifempty( cuser.c_telcheckflag, '-1') as c_telcheckflag,
ifempty( cuser.c_emailcheckflag, '-1') as c_emailcheckflag,
ifempty( nvl(cuser.c_school_kind,rp.res_school_kind), '-1') as c_school_kind,
ifempty( nvl(cuser.c_company_kind,rp.res_company_kind), '-1') as c_company_kind,
ifempty( nvl(cuser.c_household,rp.res_household), '未知') as c_household,
ifempty( nvl(cuser.c_nationality,rp.res_nationality), '未知') as c_nationality,
ifempty( cuser.reg_device, '-1') as reg_device,
ifempty( cuser.reg_mscid, '99999999') as reg_mscid,
ifempty( cuser.reg_plan, '-1') as reg_plan,
ifempty( cuser.reg_unit, '-1') as reg_unit,
ifempty( cuser.reg_keyword, '-1') as reg_keyword,
ifempty( nvl(cuser.want_monthsalary,rp.res_wantsalary), -1) as want_monthsalary,
ifempty( nvl(cuser.want_salmonths,rp.res_want_salmonths), -1) as want_salmonths,
ifempty( nvl(cuser.want_industry,rp.res_wantindustry), '999') as want_industry,
ifempty( nvl(cuser.want_industry_first,rp.res_wantindustry), '999') as want_industry_first,
ifempty( nvl(cuser.want_jobtitle,rp.res_wantjobtitle), '999') as want_jobtitle,
ifempty( nvl(cuser.want_jobtitle_first,rp.res_wantjobtitle), '999') as want_jobtitle_first,
ifempty( nvl(cuser.want_dq,rp.res_wantdq), '999') as want_dq,
ifempty( nvl(cuser.want_dq_first,rp.res_wantdq), '999') as want_dq_first,
ifempty( nvl(cuser.want_venture_company,rp.res_want_venture_company), '-1') as want_venture_company,
ifempty( cuser.secret_openwho, '1') as secret_openwho,
ifempty( cuser.secret_name, '-1') as secret_name,
ifempty( cuser.secret_yearsalary, '-1') as secret_yearsalary,
ifempty( cuser.secret_contactway, '-1') as secret_contactway,
ifempty( cuser.secret_e_shield, '-1') as secret_e_shield,
ifempty( cuser.secret_keys, '未知') as secret_keys,
ifempty( cuser.secret_contactflag, '-1') as secret_contactflag,
ifempty( cuser.secret_contactmemo, '-1') as secret_contactmemo,
ifempty( cuser.secret_wantsalary, '-1') as secret_wantsalary,
ifempty( cuser.secret_sns, '-1') as secret_sns,
ifempty( cuser.secret_sns2, '-1') as secret_sns2,
ifempty( cuser.secret_card, '-1') as secret_card,
from_unixtime(unix_timestamp()),
ifempty( cuser.modifiedtime,'1900-01-01 00:00:00' ) as c_modifiedtime,
case when fw.res_id is not null then 1 else 0 end as is_have_foreign_work,
ifempty( res_refresh.refresh_time,'1900-01-01 00:00:00' ) as refresh_time,
ifempty( cuser.last_login_date,'1900-01-01 00:00:00' ) as last_login_date,
case when res_user.res_source in (3,4,12,13) then 1 else 0 end as is_crawler_cv
from 
(select  res_id,user_id,res_caption,res_lockflag,res_langkind,res_format,res_source,res_category,createtime,modifiedtime,res_audittime,default_flag,res_level,res_bgcheck,res_type,res_kind
   from  res_user 
   where delflag = '0'
    and res_source <> '5'
)  res_user
left outer join dw_c_d_user_base cuser
on res_user.user_id = cuser.user_id
and cuser.p_date = '$date$'
left outer join res_integrity ri 
ON res_user.res_id = ri.res_id
left outer join 
(select res_id
   from dw_c_a_res_workexperience_sorted
   where is_foreign_work = 1
   group by res_id) fw
on res_user.res_id =fw.res_id 
left outer join res_refresh 
on res_user.res_id = res_refresh.res_id
left outer join res_profile rp 
on res_user.res_id = rp.res_id;







insert overwrite table dw_c_d_res_base partition (p_date)
select 
ifempty( cast(res_user.res_id as int), -1) as res_id, 
ifempty( cast(res_user.user_id as int), -1) as user_id,
ifempty( res_user.res_caption, '-1') as res_caption,
ifempty( res_user.res_lockflag, '-1') as res_lockflag,
ifempty( res_user.res_langkind, '-1') as res_langkind,
ifempty( res_user.res_format, '-1') as res_format,
ifempty( res_user.res_source, '-1') as res_source,
ifempty( res_user.res_category, '-1') as res_category,
ifempty( res_user.createtime, '1900-01-01 00:00:00') as res_createtime,
ifempty( res_user.modifiedtime, '1900-01-01 00:00:01') as res_modifiedtime,
ifempty( case when substr(res_user.res_audittime,1,10) >= '2014-03-01' then  res_user.res_audittime else '2014-03-01 00:00:00' end, '1900-01-01 00:00:01') as res_audittime,
ifempty( case when substr(res_user.res_audittime,1,10)<'2014-03-01' then  res_user.res_audittime else '2014-02-28 23:59:59' end, '1900-01-01 00:00:02') as res_biz_audittime,
ifempty( res_user.default_flag, '-1') as res_default_flag,
ifempty( res_user.res_level, -1) as res_level,
ifempty( res_user.res_bgcheck, '-1') as res_bgcheck,
ifempty( res_user.res_type, '-1') as res_type,
ifempty( res_user.res_kind, '-1') as res_kind,
ifempty( ri.integrity_flag, '00000000') as res_integrity_flag,
ifempty( CALC_RES_COMPLETE_RATE(ifempty(cuser.integrity_flag,'0000000000'),ifempty(ri.integrity_flag,'0000000000')),-1) as integrity_flag,
ifempty( cuser.integrity_flag ,'00000000') as user_integrity_flag,
ifempty( cuser.createtime, '1900-01-01 00:00:00') as c_createtime,
ifempty( cuser.c_kind, '-1') as c_kind,
ifempty( nvl(cuser.c_industry,rp.res_industry), '999') as c_industry,
ifempty( nvl(cuser.c_jobtitle,rp.res_jobtitle), '999') as c_jobtitle,
ifempty( nvl(cuser.c_workyear,rp.res_workyear), 1900) as c_workyear,
ifempty( nvl(cuser.c_title,rp.res_title), '未知') as c_title,
ifempty( nvl(cuser.c_company,rp.res_company), '未知') as c_company,
ifempty( nvl(cuser.c_dq,rp.res_dq), '999') as c_dq,
ifempty( nvl(cuser.c_sex,rp.res_sex), '-1') as c_sex,
ifempty( nvl(cuser.c_edulevel,rp.res_edulevel), '-1') as c_edulevel,
ifempty( nvl(cuser.c_edulevel_tz,rp.res_edulevel_tz), '-1') as c_edulevel_tz,
ifempty( nvl(cuser.c_birth_year,string(rp.res_birth_year)), '1900') as c_birth_year,
ifempty( nvl(cuser.c_marriage,rp.res_marriage), '-1') as c_marriage,
ifempty( nvl(cuser.c_nowsalary,rp.res_nowsalary),-1 ) as c_nowsalary,
ifempty( nvl(cuser.c_salmonths,rp.res_salmonths),-1 ) as c_salmonths,
ifempty( nvl(cuser.c_hope,rp.res_hope), '-1') as c_hope,
ifempty( cuser.c_namecardflag, '-1') as c_namecardflag,
ifempty( cuser.c_telcheckflag, '-1') as c_telcheckflag,
ifempty( cuser.c_emailcheckflag, '-1') as c_emailcheckflag,
ifempty( nvl(cuser.c_school_kind,rp.res_school_kind), '-1') as c_school_kind,
ifempty( nvl(cuser.c_company_kind,rp.res_company_kind), '-1') as c_company_kind,
ifempty( nvl(cuser.c_household,rp.res_household), '未知') as c_household,
ifempty( nvl(cuser.c_nationality,rp.res_nationality), '未知') as c_nationality,
ifempty( cuser.reg_device, '-1') as reg_device,
ifempty( cuser.reg_mscid, '99999999') as reg_mscid,
ifempty( cuser.reg_plan, '-1') as reg_plan,
ifempty( cuser.reg_unit, '-1') as reg_unit,
ifempty( cuser.reg_keyword, '-1') as reg_keyword,
ifempty( nvl(cuser.want_monthsalary,rp.res_wantsalary), -1) as want_monthsalary,
ifempty( nvl(cuser.want_salmonths,rp.res_want_salmonths), -1) as want_salmonths,
ifempty( nvl(cuser.want_industry,rp.res_wantindustry), '999') as want_industry,
ifempty( nvl(cuser.want_industry_first,rp.res_wantindustry), '999') as want_industry_first,
ifempty( nvl(cuser.want_jobtitle,rp.res_wantjobtitle), '999') as want_jobtitle,
ifempty( nvl(cuser.want_jobtitle_first,rp.res_wantjobtitle), '999') as want_jobtitle_first,
ifempty( nvl(cuser.want_dq,rp.res_wantdq), '999') as want_dq,
ifempty( nvl(cuser.want_dq_first,rp.res_wantdq), '999') as want_dq_first,
ifempty( nvl(cuser.want_venture_company,rp.res_want_venture_company), '-1') as want_venture_company,
ifempty( cuser.secret_openwho, '1') as secret_openwho,
ifempty( cuser.secret_name, '-1') as secret_name,
ifempty( cuser.secret_yearsalary, '-1') as secret_yearsalary,
ifempty( cuser.secret_contactway, '-1') as secret_contactway,
ifempty( cuser.secret_e_shield, '-1') as secret_e_shield,
ifempty( cuser.secret_keys, '未知') as secret_keys,
ifempty( cuser.secret_contactflag, '-1') as secret_contactflag,
ifempty( cuser.secret_contactmemo, '-1') as secret_contactmemo,
ifempty( cuser.secret_wantsalary, '-1') as secret_wantsalary,
ifempty( cuser.secret_sns, '-1') as secret_sns,
ifempty( cuser.secret_sns2, '-1') as secret_sns2,
ifempty( cuser.secret_card, '-1') as secret_card,
from_unixtime(unix_timestamp()),
ifempty( cuser.modifiedtime,'1900-01-01 00:00:00' ) as c_modifiedtime,
case when fw.res_id is not null then 1 else 0 end as is_have_foreign_work,
ifempty( res_refresh.refresh_time,'1900-01-01 00:00:00' ) as refresh_time,
ifempty( cuser.last_login_date,'1900-01-01 00:00:00' ) as last_login_date,
case when res_user.res_source in (3,4,12,13) then 1 else 0 end as is_crawler_cv,
res_user.p_date
from 
(select  res_id,user_id,res_caption,res_lockflag,res_langkind,res_format,res_source,res_category,createtime,modifiedtime,res_audittime,default_flag,res_level,res_bgcheck,res_type,res_kind,p_date
   from  recovery.res_user_history_20170301_20170425 
   where delflag = '0'
    and res_source <> '5'
)  res_user
left outer join dw_c_d_user_base cuser
on res_user.user_id = cuser.user_id
and cuser.p_date = res_user.p_date
and cuser.p_date between {{start_date}} and {{end_date}}
left outer join recovery.res_integrity_history_20170301_20170425 ri 
ON res_user.res_id = ri.res_id
and res_user.p_date = ri.p_date
left outer join 
(select res_id
   from dw_c_a_res_workexperience_sorted
   where is_foreign_work = 1
   group by res_id) fw
on res_user.res_id =fw.res_id 
left outer join recovery.res_refresh_history_20170301_20170425 as  res_refresh
on res_user.res_id = res_refresh.res_id
and res_user.p_date = res_refresh.p_date
left outer join recovery.res_profile_history_20170301_20170425 rp 
on res_user.res_id = rp.res_id
and res_user.p_date = rp.p_date
where res_user.p_date between {{start_date}} and {{end_date}}