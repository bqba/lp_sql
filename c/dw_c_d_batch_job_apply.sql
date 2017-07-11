create table if not exists dw_c_d_batch_job_apply
(
	d_date int comment '日期',
	action_source int comment '应聘客户端 0 PC,1苹果,2 安卓,4 H5',
	user_id int comment '经理人id',
	job_kind string comment '职位类型 1 猎头,2 企业,3 抓取',
	job_id int comment '职位id',
	creation_timestamp timestamp comment '时间戳'
) comment 'C端用户批量应聘记录表'
partitioned by (p_date int);

insert overwrite table dw_c_d_batch_job_apply partition (p_date = $date$)
select 
p_date as d_date,
action_source,
user_id,
job_kind,
job_id,
from_unixtime(unix_timestamp()) as creation_timestamp
from 
(
select p_date,
       action_source,
       actor_id as user_id,
       get_json_object(action_info, '$.job_kind') as job_kind,
	   get_json_object(action_info, '$.job_id') as job_id,
	   row_number()over(distribute by actor_id,get_json_object(action_info, '$.job_id') sort by action_datetime desc) rn 
from blog 
where action_kind = 'APPLY-JOB'
     and get_json_object(action_info, '$.apply_kind') ='batch'  --批量应聘
	 and p_date = $date$
	 and actor_id > 0
	 and actor_kind = '0'
) bl
where rn = 1
