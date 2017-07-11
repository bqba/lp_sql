create table dim_position (    
id int ,
name string ,
shortname string ,
parent_id int ,
position_type string ,
position_channel string ,
position_level string ,
position_levelname string ,
close_flag tinyint ,
createtime timestamp ,
first_level int ,
second_level int ,
third_level int ,
forth_level int ,
fifth_level int ,
sixth_level int ,
seventh_level int ,
eighth_level int ,
ninth_level int ,
tenth_level int ,
grade int 
)  partitioned by (p_date int); 


create table if not exists dim_position (    
id int comment ' 主键 ',
name string comment ' 职位名称 ',
shortname string comment ' 职位简称 ',
parent_id int comment ' 父岗位id ',
position_type string comment ' 职位类型 ',
position_channel string comment ' 职位通道 ',
position_level string comment ' 职级 ',
position_levelname string comment ' 职级名称 ',
close_flag tinyint comment ' 封存标志 ',
createtime timestamp comment ' 创建时间 ',
first_level int comment ' 1级职位 ',
second_level int comment ' 2级职位 ',
third_level int comment ' 3级职位 ',
forth_level int comment ' 4级职位 ',
fifth_level int comment ' 5级职位 ',
sixth_level int comment ' 6级职位 ',
seventh_level int comment ' 7级职位 ',
eighth_level int comment ' 8级职位 ',
ninth_level int comment ' 9级职位 ',
tenth_level int comment ' 10级职位 ',
grade int comment ' 当前职位级次 ',
)  partitioned by (p_date int);    

create table  temp1_dim_position like dim_position;
create table  temp2_dim_position like dim_position;
create table  temp3_dim_position like dim_position;
create table  temp4_dim_position like dim_position;
create table  temp5_dim_position like dim_position;
create table  temp6_dim_position like dim_position;
create table  temp7_dim_position like dim_position;
create table  temp8_dim_position like dim_position;
create table  temp9_dim_position like dim_position;
create table  temp10_dim_position like dim_position;


create table if not exists temp1_dim_position like dim_position;
create table if not exists temp2_dim_position like dim_position;
create table if not exists temp3_dim_position like dim_position;
create table if not exists temp4_dim_position like dim_position;
create table if not exists temp5_dim_position like dim_position;
create table if not exists temp6_dim_position like dim_position;
create table if not exists temp7_dim_position like dim_position;
create table if not exists temp8_dim_position like dim_position;
create table if not exists temp9_dim_position like dim_position;
create table if not exists temp10_dim_position like dim_position;

insert overwrite table  temp1_dim_position  
select id , name , shortname , parent_id , position_type , position_channel , position_level , position_levelname , close_flag , createtime , id as first_level, null as second_level,null as third_level,null as forth_level,null as fifth_level,null as sixth_level ,null as seventh_level ,null as eighth_level ,null as ninth_level ,null as tenth_level, 1 as grade
from portal_position where parent_id  = 0;

insert overwrite table  temp2_dim_position  
select id , name , shortname , parent_id , position_type , position_channel , position_level , position_levelname , close_flag , createtime , temp1.first_level as first_level, position_id as second_level,null as third_level,null as forth_level,null as fifth_level,null as sixth_level ,null as seventh_level ,null as eighth_level ,null as ninth_level ,null as tenth_level, 2 as grade
from portal_position position
inner join temp1_dim_position temp1
on position.parent_id = temp1.id;

insert overwrite table  temp3_dim_position  
select id , name , shortname , parent_id , position_type , position_channel , position_level , position_levelname , close_flag , createtime , temp2.first_level as first_level, temp2.second_level as second_level,position.id as third_level,null as forth_level,null as fifth_level,null as sixth_level ,null as seventh_level ,null as eighth_level ,null as ninth_level ,null as tenth_level, 3 as grade
from portal_position position
inner join temp2_dim_position temp2
on position.parent_id = temp2.id;

insert overwrite table  temp4_dim_position  
select id , name , shortname , parent_id , position_type , position_channel , position_level , position_levelname , close_flag , createtime , temp3.first_level as first_level, temp3.second_level as second_level,temp3.third_level as third_level,position.id  as forth_level,null as fifth_level,null as sixth_level ,null as seventh_level ,null as eighth_level ,null as ninth_level ,null as tenth_level, 4 as grade
from portal_position position
inner join temp3_dim_position temp3
on position.parent_id = temp3.id;

insert overwrite table  temp5_dim_position  
select id , name , shortname , parent_id , position_type , position_channel , position_level , position_levelname , close_flag , createtime , temp4.first_level as first_level, temp4.second_level as second_level,temp4.third_level as third_level,temp4.forth_level  as forth_level,position.id as fifth_level,null as sixth_level ,null as seventh_level ,null as eighth_level ,null as ninth_level ,null as tenth_level, 5 as grade
from portal_position position
inner join temp4_dim_position temp4
on position.parent_id = temp4.id;

insert overwrite table  temp5_dim_position  
select id , name , shortname , parent_id , position_type , position_channel , position_level , position_levelname , close_flag , createtime , temp4.first_level as first_level, temp4.second_level as second_level,temp4.third_level as third_level,temp4.forth_level  as forth_level,position.id as fifth_level,null as sixth_level ,null as seventh_level ,null as eighth_level ,null as ninth_level ,null as tenth_level, 5 as grade
from portal_position position
inner join temp4_dim_position temp4
on position.parent_id = temp4.id;

insert overwrite table  temp6_dim_position  
select id , name , shortname , parent_id , position_type , position_channel , position_level , position_levelname , close_flag , createtime , temp5.first_level as first_level, temp5.second_level as second_level,temp5.third_level as third_level,temp5.forth_level  as forth_level,temp5.fifth_level as fifth_level,position.id  as sixth_level ,null as seventh_level ,null as eighth_level ,null as ninth_level ,null as tenth_level, 6 as grade
from portal_position position
inner join temp5_dim_position temp5
on position.parent_id = temp5.id;

select
from (
 select e.*, 
 case when d.parent_id = d.first_level then d.first_level 
   when d.parent_id = d.second_level then contact(d.first_level,',',d.second_level),
   when d.parent_id = d.third_level then contact(d.first_level,',',d.second_level,',',d.third_level),
   when d.parent_id = d.forth_level then contact(d.first_level,',',d.second_level,',',d.third_level,',',d.forth_level),
   when d.parent_id = d.fifth_level then contact(d.first_level,',',d.second_level,',',d.third_level,',',d.forth_level,',',fifth_level)
 end parent_id_list
 from portal_employee e
 left outer join dim_position d
 on e.position_id = d.id
) e1
left outer join portal_employee e2
on instr(e1.parent_id_list, e2.position_id) > 0
;

select e1.*
from (
 select e.*, 
 case when d.parent_id = d.first_level then d.first_level 
   when d.parent_id = d.second_level then contact(d.first_level,',',d.second_level),
   when d.parent_id = d.third_level then contact(d.first_level,',',d.second_level,',',d.third_level),
   when d.parent_id = d.forth_level then contact(d.first_level,',',d.second_level,',',d.third_level,',',d.forth_level),
   when d.parent_id = d.fifth_level then contact(d.first_level,',',d.second_level,',',d.third_level,',',d.forth_level,',',fifth_level)
 end parent_id_list
 from portal_employee e
 left outer join dim_position d
 on e.position_id = d.id
) e1
left outer join portal_employee e2
where instr(e1.parent_id_list, e2.position_id) > 0


on instr(e1.parent_id_list, e2.position_id) > 0


select e.*, d.parent_id
from portal_employee e
inner join portal_position d
on d.id=e.position_id
left outer join  portal_employee e2
on d.parent_id=e2.position_id;


select e.*, d.parent_id_list
from portal_employee e
inner join dim_position d
on e.position_id = d.position_id