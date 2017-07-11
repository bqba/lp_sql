select '编号	客户名称	拨打计划类型	拨打计划状态	拨打计划时间	实际拨打时间	专员名称	专员所在组别	拨打计划备注	沟通记录'
from dummy;
select rsc.id,
cus.name,
case rsc.source when 0 then '手动录入'
when 1 then '招服划转生成'
when 2 then '客服要求采取非电话形式沟通'
when 3 then '意向沟通生成'
when 4 then '客户满意度回访生成TL'
when 5 then '新签客户生成'
when 6 then '到期客户生成'
when 7 then '浅度客户生成'
when 8 then '活跃客户生成'
when 9 then '中度客户生成'
when 10 then '新签客户跟进'
when 11 then '新职位发布客户生成'
when 12 then '常规覆盖'
end as source,
case rsc.status
when 0 then '未拨打'
when 1 then '已拨打'
when 2 then '已过期未拨打' 
when 3 then '手动无效计划'
when 4 then '已合并'
when 5 then '系统无效计划'
end as status,
substr(rsc.calltime,1,8),
substr(rsc.finishtime,1,8),
pu.name,
org.name,
rsc.memo,
track.abstracts
from
rsc_callplan rsc
left join dw_erp_d_customer_base_new as cus on rsc.customer_id = cus.id
left join track track on track.id =rsc.track_id
left join portal_employee pu on pu.id = rsc.creator_id
left join portal_org org on org.id = rsc.org_id
where substr(rsc.calltime,1,8) between '20161201' and '20161227'
and rsc.deleteflag = 0 
and rsc.creator_id != 346 