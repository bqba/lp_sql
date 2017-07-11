insert overwrite table dw_c_d_user_base partition (p_date)
select
ifempty( cast(web_user.user_id as int), -1) as user_id,
ifempty( web_user.createtime, '1900-01-01 00:00:00') as createtime,
ifempty( user_c.c_kind, '-1') as c_kind,
ifempty( user_c.c_industry, '999') as c_industry,
ifempty( user_c.c_jobtitle, '999') as c_jobtitle,
ifempty( user_c.c_workyear, 1900) as c_workyear,
ifempty( user_c.c_title, '未知') as c_title,
ifempty( user_c.c_company, '未知') as c_company,
ifempty( user_c.c_dq, '999') as c_dq,
regexp_replace(ifempty( user_c.c_sex, '未知'),'9','未知') as c_sex,
ifempty( user_c.c_edulevel, '-1') as c_edulevel,
ifempty( user_c.c_edulevel_tz, '-1') as c_edulevel_tz,
ifempty( user_c.c_birth_year, 1900) as c_birth_year,
ifempty( user_c.c_marriage, '-1') as c_marriage,
ifempty( cast(user_c.c_nowsalary as int), -1) as c_nowsalary,
ifempty( user_c.c_salmonths, -1) as c_salmonths,
ifempty( user_c.c_hope, '-1') as c_hope,
ifempty( user_c.c_namecardflag, '-1') as c_namecardflag,
ifempty( user_c.c_telcheckflag, '-1') as c_telcheckflag,
ifempty( user_c.c_emailcheckflag, '-1') as c_emailcheckflag,
ifempty( user_c.c_school_kind, '-1') as c_school_kind,
ifempty( user_c.c_company_kind, '-1') as c_company_kind,
ifempty( user_c.c_household, '未知') as c_household,
ifempty( user_c.c_nationality, '未知') as c_nationality,
ifempty( user_register.reg_device, '-1') as reg_device,
ifempty( user_register.reg_mscid, '99999999') as reg_mscid,
ifempty( user_register.reg_plan, '-1') as reg_plan,
ifempty( user_register.reg_unit ,'-1') as reg_unit,
ifempty( user_register.reg_keyword ,'-1') as reg_keyword,
ifempty( user_c_want.want_monthsalary, -1) as want_monthsalary,
ifempty( user_c_want.want_salmonths, -1) as want_salmonths,
ifempty( user_c_want.want_industry, '999') as want_industry,
ifempty( get_first_code(user_c_want.want_industry, ','), '999') as want_industry_first,
ifempty( user_c_want.want_jobtitle, '999') as want_jobtitle,
ifempty( get_first_code(user_c_want.want_jobtitle, ','), '999') as want_jobtitle_first,
ifempty( user_c_want.want_dq, '999') as want_dq,
ifempty( get_first_code(user_c_want.want_dq, ','), '999') as want_dq_first,
ifempty( user_c_want.want_venture_company, '-1') as want_venture_company,
ifempty( uci.integrity_flag ,'0000000000') as integrity_flag,
ifempty( user_c_secret.secret_openwho, '-1') as secret_openwho,
ifempty( user_c_secret.secret_name, '-1') as secret_name,
ifempty( user_c_secret.secret_yearsalary, '-1') as secret_yearsalary,
ifempty( user_c_secret.secret_contactway, '-1') as secret_contactway,
ifempty( user_c_secret.secret_e_shield, '-1') as secret_e_shield,
ifempty( user_c_secret.secret_keys, '未知') as secret_keys,
ifempty( user_c_secret.secret_contactflag, '-1') as secret_contactflag,
ifempty( user_c_secret.secret_contactmemo, '-1') as secret_contactmemo,
ifempty( user_c_secret.secret_wantsalary, '-1') as secret_wantsalary,
ifempty( user_c_secret.secret_sns, '-1') as secret_sns,
ifempty( user_c_secret.secret_sns2, '-1') as secret_sns2,
ifempty( user_c_secret.secret_card, '-1') as secret_card, 
from_unixtime(unix_timestamp()),
web_user.p_date
from 
(select user_id,user_kind,createtime,user_status,delflag,p_date
   from web_user_history_20150317_20160705
  where user_kind = '0'
    and delflag = '0'
    and user_status = 1
	and p_date between 20160516 and 20160531
)  web_user
join 
(select c_kind,c_industry,c_jobtitle,c_workyear,c_title,c_company,c_dq,c_sex,c_edulevel,c_edulevel_tz,c_birth_year,c_marriage,c_nowsalary,c_hope,c_namecardflag,c_telcheckflag,c_emailcheckflag,c_majia,c_school_kind,c_household,c_nationality,user_id,c_company_kind,c_salmonths,p_date
  from user_c_history_20160405_20160714 --user_c_history_20160405_20160706
  where c_majia = 0
    and delflag = '0' 
	and p_date between 20160516 and 20160531
) user_c  
 on web_user.user_id = user_c.user_id
 and web_user.p_date = user_c.p_date
left outer join user_register 
on web_user.user_id = user_register.user_id
left outer join 
(
	select  want_monthsalary,want_salmonths,want_dq,want_industry,want_jobtitle,want_venture_company,user_id,p_date
	from user_c_want_history_20150621_20160707  
	where p_date between 20160516 and 20160531
) user_c_want
on web_user.user_id = user_c_want.user_id 
and web_user.p_date = user_c_want.p_date 
left outer join 
(select secret_openwho,secret_name,secret_yearsalary,secret_contactway,secret_e_shield,secret_keys,secret_contactflag,secret_contactmemo,secret_wantsalary,secret_sns,secret_sns2,secret_card,user_id,p_date
	from user_c_secret_history_20150317_20160707
  where  p_date between 20160516 and 20160531)   user_c_secret
 on web_user.user_id = user_c_secret.user_id 
 and web_user.p_date =  user_c_secret.user_id
left outer join 
( select  integrity_flag,user_id,p_date
	from user_c_integrity_history_20150317_20160708 
   where p_date between 20160516 and 20160531
) uci 
on web_user.user_id = uci.user_id 
and web_user.p_date = uci.p_date
;


insert overwrite table dw_c_d_user_base partition (p_date)
select
ifempty( cast(web_user.user_id as int), -1) as user_id,
ifempty( web_user.createtime, '1900-01-01 00:00:00') as createtime,
ifempty( user_c.c_kind, '-1') as c_kind,
ifempty( user_c.c_industry, '999') as c_industry,
ifempty( user_c.c_jobtitle, '999') as c_jobtitle,
ifempty( user_c.c_workyear, 1900) as c_workyear,
ifempty( user_c.c_title, '未知') as c_title,
ifempty( user_c.c_company, '未知') as c_company,
ifempty( user_c.c_dq, '999') as c_dq,
regexp_replace(ifempty( user_c.c_sex, '未知'),'9','未知') as c_sex,
ifempty( user_c.c_edulevel, '-1') as c_edulevel,
ifempty( user_c.c_edulevel_tz, '-1') as c_edulevel_tz,
ifempty( user_c.c_birth_year, 1900) as c_birth_year,
ifempty( user_c.c_marriage, '-1') as c_marriage,
ifempty( cast(user_c.c_nowsalary as int), -1) as c_nowsalary,
ifempty( user_c.c_salmonths, -1) as c_salmonths,
ifempty( user_c.c_hope, '-1') as c_hope,
ifempty( user_c.c_namecardflag, '-1') as c_namecardflag,
ifempty( user_c.c_telcheckflag, '-1') as c_telcheckflag,
ifempty( user_c.c_emailcheckflag, '-1') as c_emailcheckflag,
ifempty( user_c.c_school_kind, '-1') as c_school_kind,
ifempty( user_c.c_company_kind, '-1') as c_company_kind,
ifempty( user_c.c_household, '未知') as c_household,
ifempty( user_c.c_nationality, '未知') as c_nationality,
ifempty( user_register.reg_device, '-1') as reg_device,
ifempty( user_register.reg_mscid, '99999999') as reg_mscid,
ifempty( user_register.reg_plan, '-1') as reg_plan,
ifempty( user_register.reg_unit ,'-1') as reg_unit,
ifempty( user_register.reg_keyword ,'-1') as reg_keyword,
ifempty( user_c_want.want_monthsalary, -1) as want_monthsalary,
ifempty( user_c_want.want_salmonths, -1) as want_salmonths,
ifempty( user_c_want.want_industry, '999') as want_industry,
ifempty( get_first_code(user_c_want.want_industry, ','), '999') as want_industry_first,
ifempty( user_c_want.want_jobtitle, '999') as want_jobtitle,
ifempty( get_first_code(user_c_want.want_jobtitle, ','), '999') as want_jobtitle_first,
ifempty( user_c_want.want_dq, '999') as want_dq,
ifempty( get_first_code(user_c_want.want_dq, ','), '999') as want_dq_first,
ifempty( user_c_want.want_venture_company, '-1') as want_venture_company,
ifempty( uci.integrity_flag ,'0000000000') as integrity_flag,
ifempty( user_c_secret.secret_openwho, '-1') as secret_openwho,
ifempty( user_c_secret.secret_name, '-1') as secret_name,
ifempty( user_c_secret.secret_yearsalary, '-1') as secret_yearsalary,
ifempty( user_c_secret.secret_contactway, '-1') as secret_contactway,
ifempty( user_c_secret.secret_e_shield, '-1') as secret_e_shield,
ifempty( user_c_secret.secret_keys, '未知') as secret_keys,
ifempty( user_c_secret.secret_contactflag, '-1') as secret_contactflag,
ifempty( user_c_secret.secret_contactmemo, '-1') as secret_contactmemo,
ifempty( user_c_secret.secret_wantsalary, '-1') as secret_wantsalary,
ifempty( user_c_secret.secret_sns, '-1') as secret_sns,
ifempty( user_c_secret.secret_sns2, '-1') as secret_sns2,
ifempty( user_c_secret.secret_card, '-1') as secret_card, 
from_unixtime(unix_timestamp()),
web_user.p_date
from 
(select user_id,user_kind,createtime,user_status,delflag,p_date
   from web_user_history_20150317_20160705
  where user_kind = '0'
    and delflag = '0'
    and user_status = 1
	and p_date between 20160516 and 20160531
)  web_user
join 
(select c_kind,c_industry,c_jobtitle,c_workyear,c_title,c_company,c_dq,c_sex,c_edulevel,c_edulevel_tz,c_birth_year,c_marriage,c_nowsalary,c_hope,c_namecardflag,c_telcheckflag,c_emailcheckflag,c_majia,c_school_kind,c_household,c_nationality,user_id,c_company_kind,c_salmonths,p_date
  from user_c_history_20160405_20160714 --user_c_history_20160405_20160706
  where c_majia = 0
    and delflag = '0' 
	and p_date between 20160516 and 20160531
) user_c  
 on web_user.user_id = user_c.user_id
 and web_user.p_date = user_c.p_date
left outer join user_register 
on web_user.user_id = user_register.user_id
left outer join 
(
	select  want_monthsalary,want_salmonths,want_dq,want_industry,want_jobtitle,want_venture_company,user_id,p_date
	from user_c_want_history_20150621_20160707  
	where p_date between 20160516 and 20160531
) user_c_want
on web_user.user_id = user_c_want.user_id 
and web_user.p_date = user_c_want.p_date 
left outer join 
(select secret_openwho,secret_name,secret_yearsalary,secret_contactway,secret_e_shield,secret_keys,secret_contactflag,secret_contactmemo,secret_wantsalary,secret_sns,secret_sns2,secret_card,user_id,p_date
	from user_c_secret_history_20150317_20160707
  where  p_date between 20160516 and 20160531)   user_c_secret
 on web_user.user_id = user_c_secret.user_id 
 and web_user.p_date =  user_c_secret.user_id
left outer join 
( select  integrity_flag,user_id,p_date
	from user_c_integrity_history_20150317_20160708 
   where p_date between 20160516 and 20160531
) uci 
on web_user.user_id = uci.user_id 
and web_user.p_date = uci.p_date
;





insert overwrite table dw_c_d_user_base partition (p_date)
select
ifempty( cast(web_user.user_id as int), -1) as user_id,
ifempty( web_user.createtime, '1900-01-01 00:00:00') as createtime,
ifempty( user_c.c_kind, '-1') as c_kind,
ifempty( user_c.c_industry, '999') as c_industry,
ifempty( user_c.c_jobtitle, '999') as c_jobtitle,
ifempty( user_c.c_workyear, 1900) as c_workyear,
ifempty( user_c.c_title, '未知') as c_title,
ifempty( user_c.c_company, '未知') as c_company,
ifempty( user_c.c_dq, '999') as c_dq,
regexp_replace(ifempty( user_c.c_sex, '未知'),'9','未知') as c_sex,
ifempty( user_c.c_edulevel, '-1') as c_edulevel,
ifempty( user_c.c_edulevel_tz, '-1') as c_edulevel_tz,
ifempty( user_c.c_birth_year, 1900) as c_birth_year,
ifempty( user_c.c_marriage, '-1') as c_marriage,
ifempty( cast(user_c.c_nowsalary as int), -1) as c_nowsalary,
ifempty( user_c.c_salmonths, -1) as c_salmonths,
ifempty( user_c.c_hope, '-1') as c_hope,
ifempty( user_c.c_namecardflag, '-1') as c_namecardflag,
ifempty( user_c.c_telcheckflag, '-1') as c_telcheckflag,
ifempty( user_c.c_emailcheckflag, '-1') as c_emailcheckflag,
ifempty( user_c.c_school_kind, '-1') as c_school_kind,
ifempty( user_c.c_company_kind, '-1') as c_company_kind,
ifempty( user_c.c_household, '未知') as c_household,
ifempty( user_c.c_nationality, '未知') as c_nationality,
ifempty( user_register.reg_device, '-1') as reg_device,
ifempty( user_register.reg_mscid, '99999999') as reg_mscid,
ifempty( user_register.reg_plan, '-1') as reg_plan,
ifempty( user_register.reg_unit ,'-1') as reg_unit,
ifempty( user_register.reg_keyword ,'-1') as reg_keyword,
ifempty( user_c_want.want_monthsalary, -1) as want_monthsalary,
ifempty( user_c_want.want_salmonths, -1) as want_salmonths,
ifempty( user_c_want.want_industry, '999') as want_industry,
ifempty( get_first_code(user_c_want.want_industry, ','), '999') as want_industry_first,
ifempty( user_c_want.want_jobtitle, '999') as want_jobtitle,
ifempty( get_first_code(user_c_want.want_jobtitle, ','), '999') as want_jobtitle_first,
ifempty( user_c_want.want_dq, '999') as want_dq,
ifempty( get_first_code(user_c_want.want_dq, ','), '999') as want_dq_first,
ifempty( user_c_want.want_venture_company, '-1') as want_venture_company,
ifempty( uci.integrity_flag ,'0000000000') as integrity_flag,
ifempty( user_c_secret.secret_openwho, '-1') as secret_openwho,
ifempty( user_c_secret.secret_name, '-1') as secret_name,
ifempty( user_c_secret.secret_yearsalary, '-1') as secret_yearsalary,
ifempty( user_c_secret.secret_contactway, '-1') as secret_contactway,
ifempty( user_c_secret.secret_e_shield, '-1') as secret_e_shield,
ifempty( user_c_secret.secret_keys, '未知') as secret_keys,
ifempty( user_c_secret.secret_contactflag, '-1') as secret_contactflag,
ifempty( user_c_secret.secret_contactmemo, '-1') as secret_contactmemo,
ifempty( user_c_secret.secret_wantsalary, '-1') as secret_wantsalary,
ifempty( user_c_secret.secret_sns, '-1') as secret_sns,
ifempty( user_c_secret.secret_sns2, '-1') as secret_sns2,
ifempty( user_c_secret.secret_card, '-1') as secret_card, 
from_unixtime(unix_timestamp()),
web_user.p_date
from 
(select user_id,user_kind,createtime,user_status,delflag,p_date
   from web_user_history_20150317_20160705
  where user_kind = '0'
    and delflag = '0'
    and user_status = 1
	and p_date between 20160404 and 20160404
)  web_user
join 
(select c_kind,c_industry,c_jobtitle,c_workyear,c_title,c_company,c_dq,c_sex,c_edulevel,c_edulevel_tz,c_birth_year,c_marriage,c_nowsalary,c_hope,c_namecardflag,c_telcheckflag,c_emailcheckflag,c_majia,c_school_kind,c_household,c_nationality,user_id,c_company_kind,c_salmonths,p_date
  from user_c_history_20160404_20160404 --user_c_history_20160405_20160706
  where c_majia = 0
    and delflag = '0' 
	and p_date between 20160404 and 20160404
) user_c  
 on web_user.user_id = user_c.user_id
 and web_user.p_date = user_c.p_date
left outer join user_register 
on web_user.user_id = user_register.user_id
left outer join 
(
	select  want_monthsalary,want_salmonths,want_dq,want_industry,want_jobtitle,want_venture_company,user_id,p_date
	from user_c_want_history_20150621_20160707  
	where p_date between 20160404 and 20160404
) user_c_want
on web_user.user_id = user_c_want.user_id 
and web_user.p_date = user_c_want.p_date 
left outer join 
(select secret_openwho,secret_name,secret_yearsalary,secret_contactway,secret_e_shield,secret_keys,secret_contactflag,secret_contactmemo,secret_wantsalary,secret_sns,secret_sns2,secret_card,user_id,p_date
	from user_c_secret_history_20150317_20160707
  where  p_date between 20160404 and 20160404)   user_c_secret
 on web_user.user_id = user_c_secret.user_id 
 and web_user.p_date =  user_c_secret.user_id
left outer join 
( select  integrity_flag,user_id,p_date
	from user_c_integrity_history_20150317_20160708 
   where p_date between 20160404 and 20160404
) uci 
on web_user.user_id = uci.user_id 
and web_user.p_date = uci.p_date
;