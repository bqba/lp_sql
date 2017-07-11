CREATE TABLE dw_erp_d_salesuser_to_sd(
  d_date int COMMENT ' 数据日期  ', 
  id string COMMENT ' 员工id  ', 
  name string COMMENT ' 员工姓名  ', 
  entrydate string COMMENT ' 入职日期  ', 
  lp_age string COMMENT ' 猎聘司龄-月数  ', 
  status int COMMENT ' 0-试用,1-正式,2-离职  ', 
  account_status int COMMENT ' 员工状态 0-启用,1-禁用 ', 
  position_id string COMMENT ' 岗位ID  ', 
  position_name string COMMENT ' 岗位名称  ', 
  execute_position_name string COMMENT ' 调整后岗位名称  ',   
  position_channel string COMMENT ' 岗位通道  ', 
  position_channel_name string COMMENT ' 岗位通道名称  ', 
  position_level string COMMENT ' 岗位级别  ', 
  position_level_name string COMMENT ' 岗位级别名称  ', 
  org_id int COMMENT ' 所在组织  ', 
  org_name string COMMENT ' 所在组织名称  ', 
  branch_id int COMMENT ' 所在分公司  ', 
  branch_name string COMMENT ' 所在分公司名称  ', 
  parent_salesuser_id int COMMENT ' 汇报对象  ', 
  parent_salesuser_name string COMMENT ' 汇报对象名称  ', 
  parent_salesuser_id_list string COMMENT ' 汇报对象及所有上级列表  ', 
  grade int COMMENT ' 级别 ', 
  salesposition int COMMENT '销售岗位级别', 
  salesposition_name string COMMENT '销售岗位级别名称', 
  is_sd int comment '是否总监', 
  sd_id int COMMENT '汇报总监',
  sd_name string COMMENT '汇报总监名称',
  sr_sd_id int COMMENT '汇报高级总监',
  sr_sd_name string COMMENT '汇报高级总监名称',  
  creation_timestamp timestamp COMMENT ' 时间戳  '
  ) comment '销售顾问与销售总监映射表'
PARTITIONED BY ( p_date int);

insert overwrite table dw_erp_d_salesuser_to_sd partition (p_date = $date$)
select base.d_date,
	base.id,
	base.name,
	base.entrydate,
	months_between(concat(substr('$date$',1,4),'-',substr('$date$',5,2),'-',substr('$date$',7,2)),base.entrydate) as lp_age,
	base.status,
	base.account_status,
	base.position_id,
	base.position_name,
	nvl(self_sd.execute_position_name,base.position_name) as execute_position_name,
	base.position_channel,
	base.position_channel_name,
	base.position_level,
	base.position_level_name,
	base.org_id,
	base.org_name,
	dim_org.branch_id,
	dim_org.branch_name,
	base.parent_salesuser_id,
	base.parent_salesuser_name,
	base.parent_salesuser_id_list,
	base.grade,
	base.salesposition,
	base.salesposition_name,
	case when base.id = self_sd.id then 1 else 0 end as is_sd,
	case when base.id = self_sd.id and self_sd.execute_position_name = '销售总监' then base.id else nvl(parent_sd.sd_id,'-1') end as sd_id,
	case when base.id = self_sd.id and self_sd.execute_position_name = '销售总监' then base.name else nvl(parent_sd.sd_name,'未知') end as sd_name,	
	case when base.id = self_sd.id and self_sd.execute_position_name = '高级总监' then base.id else nvl(parent_sd.sr_sd_id,'-1') end as sr_sd_id,
	case when base.id = self_sd.id and self_sd.execute_position_name = '高级总监' then base.name else nvl(parent_sd.sr_sd_name,'未知') end as sr_sd_name,
	current_timestamp,
	case when base.position_channel in ('A0000821','A0000484') then 'S' --JS,LPT销售
		 when base.position_channel in ('A0000486','A0000489') then 'KA' -- KA销售,KA管理
		 when base.position_channel in ('A0000485') then 'SS' -- 高级销售
		 else 
		(case when instr(base.org_name,'SS') > 0 then 'SS'
			  when instr(base.org_name,'S') > 0 then 'S'
			  when instr(base.org_name,'KA') > 0 then 'KA'
		 else '其他' end)
	end as sales_level
	from dw_erp_d_salesuser_base base
	join dim_org 
	on base.org_id = dim_org.d_org_id 
	left join 
	(
		select base.id,base.name,base.position_name,cf.execute_positiontype as exe_type,pl.enum_name as execute_position_name
		from dw_erp_d_salesuser_base base 
		join portal_export_conf cf 
		on base.id = cf.employee_id
		and cf.deleteflag = 0
		join pub_enum_list pl 
		on pl.src_table = 'portal_export_conf'
		and pl.enum_type = 'execute_positiontype'
		and pl.enum_code = cf.execute_positiontype
		and pl.is_default = 1
		where base.p_date = $date$
		and nvl(pl.enum_name,base.position_name) like '%总监%'
		and base.is_saleuser = 1
		and base.status in (0,1)
	) self_sd 
	on base.id = self_sd.id 
	left join 
	(  select id,sd_id,sd_name,sr_sd_id,sr_sd_name
		 from (
		select id,sd_id,sd_name,
				max(sr_sd_id) over(distribute by id ) as sr_sd_id,
				max(sr_sd_name) over(distribute by id ) as sr_sd_name,
			  	row_number()over(distribute by id sort by sd_id desc,sr_sd_id desc) as rn 
		  from (
				select suser.id ,
					   case when sd.execute_position_name = '销售总监' then sd.id else -1 end as sd_id,
					   case when sd.execute_position_name = '销售总监' then sd.name else '-1' end as sd_name,
					   case when sd.execute_position_name = '高级总监' then sd.id else -1 end as sr_sd_id,
					   case when sd.execute_position_name = '高级总监' then sd.name else '-1' end as sr_sd_name
				from 
				(
					select id,name,parent_id
				    from (
				    select id,name,parent_salesuser_id_list
				    from dw_erp_d_salesuser_base  
				    where is_saleuser = 1     
				    and p_date = $date$
				    ) su
				    lateral view explode(split(parent_salesuser_id_list,',')) i as parent_id
				) suser 
				join 
				(
						select base.id,base.name,base.position_name,cf.execute_positiontype as exe_type,pl.enum_name as execute_position_name
						from dw_erp_d_salesuser_base base 
						join portal_export_conf cf 
						on base.id = cf.employee_id
						and cf.deleteflag = 0
						join pub_enum_list pl 
						on pl.src_table = 'portal_export_conf'
						and pl.enum_type = 'execute_positiontype'
						and pl.enum_code = cf.execute_positiontype
						and pl.is_default = 1
						where base.p_date = $date$
						and nvl(pl.enum_name,base.position_name) like '%总监%'
						and base.is_saleuser = 1
						and base.status in (0,1)
				) sd 
				on suser.parent_id = sd.id 
		 ) par		
		) par2  where rn = 1	
	) parent_sd 
    on base.id = parent_sd.id 
	where base.p_date = $date$
	and base.is_saleuser = 1



insert overwrite table dw_erp_d_salesuser_to_sd partition (p_date)
select d_date
, id
, name
, entrydate
, lp_age
, status
, account_status
, position_id
, position_name
, execute_position_name
, position_channel
, position_channel_name
, position_level
, position_level_name
, org_id
, org_name
, branch_id
, branch_name
, parent_salesuser_id
, parent_salesuser_name
, parent_salesuser_id_list
, grade
, salesposition
, salesposition_name
, is_sd
, sd_id
, sd_name
, sr_sd_id
, sr_sd_name
, creation_timestamp
,	case when position_channel in ('A0000821','A0000484') then 'S' --JS,LPT销售
		 when position_channel in ('A0000486','A0000489') then 'KA' -- KA销售,KA管理
		 when position_channel in ('A0000485') then 'SS' -- 高级销售
		 else 
		(case when instr(org_name,'SS') > 0 then 'SS'
			  when instr(org_name,'S') > 0 then 'S'
			  when instr(org_name,'KA') > 0 then 'KA'
		 else '其他' end)
	end as sales_level	
, p_date
from dw_erp_d_salesuser_to_sd
where p_date between {{start_date}} and {{end_date}}


insert overwrite table dw_erp_d_salesuser_to_sd partition(p_date)
select d_date, id, name, entrydate, lp_age, status, account_status, position_id, position_name, execute_position_name, position_channel, position_channel_name, position_level, position_level_name, org_id, org_name, branch_id, branch_name, parent_salesuser_id, parent_salesuser_name, parent_salesuser_id_list, grade, salesposition, salesposition_name, is_sd, 
	case when is_sd = 1 and name not in ('朱佳英','尚斌') then id else sd_id end as sd_id,
	case when is_sd = 1 and name not in ('朱佳英','尚斌') then name else sd_name end as sd_name,	
	case when is_sd = 1 and name in ('朱佳英','尚斌') then id else sr_sd_id end as sr_sd_id, 
	case when is_sd = 1 and name in ('朱佳英','尚斌') then name else sr_sd_name end sr_sd_name, 
creation_timestamp, p_date
from dw_erp_d_salesuser_to_sd
where p_date between {{start_date}} and {{end_date}} 