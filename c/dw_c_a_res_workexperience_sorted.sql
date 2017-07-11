create table dw_c_a_res_workexperience_sorted
(
mule_sharding_primary_key string comment '分库分表添加主键',
rw_id	bigint	comment '工作经历主键',
res_id	bigint	comment '简历主键',
rw_start	string	comment '开始时间',
rw_end	string	comment '结束时间',
rw_compname	string	comment '公司名称',
rw_compdesc	string	comment '公司描述',
rw_compkind	string	comment '公司性质',
rw_compscale	string	comment '公司规模',
rw_industry	string	comment '行业',
rw_title	string	comment '职位名称',
rw_dept	string	comment '所在部门',
rw_dq	string	comment '工作地点',
rw_salary	string	comment '薪水',
rw_report2	string	comment '汇报对象',
rw_subordinate	string	comment '下属人数',
rw_duty	string	comment '工作职责',
rw_salmonths	int	comment '薪资月数',
delflag	string	comment '删除标示,0:正常 1:删除',
modifiedtime	string	comment '简历修改时间',
createtime	string	comment '创建时间',
rws_index int comment '基于简历的经历排序号',
rws_comp_index int comment '基于简历各公司的经历排序号',
rws_comp_detail_index int comment '基于简历每个公司内各段工作经历的排序号',
creation_timestamp timestamp COMMENT '时间戳'
) comment '工作经历扩展表-带经历排序号';

alter table dw_c_a_res_workexperience_sorted add columns(is_foreign_work int comment '是否海外工作经历,1:有,0:没有,-1:未知' );

alter table dw_c_a_res_workexperience_sorted change is_foreign_work is_foreign_work int comment '是否海外工作经历,1:有,0:没有,-1:未知' ;

alter table dw_c_a_res_workexperience_sorted add columns(rws_index_reverse int comment '基于简历的经历倒序排序号');

insert overwrite table dw_c_a_res_workexperience_sorted
select 
  rw_new.mule_sharding_primary_key, 
  rw_new.rw_id, 
  rw_new.res_id, 
  rw_new.rw_start, 
  rw_new.rw_end, 
  rw_new.rw_compname, 
  rw_new.rw_compdesc, 
  rw_new.rw_compkind, 
  rw_new.rw_compscale, 
  case when (rw_new.rw_industry is null or  rw_new.rw_industry = '') and rws_index_reverse = 1 then rw_new.c_industry else rw_new.rw_industry end as rw_industry,   
  rw_new.rw_title, 
  rw_new.rw_dept, 
  case when (rw_new.rw_dq is null or  rw_new.rw_dq = '') and rws_index_reverse = 1 then rw_new.c_dq else rw_new.rw_dq end as rw_dq, 
  rw_new.rw_salary, 
  rw_new.rw_report2, 
  rw_new.rw_subordinate, 
  rw_new.rw_duty, 
  rw_new.rw_salmonths, 
  rw_new.delflag, 
  rw_new.modifiedtime, 
  rw_new.createtime, 
  rw_new.rws_index, 
  rw_new.rws_comp_index, 
  rw_new.rws_comp_detail_index, 
  rw_new.creation_timestamp, 
  rw_new.is_foreign_work, 
  rw_new.rws_index_reverse
from (
select 
rw.mule_sharding_primary_key,
rw.rw_id,
rw.res_id,
rw.rw_start,
rw.rw_end,
rw.rw_compname,
rw.rw_compdesc,
rw.rw_compkind,
rw.rw_compscale,
rw.rw_industry,
rw.rw_title,
rw.rw_dept,
rw.rw_dq,
rw.rw_salary,
rw.rw_report2,
rw.rw_subordinate,
rw.rw_duty,
rw.rw_salmonths,
rw.delflag,
rw.modifiedtime,
rw.createtime,
row_number()over(distribute by rw.res_id sort by rw.rw_end,rw.rw_start) as rws_index,
dense_rank()over(distribute by rw.res_id sort by rwm.min_rw_end,rwm.min_rw_start) as rws_comp_index,
row_number()over(distribute by rw.res_id,rw.rw_compname sort by rw.rw_end,rw.rw_start) as rws_comp_detail_index,
from_unixtime(unix_timestamp()) as creation_timestamp,
case when substr(nvl(dim_dq.d_parent_code,'000'),1,3) in ('350','360','370','380','390','400') then 1 
	 when substr(nvl(dim_dq.d_parent_code,'000'),1,3) in ('000','999') then -1
	 else 0 end as  is_foreign_work,
row_number()over(distribute by rw.res_id sort by rw.rw_end desc,rw.rw_start desc) as rws_index_reverse,
nvl(uc.c_dq,'999') as c_dq,
nvl(uc.c_industry,'999') as c_industry
from res_workexperience rw
left join 
(select mule_sharding_primary_key,rw_id,
		min(rw_end)over(distribute by res_id,rw_compname) as min_rw_end,
		min(rw_start)over(distribute by res_id,rw_compname) as min_rw_start
  from res_workexperience
  where delflag = 0
  ) rwm 
on rw.mule_sharding_primary_key = rwm.mule_sharding_primary_key
left join dim_dq
on rw.rw_dq = dim_dq.d_code
left join res_user res 
on rw.res_id = res.res_id 
left join user_c uc 
on res.user_id = uc.user_id
where rw.delflag = 0
) rw_new;


select rw_dq,count(1) as cnt 
from dw_c_a_res_workexperience_sorted
group by rw_dq