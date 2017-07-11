create table if not exists dw_erp_d_contract_base_pre (
id int comment '主键id',
contract_no string comment '合同号',
customer_id int comment '客户id',
customer_linkman_id int comment '客户联系人',
type int comment '合同类型: 0-猎聘通网上综合合同，1-诚聘通合同，2-薪酬报告，10-校园，11-rpo，12-广告，13-猎聘通，14-白领在线支付合同',
subtype int comment '合同类型划分的小类型: 0-默认，1-rpo推荐免试，2-rpo推荐入职/猎头，3-rpo独家专场，4-rpo行业职能专场，5-rpo其他，6-lpol合同，7-白领在线支付合同',
action int comment '合同产生类型 0-新签 1-补偿 3-销售确认(系统自动生成)',
subaction int comment '合同子类型 0-新签，1-能源转移，2-补偿，3-销售确认，4-资源置换',
status int comment '合同主状态 0-编制中,1-我方盖章完成,2-已回执,3-已生效,4-作废',
audit_status int comment '合同审核状态 0-编制中,1-待审核,2-审核通过,3-驳回(可修改)',
money float comment '实际总金额',
secondparty_sign_id int comment '签约人',
secondparty_sign_name string comment '签约人名称',
secondparty_sign_pos_chnl string comment '签约人职位通道',
secondparty_sign_org string comment '签约人所属组织',
secondparty_sign_org_name string comment '签约人组织名称',
sign_date string comment '签约日期',
object_suit_id int comment '套餐id',
lpt_products_instance string comment '猎聘通产品实例列表',
ad_products_instance string comment '广告产品实例列表',
srp_products_instance string comment '薪酬报告产品实例列表',
clt_products_instance string comment '诚猎通产品实例列表',
suit_products_instance string comment '套餐产品实例列表',
expect_pay_date string comment '预计付款日期',
pay_another int comment '是否代付 0 非代付,1代付',
relation_contract_id int comment '补偿的源合同id',
memo string comment '备注',
creator_id int comment '当前维护人',
creator_name string comment '维护人名称',
creator_position_channel string comment '维护人职位通道',
creator_org_id int comment '维护人所属组织',
creator_org_name string comment '维护人组织名称',
createtime timestamp comment '创建日期',
modifytime timestamp comment '修改日期',
lpt_service_effect_date string comment '猎聘通服务生效时间',
lpt_service_expired_date string comment '猎聘通服务过期时间',
contract_effect_time timestamp comment '猎聘通合同生效日期',
contract_sign_effect_mode int comment '猎聘通合同上约定的生效模式',
contract_sign_effect_date string comment '猎聘通合同上约定的生效日期',
service_days int comment '猎聘通合同服务天数',
res_cnt int comment '猎聘通合同简历数',
job_cnt int comment '猎聘通合同精英职位数',
intention_cnt int comment '猎聘通合同意向沟通数',
invite_apply_cnt int comment '猎聘通合同邀请应聘数',
download_coupon_cnt int comment '猎聘通合同下载券数数',
interview_coupon_cnt int comment '猎聘通合同面试快券数',
point_cnt int comment '猎聘通合同积分数',
junior_res_cnt int comment '猎聘通合同白领简历数',
junior_job_cnt int comment '猎聘通合同白领职位数',
payment_days int comment '猎聘通合同账期天数',
input_lpt_money float comment '猎聘通合同手工录入的lpt金额',
is_junior_contract int comment '猎聘通合同是否白领合同',
opportunity_id int comment '商机ID',
creation_timestamp timestamp comment '时间戳'
) comment '合同实体表'
partitioned by (p_date int);

alter table dw_erp_d_contract_base add columns (
inner_money	float	comment '内部结算总金额',
online_money	float	comment '综合合同的线上部分总金额',
online_inner_money	float	comment '综合合同的线上部分内部结算总金额',
rpo_money	float	comment '综合合同的线下部分内部结算总金额',
rpo_inner_money	float	comment '综合合同的线下部分内部结算总金额',
is_less_inner_price	int	comment '是否低于内部结算价 0 不低于 1低于') cascade; 

alter table dw_erp_d_contract_base add columns (push_lpt_flag int comment '推送LPT状态标识 0-未推送 1-已推送') cascade; 

alter table dw_erp_d_contract_base add columns (bc_products_instance string comment '产品实例内容：商业中心json',test_products_instance	string comment '产品实例内容：测评json') cascade; 

insert overwrite table dw_erp_d_contract_base partition (p_date = $date$)
select
nvl(contract.id,-1) as id,
nvl(contract.contract_no,'-1') as contract_no,
nvl(contract.customer_id,-1) as customer_id,
nvl(contract.customer_linkman_id,-1) as customer_linkman_id,
nvl(contract.type,-1) as type,
nvl(contract.subtype,-1) as subtype,
nvl(contract.action,-1) as action,
nvl(contract.subaction,-1) as subaction,
nvl(contract.status,-1) as status,
nvl(contract.audit_status,-1) as audit_status,
nvl(contract.money,0) as money,
nvl(contract.secondparty_sign_id,-1) as secondparty_sign_id,
nvl(salesuser.name,'未知') as secondparty_sign_name,
nvl(salesuser.position_channel,'-1') as secondparty_sign_pos_chnl,
nvl(salesuser.org_id,-1) as secondparty_sign_org,
nvl(salesuser.org_name,'未知') as secondparty_sign_org_name,
nvl(concat(substr(contract.sign_date,1,4),'-',substr(contract.sign_date,5,2),'-',substr(contract.sign_date,7,2)) , '1900-01-01' )  as sign_date,
nvl(contract.object_suit_id,0) as object_suit_id,
nvl(saleitem.lpt_products_instance,0) as lpt_products_instance,
nvl(saleitem.ad_products_instance,0) as ad_products_instance,
nvl(saleitem.srp_products_instance,0) as srp_products_instance,
nvl(saleitem.clt_products_instance,0) as clt_products_instance,
nvl(saleitem.suit_products_instance,0) as suit_products_instance,
nvl(concat(substr(contract.expect_pay_date,1,4),'-',substr(contract.expect_pay_date,5,2),'-',nvl(substr(contract.expect_pay_date,7,2),'01') ), '1900-01-01' )  as expect_pay_date,
nvl(contract.pay_another,-1) as pay_another,
nvl(case when contract.id = contract.relation_contract_id then 0
else contract.relation_contract_id end ,-1) as relation_contract_id,
nvl(contract.memo,'999') as memo,
nvl(contract.creator_id,-1) as creator_id,
nvl(salesuser2.name,'未知') as creator_name,
nvl(salesuser2.position_channel,'-1') as creator_position_channel,
nvl(salesuser2.org_id,-1) as creator_org_id,
nvl(salesuser2.org_name,'未知') as creator_org_name,
contract.createtime as createtime,
contract.modifytime as modifytime,
nvl(concat(substr(lpt.lpt_service_effect_date,1,4),'-',substr(lpt.lpt_service_effect_date,5,2),'-',substr(lpt.lpt_service_effect_date,7,2)) , '1900-01-01' )  as lpt_service_effect_date,
nvl(concat(substr(lpt.lpt_service_expired_date,1,4),'-',substr(lpt.lpt_service_expired_date,5,2),'-',substr(lpt.lpt_service_expired_date,7,2)) , '1900-01-01' )  as lpt_service_expired_date,
nvl(reformat_date(lpt.contract_effect_time) , '1900-01-01' )  as contract_effect_time,
nvl(lpt.contract_sign_effect_mode,-1) as contract_sign_effect_mode,
nvl(concat(substr(lpt.contract_sign_effect_date,1,4),'-',substr(lpt.contract_sign_effect_date,5,2),'-',substr(lpt.contract_sign_effect_date,7,2)) , '1900-01-01' )  as contract_sign_effect_date,
nvl(lpt.service_days,-1) as service_days,
nvl(lpt.res_cnt,0) as res_cnt,
nvl(lpt.job_cnt,0) as job_cnt,
nvl(lpt.intention_cnt,0) as intention_cnt,
nvl(lpt.invite_apply_cnt,0) as invite_apply_cnt,
nvl(lpt.download_coupon_cnt,0) as download_coupon_cnt,
nvl(lpt.interview_coupon_cnt,0) as interview_coupon_cnt,
nvl(lpt.point_cnt,0) as point_cnt,
nvl(lpt.junior_res_cnt,0) as junior_res_cnt,
nvl(lpt.junior_job_cnt,0) as junior_job_cnt,
nvl(lpt.payment_days,0) as payment_days,
nvl(lpt.input_lpt_money,0) as input_lpt_money,
nvl(lpt.is_junior_contract,0) as is_junior_contract,
nvl(contract.opportunity_id,-1) as opportunity_id,
from_unixtime(unix_timestamp()) as creation_timestamp,
nvl(contract.inner_money,0) as inner_money,
nvl(contract.online_money,0) as online_money,
nvl(contract.online_inner_money,0) as online_inner_money,
nvl(contract.rpo_money,0) as rpo_money,
nvl(contract.rpo_inner_money,0) as rpo_inner_money,
nvl(contract.is_less_inner_price,0) as is_less_inner_price,
nvl(lpt.push_lpt_flag,-1) as push_lpt_flag,
nvl(saleitem.bc_products_instance,0) as bc_products_instance,
nvl(saleitem.test_products_instance,0) as test_products_instance
from crm_contract contract
left outer join crm_contract_lpt lpt 
on contract.id = lpt.contract_id 
and lpt.deleteflag = 0
left outer join crm_contract_saleitem saleitem
on contract.id = saleitem.contract_id
and saleitem.deleteflag = 0
left outer join 
(select id, name,position_channel,org_id,org_name
from dw_erp_d_salesuser_base 
where p_date = '$date$' ) salesuser
on contract.secondparty_sign_id = salesuser.id
left outer join 
(select id, name,position_channel,org_id,org_name
from dw_erp_d_salesuser_base 
where p_date = '$date$' ) salesuser2
on contract.creator_id = salesuser2.id
where contract.deleteflag = 0
;



insert overwrite table dw_erp_d_contract_base partition(p_date)
select 
contract.id,
contract.contract_no,
contract.customer_id,
contract.customer_linkman_id,
contract.type,
contract.subtype,
contract.action,
contract.subaction,
contract.status,
contract.audit_status,
contract.money,
contract.secondparty_sign_id,
contract.secondparty_sign_name,
contract.secondparty_sign_pos_chnl,
contract.secondparty_sign_org,
contract.secondparty_sign_org_name,
contract.sign_date,
contract.object_suit_id,
contract.lpt_products_instance,
contract.ad_products_instance,
contract.srp_products_instance,
contract.clt_products_instance,
contract.suit_products_instance,
contract.expect_pay_date,
contract.pay_another,
contract.relation_contract_id,
contract.memo,
contract.creator_id,
contract.creator_name,
contract.creator_position_channel,
contract.creator_org_id,
contract.creator_org_name,
contract.createtime,
contract.modifytime,
contract.lpt_service_effect_date,
contract.lpt_service_expired_date,
contract.contract_effect_time,
contract.contract_sign_effect_mode,
contract.contract_sign_effect_date,
contract.service_days,
contract.res_cnt,
contract.job_cnt,
contract.intention_cnt,
contract.invite_apply_cnt,
contract.download_coupon_cnt,
contract.interview_coupon_cnt,
contract.point_cnt,
contract.junior_res_cnt,
contract.junior_job_cnt,
contract.payment_days,
contract.input_lpt_money,
contract.is_junior_contract,
contract.opportunity_id,
contract.creation_timestamp,
contract.p_date,
opp.inner_money,
opp.online_money,
opp.online_inner_money,
opp.rpo_money,
opp.rpo_inner_money,
opp.is_less_inner_price
from dw_erp_d_contract_base contract 
left join crm_contract opp
on contract.id = opp.id
where contract.p_date between 20170401 and 20170412;

alter table dw_erp_d_contract_base rename to dw_erp_d_contract_base_0926;
alter table dw_erp_d_contract_base_pre rename to dw_erp_d_contract_base;


