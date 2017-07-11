create table dim_org_gcdc
(
d_date int comment '统计日期',
d_org_id int comment '主键',
org_name varchar(80) comment '姓名',
parent_id int comment '上级主键',
parent_name varchar(80) comment '上级姓名',
grade int comment '层级',
kind int comment '组织类型',
sub_kind int comment '组织分类',
is_last int comment '是否末级',
first_level int comment '第1级主键',
first_level_name varchar(80) comment '第1级姓名',
second_level int comment '第2级主键',
second_level_name varchar(80) comment '第2级姓名',
third_level int comment '第3级主键',
third_level_name varchar(80) comment '第3级姓名',
forth_level int comment '第4级主键',
forth_level_name varchar(80) comment '第4级姓名',
fifth_level int comment '第5级主键',
fifth_level_name varchar(80) comment '第5级姓名',
sixth_level int comment '第6级主键',
sixth_level_name varchar(80) comment '第6级姓名',
seventh_level int comment '第7级主键',
seventh_level_name varchar(80) comment '第7级姓名',
eighth_level int comment '第8级主键',
eighth_level_name varchar(80) comment '第8级姓名',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,d_org_id)
) comment '组织层级展开维度表';


create table dim_org_level 
(
d_date int comment '统计日期',
d_org_id int comment '主键',
org_name string comment '姓名',
parent_id int comment '上级主键',
parent_name string comment '上级姓名',
grade int comment '层级',
kind int comment '组织类型',
sub_kind int comment '组织分类',
is_last int comment '是否末级',
first_level int comment '第1级主键',
first_level_name string comment '第1级姓名',
second_level int comment '第2级主键',
second_level_name string comment '第2级姓名',
third_level int comment '第3级主键',
third_level_name string comment '第3级姓名',
forth_level int comment '第4级主键',
forth_level_name string comment '第4级姓名',
fifth_level int comment '第5级主键',
fifth_level_name string comment '第5级姓名',
sixth_level int comment '第6级主键',
sixth_level_name string comment '第6级姓名',
seventh_level int comment '第7级主键',
seventh_level_name string comment '第7级姓名',
eighth_level int comment '第8级主键',
eighth_level_name string comment '第8级姓名',
creation_timestamp timestamp comment '时间戳'
) comment '组织层级展开维度表'
partitioned by (p_date int );


create table dim_org_level 
(
d_date int comment '统计日期',
d_org_id int comment '主键',
org_name varchar(80) comment '姓名',
parent_id int comment '上级主键',
parent_name varchar(80) comment '上级姓名',
grade int comment '层级',
kind int comment '组织类型',
sub_kind int comment '组织分类',
is_last int comment '是否末级',
first_level int comment '第1级主键',
first_level_name varchar(80) comment '第1级姓名',
second_level int comment '第2级主键',
second_level_name varchar(80) comment '第2级姓名',
third_level int comment '第3级主键',
third_level_name varchar(80) comment '第3级姓名',
forth_level int comment '第4级主键',
forth_level_name varchar(80) comment '第4级姓名',
fifth_level int comment '第5级主键',
fifth_level_name varchar(80) comment '第5级姓名',
sixth_level int comment '第6级主键',
sixth_level_name varchar(80) comment '第6级姓名',
seventh_level int comment '第7级主键',
seventh_level_name varchar(80) comment '第7级姓名',
eighth_level int comment '第8级主键',
eighth_level_name varchar(80) comment '第8级姓名',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,d_org_id)
) comment '组织层级展开维度表';

alter table dim_org_level add columns(rps_user_cnt int comment '当日RPS顾问人数',avg_rps_user_cnt int comment '月均RPS顾问人数') cascade;

alter table dim_org_level add columns(rps_user_cnt int comment '当日RPS顾问人数',avg_rps_user_cnt int comment '月均RPS顾问人数') ;

with  dol as 
( select 
    id as d_org_id,
    name as org_name,
    0 as parent_id,
    '0' as parent_name,
    1 as grade,
    6 as kind,
    99 as sub_kind,
    0 as is_last,
    id as first_level,
    name as first_level_name,
    0 as second_level,
    0 as second_level_name,
    0 as third_level,
    0 as third_level_name,
    0 as forth_level,
    0 as forth_level_name,
    0 as fifth_level,
    0 as fifth_level_name,
    0 as sixth_level,
    0 as sixth_level_name,
    0 as seventh_level,
    0 as seventh_level_name,
    0 as eighth_level,
    0 as eighth_level_name
  from portal_org
  where id = 1
  union all 
  select 
    id as d_org_id,
    name as org_name,
    1 as parent_id,
    '万仕道（北京）管理咨询有限公司' as parent_name,
    2 as grade,
    1 as kind,
    99 as sub_kind,
    0 as is_last,
    '1' as first_level,
    '万仕道（北京）管理咨询有限公司' as first_level_name,
    id as second_level,
    name as second_level_name,
    0 as third_level,
    0 as third_level_name,
    0 as forth_level,
    0 as forth_level_name,
    0 as fifth_level,
    0 as fifth_level_name,
    0 as sixth_level,
    0 as sixth_level_name,
    0 as seventh_level,
    0 as seventh_level_name,
    0 as eighth_level,
    0 as eighth_level_name
  from portal_org
  where id in (4,5,6,10268,10210)
  union all 
  select 
    org.id as d_org_id,
    org.name as org_name,
    case when org.id <> 10362 then org.parent_id else 10210 end as parent_id,
    case when org.id <> 10362 then parent.name else '天津' end as parent_name,
    3 as grade,
    2 as kind,
    99 as sub_kind,
    0 as is_last,
    '1' as first_level,
    '万仕道（北京）管理咨询有限公司' as first_level_name,
    case when org.id <> 10362 then org.parent_id else 10210 end as second_level,
    case when org.id <> 10362 then parent.name else '天津' end as second_level_name,
    org.id as third_level,
    org.name as third_level_name,
    0 as forth_level,
    0 as forth_level_name,
    0 as fifth_level,
    0 as fifth_level_name,
    0 as sixth_level,
    0 as sixth_level_name,
    0 as seventh_level,
    0 as seventh_level_name,
    0 as eighth_level,
    0 as eighth_level_name
  from portal_org org 
  left join portal_org parent 
  on org.parent_id = parent.id
  where org.id in (10113,10115,10148,10440,10362)
  union all 
  select 
    org.id as d_org_id,
    org.name as org_name,
    parent.id as parent_id,
    parent.name as parent_name,
    4 as grade,
    3 as kind,
    gp.sub_kind as sub_kind,
    1 as is_last,
    '1' as first_level,
    '万仕道（北京）管理咨询有限公司' as first_level_name,
    parent.parent_id as second_level,
    parent.parent_name as second_level_name,
    parent.id as third_level,
    parent.name as third_level_name,
    org.id as forth_level,
    org.name as forth_level_name,
    0 as fifth_level,
    0 as fifth_level_name,
    0 as sixth_level,
    0 as sixth_level_name,
    0 as seventh_level,
    0 as seventh_level_name,
    0 as eighth_level,
    0 as eighth_level_name
  from portal_org org 
  left join (
    select org.id ,org.name,
         case when org.id <> 10362 then org.parent_id else 10210 end as parent_id,
         case when org.id <> 10362 then parent.name else '天津' end as parent_name
      from portal_org org
      left join portal_org parent 
      on org.parent_id = parent.id
     where org.id in (10113,10115,10148,10440,10362)
    ) parent 
  on org.parent_id = parent.id
  left join 
  (select member_org_id ,sub_kind
    from portal_org_group 
    where sub_kind in (3,4,5,9,11)
    and deleteflag = 0
    ) gp
  on org.id = gp.member_org_id
  where org.parent_id in (10113,10115,10148,10440,10362)
) 
insert overwrite table dim_org_level partition (p_date = $date$)
select 
'$date$' as d_date,
d_org_id,
org_name,
parent_id,
parent_name,
grade,
kind,
sub_kind,
is_last,
first_level,
first_level_name,
second_level,
second_level_name,
third_level,
third_level_name,
forth_level,
forth_level_name,
fifth_level,
fifth_level_name,
sixth_level,
sixth_level_name,
seventh_level,
seventh_level_name,
eighth_level,
eighth_level_name,
from_unixtime(unix_timestamp()) as creation_timestamp,
user_cnt.rps_user_cnt as rps_user_cnt,
user_cnt.avg_rps_user_cnt as avg_rps_user_cnt
from dol 
left join (
select coalesce(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) as org_id,
           sum(rps_user_cnt) as rps_user_cnt,
           sum(avg_rps_user_cnt) as avg_rps_user_cnt
from dol 
left join (
        select teamorg.service_teamorg_id as org_id,
             sum(case when p_date = $date$ then rps_user_cnt else 0 end) as rps_user_cnt,
             avg(rps_user_cnt) as avg_rps_user_cnt
        from (
         select base.p_date,base.service_teamorg_id,count(distinct base.serviceuser_id) as rps_user_cnt
           from dw_erp_d_customer_base base
           join dw_erp_d_salesuser_base suser
           on base.serviceuser_id = suser.id 
           and base.p_date = suser.p_date
           and suser.position_channel = 'A0000603'
          where base.p_date  between  {{date[:6]+'01'}} and $date$ 
            and base.rps_service_version = 1
            and base.rsc_valid_status = 1 
           group by base.p_date,base.service_teamorg_id
         ) teamorg 
        group by service_teamorg_id
    ) teamorg 
on teamorg.org_id = dol.d_org_id 
group by dol.first_level,dol.second_level,dol.third_level,dol.forth_level
grouping sets(dol.first_level,dol.second_level,dol.third_level,dol.forth_level) 
) user_cnt 
on dol.d_org_id = user_cnt.org_id;
