create table dw_erp_a_call_record
(
id string comment '主键ID',
service_hotline_type int comment '热线类型:0-普通呼叫,1-400呼叫',
call_type int comment '呼叫类型:0-呼出,1-呼入',
customer_id int comment '客户ID',
candidate_id int comment '经理人ID',
call_date string comment '通话时间',
begintime string comment '通话开始时间',
timelong int comment '通话时长',
uuid string comment 'UUID',
creator_id int comment '销售或招服',
org_id int comment '所属组织',
presented_type int comment '坐席类型:1-SALES,2-GCDC'
) 
comment 'hpo通话记录合并'
partitioned by (p_date);


insert overwrite table dw_erp_a_call_record partition (p_date = '$date$')
select
concat('1-',id) as id,
service_hotline_type,
call_type,
customer_id,
if(customer_id = 0,serviced_object_id,0) as candidate_id,
call_date,
begin_time as begintime,
time_long as timelong,
uuid,
creator_id,
org_id,
case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type
from call_record
where deleteflag = 0
and regexp_replace(substr(createtime,1,10),'-','') = '$date$' ;


insert overwrite table dw_erp_a_call_record partition (p_date)
select 
concat('0-',id) as id,
'-1' as service_hotline_type,
calltype as call_type,
cust_id as customer_id,
'-1' as candidate_id,
calldate as call_date,
begintime,
timelong,
'-1' as uuid,
creator_id,
org_id,
1 as presented_type,
substr(createtime,1,8) as p_date
from biz_sales_callrecord
where deleteflag = 0
union 
select 
concat('0-',id) as id,
'-1' as service_hotline_type,
calltype as call_type,
cust_id as customer_id,
'-1' as candidate_id,
calldate as call_date,
begintime,
timelong,
'-1' as uuid,
creator_id,
org_id,
1 as presented_type,
substr(createtime,1,8) as p_date
from biz_sales_callrecord_archive
where deleteflag = 0
union 
select
concat('1-',id) as id,
service_hotline_type,
call_type,
customer_id,
if(customer_id = 0,serviced_object_id,0) as candidate_id,
call_date ,
begin_time as begintime,
time_long as timelong,
uuid,
creator_id,
org_id,
case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,
regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record_archive
where deleteflag = 0
union 
select
concat('1-',id) as id,
service_hotline_type,
call_type,
customer_id,
if(customer_id = 0,serviced_object_id,0) as candidate_id,
call_date,
begin_time as begintime,
time_long as timelong,
uuid,
creator_id,
org_id,
case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,
regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record
where deleteflag = 0;


insert overwrite table dw_erp_a_call_record partition (p_date)
select 
concat('0-',id) as id,
'-1' as service_hotline_type,
calltype as call_type,
cust_id as customer_id,
'-1' as candidate_id,
calldate as call_date,
begintime,
timelong,
'-1' as uuid,
creator_id,
org_id,
1 as presented_type,
substr(createtime,1,8) as p_date
from biz_sales_callrecord_archive
where deleteflag = 0
and substr(createtime,1,4) = 2013;


insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201306;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201307;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201308;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201309;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201310;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201311;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201312;

insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201401;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201402;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201403;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201404;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201405;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201406;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201407;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201408;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201409;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201410;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201411;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201412;


insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201501;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201502;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201503;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201504;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201505;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201506;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201507;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201508;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201509;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201510;
insert overwrite table dw_erp_a_call_record partition (p_date)
	select concat('0-',id) as id,'-1' as service_hotline_type,calltype as call_type,cust_id as customer_id,'-1' as candidate_id,calldate as call_date,begintime,timelong,'-1' as uuid,creator_id,org_id,1 as presented_type,substr(createtime,1,8) as p_date from biz_sales_callrecord_archive where deleteflag = 0 and substr(createtime,1,6) = 201511;



insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record_archive where deleteflag = 0 and substr(createtime,1,7) = '2015-10';

insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record_archive where deleteflag = 0 and substr(createtime,1,7) = '2015-11';

insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record_archive where deleteflag = 0 and substr(createtime,1,7) = '2015-12';

insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record_archive where deleteflag = 0 and substr(createtime,1,7) = '2016-01';

insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record_archive where deleteflag = 0 and substr(createtime,1,7) = '2016-02';

insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record_archive where deleteflag = 0 and substr(createtime,1,7) = '2016-03';

insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record_archive where deleteflag = 0 and substr(createtime,1,7) = '2016-04';

insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record where deleteflag = 0 and substr(createtime,1,7) = '2016-04';
insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record where deleteflag = 0 and substr(createtime,1,7) = '2016-05';
insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record where deleteflag = 0 and substr(createtime,1,7) = '2016-06';
insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record where deleteflag = 0 and substr(createtime,1,7) = '2016-07';
insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record where deleteflag = 0 and substr(createtime,1,7) = '2016-08';
insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record where deleteflag = 0 and substr(createtime,1,7) = '2016-09';
insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record where deleteflag = 0 and substr(createtime,1,7) = '2016-10';
insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record where deleteflag = 0 and substr(createtime,1,7) = '2016-11';
insert overwrite table dw_erp_a_call_record partition (p_date)
select concat('1-',id) as id,service_hotline_type,call_type,customer_id,if(customer_id = 0,serviced_object_id,0) as candidate_id,call_date ,begin_time as begintime,time_long as timelong,uuid,creator_id,org_id,case when presented_type = 1 then 1 when presented_type in (2,3,4) then 2 else 0 end as presented_type,regexp_replace(substr(createtime,1,10),'-','') as p_date
from call_record where deleteflag = 0 and substr(createtime,1,7) = '2016-12';