create table if not exists dw_c_d_appuser_base(
user_id int ,
first_login_day string ,
first_login_device int,
last_login_day string ,
last_login_device int ,
reg_device int ,
reg_datetime string ,
creation_timestamp timestamp 
) partitioned by (p_date int);

insert overwrite table dw_c_d_appuser_base partition (p_date = $date$)
select 
ifempty( ul.user_id,-1) as user_id,
ifempty( first_login_day,'1900-00-00 00:00:00') as first_login_day,
ifempty( first_login_device,-1) as first_login_device,
ifempty( last_login_day,'1900-00-00 00:00:00') as last_login_day,
ifempty( last_login_device,-1) as last_login_device,
ifempty( ur.reg_device,'-1') as reg_device,
ifempty( ur.reg_datetime,'1900-00-00 00:00:00') as reg_device,
from_unixtime(unix_timestamp())
from (
	select user_id,first_login_day,first_login_device,last_login_day,last_login_device
	from (
		select user_id,
		first_value(login_datetime) over(distribute by user_id sort by login_datetime ROWS between UNBOUNDED PRECEDING and  UNBOUNDED FOLLOWING ) first_login_day,
		first_value(ul_login_device) over(distribute by user_id sort by login_datetime ROWS between UNBOUNDED PRECEDING and  UNBOUNDED FOLLOWING ) first_login_device,
		last_value(login_datetime) over(distribute by user_id sort by login_datetime ROWS between UNBOUNDED PRECEDING and  UNBOUNDED FOLLOWING  ) last_login_day,
		last_value(ul_login_device) over(distribute by user_id sort by login_datetime ROWS between UNBOUNDED PRECEDING and  UNBOUNDED FOLLOWING  ) last_login_device,
		row_number() over(distribute by user_id sort by login_datetime) rowno
		from user_login 
		where ul_login_device in ('1','2')
		    and p_date <= '$date$'
	) u where rowno = 1
) ul 
left outer join user_register ur
on ul.user_id = ur.user_id;

alter table dw_c_d_appuser_base change user_id user_id int comment '用户主键';
alter table dw_c_d_appuser_base change first_login_day first_login_day string comment '首次登陆时间';
alter table dw_c_d_appuser_base change first_login_device first_login_device int comment '首次登陆终端';
alter table dw_c_d_appuser_base change last_login_day last_login_day string comment '最近一次登陆时间';
alter table dw_c_d_appuser_base change last_login_device last_login_device int comment '最近一次登陆终端';
alter table dw_c_d_appuser_base change reg_device reg_device int comment '注册终端';
alter table dw_c_d_appuser_base change reg_datetime reg_datetime string comment '注册时间';
alter table dw_c_d_appuser_base change creation_timestamp creation_timestamp timestamp comment '时间戳';
alter table dw_c_d_appuser_base change p_date p_date int comment '日期分区';