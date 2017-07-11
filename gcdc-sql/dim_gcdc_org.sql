/*
public enum EnumOrgGroupSubKind {
	SALES_LPT(1, "lpt销售"), SALES_KA(2, "大客户销售"), SALES_SS(10, "高级lpt销售"),
	GCDC_PM(3, "执行项目经理"), GCDC_RC(4, "RPO项目执行"), GCDC_RPS(5, "RPS招聘服务中心"), GCDC_RPO(9, "猎头顾问"), GCDC_CDC(11, "CDC职业顾问"),
	TECHNOLOGY(6, "技术"), OTHER(8, "其他"); // 以前的新人组按照其他同步
*/

create table  if not exists dim_gcdc_org
(
	d_date int comment '统计日期',
	id int comment '部门ID',
	name string comment '部门名称',
	branch_id int comment '分公司ID',
	branch_name string comment '分公司名称',
	parent_id int  comment '部门父id',
	parent_name string  comment '部门父名称',
	upper_path string comment '父节点path',	
	creation_timestamp timestamp comment '时间戳'
) partitioned by (p_date int);
insert overwrite table dim_gcdc_org partition (p_date = $date$)
select  $date$ as d_date,
			org.id,
			org.name,
			nvl(nvl(tj.branch_id,org.branch_id),-1) as branch_id,
			nvl(nvl(tj.branch_name,branch.name),'未知') as branch_name,
			nvl(org.parent_id,-1) as parent_id,
			nvl(parent.name,'未知') as parent_name,
			nvl(org.upper_path,-1) as upper_path,
			from_unixtime(unix_timestamp())
from portal_org org
join 
(select member_org_id 
	from portal_org_group 
	where sub_kind in (3,4,5,9,11)
	and deleteflag = 0
	) gp
on org.id = gp.member_org_id
left join
(select id,name, '10421' as branch_id,
			'天津' as branch_name
   from portal_org
  where instr(upper_path,',10421,') > 0
  and deleteflag = 0
 )  tj  --10421	同道汇才（天津）信息技术有限公司
on org.id = tj.id
left join
(select id,name
from portal_org
where kind = 1
and deleteflag = 0)  branch
on org.branch_id = branch.id
left join
(select id,name
from portal_org
where deleteflag = 0)  parent
on org.parent_id = parent.id;



create table dim_gcdc_org
(
	d_date int comment '统计日期',
	id int comment '部门ID',
	name varchar(100) comment '部门名称',
	branch_id int comment '分公司ID',
	branch_name varchar(100) comment '分公司名称',
	parent_id int  comment '部门父id',
	parent_name varchar(100)  comment '部门父名称',
	upper_path varchar(100) comment '父节点path',
	creation_timestamp  timestamp default CURRENT_TIMESTAMP,
	primary key (d_date,id)
);