insert overwrite table busi_c_d_im_dialogs partition (p_date = {{date}})
select {{date}},
	sender_kind,
	sender_id,
	count(distinct concat(sender_id,'-',receiver_id)),
	count(distinct concat(dialogs_sender_id,'-',dialogs_receive_id)),
	from_unixtime(unix_timestamp())
from
	(select c.user_kind as sender_kind,
		d.user_kind as receiver_kind,
		c.user_id as sender_id,
		d.user_id as receiver_id,
		a.message_id,
		e.message_id as dialogs_message_id,
		e.user_id as dialogs_sender_id,
		e.opposite_user_id as dialogs_receive_id
	from (
		select *
		from msg_message_dialogs
		where message_status = 1
			and regexp_replace(to_date(createtime), '-', '') = {{date}}
		) a --新版IM+
	join msg_message b on a.message_id = b.message_id
	join web_user c on a.opposite_user_id = c.user_id
	join web_user d on a.user_id = d.user_id
	left outer join (
		select *
		from msg_message_dialogs
		where message_status = 1
			and regexp_replace(to_date(createtime), '-', '') = {{date}}
		) e on regexp_replace(to_date(a.createtime), '-', '') = regexp_replace(to_date(e.createtime), '-', '')
		and a.opposite_user_id = e.user_id
		and a.user_id = e.opposite_user_id
	left outer join (
		select opposite_user_id,
		    regexp_replace(to_date(a.createtime), '-', '') as p_date,
			count(distinct a.message_id) as msg_cnt,
			count(distinct case when get_json_object(get_json_object(b.message_content, '$.ext'), '$.extType') = '13' then a.message_id end) as invite_msg_cnt
		from msg_message_dialogs a
		join msg_message b on a.message_id = b.message_id
		join web_user c on a.opposite_user_id = c.user_id
		where regexp_replace(to_date(a.createtime), '-', '') = {{date}}
			and message_status = 1
			and c.user_kind = 1
		group by opposite_user_id,
		    regexp_replace(to_date(a.createtime), '-', '')
		) f on a.opposite_user_id = f.opposite_user_id 
		and regexp_replace(to_date(a.createtime), '-', '') = f.p_date
	where (f.msg_cnt != f.invite_msg_cnt) 
		or f.opposite_user_id is null
	) aa
where sender_kind in ('1','2')
    and receiver_kind = '0'
group by sender_kind,sender_id