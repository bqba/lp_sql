create table if not exists fact_c_d_base(
c_msc_id string,
c_reg_source string,
c_jobtitle string,
c_dq string,
c_industry string ,
c_user_cnt_new int ,
c_user_card_cnt_new int ,
c_res_cnt_new int ,
c_res_draft_cnt_new int ,
c_res_full_cnt_new int ,
c_res_biz_cnt_new int ,
c_res_level1_cnt_new int ,
c_res_level2_cnt_new int ,
c_res_level3_cnt_new int ,
c_res_level4_cnt_new int ,
c_res_level5_cnt_new int ,
c_res_level6_cnt_new int ,
c_res_draft_cnt_instant_new int ,
c_res_full_cnt_instant_new int ,
c_res_biz_cnt_instant_new int ,
c_res_level1_cnt_instant_new int ,
c_res_level2_cnt_instant_new int ,
c_res_level3_cnt_instant_new int ,
c_res_level4_cnt_instant_new int ,
c_res_level5_cnt_instant_new int ,
c_res_level6_cnt_instant_new int ,
c_user_cnt_total int ,
c_res_biz_cnt_total int ,
c_res_full_cnt_total int ,
c_res_draft_cnt_total int ,
c_res_level1_cnt_total int ,
c_res_level2_cnt_total int ,
c_res_level3_cnt_total int ,
c_res_level4_cnt_total int ,
c_res_level5_cnt_total int ,
c_res_level6_cnt_total int ,
c_res_bizreturn_cnt_new int ,
c_res_fullreturn_cnt_new int ,
c_res_zdreturn_cnt_new int ,
c_user_res_modify_cnt int ,
c_user_res_refresh_cnt int ,
creation_timestamp timestamp
) partitioned by (p_date int);

insert overwrite table fact_c_d_base partition (p_date = $date$)
select 
reg_mscid,
reg_device,
c_jobtitle,
c_dq,
c_industry,
count(distinct case when regexp_replace(to_date(u.c_createtime),'-','')  = '$date$' then u.user_id end)as c_user_cnt_new,--新增注册数 web_user createtime
count(distinct case when (t.res_createtime != t.res_audittime or to_date(t.res_audittime) is null) and regexp_replace(to_date(t.res_createtime),'-','')  = '$date$' then t.user_id end) as c_user_card_cnt_new,--新增名片数
count( case when t.res_category in ('8','1') then t.res_id end) -count( case when tt.res_category  in ('8','1') then tt.res_id end)  as c_res_cnt_new,--新增简历数
count( case when t.res_category = '8' then t.res_id end) -count( case when tt.res_category = '8' then tt.res_id end)  as c_res_draft_cnt_new,--新增草稿简历 今天累计-昨天累计 
count( case when t.res_category = '1' then t.res_id end)  -count( case when tt.res_category = '1' then tt.res_id end)   as c_res_full_cnt_new,--新增完整简历 今天累计-昨天累计 
count( case when t.res_category = '1' and t.res_level in (2,3,4,5,6) then t.res_id end)  - count( case when tt.res_category = '1' and tt.res_level in (2,3,4,5,6) then tt.res_id end) as   c_res_biz_cnt_new, --新增商业简历 今天累计-昨天累计 
count( case when t.res_category = '1' and t.res_level=1 then t.res_id end)  - count( case when tt.res_category = '1' and tt.res_level =1 then tt.res_id end) as   c_res_level1_cnt_new, --新增1级简历 
count( case when t.res_category = '1' and t.res_level=2 then t.res_id end)  - count( case when tt.res_category = '1' and tt.res_level =2 then tt.res_id end) as   c_res_level2_cnt_new, --新增2级简历 
count( case when t.res_category = '1' and t.res_level=3 then t.res_id end)  - count( case when tt.res_category = '1' and tt.res_level =3 then tt.res_id end) as   c_res_level3_cnt_new, --新增3级简历 
count( case when t.res_category = '1' and t.res_level=4 then t.res_id end)  - count( case when tt.res_category = '1' and tt.res_level =4 then tt.res_id end) as   c_res_level4_cnt_new, --新增4级简历 
count( case when t.res_category = '1' and t.res_level=5 then t.res_id end)  - count( case when tt.res_category = '1' and tt.res_level =5 then tt.res_id end) as   c_res_level5_cnt_new, --新增5级简历 
count( case when t.res_category = '1' and t.res_level=6 then t.res_id end)  - count( case when tt.res_category = '1' and tt.res_level =6 then tt.res_id end) as   c_res_level6_cnt_new, --新增6级简历 
count( case when (regexp_replace(to_date(t.c_createtime),'-','')  = '$date$'  and regexp_replace(to_date(t.res_createtime),'-','')  = '$date$'   and  t.res_category = '8') then t.res_id end) as c_res_draft_cnt_instant_new,--新增即时草稿
count( case when (regexp_replace(to_date(t.c_createtime),'-','')  = '$date$'  and regexp_replace(to_date(t.res_audittime),'-','')  = '$date$'  and t.res_category = '1') then t.res_id end) as c_res_full_cnt_instant_new,--新增即时完整
count( case when (regexp_replace(to_date(t.c_createtime),'-','')  = '$date$'  and regexp_replace(to_date(t.res_audittime),'-','')  = '$date$'  and t.res_category = '1'  and t.res_level in (2,3,4,5,6)) then t.res_id end) as c_res_biz_cnt_instant_new,--新增即时商业
count( case when (regexp_replace(to_date(t.c_createtime),'-','')  = '$date$'  and regexp_replace(to_date(t.res_audittime),'-','')  = '$date$'  and t.res_category = '1'  and t.res_level =1 ) then t.res_id end) as c_res_level1_cnt_instant_new,--新增即时1 级
count( case when (regexp_replace(to_date(t.c_createtime),'-','')  = '$date$'  and regexp_replace(to_date(t.res_audittime),'-','')  = '$date$'  and t.res_category = '1'  and t.res_level =2 ) then t.res_id end) as c_res_level2_cnt_instant_new,--新增即时2 级
count( case when (regexp_replace(to_date(t.c_createtime),'-','')  = '$date$'  and regexp_replace(to_date(t.res_audittime),'-','')  = '$date$'  and t.res_category = '1'  and t.res_level =3 ) then t.res_id end) as c_res_level3_cnt_instant_new,--新增即时3 级
count( case when (regexp_replace(to_date(t.c_createtime),'-','')  = '$date$'  and regexp_replace(to_date(t.res_audittime),'-','')  = '$date$'  and t.res_category = '1'  and t.res_level =4 ) then t.res_id end) as c_res_level4_cnt_instant_new,--新增即时4 级
count( case when (regexp_replace(to_date(t.c_createtime),'-','')  = '$date$'  and regexp_replace(to_date(t.res_audittime),'-','')  = '$date$'  and t.res_category = '1'  and t.res_level =5 ) then t.res_id end) as c_res_level5_cnt_instant_new,--新增即时5 级
count( case when (regexp_replace(to_date(t.c_createtime),'-','')  = '$date$'  and regexp_replace(to_date(t.res_audittime),'-','')  = '$date$'  and t.res_category = '1'  and t.res_level =6 ) then t.res_id end) as c_res_level6_cnt_instant_new,--新增即时6 级
count(distinct u.user_id) as c_user_cnt_total, --累计注册数
count( case when t.res_category = '1' and t.res_level in (2,3,4,5,6) then t.res_id end) as c_res_biz_cnt_total,--累计商业简历
count( case when t.res_category = '1' then t.res_id end) as c_res_full_cnt_total,--累计完整简历
count( case when t.res_category = '8' then t.res_id end) as c_res_draft_cnt_total,--累计草稿简历
count( case when t.res_level = 1 and t.res_category = '1' then t.res_id end) as c_res_level1_cnt_total,  --累计1级简历
count( case when t.res_level = 2 and t.res_category = '1' then t.res_id end) as c_res_level2_cnt_total,  --累计2级简历
count( case when t.res_level = 3 and t.res_category = '1' then t.res_id end) as c_res_level3_cnt_total,  --累计3级简历
count( case when t.res_level = 4 and t.res_category = '1' then t.res_id end) as c_res_level4_cnt_total,  --累计4级简历
count( case when t.res_level = 5 and t.res_category = '1' then t.res_id end) as c_res_level5_cnt_total,  --累计5级简历
count( case when t.res_level = 6 and t.res_category = '1' then t.res_id end) as c_res_level6_cnt_total,  --累计6级简历
count( case when usermsc.user_id is not null and res_full_return = 1 then t.res_id else null end) as c_res_bizreturn_cnt_new,--新增商业回归
count( case when usermsc.user_id is not null and res_biz_return = 1 then t.res_id else null end) as c_res_fullreturn_cnt_new, --新增完整回归
count( case when usermsc.user_id is not null and res_full_return_zd = 1 then t.res_id else null end) as c_res_zdreturn_cnt_new, --新增主动回归(GCDC或者Email召回)
count( distinct case when usermsc.user_id is not null and res_update = 1 then  usermsc.user_id else null end) as c_user_res_modify_cnt,--简历修改用户数
count( distinct case when usermsc.user_id is not null and res_refresh = 1 then  usermsc.user_id else null end) as c_user_res_refresh_cnt, --简历更新用户数
from_unixtime(unix_timestamp())
from 
(select reg_mscid,reg_device,c_jobtitle,c_dq,c_industry,createtime as c_createtime ,user_id
   from dw_c_d_user_base
  where p_date = '$date$'
   ) u
left outer join 
( select c_createtime,res_createtime,user_id,res_id,res_category,res_level,res_audittime
 from dw_c_d_res_base
 where p_date = '$date$'
) t 
on u.user_id = t.user_id
left outer join 
( select c_createtime,res_createtime,user_id,res_id,res_category,res_level,res_audittime
 from dw_c_d_res_base  
 where p_date = regexp_replace( substr(date_add(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-',substr('$date$',7,2)),-1),1,10),'-','')
) tt
on u.user_id = tt.user_id
left outer join 
(select user_id,
  case when sum(res_refresh_cnt  ) > 0 then 1 else 0 end res_refresh ,
  case when sum(res_update_cnt  ) > 0 then 1 else 0 end res_update ,
  case when sum(res_full_return  ) > 0 then 1 else 0 end res_full_return ,
  case when sum(res_biz_return  ) > 0 then 1 else 0 end res_biz_return ,
  case when sum(case when act.msc_id = '9_gcdc_0' or nvl(msc.d_class_2,'99') = '邮件推广' then res_full_return else 0 end ) > 0 then 1 else 0 end res_full_return_zd
 from dw_c_d_usermsc_act act
     left outer join dim_mscid msc 
        on act.msc_id = msc.d_mscid
 where p_date ='$date$'
   group by user_id
) usermsc
on t.user_id = usermsc.user_id
group by 
reg_mscid,
reg_device,
c_jobtitle,
c_dq,
c_industry;

alter table fact_c_d_base change c_msc_id c_msc_id string comment '媒体码';
alter table fact_c_d_base change c_reg_source c_reg_source string comment '终端类型';
alter table fact_c_d_base change c_jobtitle c_jobtitle string comment '职位等级';
alter table fact_c_d_base change c_dq c_dq string comment '地区';
alter table fact_c_d_base change c_industry c_industry string comment '行业';
alter table fact_c_d_base change c_user_cnt_new c_user_cnt_new int comment '新增C注册数 ';
alter table fact_c_d_base change c_user_card_cnt_new c_user_card_cnt_new int comment '新增C名片数 ';
alter table fact_c_d_base change c_res_cnt_new c_res_cnt_new int comment '新增简历数';
alter table fact_c_d_base change c_res_draft_cnt_new c_res_draft_cnt_new int comment '新增草稿简历数 ';
alter table fact_c_d_base change c_res_full_cnt_new c_res_full_cnt_new int comment '新增完整简历数';
alter table fact_c_d_base change c_res_biz_cnt_new c_res_biz_cnt_new int comment '新增商业简历数  ';
alter table fact_c_d_base change c_res_level1_cnt_new c_res_level1_cnt_new int comment '新增1级简历数 ';
alter table fact_c_d_base change c_res_level2_cnt_new c_res_level2_cnt_new int comment '新增2级简历数 ';
alter table fact_c_d_base change c_res_level3_cnt_new c_res_level3_cnt_new int comment '新增3级简历数 ';
alter table fact_c_d_base change c_res_level4_cnt_new c_res_level4_cnt_new int comment '新增4级简历数 ';
alter table fact_c_d_base change c_res_level5_cnt_new c_res_level5_cnt_new int comment '新增5级简历数 ';
alter table fact_c_d_base change c_res_level6_cnt_new c_res_level6_cnt_new int comment '新增6级简历数 ';
alter table fact_c_d_base change c_res_draft_cnt_instant_new c_res_draft_cnt_instant_new int comment '新增即时草稿简历';
alter table fact_c_d_base change c_res_full_cnt_instant_new c_res_full_cnt_instant_new int comment '新增即时完整简历';
alter table fact_c_d_base change c_res_biz_cnt_instant_new c_res_biz_cnt_instant_new int comment '新增即时商业简历';
alter table fact_c_d_base change c_res_level1_cnt_instant_new c_res_level1_cnt_instant_new int comment '新增即时1级简历数 ';
alter table fact_c_d_base change c_res_level2_cnt_instant_new c_res_level2_cnt_instant_new int comment '新增即时2级简历数 ';
alter table fact_c_d_base change c_res_level3_cnt_instant_new c_res_level3_cnt_instant_new int comment '新增即时3级简历数 ';
alter table fact_c_d_base change c_res_level4_cnt_instant_new c_res_level4_cnt_instant_new int comment '新增即时4级简历数 ';
alter table fact_c_d_base change c_res_level5_cnt_instant_new c_res_level5_cnt_instant_new int comment '新增即时5级简历数 ';
alter table fact_c_d_base change c_res_level6_cnt_instant_new c_res_level6_cnt_instant_new int comment '新增即时6级简历数 ';
alter table fact_c_d_base change c_user_cnt_total c_user_cnt_total int comment '累计C注册人数 ';
alter table fact_c_d_base change c_res_biz_cnt_total c_res_biz_cnt_total int comment '累计商业简历数 ';
alter table fact_c_d_base change c_res_full_cnt_total c_res_full_cnt_total int comment '累计完整简历数 ';
alter table fact_c_d_base change c_res_draft_cnt_total c_res_draft_cnt_total int comment '累计草稿简历数 ';
alter table fact_c_d_base change c_res_level1_cnt_total c_res_level1_cnt_total int comment '累计1级简历数 ';
alter table fact_c_d_base change c_res_level2_cnt_total c_res_level2_cnt_total int comment '累计2级简历数';
alter table fact_c_d_base change c_res_level3_cnt_total c_res_level3_cnt_total int comment '累计3级简历数';
alter table fact_c_d_base change c_res_level4_cnt_total c_res_level4_cnt_total int comment '累计4级简历数';
alter table fact_c_d_base change c_res_level5_cnt_total c_res_level5_cnt_total int comment '累计5级简历数';
alter table fact_c_d_base change c_res_level6_cnt_total c_res_level6_cnt_total int comment '累计6级简历数';
alter table fact_c_d_base change c_res_bizreturn_cnt_new c_res_bizreturn_cnt_new int comment '新增商业回归简历数';
alter table fact_c_d_base change c_res_fullreturn_cnt_new c_res_fullreturn_cnt_new int comment '新增完整回归简历数';
alter table fact_c_d_base change c_res_zdreturn_cnt_new c_res_zdreturn_cnt_new int comment '新增主动召回简历数';
alter table fact_c_d_base change c_user_res_modify_cnt c_user_res_modify_cnt int comment '简历修改人数';
alter table fact_c_d_base change c_user_res_refresh_cnt c_user_res_refresh_cnt int comment '简历刷新按钮点击人数';
alter table fact_c_d_base change creation_timestamp creation_timestamp timestamp comment '时间戳';
