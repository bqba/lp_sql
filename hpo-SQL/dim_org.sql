
create table if not exists dim_org
(
	d_org_id  int comment '组织ID',
	org_name string comment '组织名称',
	branch_id int comment '分公司ID',
	branch_name string comment '分公司名称',
	area_id int comment '大区ID',
	area_name string comment '大区名称',	
	parent_id int  comment '上级组织id',
	parent_name string  comment '上级部门名称',
	upper_path string comment '父节点path',	
	repertory_industry string  comment '深耕行业',	
	createtime string  comment '创建时间',
	modifytime string  comment '修改时间',
	close_flag int  comment '封存标志',
	sub_kind string  comment '组织类型:多种类型以,分隔(1:lpt销售,2:大客户销售,10:高级lpt销售,3:执行项目经理,4:RPO项目执行,5:RPS招聘服务中心,9:猎头顾问,11:CDC职业顾问,6:技术,8:其他)',
	is_sales_org int comment '是否销售团队：0:否，1:是',
	is_gcdc_org int comment '是否GCDC团队：0:否，1:是',
	is_sales_org_s int comment '是否lpt销售团队：0:否，1:是',
	is_sales_org_ss int comment '是否高级lpt销售团队：0:否，1:是',
	is_sales_org_ka int comment '是否大客户销售团队：0:否，1:是',		
	creation_timestamp timestamp comment '时间戳'
);
create table if not exists dim_org
(
	d_org_id  int comment '组织ID',
	org_name varchar(200) comment '组织名称',
	branch_id int comment '分公司ID',
	branch_name varchar(200) comment '分公司名称',
	area_id int comment '大区ID',
	area_name varchar(200) comment '大区名称',	
	parent_id int  comment '上级组织id',
	parent_name varchar(200)  comment '上级部门名称',
	upper_path varchar(200) comment '父节点path',	
	repertory_industry varchar(200)  comment '深耕行业',	
	createtime varchar(200)  comment '创建时间',
	modifytime varchar(200)  comment '修改时间',
	close_flag int  comment '封存标志',
	sub_kind varchar(200)  comment '组织类型:多种类型以,分隔(1:lpt销售,2:大客户销售,10:高级lpt销售,3:执行项目经理,4:RPO项目执行,5:RPS招聘服务中心,9:猎头顾问,11:CDC职业顾问,6:技术,8:其他)',
	is_sales_org int comment '是否销售团队：0:否，1:是',
	is_gcdc_org int comment '是否GCDC团队：0:否，1:是',
	is_sales_org_s int comment '是否lpt销售团队：0:否，1:是',
	is_sales_org_ss int comment '是否高级lpt销售团队：0:否，1:是',
	is_sales_org_ka int comment '是否大客户销售团队：0:否，1:是',		
	creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
	primary key (d_org_id)
);

insert overwrite table dim_org 
select  org.id,
			org.name,
			nvl(case when gp.is_gcdc_org = 1 then cast(nvl(tj.branch_id,org.branch_id) as bigint) else org.branch_id end,-1) as branch_id,
			nvl(case when gp.is_gcdc_org = 1 then nvl(tj.branch_name,branch.branch_name) else  branch.branch_name end ,'未知') as branch_name,
			nvl(branch.area_id,-1) as area_id,
			nvl(branch.area_name,'未知') as area_name,
			nvl(org.parent_id,-1) as parent_id,
			nvl(parent.name,'未知') as parent_name,
			nvl(org.upper_path,-1) as upper_path,
			org.repertory_industry,
			org.createtime,
			org.modifytime,
			org.close_flag,
			nvl(gp.sub_kind,-1) as sub_kind,
			nvl(gp.is_sales_org,-1) as is_sales_org,
			nvl(gp.is_gcdc_org,-1) as is_gcdc_org,
			nvl(gp.is_sales_org_s,-1) as is_sales_org_s,
			nvl(gp.is_sales_org_ss,-1) as is_sales_org_ss,
			nvl(gp.is_sales_org_ka,-1) as is_sales_org_ka,
			CURRENT_TIMESTAMP	
from portal_org org
left join 
(select member_org_id,
		combine(string(sub_kind)) as sub_kind,
		case when sum(case when sub_kind = 1 then 1 else 0 end) > 0 then 1 else 0 end as is_sales_org_s,
		case when sum(case when sub_kind = 2 then 1 else 0 end) > 0 then 1 else 0 end as is_sales_org_ka,
		case when sum(case when sub_kind = 10 then 1 else 0 end) > 0 then 1 else 0 end as is_sales_org_ss,
		case when sum(case when sub_kind in (1,2,10) then 1 else 0 end) > 0 then 1 else 0 end as is_sales_org,
		case when sum(case when sub_kind in (3,4,5,9,11) then 1 else 0 end) > 0 then 1 else 0 end as is_gcdc_org
   from portal_org_group
   where deleteflag = 0
   group by member_org_id
 ) gp
on org.id = gp.member_org_id
left join
(
	select  city.id branch_id,
				city.name branch_name,
				area.id area_id,
				area.name area_name
	from 
	(select id,name,parent_id
	from portal_org
	where kind = 1
	and deleteflag = 0)  city
	left join 
	(select id,name
	from portal_org
	where kind = 5
	and deleteflag = 0)  area
	on city.parent_id = area.id 
) branch 
on org.branch_id = branch.branch_id
left join
(select id,name, '10210' as branch_id,
			'天津' as branch_name
   from portal_org
  where instr(upper_path,',10421,') > 0
  and deleteflag = 0
 )  tj  --10421	汇才属下GCDC组织迁移到天津分公司属下
on org.id = tj.id
left join
(select id,name
from portal_org
where deleteflag = 0)  parent
on org.parent_id = parent.id;





create table dim_org
(
	d_org_id  int comment '组织ID',
	org_name varchar(200) comment '组织名称',
	branch_id int comment '分公司ID',
	branch_name varchar(200) comment '分公司名称',
	area_id int comment '大区ID',
	area_name varchar(200) comment '大区名称',
	parent_id int  comment '上级组织id',
	parent_name varchar(200)  comment '上级部门名称',
	upper_path varchar(200) comment '父节点path',
	repertory_industry varchar(200)  comment '深耕行业',
	createtime varchar(50)  comment '创建时间',
	modifytime varchar(50)  comment '修改时间',
	close_flag int  comment '封存标志: 1-封存',
	sub_kind int  comment '组织类型:1-lpt销售,2-大客户销售,10-高级lpt销售,3-执行项目经理,4-RPO项目执行,5-RPS招聘服务中心,9-猎头顾问,11-CDC职业顾问,6-技术,8-其他',
	creation_timestamp  timestamp default CURRENT_TIMESTAMP comment ' 时间戳 ',
	primary key (d_org_id)
) ;

insert overwrite table dim_org
select d_org_id
, org_name
, branch_id
, branch_name
, area_id
, area_name
, parent_id
, parent_name
, upper_path
, repertory_industry
, createtime
, modifytime
, close_flag
, sub_kind
, is_sales_org
, is_gcdc_org
, is_sales_org_s
, is_sales_org_ss
, is_sales_org_ka
, creation_timestamp
from dim_org