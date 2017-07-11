create table if not exists dw_c_d_user_base (
user_id int ,
createtime string ,
c_kind string ,
c_industry string ,
c_jobtitle string ,
c_workyear int ,
c_title string ,
c_company string ,
c_dq string ,
c_sex string ,
c_edulevel string ,
c_edulevel_tz string ,
c_birth_year string ,
c_marriage string ,
c_nowsalary int ,
c_salmonths int ,
c_hope string ,
c_namecardflag string ,
c_telcheckflag string ,
c_emailcheckflag string ,
c_school_kind string ,
c_company_kind string ,
c_household string ,
c_nationality string ,
reg_device string ,
reg_mscid string ,
reg_plan string ,
reg_unit string ,
reg_keyword string ,
want_monthsalary int ,
want_salmonths int ,
want_industry string ,
want_industry_first string ,
want_jobtitle string ,
want_jobtitle_first string ,
want_dq string ,
want_dq_first string ,
want_venture_company string ,
integrity_flag string ,
secret_openwho string ,
secret_name string ,
secret_yearsalary string ,
secret_contactway string ,
secret_e_shield string ,
secret_keys string ,
secret_contactflag string ,
secret_contactmemo string ,
secret_wantsalary string ,
secret_sns string ,
secret_sns2 string ,
secret_card string ,
creation_timestamp timestamp 
) partitioned by (p_date int);

alter table dw_c_d_user_base add columns (is_upload_photo int comment '是否上传照片: 0-否,1-是') cascade;
alter table dw_c_d_user_base add columns (modifiedtime string comment '用户修改时间') cascade;
alter table dw_c_d_user_base add columns (last_login_date string comment '用户最近一次登录时间') cascade;

insert overwrite table dw_c_d_user_base partition (p_date = $date$)
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
ifempty( user_c_want.want_monthsalary, cast(-1 as bigint)) as want_monthsalary,
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
case when c_photo = '' then 0 else 1 end as is_upload_photo,
ifempty( user_c.modifiedtime, '1900-01-01 00:00:00') as modifiedtime,
ifempty( ul.last_login_date,'1900-01-01 00:00:00') as last_login_date
from 
(select user_id,user_kind,createtime,user_status,delflag
   from web_user 
  where user_kind = '0'
    and delflag = '0'
    and user_status = 1
)  web_user
join 
(select c_photo,c_kind,c_industry,c_jobtitle,c_workyear,c_title,c_company,c_dq,c_sex,c_edulevel,c_edulevel_tz,c_birth_year,c_marriage,c_nowsalary,c_hope,c_namecardflag,c_telcheckflag,c_emailcheckflag,c_majia,c_school_kind,c_household,c_nationality,user_id,c_company_kind,c_salmonths,modifiedtime
  from user_c
  where c_majia = 0
    and delflag = '0' ) user_c  
 on web_user.user_id = user_c.user_id
left outer join user_register
on web_user.user_id = user_register.user_id
left outer join user_c_want on web_user.user_id = user_c_want.user_id
left outer join user_c_secret on web_user.user_id = user_c_secret.user_id
left outer join user_c_integrity uci on web_user.user_id = uci.user_id
left outer join tongdaoren_id test on user_c.user_id = test.user_id
left outer join 
(select user_id, max(login_datetime) as last_login_date
   from user_login ul 
   where ul.p_date <= '$date$'
   group by user_id
) ul
on user_c.user_id = ul.user_id 
where test.user_id is null ;



insert overwrite table dw_c_d_user_base partition (p_date=$date$)
select c.user_id,c.createtime,c.c_kind,c.c_industry,c.c_jobtitle,c.c_workyear,c.c_title,c.c_company,c.c_dq,c.c_sex,c.c_edulevel,c.c_edulevel_tz,c.c_birth_year,c.c_marriage,c.c_nowsalary,c.c_salmonths,c.c_hope,c.c_namecardflag,c.c_telcheckflag,c.c_emailcheckflag,c.c_school_kind,c.c_company_kind,c.c_household,c.c_nationality,c.reg_device,c.reg_mscid,c.reg_plan,c.reg_unit,c.reg_keyword,c.want_monthsalary,c.want_salmonths,c.want_industry,c.want_industry_first,c.want_jobtitle,c.want_jobtitle_first,c.want_dq,c.want_dq_first,c.want_venture_company,c.integrity_flag,c.secret_openwho,c.secret_name,c.secret_yearsalary,c.secret_contactway,c.secret_e_shield,c.secret_keys,c.secret_contactflag,c.secret_contactmemo,c.secret_wantsalary,c.secret_sns,c.secret_sns2,c.secret_card,c.creation_timestamp,c.is_upload_photo,c.modifiedtime,
reformat_datetime(nvl(l.last_login_date,'1900-01-01 00:00:00')) as last_login_date
from dw_c_d_user_base c 
left join 
(select userc_id,max(last_login_date) as last_login_date
   from dw_c_d_last_login_date
   where p_date = $date$
   group by userc_id
 ) l
on c.user_id = l.userc_id
where c.p_date = $date$



