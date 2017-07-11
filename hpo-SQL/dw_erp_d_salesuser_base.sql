create table if not exists dw_erp_d_salesuser_base (  
d_date int,
id int ,
name string ,
username string,
sex string ,
entrydate string ,
formaldate string ,
status int ,
account_status int ,
position_id int ,
position_name string ,
position_channel string ,
position_channel_name string,
position_level string,
position_level_name string,
org_id int ,
org_name string ,
repertory_industry string ,
parent_salesuser_id int ,
parent_salesuser_name string ,
parent_salesuser_id_list string,
grade int,
createtime timestamp ,
modifytime timestamp  ,
is_saleuser int,
creation_timestamp timestamp 
) partitioned by (p_date int);

alter table dw_erp_d_salesuser_base add columns(salesposition int comment '销售岗位级别',salesposition_name string comment '销售岗位级别名称') cascade;
alter table dw_erp_d_salesuser_act add columns(salesposition int comment '销售岗位级别',salesposition_name string comment '销售岗位级别名称') cascade;

alter table dw_erp_d_salesuser_act add (salesposition int comment '销售岗位级别',salesposition_name varchar(50) comment '销售岗位级别名称');
alter table dw_erp_d_salesuser_base add (salesposition int comment '销售岗位级别',salesposition_name varchar(50) comment '销售岗位级别名称');


insert overwrite table dw_erp_d_salesuser_base partition (p_date = $date$)
select
$date$ as d_date,
nvl(employee.id,-1) as id,
nvl(employee.name,'未知') as name,
nvl(employee.username,'未知') as username,
nvl(case when employee.sex = '1' then '男' 
			   when employee.sex = '0' then '女' 
			   else '9'
	  end,'9')  as sex,
nvl(concat(substr(employee.entrydate,1,4),'-',substr(employee.entrydate,5,2),'-',substr(employee.entrydate,7,2)) , '1900-01-01' ) as entrydate,
nvl(concat(substr(employee.formaldate,1,4),'-',substr(employee.formaldate,5,2),'-',substr(employee.formaldate,7,2)) , '1900-01-01' ) as formaldate,
nvl(employee.status,-1) as status,
nvl(employee.account_status,-1) as account_status,
nvl(employee.position_id,-1) as position_id,
nvl(position.name,'未知') as position_name,
nvl(position.position_channel,'999') as position_channel,
nvl(pchannel_enum.enum_name,'999') as position_channel_name,
nvl(position.position_level,'999') as position_level,
nvl(plevel_enum.enum_name,'999') as position_level_name,
nvl(employee.org_id,-1) as org_id,
nvl(org.name,'未知') as org_name,
nvl(employee.repertory_industry,'999') as repertory_industry,
nvl(dim_employee_level.parent_id ,-1)as parent_salesuser_id,
nvl(dim_employee_level.parent_name,'未知' ) as parent_salesuser_name,
nvl(dim_employee_level.parent_id_list,'-1')  as parent_salesuser_id_list ,
nvl(dim_employee_level.grade,-1) as grade,
nvl(employee.createtime,'1900-01-01 00:00:00') as createtime,
nvl(employee.modifytime,'1900-01-01 00:00:00') as modifytime,
nvl(case when position.position_channel in ('A0000484','A0000485','A0000486','A0000487','A0000489','A0000821') then 1 else 0 end ,-1) as is_saleuser,
from_unixtime(unix_timestamp()) as creation_timestamp,
case when position.position_channel = 'A0000821' then 0
	 when position.position_channel = 'A0000484' then 1
	 when position.position_channel = 'A0000485' then 2
	 when position.position_channel = 'A0000486' then 3
	 when position.position_channel in ('A0000487','A0000489','A0000641','A0000526') then sposition.d_level_code
	 else -1 
end as salesposition,
case when position.position_channel = 'A0000821' then 'JS销售'
	 when position.position_channel = 'A0000484' then 'S销售'
	 when position.position_channel = 'A0000485' then 'SS销售'
	 when position.position_channel = 'A0000486' then 'KA销售'
	 when position.position_channel in ('A0000487','A0000489','A0000641','A0000526') then sposition.d_level_name
	 else '未知'
end as salesposition_name
from portal_employee employee
left outer join portal_position position 
on employee.position_id = position.id
left outer join portal_org org
on employee.org_id = org.id
left outer join 
(
 select id,parent_id,parent_name,parent_id_list,grade
   from dim_employee_level
   where p_date = $date$
) dim_employee_level
on employee.id = dim_employee_level.id
left outer join 
(select enum_code,
		enum_name,
		row_number()over(distribute by enum_code sort by startdate desc) as rn 
   from pub_enum_list
  where src_table = 'portal_position'
   and is_default = 1
   and enum_type = 'position_level') plevel_enum
on position.position_level = plevel_enum.enum_code
and plevel_enum.rn = 1
left outer join 
(select enum_code,
		enum_name,
		row_number()over(distribute by enum_code sort by startdate desc) as rn 
   from pub_enum_list
  where src_table = 'portal_position'
   and is_default = 1
   and enum_type = 'position_channel') pchannel_enum
on position.position_channel = pchannel_enum.enum_code
and pchannel_enum.rn = 1
left outer join pub_salesposition_level sposition 
on position.position_channel = sposition.d_position_channel
and position.position_level = sposition.d_position_level
left outer join dw_erp_a_test_account ta 
on employee.id = ta.id 
and ta.type = 2
where employee.deleteflag = 0
and ta.id is null;


create table dw_erp_d_salesuser_base (  
d_date int,
id int ,
name varchar(50) ,
username varchar(50),
sex varchar(50) ,
entrydate varchar(50) ,
formaldate varchar(50) ,
status int ,
account_status int ,
position_id int ,
position_name varchar(50) ,
position_channel varchar(50) ,
position_channel_name varchar(50) ,
position_level varchar(20),
position_level_name varchar(20),
org_id int ,
org_name varchar(200) ,
repertory_industry varchar(50) ,
parent_salesuser_id int ,
parent_salesuser_name varchar(50) ,
parent_salesuser_id_list varchar(200),
grade int,
createtime varchar(50) ,
modifytime varchar(50)  ,
is_saleuser int,
creation_timestamp  timestamp default CURRENT_TIMESTAMP,
primary key (d_date, id)
);
alter table dw_erp_d_salesuser_base change d_date d_date int comment ' 数据日期  ';
alter table dw_erp_d_salesuser_base change id id string comment ' 员工id  ';
alter table dw_erp_d_salesuser_base change name name string comment ' 员工姓名  ';
alter table dw_erp_d_salesuser_base change username username string comment ' hpo账号  ';
alter table dw_erp_d_salesuser_base change sex sex string comment ' 员工性别  ';
alter table dw_erp_d_salesuser_base change entrydate entrydate string comment ' 入职日期  ';
alter table dw_erp_d_salesuser_base change formaldate formaldate int comment ' 转正日期 0-试用,1-正式,2-离职 ';
alter table dw_erp_d_salesuser_base change status status int comment ' 员工状态 0-启用,1-禁用 ';
alter table dw_erp_d_salesuser_base change account_status account_status int comment ' 账号状态  ';
alter table dw_erp_d_salesuser_base change position_id position_id string comment ' 岗位ID  ';
alter table dw_erp_d_salesuser_base change position_name position_name string comment ' 岗位名称  ';
alter table dw_erp_d_salesuser_base change position_channel position_channel string comment ' 岗位通道  ';
alter table dw_erp_d_salesuser_base change position_channel_name position_channel_name string comment ' 岗位通道名称  ';
alter table dw_erp_d_salesuser_base change position_level position_level string comment ' 岗位级别  ';
alter table dw_erp_d_salesuser_base change position_level_name position_level_name string comment ' 岗位级别名称  ';
alter table dw_erp_d_salesuser_base change org_id org_id int comment ' 所在组织  ';
alter table dw_erp_d_salesuser_base change org_name org_name string comment ' 所在组织名称  ';
alter table dw_erp_d_salesuser_base change repertory_industry repertory_industry string comment ' 深耕行业 逗号分隔 ';
alter table dw_erp_d_salesuser_base change parent_salesuser_id parent_salesuser_id int comment ' 汇报对象  ';
alter table dw_erp_d_salesuser_base change parent_salesuser_name parent_salesuser_name string comment ' 汇报对象名称  ';
alter table dw_erp_d_salesuser_base change parent_salesuser_id_list parent_salesuser_id_list string comment ' 汇报对象及所有上级列表  ';
alter table dw_erp_d_salesuser_base change grade grade int comment ' 级别 岗位类型A0000481 ';
alter table dw_erp_d_salesuser_base change createtime createtime timestamp comment ' 创建时间  ';
alter table dw_erp_d_salesuser_base change modifytime modifytime timestamp comment ' 修改时间  ';
alter table dw_erp_d_salesuser_base change is_saleuser is_saleuser int comment ' 是否销售序列  ';
alter table dw_erp_d_salesuser_base change creation_timestamp creation_timestamp timestamp comment ' 时间戳  ';


CREATE TABLE dw_erp_d_salesuser_base_pre(
  d_date int COMMENT ' 数据日期  ', 
  id string COMMENT ' 员工id  ', 
  name string COMMENT ' 员工姓名  ', 
  username string COMMENT ' hpo账号  ', 
  sex string COMMENT ' 员工性别  ', 
  entrydate string COMMENT ' 入职日期  ', 
  formaldate string COMMENT ' 转正日期 ', 
  dismissdate string COMMENT ' 离职日期 ',   
  status int COMMENT ' 0-试用,1-正式,2-离职  ', 
  account_status int COMMENT ' 员工状态 0-启用,1-禁用 ', 
  position_id string COMMENT ' 岗位ID  ', 
  position_name string COMMENT ' 岗位名称  ', 
  position_channel string COMMENT ' 岗位通道  ', 
  position_channel_name string COMMENT ' 岗位通道名称  ', 
  position_level string COMMENT ' 岗位级别  ', 
  position_level_name string COMMENT ' 岗位级别名称  ', 
  org_id int COMMENT ' 所在组织  ', 
  org_name string COMMENT ' 所在组织名称  ', 
  repertory_industry string COMMENT ' 深耕行业 逗号分隔 ', 
  parent_salesuser_id int COMMENT ' 汇报对象  ', 
  parent_salesuser_name string COMMENT ' 汇报对象名称  ', 
  parent_salesuser_id_list string COMMENT ' 汇报对象及所有上级列表  ', 
  grade int COMMENT ' 级别 ', 
  createtime timestamp COMMENT ' 创建时间  ', 
  modifytime timestamp COMMENT ' 修改时间  ', 
  is_saleuser int COMMENT ' 是否销售序列  ', 
  creation_timestamp timestamp COMMENT ' 时间戳  ', 
  salesposition int COMMENT '销售岗位级别', 
  salesposition_name string COMMENT '销售岗位级别名称')
comment '猎聘员工信息表'
PARTITIONED BY ( p_date int);


CREATE TABLE dw_erp_d_salesuser_base_pre (
	d_date INT(11) NOT NULL DEFAULT '0',
	id INT(11) NOT NULL DEFAULT '0',
	name VARCHAR(50) NULL DEFAULT NULL,
	username VARCHAR(50) NULL DEFAULT NULL,
	sex VARCHAR(50) NULL DEFAULT NULL,
	entrydate VARCHAR(50) NULL DEFAULT NULL,
	formaldate VARCHAR(50) NULL DEFAULT NULL,
	dismissdate VARCHAR(50) NULL DEFAULT NULL,	
	status INT(11) NULL DEFAULT NULL,
	account_status INT(11) NULL DEFAULT NULL,
	position_id INT(11) NULL DEFAULT NULL,
	position_name VARCHAR(50) NULL DEFAULT NULL,
	position_channel VARCHAR(50) NULL DEFAULT NULL,
	position_channel_name VARCHAR(50) NULL DEFAULT NULL,
	position_level VARCHAR(20) NULL DEFAULT NULL,
	position_level_name VARCHAR(20) NULL DEFAULT NULL,
	org_id INT(11) NULL DEFAULT NULL,
	org_name VARCHAR(200) NULL DEFAULT NULL,
	repertory_industry VARCHAR(50) NULL DEFAULT NULL,
	parent_salesuser_id INT(11) NULL DEFAULT NULL,
	parent_salesuser_name VARCHAR(50) NULL DEFAULT NULL,
	parent_salesuser_id_list VARCHAR(200) NULL DEFAULT NULL,
	grade INT(11) NULL DEFAULT NULL,
	createtime VARCHAR(50) NULL DEFAULT NULL,
	modifytime VARCHAR(50) NULL DEFAULT NULL,
	is_saleuser INT(11) NULL DEFAULT NULL,
	creation_timestamp TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	salesposition INT(11) NULL DEFAULT NULL COMMENT '销售岗位级别',
	salesposition_name VARCHAR(50) NULL DEFAULT NULL COMMENT '销售岗位级别名称',
	PRIMARY KEY (d_date, id)
);


insert overwrite table dw_erp_d_salesuser_base_pre partition (p_date)
select base.d_date,base.id,base.name,base.username,base.sex,
if(base.entrydate = '--','1900-01-01',base.entrydate) as entrydate,
if(nvl(pl.formaldate,'')='' or pl.formaldate = '00000000','1900-01-01',concat(substr(pl.formaldate,1,4),'-',substr(pl.formaldate,5,2),'-',substr(pl.formaldate,7,2))) as formaldate,
if(nvl(pl.dismissdate,'')='' or pl.dismissdate = '00000000','1900-01-01',concat(substr(pl.dismissdate,1,4),'-',substr(pl.dismissdate,5,2),'-',substr(pl.dismissdate,7,2))) as dismissdate,
base.status,base.account_status,base.position_id,base.position_name,base.position_channel,base.position_channel_name,base.position_level,base.position_level_name,base.org_id,base.org_name,base.repertory_industry,base.parent_salesuser_id,base.parent_salesuser_name,base.parent_salesuser_id_list,base.grade,base.createtime,base.modifytime,base.is_saleuser,base.creation_timestamp,base.salesposition,base.salesposition_name,base.p_date
from dw_erp_d_salesuser_base base 
left join portal_employee pl 
on base.id = pl.id
where p_date between {{start_date}} and {{end_date}};

CREATE TABLE dw_erp_d_salesuser_base_temp(
  d_date int COMMENT ' 数据日期  ', 
  id string COMMENT ' 员工id  ', 
  name string COMMENT ' 员工姓名  ', 
  username string COMMENT ' hpo账号  ', 
  sex string COMMENT ' 员工性别  ', 
  entrydate string COMMENT ' 入职日期  ', 
  formaldate string COMMENT ' 转正日期 ', 
  dismissdate string COMMENT ' 离职日期 ',   
  status int COMMENT ' 0-试用,1-正式,2-离职  ', 
  account_status int COMMENT ' 员工状态 0-启用,1-禁用 ', 
  position_id string COMMENT ' 岗位ID  ', 
  position_name string COMMENT ' 岗位名称  ', 
  position_channel string COMMENT ' 岗位通道  ', 
  position_channel_name string COMMENT ' 岗位通道名称  ', 
  position_level string COMMENT ' 岗位级别  ', 
  position_level_name string COMMENT ' 岗位级别名称  ', 
  org_id int COMMENT ' 所在组织  ', 
  org_name string COMMENT ' 所在组织名称  ', 
  repertory_industry string COMMENT ' 深耕行业 逗号分隔 ', 
  parent_salesuser_id int COMMENT ' 汇报对象  ', 
  parent_salesuser_name string COMMENT ' 汇报对象名称  ', 
  parent_salesuser_id_list string COMMENT ' 汇报对象及所有上级列表  ', 
  grade int COMMENT ' 级别 ', 
  createtime timestamp COMMENT ' 创建时间  ', 
  modifytime timestamp COMMENT ' 修改时间  ', 
  is_saleuser int COMMENT ' 是否销售序列  ', 
  creation_timestamp timestamp COMMENT ' 时间戳  ', 
  salesposition int COMMENT '销售岗位级别', 
  salesposition_name string COMMENT '销售岗位级别名称',
  parent_salesuser_name_list string comment '汇报对象及所有上级列表'
  )
comment '猎聘员工信息表'
PARTITIONED BY ( p_date int);

alter table dw_erp_d_salesuser_base_temp add columns(parent_salesuser_name_list string comment '汇报对象及所有上级列表');

insert overwrite table dw_erp_d_salesuser_base_temp partition (p_date)
select d_date, id, name, username, sex, entrydate, formaldate, null as dismissdate, status, account_status, position_id, position_name, position_channel, position_channel_name, position_level, position_level_name, org_id, org_name, repertory_industry, parent_salesuser_id, parent_salesuser_name, parent_salesuser_id_list, grade, createtime, modifytime, is_saleuser, creation_timestamp, salesposition, salesposition_name,pr.parent_name, p_date
from dw_erp_d_salesuser_base base 
left join 
(select su2.id as sid ,
	   combine(nvl(pl.name,'')) as parent_name
	from 
	(
		select id,name,parent_id
	    from (
			select d_date, id, name,  parent_salesuser_id_list
			from dw_erp_d_salesuser_base
		    where status in (0,1)
		    and is_saleuser = 1 
		    and position_channel_name in ('JS销售','大客户销售','高级销售','LPT销售')
		    and p_date = 20170331
	    ) su
	    lateral view explode(split(parent_salesuser_id_list,',')) i as parent_id
	) su2 
	left join portal_employee pl 
	on su2.parent_id = pl.id 
	group by su2.id
) pr
on base.id = pr.sid
where base.p_date = 20170331;




alter table dw_erp_d_salesuser_base_pre add columns (position_type string comment '职位类型', position_type_name string comment '职位类型名称') cascade;

alter table dw_erp_d_salesuser_base_pre add (position_type varchar(50) comment '职位类型', position_type_name varchar(50) comment '职位类型名称') ;



insert overwrite table dw_erp_d_salesuser_base_pre partition (p_date = $date$)
select
$date$ as d_date,
nvl(employee.id,-1) as id,
nvl(employee.name,'未知') as name,
nvl(employee.username,'未知') as username,
nvl(case when employee.sex = '1' then '男' 
         when employee.sex = '0' then '女' 
         else '9'
    end,'9')  as sex,
nvl(reformat_datetime(ifempty(employee.entrydate,'1900-01-01'),'yyyy-MM-dd'),'1900-01-01') as  entrydate,
nvl(reformat_datetime(ifempty(employee.formaldate,'1900-01-01'),'yyyy-MM-dd'),'1900-01-01') as  formaldate,
nvl(reformat_datetime(ifempty(employee.dismissdate,'1900-01-01'),'yyyy-MM-dd'),'1900-01-01') as  dismissdate,
nvl(employee.status,-1) as status,
nvl(employee.account_status,-1) as account_status,
nvl(employee.position_id,-1) as position_id,
nvl(position.name,'未知') as position_name,
nvl(position.position_channel,'999') as position_channel,
nvl(pchannel_enum.enum_name,'999') as position_channel_name,
nvl(position.position_level,'999') as position_level,
nvl(plevel_enum.enum_name,'999') as position_level_name,
nvl(employee.org_id,-1) as org_id,
nvl(org.name,'未知') as org_name,
nvl(employee.repertory_industry,'999') as repertory_industry,
nvl(dim_employee_level.parent_id ,-1)as parent_salesuser_id,
nvl(dim_employee_level.parent_name,'未知' ) as parent_salesuser_name,
nvl(dim_employee_level.parent_id_list,'-1')  as parent_salesuser_id_list ,
nvl(dim_employee_level.grade,-1) as grade,
nvl(employee.createtime,'1900-01-01 00:00:00') as createtime,
nvl(employee.modifytime,'1900-01-01 00:00:00') as modifytime,
nvl(case when position.position_channel in ('A0000484','A0000485','A0000486','A0000487','A0000489','A0000821') then 1 else 0 end ,-1) as is_saleuser,
from_unixtime(unix_timestamp()) as creation_timestamp,
case when position.position_channel = 'A0000821' then 0
   when position.position_channel = 'A0000484' then 1
   when position.position_channel = 'A0000485' then 2
   when position.position_channel = 'A0000486' then 3
   when position.position_channel in ('A0000487','A0000489','A0000641','A0000526') then sposition.d_level_code
   else -1 
end as salesposition,
case when position.position_channel = 'A0000821' then 'JS销售'
   when position.position_channel = 'A0000484' then 'S销售'
   when position.position_channel = 'A0000485' then 'SS销售'
   when position.position_channel = 'A0000486' then 'KA销售'
   when position.position_channel in ('A0000487','A0000489','A0000641','A0000526') then sposition.d_level_name
   else '未知'
end as salesposition_name,
nvl(position.position_type,'999') as position_type,
nvl(ptype_enum.enum_name,'999')  as position_type_name
from portal_employee employee
left outer join portal_position position 
on employee.position_id = position.id
left outer join portal_org org
on employee.org_id = org.id
left outer join 
(
 select id,parent_id,parent_name,parent_id_list,grade
   from dim_employee_level
   where p_date = $date$
) dim_employee_level
on employee.id = dim_employee_level.id
left outer join 
(select enum_code,
    enum_name,
    row_number()over(distribute by enum_code sort by startdate desc) as rn 
   from pub_enum_list
  where src_table = 'portal_position'
   and is_default = 1
   and enum_type = 'position_level') plevel_enum
on position.position_level = plevel_enum.enum_code
and plevel_enum.rn = 1
left outer join 
(select enum_code,
    enum_name,
    row_number()over(distribute by enum_code sort by startdate desc) as rn 
   from pub_enum_list
  where src_table = 'portal_position'
   and is_default = 1
   and enum_type = 'position_channel') pchannel_enum
on position.position_channel = pchannel_enum.enum_code
and pchannel_enum.rn = 1
left outer join 
(select enum_code,
    enum_name,
    row_number()over(distribute by enum_code sort by startdate desc) as rn 
   from pub_enum_list
  where src_table = 'portal_position'
   and is_default = 1
   and enum_type = 'position_type') ptype_enum
on position.position_type = ptype_enum.enum_code
and ptype_enum.rn = 1
left outer join pub_salesposition_level sposition 
on position.position_channel = sposition.d_position_channel
and position.position_level = sposition.d_position_level
left outer join dw_erp_a_test_account ta 
on employee.id = ta.id 
and ta.type = 2
where employee.deleteflag = 0
and ta.id is null;


insert overwrite table dw_erp_d_salesuser_base_pre partition (p_date)
select 
  pre.d_date
, pre.id
, pre.name
, pre.username
, pre.sex
, case when pre.entrydate = '--' then '1900-01-01' else pre.entrydate end as entrydate 
, case when pre.formaldate = '--' then '1900-01-01' else pre.formaldate end as formaldate 
, case when pre.dismissdate = '--' then '1900-01-01' else pre.dismissdate end as dismissdate
, pre.status
, pre.account_status
, pre.position_id
, pre.position_name
, pre.position_channel
, pre.position_channel_name
, pre.position_level
, pre.position_level_name
, pre.org_id
, pre.org_name
, pre.repertory_industry
, pre.parent_salesuser_id
, pre.parent_salesuser_name
, pre.parent_salesuser_id_list
, pre.grade
, pre.createtime
, pre.modifytime
, pre.is_saleuser
, pre.creation_timestamp
, pre.salesposition
, pre.salesposition_name
, nvl(pp.position_type,'999')
, nvl(ptype_enum.enum_name,'未知')
, pre.p_date
from dw_erp_d_salesuser_base_pre pre
left join portal_position pp 
on pre.position_id = pp.id 
left outer join 
(select enum_code,
    enum_name,
    row_number()over(distribute by enum_code sort by startdate desc) as rn 
   from pub_enum_list
  where src_table = 'portal_position'
   and is_default = 1
   and enum_type = 'position_type') ptype_enum
on pp.position_type = ptype_enum.enum_code
and ptype_enum.rn = 1
where pre.p_date between {{start_date}} and {{end_date}}