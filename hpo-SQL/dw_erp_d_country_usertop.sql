create table if not exists dw_erp_d_country_usertop
(
	d_date int,
	position_channel string,
	top_call_rec_cnt int,
	top_call_time_long float,
	top_visit_cus_cnt int,
	top_input_cus_cnt int
) comment '销售顾问KPI全国top值'
partitioned by  (p_date int);

create table dw_erp_d_country_usertop
(
	d_date int,
	position_channel varchar(30),
	top_call_rec_cnt int,
	top_call_time_long float,
	top_visit_cus_cnt int,
	top_input_cus_cnt int,
	primary key (d_date,position_channel)
) comment '销售顾问KPI全国top值';


insert overwrite table dw_erp_d_country_usertop partition (p_date = $date$)
select 
	$date$ as d_date,
	position_channel,
	max(call_rec_cnt) as top_call_rec_cnt,
	max(call_time_long) as top_call_time_long,
	max(visit_cus_cnt_m) as top_visit_cus_cnt,
	max(input_cus_cnt_m) as top_input_cus_cnt
from  dw_erp_d_salesuser_act act 
left join 
(select 
   from dw_erp_a_customer_input
 ) input 
on act.sales_id = input.input_id
and 
where p_date = $date$
and is_sales_agent = 1
group by position_channel;

