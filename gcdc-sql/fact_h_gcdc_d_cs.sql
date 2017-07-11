create table fact_h_gcdc_d_cs_act(
d_date int comment '统计日期',
cs_id int comment '客服ID',
cs_name varchar(100) comment '客服姓名',
cs_org_id int comment '客服团队ID',
cs_org_name varchar(100) comment '客服团队名称',
cs_flag int comment '客服类型:0-H,1-C',
cs_cnt int comment '接线人数',
call_in_rec_cnt int comment '呼入量',
answer_rec_cnt int comment '接听量',
call_in_time float comment '呼入时长',
call_out_rec_cnt int comment '呼出量',

audit_userh_cnt int comment '审核猎头账户总量',
audit_userh_pass_cnt int comment '审核猎头账户通过量',
audit_hjob_cnt int comment '审核猎头职位个数',
audit_hcomp_cnt int comment '诚猎通审核数',
audit_fbd_cnt int comment '猎头敏感词审核数',
audit_feedback_userh_cnt int comment '猎头意见反馈',

audit_fbd_userc_cnt int comment '经理人敏感词审核数',
audit_fbd_userc_pass_cnt int comment '审核经理人敏感词通过量',
audit_feedback_userc_cnt int comment '经理人反馈处理数',
audit_feedback_userc_pending_cnt int comment '经理人反馈待处理数量',
audit_feddback_userxy_cnt int comment '学生反馈处理数',
audit_complaint_userh_cnt int comment '猎头举报',
audit_complaint_userc_cnt int comment '经理人举报',
audit_complaint_userb_cnt int comment '企业举报',
audit_complaint_ignore_cnt int comment '举报忽略数',
audit_appjob_cnt int comment '审核APP职位数',
audit_appfeed_cnt int comment '审核APP feed数',
audit_appid_cnt int comment '审核身份验证数',
audit_complaint_obj_userc_cnt int comment '举报经理人总数',
audit_complaint_obj_userc_real_cnt int comment '举报经理人属实',
audit_complaint_obj_userc_unreal_cnt int comment '举报经理人不属实',
audit_complaint_obj_userc_ingore_cnt int comment '举报经理人忽略',
audit_fbd_res_cnt int comment '简历敏感词审核总量',
audit_fbd_res_pass_cnt int comment '简历敏感词审核通过量',
creation_timestamp  timestamp default CURRENT_TIMESTAMP comment '时间戳',
primary key (d_date,cs_id,cs_org_id,cs_flag)
)comment 'GCDC客服统计';

create table fact_h_gcdc_d_cs_act(
d_date int comment '统计日期',
cs_id int comment '客服ID',
cs_name string comment '客服姓名',
cs_org_id int comment '客服团队ID',
cs_org_name string comment '客服团队名称',
cs_flag int comment '客服类型:0-H,1-C',
cs_cnt int comment '接线人数',
call_in_rec_cnt int comment '呼入量',
answer_rec_cnt int comment '接听量',
call_in_time float comment '呼入时长',
call_out_rec_cnt int comment '呼出量',
audit_userh_cnt int comment '审核猎头账户总量',
audit_userh_pass_cnt int comment '审核猎头账户通过量',
audit_hjob_cnt int comment '审核猎头职位个数',
audit_hcomp_cnt int comment '诚猎通审核数',
audit_fbd_userh_cnt int comment '猎头敏感词审核数',
audit_feedback_userh_cnt int comment '猎头意见反馈',
audit_fbd_userc_cnt int comment '经理人敏感词审核数',
audit_fbd_userc_pass_cnt int comment '审核经理人敏感词通过量',
audit_feedback_userc_cnt int comment '经理人反馈处理数',
audit_feedback_userc_pending_cnt int comment '经理人反馈待处理数量',
audit_feddback_userxy_cnt int comment '学生反馈处理数',
audit_complaint_userh_cnt int comment '猎头举报',
audit_complaint_userc_cnt int comment '经理人举报',
audit_complaint_userb_cnt int comment '企业举报',
audit_complaint_ignore_cnt int comment '举报忽略数',
audit_appjob_cnt int comment '审核APP职位数',
audit_appfeed_cnt int comment '审核APP feed数',
audit_appid_cnt int comment '审核身份验证数',
audit_complaint_obj_userc_cnt int comment '举报经理人总数',
audit_complaint_obj_userc_real_cnt int comment '举报经理人属实',
audit_complaint_obj_userc_unreal_cnt int comment '举报经理人不属实',
audit_complaint_obj_userc_ingore_cnt int comment '举报经理人忽略',
audit_fbd_res_cnt int comment '简历敏感词审核总量',
audit_fbd_res_pass_cnt int comment '简历敏感词审核通过量',
creation_timestamp timestamp comment '时间戳'
) comment 'GCDC客服统计'
partitioned by (p_date int);

alter table fact_h_gcdc_d_cs_act change audit_fbd_cnt audit_fbd_userh_cnt int comment '猎头敏感词审核数';
alter table fact_h_gcdc_d_cs_act change audit_fbd_cnt audit_fbd_userh_cnt int comment '猎头敏感词审核数';

alter table fact_h_gcdc_d_cs_act add columns (audit_question_cnt int comment '问题审核数',audit_question_pass_cnt int comment '问题发布数',audit_question_unpass_cnt int comment '问题审核不通过数',
audit_comment_cnt int comment '评论审核数',audit_comment_pass_cnt int comment '评论发布数',,audit_comment_unpass_cnt int comment '评论审核不通过数',
audit_answer_cnt int comment '回答审核数',audit_answer_pass_cnt int comment '回答发布数',,audit_answer_unpass_cnt int comment '回答审核不通过数') cascade;

alter table fact_h_gcdc_d_cs_act add (audit_question_cnt int comment '问题审核数',audit_question_pass_cnt int comment '问题发布数',audit_question_unpass_cnt int comment '问题审核不通过数',
audit_comment_cnt int comment '评论审核数',audit_comment_pass_cnt int comment '评论发布数',,audit_comment_unpass_cnt int comment '评论审核不通过数',
audit_answer_cnt int comment '回答审核数',audit_answer_pass_cnt int comment '回答发布数',,audit_answer_unpass_cnt int comment '回答审核不通过数');

insert overwrite table fact_h_gcdc_d_cs_act partition (p_date=$date$)
select 	$date$ as d_date,
		fact.cs_id,
		csuser.name,
		csuser.org_id,
		csuser.org_name,
		nvl(case  csuser.org_id when 10542 then 0 when 10535 then 1 end,-1) as  cs_flag,
		case when fact.call_in_rec_cnt+fact.call_out_rec_cnt>0 then 1 else 0 end as cs_cnt,
		call_in_rec_cnt,
		answer_rec_cnt,
		call_in_time,
		call_out_rec_cnt,
		audit_userh_cnt,
		audit_userh_pass_cnt,
		audit_hjob_cnt,
		audit_hcomp_cnt,
		audit_fbd_userh_cnt,
		audit_feedback_userh_cnt,
		audit_fbd_userc_cnt,
		audit_fbd_userc_pass_cnt,
		audit_feedback_userc_cnt,
		audit_feedback_userc_pending_cnt,
		audit_feedback_userxy_cnt,
		audit_complaint_userh_cnt,
		audit_complaint_userc_cnt,
		audit_complaint_userb_cnt,
		audit_complaint_ignore_cnt,
		audit_appjob_cnt,
		audit_appfeed_cnt,
		audit_appid_cnt,
		audit_complaint_obj_userc_cnt,
		audit_complaint_obj_userc_real_cnt,
		audit_complaint_obj_userc_unreal_cnt,
		audit_complaint_obj_userc_ingore_cnt,
		audit_fbd_res_cnt,
		audit_fbd_res_pass_cnt,
		from_unixtime(unix_timestamp()) as creation_timestamp,
		audit_question_cnt,
		audit_question_pass_cnt,
		audit_question_unpass_cnt,
		audit_comment_cnt,
		audit_comment_pass_cnt,
		audit_comment_unpass_cnt,
		audit_answer_cnt,
		audit_answer_pass_cnt,
		audit_answer_unpass_cnt

	from(
		select 
		coalesce(callrecord.cs_id,userh.cs_id,hjob.cs_id,hcomp.cs_id,fbd.cs_id,res.cs_id,complaint.cs_id,feedback.cs_id,app.cs_id,article.cs_id) as cs_id,
		nvl(sum(call_in_rec_cnt),0) as call_in_rec_cnt,
		nvl(sum(answer_rec_cnt),0) as answer_rec_cnt,
		nvl(sum(call_in_time),0) as call_in_time,
		nvl(sum(call_out_rec_cnt),0) as call_out_rec_cnt,
		nvl(sum(audit_userh_cnt),0) as audit_userh_cnt,
		nvl(sum(audit_userh_pass_cnt),0) as audit_userh_pass_cnt,
		nvl(sum(audit_hjob_cnt),0) as audit_hjob_cnt,
		nvl(sum(audit_hcomp_cnt),0) as audit_hcomp_cnt,
		nvl(sum(audit_fbd_userh_cnt),0) as audit_fbd_userh_cnt,
		nvl(sum(audit_feedback_userh_cnt),0) as audit_feedback_userh_cnt,
		nvl(sum(audit_fbd_userc_cnt),0) as audit_fbd_userc_cnt,
		nvl(sum(audit_fbd_userc_pass_cnt),0) as audit_fbd_userc_pass_cnt,
		nvl(sum(audit_feedback_userc_cnt),0) as audit_feedback_userc_cnt,
		nvl(sum(audit_feedback_userc_pending_cnt),0) as audit_feedback_userc_pending_cnt,
		nvl(sum(audit_feedback_userxy_cnt),0) as audit_feedback_userxy_cnt,
		nvl(sum(audit_complaint_userh_cnt),0) as audit_complaint_userh_cnt,
		nvl(sum(audit_complaint_userc_cnt),0) as audit_complaint_userc_cnt,
		nvl(sum(audit_complaint_userb_cnt),0) as audit_complaint_userb_cnt,
		nvl(sum(audit_complaint_ignore_cnt),0) as audit_complaint_ignore_cnt,
		nvl(sum(audit_appjob_cnt),0) as audit_appjob_cnt,
		nvl(sum(audit_appfeed_cnt),0) as audit_appfeed_cnt,
		nvl(sum(audit_appid_cnt),0) as audit_appid_cnt,
		nvl(sum(audit_complaint_obj_userc_cnt),0) as audit_complaint_obj_userc_cnt,
		nvl(sum(audit_complaint_obj_userc_real_cnt),0) as audit_complaint_obj_userc_real_cnt,
		nvl(sum(audit_complaint_obj_userc_unreal_cnt),0) as audit_complaint_obj_userc_unreal_cnt,
		nvl(sum(audit_complaint_obj_userc_ingore_cnt),0) as audit_complaint_obj_userc_ingore_cnt,
		nvl(sum(audit_fbd_res_cnt),0) as audit_fbd_res_cnt,
		nvl(sum(audit_fbd_res_pass_cnt),0) as audit_fbd_res_pass_cnt,
		nvl(sum(article.audit_question_cnt),0) as audit_question_cnt,
		nvl(sum(article.audit_question_pass_cnt),0) as audit_question_pass_cnt,
		nvl(sum(article.audit_question_unpass_cnt),0) as audit_question_unpass_cnt,
		0 as audit_comment_cnt,
		0 as audit_comment_pass_cnt,
		0 as audit_comment_unpass_cnt,
		0 as audit_answer_cnt,
		0 as audit_answer_pass_cnt,
		0 as audit_answer_unpass_cnt
	from 
	(
		select creator_id as cs_id,
				sum(case when call_type = 1 and service_hotline_type = 1 then 1 else 0 end ) as call_in_rec_cnt,
				sum(case when call_type = 1 and service_hotline_type = 1 and answer_status  = 0 then 1 else 0 end ) as answer_rec_cnt,
				sum(case when call_type = 1 and service_hotline_type = 1 then time_long else 0 end )/60 as call_in_time,
				sum(case when call_type = 0 and answer_status  = 0 then 1 else 0 end ) as call_out_rec_cnt
		  from call_record 
		where  begin_time >='080000'
			and end_time <='200000'
			and call_date='$date$'
			and deleteflag = 0
		group by creator_id
	) callrecord
	full outer join 
	--猎头账号审核  user_h_track  audit_result:审核结果,0:不通过,1通过
	(
		select  audit_user_id as cs_id,
				count(distinct userh_id) as  audit_userh_cnt,
				count(distinct case when audit_result = 1 then userh_id else null end) as audit_userh_pass_cnt
		from audit_userh_log
		where substr(regexp_replace(createtime,'-',''),1,8)  = '$date$'
		group by  audit_user_id
	) userh
	on callrecord.cs_id = userh.cs_id
	full outer join 
	--猎头职位审核
		(select creator_id as cs_id,
				count(id) as audit_hjob_cnt
		from wm_hjob_track
		where substr(regexp_replace(trackdate,'-',''),1,8)  = '$date$'
		and deleteflag = 0
		group by  creator_id
	) hjob
	on callrecord.cs_id = hjob.cs_id
	full outer join
	--猎头公司审核 	审核状态status：2 审核不通过,3 审核通过
	(	select creator_id as cs_id,
				count(id) as audit_hcomp_cnt
		from hcomp_audit_log
		where substr(regexp_replace(createtime,'-',''),1,8)  = '$date$'
		and deleteflag = 0
		group by  creator_id
	) hcomp
	on callrecord.cs_id = hcomp.cs_id
	full outer join
	--敏感词 obj_userkind:0 经理人 1 企业 2 猎头 4 校园企业 status:0 未处理,1 属实,2 不属实
	(	select creator_id as cs_id,
			   count(case when obj_userkind = 2 then obj_userid else null end ) as audit_fbd_userh_cnt,
			   count(case when obj_userkind = 1 then obj_userid else null end ) as audit_fbd_userb_cnt,
			   count(case when obj_userkind = 0 then obj_userid else null end ) as audit_fbd_userc_cnt,
			   count(case when obj_userkind = 0 and status = 2 then obj_userid else null end ) as audit_fbd_userc_pass_cnt,
			   count(case when obj_userkind = 0 and status = 1 then obj_userid else null end ) as audit_fbd_userc_unpass_cnt
		from webmanager_forbiddeninfo_approve
		where substr(regexp_replace(checkedtime,'-',''),1,8)  = '$date$'
		and deleteflag = 0
		group by creator_id
	) fbd
	on callrecord.cs_id = fbd.cs_id
	full outer join
	--简历审核 操作类型: 0 审核通过 3 审核不通过 4 放入回收站 (1 审核通过置为中级 2 审核通过置为高级 )
	(	select creator_id as cs_id,
			   count(res_id) as audit_fbd_res_cnt,
			   count(case when operate_type in (0,1,2) then res_id else null end) as audit_fbd_res_pass_cnt,		   
			   count(case when operate_type = 3 then res_id else null end) as audit_fbd_res_unpass_cnt
		from webmanager_resume_track
		where substr(regexp_replace(createtime,'-',''),1,8)  = '$date$'
		and deleteflag = 0
		group by  creator_id 
	) res
	on callrecord.cs_id = res.cs_id
	full outer join 
	(	select  creator_id as cs_id,
				count(case when user_kind = 2 and wc_status <> 0 then obj_id else null end) as audit_complaint_userh_cnt,
				count(case when user_kind = 1 and wc_status <> 0 then obj_id else null end) as audit_complaint_userb_cnt,
				count(case when user_kind = 0 and wc_status <> 0 then obj_id else null end) as audit_complaint_userc_cnt,
				count(case when wc_status = 5 then obj_id else null end) as audit_complaint_ignore_cnt,
				count(case when user_kind in (1,2) and obj_userkind = 0 and wc_status <> 0 then obj_id else null end) as audit_complaint_obj_userc_cnt,
				count(case when user_kind in (1,2) and obj_userkind = 0 and wc_status in (1,3) then obj_id else null end) as audit_complaint_obj_userc_real_cnt,
				count(case when user_kind in (1,2) and obj_userkind = 0 and wc_status in (2,4) then obj_id else null end) as audit_complaint_obj_userc_unreal_cnt,
				count(case when user_kind in (1,2) and obj_userkind = 0 and wc_status =5 then obj_id else null end) as audit_complaint_obj_userc_ingore_cnt
		from wm_web_complaint
		where substr(regexp_replace(wc_checkedtime,'-',''),1,8)  = '$date$'
		and deleteflag = 0
		group by creator_id
	) complaint
	on callrecord.cs_id = complaint.cs_id
	full outer join 
	--用户反馈 user_kind  0 经理人 1 企业 2 猎头 9 学生 10 未知  status:  0 未解决 1 已解决 2 无用信息 3 处理中
	(	select fdtrack.creator_id as cs_id,
			   count(case when fd.user_kind = 2 and fd.status = 1 then fdtrack.id else null end) as audit_feedback_userh_cnt,
			   count(case when fd.user_kind = 0 and fd.status = 1 then fdtrack.id else null end) as audit_feedback_userc_cnt,
			   count(case when fd.user_kind = 0 and fd.status = 3 then fdtrack.id else null end) as audit_feedback_userc_pending_cnt,	   
			   count(case when fd.user_kind = 9 and fd.status = 1 then fdtrack.id else null end) as audit_feedback_userxy_cnt
		from webmanager_feedback fd
		join webmanager_feedback_track fdtrack
		on fd.id = fdtrack.feedback_id
		and substr(regexp_replace(fdtrack.createtime,'-',''),1,8)  = '$date$'
		and fdtrack.deleteflag = 0
		where fd.deleteflag = 0
		group by  fdtrack.creator_id
	) feedback
	on callrecord.cs_id = feedback.cs_id
	full outer join
	--APP审核 target_type: 0:职位, 1:feed, 2:feed评论,3:系统通知,4:分发职位，5：公司评论,6:身份验证审核
	(	select  review_user_id as cs_id,
				count(case when target_type = 0 then rl_id else null end) as audit_appjob_cnt,
				count(case when target_type in (1,2) then rl_id else null end) as audit_appfeed_cnt,
				count(case when target_type = 6 then rl_id else null end) as audit_appid_cnt
		from review_log
		where substr(regexp_replace(createtime,'-',''),1,8)  = '$date$'
		group by  review_user_id
	) app
	on callrecord.cs_id = app.cs_id
	full outer join 
	(
		select operator_id as cs_id,
			   count(case when operate in (3,15) then id else null end) AS audit_question_cnt,
			   count(case when operate = 15 then id else null end) AS audit_question_pass_cnt,
			   count(case when operate =3 then id else null end) AS audit_question_unpass_cnt
		  from wm_qa_question_log
		  where  substr(regexp_replace(modifytime,'-',''),1,8)  = '$date$'
		  and 	deleteflag = 0
		  group by operator_id
	) article
    on callrecord.cs_id = article.cs_id
    group by coalesce(callrecord.cs_id,userh.cs_id,hjob.cs_id,hcomp.cs_id,fbd.cs_id,res.cs_id,complaint.cs_id,feedback.cs_id,app.cs_id,article.cs_id)

	) fact 
	join 
	(select id,name,org_id,org_name,username
	  from dw_erp_d_salesuser_base
	 where p_date = $date$
	   and position_channel in ('A0000506','A0000601')) csuser
	on fact.cs_id = csuser.id;