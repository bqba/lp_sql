【BI端注册的sql】
/** 1：根据员工id获取员工的汇报线等级*/
输出结果：
	List<Map<String,String>> 
SQL参数：
	${statistic_date}, ${employee_id}
SQL内容：
	SELECT
		id AS employee_id, -- 销售id
		entrydate AS entrydate, -- 入职日期
		formaldate AS formaldate, -- 转正日期
		grade AS grade, -- 级别
		position_id AS position_id, -- 岗位ID
		position_name AS position_name, -- 岗位名称
		position_channel AS position_channel, -- 岗位通道
		position_level AS position_level, -- 岗位级别
		org_id AS org_id, -- 所在组织
		org_name AS org_name, -- 所在组织名称
		repertory_industry AS repertory_industry, -- 深耕行业
		parent_salesuser_id AS parent_salesuser_id, -- 汇报对象
		parent_salesuser_name AS parent_salesuser_name -- 汇报对象名称
	FROM
		dw_erp_d_salesuser_base
	WHERE
		d_date = ${statistic_date}
		AND id = ${employee_id};	

/** 2：根据员工id获取该员工的所有下属id*/
输出结果：
	List<Map<String,String>> 
SQL参数：
	${statistic_date}, ${employee_id}, ${employee_grade} 
SQL内容：
	SELECT
		id AS employee_id
	FROM
		dim_employee_level
	WHERE
		d_date=${statistic_date}
	AND 
	(CASE
		WHEN ${employee_grade} = 1 THEN first_level
		WHEN ${employee_grade} = 2 THEN second_level 
		WHEN ${employee_grade} = 3 THEN third_level 
		WHEN ${employee_grade} = 4 THEN forth_level
		WHEN ${employee_grade} = 5 THEN fifth_level
		WHEN ${employee_grade} = 6 THEN sixth_level
		WHEN ${employee_grade} = 7 THEN seventh_level
		WHEN ${employee_grade} = 8 THEN eighth_level
		WHEN ${employee_grade} = 9 THEN ninth_level
		WHEN ${employee_grade} = 10 THEN tenth_level
		WHEN ${employee_grade} = 11 THEN eleventh_level
		WHEN ${employee_grade} = 12 THEN twelfth_level
		WHEN ${employee_grade} = 13 THEN thirteenth_level
		WHEN ${employee_grade} = 14 THEN fourteenth_level
		WHEN ${employee_grade} = 15 THEN fifteenth_level
		ELSE 1
		END) = ${employee_id}

/** 3：获取本月的合同成交金额、回款金额*/
输出结果：
	List<Map<String,String>>  
SQL参数： 
    ${employ_ids}、${statistic_date}
SQL内容：
    SELECT 
        floor(SUM(contract_new_amount_m)) AS clinch_amount, -- 合同成交金额 
        floor(SUM(all_income_m)) AS receivable_amount	 -- 回款金额 
    FROM 
        dw_erp_d_salesuser_act
    WHERE 
        d_date= ${statistic_date} 
        AND sales_id IN (${employ_ids}) 

/** 4：根据员工id获取当天客户行为统计信息
   *		提前开通未回款、合作客户数、断约客户数、将到期客户数、
   *		当前面试快发起客户数、当前面试快发起职位数、新增面试快发起客户数、新增面试快发起职位数
   */
输出结果：
	List<Map<String,String>>  
SQL参数： 
    ${employ_ids}、${statistic_date} 
SQL内容： 
	select 
		SUM(noincome_effect_cus_cnt) AS noincome_effect_cus_cnt, -- 提前开通未回款 
		SUM(cus_contract_cnt) AS cus_contract_cnt, -- 合作客户数 
		SUM(cus_break_cnt) AS cus_break_cnt, -- 断约客户数 
		SUM(cus_expire_cnt) AS cus_expire_cnt, -- 将到期客户数 
		SUM(service_cus_cnt) AS service_cus_cnt, -- 当前面试快发起客户数 
		SUM(service_ejob_cnt) AS service_ejob_cnt, -- 当前面试快发起职位数 
		SUM(add_cus_cnt) AS add_cus_cnt, -- 新增面试快发起客户数 
		SUM(add_ejob_cnt) AS add_ejob_cnt -- 新增面试快发起职位数 
	from 
		dw_erp_d_salesuser_act 
	WHERE 
		d_date=${statistic_date} 
		AND sales_id IN (${employ_ids}); 

/** 5：根据员工id分组获取销售行为统计信息 
   *      已签合同数、已签约金额、所有合同回款金额
   */
输出结果：
	List<Map<String,String>>  
SQL参数： 
    ${employee_id}、${statistic_date} 、${current_level_column_name }、${ next_level_column_name}
SQL内容：
		SELECT
			c.employee_id AS employee_id, -- 销售id
      d.name AS sales_name, -- 销售姓名
      d.position_channel AS position_channel, -- 销售岗位通道
    	d.org_name AS org_name, -- 组织名称
    	c.contract_new_cnt AS contract_new_cnt,-- 已签合同数 
    	c.contract_new_amount AS contract_new_amount, -- 已签约金额 
    	c.all_income AS all_income -- 所有合同回款金额 
    FROM
    	(
    SELECT 
      b.${next_level_column_name} AS employee_id,	 -- 销售id 
	    SUM(a.contract_new_cnt_m) AS contract_new_cnt, -- 已签合同数 
			SUM(round(a.contract_new_amount_m)) AS contract_new_amount, -- 已签约金额 
			SUM(round(a.all_income_m)) AS all_income -- 所有合同回款金额     
    FROM 
        dw_erp_d_salesuser_act a
        Left join dim_employee_level b on b.d_date =${statistic_date} and a.sales_id = b.id 
    WHERE 
        a.d_date = ${statistic_date} 
        AND b.${current_level_column_name} = ${employee_id} 
        AND b.${next_level_column_name} > 0
        GROUP BY b.${next_level_column_name} 
     ) c Left join dw_erp_d_salesuser_base d on c.employee_id = d.id AND d.d_date=${statistic_date}

/** 6：根据员工id分组获取当日人均电话时长、当日人均电话数量、当月新增客户数量、当月新增拜访数量 */
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { employee_id }、$ { statistic_date } 、${current_level_column_name }、${ next_level_column_name}
SQL内容： 
SELECT
		c.employee_id AS employee_id, -- 销售id
		d.name AS sales_name, -- 销售姓名
    d.position_channel AS position_channel, -- 销售岗位通道
  	d.org_name AS org_name, -- 组织名称
  	c.call_time_long AS call_time_long,	  -- 人均有效通话时长
  	c.call_rec_cnt AS call_rec_cnt, -- 人均有效通话次数
  	c.input_cus_cnt AS input_cus_cnt, -- 当月新增客户数量 
    c.visit_cus_cnt AS visit_cus_cnt	 -- 当月新增拜访数量 
FROM
(select 
    b.${ next_level_column_name } AS employee_id,	 -- 销售id 
    floor(SUM(a.call_time_long)/SUM(a.is_work_on)) AS call_time_long,	  -- 人均有效通话时长 
    floor(SUM(a.call_rec_cnt)/SUM(a.is_work_on)) AS call_rec_cnt,				-- 人均有效通话次数
    SUM(a.input_cus_cnt_m) AS input_cus_cnt, -- 当月新增客户数量 
    SUM(a.visit_cus_cnt_m) AS visit_cus_cnt	 -- 当月新增拜访数量 
from 
    dw_erp_d_salesuser_act a 
    Left join dim_employee_level b on b.d_date = ${statistic_date } and a.sales_id = b.id 
WHERE 
    a.d_date = ${ statistic_date } 
    AND b.${current_level_column_name } = ${ employee_id } 
    AND b.${ next_level_column_name} > 0
    AND a.is_sales_agent = 1
    GROUP BY b.${ next_level_column_name}
) c Left join dw_erp_d_salesuser_base d on c.employee_id = d.id AND d.d_date=${statistic_date }

/** 7：销售行为KPI明细表 */
输出结果：
	List<Map<String,String>>  
SQL参数： 
  ${employ_ids}、$ { statistic_startdate } 、$ { statistic_enddate }
SQL内容：
	SELECT 
		d_date AS d_date,	-- 统计日期
    sales_id AS employee_id, -- 销售id 
    sales_name AS sales_name, -- 销售姓名
  	org_name AS org_name, -- 组织名称
    position_level AS position_level, -- 销售级别
		call_rec_cnt AS call_rec_cnt, -- 有效电话数量
		call_time_long AS call_time_long, -- 有效电话时长
    input_cus_cnt AS input_cus_cnt, -- 当日新增客户数量 
    visit_cus_cnt AS visit_cus_cnt	 -- 当日新增拜访数量 
  FROM 
      dw_erp_d_salesuser_act
  WHERE 
      d_date BETWEEN ${statistic_startdate} AND ${statistic_enddate} 
    AND sales_id IN (${employ_ids})
    AND a.is_sales_agent = 1
    ORDER BY sales_id, d_date DESC;

-----------------------------销售明细sql-----------------------------------
/** 11：销售签约明细表 调整为分页*/
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_startdate }、$ { statistic_enddate }、${employ_ids}、${current_page}、${page_size}
SQL内容：
SELECT 
	d_date AS d_date,	-- 统计日期
	org_name AS org_name,	-- 销售组别
	sales_name AS sales_name,-- 销售姓名
	position_level_name AS position_level_name,-- 销售级别
	customer_name AS customer_name,-- 客户名称
	comp_industry_name AS comp_industry_name,-- 客户行业名称
	contract_type AS contract_type,-- 合同类型名称
	contract_money AS contract_money -- 合同金额
FROM 
	dw_erp_d_contract_act
WHERE 		
		d_date = ${statistic_enddate}
	AND
		sales_id IN (${employ_ids})
	AND
		contract_createtime BETWEEN ${statistic_startdate} AND ${statistic_enddate}
	limit ${current_page},${page_size}

/** 12：销售回款明细表*/
输出结果：
	List<Map<String,String>>  
SQL参数： 
    ${statistic_startdate}、${statistic_enddate}、${employ_ids}、${current_page}、${page_size}
SQL内容：
SELECT 
	d_date AS d_date,	-- 统计日期
	org_name AS org_name,	-- 销售组别
	sales_name AS sales_name,-- 销售姓名
	position_level_name AS position_level_name,-- 销售级别
	customer_name AS customer_name,-- 客户名称
	customer_industry_name AS customer_industry_name,-- 客户行业名称
	contract_type AS contract_type,-- 合同类型名称
	money AS all_income -- 合同回款金额
FROM 
	dw_erp_d_crmfinance_income
WHERE
		money > 0
	AND
		d_date = ${statistic_enddate}
	AND
		sales_id IN (${employ_ids})
	AND
		replace(pay_time,'-','') >= ${statistic_startdate}
	AND
	  replace(pay_time,'-','') <= ${statistic_enddate}
	limit ${current_page},${page_size}
-- SELECT 
-- 	d_date AS d_date,	-- 统计日期
-- 	org_name AS org_name,	-- 销售组别
-- 	sales_name AS sales_name,-- 销售姓名
-- 	position_level_name AS position_level_name,-- 销售级别
-- 	customer_name AS customer_name,-- 客户名称
-- 	comp_industry_name AS comp_industry_name,-- 客户行业名称
-- 	contract_type AS contract_type,-- 合同类型名称
-- 	all_income_m AS all_income -- 合同回款金额
-- FROM 
-- 	dw_erp_d_contract_act
-- WHERE
-- 		all_income_m > 0
-- 	AND
-- 		d_date = ${statistic_enddate}
-- 	AND
-- 		sales_id IN (${employ_ids})
-- 	limit ${current_page},${page_size}

/** 3：销售行为KPI明细表*/
(略)

/** 13：面试快发起职位情况明细 (拆开+分页) */
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}、${current_page}、${page_size}
SQL内容：
SELECT 
	d_date AS d_date,	-- 统计日期
	org_name AS org_name,	-- 销售组别
	sales_name AS sales_name,-- 销售姓名
	position_level_name AS position_level_name,-- 销售级别
	ecomp_name AS ecomp_name,-- 企业客户名称
	industry_name AS industry_name,-- 行业
	ejob_title AS ejob_title,-- 面试快发起职位
	create_time AS create_time -- 职位发布时间
FROM 
	dw_erp_d_godjob_list
WHERE
		d_date= ${statistic_date}
	AND
	  sales_id IN (${employ_ids})
	AND 
		ge_status=1
	ORDER BY create_time DESC
	limit ${current_page},${page_size}

/** 14：面试快发起职位情况明细 总记录数 */
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}
SQL内容：
SELECT 
	COUNT(1) AS total_count
FROM 
	dw_erp_d_godjob_list
WHERE
		d_date= ${statistic_date}
	AND
	  sales_id IN (${employ_ids})
	AND 
		ge_status=1

/** 15：面试快新增职位情况明细 (拆开+分页) */		
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}、${current_page}、${page_size}
SQL内容：
SELECT 
	d_date AS d_date,	-- 统计日期
	org_name AS org_name,	-- 销售组别
	sales_name AS sales_name,-- 销售姓名
	position_level_name AS position_level_name,-- 销售级别
	ecomp_name AS ecomp_name,-- 企业客户名称
	industry_name AS industry_name,-- 行业
	ejob_title AS ejob_title, -- 面试快发起职位
	create_time AS create_time -- 职位发布时间
FROM 
	dw_erp_d_godjob_list
WHERE
  	d_date = ${statistic_date}
	AND
		is_add = 1
	AND
		sales_id IN (${employ_ids})
	ORDER BY create_time DESC
	limit ${current_page},${page_size}

/** 16：面试快新增职位情况明 总记录数 */		
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}
SQL内容：
SELECT 
	COUNT(1) AS total_count
FROM 
	dw_erp_d_godjob_list
WHERE
  	d_date = ${statistic_date}
	AND
		is_add = 1
	AND
		sales_id IN (${employ_ids})

/** 17：名下客户情况明细【合作中】分页 */
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}、${current_page}、${page_size}
SQL内容：
SELECT 
	b.org_name AS org_name,	-- 销售组别
	b.sales_name AS sales_name,-- 销售姓名
	b.position_level_name AS position_level_name,-- 销售级别
	b.customer_name AS customer_name,-- 客户名称
	b.comp_industry_name AS comp_industry_name, -- 行业
	b.is_lpt_expire AS is_lpt_expire,-- 是否到期
	a.service_expired_date  AS service_expired_date,  -- 到期日期
	a.contract_no AS contract_no, -- 合同号
	a.contract_money AS contract_money -- 签约金额
FROM 
	dw_erp_d_contract_act a,
	dw_erp_d_customer_status b
WHERE
		a.d_date = b.d_date
	AND
		a.customer_id = b.customer_id
	AND
		a.d_date = ${statistic_date}
	AND
		b.sales_id IN (${employ_ids})
	AND
		b.is_lpt_in_service = 1
	AND
		replace(a.service_expired_date,'-','') >= ${statistic_date}
	ORDER BY 
		a.is_lpt_expire DESC,
		a.service_expired_date
	limit ${current_page},${page_size};

/** 18：名下客户情况明细【合作中】总记录数 */
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}
SQL内容：
SELECT 
	COUNT(1) AS total_count
FROM 
	dw_erp_d_contract_act a,
	dw_erp_d_customer_status b
WHERE
		a.d_date = b.d_date
	AND
		a.customer_id = b.customer_id
	AND
		a.d_date = ${statistic_date}
	AND
		b.sales_id IN (${employ_ids})
	AND
		b.is_lpt_in_service = 1
	AND
		replace(a.service_expired_date,'-','') >= ${statistic_date}

/** 19：名下客户情况明细【到期】分页 */
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}、${current_page}、${page_size};
SQL内容：
SELECT 
	b.org_name AS org_name,	-- 销售组别
	b.sales_name AS sales_name,-- 销售姓名
	b.position_level_name AS position_level_name,-- 销售级别
	b.customer_name AS customer_name,-- 客户名称
	b.comp_industry_name AS comp_industry_name, -- 行业
	a.service_expired_date  AS service_expired_date,  -- 到期日期
	a.contract_no AS contract_no, -- 合同号
	a.contract_money AS contract_money -- 签约金额
FROM 
	dw_erp_d_contract_act a,
	dw_erp_d_customer_status b
WHERE
		a.d_date = b.d_date
	AND
		a.customer_id = b.customer_id
	AND
		a.d_date = ${statistic_date}
	AND
		b.sales_id IN (${employ_ids})
	AND
		b.is_lpt_expire = 1
	AND
		replace(a.service_expired_date,'-','') >= ${statistic_date}
	ORDER BY 
		a.service_expired_date
	limit ${current_page},${page_size};

/** 20：名下客户情况明细【到期】总记录数 */
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}
SQL内容：
SELECT 
	COUNT(1) AS total_count
FROM 
	dw_erp_d_contract_act a,
	dw_erp_d_customer_status b
WHERE
		a.d_date = b.d_date
	AND
		a.customer_id = b.customer_id
	AND
		a.d_date = ${statistic_date}
	AND
		b.sales_id IN (${employ_ids})
	AND
		b.is_lpt_expire = 1
	AND
		replace(a.service_expired_date,'-','') >= ${statistic_date}

/** 21：名下客户情况明细【已断约】分页 */
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}、${current_page}、${page_size}
SQL内容：
SELECT 
	b.org_name AS org_name,	-- 销售组别
	b.sales_name AS sales_name,-- 销售姓名
	b.position_level_name AS position_level_name,-- 销售级别
	b.customer_name AS customer_name,-- 客户名称
	b.comp_industry_name AS comp_industry_name, -- 行业
	a.service_expired_date  AS service_expired_date,  -- 到期日期
	a.contract_no AS contract_no, -- 合同号
	a.contract_money AS contract_money -- 签约金额
FROM 
	dw_erp_d_contract_act a,
	dw_erp_d_customer_status b
WHERE
		a.d_date = b.d_date
	AND
		a.customer_id = b.customer_id
	AND
		a.d_date = ${statistic_date}
	AND
		b.sales_id IN (${employ_ids} )
	AND
		b.is_lpt_break = 1
	ORDER BY 
		a.service_expired_date
	limit ${current_page},${page_size};

/** 22：名下客户情况明细【已断约】总记录数 */
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}
SQL内容：
SELECT 
	COUNT(1) AS total_count
FROM 
	dw_erp_d_contract_act a,
	dw_erp_d_customer_status b
WHERE
		a.d_date = b.d_date
	AND
		a.customer_id = b.customer_id
	AND
		a.d_date = ${statistic_date}
	AND
		b.sales_id IN (${employ_ids} )
	AND
		b.is_lpt_break = 1

/** 23：客户提前开通预警明细 分页*/
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}、${current_page}、${page_size}
SQL内容：
SELECT 
	org_name AS org_name,	-- 销售组别
	sales_name AS sales_name,-- 销售姓名
	position_level_name AS position_level_name,-- 销售级别
	customer_name AS customer_name,-- 企业客户名称
	comp_industry_name AS comp_industry_name, -- 行业
	contract_type AS contract_type,-- 合同类型名称
	contract_no AS contract_no, -- 合同号
	service_effect_date AS service_effect_date -- 开通日期
FROM 
	dw_erp_d_contract_act 
WHERE
		d_date = ${statistic_date}
	AND
		sales_id IN (${employ_ids} )
	AND
		is_noincome_effect = 1
	limit ${current_page},${page_size};

/** 24：客户提前开通预警明细 总记录数*/
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}
SQL内容：
SELECT 
	COUNT(1) AS total_count
FROM 
	dw_erp_d_contract_act 
WHERE
		d_date = ${statistic_date}
	AND
		sales_id IN (${employ_ids})
	AND
		is_noincome_effect = 1	

/** 25：分岗位渠道获取平均数*/
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }
SQL内容：
SELECT 
	position_channel AS position_channel,  -- 销售岗位通道
	floor(avg_call_rec_cnt) AS avg_call_rec_cnt, -- 通话记录条数平均数
	floor(avg_call_time_long) AS avg_call_time_long, -- 有效通话时长平均数
	floor(avg_input_cus_cnt) AS avg_input_cus_cnt,  -- 新增输入客户数平均数
	floor(avg_visit_cus_cnt) AS avg_visit_cus_cnt -- 拜访客户数平均数
FROM 
	dw_erp_d_country_useravg
WHERE
	d_date = ${statistic_date}
ORDER BY position_channel;

/** 26：分岗位渠道获取中位数*/
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }
SQL内容：
SELECT 
	position_channel AS position_channel,  -- 销售岗位通道
	floor(med_call_rec_cnt) AS med_call_rec_cnt, -- 通话记录条数中位数
	floor(med_call_time_long) AS med_call_time_long, -- 有效通话时长中位数
	floor(med_input_cus_cnt) AS med_input_cus_cnt,  -- 新增输入客户数中位数
	floor(med_visit_cus_cnt) AS med_visit_cus_cnt -- 拜访客户数中位数
FROM 
	dw_erp_d_country_usermedian
WHERE
	d_date = ${statistic_date}
ORDER BY position_channel;

/** 临时替换方案 26：分岗位渠道获取中位数  */
select 
${statistic_date} as d_date,
ifnull(d_act.position_channel,m_act.position_channel) position_channel,
ifnull(d_act.med_call_rec_cnt,0) as  med_call_rec_cnt,
ifnull(round(d_act.med_call_time_long,2),0) as med_call_time_long,
ifnull(m_act.med_visit_cus_cnt,0) as med_visit_cus_cnt,
ifnull(m_act.med_input_cus_cnt,0) as med_input_cus_cnt
from 
(select position_channel,
			floor(avg(call_rec_cnt)) as med_call_rec_cnt,
			floor(avg(call_time_long)) as med_call_time_long
from  dw_erp_d_salesuser_act
where d_date = ${statistic_date}
and is_sales_agent = 1
group by position_channel) d_act
full join 
(
	select position_channel,
			avg(visit_cus_cnt)  as med_visit_cus_cnt,
			avg(input_cus_cnt) as med_input_cus_cnt
	from (select    sales_id,position_channel,
							sum(visit_cus_cnt) as visit_cus_cnt,
							sum(input_cus_cnt) as input_cus_cnt
				from  dw_erp_d_salesuser_act
				where floor(d_date/100) = floor(${statistic_date}/100)
				and is_sales_agent = 1
				group by sales_id,position_channel
			)  dw_erp_d_salesuser_act
	group by position_channel
) m_act
on d_act.position_channel= m_act.position_channel;

/** 27：销售签约明细总记录数*/
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_startdate }、$ { statistic_enddate }、${employ_ids}
SQL内容：
SELECT 
	COUNT(1) AS total_count
FROM 
	dw_erp_d_contract_act
WHERE
		d_date BETWEEN ${statistic_startdate} AND ${statistic_enddate}
	AND
		sales_id in (${employ_ids})
	AND
		is_contract_new = 1

/** 28：销售回款明细总记录数*/
输出结果：
	List<Map<String,String>>  
SQL参数： 
    ${statistic_startdate}、${statistic_enddate}、${employ_ids}
SQL内容：
SELECT 
	COUNT(1) AS total_count
FROM 
	dw_erp_d_crmfinance_income
WHERE
		money > 0
	AND
		d_date = ${statistic_enddate}
	AND
		sales_id IN (${employ_ids})
	AND
		replace(pay_time,'-','') >= ${statistic_startdate}
	AND
	  replace(pay_time,'-','') <= ${statistic_enddate}
-- SELECT 
-- 	COUNT(1) AS total_count
-- FROM 
-- 	dw_erp_d_contract_act
-- WHERE
-- 		all_income > 0
-- 	AND
-- 		d_date BETWEEN ${statistic_startdate} AND ${statistic_enddate}
-- 	AND
-- 		sales_id IN (${employ_ids})

/** 29：面试快发起客户情况明细 (拆开+分页) */
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}、${current_page}、${page_size}
SQL内容：
SELECT 
	d_date AS d_date,	-- 统计日期
	org_name AS org_name,	-- 销售组别
	sales_name AS sales_name,-- 销售姓名
	position_level_name AS position_level_name,-- 销售级别
	ecomp_name AS ecomp_name,-- 企业客户名称
	industry_name AS industry_name-- 行业
FROM 
	dw_erp_d_godjob_list
WHERE
		d_date= ${statistic_date}
	AND
	  sales_id IN (${employ_ids})
	AND 
		ge_status=1
	GROUP BY sales_id, ecomp_id
	limit ${current_page},${page_size}

/** 30：面试快发起客户情况明细 总记录数 */
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}
SQL内容：
SELECT 
	COUNT(1) AS total_count
FROM 
	(
		SELECT 
			sales_id AS sales_id,	-- 销售id
			ecomp_id AS ecomp_id	-- 企业客户id
		FROM 
			dw_erp_d_godjob_list
		WHERE
				d_date= ${statistic_date}
			AND
			  sales_id IN (${employ_ids})
			AND 
				ge_status=1
			GROUP BY sales_id, ecomp_id
		) a;

/** 31：面试快新增客户情况明细 (拆开+分页) */		
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}、${current_page}、${page_size}
SQL内容：
SELECT 
	d_date AS d_date,	-- 统计日期
	org_name AS org_name,	-- 销售组别
	sales_name AS sales_name, -- 销售姓名
	position_level_name AS position_level_name, -- 销售级别
	ecomp_name AS ecomp_name, -- 企业客户名称
	industry_name AS industry_name -- 行业
FROM 
	dw_erp_d_godjob_list
WHERE
  	d_date = ${statistic_date}
	AND
		is_add = 1
	AND
		sales_id IN (${employ_ids})
	GROUP BY sales_id, ecomp_id
	limit ${current_page},${page_size}

/** 32：面试快新增客户情况明 总记录数 */		
输出结果：
	List<Map<String,String>>  
SQL参数： 
    $ { statistic_date }、${employ_ids}
SQL内容：
SELECT 
	COUNT(1) AS total_count
FROM 
(
	SELECT 
		sales_id AS sales_id,	-- 销售id
		ecomp_id AS ecomp_id	-- 企业客户id
	FROM
		dw_erp_d_godjob_list
	WHERE
  	d_date = ${statistic_date}
	AND
		is_add = 1
	AND
		sales_id IN (${employ_ids})
	GROUP BY sales_id, ecomp_id
) a;