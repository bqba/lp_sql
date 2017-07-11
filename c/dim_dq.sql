CREATE TABLE dim_dq_pre(
  d_code string COMMENT '代码 ' , 
  d_ch_area string, 
  d_ch_code string,   
  d_ch_name string COMMENT '中文名', 
  d_en_name string COMMENT '英文名', 
  d_parent_code string, 
  d_parent_ch_name string, 
  d_parent_en_name string, 
  d_branch string, 
  d_region string, 
  creation_timestamp string COMMENT '创建时间 ', 
  d_ins_version string);


alter table dim_dq change d_branch d_branch string comment '所属分公司';
alter table dim_dq change d_region d_region string comment '所属大区';
alter table dim_dq change  d_ch_area d_ch_area string comment '地区名称';
alter table dim_dq change d_ch_code d_ch_code string comment '地区所属城市代码(中国)';
alter table dim_dq change d_ch_name d_ch_name string comment '地区所属城市名称(中国)';
alter table dim_dq change d_parent_code d_parent_code string comment '地区所属省份名称(中国)';
alter table dim_dq change d_parent_ch_name d_parent_ch_name string comment '地区所属省份名称(中国)';

CREATE TABLE dim_dq_pre(
  d_code varchar(9) COMMENT '代码 ' not null, 
  d_ch_area varchar(50) not null, 
  d_ch_code varchar(9),
  d_ch_name varchar(50) COMMENT '中文名' not null, 
  d_en_name varchar(50) COMMENT '英文名' not null, 
  d_parent_code varchar(9)  , 
  d_parent_ch_name varchar(50)  , 
  d_parent_en_name varchar(50)  , 
  d_branch varchar(50)  , 
  d_region varchar(50)  , 
  creation_timestamp not null default current_timestamp COMMENT '创建时间 ' , 
  d_ins_version varchar(9),
  primary key (d_code))
comment '维表-地区';

insert overwrite table dim_dq_pre
select p.d_code,p.d_ch_area,
nvl(ch.d_code,p.d_code) as d_ch_code,
p.d_ch_name,
p.d_en_name,p.d_parent_code,p.d_parent_ch_name,p.d_parent_en_name,p.d_branch,p.d_region,p.creation_timestamp,p.d_ins_version
from dim_dq_pre p
left join 
(select d_code,d_ch_area
   from dim_dq_pre
  where length(d_code) = 6) ch 
on substr(p.d_code,1,6) = ch.d_code;


alter table dim_dq rename to dim_dq_20170322;
alter table dim_dq_pre rename to dim_dq;