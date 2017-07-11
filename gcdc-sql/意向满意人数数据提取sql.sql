select 
'统计日期',
'客户名称',
'销售名称',
'销售团队名称',
'招服名称',
'招服团队名称',
'职位主动投递人数(含急聘回投不含邀请应聘回投)',
'邀请应聘主动投递人数',
'主动搜索下载',
'推荐下载(人工+伯乐推荐)',
'意向沟通可进一步沟通',
'面试快推荐人数（含内外部接单推荐）',
'RPO+PM推荐人数',
'猎头快推荐人数'
from dummy;

select 
    $date$ as d_date,
    regexp_replace(cntt.customer_name,'	','') as customer_name,
	cntt.sales_user_name,	
	cntt.sales_org_name,
	cntt.serviceuser_name,
	cntt.service_teamorg_name,
	nvl(aply.apply_cnt,0) - nvl(invite.invite_apply_cnt,0) as apply_cnt,
	nvl(invite.invite_apply_cnt,0) as invite_apply_cnt,
	nvl(schd.download_search_cv_cnt,0) as download_search_cv_cnt,
	nvl(rcmd.recmd_download_cnt,0) as recmd_download_cnt,
	nvl(inten.intention_cnt,0) as intention_cnt,
	nvl(msk.msk_recmd_cnt,0) as msk_recmd_cnt,
	nvl(rpo.rpo_recmd_cnt,0) as rpo_recmd_cnt,
	nvl(ltk.ltk_cnt,0) as ltk_cnt
from 
(
	select id as customer_id,name as customer_name,ecomp_root_id,ecomp_id,sales_user_name,sales_org_name,serviceuser_name,service_teamorg_name
	  from dw_erp_d_customer_base
	 where p_date = $date$
	 and name in ('飒拉商业(上海)有限公司',
'上海百事可乐饮料有限公司',
'欧普照明股份有限公司',
'欧尚(中国)投资有限公司',
'上海罗莱家用纺织品有限公司',
'上海贝肤泉化妆品有限公司',
'世楷贸易(上海)有限公司',
'网新新云联技术有限公司',
'银江股份有限公司',
'杭州时趣信息技术有限公司',
'爱渠西来科技(北京)有限公司',
'拉卡拉云商网络有限公司',
'上海豫园黄金珠宝集团有限公司',
'上海豫园旅游商城股份有限公司',
'浙江开心果网络科技有限公司',
'上海展志实业集团有限责任公司',
'上海小虎金融信息服务有限公司',
'苹果贸易(上海)有限公司',
'苹果采购运营管理(上海)有限公司',
'英域成语言培训(上海)有限公司',
'百度在线网络技术(北京)有限公司上海软件技术分公司',
'上海贝塔斯曼商业服务有限公司',
'上海百联大宗商品电子商务有限公司',
'英培信息技术(上海)有限公司',
'百联全渠道电子商务有限公司',
'沪江教育科技(上海)股份有限公司',
'上海康德弘翼医学临床研究有限公司',
'北京朗诗投资管理有限公司',
'上海幸福九号网络科技有限公司',
'阿克苏诺贝尔(中国)投资有限公司',
'科莱恩化工(中国)有限公司',
'阿科玛(中国)投资有限公司',
'中国华信能源有限公司',
'毕马威华振会计师事务所(特殊普通合伙)上海分所',
'康宁(上海)管理有限公司',
'碧辟(中国)投资有限公司',
'宁波均胜电子股份有限公司',
'复星保德信人寿保险有限公司',
'英飞凌科技(无锡)有限公司',
'凯捷咨询(中国)有限公司',
'拜耳(中国)有限公司',
'上海安鲜达物流科技有限公司',
'通联数据股份公司',
'上海载梦信息科技有限公司',
'新思科技(上海)有限公司',
'上海景域文化传播股份有限公司',
'上海阑途信息技术有限公司',
'美味不用等(上海)信息科技股份有限公司',
'拉萨鸿新资产管理有限公司上海分公司',
'携程计算机技术(上海)有限公司',
'菲仕兰乳制品(上海)有限公司',
'乐金生活健康贸易(上海)有限公司',
'浙江森马服饰股份有限公司',
'欧莱雅(中国)有限公司',
'金光纸业(中国)投资有限公司',
'上海百雀羚日用化学有限公司',
'上海双立人亨克斯有限公司',
'金红叶纸业集团有限公司上海分公司',
'小主人企业管理(上海)有限公司',
'上海眯客信息技术有限公司',
'花旗金融信息服务(中国)有限公司',
'威比网络科技(上海)有限公司',
'展讯通信(上海)有限公司',
'国际商业机器(中国)有限公司',
'迅销(中国)商贸有限公司',
'百安居(中国)投资有限公司',
'上海汇付数据服务有限公司',
'国际商业机器全球服务(大连)有限公司',
'上海恺英网络科技有限公司',
'浙江科澜信息技术有限公司',
'中远海运发展股份有限公司',
'王品(中国)餐饮有限公司',
'广州尼尔森市场研究有限公司上海分公司',
'上海华夏邓白氏商业信息咨询有限公司',
'敦豪物流(北京)有限公司上海分公司',
'圆通速递有限公司')
) cntt
left join 
( select 
		ur.ecomp_root_id,
		count(appejob_id) as apply_cnt
	from usere_recvapp ur
	where substr(regexp_replace(ur.appejob_createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$
	and ur.appejob_category!=4
	group by ur.ecomp_root_id
) aply  --全部主动应聘
on cntt.ecomp_id = aply.ecomp_root_id
left join
(select ecv.ecomp_root_id,
		count(ecv.res_id) as download_search_cv_cnt
	from 
	(select
			p_date, 
			user_id,
			nvl(get_json_object(data_info, '$.res_id'), decode_res_id(extract_url_param(url, 'res_id_encode'))) as res_id
		from tlog 
		where url like 'https://lpt.liepin.com/resume/showresumedetail%ck=%'
		and type = 'c'
		and info = 'b_resume_download'
		and p_date between {{date[:6]+'01'}} and $date$
		group by p_date,user_id,nvl(get_json_object(data_info, '$.res_id'), decode_res_id(extract_url_param(url, 'res_id_encode')))
	) tl 
	join (
	select 
		substr(regexp_replace(createtime,'-',''), 1, 8) as d_date,
		cd.res_id,
		cd.usere_id,
		cd.ecomp_root_id
	from e_cv_download cd
	where substr(regexp_replace(createtime,'-',''), 1, 8)  between {{date[:6]+'01'}} and $date$
	group by substr(regexp_replace(createtime,'-',''), 1, 8) ,cd.res_id,cd.usere_id,ecomp_root_id
	) ecv
	on tl.res_id = ecv.res_id
		and tl.user_id = ecv.usere_id 
		and tl.p_date = ecv.d_date
	group by ecv.ecomp_root_id
) schd --搜索下载
on cntt.ecomp_id = schd.ecomp_root_id
left join
(select task.customer_id,
		count(taskblog.id) as intention_cnt
	from rsc_intention task 
	join rsc_intention_task_b taskb
	on taskb.rsc_intention_id = task.id
	join (select    
			tasklog.id,
	        tasklog.result,
	        tasklog.creator_id,
	        tasklog.org_id,
	        tasklog.rsc_intention_task_b_id,
	        tasklog.intention_type,
	        tasklog.demand_concat_result,
	        tasklog.createtime,
	        regexp_replace(substr(tasklog.createtime,1,10),'-','') as d_date
	    from (
		    select id,result,creator_id,org_id,intention_type,rsc_intention_task_b_id,demand_concat_result,createtime,
		         row_number()over(distribute by rsc_intention_task_b_id sort by createtime desc) rn 
		      from rsc_intention_task_b_log
		     where result in ('1','2','3','4','5')
		       and deleteflag = 0
		       and intention_type in ('1','2')
		       and substr(regexp_replace(tracktime,'-',''),1,8)  between {{date[:6]+'01'}} and $date$
		       ) tasklog
	    where rn = 1
	    and result = 1 --可以进一步沟通
	) taskblog
	on taskb.id = taskblog.rsc_intention_task_b_id
	group by task.customer_id
) inten --意向沟通可进一步沟通
on cntt.customer_id = inten.customer_id
left join
(	
	select 
		recmd.ecomp_root_id,
		count(distinct recmd.res_id ) as recmd_download_cnt
	from 
		(select ecomp_root_id,
			ejob_id,
			res_id,
			source,
			regexp_replace(substr(handletime,1,10),'-','') as d_date
		from dw_erp_d_ejob_candidate 
		where substr(regexp_replace(handletime,'-',''),1,8) between {{date[:6]+'01'}} and $date$
			and feedback  in (2,4)
			and source in (0,4)
			and p_date = $date$
	) recmd
	group by ecomp_root_id
) rcmd --推荐下载
on cntt.ecomp_id = rcmd.ecomp_root_id
left join
(	select rj.customer_id,
			count(rcan.candidate_id) as rpo_recmd_cnt
	from dw_god_d_rpo_candidate rcan 
	join dw_god_d_rpo_job rj
	on rcan.job_id = rj.job_id
	and rj.p_date = $date$
	where rcan.p_date = $date$
	and substr(regexp_replace(rcan.recommend_time,'-',''),1,8) between {{date[:6]+'01'}} and $date$
	group by rj.customer_id
) rpo --RPO+PM推荐人数
on cntt.customer_id = rpo.customer_id

left join 
(select customer_id,count(can_id) as msk_recmd_cnt
   from dw_god_d_msk_candidate
   where p_date = $date$
     and substr(regexp_replace(recomm_time,'-',''),1,8) between {{date[:6]+'01'}} and $date$
     group by customer_id
) msk --面试快推荐人数（含内外部接单推荐）
on cntt.customer_id = msk.customer_id

left join 
(select 
		invite.ecomp_root_id,
		count(distinct recv.res_id) as invite_apply_cnt
	from 
	(select 
	    p_date,
		ejob_id,
		ecomp_root_id,
		userc_id
	from (
		select 
			ia.p_date,
			ia.ejob_id,
			ia.ecomp_root_id,
			split(liu_userc_ids, ',') as userc_ids
		from dw_b_d_invite_apply  ia
		where p_date between {{date[:6]+'01'}} and $date$
		) ivt 
		lateral view explode(userc_ids) subview as userc_id
	) invite
	left join 
	(select ur.ejob_id,
			ur.res_id,
			ur.user_id as userc_id,
			substr(ur.appejob_createtime,1,8) as app_date
			from usere_recvapp ur
		where substr(regexp_replace(ur.appejob_createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$
			and ur.appejob_category!=4
	) recv
		on invite.ejob_id = recv.ejob_id
		and invite.userc_id = recv.userc_id
	where invite.p_date <= recv.app_date	
	group by invite.ecomp_root_id
) invite --邀请应聘回投简历数
on cntt.ecomp_root_id = invite.ecomp_root_id
left join
(select ecomp_root_id,
		sum(apply_lowcv_cnt)+sum(apply_cv_cnt) as urgent_apply_cnt
	from dw_b_d_ejob_urgent
	where p_date between {{date[:6]+'01'}} and $date$ 
	group by ecomp_root_id
) urgent -- 急聘回投简历数
on cntt.ecomp_id = urgent.ecomp_root_id
left join 
(
	select rj.cust_id as customer_id,
            count(distinct rjrl.res_id) as ltk_cnt
	  from rpo_job_recommend_list_status rjrls 
	  join rpo_job_recommend_list rjrl 
 		on rjrls.recommend_list_id = rjrl.id
 		and rjrl.deleteflag = 0
 		and rjrl.source = 7
 	  join rpo_job rj 
 	    on rjrl.job_id = rj.id  
 	   and rj.deleteflag = 0
	 where rjrls.status = 1
	  and substr(regexp_replace(rjrls.createtime,'-',''),1,8) between {{date[:6]+'01'}} and $date$
	  and rjrls.deleteflag = 0
	  group by rj.cust_id 
) ltk 
on cntt.customer_id = ltk.customer_id