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
ifempty( case when substr(res_user.res_audittime,1,4) >= '2014-03-01' then  res_user.res_audittime else '2014-03-01 00:00:00' end, '1900-01-01 00:00:01') as res_audittime,
ifempty( case when substr(res_user.res_audittime,1,4)<'2014-03-01' then  res_user.res_audittime else '2014-02-28 23:59:59' end, '1900-01-01 00:00:02') as res_biz_audittime,
ifempty( res_user.default_flag, '-1') as res_default_flag,
ifempty( res_user.res_level, -1) as res_level,
ifempty( res_user.res_bgcheck, '-1') as res_bgcheck,
ifempty( res_user.res_type, '-1') as res_type,
ifempty( res_user.res_kind, '-1') as res_kind,
ifempty( ri.integrity_flag, '00000000') as res_integrity_flag,
ifempty( calc_res_complete_rate(ifempty(cuser.integrity_flag,'0000000000'),ifempty(ri.integrity_flag,'0000000000')),-1) as integrity_flag,
ifempty( cuser.integrity_flag ,'00000000') as user_integrity_flag,
ifempty( cuser.createtime, '1900-01-01 00:00:00') as c_createtime,
ifempty( cuser.c_kind, '-1') as c_kind,
ifempty( cuser.c_industry, '999') as c_industry,
ifempty( cuser.c_jobtitle, '999') as c_jobtitle,
ifempty( cuser.c_workyear, 1900) as c_workyear,
ifempty( cuser.c_title, '未知') as c_title,
ifempty( cuser.c_company, '未知') as c_company,
ifempty( cuser.c_dq, '999') as c_dq,
ifempty( cuser.c_sex, '-1') as c_sex,
ifempty( cuser.c_edulevel, '-1') as c_edulevel,
ifempty( cuser.c_edulevel_tz, '-1') as c_edulevel_tz,
ifempty( cuser.c_birth_year, '1900') as c_birth_year,
ifempty( cuser.c_marriage, '-1') as c_marriage,
ifempty( cuser.c_nowsalary,-1 ) as c_nowsalary,
ifempty( cuser.c_salmonths,-1 ) as c_salmonths,
ifempty( cuser.c_hope, '-1') as c_hope,
ifempty( cuser.c_namecardflag, '-1') as c_namecardflag,
ifempty( cuser.c_telcheckflag, '-1') as c_telcheckflag,
ifempty( cuser.c_emailcheckflag, '-1') as c_emailcheckflag,
ifempty( cuser.c_school_kind, '-1') as c_school_kind,
ifempty( cuser.c_company_kind, '-1') as c_company_kind,
ifempty( cuser.c_household, '未知') as c_household,
ifempty( cuser.c_nationality, '未知') as c_nationality,
ifempty( cuser.reg_device, '-1') as reg_device,
ifempty( cuser.reg_mscid, '99999999') as reg_mscid,
ifempty( cuser.reg_plan, '-1') as reg_plan,
ifempty( cuser.reg_unit, '-1') as reg_unit,
ifempty( cuser.reg_keyword, '-1') as reg_keyword, 
ifempty( cuser.want_monthsalary, -1) as want_monthsalary,
ifempty( cuser.want_salmonths, -1) as want_salmonths,
ifempty( cuser.want_industry, '999') as want_industry,
ifempty( cuser.want_industry_first, '999') as want_industry_first,
ifempty( cuser.want_jobtitle, '999') as want_jobtitle,
ifempty( cuser.want_jobtitle_first, '999') as want_jobtitle_first,
ifempty( cuser.want_dq, '999') as want_dq,
ifempty( cuser.want_dq_first, '999') as want_dq_first,
ifempty( cuser.want_venture_company, '-1') as want_venture_company,
ifempty( cuser.secret_openwho, '-1') as secret_openwho,
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
res_user.p_date
from 
(select  res_id,user_id,res_caption,res_lockflag,res_langkind,res_format,res_source,res_category,createtime,modifiedtime,res_audittime,default_flag,res_level,res_bgcheck,res_type,res_kind,p_date
   from  recovery.res_user_history_20160401_20160430  --res_user_history_20160410_20160705 
   where delflag = '0'
		and user_id <> 0 
		and res_source <> '5'
	    and p_date between 20160401 and 20160415
) res_user
join 
(select  c_kind,c_industry,c_jobtitle,c_workyear,c_title,c_company,c_dq,c_sex,c_edulevel,c_birth_year,c_marriage,c_nowsalary,c_salmonths,c_hope,c_namecardflag,c_telcheckflag,c_emailcheckflag,c_school_kind,c_company_kind,c_household,c_nationality,reg_device,reg_mscid,reg_plan,reg_unit,reg_keyword,want_monthsalary,want_salmonths,want_industry,want_industry_first,want_jobtitle,want_jobtitle_first,want_dq,want_dq_first,want_venture_company,secret_openwho,secret_name,secret_yearsalary,secret_contactway,secret_e_shield,secret_keys,secret_contactflag,secret_contactmemo,secret_wantsalary,secret_sns,secret_sns2,secret_card,p_date,user_id,integrity_flag,createtime,c_edulevel_tz
	from dw_c_d_user_base 
   where p_date between 20160401 and 20160415
 ) cuser
on res_user.user_id = cuser.user_id
and res_user.p_date = cuser.p_date
left outer join 
(select integrity_flag,res_id,p_date
   from recovery.res_integrity_history_20160401_20160430 
  where p_date between 20160401 and 20160415) ri 
on res_user.res_id = ri.res_id
and res_user.p_date = ri.p_date
;

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
ifempty( case when substr(res_user.res_audittime,1,4) >= '2014-03-01' then  res_user.res_audittime else '2014-03-01 00:00:00' end, '1900-01-01 00:00:01') as res_audittime,
ifempty( case when substr(res_user.res_audittime,1,4)<'2014-03-01' then  res_user.res_audittime else '2014-02-28 23:59:59' end, '1900-01-01 00:00:02') as res_biz_audittime,
ifempty( res_user.default_flag, '-1') as res_default_flag,
ifempty( res_user.res_level, -1) as res_level,
ifempty( res_user.res_bgcheck, '-1') as res_bgcheck,
ifempty( res_user.res_type, '-1') as res_type,
ifempty( res_user.res_kind, '-1') as res_kind,
ifempty( ri.integrity_flag, '00000000') as res_integrity_flag,
ifempty( calc_res_complete_rate(ifempty(cuser.integrity_flag,'0000000000'),ifempty(ri.integrity_flag,'0000000000')),-1) as integrity_flag,
ifempty( cuser.integrity_flag ,'00000000') as user_integrity_flag,
ifempty( cuser.createtime, '1900-01-01 00:00:00') as c_createtime,
ifempty( cuser.c_kind, '-1') as c_kind,
ifempty( cuser.c_industry, '999') as c_industry,
ifempty( cuser.c_jobtitle, '999') as c_jobtitle,
ifempty( cuser.c_workyear, 1900) as c_workyear,
ifempty( cuser.c_title, '未知') as c_title,
ifempty( cuser.c_company, '未知') as c_company,
ifempty( cuser.c_dq, '999') as c_dq,
ifempty( cuser.c_sex, '-1') as c_sex,
ifempty( cuser.c_edulevel, '-1') as c_edulevel,
ifempty( cuser.c_edulevel_tz, '-1') as c_edulevel_tz,
ifempty( cuser.c_birth_year, '1900') as c_birth_year,
ifempty( cuser.c_marriage, '-1') as c_marriage,
ifempty( cuser.c_nowsalary,-1 ) as c_nowsalary,
ifempty( cuser.c_salmonths,-1 ) as c_salmonths,
ifempty( cuser.c_hope, '-1') as c_hope,
ifempty( cuser.c_namecardflag, '-1') as c_namecardflag,
ifempty( cuser.c_telcheckflag, '-1') as c_telcheckflag,
ifempty( cuser.c_emailcheckflag, '-1') as c_emailcheckflag,
ifempty( cuser.c_school_kind, '-1') as c_school_kind,
ifempty( cuser.c_company_kind, '-1') as c_company_kind,
ifempty( cuser.c_household, '未知') as c_household,
ifempty( cuser.c_nationality, '未知') as c_nationality,
ifempty( cuser.reg_device, '-1') as reg_device,
ifempty( cuser.reg_mscid, '99999999') as reg_mscid,
ifempty( cuser.reg_plan, '-1') as reg_plan,
ifempty( cuser.reg_unit, '-1') as reg_unit,
ifempty( cuser.reg_keyword, '-1') as reg_keyword, 
ifempty( cuser.want_monthsalary, -1) as want_monthsalary,
ifempty( cuser.want_salmonths, -1) as want_salmonths,
ifempty( cuser.want_industry, '999') as want_industry,
ifempty( cuser.want_industry_first, '999') as want_industry_first,
ifempty( cuser.want_jobtitle, '999') as want_jobtitle,
ifempty( cuser.want_jobtitle_first, '999') as want_jobtitle_first,
ifempty( cuser.want_dq, '999') as want_dq,
ifempty( cuser.want_dq_first, '999') as want_dq_first,
ifempty( cuser.want_venture_company, '-1') as want_venture_company,
ifempty( cuser.secret_openwho, '-1') as secret_openwho,
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
res_user.p_date
from 
(select  res_id,user_id,res_caption,res_lockflag,res_langkind,res_format,res_source,res_category,createtime,modifiedtime,res_audittime,default_flag,res_level,res_bgcheck,res_type,res_kind,p_date
   from  recovery.res_user_history_20160401_20160430  --res_user_history_20160410_20160705 
   where delflag = '0'
    and user_id <> 0 
    and res_source <> '5'
      and p_date between 20160416 and 20160430
) res_user
join 
(select  c_kind,c_industry,c_jobtitle,c_workyear,c_title,c_company,c_dq,c_sex,c_edulevel,c_birth_year,c_marriage,c_nowsalary,c_salmonths,c_hope,c_namecardflag,c_telcheckflag,c_emailcheckflag,c_school_kind,c_company_kind,c_household,c_nationality,reg_device,reg_mscid,reg_plan,reg_unit,reg_keyword,want_monthsalary,want_salmonths,want_industry,want_industry_first,want_jobtitle,want_jobtitle_first,want_dq,want_dq_first,want_venture_company,secret_openwho,secret_name,secret_yearsalary,secret_contactway,secret_e_shield,secret_keys,secret_contactflag,secret_contactmemo,secret_wantsalary,secret_sns,secret_sns2,secret_card,p_date,user_id,integrity_flag,createtime,c_edulevel_tz
  from dw_c_d_user_base 
   where p_date between 20160416 and 20160430
 ) cuser
on res_user.user_id = cuser.user_id
and res_user.p_date = cuser.p_date
left outer join 
(select integrity_flag,res_id,p_date
   from recovery.res_integrity_history_20160401_20160430 
  where p_date between 20160416 and 20160430) ri 
on res_user.res_id = ri.res_id
and res_user.p_date = ri.p_date
;



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
ifempty( case when substr(res_user.res_audittime,1,4) >= '2014-03-01' then  res_user.res_audittime else '2014-03-01 00:00:00' end, '1900-01-01 00:00:01') as res_audittime,
ifempty( case when substr(res_user.res_audittime,1,4)<'2014-03-01' then  res_user.res_audittime else '2014-02-28 23:59:59' end, '1900-01-01 00:00:02') as res_biz_audittime,
ifempty( res_user.default_flag, '-1') as res_default_flag,
ifempty( res_user.res_level, -1) as res_level,
ifempty( res_user.res_bgcheck, '-1') as res_bgcheck,
ifempty( res_user.res_type, '-1') as res_type,
ifempty( res_user.res_kind, '-1') as res_kind,
ifempty( ri.integrity_flag, '00000000') as res_integrity_flag,
ifempty( calc_res_complete_rate(ifempty(cuser.integrity_flag,'0000000000'),ifempty(ri.integrity_flag,'0000000000')),-1) as integrity_flag,
ifempty( cuser.integrity_flag ,'00000000') as user_integrity_flag,
ifempty( cuser.createtime, '1900-01-01 00:00:00') as c_createtime,
ifempty( cuser.c_kind, '-1') as c_kind,
ifempty( cuser.c_industry, '999') as c_industry,
ifempty( cuser.c_jobtitle, '999') as c_jobtitle,
ifempty( cuser.c_workyear, 1900) as c_workyear,
ifempty( cuser.c_title, '未知') as c_title,
ifempty( cuser.c_company, '未知') as c_company,
ifempty( cuser.c_dq, '999') as c_dq,
ifempty( cuser.c_sex, '-1') as c_sex,
ifempty( cuser.c_edulevel, '-1') as c_edulevel,
ifempty( cuser.c_edulevel_tz, '-1') as c_edulevel_tz,
ifempty( cuser.c_birth_year, '1900') as c_birth_year,
ifempty( cuser.c_marriage, '-1') as c_marriage,
ifempty( cuser.c_nowsalary,-1 ) as c_nowsalary,
ifempty( cuser.c_salmonths,-1 ) as c_salmonths,
ifempty( cuser.c_hope, '-1') as c_hope,
ifempty( cuser.c_namecardflag, '-1') as c_namecardflag,
ifempty( cuser.c_telcheckflag, '-1') as c_telcheckflag,
ifempty( cuser.c_emailcheckflag, '-1') as c_emailcheckflag,
ifempty( cuser.c_school_kind, '-1') as c_school_kind,
ifempty( cuser.c_company_kind, '-1') as c_company_kind,
ifempty( cuser.c_household, '未知') as c_household,
ifempty( cuser.c_nationality, '未知') as c_nationality,
ifempty( cuser.reg_device, '-1') as reg_device,
ifempty( cuser.reg_mscid, '99999999') as reg_mscid,
ifempty( cuser.reg_plan, '-1') as reg_plan,
ifempty( cuser.reg_unit, '-1') as reg_unit,
ifempty( cuser.reg_keyword, '-1') as reg_keyword, 
ifempty( cuser.want_monthsalary, -1) as want_monthsalary,
ifempty( cuser.want_salmonths, -1) as want_salmonths,
ifempty( cuser.want_industry, '999') as want_industry,
ifempty( cuser.want_industry_first, '999') as want_industry_first,
ifempty( cuser.want_jobtitle, '999') as want_jobtitle,
ifempty( cuser.want_jobtitle_first, '999') as want_jobtitle_first,
ifempty( cuser.want_dq, '999') as want_dq,
ifempty( cuser.want_dq_first, '999') as want_dq_first,
ifempty( cuser.want_venture_company, '-1') as want_venture_company,
ifempty( cuser.secret_openwho, '-1') as secret_openwho,
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
res_user.p_date
from 
(select  res_id,user_id,res_caption,res_lockflag,res_langkind,res_format,res_source,res_category,createtime,modifiedtime,res_audittime,default_flag,res_level,res_bgcheck,res_type,res_kind,p_date
   from  recovery.res_user_history_20151218_20160715  --res_user_history_20160410_20160705 
   where delflag = '0'
		and user_id <> 0 
		and res_source <> '5'
	    and p_date between 20160316 and 20160331
) res_user
join 
(select  c_kind,c_industry,c_jobtitle,c_workyear,c_title,c_company,c_dq,c_sex,c_edulevel,c_birth_year,c_marriage,c_nowsalary,c_salmonths,c_hope,c_namecardflag,c_telcheckflag,c_emailcheckflag,c_school_kind,c_company_kind,c_household,c_nationality,reg_device,reg_mscid,reg_plan,reg_unit,reg_keyword,want_monthsalary,want_salmonths,want_industry,want_industry_first,want_jobtitle,want_jobtitle_first,want_dq,want_dq_first,want_venture_company,secret_openwho,secret_name,secret_yearsalary,secret_contactway,secret_e_shield,secret_keys,secret_contactflag,secret_contactmemo,secret_wantsalary,secret_sns,secret_sns2,secret_card,p_date,user_id,integrity_flag,createtime,c_edulevel_tz
	from dw_c_d_user_base 
   where p_date between 20160316 and 20160331
 ) cuser
on res_user.user_id = cuser.user_id
and res_user.p_date = cuser.p_date
left outer join 
(select integrity_flag,res_id,p_date
   from recovery.res_integrity_history_20151218_20160711 
  where p_date between 20160316 and 20160331) ri 
on res_user.res_id = ri.res_id
and res_user.p_date = ri.p_date
;
