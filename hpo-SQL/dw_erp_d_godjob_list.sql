create table if not exists dw_erp_d_godjob_list
(
	d_date int,
	id  int,
	ejob_id int,
	ejob_title string,
	ecomp_id int,
	ecomp_root_id int,
	ecomp_name string,
	industry string,
	industry_name string,
	create_time timestamp,
	is_add int,
	sales_id int,
	sales_name string,
	position_id int,
	position_name string,
	position_level string,
	position_level_name string,
	org_id int,
	org_name string,
	sales_group_id int,
	sales_group_name string,
	ge_status string,
	creation_timestamp timestamp
) 
partitioned by (p_date int);

alter table dw_erp_d_godjob_list add columns (customer_id int comment '客户ID',customer_name string comment '客户名称') cascade;
alter table dw_erp_d_godjob_list add (customer_id int comment '客户ID',customer_name varchar(150) comment '客户名称');



insert overwrite table dw_erp_d_godjob_list partition (p_date = $date$)
select  
	$date$ as d_date,
	nvl(ge.id ,-1) as id ,
	nvl(ge.ejob_id ,-1) as ejob_id,
	nvl(ge.ge_ejob_title ,'-1') as ejob_title,
	nvl(ge.ecomp_id,-1) as ecomp_id,
	nvl(ge.ecomp_root_id,-1) as ecomp_root_id,
	nvl(ge.ge_ecomp_name,'未知' ) as ecomp_name,
	nvl(cus.industry ,-1) as industry,
	nvl(dim_industry.d_main_industry,'-1') as industry_name,
	nvl(reformat_date(ge.createtime),'1900-01-01 00:00:00' ) as create_time,
	nvl((case when cal_days(substr(ge.createtime,1,8),'$date$') between 0 and 6 then 1 else 0 end),0) as is_add,
	nvl(cus.sales_user_id,-1) as sales_id,
	nvl(salesuser.name,'未知') as sales_name,
    nvl(salesuser.position_id,-1) as position_id,
	nvl(salesuser.position_name,'未知') as position_name ,
	nvl(salesuser.position_level,'-1') as position_level,
	nvl(enum.enum_name,'未知') as position_level_name,
	nvl(salesuser.org_id,-1) as org_id ,
	nvl(salesuser.org_name,'未知') as org_name,
	nvl(salesuser.parent_salesuser_id,-1) as sales_group_id ,
    nvl(salesuser.parent_salesuser_name,'未知') as sales_group_name,
	nvl(ge.ge_status ,-1) as ge_status,
	from_unixtime(unix_timestamp()) as creation_timestamp,
	nvl(cus.id,-1) as customer_id,
	nvl(cus.name,'未知') as customer_name
from 
(select ge.id,ge.ejob_id,ge.ge_ejob_title,
		ge.usere_kind, 
		case when ge.usere_kind = 0 then ge.ecomp_id else cust.ecomp_id end as ecomp_id,
		ge.ecomp_root_id,
		ge.ge_ecomp_name,ge.ge_industry,ge.createtime,ge.ge_status
   from god_ejob ge
   left join dw_erp_d_salesuser_base_new cust 
    on ge.ecomp_id = cust.id 
    and ge.usere_kind = 1
  where ge.ge_status in (0,1) 
    and ge.ge_service_type = '0' 
)  ge
inner join 
	(--排除测试数据
	select god_ejob_id 
	from dw_b_a_god_ejob_id
	) ej 
on ge.id=ej.god_ejob_id 
inner join 
(select  id,ecomp_id,sales_user_id,industry,name
	from dw_erp_d_customer_base 
   where p_date = $date$) cus
on ge.ecomp_id = cus.ecomp_id   
inner join 
(select  id,name,position_id,position_name,position_channel,position_level,org_id,org_name,parent_salesuser_id,parent_salesuser_name
	from dw_erp_d_salesuser_base
   where p_date = $date$
      and is_saleuser =1
	  and status in (0,1)) salesuser
on salesuser.id = cus.sales_user_id
 left outer join 
(select enum_code,enum_name
    from pub_enum_list
  where enum_type = 'position_level'
     and is_default = 1) enum 
on salesuser.position_level = enum.enum_code
left outer join dim_industry 
on cus.industry = dim_industry.d_ind_code;



insert overwrite table dw_erp_d_godjob_list partition (p_date)
select ge.d_date,ge.id,ge.ejob_id,ge.ejob_title,ge.ecomp_id,ge.ecomp_root_id,ge.ecomp_name,ge.industry,ge.industry_name,ge.create_time,ge.is_add,ge.sales_id,ge.sales_name,ge.position_id,ge.position_name,ge.position_level,ge.position_level_name,ge.org_id,ge.org_name,ge.sales_group_id,ge.sales_group_name,ge.ge_status,ge.creation_timestamp,cus.id,cus.name,ge.p_date
from dw_erp_d_godjob_list ge
inner join 
(select  id,ecomp_id,name,p_date
	from dw_erp_d_customer_base 
	where p_date between 20170102 and 20170314) cus
on ge.ecomp_id = cus.ecomp_id  
and ge.p_date = cus.p_date
where ge.p_date between 20170102 and 20170314


select ge.d_date,ge.id,ge.ejob_id,ge.ejob_title,ge.ecomp_id,ge.ecomp_root_id,ge.ecomp_name,ge.industry,ge.industry_name,ge.create_time,ge.is_add,ge.sales_id,ge.sales_name,ge.position_id,ge.position_name,ge.position_level,ge.position_level_name,ge.org_id,ge.org_name,ge.sales_group_id,ge.sales_group_name,ge.ge_status,ge.creation_timestamp,cus.id,cus.name,ge.p_date
from dw_erp_d_godjob_list ge
inner join 
(select  id,ecomp_id,name,p_date
	from dw_erp_d_customer_base 
	where p_date between 20170102 and 20170314) cus
on ge.ecomp_id = cus.ecomp_id  
and ge.p_date = cus.p_date
where ge.p_date between 20170102 and 20170314