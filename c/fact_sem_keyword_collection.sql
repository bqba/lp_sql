--应聘企业职位次数、应聘企业职位的经理人数
drop table if exists temp_task_bi_sem_keyword_collection_apply_ejob_cnt;
create table temp_task_bi_sem_keyword_collection_apply_ejob_cnt (
d_mscid                string,
d_plan                 string,
d_unit                 string,
d_keyword              string,
apply_ejob_cnt         int,
apply_ejob_user_cnt    int
);

insert overwrite table temp_task_bi_sem_keyword_collection_apply_ejob_cnt
select
t.mscid,
t.plan,
t.unit,
t.keyword,
sum(case when t.apply_cnt is null then 0 else t.apply_cnt end) as apply_ejob_cnt, 
count(t.user_id) as apply_ejob_user_cnt
from
(
select 
ifnull(split(rvu.reg_mscid, '#')[1], '00000000') as mscid,
ifnull(rvu.reg_plan, '') as plan,
ifnull(rvu.reg_unit, '') as unit,
ifnull(rvu.reg_keyword, '') as keyword,
ja.apply_cnt,
ja.user_id
from web_user wu 
join user_c uc
on wu.user_id = uc.user_id
left outer join 
user_register rvu 
on wu.user_id = rvu.user_id
left outer join
(select user_id,cast(count(apply_id) as int) as apply_cnt
from job_apply
where
apply_createtime between '$start_datetime$' and '$end_datetime$'
and job_kind = '2'
group by user_id) ja
on wu.user_id = ja.user_id
where wu.createtime between '$start_timestamp$' and '$end_timestamp$'
and wu.user_kind = '0' and rvu.reg_device in (0,4)) t
group by t.mscid, t.plan, t.unit, t.keyword;


--应聘猎头职位次数、应聘猎头职位的经理人数
drop table if exists temp_task_bi_sem_keyword_collection_apply_hjob_cnt;
create table temp_task_bi_sem_keyword_collection_apply_hjob_cnt (
d_mscid                string,
d_plan                 string,
d_unit                 string,
d_keyword              string,
apply_hjob_cnt         int,
apply_hjob_user_cnt    int
);

insert overwrite table temp_task_bi_sem_keyword_collection_apply_hjob_cnt
select
t.mscid,
t.plan,
t.unit,
t.keyword,
sum(case when t.apply_cnt is null then 0 else t.apply_cnt end) as apply_hjob_cnt, 
count(t.user_id) as apply_hjob_user_cnt
from
(
select 
ifnull(split(rvu.reg_mscid,'#')[1], '00000000') as mscid,
ifnull(rvu.reg_plan, '') as plan,
ifnull(rvu.reg_unit, '') as unit,
ifnull(rvu.reg_keyword, '') as keyword,
ja.apply_cnt, 
ja.user_id
from web_user wu 
join user_c uc
on wu.user_id = uc.user_id
left outer join 
user_register rvu
on wu.user_id = rvu.user_id
left outer join
(select user_id,cast(count(apply_id) as int) as apply_cnt
from job_apply
where
apply_createtime between '$start_datetime$' and '$end_datetime$'
and job_kind = '1'
group by user_id) ja
on wu.user_id = ja.user_id
where wu.createtime between '$start_timestamp$' and '$end_timestamp$'
and wu.user_kind = '0' and rvu.reg_device in (0,4)) t
group by t.mscid, t.plan, t.unit, t.keyword;


--职位订阅次数、职位订阅人数
drop table if exists temp_task_bi_sem_keyword_collection_job_subscribe_cnt;
create table temp_task_bi_sem_keyword_collection_job_subscribe_cnt (
d_mscid                string,
d_plan                 string,
d_unit                 string,
d_keyword              string,
subscribe_cnt          int,
subscribe_user_cnt     int
);

insert overwrite table temp_task_bi_sem_keyword_collection_job_subscribe_cnt
select
t.mscid,
t.plan,
t.unit,
t.keyword,
sum(case when t.usc_cnt is null then 0 else t.usc_cnt end) as subscribe_cnt, 
count(t.user_id) as subscribe_user_cnt
from
(
select 
ifnull(split(rvu.reg_mscid, '#')[1], '00000000') as mscid,
ifnull(rvu.reg_plan, '') as plan,
ifnull(rvu.reg_unit, '') as unit,
ifnull(rvu.reg_keyword, '') as keyword,
js.usc_cnt,
js.user_id
from web_user wu join
user_c uc
on wu.user_id = uc.user_id
left outer join user_register rvu
on wu.user_id = rvu.user_id
left outer join
(select user_id ,cast(count(usc_id) as int) as usc_cnt
from job_subscribe
where usc_createtime between '$start_datetime$' and '$end_datetime$'
group by user_id) js
on wu.user_id = js.user_id
where wu.createtime between '$start_timestamp$' and '$end_timestamp$'
and wu.user_kind = '0' and rvu.reg_device in (0,4)) t
group by t.mscid, t.plan, t.unit, t.keyword;

--职位收藏次数、职位收藏的经理人数
drop table if exists temp_task_bi_sem_keyword_collection_job_favorites_cnt;
create table temp_task_bi_sem_keyword_collection_job_favorites_cnt (
d_mscid                string,
d_plan                 string,
d_unit                 string,
d_keyword              string,
favorites_cnt          int,
favorites_user_cnt     int
);

insert overwrite table temp_task_bi_sem_keyword_collection_job_favorites_cnt
select
t.mscid,
t.plan,
t.unit,
t.keyword,
sum(case when t.jf_cnt is null then 0 else t.jf_cnt end) as favorites_cnt, 
count(t.user_id) as favorites_user_cnt
from
(
select 
ifnull(split(rvu.reg_mscid, '#')[1], '00000000') as mscid,
ifnull(rvu.reg_plan, '') as plan,
ifnull(rvu.reg_unit, '') as unit,
ifnull(rvu.reg_keyword, '') as keyword,
jf.jf_cnt,
jf.user_id
from 
web_user wu
join user_c uc
on wu.user_id = uc.user_id
left outer join
user_register rvu
on wu.user_id = rvu.user_id
left outer join
(select user_id, cast(count(jf_id) as int) as jf_cnt
from job_favorites
where jf_createtime between '$start_datetime$' and '$end_datetime$'
group by user_id) jf
on wu.user_id = jf.user_id
where wu.createtime between '$start_timestamp$' and '$end_timestamp$'
and wu.user_kind = '0' and rvu.reg_device in (0,4)) t
group by t.mscid, t.plan, t.unit, t.keyword;

--关注猎头次数、关注猎头的经理人数、被关注的猎头人数
drop table if exists temp_task_bi_sem_keyword_collection_follower_cnt;
create table temp_task_bi_sem_keyword_collection_follower_cnt (
d_mscid                string,
d_plan                 string,
d_unit                 string,
d_keyword              string,
follower_cnt           int,
follower_c_cnt         int,
follower_h_cnt         int
);
insert overwrite table temp_task_bi_sem_keyword_collection_follower_cnt
select
t.mscid,
t.plan,
t.unit,
t.keyword,
count(t.user_id) as follower_cnt, 
count(distinct t.follower_id) as follower_c_cnt, 
count(distinct t.user_id) as follower_h_cnt 
from
(
select 
ifnull(split(rvu.reg_mscid, '#')[1], '00000000') as mscid,
ifnull(rvu.reg_plan, '') as plan,
ifnull(rvu.reg_unit, '') as unit,
ifnull(rvu.reg_keyword, '') as keyword,
uf.follower_id,
uf.user_id
from web_user wu 
join user_c uc
on wu.user_id = uc.user_id
left outer join user_register rvu
on wu.user_id = rvu.user_id
left outer join
(select user_id, follower_id 
from user_follower 
where createtime between '$start_datetime$' and '$end_datetime$') uf
on wu.user_id = uf.follower_id
where wu.user_kind = '0'
and wu.createtime between '$start_timestamp$' and '$end_timestamp$' and rvu.reg_device in (0,4)) t
group by t.mscid, t.plan, t.unit, t.keyword;


--UV
--此处的uv不可以累加求和。因为不同关键词，有可能有重合的UV。
drop table if exists temp_task_bi_sem_keyword_collection_uv_cnt;
create table temp_task_bi_sem_keyword_collection_uv_cnt (
d_mscid                string,
d_plan                 string,
d_unit                 string,
d_keyword              string,
uv_cnt                 int
);

insert overwrite table temp_task_bi_sem_keyword_collection_uv_cnt
select 
sv.m_mscid,
sv.m_plan,
sv.m_unit,
sv.m_keyword,
count(distinct sv.uuid) as uv_cnt
from (
select 
el_mscid as m_mscid,
ifnull(extract_url_param(url, 'utm_campaign'), '') as m_plan,
ifnull(extract_url_param(url, 'utm_content'), '') as m_unit,
ifnull(extract_url_param(url, 'utm_term'), '') as m_keyword,
uuid as uuid
from tlog
where p_date ='$date$' and type = 'p'
and url != 'http://m.liepin.com/register.jsp?mscid=s_00_m10&utm_source=sogou&utm_medium=cpc&utm_campaign=%C3%A5%C2%9B%C2%BE%C3%A7%C2%89%C2%87&utm_content=&utm_term='
and el_mscid not like 's_o_%'
union all
select 
el_mscid as m_mscid,
ifnull(extract_url_dir(refer, 0), '') as m_plan,
ifnull(substr(url, 0, 100), '') as m_unit,
ifnull(extract_seo_keyword(refer), '') as m_keyword,
uuid as uuid
from tlog
where p_date ='$date$' and type = 'p'
and uv_seq = 1
and el_mscid like 's_o_%'
) sv
group by sv.m_mscid,sv.m_plan,sv.m_unit,sv.m_keyword;


--注册数
drop table if exists temp_task_bi_sem_keyword_collection_c_reg_cnt;
create table temp_task_bi_sem_keyword_collection_c_reg_cnt (
d_mscid                string,
d_plan                 string,
d_unit                 string,
d_keyword              string,
c_reg_cnt                int
);

insert overwrite table temp_task_bi_sem_keyword_collection_c_reg_cnt
select
t.mscid,
t.plan,
t.unit,
t.keyword,
count(t.user_id) as c_reg_cnt
from
(
select 
ifnull(split(rvu.reg_mscid, '#')[1], '00000000') as mscid,
substr(ifnull(rvu.reg_plan, ''), 0, 100) as plan,
substr(ifnull(rvu.reg_unit, ''), 0, 100) as unit,
substr(ifnull(rvu.reg_keyword, ''), 0, 100) as keyword,
wu.user_id
from web_user wu join
user_c uc on wu.user_id = uc.user_id
left outer join user_register rvu
on wu.user_id = rvu.user_id
where wu.createtime between '$start_timestamp$' and '$end_timestamp$'
and wu.user_kind = '0' and rvu.reg_device in (0,4)) t
group by t.mscid, t.plan, t.unit, t.keyword;

-- 猎头注册数，包含注册/即时审核通过数
drop table if exists temp_task_bi_sem_keyword_collection_h_reg_cnt;
create table temp_task_bi_sem_keyword_collection_h_reg_cnt (
d_mscid                string,
d_plan                 string,
d_unit                 string,
d_keyword              string,
h_reg_cnt                int,
h_audit_cnt              int
);

insert overwrite table temp_task_bi_sem_keyword_collection_h_reg_cnt
select
t.mscid,
t.plan,
t.unit,
t.keyword,
count(t.user_id) as h_reg_cnt, 
-- 正式会员/VIP会员即视为审核通过
sum(case when (t.h_status = '1' or t.h_status = '3') then 1 else 0 end) as h_audit_cnt
from
( 
select 
ifnull(split(rvu.reg_mscid, '#')[1], '00000000') as mscid,
ifnull(rvu.reg_plan, '') as plan,
ifnull(rvu.reg_unit, '') as unit,
ifnull(rvu.reg_keyword, '') as keyword,
wu.user_id,
uh.h_status
from web_user wu 
join user_h uh
on wu.user_id = uh.user_id
left outer join user_register rvu on
wu.user_id = rvu.user_id
where wu.createtime between '$start_timestamp$' and '$end_timestamp$'
and wu.user_kind = '2' and rvu.reg_device in (0,4)) t
group by t.mscid, t.plan, t.unit, t.keyword;

-- 企业注册数， 区别企业类型
drop table if exists temp_task_bi_sem_keyword_collection_ecomp_reg_cnt0;
create table temp_task_bi_sem_keyword_collection_ecomp_reg_cnt0 (
d_mscid                string,
d_plan                 string,
d_unit                 string,
d_keyword              string,
ecomp_version          string,
ecomp_reg_cnt                int
);

insert overwrite table temp_task_bi_sem_keyword_collection_ecomp_reg_cnt0
select
t.mscid,
t.plan,
t.unit,
t.keyword,
t.ecomp_version,
count(distinct t.ecomp_id)
from
(
select 
-- 默认自然来源 
ifnull(split(rvu.reg_mscid,'#')[1], '00000000') as mscid, 
ifnull(rvu.reg_plan, '') as plan, 
ifnull(rvu.reg_unit, '') as unit, 
ifnull(rvu.reg_keyword, '') as keyword, 
ec.ecomp_version,
ec.ecomp_id
from ecomp ec join ecomp_user eu on ec.ecomp_id = eu.ecomp_id
join user_e ue on eu.user_id = ue.user_id
left outer join user_register rvu on ue.user_id = rvu.user_id
where ec.createtime between '$start_timestamp$' and '$end_timestamp$'
-- user e为管理员身份
and ue.e_role in ('1', '2')
and ec.delflag = '0' and rvu.reg_device in (0,4)) t
group by t.mscid, t.plan, t.unit, t.keyword, t.ecomp_version;
-- 橫表
drop table if exists temp_task_bi_sem_keyword_collection_ecomp_reg_cnt;
create table temp_task_bi_sem_keyword_collection_ecomp_reg_cnt (
d_mscid                string,
d_plan                 string,
d_unit                 string,
d_keyword              string,
ecomp_preview_reg_cnt                int,
ecomp_basic_reg_cnt                int,
ecomp_professional_reg_cnt                int,
ecomp_expire_reg_cnt                int
);

insert overwrite table temp_task_bi_sem_keyword_collection_ecomp_reg_cnt
select d_mscid, d_plan, d_unit, d_keyword,
-- 预览
sum(case when ecomp_version = '0' then ecomp_reg_cnt else 0 end),
-- 基础
sum(case when ecomp_version = '1' then ecomp_reg_cnt else 0 end),
-- 专业
sum(case when ecomp_version = '2' then ecomp_reg_cnt else 0 end),
-- 过期
sum(case when ecomp_version = '3' then ecomp_reg_cnt else 0 end)
from temp_task_bi_sem_keyword_collection_ecomp_reg_cnt0
group by d_mscid, d_plan, d_unit, d_keyword;

-- 审核通过简历
drop table if exists temp_task_bi_sem_keyword_collection_auditted_res_cnt;
create table temp_task_bi_sem_keyword_collection_auditted_res_cnt (
d_mscid                string,
d_plan                 string,
d_unit                 string,
d_keyword              string,
level_0_res_cnt                  int,
level_1_res_cnt                  int,
level_2_res_cnt                  int,
level_3_res_cnt                  int,
level_4_res_cnt                  int,
level_5_res_cnt                  int
);

insert overwrite table temp_task_bi_sem_keyword_collection_auditted_res_cnt
select
t.mscid,
t.plan,
t.unit,
t.keyword,
sum(case when t.res_level = 0 then 1 else 0 end),
sum(case when t.res_level = 1 then 1 else 0 end),
sum(case when t.res_level = 2 then 1 else 0 end),
sum(case when t.res_level = 3 then 1 else 0 end),
sum(case when t.res_level = 4 then 1 else 0 end),
sum(case when t.res_level = 5 then 1 else 0 end)
from
(
select 
ifnull(split(rvu.reg_mscid,'#')[1], '00000000') as mscid,
ifnull(rvu.reg_plan, '') as plan,
ifnull(rvu.reg_unit, '') as unit,
ifnull(rvu.reg_keyword, '') as keyword,
ru.res_level
from web_user wu 
join user_c uc
on wu.user_id = uc.user_id
join res_user ru on wu.user_id = ru.user_id
left outer join 
user_register rvu on wu.user_id = rvu.user_id
where wu.createtime between '$start_timestamp$' and '$end_timestamp$'
and wu.user_kind = '0'
-- 不为草稿
and ru.res_category != '8'
-- 不为待审核
and ru.res_category != '9'
and ru.delflag = '0' and rvu.reg_device in (0,4)) t
group by t.mscid, t.plan, t.unit, t.keyword;


-- 草稿/待审核简历
drop table if exists temp_task_bi_sem_keyword_collection_unaudit_res_cnt;
create table temp_task_bi_sem_keyword_collection_unaudit_res_cnt (
d_mscid                string,
d_plan                 string,
d_unit                 string,
d_keyword              string,
audit_res_cnt                  int,
draft_res_cnt                  int
);

insert overwrite table temp_task_bi_sem_keyword_collection_unaudit_res_cnt
select
t.mscid,
t.plan,
t.unit,
t.keyword,
sum(case when t.res_category = '9' then 1 else 0 end),
sum(case when t.res_category = '8' then 1 else 0 end)
from
(
select 
ifnull(split(rvu.reg_mscid,'#')[1], '00000000') as mscid,
ifnull(rvu.reg_plan, '') as plan,
ifnull(rvu.reg_unit, '') as unit,
ifnull(rvu.reg_keyword, '') as keyword,
wu.user_id,
ru.res_category
from web_user wu 
join user_c uc
on wu.user_id = uc.user_id
join res_user ru on wu.user_id = ru.user_id
left outer join user_register rvu 
on wu.user_id = rvu.user_id
where wu.createtime between '$start_timestamp$' and '$end_timestamp$'
and wu.user_kind = '0'
-- 为草稿/待审核
and ru.res_category in ('8', '9')
and ru.delflag = '0' and rvu.reg_device in (0,4)) t
group by t.mscid, t.plan, t.unit, t.keyword;


-- 中间合并结果。为了防止有重复的主键，还需要在处理一次。
drop table if exists fact_sem_keyword_collection0;
create table fact_sem_keyword_collection0 (
  d_mscid string,
  d_plan string,
  d_unit string,
  d_keyword string,
  apply_ejob_cnt int,
  apply_ejob_user_cnt int,
  apply_hjob_cnt int,
  apply_hjob_user_cnt int,
  subscribe_cnt int,
  subscribe_user_cnt int,
  favorites_cnt int,
  favorites_user_cnt int,
  follower_cnt int,
  follower_c_cnt int,
  follower_h_cnt int,
  uv_cnt int,
  c_reg_cnt int,
  h_reg_cnt int,
  h_audit_cnt int,
  ecomp_preview_reg_cnt int,
  ecomp_basic_reg_cnt int,
  ecomp_professional_reg_cnt int,
  ecomp_expire_reg_cnt int,
  -- deprecated
  eff_res_cnt int,
  -- deprecated
  res_cnt int,
  level_0_res_cnt int,
  level_1_res_cnt int,
  level_2_res_cnt int,
  level_3_res_cnt int,
  level_4_res_cnt int,
  level_5_res_cnt int,
  audit_res_cnt int,
  draft_res_cnt int
);

insert overwrite table fact_sem_keyword_collection0
select 
-- 需要在4个组合之中取关键字的并集
get_not_null(tuv.d_mscid, tcr.d_mscid, thr.d_mscid, ter.d_mscid, '00000000'),
upper(get_not_null(tuv.d_plan, tcr.d_plan, thr.d_plan, ter.d_plan, '')),
upper(get_not_null(tuv.d_unit, tcr.d_unit, thr.d_unit, ter.d_unit, '')),
upper(get_not_null(tuv.d_keyword, tcr.d_keyword, thr.d_keyword, ter.d_keyword, '')),
ifnull(tcr.apply_ejob_cnt, 0),
ifnull(tcr.apply_ejob_user_cnt, 0),
ifnull(tcr.apply_hjob_cnt, 0),
ifnull(tcr.apply_hjob_user_cnt, 0),
ifnull(tcr.subscribe_cnt, 0),
ifnull(tcr.subscribe_user_cnt, 0),
ifnull(tcr.favorites_cnt, 0),
ifnull(tcr.favorites_user_cnt, 0),
ifnull(tcr.follower_cnt, 0),
ifnull(tcr.follower_c_cnt, 0),
ifnull(tcr.follower_h_cnt, 0),
ifnull(tuv.uv_cnt, 0),
ifnull(tcr.c_reg_cnt, 0),
ifnull(thr.h_reg_cnt, 0),
ifnull(thr.h_audit_cnt, 0),
ifnull(ter.ecomp_preview_reg_cnt, 0),
ifnull(ter.ecomp_basic_reg_cnt, 0),
ifnull(ter.ecomp_professional_reg_cnt, 0),
ifnull(ter.ecomp_expire_reg_cnt, 0),
-- eff_res_cnt 已废弃
0,
-- res_cnt 已废弃
0,
ifnull(tcr.level_0_res_cnt, 0),
ifnull(tcr.level_1_res_cnt, 0),
ifnull(tcr.level_2_res_cnt, 0),
ifnull(tcr.level_3_res_cnt, 0),
ifnull(tcr.level_4_res_cnt, 0),
ifnull(tcr.level_5_res_cnt, 0),
ifnull(tcr.audit_res_cnt, 0),
ifnull(tcr.draft_res_cnt, 0) 
from 
-- 用uv和其他行为(注册)表做full outer join
temp_task_bi_sem_keyword_collection_uv_cnt tuv 
full outer join
-- C
(
select 
cr.d_mscid, cr.d_plan, cr.d_unit, cr.d_keyword,
-- 应聘企业
ae.apply_ejob_cnt, ae.apply_ejob_user_cnt,
-- 应聘猎头
ah.apply_hjob_cnt, ah.apply_hjob_user_cnt,
-- 订阅
js.subscribe_cnt, js.subscribe_user_cnt,
-- 收藏
jf.favorites_cnt, jf.favorites_user_cnt,
-- 关注
fl.follower_cnt, fl.follower_c_cnt, fl.follower_h_cnt,
-- 注册
cr.c_reg_cnt,
-- 简历
ar.level_0_res_cnt,
ar.level_1_res_cnt,
ar.level_2_res_cnt,
ar.level_3_res_cnt,
ar.level_4_res_cnt,
ar.level_5_res_cnt,
ur.audit_res_cnt,
ur.draft_res_cnt
from temp_task_bi_sem_keyword_collection_c_reg_cnt cr 
left outer join temp_task_bi_sem_keyword_collection_apply_ejob_cnt ae 
on (cr.d_mscid = ae.d_mscid and cr.d_plan = ae.d_plan and cr.d_unit = ae.d_unit and cr.d_keyword = ae.d_keyword) 
left outer join temp_task_bi_sem_keyword_collection_apply_hjob_cnt ah 
on (cr.d_mscid = ah.d_mscid and cr.d_plan = ah.d_plan and cr.d_unit = ah.d_unit and cr.d_keyword = ah.d_keyword) 
left outer join temp_task_bi_sem_keyword_collection_job_subscribe_cnt js 
on (cr.d_mscid = js.d_mscid and cr.d_plan = js.d_plan and cr.d_unit = js.d_unit and cr.d_keyword = js.d_keyword) 
left outer join temp_task_bi_sem_keyword_collection_job_favorites_cnt jf 
on (cr.d_mscid = jf.d_mscid and cr.d_plan = jf.d_plan and cr.d_unit = jf.d_unit and cr.d_keyword = jf.d_keyword) 
left outer join temp_task_bi_sem_keyword_collection_follower_cnt fl 
on (cr.d_mscid = fl.d_mscid and cr.d_plan = fl.d_plan and cr.d_unit = fl.d_unit and cr.d_keyword = fl.d_keyword) 
left outer join temp_task_bi_sem_keyword_collection_auditted_res_cnt ar 
on (cr.d_mscid = ar.d_mscid and cr.d_plan = ar.d_plan and cr.d_unit = ar.d_unit and cr.d_keyword = ar.d_keyword) 
left outer join temp_task_bi_sem_keyword_collection_unaudit_res_cnt ur 
on (cr.d_mscid = ur.d_mscid and cr.d_plan = ur.d_plan and cr.d_unit = ur.d_unit and cr.d_keyword = ur.d_keyword) 
) tcr
on (tuv.d_mscid = tcr.d_mscid and tuv.d_plan = tcr.d_plan and tuv.d_unit = tcr.d_unit and tuv.d_keyword = tcr.d_keyword)
-- H
full outer join temp_task_bi_sem_keyword_collection_h_reg_cnt thr 
on (tuv.d_mscid = thr.d_mscid and tuv.d_plan = thr.d_plan and tuv.d_unit = thr.d_unit and tuv.d_keyword = thr.d_keyword)
-- E
full outer join temp_task_bi_sem_keyword_collection_ecomp_reg_cnt ter 
on (tuv.d_mscid = ter.d_mscid and tuv.d_plan = ter.d_plan and tuv.d_unit = ter.d_unit and tuv.d_keyword = ter.d_keyword)
;

-- 再次合并
create table if not exists fact_sem_keyword_collection (
  d_date                 int,
  d_mscid string,
  d_plan string,
  d_unit string,
  d_keyword string,
  apply_ejob_cnt int,
  apply_ejob_user_cnt int,
  apply_hjob_cnt int,
  apply_hjob_user_cnt int,
  subscribe_cnt int,
  subscribe_user_cnt int,
  favorites_cnt int,
  favorites_user_cnt int,
  follower_cnt int,
  follower_c_cnt int,
  follower_h_cnt int,
  uv_cnt int,
  c_reg_cnt int,
  h_reg_cnt int,
  h_audit_cnt int,
  ecomp_preview_reg_cnt int,
  ecomp_basic_reg_cnt int,
  ecomp_professional_reg_cnt int,
  ecomp_expire_reg_cnt int,
  -- deprecated
  eff_res_cnt int,
  -- deprecated
  res_cnt int,
  level_0_res_cnt int,
  level_1_res_cnt int,
  level_2_res_cnt int,
  level_3_res_cnt int,
  level_4_res_cnt int,
  level_5_res_cnt int,
  audit_res_cnt int,
  draft_res_cnt int,
  creation_timestamp     string
) partitioned by (p_date int);

insert overwrite table fact_sem_keyword_collection partition (p_date = $date$)
select
$date$, 
a.d_mscid,
a.d_plan,
a.d_unit,
a.d_keyword,
sum(a.apply_ejob_cnt),
sum(a.apply_ejob_user_cnt),
sum(a.apply_hjob_cnt),
sum(a.apply_hjob_user_cnt),
sum(a.subscribe_cnt),
sum(a.subscribe_user_cnt),
sum(a.favorites_cnt),
sum(a.favorites_user_cnt),
sum(a.follower_cnt),
sum(a.follower_c_cnt),
sum(a.follower_h_cnt),
sum(a.uv_cnt),
sum(a.c_reg_cnt),
sum(a.h_reg_cnt),
sum(a.h_audit_cnt),
sum(a.ecomp_preview_reg_cnt),
sum(a.ecomp_basic_reg_cnt),
sum(a.ecomp_professional_reg_cnt),
sum(a.ecomp_expire_reg_cnt),
sum(a.eff_res_cnt),
sum(a.res_cnt),
sum(a.level_0_res_cnt),
sum(a.level_1_res_cnt),
sum(a.level_2_res_cnt),
sum(a.level_3_res_cnt),
sum(a.level_4_res_cnt),
sum(a.level_5_res_cnt),
sum(a.audit_res_cnt),
sum(a.draft_res_cnt),
from_unixtime(unix_timestamp())
from
fact_sem_keyword_collection0 a join dim_mscid b on a.d_mscid = b.d_mscid
group by a.d_mscid, a.d_plan, a.d_unit, a.d_keyword;