CREATE TABLE dim_pay_product_info(
  ppi_id int, 
  ppi_kind string, 
  ppi_key string, 
  ppi_name string, 
  ppi_money float, 
  ppi_desc string, 
  createtime timestamp, 
  modifytime timestamp, 
  is_goldcard_product int COMMENT '金卡产品:1-是,0-否', 
  is_goldcard_group_product int COMMENT '金卡套餐产品:1-是,0-否', 
  is_goldcard_gift_product int COMMENT '金卡是否赠送产品:1-是,0-否');


alter table dim_pay_product_info add columns(is_goldcard_product int comment '金卡产品:1-是,0-否',is_goldcard_group_product int comment '金卡套餐产品:1-是,0-否');
alter table dim_pay_product_info add (is_goldcard_product int comment '金卡产品:1-是,0-否',is_goldcard_group_product int comment '金卡套餐产品:1-是,0-否');


alter table dim_pay_product_info change is_goldcard_pay_group_product is_goldcard_gift_product int comment '金卡是否赠送产品:1-是,0-否';
alter table dim_pay_product_info change is_goldcard_pay_group_product is_goldcard_gift_product int comment '金卡是否赠送产品:1-是,0-否';


insert overwrite table dim_pay_product_info
select ppi_id,ppi_kind,ppi_key,ppi_name,ppi_money,ppi_desc,createtime,from_unixtime(unix_timestamp()),
case when substr(upper(ppi_key),1,7) = 'PROC_C_' and ppi_key not like 'PROC_C_CREDIT%' then 1 else 0 end as is_goldcard_product,
case when substr(upper(ppi_key),1,7) = 'PROC_C_' and (instr(upper(ppi_key),'MEMBERSHIP') > 0 or ppi_key = 'PROC_C_CMB_30_MARK') then 1 else 0 end 
 as is_goldcard_group_product,
case when substr(upper(ppi_key),1,7) = 'PROC_C_' and ppi_id in ('18','25','26','27','28','33','34','35','44','61','62','63','64','73','74','78','82','96','97') then 1 else 0 end as is_goldcard_gift_product
from pay_product_info


CREATE TABLE dim_goldcard_product_matrix(
  ppi_id int COMMENT '', 
  ppi_key string COMMENT '', 
  ppi_name string COMMENT '', 
  ppi_money string COMMENT '', 
  is_group_product int comment '金卡套餐产品:1-是,0-否',
  is_gift_product int comment '金卡是否赠送产品:1-是,0-否',
  service_goldcard_kind int comment '金卡类型',
  service_goldcard_days int COMMENT '购买的金卡服务的天数', 
  service_cv_rank_days int COMMENT '购买的简历置顶天数', 
  service_showad_days int COMMENT '购买的广告自荐的天数',   
  service_applyprior_count int COMMENT '购买的应聘优先次数',   
  service_groupmessage_count int COMMENT '购买的简历群发次数', 
  service_advisersrecommend_count int COMMENT '顾问推荐次数',   
  service_secretary_days int COMMENT '购买的秘书台的天数', 
  service_eval_count int COMMENT '购买的职业测评的次数',   
  service_jobreward_count int COMMENT '悬赏求职次数', 
  service_consult_times int COMMENT '购买的通话时长(s)', 
  service_industryreport_count int COMMENT '购买的薪酬报告次数', 
  service_message_count int COMMENT '无线沟通 购买的私信数量',
  creation_timestamp timestamp comment '时间戳');

CREATE TABLE dim_goldcard_product_matrix(
  ppi_id int COMMENT '', 
  ppi_key varchar(50) COMMENT '产品KEY', 
  ppi_name varchar(50) COMMENT '产品名称', 
  ppi_money varchar(50) COMMENT '产品价格', 
  is_group_product int comment '金卡套餐产品:1-是,0-否',
  is_gift_product int comment '金卡是否赠送产品:1-是,0-否',
  service_goldcard_kind int comment '金卡类型',
  service_goldcard_days int COMMENT '购买的金卡服务的天数', 
  service_cv_rank_days int COMMENT '购买的简历置顶天数', 
  service_showad_days int COMMENT '购买的广告自荐的天数',   
  service_applyprior_count int COMMENT '购买的应聘优先次数',   
  service_groupmessage_count int COMMENT '购买的简历群发次数', 
  service_advisersrecommend_count int COMMENT '顾问推荐次数',   
  service_secretary_days int COMMENT '购买的秘书台的天数', 
  service_eval_count int COMMENT '购买的职业测评的次数',   
  service_jobreward_count int COMMENT '悬赏求职次数', 
  service_consult_times int COMMENT '购买的通话时长(s)', 
  service_industryreport_count int COMMENT '购买的薪酬报告次数', 
  service_message_count int COMMENT '无线沟通 购买的私信数量',
  creation_timestamp timestamp default current_timestamp comment '时间戳',
  primary key (ppi_id));

insert overwrite table dim_goldcard_product_matrix
select 	dpp.ppi_id,
		dpp.ppi_key,
		dpp.ppi_name,
		dpp.ppi_money,
		dpp.is_goldcard_group_product,
		dpp.is_goldcard_gift_product,
	    sum(case when ppp.ppp_key = 'service_goldcard_kind' then ppp.ppp_value else 0 end) as service_goldcard_kind,
		sum(case when ppp.ppp_key = 'service_goldcard_days' then ppp.ppp_value else 0 end) as service_goldcard_days,
		sum(case when ppp.ppp_key = 'service_cv_rank_days' then ppp.ppp_value else 0 end) as service_cv_rank_days,
		sum(case when ppp.ppp_key = 'service_showad_days' then ppp.ppp_value else 0 end) as service_showad_days,
		sum(case when ppp.ppp_key = 'service_applyprior_count' then ppp.ppp_value else 0 end) as service_applyprior_count,
		sum(case when ppp.ppp_key = 'service_groupmessage_count' then ppp.ppp_value else 0 end) as service_groupmessage_count,
		sum(case when ppp.ppp_key = 'service_advisersrecommend_count' then ppp.ppp_value else 0 end) as service_advisersrecommend_count,
		sum(case when ppp.ppp_key = 'service_secretary_days' then ppp.ppp_value else 0 end) as service_secretary_days,
		sum(case when ppp.ppp_key = 'service_eval_count' then ppp.ppp_value else 0 end) as service_eval_count,
		sum(case when ppp.ppp_key = 'service_jobreward_count' then ppp.ppp_value else 0 end) as service_jobreward_count,
		sum(case when ppp.ppp_key = 'service_consult_times' then ppp.ppp_value else 0 end) as service_consult_times,
		sum(case when ppp.ppp_key = 'service_industryreport_count' then ppp.ppp_value else 0 end) as service_industryreport_count,
		sum(case when ppp.ppp_key = 'service_message_count' then ppp.ppp_value else 0 end) as service_message_count,
		current_timestamp as creation_timestamp
  from pay_product_property ppp 
   join dim_pay_product_info dpp on ppp.ppi_id = dpp.ppi_id and dpp.is_goldcard_product = 1 
 group by 
		dpp.ppi_id,
		dpp.ppi_key,
		dpp.ppi_name,
		dpp.ppi_money,
		dpp.is_goldcard_group_product,
		dpp.is_goldcard_gift_product

-- user_kind = 0 and order_dealresult = 1 and prod_id = 金卡产品

select is_goldcard_gift_product,count(1) as cnt 
from dw_c_a_goldcard_order ord 
join dim_pay_product_info prod
  on ord.prod_id = prod.ppi_id
 group by ord.order_isgift,prod.is_goldcard_gift_product



create table dw_c_a_goldcard_order 
(
order_id int comment '订单ID',
user_id int comment '用户ID',
order_name string comment '订单名称(产品的名称)',
order_money string comment '订单金额',
order_paykind string comment '订单支付方式(00:公司账户 01:支付宝 02:快钱 03:财付通 04:网银直连 06:银联在线 07:联动优势)',
prod_id int comment '产品主键ID',
prod_key string comment '产品KEY',
is_group_prod int comment '是否金卡套餐: 1-是,0-否'
order_createtime string comment '订单创建时间',
order_dealmoney string comment '订单支付金额',
order_dealtime string comment '订单支付时间',
order_isgift string comment '是否赠送(0:非赠送 1:赠送) 且订单金额大于10元', --确认是否根据套餐产品的付费类型来定 订单的赠送和产品的赠送是否一致以及数据量
order_source string comment '订单来源0：网页1：苹果2：安卓',
modifiedtime string comment '订单修改时间',
order_number string comment '订单号（业务性质）',
obj_id string comment '业务端业务ID，例如兼职职位ID',
order_seq int comment '用户第几笔订单',
buy_membership_order_seq int comment '用户第几笔付费成功套餐订单',
buy_order_seq int comment '用户第几笔付费成功订单',
before_order_isgift int comment '前一笔订单是否赠送：1-是，0-不是，-1：第一笔订单',
before_order_prod int comment '前一笔订单产品ID',
order_seq_reverse int  comment '用户第几笔订单-倒序',
buy_order_seq_reverse int  comment '用户第几笔付费成功订单-倒序',
order_start_date string comment '订单服务开始时间',
order_end_date string comment '订单服务结束时间',
order_days string comment '订单服务期天数',
is_in_service int comment '是否服务期内订单',
creation_timestamp timestamp comment '时间戳'
) comment 'C端用户金卡产品订单表';

with ord0 as 
(
select
	ord.order_id,
	ord.user_id,
	ord.order_name,
	ord.order_money,
	ord.order_paykind,
	ord.prod_id,
	prod.ppi_key as prod_key,
	ord.order_createtime,
	ord.order_dealmoney,
	ord.order_dealtime,
	case when order_money > 10 then ord.order_isgift else 1 end as order_isgift,
	ord.order_source,
	ord.modifiedtime,
	ord.order_number,
	ord.obj_id,
	prod.is_goldcard_group_product as is_group_prod,
	row_number()over(distribute by ord.user_id sort by ord.order_createtime) as rn,
	lag(ord.order_isgift,1,0)over(distribute by ord.user_id sort by ord.order_createtime) as before_order_isgift,
	lag(ord.prod_id,1,0)over(distribute by ord.user_id sort by ord.order_createtime) as before_order_prod,
	row_number()over(distribute by ord.user_id sort by ord.order_createtime desc) as rn_reverse,
	reformat_datetime(nvl(gl.start_date,'1900-01-01 00:00:00')) as order_start_date,
	date_add(reformat_datetime(gl.start_date),nvl(gl.days,0)) as order_end_date,
	nvl(gl.days,0) as order_days,
	case when ord.order_isgift = 0 and substr(reformat_datetime(ord.order_dealtime),1,10) < substr(reformat_datetime(gl.start_date),1,10) then 1 else 0 end as is_in_service --订单支付时间，与goldcard_log里的生效时间比对(如果是服务期内订单，goldcard_log里的生效时间是当前服务期结束时间+1)
from web_order ord 
join dim_pay_product_info prod
  on ord.prod_id = prod.ppi_id
 and is_goldcard_product = 1
left join goldcard_log gl on ord.order_id = gl.order_id
where ord.order_dealresult = 1
and ord.user_kind = 0
) 
insert overwrite table dw_c_a_goldcard_order 
select
	ord0.order_id,
	ord0.user_id,
	ord0.order_name,
	ord0.order_money,
	ord0.order_paykind,
	ord0.prod_id,
	ord0.prod_key,
	ord0.is_group_prod,
	reformat_datetime(ord0.order_createtime) as order_createtime,
	ord0.order_dealmoney,
	reformat_datetime(ord0.order_dealtime) as order_dealtime,
	ord0.order_isgift,
	ord0.order_source,
	ord0.modifiedtime,
	ord0.order_number,
	ord0.obj_id,
	nvl(ord0.rn,0) as order_seq,
	nvl(ord2.rn,0) as buy_membership_order_seq,
	nvl(ord1.rn,0) as buy_order_seq,
	ord0.before_order_isgift as before_order_isgift,
	ord0.before_order_prod as before_order_prod,
	ord0.rn_reverse as order_seq_reverse,
	nvl(ord1.rn_reverse,0) as buy_order_seq_reverse,
	ord0.order_start_date,
	ord0.order_end_date,
	ord0.order_days,
	ord0.is_in_service,
	current_timestamp as creation_timestamp
from ord0
left join
(   select
		order_id, 
		row_number()over(distribute by user_id sort by order_createtime) as rn ,
		row_number()over(distribute by user_id sort by order_createtime desc) as rn_reverse
	from ord0
	where order_isgift = 0
) ord1  -- 付费订单
on ord0.order_id = ord1.order_id
left join 
(
	select
		order_id, 
		row_number()over(distribute by user_id sort by order_createtime) as rn
	from ord0
	where order_isgift = 0
	 and is_group_prod = 1
) ord2 --付费套餐订单
on ord0.order_id = ord2.order_id;


create table dw_c_d_goldcard_user_base (
user_id int comment '用户ID',
res_id int comment '默认简历',
res_level int comment '简历等级',
c_industry string comment '行业',
c_hope string comment '求职状态 0:目前在职，有好机会可以看看, 1:目前离职，随时可以谈新机会, 2:目前在职，希望尽快寻找新机会',
c_jobtitle string comment '职能',
c_workyear string comment '开始工作年份',
c_dq string comment '地区',
c_edulevel string comment '教育经历',
c_edulevel_tz string comment '统招教育经历',
c_sex string comment '性别 男, 女, 9',
c_birth_year string comment '出生年月',
c_yearsalary int comment '目前月薪c_nowsalary*发薪月数c_salmonths',
c_want_yearsalary int comment 'want_monthsalary * want_salmonths',
c_title string comment '目前职位名称',
c_school_kind string comment '学校类型 0:common 1:211 2:985',
reg_device string comment '注册终端',
integrity_flag string comment '简历完整度',
c_marriage string comment '婚否 0:未婚, 1:已婚, 9:不详',
rw_start string comment '最近一段工作经历开始时间',
rw_compkind string comment '最近一段工作经历企业性质',
kind int comment '金卡类型，0是体验版金卡1是完整版金卡',
effect_flag int comment '金卡是否有效 0：无效，1：有效',
start_date string comment '当前或最后一次金卡开始时间',
end_date string comment '当前或最后一次金卡金卡结束时间',
days int comment '金卡天数',
first_order_group_product_prod int comment '第一次购买金卡套餐产品',
first_order_group_product_time string comment '第一次购买金卡套餐时间',
is_gift_before_first_order_group_product int comment '第一次购买金卡套餐前是否赠送金卡',
gift_prod_before_first_order_group_product int comment '第一次购买金卡套餐前开通赠送金卡产品类型',
is_gift_used_before_first_order_group_product int comment '第一次购买金卡套餐前是否开通过赠送金卡', ---取不到精确数值
last_prod_id int comment '最近一次购买的金卡类型',
last_order_time string comment '最近一次购买金卡时间',
cumu_effect_gift_group_product_cnt int comment '累计服务期赠送套餐数',
cumu_trial_gift_group_product_cnt int comment '累计非服务期赠送套餐数',
cumu_effect_gift_resource_cnt string comment '累计服务期赠送单独资源数',
cumu_group_prod_cnt int comment '累计购买套餐数',
cumu_resource_cnt string comment '累计购买单独资源数',
cumu_group_prod_money float comment '累计购买套餐金额',
cumu_resource_money string comment '累计购买单独资源金额',
createtime string comment '创建时间',
modifytime string comment '修改时间',
creation_timestamp timestamp comment '时间戳'
) comment '金卡用户表'
partitioned by (p_date int);

json格式：gift_service_cv_rank_days:简历置顶总天数,gift_service_showad_days:广告自荐总天数,gift_service_applyprior_count:应聘优先总次数,gift_service_groupmessage_count:群发资源总数

json格式：pay_service_cv_rank_days:简历置顶总天数,pay_service_showad_days:广告自荐总天数,pay_service_applyprior_count:应聘优先总次数,pay_service_groupmessage_count:群发资源总数

json格式：service_cv_rank_days_money:简历置顶资源金额,service_showad_days_money:广告自荐资源金额,service_applyprior_count_money:应聘优先资源金额,service_groupmessage_count_money:群发资源金额

	parse_json(
	'gift_service_cv_rank_days', nvl(ord2.gift_service_cv_rank_days,0),
	'gift_service_showad_days', nvl(ord2.gift_service_showad_days,0),
	'gift_service_applyprior_count', nvl(ord2.gift_service_applyprior_count,0),
	'gift_service_groupmessage_count', nvl(ord2.gift_service_groupmessage_count,0)
	) as cumu_effect_gift_resource_cnt,
	nvl(ord1.cumu_group_prod_cnt,0) as cumu_group_prod_cnt,
	parse_json(
	'pay_service_cv_rank_days', nvl(ord2.pay_service_cv_rank_days,0),
	'pay_service_showad_days', nvl(ord2.pay_service_showad_days,0),
	'pay_service_applyprior_count', nvl(ord2.pay_service_applyprior_count,0),
	'pay_service_groupmessage_count', nvl(ord2.pay_service_groupmessage_count,0)
	) as cumu_resource_cnt,
	nvl(ord1.cumu_group_prod_money,0) as cumu_group_prod_money,
	parse_json(
	'service_cv_rank_days_money', nvl(ord2.service_cv_rank_days_money,0),
	'service_showad_days_money', nvl(ord2.service_showad_days_money,0),
	'service_applyprior_count_money', nvl(ord2.service_applyprior_count_money,0),
	'service_groupmessage_count_money',nvl(ord2.service_groupmessage_count_money,0)) as cumu_resource_money,

alter table dw_c_d_goldcard_user_base change first_order_group_product_prod first_order_group_product_id int comment '第一次购买金卡套餐产品';

alter table dw_c_d_goldcard_user_base change last_order_time last_order_time string comment '最近一次购买金卡套餐时间';
alter table dw_c_d_goldcard_user_base change last_prod_key last_prod_id int comment '最近一次购买金卡套餐产品ID';


insert overwrite table dw_c_d_goldcard_user_base partition (p_date = $date$)
select
	gc.user_id,
	rc.res_id,
	rc.res_level,
	uc.c_industry,
	uc.c_hope,
	uc.c_jobtitle,
	uc.c_workyear,
	uc.c_dq,
	uc.c_edulevel,
	uc.c_edulevel_tz,
	uc.c_sex,
	uc.c_birth_year,
	uc.c_yearsalary,
	uc.c_want_yearsalary,
	uc.c_title,
	uc.c_school_kind,
	uc.reg_device,
	rc.integrity_flag,
	uc.c_marriage,
	nvl(if(rw.rw_start='',null,rw.rw_start),'190001') as rw_start,
	nvl(if(rw.rw_compkind='',null,rw.rw_compkind), '-1') as rw_compkind,
	nvl(gc_kind.kind,gc.kind) as kind,
	gc.effect_flag,
	gc.start_date,
	gc.end_date,
	gc.days,
	nvl(ord1.first_order_group_product_id,-1) as first_order_group_product_id,
	nvl(ord1.first_order_group_product_time,'1900-01-01 00:00:00') as first_order_group_product_time,
	nvl(ord1.is_gift_before_first_order_group_product,-1) as is_gift_before_first_order_group_product,
	nvl(ord1.gift_prod_before_first_order_group_product,-1) as gift_prod_before_first_order_group_product,
	nvl(ord1.is_gift_used_before_first_order_group_product,-1) as is_gift_used_before_first_order_group_product,
	nvl(ord1.last_prod_id,-1) as last_prod_id,
	nvl(ord1.last_order_time,'1900-01-01 00:00:00') as last_order_time,
	nvl(ord1.cumu_effect_gift_group_product_cnt,0) as cumu_effect_gift_group_product_cnt,
	nvl(ord1.cumu_trial_gift_group_product_cnt,0) as cumu_trial_gift_group_product_cnt,
	parse_json(
	'gift_service_cv_rank_days', nvl(ord2.gift_service_cv_rank_days,0),
	'gift_service_showad_days', nvl(ord2.gift_service_showad_days,0),
	'gift_service_applyprior_count', nvl(ord2.gift_service_applyprior_count,0),
	'gift_service_groupmessage_count', nvl(ord2.gift_service_groupmessage_count,0)
	) as cumu_effect_gift_resource_cnt,
	nvl(ord1.cumu_group_prod_cnt,0) as cumu_group_prod_cnt,
	parse_json(
	'pay_service_cv_rank_days', nvl(ord2.pay_service_cv_rank_days,0),
	'pay_service_showad_days', nvl(ord2.pay_service_showad_days,0),
	'pay_service_applyprior_count', nvl(ord2.pay_service_applyprior_count,0),
	'pay_service_groupmessage_count', nvl(ord2.pay_service_groupmessage_count,0)
	) as cumu_resource_cnt,
	nvl(ord1.cumu_group_prod_money,0) as cumu_group_prod_money,
	parse_json(
	'service_cv_rank_days_money', nvl(ord2.service_cv_rank_days_money,0),
	'service_showad_days_money', nvl(ord2.service_showad_days_money,0),
	'service_applyprior_count_money', nvl(ord2.service_applyprior_count_money,0),
	'service_groupmessage_count_money',nvl(ord2.service_groupmessage_count_money,0)) as cumu_resource_money,
	gc.createtime,
	gc.modifytime,
	current_timestamp creation_timestamp
from 
(select
	user_id,
	kind,
	effect_flag,
	reformat_datetime(start_date) as start_date,  
	reformat_datetime(end_date) as end_date,
	datediff(reformat_datetime(end_date),reformat_datetime(start_date)) as days,
	createtime,
	modifytime
from goldcard
) gc 
left join 
(select user_id,kind
   from goldcard_log
  where $date$ between start_date and substr(regexp_replace(date_add(reformat_datetime(start_date),days),'-',''),1,8)
) gc_kind 
on gc.user_id = gc_kind.user_id
left join 
(select user_id,
		c_industry,
		c_hope,
		c_jobtitle,
		c_workyear,
		c_dq,
		c_edulevel,
		c_edulevel_tz,
		c_sex,
		c_birth_year,
		(c_nowsalary*c_salmonths) / 10000 as c_yearsalary,
		(want_monthsalary*want_salmonths) / 10000 as c_want_yearsalary,
		c_title,
		c_school_kind,
		reg_device,
		c_marriage
   from dw_c_d_user_base 
   where p_date = $date$
) uc 
on gc.user_id = uc.user_id
left join 
(select user_id,
		res_id,
		integrity_flag,
		res_level
  from dw_c_d_res_base 
  where p_date = $date$
   and res_default_flag = 1
) rc 
on gc.user_id = rc.user_id
left join 
(select res_id,rw_start,rw_compkind
   from dw_c_a_res_workexperience_sorted
  where rws_index_reverse = 1
) rw 
on rc.res_id = rw.res_id
left join 
(
	select user_id, 
			max(case when buy_membership_order_seq = 1 then prod_id else -1 end ) as first_order_group_product_id, --第一次购买金卡套餐产品
			max(case when buy_membership_order_seq = 1 then order_createtime else -1 end ) as first_order_group_product_time, --第一次购买金卡套餐时间
			max(case when buy_membership_order_seq = 1 and before_order_isgift = 1 then 1 else 0 end ) as is_gift_before_first_order_group_product, --第一次购买金卡套餐前是否赠送金卡
			max(case when buy_membership_order_seq = 1 and before_order_isgift = 1 then before_order_prod else -1 end ) as gift_prod_before_first_order_group_product,--第一次购买金卡套餐前开通赠送金卡产品类型
			max(case when buy_order_seq_reverse = 1 and is_group_prod = 1 then prod_id else -1 end ) as last_prod_id,--最近一次购买的金卡类型
			max(case when buy_order_seq_reverse = 1 and is_group_prod = 1 then order_createtime else -1 end ) as last_order_time,--最近一次购买金卡时间
			count(case when is_in_service = 1 and is_group_prod = 1 and order_isgift = 1 then order_id else null end) as cumu_effect_gift_group_product_cnt,--累计服务期赠送套餐数
			count(case when is_in_service = 0 and is_group_prod = 1 and order_isgift = 1 then order_id else null end) as cumu_trial_gift_group_product_cnt,--累计非服务期赠送套餐数
			count(case when is_group_prod = 1 and order_isgift = 0 then order_id else null end) as cumu_group_prod_cnt,--累计购买套餐数
			sum(case when is_group_prod = 1 and order_isgift = 0 then order_money else null end) as cumu_group_prod_money, --累计购买套餐金额
			0 as is_gift_used_before_first_order_group_product
	from dw_c_a_goldcard_order
	group by user_id
) ord1
on gc.user_id = ord1.user_id
left join 
(
	select user_id, 
		   sum(case when is_group_prod = 0 and order_isgift = 1 then dm.service_cv_rank_days else 0 end) as gift_service_cv_rank_days,
		   sum(case when is_group_prod = 0 and order_isgift = 1 then dm.service_showad_days else 0 end) as gift_service_showad_days,
		   sum(case when is_group_prod = 0 and order_isgift = 1 then dm.service_applyprior_count else 0 end) as gift_service_applyprior_count,
		   sum(case when is_group_prod = 0 and order_isgift = 1 then dm.service_groupmessage_count else 0 end) as gift_service_groupmessage_count, 	
		   sum(case when is_group_prod = 0 and order_isgift = 0 then dm.service_cv_rank_days else 0 end) as pay_service_cv_rank_days,
		   sum(case when is_group_prod = 0 and order_isgift = 0 then dm.service_showad_days else 0 end) as pay_service_showad_days,
		   sum(case when is_group_prod = 0 and order_isgift = 0 then dm.service_applyprior_count else 0 end) as pay_service_applyprior_count,
		   sum(case when is_group_prod = 0 and order_isgift = 0 then dm.service_groupmessage_count else 0 end) as pay_service_groupmessage_count,
		   sum(case when is_group_prod = 0 and order_isgift = 0 and dm.service_cv_rank_days > 0 then ord.order_money end) as service_cv_rank_days_money,
		   sum(case when is_group_prod = 0 and order_isgift = 0 and dm.service_showad_days > 0 then ord.order_money end) as service_showad_days_money,
		   sum(case when is_group_prod = 0 and order_isgift = 0 and dm.service_applyprior_count > 0 then ord.order_money end) as service_applyprior_count_money,
		   sum(case when is_group_prod = 0 and order_isgift = 0 and dm.service_groupmessage_count > 0 then ord.order_money end) as service_groupmessage_count_money
	from dw_c_a_goldcard_order ord 
	 join dim_goldcard_product_matrix dm 
	 on ord.prod_id = dm.ppi_id
	group by user_id
) ord2
on gc.user_id = ord2.user_id
left join tongdaoren_id td 
on gc.user_id = td.user_id
where td.user_id is null;

create table dw_c_d_goldcard_resource_consume(
user_id int comment '经理人ID',
cv_rank_total_days int comment '简历置顶总天数',
cv_rank_used_days int comment '简历置顶已用天数',
td_cv_rank_used int comment '当天是否使用简历置顶',
cv_rank_show_cnt int comment '简历置顶展示次数',
cv_rank_pause_time string comment '简历置顶暂停时间',
apply_prior_total_cnt int comment '应聘优先总次数',
apply_prior_used_cnt int comment '应聘优先已用次数',
td_apply_prior_used_cnt int comment '应聘优先当天使用次数',
apply_prior_ejob_ids string comment '应聘优先hr职位id',
apply_prior_hjob_ids string comment '应聘优先猎头职位id',
apply_prior_rjob_ids string comment '应聘优先rpo职位id',
show_ad_total_days int comment '广告自荐总天数',
show_ad_used_days int comment '广告自荐已用天数',
td_show_ad_used int comment '当天是否使用广告自荐',
show_ad_show_cnt int comment '广告自荐展示次数',
show_ad_pause_time string comment '广告自荐暂停时间',
gm_total_cnt int comment '群发资源总数',
gm_used_cnt int comment '群发资源已用数',
td_gm_used_cnt int comment '当天使用群发次数',
td_gm_used_userh_cnt int comment '当天使用群发猎头数量(去重)',
cumu_gm_userh_cnt int comment '服务期内累计发送猎头数量(去重)',
cumu_gm_message_cnt int comment '金卡用户服务期累计主动发的消息数',
cumu_gm_res_cnt int comment '金卡用户服务期累计主动发简历消息数',
creation_timestamp timestamp comment '时间戳'
) comment '金卡用户资源使用表' 
partitioned by (p_date int);

--添加 apply_prior_rpo_job_ids string comment '应聘优先RPO职位id',


insert overwrite table dw_c_d_goldcard_resource_consume partition (p_date = $date$)
select 
gc.user_id,
nvl(cr.total_days,0) as cv_rank_total_days,
nvl(cr.used_days,0) as cv_rank_used_days,
nvl(case when cr.pause_flag = 0 then 1 else 0 end,-1) as td_cv_rank_used,
nvl(cr.show_cnt,0) as cv_rank_show_cnt,
reformat_datetime(nvl(cr.pause_time,'1900-01-01 00:00:00')) as cv_rank_pause_time,
nvl(ap.total_cnt,0) as apply_prior_total_cnt,
nvl(ap.used_cnt,0) as apply_prior_used_cnt,
nvl(ja.td_apply_prior_used_cnt,0) as td_apply_prior_used_cnt,
nvl(ja.apply_prior_ejob_ids,'-1') as apply_prior_ejob_ids,
nvl(ja.apply_prior_hjob_ids,'-1') as apply_prior_hjob_ids,
nvl(ja.apply_prior_rjob_ids,'-1') as apply_prior_rjob_ids,
nvl(sa.total_days,0) as show_ad_total_days,
nvl(sa.used_days,0) as show_ad_used_days,
nvl(case when sa.pause_flag = 0 then 1 else 0 end,-1) as td_show_ad_used,
nvl(sa.show_cnt,0) as show_ad_show_cnt,
reformat_datetime(nvl(sa.pause_time,'1900-01-01 00:00:00'))  as show_ad_pause_time,
nvl(gm.total_cnt,0) as gm_total_cnt,
nvl(gm.used_cnt,0) as gm_used_cnt,
nvl(gmu3.td_gm_used_cnt,0) as td_gm_used_cnt,
nvl(gmu3.td_gm_used_userh_cnt,0) as td_gm_used_userh_cnt,
nvl(gmu3.cumu_gm_userh_cnt,0) as cumu_gm_userh_cnt,
nvl(msg.cumu_gm_message_cnt,0) as cumu_gm_message_cnt,
nvl(msg.cumu_gm_res_cnt,0) as cumu_gm_res_cnt,
current_timestamp as creation_timestamp
from goldcard gc
left join cv_rank cr 
on gc.user_id = cr.user_id
left join apply_prior ap 
on gc.user_id = ap.user_id
left join 
(select user_id,
		combine(nvl(string(case when job_kind = 1 then job_id else null end),'-1')) as apply_prior_hjob_ids,
		combine(nvl(string(case when job_kind = 2 then job_id else null end),'-1')) as apply_prior_ejob_ids,
		combine(nvl(string(case when job_kind = 5 then job_id else null end),'-1')) as apply_prior_rjob_ids,		
		count(case when substr(regexp_replace(createtime,'-',''),1,8) = $date$ then apply_id else null end) as td_apply_prior_used_cnt
   from job_apply
  where substr(regexp_replace(createtime,'-',''),1,8) <= $date$
  group by user_id) ja 
on gc.user_id = ja.user_id

left join show_ad sa 
on gc.user_id = sa.user_id
left join group_message gm 
on gc.user_id = gm.user_id
left join 
(	select gmu2.user_id,
		   count(distinct case when gmu_date = '$date$' then id else null end) as td_gm_used_cnt,
		   count(distinct case when gmu_date = '$date$' then uh_list else null end) as td_gm_used_userh_cnt,
		   count(distinct uh_list) as cumu_gm_userh_cnt	   
	from (
		select user_id,uh_list,gmu_date,id
		from (select user_id,
				userh_list,
				substr(regexp_replace(createtime,'-',''),1,8) as gmu_date,id
		   from group_message_used
		   where substr(regexp_replace(createtime,'-',''),1,8) <= '$date$'
		     and send_flag = 1
		) gmu
		lateral view explode(split(userh_list,',')) i as uh_list
	) gmu2
	group by gmu2.user_id
) gmu3
on gc.user_id = gmu3.user_id
left join 
(select cm.user_id,
		sum(case when (cm.im_version = 1 and cm.message_kind in ('80','05')) or (cm.im_version = 2 and cm.message_kind = '6') then cm.message_cnt else 0 end) as cumu_gm_res_cnt,--私信-80群发简历 05委托简历 职聊-6-发送简历/转发简历
		sum( cm.message_cnt) as cumu_gm_message_cnt --私信-00普通私信 职聊-1-普通文本,图片,语音,地图消息
  from dw_c_d_user_message cm 
  join goldcard gc 
  on cm.user_id = gc.user_id
 where cm.p_date >= 20160101
   and cm.p_date >= gc.start_date
   and cm.user_kind = 0
   and cm.opposite_user_kind = 2
 group by cm.user_id 
 ) msg 
on gc.user_id = msg.user_id



insert overwrite table dw_c_d_goldcard_user_base partition (p_date = $date$)
select
	gc.user_id,
	rc.res_id,
	rc.res_level,
	uc.c_industry,
	uc.c_hope,
	uc.c_jobtitle,
	uc.c_workyear,
	uc.c_dq,
	uc.c_edulevel,
	uc.c_edulevel_tz,
	uc.c_sex,
	uc.c_birth_year,
	uc.c_yearsalary,
	uc.c_want_yearsalary,
	uc.c_title,
	uc.c_school_kind,
	uc.reg_device,
	rc.integrity_flag,
	uc.c_marriage,
	nvl(if(rw.rw_start='',null,rw.rw_start),'190001') as rw_start,
	nvl(if(rw.rw_compkind='',null,rw.rw_compkind), '-1') as rw_compkind,
	nvl(gc_kind.kind,gc.kind) as kind,
	gc.effect_flag,
	gc.start_date,
	gc.end_date,
	gc.days,
	nvl(ord1.first_order_group_product_id,-1) as first_order_group_product_id,
	nvl(ord1.first_order_group_product_time,'1900-01-01 00:00:00') as first_order_group_product_time,
	nvl(ord1.is_gift_before_first_order_group_product,-1) as is_gift_before_first_order_group_product,
	nvl(ord1.gift_prod_before_first_order_group_product,-1) as gift_prod_before_first_order_group_product,
	nvl(ord1.is_gift_used_before_first_order_group_product,-1) as is_gift_used_before_first_order_group_product,
	nvl(ord1.last_prod_id,-1) as last_prod_id,
	nvl(ord1.last_order_time,'1900-01-01 00:00:00') as last_order_time,
	nvl(ord1.cumu_effect_gift_group_product_cnt,0) as cumu_effect_gift_group_product_cnt,
	nvl(ord1.cumu_trial_gift_group_product_cnt,0) as cumu_trial_gift_group_product_cnt,
	parse_json(
	'gift_service_cv_rank_days', nvl(ord2.gift_service_cv_rank_days,0),
	'gift_service_showad_days', nvl(ord2.gift_service_showad_days,0),
	'gift_service_applyprior_count', nvl(ord2.gift_service_applyprior_count,0),
	'gift_service_groupmessage_count', nvl(ord2.gift_service_groupmessage_count,0)
	) as cumu_effect_gift_resource_cnt,
	nvl(ord1.cumu_group_prod_cnt,0) as cumu_group_prod_cnt,
	parse_json(
	'pay_service_cv_rank_days', nvl(ord2.pay_service_cv_rank_days,0),
	'pay_service_showad_days', nvl(ord2.pay_service_showad_days,0),
	'pay_service_applyprior_count', nvl(ord2.pay_service_applyprior_count,0),
	'pay_service_groupmessage_count', nvl(ord2.pay_service_groupmessage_count,0)
	) as cumu_resource_cnt,
	nvl(ord1.cumu_group_prod_money,0) as cumu_group_prod_money,
	parse_json(
	'service_cv_rank_days_money', nvl(ord2.service_cv_rank_days_money,0),
	'service_showad_days_money', nvl(ord2.service_showad_days_money,0),
	'service_applyprior_count_money', nvl(ord2.service_applyprior_count_money,0),
	'service_groupmessage_count_money',nvl(ord2.service_groupmessage_count_money,0)) as cumu_resource_money,
	gc.createtime,
	gc.modifytime,
	current_timestamp creation_timestamp
from 
(select
	user_id,
	kind,
	effect_flag,
	reformat_datetime(start_date) as start_date,  
	reformat_datetime(end_date) as end_date,
	datediff(reformat_datetime(end_date),reformat_datetime(start_date)) as days,
	createtime,
	modifytime
from recovery.goldcard_history_20170101_20170314
where p_date = $date$
) gc 
left join 
(select user_id,kind
   from goldcard_log
  where $date$ between start_date and substr(regexp_replace(date_add(reformat_datetime(start_date),days),'-',''),1,8)
) gc_kind 
on gc.user_id = gc_kind.user_id
left join 
(select user_id,
		c_industry,
		c_hope,
		c_jobtitle,
		c_workyear,
		c_dq,
		c_edulevel,
		c_edulevel_tz,
		c_sex,
		c_birth_year,
		(c_nowsalary*c_salmonths) / 10000 as c_yearsalary,
		(want_monthsalary*want_salmonths) / 10000 as c_want_yearsalary,
		c_title,
		c_school_kind,
		reg_device,
		c_marriage
   from dw_c_d_user_base 
   where p_date = $date$
) uc 
on gc.user_id = uc.user_id
left join 
(select user_id,
		res_id,
		integrity_flag,
		res_level
  from dw_c_d_res_base 
  where p_date = $date$
   and res_default_flag = 1
) rc 
on gc.user_id = rc.user_id
left join 
(select res_id,rw_start,rw_compkind
   from dw_c_a_res_workexperience_sorted
  where rws_index_reverse = 1
) rw 
on rc.res_id = rw.res_id
left join 
(
	select user_id, 
			max(case when buy_membership_order_seq = 1 then prod_id else -1 end ) as first_order_group_product_id, --第一次购买金卡套餐产品
			max(case when buy_membership_order_seq = 1 then order_createtime else -1 end ) as first_order_group_product_time, --第一次购买金卡套餐时间
			max(case when buy_membership_order_seq = 1 and before_order_isgift = 1 then 1 else 0 end ) as is_gift_before_first_order_group_product, --第一次购买金卡套餐前是否赠送金卡
			max(case when buy_membership_order_seq = 1 and before_order_isgift = 1 then before_order_prod else -1 end ) as gift_prod_before_first_order_group_product,--第一次购买金卡套餐前开通赠送金卡产品类型
			max(case when buy_order_seq_reverse = 1 and is_group_prod = 1 then prod_id else -1 end ) as last_prod_id,--最近一次购买的金卡类型
			max(case when buy_order_seq_reverse = 1 and is_group_prod = 1 then order_createtime else -1 end ) as last_order_time,--最近一次购买金卡时间
			count(case when is_in_service = 1 and is_group_prod = 1 and order_isgift = 1 then order_id else null end) as cumu_effect_gift_group_product_cnt,--累计服务期赠送套餐数
			count(case when is_in_service = 0 and is_group_prod = 1 and order_isgift = 1 then order_id else null end) as cumu_trial_gift_group_product_cnt,--累计非服务期赠送套餐数
			count(case when is_group_prod = 1 and order_isgift = 0 then order_id else null end) as cumu_group_prod_cnt,--累计购买套餐数
			sum(case when is_group_prod = 1 and order_isgift = 0 then order_money else null end) as cumu_group_prod_money, --累计购买套餐金额
			0 as is_gift_used_before_first_order_group_product
	from dw_c_a_goldcard_order
	group by user_id
) ord1
on gc.user_id = ord1.user_id
left join 
(
	select user_id, 
		   sum(case when is_group_prod = 0 and order_isgift = 1 then dm.service_cv_rank_days else 0 end) as gift_service_cv_rank_days,
		   sum(case when is_group_prod = 0 and order_isgift = 1 then dm.service_showad_days else 0 end) as gift_service_showad_days,
		   sum(case when is_group_prod = 0 and order_isgift = 1 then dm.service_applyprior_count else 0 end) as gift_service_applyprior_count,
		   sum(case when is_group_prod = 0 and order_isgift = 1 then dm.service_groupmessage_count else 0 end) as gift_service_groupmessage_count, 	
		   sum(case when is_group_prod = 0 and order_isgift = 0 then dm.service_cv_rank_days else 0 end) as pay_service_cv_rank_days,
		   sum(case when is_group_prod = 0 and order_isgift = 0 then dm.service_showad_days else 0 end) as pay_service_showad_days,
		   sum(case when is_group_prod = 0 and order_isgift = 0 then dm.service_applyprior_count else 0 end) as pay_service_applyprior_count,
		   sum(case when is_group_prod = 0 and order_isgift = 0 then dm.service_groupmessage_count else 0 end) as pay_service_groupmessage_count,
		   sum(case when is_group_prod = 0 and order_isgift = 0 and dm.service_cv_rank_days > 0 then ord.order_money end) as service_cv_rank_days_money,
		   sum(case when is_group_prod = 0 and order_isgift = 0 and dm.service_showad_days > 0 then ord.order_money end) as service_showad_days_money,
		   sum(case when is_group_prod = 0 and order_isgift = 0 and dm.service_applyprior_count > 0 then ord.order_money end) as service_applyprior_count_money,
		   sum(case when is_group_prod = 0 and order_isgift = 0 and dm.service_groupmessage_count > 0 then ord.order_money end) as service_groupmessage_count_money
	from dw_c_a_goldcard_order ord 
	 join dim_goldcard_product_matrix dm 
	 on ord.prod_id = dm.ppi_id
	group by user_id
) ord2
on gc.user_id = ord2.user_id
left join tongdaoren_id td 
on gc.user_id = td.user_id
where td.user_id is null;


recovery.show_ad_history_20170101_20170314
recovery.groupmessage_history_20170101_20170314
recovery.goldcard_history_20170101_20170314
recovery.cv_rank_history_20170101_20170314
recovery.apply_prior_history_20170101_20170314

insert overwrite table dw_c_d_goldcard_resource_consume partition (p_date = $date$)
select 
gc.user_id,
nvl(cr.total_days,0) as cv_rank_total_days,
nvl(cr.used_days,0) as cv_rank_used_days,
nvl(case when cr.pause_flag = 0 then 1 else 0 end,-1) as td_cv_rank_used,
nvl(cr.show_cnt,0) as cv_rank_show_cnt,
reformat_datetime(nvl(cr.pause_time,'1900-01-01 00:00:00')) as cv_rank_pause_time,
nvl(ap.total_cnt,0) as apply_prior_total_cnt,
nvl(ap.used_cnt,0) as apply_prior_used_cnt,
nvl(ja.td_apply_prior_used_cnt,0) as td_apply_prior_used_cnt,
nvl(ja.apply_prior_ejob_ids,'-1') as apply_prior_ejob_ids,
nvl(ja.apply_prior_hjob_ids,'-1') as apply_prior_hjob_ids,
nvl(ja.apply_prior_rjob_ids,'-1') as apply_prior_rjob_ids,
nvl(sa.total_days,0) as show_ad_total_days,
nvl(sa.used_days,0) as show_ad_used_days,
nvl(case when sa.pause_flag = 0 then 1 else 0 end,-1) as td_show_ad_used,
nvl(sa.show_cnt,0) as show_ad_show_cnt,
reformat_datetime(nvl(sa.pause_time,'1900-01-01 00:00:00'))  as show_ad_pause_time,
nvl(gm.gm_totalcnt,0) as gm_total_cnt,
nvl(gm.gm_usedcnt,0) as gm_used_cnt,
nvl(gmu3.td_gm_used_cnt,0) as td_gm_used_cnt,
nvl(gmu3.td_gm_used_userh_cnt,0) as td_gm_used_userh_cnt,
nvl(gmu3.cumu_gm_userh_cnt,0) as cumu_gm_userh_cnt,
nvl(msg.cumu_gm_message_cnt,0) as cumu_gm_message_cnt,
nvl(msg.cumu_gm_res_cnt,0) as cumu_gm_res_cnt,
current_timestamp as creation_timestamp
from recovery.goldcard_history_20170101_20170314 gc
left join recovery.cv_rank_history_20170101_20170314 cr 
on gc.user_id = cr.user_id
and cr.p_date = $date$
left join recovery.apply_prior_history_20170101_20170314 ap 
on gc.user_id = ap.user_id
and ap.p_date = $date$
left join 
(select user_id,
		combine(nvl(string(case when job_kind = 1 then job_id else null end),'-1')) as apply_prior_hjob_ids,
		combine(nvl(string(case when job_kind = 2 then job_id else null end),'-1')) as apply_prior_ejob_ids,
		combine(nvl(string(case when job_kind = 5 then job_id else null end),'-1')) as apply_prior_rjob_ids,		
		count(case when substr(regexp_replace(createtime,'-',''),1,8) = $date$ then apply_id else null end) as td_apply_prior_used_cnt
   from job_apply
  where substr(regexp_replace(createtime,'-',''),1,8) <= $date$
  group by user_id) ja 
on gc.user_id = ja.user_id
left join recovery.show_ad_history_20170101_20170314 sa 
on gc.user_id = sa.user_id
and sa.p_date = $date$
left join recovery.groupmessage_history_20170101_20170314 gm 
on gc.user_id = gm.user_id
and gm.p_date = $date$
left join 
(	select gmu2.user_id,
		   count(case when gmu_date = '$date$' then uh_list else null end) as td_gm_used_cnt,
		   count(distinct case when gmu_date = '$date$' then uh_list else null end) as td_gm_used_userh_cnt,
		   count(distinct uh_list) as cumu_gm_userh_cnt	   
	from (
		select user_id,uh_list,gmu_date
		from (select user_id,
				gmu_userh_list,
				substr(regexp_replace(gmu_createtime,'-',''),1,8) as gmu_date
		   from groupmessage_used
		   where substr(regexp_replace(gmu_createtime,'-',''),1,8) <= '$date$'
		     and gmu_flag = 1
		) gmu
		lateral view explode(split(gmu_userh_list,',')) i as uh_list
	) gmu2
	group by gmu2.user_id
) gmu3
on gc.user_id = gmu3.user_id
left join 
(select cm.user_id,
		sum(case when (cm.im_version = 1 and cm.message_kind in ('80','05')) or (cm.im_version = 2 and cm.message_kind = '6') then cm.message_cnt else 0 end) as cumu_gm_res_cnt,--私信-80群发简历 05委托简历 职聊-6-发送简历/转发简历
		sum( cm.message_cnt) as cumu_gm_message_cnt --私信-00普通私信 职聊-1-普通文本,图片,语音,地图消息
  from dw_c_d_user_message cm 
  join recovery.goldcard_history_20170101_20170314 gc 
  on cm.user_id = gc.user_id
  and gc.p_date = $date$
 where cm.p_date >= 20160101
   and cm.p_date >= gc.start_date
   and cm.user_kind = 0
   and cm.opposite_user_kind = 2
 group by cm.user_id 
 ) msg 
on gc.user_id = msg.user_id
where gc.p_date = $date$;


insert overwrite table dw_c_d_goldcard_resource_consume partition (p_date = '$date$')
select 
  dc.user_id
, dc.cv_rank_total_days
, dc.cv_rank_used_days
, dc.td_cv_rank_used
, dc.cv_rank_show_cnt
, dc.cv_rank_pause_time
, dc.apply_prior_total_cnt
, dc.apply_prior_used_cnt
, dc.td_apply_prior_used_cnt
, dc.apply_prior_ejob_ids
, dc.apply_prior_hjob_ids
, dc.apply_prior_rjob_ids
, dc.show_ad_total_days
, dc.show_ad_used_days
, dc.td_show_ad_used
, dc.show_ad_show_cnt
, dc.show_ad_pause_time
, nvl(new.gm_total_cnt,0) - nvl(gm_add.add_cnt,0) as gm_total_cnt
, nvl(new.gm_used_cnt,0) - nvl(gm_sub.sub_cnt,0) as gm_used_cnt
, nvl(gmu3.td_gm_used_cnt,0)
, nvl(gmu3.td_gm_used_userh_cnt,0)
, nvl(gmu3.cumu_gm_userh_cnt,0)
, dc.cumu_gm_message_cnt
, dc.cumu_gm_res_cnt
, current_timestamp as creation_timestamp
from dw_c_d_goldcard_resource_consume dc
left join 
(	select gmu2.user_id,
		   count(distinct case when gmu_date = '$date$' then id else null end) as td_gm_used_cnt,
		   count(distinct case when gmu_date = '$date$' then uh_list else null end) as td_gm_used_userh_cnt,
		   count(distinct uh_list) as cumu_gm_userh_cnt	   
	from (
		select user_id,uh_list,gmu_date,id
		from (select user_id,
				userh_list,
				substr(regexp_replace(createtime,'-',''),1,8) as gmu_date,id
		   from group_message_used
		   where substr(regexp_replace(createtime,'-',''),1,8) <= '$date$'
		     and send_flag = 1
		) gmu
		lateral view explode(split(userh_list,',')) i as uh_list
	) gmu2
	group by gmu2.user_id
) gmu3
on dc.user_id = gmu3.user_id
left join 
(	select user_id,
			count(id) as sub_cnt
	   from group_message_used
	   where substr(regexp_replace(createtime,'-',''),1,8) = {{delta(date,1)}}
	     and send_flag = 1
		group by user_id
) gm_sub
on dc.user_id = gm_sub.user_id
left join 
(select user_id,sum(cnt) as add_cnt 
from group_message_log
where substr(regexp_replace(createtime,'-',''),1,8) =  {{delta(date,1)}}  
group by user_id) gm_add
on dc.user_id = gm_add.user_id
left join 
(select user_id,gm_total_cnt,gm_used_cnt
  from dw_c_d_goldcard_resource_consume
  where p_date = {{delta(date,1)}}  
) new 
on dc.user_id = new.user_id
where p_date = '$date$'