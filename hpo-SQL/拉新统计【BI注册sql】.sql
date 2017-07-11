【拉新统计BI注册sql】
/** 101：按顾问统计*/
输出结果：
  List<Map<String,String>>  
SQL参数： 
  ${statistic_startdate}、${statistic_enddate}、${employee_id}
SQL内容：
  SELECT
    gcdc_name AS gcdc_name,      -- GCDC顾问名称
    SUM(valid_call_rec_cnt) AS valid_call_rec_cnt,  -- 有效沟通数                         
    SUM(valid_call_c_cn) AS valid_call_c_cn,  -- 有效覆盖数                              
    SUM(call_c_cnt) AS call_c_cnt,  -- 已覆盖人数
    SUM(call_rec_cnt) AS call_rec_cnt,  -- 已沟通次数
    SUM(finish_res_c_cnt) AS finish_res_c_cnt,  -- 在线完成数
    SUM(finish_level6_res_cnt) AS finish_level6_res_cnt,  -- 6级简历的数量
    SUM(finish_level5_res_cnt) AS finish_level5_res_cnt,  -- 5级简历的数量
    SUM(finish_level4_res_cnt) AS finish_level4_res_cnt,  -- 4级简历的数量
    SUM(finish_level3_res_cnt) AS finish_level3_res_cnt,  -- 3级简历的数量
    SUM(finish_level2_res_cnt) AS finish_level2_res_cnt,  -- 2级简历的数量
    SUM(finish_level1_res_cnt) AS finish_level1_res_cnt,  -- 1级简历的数量
    SUM(invite_c_cnt) AS invite_c_cnt,  -- 发送邀请数
    SUM(finish_invite_c_cnt) AS finish_invite_c_cnt,  -- 邀请完成数
    SUM(finish_res_cnt) AS finish_res_cnt,  -- 简历完成总数
    SUM(finish_biz_res_cnt) AS finish_biz_res_cnt,  -- 商业简历完善数
    SUM(finish_task_c_cnt) AS finish_task_c_cnt,  -- 当天领取任务的覆盖数
    SUM(call_plan_c_cnt) AS call_plan_c_cnt,  -- 今日待沟通总数
    SUM(finish_task_c_cnt)/SUM(call_plan_c_cnt) AS coverage_ratio,  -- 覆盖率 = 当天领取任务的覆盖数/今日待沟通总数
    SUM(finish_res_cnt)/SUM(finish_task_c_cnt) AS resume_finish_ratio, -- 简历完成率 = 简历完成总数/当天领取任务的覆盖数
    SUM(finish_res_cnt)/SUM(call_c_cnt) AS resume_effic_ratio, -- 简历效率 = 简历完成总数/已覆盖人数
    SUM(finish_biz_res_cnt)/SUM(finish_res_cnt) AS bizresume_finish_ratio, -- 商业简历完善率 = 商业简历完善数/简历完成总数
    SUM(finish_biz_res_cnt)/SUM(call_c_cnt) AS busresume_effic_ratio, -- 商业简历效率 = 商业简历完善数/已覆盖人数
    SUM(finish_res_c_cnt)/SUM(valid_call_c_cn) AS onLine_complate_ratio,  -- 在线完成率 = 在线完成数/有效覆盖数
    SUM(finish_invite_c_cnt)/SUM(valid_call_c_cn) AS invite_ratio -- 邀请完成率 = 邀请完成数/有效覆盖数
  FROM
    dw_erp_d_gcdc_newpull
  WHERE
    d_date >= ${statistic_startdate}
  AND
    d_date <= ${statistic_enddate}
  AND
    (case when ${employee_id} = 0 then 0 ELSE gcdc_id END) = ${employee_id}
  GROUP BY gcdc_id;

/** 102：按组统计*/
输出结果：
  List<Map<String,String>>  
SQL参数： 
  ${statistic_startdate}、${statistic_enddate}、${org_id}
SQL内容：
  SELECT
    org_name AS org_name,      -- 团队名称
    SUM(valid_call_rec_cnt) AS valid_call_rec_cnt,  -- 有效沟通数                         
    SUM(valid_call_c_cn) AS valid_call_c_cn,  -- 有效覆盖数                              
    SUM(call_c_cnt) AS call_c_cnt,  -- 已覆盖人数
    SUM(call_rec_cnt) AS call_rec_cnt,  -- 已沟通次数
    SUM(finish_res_c_cnt) AS finish_res_c_cnt,  -- 在线完成数
    SUM(finish_level6_res_cnt) AS finish_level6_res_cnt,  -- 6级简历的数量
    SUM(finish_level5_res_cnt) AS finish_level5_res_cnt,  -- 5级简历的数量
    SUM(finish_level4_res_cnt) AS finish_level4_res_cnt,  -- 4级简历的数量
    SUM(finish_level3_res_cnt) AS finish_level3_res_cnt,  -- 3级简历的数量
    SUM(finish_level2_res_cnt) AS finish_level2_res_cnt,  -- 2级简历的数量
    SUM(finish_level1_res_cnt) AS finish_level1_res_cnt,  -- 1级简历的数量
    SUM(invite_c_cnt) AS invite_c_cnt,  -- 发送邀请数
    SUM(finish_invite_c_cnt) AS finish_invite_c_cnt,  -- 邀请完成数
    SUM(finish_res_cnt) AS finish_res_cnt,  -- 简历完成总数
    SUM(finish_biz_res_cnt) AS finish_biz_res_cnt,  -- 商业简历完善数
    SUM(finish_task_c_cnt) AS finish_task_c_cnt,  -- 当天领取任务的覆盖数
    SUM(call_plan_c_cnt) AS call_plan_c_cnt,  -- 今日待沟通总数
    SUM(finish_task_c_cnt)/SUM(call_plan_c_cnt) AS coverage_ratio,  -- 覆盖率 = 当天领取任务的覆盖数/今日待沟通总数
    SUM(finish_res_cnt)/SUM(finish_task_c_cnt) AS resume_finish_ratio, -- 简历完成率 = 简历完成总数/当天领取任务的覆盖数
    SUM(finish_res_cnt)/SUM(call_c_cnt) AS resume_effic_ratio, -- 简历效率 = 简历完成总数/已覆盖人数
    SUM(finish_biz_res_cnt)/SUM(finish_res_cnt) AS bizresume_finish_ratio, -- 商业简历完善率 = 商业简历完善数/简历完成总数
    SUM(finish_biz_res_cnt)/SUM(call_c_cnt) AS busresume_effic_ratio, -- 商业简历效率 = 商业简历完善数/已覆盖人数
    SUM(finish_res_c_cnt)/SUM(valid_call_c_cn) AS onLine_complate_ratio,  -- 在线完成率 = 在线完成数/有效覆盖数
    SUM(finish_invite_c_cnt)/SUM(valid_call_c_cn) AS invite_ratio -- 邀请完成率 = 邀请完成数/有效覆盖数
  FROM
    dw_erp_d_gcdc_newpull
  WHERE
    d_date >= ${statistic_startdate}
  AND
    d_date <= ${statistic_enddate}
  AND
    (case when ${org_id} = 0 then 0 ELSE org_id END) = ${org_id}
  GROUP BY org_id;

/** 103：按行业统计*/
输出结果：
  List<Map<String,String>>  
SQL参数： 
  ${statistic_startdate}、${statistic_enddate}、${industrys}
SQL内容：
  SELECT
    industry_name AS industry_name,      -- 行业名称
    SUM(valid_call_rec_cnt) AS valid_call_rec_cnt,  -- 有效沟通数                         
    SUM(valid_call_c_cn) AS valid_call_c_cn,  -- 有效覆盖数                              
    SUM(call_c_cnt) AS call_c_cnt,  -- 已覆盖人数
    SUM(call_rec_cnt) AS call_rec_cnt,  -- 已沟通次数
    SUM(finish_res_c_cnt) AS finish_res_c_cnt,  -- 在线完成数
    SUM(finish_level6_res_cnt) AS finish_level6_res_cnt,  -- 6级简历的数量
    SUM(finish_level5_res_cnt) AS finish_level5_res_cnt,  -- 5级简历的数量
    SUM(finish_level4_res_cnt) AS finish_level4_res_cnt,  -- 4级简历的数量
    SUM(finish_level3_res_cnt) AS finish_level3_res_cnt,  -- 3级简历的数量
    SUM(finish_level2_res_cnt) AS finish_level2_res_cnt,  -- 2级简历的数量
    SUM(finish_level1_res_cnt) AS finish_level1_res_cnt,  -- 1级简历的数量
    SUM(invite_c_cnt) AS invite_c_cnt,  -- 发送邀请数
    SUM(finish_invite_c_cnt) AS finish_invite_c_cnt,  -- 邀请完成数
    SUM(finish_res_cnt) AS finish_res_cnt,  -- 简历完成总数
    SUM(finish_biz_res_cnt) AS finish_biz_res_cnt,  -- 商业简历完善数
    SUM(finish_task_c_cnt) AS finish_task_c_cnt,  -- 当天领取任务的覆盖数
    SUM(call_plan_c_cnt) AS call_plan_c_cnt,  -- 今日待沟通总数
    SUM(finish_task_c_cnt)/SUM(call_plan_c_cnt) AS coverage_ratio,  -- 覆盖率 = 当天领取任务的覆盖数/今日待沟通总数
    SUM(finish_res_cnt)/SUM(finish_task_c_cnt) AS resume_finish_ratio, -- 简历完成率 = 简历完成总数/当天领取任务的覆盖数
    SUM(finish_res_cnt)/SUM(call_c_cnt) AS resume_effic_ratio, -- 简历效率 = 简历完成总数/已覆盖人数
    SUM(finish_biz_res_cnt)/SUM(finish_res_cnt) AS bizresume_finish_ratio, -- 商业简历完善率 = 商业简历完善数/简历完成总数
    SUM(finish_biz_res_cnt)/SUM(call_c_cnt) AS busresume_effic_ratio, -- 商业简历效率 = 商业简历完善数/已覆盖人数
    SUM(finish_res_c_cnt)/SUM(valid_call_c_cn) AS onLine_complate_ratio,  -- 在线完成率 = 在线完成数/有效覆盖数
    SUM(finish_invite_c_cnt)/SUM(valid_call_c_cn) AS invite_ratio -- 邀请完成率 = 邀请完成数/有效覆盖数
  FROM
    dw_erp_d_gcdc_newpull
  WHERE
    d_date >= ${statistic_startdate}
  AND
    d_date <= ${statistic_enddate}
  AND
    (case when ${industrys} = '' then '' ELSE industry END) in (${industrys})
  GROUP BY industry;

/** 104：按城市统计*/
输出结果：
  List<Map<String,String>>  
SQL参数： 
  ${statistic_startdate}、${statistic_enddate}、${dqs}
SQL内容：
  SELECT
    dq_name AS dq_name,  -- 城市名称
    SUM(valid_call_rec_cnt) AS valid_call_rec_cnt,  -- 有效沟通数                         
    SUM(valid_call_c_cn) AS valid_call_c_cn,  -- 有效覆盖数                              
    SUM(call_c_cnt) AS call_c_cnt,  -- 已覆盖人数
    SUM(call_rec_cnt) AS call_rec_cnt,  -- 已沟通次数
    SUM(finish_res_c_cnt) AS finish_res_c_cnt,  -- 在线完成数
    SUM(finish_level6_res_cnt) AS finish_level6_res_cnt,  -- 6级简历的数量
    SUM(finish_level5_res_cnt) AS finish_level5_res_cnt,  -- 5级简历的数量
    SUM(finish_level4_res_cnt) AS finish_level4_res_cnt,  -- 4级简历的数量
    SUM(finish_level3_res_cnt) AS finish_level3_res_cnt,  -- 3级简历的数量
    SUM(finish_level2_res_cnt) AS finish_level2_res_cnt,  -- 2级简历的数量
    SUM(finish_level1_res_cnt) AS finish_level1_res_cnt,  -- 1级简历的数量
    SUM(invite_c_cnt) AS invite_c_cnt,  -- 发送邀请数
    SUM(finish_invite_c_cnt) AS finish_invite_c_cnt,  -- 邀请完成数
    SUM(finish_res_cnt) AS finish_res_cnt,  -- 简历完成总数
    SUM(finish_biz_res_cnt) AS finish_biz_res_cnt,  -- 商业简历完善数
    SUM(finish_task_c_cnt) AS finish_task_c_cnt,  -- 当天领取任务的覆盖数
    SUM(call_plan_c_cnt) AS call_plan_c_cnt,  -- 今日待沟通总数
    SUM(finish_task_c_cnt)/SUM(call_plan_c_cnt) AS coverage_ratio,  -- 覆盖率 = 当天领取任务的覆盖数/今日待沟通总数
    SUM(finish_res_cnt)/SUM(finish_task_c_cnt) AS resume_finish_ratio, -- 简历完成率 = 简历完成总数/当天领取任务的覆盖数
    SUM(finish_res_cnt)/SUM(call_c_cnt) AS resume_effic_ratio, -- 简历效率 = 简历完成总数/已覆盖人数
    SUM(finish_biz_res_cnt)/SUM(finish_res_cnt) AS bizresume_finish_ratio, -- 商业简历完善率 = 商业简历完善数/简历完成总数
    SUM(finish_biz_res_cnt)/SUM(call_c_cnt) AS busresume_effic_ratio, -- 商业简历效率 = 商业简历完善数/已覆盖人数
    SUM(finish_res_c_cnt)/SUM(valid_call_c_cn) AS onLine_complate_ratio,  -- 在线完成率 = 在线完成数/有效覆盖数
    SUM(finish_invite_c_cnt)/SUM(valid_call_c_cn) AS invite_ratio -- 邀请完成率 = 邀请完成数/有效覆盖数
  FROM
    dw_erp_d_gcdc_newpull
  WHERE
    d_date >= ${statistic_startdate}
  AND
    d_date <= ${statistic_enddate}
  AND
    (case when ${dqs} = '' then '' ELSE dq END) in (${dqs})
  GROUP BY dq;

/** 105：按渠道统计*/
输出结果：
  List<Map<String,String>>  
SQL参数： 
  ${statistic_startdate}、${statistic_enddate}、${activity_types}
SQL内容：
  SELECT
    activity_type_name AS activity_type_name,  -- 活动类型名称
    SUM(valid_call_rec_cnt) AS valid_call_rec_cnt,  -- 有效沟通数                         
    SUM(valid_call_c_cn) AS valid_call_c_cn,  -- 有效覆盖数                              
    SUM(call_c_cnt) AS call_c_cnt,  -- 已覆盖人数
    SUM(call_rec_cnt) AS call_rec_cnt,  -- 已沟通次数
    SUM(finish_res_c_cnt) AS finish_res_c_cnt,  -- 在线完成数
    SUM(finish_level6_res_cnt) AS finish_level6_res_cnt,  -- 6级简历的数量
    SUM(finish_level5_res_cnt) AS finish_level5_res_cnt,  -- 5级简历的数量
    SUM(finish_level4_res_cnt) AS finish_level4_res_cnt,  -- 4级简历的数量
    SUM(finish_level3_res_cnt) AS finish_level3_res_cnt,  -- 3级简历的数量
    SUM(finish_level2_res_cnt) AS finish_level2_res_cnt,  -- 2级简历的数量
    SUM(finish_level1_res_cnt) AS finish_level1_res_cnt,  -- 1级简历的数量
    SUM(invite_c_cnt) AS invite_c_cnt,  -- 发送邀请数
    SUM(finish_invite_c_cnt) AS finish_invite_c_cnt,  -- 邀请完成数
    SUM(finish_res_cnt) AS finish_res_cnt,  -- 简历完成总数
    SUM(finish_biz_res_cnt) AS finish_biz_res_cnt,  -- 商业简历完善数
    SUM(finish_task_c_cnt) AS finish_task_c_cnt,  -- 当天领取任务的覆盖数
    SUM(call_plan_c_cnt) AS call_plan_c_cnt,  -- 今日待沟通总数
    SUM(finish_task_c_cnt)/SUM(call_plan_c_cnt) AS coverage_ratio,  -- 覆盖率 = 当天领取任务的覆盖数/今日待沟通总数
    SUM(finish_res_cnt)/SUM(finish_task_c_cnt) AS resume_finish_ratio, -- 简历完成率 = 简历完成总数/当天领取任务的覆盖数
    SUM(finish_res_cnt)/SUM(call_c_cnt) AS resume_effic_ratio, -- 简历效率 = 简历完成总数/已覆盖人数
    SUM(finish_biz_res_cnt)/SUM(finish_res_cnt) AS bizresume_finish_ratio, -- 商业简历完善率 = 商业简历完善数/简历完成总数
    SUM(finish_biz_res_cnt)/SUM(call_c_cnt) AS busresume_effic_ratio, -- 商业简历效率 = 商业简历完善数/已覆盖人数
    SUM(finish_res_c_cnt)/SUM(valid_call_c_cn) AS onLine_complate_ratio,  -- 在线完成率 = 在线完成数/有效覆盖数
    SUM(finish_invite_c_cnt)/SUM(valid_call_c_cn) AS invite_ratio -- 邀请完成率 = 邀请完成数/有效覆盖数
  FROM
    dw_erp_d_gcdc_newpull
  WHERE
    d_date >= ${statistic_startdate}
  AND
    d_date <= ${statistic_enddate}
  AND
    (case when ${activity_type} = '' then '' ELSE activity_type END) = ${activity_type}
  GROUP BY activity_type;
  