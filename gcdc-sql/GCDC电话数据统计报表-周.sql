create table fact_h_gcdc_w_call_serviceuser
(
d_date int comment '统计日期',
serviceuser_id int comment '顾问ID',
serviceuser_name string comment '顾问姓名',
branch_id int comment '顾问区域ID',
branch_name string comment '顾问区域',
serviceuser_org_id int comment '顾问所在团队ID',
serviceuser_org_name string comment '顾问所在团队',
position_channel string comment '岗位通道ID',
position_channel_name string comment '岗位通道',
position_id int comment '岗位ID',
position_name string comment '岗位',
cust_cover_cnt int comment '覆盖客户数',
candidate_cover_cnt int comment '覆盖经理人人数',
call_in_cust_cnt int comment '呼入客户电话数',
call_in_cust_timelong float comment '呼入客户电话时长',
call_in_candidate_cnt int comment '呼入经理人电话数',
call_in_candidate_timelong float comment '呼入经理人电话时长',
call_out_cust_cnt int comment '呼出客户电话数',
call_out_cust_timelong float comment '呼出客户电话时长',
call_out_candidate_cnt int comment '呼出经理人电话数',
call_out_candidate_timelong float comment '呼出经理人电话时长',
total_cust_cnt int comment '合计客户电话数',
total_cust_timelong float comment '合计客户电话时长',
total_candidate_cnt int comment '合计经理人电话数',
total_candidate_timelong float comment '合计经理人电话时长',
creation_timestamp timestamp comment '时间戳'
) comment 'GCDC电话数据统计-顾问-周'
partitioned by (p_date int);

create table fact_h_gcdc_w_call_serviceuser
(
d_date int comment '统计日期',
serviceuser_id int comment '顾问ID',
serviceuser_name varchar(100) comment '顾问姓名',
branch_id int comment '顾问区域ID',
branch_name varchar(100) comment '顾问区域',
serviceuser_org_id int comment '顾问所在团队ID',
serviceuser_org_name varchar(100) comment '顾问所在团队',
position_channel varchar(100) comment '岗位通道ID',
position_channel_name varchar(100) comment '岗位通道',
position_id int comment '岗位ID',
position_name varchar(100) comment '岗位',
cust_cover_cnt int comment '覆盖客户数',
candidate_cover_cnt int comment '覆盖经理人人数',
call_in_cust_cnt int comment '呼入客户电话数',
call_in_cust_timelong float comment '呼入客户电话时长',
call_in_candidate_cnt int comment '呼入经理人电话数',
call_in_candidate_timelong float comment '呼入经理人电话时长',
call_out_cust_cnt int comment '呼出客户电话数',
call_out_cust_timelong float comment '呼出客户电话时长',
call_out_candidate_cnt int comment '呼出经理人电话数',
call_out_candidate_timelong float comment '呼出经理人电话时长',
total_cust_cnt int comment '合计客户电话数',
total_cust_timelong float comment '合计客户电话时长',
total_candidate_cnt int comment '合计经理人电话数',
total_candidate_timelong float comment '合计经理人电话时长',
creation_timestamp  timestamp default CURRENT_TIMESTAMP,
primary key(d_date, serviceuser_id)
) comment 'GCDC电话数据统计-顾问-周';

alter table fact_h_gcdc_w_call_serviceuser add columns(call_in_other_cnt int comment '呼入其它电话数',
call_in_other_timelong float comment '呼入其它电话时长',
call_out_other_cnt int comment '呼出其它电话数',
call_out_other_timelong float comment '呼出其它电话时长',
total_other_cnt int comment '合计其它电话数',
total_other_timelong float comment '合计其它电话时长') cascade;
alter table fact_h_gcdc_w_call_serviceorg add columns(call_in_other_cnt int comment '呼入其它电话数',
call_in_other_timelong float comment '呼入其它电话时长',
call_out_other_cnt int comment '呼出其它电话数',
call_out_other_timelong float comment '呼出其它电话时长',
total_other_cnt int comment '合计其它电话数',
total_other_timelong float comment '合计其它电话时长') cascade;
alter table fact_h_gcdc_w_call_branch add columns(call_in_other_cnt int comment '呼入其它电话数',
call_in_other_timelong float comment '呼入其它电话时长',
call_out_other_cnt int comment '呼出其它电话数',
call_out_other_timelong float comment '呼出其它电话时长',
total_other_cnt int comment '合计其它电话数',
total_other_timelong float comment '合计其它电话时长') cascade;


alter table fact_h_gcdc_w_call_serviceuser add (call_in_other_cnt int comment '呼入其它电话数',
call_in_other_timelong float comment '呼入其它电话时长',
call_out_other_cnt int comment '呼出其它电话数',
call_out_other_timelong float comment '呼出其它电话时长',
total_other_cnt int comment '合计其它电话数',
total_other_timelong float comment '合计其它电话时长');
alter table fact_h_gcdc_w_call_serviceorg add (call_in_other_cnt int comment '呼入其它电话数',
call_in_other_timelong float comment '呼入其它电话时长',
call_out_other_cnt int comment '呼出其它电话数',
call_out_other_timelong float comment '呼出其它电话时长',
total_other_cnt int comment '合计其它电话数',
total_other_timelong float comment '合计其它电话时长');
alter table fact_h_gcdc_w_call_branch add (call_in_other_cnt int comment '呼入其它电话数',
call_in_other_timelong float comment '呼入其它电话时长',
call_out_other_cnt int comment '呼出其它电话数',
call_out_other_timelong float comment '呼出其它电话时长',
total_other_cnt int comment '合计其它电话数',
total_other_timelong float comment '合计其它电话时长');

insert overwrite table fact_h_gcdc_w_call_serviceuser partition(p_date = $date$)
select 
$date$ as d_date,
base.id as serviceuser_id,
base.name as serviceuser_name,
dim_org.branch_id as branch_id,
dim_org.branch_name as branch_name,
base.org_id as serviceuser_org_id,
base.org_name as serviceuser_org_name,
base.position_channel as position_channel,
base.position_channel_name as position_channel_name,
base.position_id as position_id,
base.position_name as position_name,
nvl(cover.cust_cover_cnt,0) as cust_cover_cnt,
nvl(cover.candidate_cover_cnt,0) as candidate_cover_cnt,
nvl(cover.call_in_cust_cnt,0) as call_in_cust_cnt,
nvl(cover.call_in_cust_timelong,0) as call_in_cust_timelong,
nvl(cover.call_in_candidate_cnt,0) as call_in_candidate_cnt,
nvl(cover.call_in_candidate_timelong,0) as call_in_candidate_timelong,
nvl(cover.call_out_cust_cnt,0) as call_out_cust_cnt,
nvl(cover.call_out_cust_timelong,0) as call_out_cust_timelong,
nvl(cover.call_out_candidate_cnt,0) as call_out_candidate_cnt,
nvl(cover.call_out_candidate_timelong,0) as call_out_candidate_timelong,
nvl(cover.total_cust_cnt,0) as total_cust_cnt,
nvl(cover.total_cust_timelong,0) as total_cust_timelong,
nvl(cover.total_candidate_cnt,0) as total_candidate_cnt,
nvl(cover.total_candidate_timelong,0) as total_candidate_timelong,
from_unixtime(unix_timestamp()) as creation_timestamp,
nvl(cover.call_in_other_cnt,0) as call_in_other_cnt,
nvl(cover.call_in_other_timelong,0) as call_in_other_timelong,
nvl(cover.call_out_other_cnt,0) as call_out_other_cnt,
nvl(cover.call_out_other_timelong,0) as call_out_other_timelong,
nvl(cover.total_other_cnt,0) as total_other_cnt,
nvl(cover.total_other_timelong,0) as total_other_timelong


from 
(
	select 
	creator_id,
	count(distinct case when customer_id <> 0 then customer_id else null end ) as cust_cover_cnt,
	count(distinct case when  customer_id = 0 and serviced_object_id <> 0 then serviced_object_id else null end ) as candidate_cover_cnt,
	count(case when customer_id <> 0 and call_type=1 then customer_id else null end ) as call_in_cust_cnt,
	sum(case when customer_id <> 0 and call_type=1 then time_long else 0 end) / 60 as call_in_cust_timelong,
	count(case when  customer_id = 0 and serviced_object_id <> 0 and call_type=1 then serviced_object_id else null end ) as call_in_candidate_cnt,
	sum(case when  customer_id = 0 and serviced_object_id <> 0 and call_type=1 then time_long else 0 end) / 60 as call_in_candidate_timelong,

	count(case when  customer_id = 0 and serviced_object_id = 0 and call_type=1 then serviced_object_id else null end ) as call_in_other_cnt,
	sum(case when  customer_id = 0 and serviced_object_id = 0 and call_type=1 then time_long else 0 end) / 60 as call_in_other_timelong,

	count(case when customer_id <> 0 and call_type = 0 then customer_id else null end ) as call_out_cust_cnt,
	sum(case when customer_id <> 0 and call_type = 0 then time_long else 0 end) / 60 as call_out_cust_timelong,
	count(case when  customer_id = 0 and serviced_object_id <> 0 and call_type = 0 then serviced_object_id else null end ) as call_out_candidate_cnt,
	sum(case when  customer_id = 0 and serviced_object_id <> 0 and call_type = 0 then time_long else 0 end) / 60 as call_out_candidate_timelong,

	count(case when  customer_id = 0 and serviced_object_id = 0 and call_type = 0 then serviced_object_id else null end ) as call_out_other_cnt,
	sum(case when  customer_id = 0 and serviced_object_id = 0 and call_type = 0 then time_long else 0 end) / 60 as call_out_other_timelong,

	count(case when customer_id <> 0 then customer_id else null end ) as total_cust_cnt,
	sum(case when customer_id <> 0 then time_long else 0 end) / 60 as total_cust_timelong,
	count(case when  customer_id = 0 and serviced_object_id <> 0 then serviced_object_id else null end ) as total_candidate_cnt,
	sum(case when  customer_id = 0 and serviced_object_id <> 0 then time_long else 0 end) / 60 as total_candidate_timelong,

	count(case when  customer_id = 0 and serviced_object_id = 0 then serviced_object_id else null end ) as total_other_cnt,
	sum(case when  customer_id = 0 and serviced_object_id = 0 then time_long else 0 end) / 60 as total_other_timelong

	from call_record
	where call_date between {{delta(date,-6)}} and $date$
	and deleteflag = 0 
	and time_long > 60
	group by creator_id
) cover
join dw_erp_d_salesuser_base base 
on cover.creator_id = base.id
and base.p_date = $date$
and base.position_channel_name like 'GCDC%'
join dim_org 
on base.org_id = dim_org.d_org_id;





create table fact_h_gcdc_w_call_serviceorg
(
d_date int comment '统计日期',
branch_id int comment '顾问区域ID',
branch_name string comment '顾问区域',
serviceuser_org_id int comment '顾问所在团队ID',
serviceuser_org_name string comment '顾问所在团队',
cust_cover_cnt int comment '覆盖客户数',
candidate_cover_cnt int comment '覆盖经理人人数',
call_in_cust_cnt int comment '呼入客户电话数',
call_in_cust_timelong float comment '呼入客户电话时长',
call_in_candidate_cnt int comment '呼入经理人电话数',
call_in_candidate_timelong float comment '呼入经理人电话时长',
call_out_cust_cnt int comment '呼出客户电话数',
call_out_cust_timelong float comment '呼出客户电话时长',
call_out_candidate_cnt int comment '呼出经理人电话数',
call_out_candidate_timelong float comment '呼出经理人电话时长',
total_cust_cnt int comment '合计客户电话数',
total_cust_timelong float comment '合计客户电话时长',
total_candidate_cnt int comment '合计经理人电话数',
total_candidate_timelong float comment '合计经理人电话时长',
creation_timestamp timestamp comment '时间戳'
) comment 'GCDC电话数据统计-部门-周'
partitioned by (p_date int);

create table fact_h_gcdc_w_call_serviceorg
(
d_date int comment '统计日期',
branch_id int comment '顾问区域ID',
branch_name varchar(100) comment '顾问区域',
serviceuser_org_id int comment '顾问所在团队ID',
serviceuser_org_name varchar(100) comment '顾问所在团队',
cust_cover_cnt int comment '覆盖客户数',
candidate_cover_cnt int comment '覆盖经理人人数',
call_in_cust_cnt int comment '呼入客户电话数',
call_in_cust_timelong float comment '呼入客户电话时长',
call_in_candidate_cnt int comment '呼入经理人电话数',
call_in_candidate_timelong float comment '呼入经理人电话时长',
call_out_cust_cnt int comment '呼出客户电话数',
call_out_cust_timelong float comment '呼出客户电话时长',
call_out_candidate_cnt int comment '呼出经理人电话数',
call_out_candidate_timelong float comment '呼出经理人电话时长',
total_cust_cnt int comment '合计客户电话数',
total_cust_timelong float comment '合计客户电话时长',
total_candidate_cnt int comment '合计经理人电话数',
total_candidate_timelong float comment '合计经理人电话时长',
creation_timestamp  timestamp default CURRENT_TIMESTAMP,
primary key(d_date, serviceuser_org_id)
) comment 'GCDC电话数据统计-部门-周';



insert overwrite table fact_h_gcdc_w_call_serviceorg partition(p_date = $date$)
select 
$date$ as d_date,
dim_org.branch_id as branch_id,
dim_org.branch_name as branch_name,
cover.org_id as serviceuser_org_id,
dim_org.org_name as serviceuser_org_name,
nvl(cover.cust_cover_cnt,0) as cust_cover_cnt,
nvl(cover.candidate_cover_cnt,0) as candidate_cover_cnt,
nvl(cover.call_in_cust_cnt,0) as call_in_cust_cnt,
nvl(cover.call_in_cust_timelong,0) as call_in_cust_timelong,
nvl(cover.call_in_candidate_cnt,0) as call_in_candidate_cnt,
nvl(cover.call_in_candidate_timelong,0) as call_in_candidate_timelong,
nvl(cover.call_out_cust_cnt,0) as call_out_cust_cnt,
nvl(cover.call_out_cust_timelong,0) as call_out_cust_timelong,
nvl(cover.call_out_candidate_cnt,0) as call_out_candidate_cnt,
nvl(cover.call_out_candidate_timelong,0) as call_out_candidate_timelong,
nvl(cover.total_cust_cnt,0) as total_cust_cnt,
nvl(cover.total_cust_timelong,0) as total_cust_timelong,
nvl(cover.total_candidate_cnt,0) as total_candidate_cnt,
nvl(cover.total_candidate_timelong,0) as total_candidate_timelong,
from_unixtime(unix_timestamp()) as creation_timestamp,
nvl(cover.call_in_other_cnt,0) as call_in_other_cnt,
nvl(cover.call_in_other_timelong,0) as call_in_other_timelong,
nvl(cover.call_out_other_cnt,0) as call_out_other_cnt,
nvl(cover.call_out_other_timelong,0) as call_out_other_timelong,
nvl(cover.total_other_cnt,0) as total_other_cnt,
nvl(cover.total_other_timelong,0) as total_other_timelong
from 
(
	select 
	org_id,
	count(distinct case when customer_id <> 0 then customer_id else null end ) as cust_cover_cnt,
	count(distinct case when  customer_id = 0 and serviced_object_id <> 0 then serviced_object_id else null end ) as candidate_cover_cnt,
	count(case when customer_id <> 0 and call_type=1 then customer_id else null end ) as call_in_cust_cnt,
	sum(case when customer_id <> 0 and call_type=1 then time_long else 0 end) / 60 as call_in_cust_timelong,
	count(case when  customer_id = 0 and serviced_object_id <> 0 and call_type=1 then serviced_object_id else null end ) as call_in_candidate_cnt,
	sum(case when  customer_id = 0 and serviced_object_id <> 0 and call_type=1 then time_long else 0 end) / 60 as call_in_candidate_timelong,

	count(case when  customer_id = 0 and serviced_object_id = 0 and call_type=1 then serviced_object_id else null end ) as call_in_other_cnt,
	sum(case when  customer_id = 0 and serviced_object_id = 0 and call_type=1 then time_long else 0 end) / 60 as call_in_other_timelong,

	count(case when customer_id <> 0 and call_type = 0 then customer_id else null end ) as call_out_cust_cnt,
	sum(case when customer_id <> 0 and call_type = 0 then time_long else 0 end) / 60 as call_out_cust_timelong,
	count(case when  customer_id = 0 and serviced_object_id <> 0 and call_type = 0 then serviced_object_id else null end ) as call_out_candidate_cnt,
	sum(case when  customer_id = 0 and serviced_object_id <> 0 and call_type = 0 then time_long else 0 end) / 60 as call_out_candidate_timelong,

	count(case when  customer_id = 0 and serviced_object_id = 0 and call_type = 0 then serviced_object_id else null end ) as call_out_other_cnt,
	sum(case when  customer_id = 0 and serviced_object_id = 0 and call_type = 0 then time_long else 0 end) / 60 as call_out_other_timelong,

	count(case when customer_id <> 0 then customer_id else null end ) as total_cust_cnt,
	sum(case when customer_id <> 0 then time_long else 0 end) / 60 as total_cust_timelong,
	count(case when  customer_id = 0 and serviced_object_id <> 0 then serviced_object_id else null end ) as total_candidate_cnt,
	sum(case when  customer_id = 0 and serviced_object_id <> 0 then time_long else 0 end) / 60 as total_candidate_timelong,

	count(case when  customer_id = 0 and serviced_object_id = 0 then serviced_object_id else null end ) as total_other_cnt,
	sum(case when  customer_id = 0 and serviced_object_id = 0 then time_long else 0 end) / 60 as total_other_timelong
	from call_record
	where call_date between {{delta(date,-6)}} and $date$
	and deleteflag = 0 
	and time_long > 60
	group by org_id
) cover
join  (select p_date,id as d_org_id,
			 name as org_name,branch_id,branch_name
	    from dim_gcdc_org
	   where p_date = $date$ ) dim_org 
on cover.org_id = dim_org.d_org_id;




create table fact_h_gcdc_w_call_branch
(
d_date int comment '统计日期',
branch_id int comment '顾问区域ID',
branch_name string comment '顾问区域',
cust_cover_cnt int comment '覆盖客户数',
candidate_cover_cnt int comment '覆盖经理人人数',
call_in_cust_cnt int comment '呼入客户电话数',
call_in_cust_timelong float comment '呼入客户电话时长',
call_in_candidate_cnt int comment '呼入经理人电话数',
call_in_candidate_timelong float comment '呼入经理人电话时长',
call_out_cust_cnt int comment '呼出客户电话数',
call_out_cust_timelong float comment '呼出客户电话时长',
call_out_candidate_cnt int comment '呼出经理人电话数',
call_out_candidate_timelong float comment '呼出经理人电话时长',
total_cust_cnt int comment '合计客户电话数',
total_cust_timelong float comment '合计客户电话时长',
total_candidate_cnt int comment '合计经理人电话数',
total_candidate_timelong float comment '合计经理人电话时长',
creation_timestamp timestamp comment '时间戳'
) comment 'GCDC电话数据统计-地区-周'
partitioned by (p_date int);

create table fact_h_gcdc_w_call_branch
(
d_date int comment '统计日期',
branch_id int comment '顾问区域ID',
branch_name varchar(100) comment '顾问区域',
cust_cover_cnt int comment '覆盖客户数',
candidate_cover_cnt int comment '覆盖经理人人数',
call_in_cust_cnt int comment '呼入客户电话数',
call_in_cust_timelong float comment '呼入客户电话时长',
call_in_candidate_cnt int comment '呼入经理人电话数',
call_in_candidate_timelong float comment '呼入经理人电话时长',
call_out_cust_cnt int comment '呼出客户电话数',
call_out_cust_timelong float comment '呼出客户电话时长',
call_out_candidate_cnt int comment '呼出经理人电话数',
call_out_candidate_timelong float comment '呼出经理人电话时长',
total_cust_cnt int comment '合计客户电话数',
total_cust_timelong float comment '合计客户电话时长',
total_candidate_cnt int comment '合计经理人电话数',
total_candidate_timelong float comment '合计经理人电话时长',
creation_timestamp  timestamp default CURRENT_TIMESTAMP,
primary key(d_date, branch_id)
) comment 'GCDC电话数据统计-地区-周';

insert overwrite table fact_h_gcdc_w_call_branch partition(p_date = $date$)
select 
$date$ as d_date,
cover.branch_id as branch_id,
cover.branch_name as branch_name,
nvl(cover.cust_cover_cnt,0) as cust_cover_cnt,
nvl(cover.candidate_cover_cnt,0) as candidate_cover_cnt,
nvl(cover.call_in_cust_cnt,0) as call_in_cust_cnt,
nvl(cover.call_in_cust_timelong,0) as call_in_cust_timelong,
nvl(cover.call_in_candidate_cnt,0) as call_in_candidate_cnt,
nvl(cover.call_in_candidate_timelong,0) as call_in_candidate_timelong,
nvl(cover.call_out_cust_cnt,0) as call_out_cust_cnt,
nvl(cover.call_out_cust_timelong,0) as call_out_cust_timelong,
nvl(cover.call_out_candidate_cnt,0) as call_out_candidate_cnt,
nvl(cover.call_out_candidate_timelong,0) as call_out_candidate_timelong,
nvl(cover.total_cust_cnt,0) as total_cust_cnt,
nvl(cover.total_cust_timelong,0) as total_cust_timelong,
nvl(cover.total_candidate_cnt,0) as total_candidate_cnt,
nvl(cover.total_candidate_timelong,0) as total_candidate_timelong,
from_unixtime(unix_timestamp()) as creation_timestamp,
nvl(cover.call_in_other_cnt,0) as call_in_other_cnt,
nvl(cover.call_in_other_timelong,0) as call_in_other_timelong,
nvl(cover.call_out_other_cnt,0) as call_out_other_cnt,
nvl(cover.call_out_other_timelong,0) as call_out_other_timelong,
nvl(cover.total_other_cnt,0) as total_other_cnt,
nvl(cover.total_other_timelong,0) as total_other_timelong
from 
(
	select 
	dim_org.branch_id,
	dim_org.branch_name,
	count(distinct case when customer_id <> 0 then customer_id else null end ) as cust_cover_cnt,
	count(distinct case when  customer_id = 0 and serviced_object_id <> 0 then serviced_object_id else null end ) as candidate_cover_cnt,
	count(case when customer_id <> 0 and call_type=1 then customer_id else null end ) as call_in_cust_cnt,
	sum(case when customer_id <> 0 and call_type=1 then time_long else 0 end) / 60 as call_in_cust_timelong,
	count(case when  customer_id = 0 and serviced_object_id <> 0 and call_type=1 then serviced_object_id else null end ) as call_in_candidate_cnt,
	sum(case when  customer_id = 0 and serviced_object_id <> 0 and call_type=1 then time_long else 0 end) / 60 as call_in_candidate_timelong,

	count(case when  customer_id = 0 and serviced_object_id = 0 and call_type=1 then serviced_object_id else null end ) as call_in_other_cnt,
	sum(case when  customer_id = 0 and serviced_object_id = 0 and call_type=1 then time_long else 0 end) / 60 as call_in_other_timelong,

	count(case when customer_id <> 0 and call_type = 0 then customer_id else null end ) as call_out_cust_cnt,
	sum(case when customer_id <> 0 and call_type = 0 then time_long else 0 end) / 60 as call_out_cust_timelong,
	count(case when  customer_id = 0 and serviced_object_id <> 0 and call_type = 0 then serviced_object_id else null end ) as call_out_candidate_cnt,
	sum(case when  customer_id = 0 and serviced_object_id <> 0 and call_type = 0 then time_long else 0 end) / 60 as call_out_candidate_timelong,

	count(case when  customer_id = 0 and serviced_object_id = 0 and call_type = 0 then serviced_object_id else null end ) as call_out_other_cnt,
	sum(case when  customer_id = 0 and serviced_object_id = 0 and call_type = 0 then time_long else 0 end) / 60 as call_out_other_timelong,

	count(case when customer_id <> 0 then customer_id else null end ) as total_cust_cnt,
	sum(case when customer_id <> 0 then time_long else 0 end) / 60 as total_cust_timelong,
	count(case when  customer_id = 0 and serviced_object_id <> 0 then serviced_object_id else null end ) as total_candidate_cnt,
	sum(case when  customer_id = 0 and serviced_object_id <> 0 then time_long else 0 end) / 60 as total_candidate_timelong,

	count(case when  customer_id = 0 and serviced_object_id = 0 then serviced_object_id else null end ) as total_other_cnt,
	sum(case when  customer_id = 0 and serviced_object_id = 0 then time_long else 0 end) / 60 as total_other_timelong
	from call_record
	join (select p_date,id as d_org_id,
			 name as org_name,branch_id,branch_name
	    from dim_gcdc_org
	   where p_date = $date$) dim_org 
	on call_record.org_id = dim_org.d_org_id
	where call_date between {{delta(date,-6)}} and $date$
	and deleteflag = 0 
	and time_long > 60
	group by dim_org.branch_id,dim_org.branch_name
) cover
