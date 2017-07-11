create table dw_c_d_user_act (
user_id int comment '用户主键',
login_cnt int comment '登陆次数',
sns_send_count  int comment '好友请求发送数',
sns_accept_count  int comment '好友请求接受数',
sns_recv_count  int comment '好友请求收到数',
sns_add_count int comment '好友请求被接受数',
msg_h_send_cnt  int comment '猎头发送信息数',
msg_h_recv_cnt  int comment '接收猎头发送信息数',
msg_hr_send_cnt int comment 'hr发送信息数',
msg_hr_recv_cnt int comment '接收hr发送信息数',
res_refresh_cnt int comment '简历刷新次数',
res_update_cnt  int comment '简历修改次数',
res_full_return int comment '完整回归简历数',
res_biz_return  int comment '商业回归简历数',
res_view  int comment '简历被hr查看次数',
job_search_pv int comment '职位搜索次数',
apply_ejob_cnt  int comment 'b端应聘职位数',
apply_ejob_view_cnt int comment 'b端应聘被查看数',
apply_ejob_fit_cnt  int comment 'b端应聘被处理合适数',
apply_ejob_nofit_cnt  int comment 'b端应聘被处理不合适数',
apply_hjob_cnt  int comment 'h端应聘职位数',
apply_hjob_view_cnt int comment 'h端应聘被查看数',
apply_hjob_fit_cnt  int comment 'h端应聘被处理合适数',
apply_hjob_nofit_cnt  int comment 'h端应聘被处理不合适数',
apply_job_cnt int comment '应聘职位总数',
apply_job_view_cnt  int comment '应聘总被查看数',
apply_job_fit_cnt int comment '应聘被处理合适数',
apply_job_nofit_cnt int comment '应聘被处理不合适数',
creation_timestamp  timestamp comment '时间戳'
) comment 'c端用户行为表'
partitioned by (p_date int);

insert overwrite table dw_c_d_user_act partition (p_date = {{date}})
select
  coalesce(login_info.user_id,follow_info.user_id,followed_info.user_id,res_act.user_id)   as user_id,
  coalesce(login_info.login_count, 0)   as login_cnt,
  coalesce(follow_info.send_count, 0)   as sns_send_count,
  coalesce(follow_info.accept_count, 0) as sns_accept_count,
  coalesce(followed_info.recv_count, 0) as sns_recv_count,
  coalesce(followed_info.add_count, 0)  as sns_add_count,
 0 as msg_h_send_cnt,
 0 as msg_h_recv_cnt,
 0 as msg_hr_send_cnt,
 0 as msg_hr_recv_cnt,
 0 as res_refresh_cnt,
 0 as res_update_cnt,
 0 as res_full_return,
 0 as res_biz_return,
 0 as res_view,
 0 as job_search_pv,
 0 as apply_ejob_cnt,
 0 as apply_ejob_view_cnt,
 0 as apply_ejob_fit_cnt,
 0 as apply_ejob_nofit_cnt,
 0 as apply_hjob_cnt,
 0 as apply_hjob_view_cnt,
 0 as apply_hjob_fit_cnt,
 0 as apply_hjob_nofit_cnt,
 0 as apply_job_cnt,
 0 as apply_job_view_cnt,
 0 as apply_job_fit_cnt,
 0 as apply_job_nofit_cnt,
 from_unixtime(unix_timestamp()) as creation_timestamp,
 nvl(res_act.b_download_cnt,0) as b_download_cnt,     
 nvl(res_act.cumu_b_download_cnt,0) as cumu_b_download_cnt,     
 nvl(res_act.h_download_cnt,0) as h_download_cnt,     
 nvl(res_act.cumu_h_download_cnt,0) as cumu_h_download_cnt
from (select
     blog.actor_id as user_id,
     count(*)      as login_count
   from blog
   where blog.p_date = {{date}}
         and blog.action_kind = 'LOGIN-COMMON'
   group by blog.actor_id) login_info
  full join
  (select
     blog.actor_id                                                  as user_id,
     count(distinct case when get_json_object(blog.action_info, '$.direction') = 'unidirectional'
       then get_json_object(blog.action_info, '$.follower_id') end) as send_count,
     count(distinct case when get_json_object(blog.action_info, '$.direction') = 'bidirectional'
       then get_json_object(blog.action_info, '$.follower_id') end) as accept_count
   from blog
   where p_date = {{date}}
         and blog.action_kind = 'FOLLOW-FRIEND'
         and blog.actor_kind = '0'
         and get_json_object(blog.action_info, '$.target_user_kind') = '0'
   group by blog.actor_id) follow_info
    on login_info.user_id = follow_info.user_id
  full join
  (select
     get_json_object(blog.action_info, '$.follower_id') as user_id,
     count(distinct case when get_json_object(blog.action_info, '$.direction') = 'unidirectional'
       then blog.actor_id end)                          as recv_count,
     count(distinct case when get_json_object(blog.action_info, '$.direction') = 'bidirectional'
       then blog.actor_id end)                          as add_count
   from blog
   where p_date = {{date}}
         and blog.action_kind = 'FOLLOW-FRIEND'
         and blog.actor_kind = '0'
         and get_json_object(blog.action_info, '$.target_user_kind') = '0'
   group by get_json_object(blog.action_info, '$.follower_id')) followed_info
    on login_info.user_id = followed_info.user_id
  full join 
  (

    select user_id,
           sum(cumu_b_download_cnt) as cumu_b_download_cnt,
           sum(b_download_cnt) as b_download_cnt,
           sum(cumu_h_download_cnt) as cumu_h_download_cnt,
           sum(h_download_cnt) as h_download_cnt
    from (
    select  res_id,
           count(1) as cumu_b_download_cnt,
           count(case when substr(regexp_replace(createtime,'-',''),1,8) = {{date}} then 1 else null end) as b_download_cnt,
           0 as cumu_h_download_cnt,
           0 as h_download_cnt
      from e_cv_download
      where substr(regexp_replace(createtime,'-',''),1,8) <= {{date}}
        and delflag = 0
      group by res_id
   union all    
   select  res_id,
           0 as cumu_b_download_cnt,
           0 as b_download_cnt,
           count(1) as cumu_h_download_cnt,
           count(case when substr(regexp_replace(cd_createtime,'-',''),1,8) = {{date}} then 1 else null end) as h_download_cnt
      from h_cv_download
      where substr(regexp_replace(cd_createtime,'-',''),1,8) <= {{date}}
      group by res_id
      ) dl 
      left join dw_c_d_res_base res 
      on dl.res_id = res.res_id
      and res.p_date = {{date}}
      group by user_id
   ) res_act
  on login_info.user_id = res_act.user_id