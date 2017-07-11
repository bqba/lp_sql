create table if not exists dw_c_d_usermsc_act (
user_id int comment '用户主键',
action_source string comment '终端类型',
msc_id string comment '媒体码' ,
res_refresh_cnt int comment '简历刷新次数',
res_update_cnt int comment '简历修改次数',
res_full_return int comment '完整回归简历数',
res_biz_return int comment '商业回归简历数',
res_view int comment '简历被HR查看次数',
job_search_pv int comment '职位搜索次数',
creation_timestamp timestamp  comment '时间戳'
) partitioned by (p_date int);


insert overwrite table dw_c_d_usermsc_act partition (p_date = $date$)
select 
user_id,
action_source,
msc_id,
sum(res_refresh_cnt) as res_refresh_cnt, 
sum(res_update_cnt) as res_update_cnt,
sum(res_full_return) as res_full_return ,
sum(res_biz_return) as res_biz_return,
sum(res_view) as res_view,
sum(job_search_pv) as job_search_pv,
from_unixtime(unix_timestamp())
from 
(
	select ru.user_id,
	bl.action_source,
	msc_id as msc_id,
	0 as res_refresh_cnt,
	count(*) as res_update_cnt,
	count (
		case when res_original_category != '1' and res_current_category ='1'
		and ru.createtime != p_date then ru.res_id else null end ) res_full_return,
	count (
		case when res_original_category != '1' and res_current_category ='1'
		and ru.createtime != p_date and res_current_level>=2 and res_original_level <2  then ru.res_id else null end ) res_biz_return,
	0 as res_view,
	0 as job_search_pv
	from (	
		select res_id,action_source,msc_id,res_original_category,res_current_category,res_original_level,res_current_level,p_date
		from (
			select  get_json_object(b.action_info,'$.res_id') res_id,p_date,
				last_value(action_source) over(distribute by get_json_object(b.action_info,'$.res_id') sort by action_datetime rows between unbounded preceding and  unbounded following) action_source,
				last_value(case when action_source = '10' then '9_gcdc_0' else split(msc_id,'#')[1] end) over(distribute by get_json_object(b.action_info,'$.res_id') sort by action_datetime rows between unbounded preceding and  unbounded following ) msc_id,
				first_value(get_json_object(action_info,'$.res_original_category')) over(distribute by get_json_object(b.action_info,'$.res_id') sort by action_datetime rows between unbounded preceding and  unbounded following) res_original_category,
				last_value(get_json_object(action_info,'$.res_current_category')) over(distribute by get_json_object(b.action_info,'$.res_id') sort by action_datetime rows between unbounded preceding and  unbounded following) res_current_category,
				first_value(get_json_object(action_info,'$.res_original_level')) over(distribute by get_json_object(b.action_info,'$.res_id')  sort by action_datetime rows between unbounded preceding and  unbounded following) res_original_level,
				last_value(get_json_object(action_info,'$.res_current_level')) over(distribute by get_json_object(b.action_info,'$.res_id')  sort by action_datetime rows between unbounded preceding and  unbounded following) res_current_level,
				row_number()over(distribute by get_json_object(b.action_info,'$.res_id')  sort by action_datetime desc) rnum		
		  from blog b			
		 where action_kind = 'CHANGE-RESUME_LEVEL'
		   and p_date = $date$ 
		   and actor_id != 0
		 ) b 
		 where rnum = 1
	) bl 	
	join res_user ru 
	on bl.res_id = ru.res_id
	group by ru.user_id,bl.action_source,msc_id

	union all 	
	select user_id,
			case when info in ('C000000353','C000000385') then 4
				 when info = 'c_resume_refresh' then 0
			end as action_source,
			el_mscid msc_id,
			count(1) as res_refresh_cnt, 
			0 as res_update_cnt,
			0 as res_full_return,
			0 as res_biz_return,
			0 as res_view,
			0 as job_search_pv
	from tlog
	where p_date = $date$ 
	and nvl(user_id,0)!= 0
	and type = 'c'
	and info in ('c_resume_refresh','C000000353','C000000385')
	group by user_id,
			case when info in ('C000000353','C000000385') then 4
				 when info = 'c_resume_refresh' then 0
			end , 
			el_mscid
	union all 
	select user_id,
			case when os like '%iPhone%' then 1
				 when os like '%ANDROID%' then 2
			end as action_source,	 
			'99999999' as msc_id , 
			count(1) as res_refresh_cnt, 
			0 as res_update_cnt,
			0 as res_full_return,
			0 as res_biz_return,
			0 as res_view,
			0 as job_search_pv
	from app_tlog
	where name = 'C000000386'
	and p_date = $date$ 
	group by user_id,
			case when os like '%iPhone%' then 1
				 when os like '%ANDROID%' then 2
			end 	
	union all 
	select
		ru.user_id,
		resview.action_source,
		resview.msc_id,
		0 as res_refresh_cnt, 
		0 as res_update_cnt,
		0 as res_full_return,
		0 as res_biz_return,
		resview.res_view as res_view,
		0 as job_search_pv		
	from 
	(select p_date,
		   nvl(get_json_object(data_info,'$.res_id'),decode_res_id(extract_url_param(url,'res_id_encode'))) as res_id,
		   '0' as action_source,
		   el_mscid as msc_id,
	      count(*) as res_view
	 from tlog
	where user_kind = '1'
	    and user_id>0 
		and p_date = $date$     --修改
		and type = 'p'
		and (url regexp 'https://lpt.liepin.com/resume/showresumedetail/.*res_id_encode.*'
		    or url regexp 'https://lpt.liepin.com/resume/showrecommendresumedetail/.*res_id_encode.*')
	group by p_date,nvl(get_json_object(data_info,'$.res_id'),decode_res_id(extract_url_param(url,'res_id_encode'))),el_mscid
	) resview 
	join res_user ru 
	on resview.res_id = ru.res_id


	union all 

	select  jobsearch.user_id,
			jobsearch.action_source,
			jobsearch.msc_id,
			0 as res_refresh_cnt, 
			0 as res_update_cnt,
			0 as res_full_return,
			0 as res_biz_return,
			0 as res_view,	
			sum(job_search_pv) as job_search_pv
	from
		(
		select user_id,
		'0' as action_source,
		el_mscid as  msc_id,
		count(*) as job_search_pv    --PC
		from tlog 
		where url regexp 'http(|s)://www\.liepin\.com/zhaopin.*init=.*'
			and p_date = $date$   --日期参数需要替换
			and type = 'p'
			and domain = 'www.liepin.com'
			and user_id > 0
			and user_kind = '0' -- 经理人
			and extract_url_param(regexp_replace(url,'#','?'),'init') = '1' --未翻页
		group by user_id,el_mscid

		union all

		select  actor_id as user_id,
				action_source,
				msc_id , 
				count(*) as job_search_pv     --	h5,APP
		from blog
		where action_kind = 'SEARCH-JOB'
			and p_date = $date$ 
			and actor_id>0 
			and nvl(get_json_object(action_info,'$.page'),'0')= '0' 
			and actor_kind = '0'
		group by actor_id,action_source,msc_id
		) jobsearch 
	group by jobsearch.user_id,jobsearch.action_source,jobsearch.msc_id

) t
group by user_id,msc_id,action_source;




--20160906之前
create table if not exists dw_c_d_usermsc_act (
user_id int ,
action_source string,
msc_id string ,
res_refresh_cnt int ,
res_update_cnt int ,
res_full_return int ,
res_biz_return int, 
creation_timestamp timestamp
) partitioned by (p_date int);

insert overwrite table dw_c_d_usermsc_act partition (p_date = $date$)
select user_id,
action_source,
msc_id,
sum(res_refresh_cnt) as res_refresh_cnt, 
sum(res_update_cnt) as res_update_cnt,
sum(res_full_return) res_full_return ,
sum(res_biz_return),
from_unixtime(unix_timestamp())
from 
(
	select ru.user_id,
	bl.action_source,
	msc_id as msc_id,
	0 as res_refresh_cnt,
	count(*) as res_update_cnt,
	count (
		case when res_original_category != '1' and res_current_category ='1'
		and ru.createtime != p_date then ru.res_id else null end ) res_full_return,
	count (
		case when res_original_category != '1' and res_current_category ='1'
		and ru.createtime != p_date and res_current_level>=2 and res_original_level <2  then ru.res_id else null end ) res_biz_return	
	from (	
		select res_id,action_source,msc_id,res_original_category,res_current_category,res_original_level,res_current_level,p_date
		from (
			select  get_json_object(b.action_info,'$.res_id') res_id,p_date,
				last_value(action_source) over(distribute by get_json_object(b.action_info,'$.res_id') sort by action_datetime rows between unbounded preceding and  unbounded following) action_source,
				last_value(case when action_source = '10' then '9_gcdc_0' else split(msc_id,'#')[1] end) over(distribute by get_json_object(b.action_info,'$.res_id') sort by action_datetime rows between unbounded preceding and  unbounded following ) msc_id,
				first_value(get_json_object(action_info,'$.res_original_category')) over(distribute by get_json_object(b.action_info,'$.res_id') sort by action_datetime rows between unbounded preceding and  unbounded following) res_original_category,
				last_value(get_json_object(action_info,'$.res_current_category')) over(distribute by get_json_object(b.action_info,'$.res_id') sort by action_datetime rows between unbounded preceding and  unbounded following) res_current_category,
				first_value(get_json_object(action_info,'$.res_original_level')) over(distribute by get_json_object(b.action_info,'$.res_id')  sort by action_datetime rows between unbounded preceding and  unbounded following) res_original_level,
				last_value(get_json_object(action_info,'$.res_current_level')) over(distribute by get_json_object(b.action_info,'$.res_id')  sort by action_datetime rows between unbounded preceding and  unbounded following) res_current_level,
				row_number()over(distribute by get_json_object(b.action_info,'$.res_id')  sort by action_datetime desc) rnum		
		  from blog b			
		 where action_kind = 'CHANGE-RESUME_LEVEL'
		   and p_date = '$date$'
		   and actor_id != 0
		 ) b 
		 where rnum = 1
	) bl 	
	join res_user ru 
	on bl.res_id = ru.res_id
	group by ru.user_id,bl.action_source,msc_id

	union all 	
	select user_id,
			case when info in ('C000000353','C000000385') then 4
				 when info = 'c_resume_refresh' then 0
			end as action_source,
			el_mscid msc_id,count(1) as res_refresh_cnt, 0 as res_update_cnt,0 as res_full_return,0 as res_biz_return
	from tlog
	where p_date = '$date$'
	and nvl(user_id,0)!= 0
	and type = 'c'
	and info in ('c_resume_refresh','C000000353','C000000385')
	group by user_id,
			case when info in ('C000000353','C000000385') then 4
				 when info = 'c_resume_refresh' then 0
			end , 
			el_mscid
	union all 
	select user_id,
			case when os like '%iPhone%' then 1
				 when os like '%ANDROID%' then 2
			end as action_source,	 
			'99999999' as msc_id , count(1) as res_refresh_cnt, 0 res_update_cnt,0 as res_full_return,0 as res_biz_return
	from app_tlog
	where name = 'C000000386'
	and p_date = '$date$'
	group by user_id,
			case when os like '%iPhone%' then 1
				 when os like '%ANDROID%' then 2
			end 	
	union all 
				
	select p_date,if(get_json_object(data_info,'$.res_id') is null,decode_res_id(extract_url_param(url,'res_id_encode')),get_json_object(data_info,'$.res_id')) as res_id,
		   count(*) as res_view
	from tlog
	where user_kind = '1'
		and user_id>0 
		and p_date = '$date$'   --修改
		and type = 'p'
		and url regexp 'https://lpt.liepin.com/resume/showresumedetail/.*res_id_encode.*'
			or url regexp 'https://lpt.liepin.com/resume/showrecommendresumedetail/.*res_id_encode.*'
	group by p_date,if(get_json_object(data_info,'$.res_id') is null,decode_res_id(extract_url_param(url,'res_id_encode')),get_json_object(data_info,'$.res_id')) as res_id


) t
group by user_id,msc_id,action_source;

alter table dw_c_d_usermsc_act change user_id user_id int comment '用户主键';
alter table dw_c_d_usermsc_act change action_source action_source string comment '终端类型';
alter table dw_c_d_usermsc_act change msc_id msc_id string comment '媒体码';
alter table dw_c_d_usermsc_act change res_refresh_cnt res_refresh_cnt int comment '简历刷新次数';
alter table dw_c_d_usermsc_act change res_update_cnt res_update_cnt int comment '简历修改次数';
alter table dw_c_d_usermsc_act change res_full_return res_full_return int comment '完整回归简历数';
alter table dw_c_d_usermsc_act change res_biz_return res_biz_return int comment '商业回归简历数';
alter table dw_c_d_usermsc_act change creation_timestamp creation_timestamp timestamp comment '时间戳';