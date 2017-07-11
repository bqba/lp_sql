CREATE TABLE dw_erp_d_sales_target (
  sales_id int COMMENT ' 员工id  ', 
  sales_name string COMMENT ' 员工姓名  ', 
  target_year int comment '年份',
  year_amount int comment '年目标金额' ,
  first_quarter_amount int comment '目标金额',
  second_quarter_amount int comment '目标金额',
  third_quarter_amount int comment '目标金额',
  fourth_quarter_amount int comment '目标金额',
  jan_amount int comment '目标金额',
  feb_amount int comment '目标金额',
  mar_amount int comment '目标金额',
  apr_amount int comment '目标金额',
  may_amount int comment '目标金额',
  jun_amount int comment '目标金额',
  jul_amount int comment '目标金额',
  aug_amount int comment '目标金额',
  sep_amount int comment '目标金额',
  oct_amount int comment '目标金额',
  nov_amount int comment '目标金额',
  dec_amount int comment '目标金额',
  creation_timestamp timestamp COMMENT '时间戳 '
  ) comment '销售业绩目标表'
PARTITIONED BY ( p_date int);

insert overwrite table dw_erp_d_sales_target PARTITION(p_date = $date$)
  select
    role3.id,role3.name,
    role3.year,
	role3.year_amount,
	role3.first_quarter_amount,
	role3.second_quarter_amount,
	role3.third_quarter_amount,
	role3.fourth_quarter_amount,
	role3.jan_amount,
	role3.feb_amount,
	role3.mar_amount,
	role3.apr_amount,
	role3.may_amount,
	role3.jun_amount,
	role3.jul_amount,
	role3.aug_amount,
	role3.sep_amount,
	role3.oct_amount,
	role3.nov_amount,
	role3.dec_amount,
	current_timestamp
  from (
        select
            role2.id,role2.type,role2.name,
            row_number()over(distribute by role2.id ,cat.year sort by cat.id ) as rn,
            cat.year,
        	cat.year_amount,
			cat.first_quarter_amount,
			cat.second_quarter_amount,
			cat.third_quarter_amount,
			cat.fourth_quarter_amount,
			cat.jan_amount,
			cat.feb_amount,
			cat.mar_amount,
			cat.apr_amount,
			cat.may_amount,
			cat.jun_amount,
			cat.jul_amount,
			cat.aug_amount,
			cat.sep_amount,
			cat.oct_amount,
			cat.nov_amount,
			cat.dec_amount
        from
        (
          select
              role1.id,
              role1.name,
              case when role1.min_level = 5 then 1 else 0 end as type,
              case when role1.min_level  = 5 then id
              when role1.min_level  = 2 and role1.level <> 5 then org_id
              when role1.min_level  = 1 then 1
              end as object_id
          from (
              select pe.id,pe.name,pe.org_id as ownorg,per.org_id,prp.level,
                      min(prp.level) over(distribute by pe.id) as min_level
              from portal_permission pp
              join portal_role_permission prp
              on pp.id = prp.permission_id
              and prp.deleteflag = 0
              join portal_employee_role per
              on per.role_id = prp.role_id
              and per.deleteflag = 0
              join portal_employee pe
              on pe.id = per.employee_id
              and pe.deleteflag = 0
              left join (select parent_salesuser_id
              from dw_erp_d_salesuser_base
              where p_date = $date$
              group by parent_salesuser_id) child
              on pe.id = child.parent_salesuser_id
              where pp.code='CRM_SALE_TARGET_LIST'
              and prp.level in (1,2,5)
              and !(child.parent_salesuser_id is null and pe.status = 2)
          ) role1
          union all
          select id,name,0 as type,1 as object_id
          from dw_erp_d_salesuser_base
          where p_date = $date$
          and position_channel in ('A0000567','A0000528')
          and status <> 2
          and account_status = 0
        ) role2
      join (
        select id,object_id,type,year,
        		year_amount,
				first_quarter_amount,
				second_quarter_amount,
				third_quarter_amount,
				fourth_quarter_amount,
				jan_amount,
				feb_amount,
				mar_amount,
				apr_amount,
				may_amount,
				jun_amount,
				jul_amount,
				aug_amount,
				sep_amount,
				oct_amount,
				nov_amount,
				dec_amount
        from (
	        select id,object_id,type,year,
			        double(nvl(get_json_object(target_amount_detail,'$.year_amount'),0))*10000 as year_amount,
					double(nvl(get_json_object(target_amount_detail,'$.first_quarter_amount'),0))*10000 as first_quarter_amount,
					double(nvl(get_json_object(target_amount_detail,'$.second_quarter_amount'),0))*10000 as second_quarter_amount,
					double(nvl(get_json_object(target_amount_detail,'$.third_quarter_amount'),0))*10000 as third_quarter_amount,
					double(nvl(get_json_object(target_amount_detail,'$.fourth_quarter_amount'),0))*10000 as fourth_quarter_amount,
					double(nvl(get_json_object(target_amount_detail,'$.jan_amount'),0))*10000 as jan_amount,
					double(nvl(get_json_object(target_amount_detail,'$.feb_amount'),0))*10000 as feb_amount,
					double(nvl(get_json_object(target_amount_detail,'$.mar_amount'),0))*10000 as mar_amount,
					double(nvl(get_json_object(target_amount_detail,'$.apr_amount'),0))*10000 as apr_amount,
					double(nvl(get_json_object(target_amount_detail,'$.may_amount'),0))*10000 as may_amount,
					double(nvl(get_json_object(target_amount_detail,'$.jun_amount'),0))*10000 as jun_amount,
					double(nvl(get_json_object(target_amount_detail,'$.jul_amount'),0))*10000 as jul_amount,
					double(nvl(get_json_object(target_amount_detail,'$.aug_amount'),0))*10000 as aug_amount,
					double(nvl(get_json_object(target_amount_detail,'$.sep_amount'),0))*10000 as sep_amount,
					double(nvl(get_json_object(target_amount_detail,'$.oct_amount'),0))*10000 as oct_amount,
					double(nvl(get_json_object(target_amount_detail,'$.nov_amount'),0))*10000 as nov_amount,
					double(nvl(get_json_object(target_amount_detail,'$.dec_amount'),0))*10000 as dec_amount,
	        		row_number()over(distribute by object_id,type,year sort by id desc) as rn
	        from crm_target_management
	        where deleteflag = 0
        )  ctm
        where ctm.rn = 1
      )  cat
      on role2.object_id = cat.object_id
      and role2.type = cat.type
    ) role3
  where rn =1