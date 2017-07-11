create table if not exists dim_position
(  
id int ,
name string ,
shortname string ,
parent_id int ,
position_type string ,
position_channel string ,
position_level string ,
close_flag tinyint ,
createtime string,
creation_timestamp timestamp 
)
row format delimited fields terminated by '\t';

select 
id ,
name ,
shortname ,
parent_id ,
position_type  ,
position_channel  ,
position_level  ,
close_flag  ,
createtime ,
from_unixtime(unix_timestamp())
from portal_position;


create table if not exists dim_org_all
(  
id int ,
parent_id int ,
name string ,
close_flag tinyint ,
kind int,
createtime string,
creation_timestamp timestamp
)
row format delimited fields terminated by '\t';

select id,parent_id,name,closeflag,kind,createtime ,
from_unixtime(unix_timestamp())
from portal_org;

create table if not exists pub_enum_list
(enum_type  string,
 enum_code  string,
 enum_name string,
 parent_type string,
 is_default int,
 startdate  string,
 enddate string,
 src_table string,
 creation_timestamp timestamp)
 row format delimited fields terminated by '\t';
 
create table  if  not exists dim_product_suit
(id int,
suit_name string,
suit_price  float,
description string ,
createtime string, 
creation_timestamp timestamp
)
 row format delimited fields terminated by '\t';
 
 
 

create table dim_position
(  
id int ,
name varchar(100) ,
shortname varchar(50)  ,
parent_id int ,
position_type varchar(20) , 
position_channel  varchar(20) ,
position_level  varchar(20) ,
close_flag int ,
createtime varchar(30) , 
creation_timestamp  timestamp default CURRENT_TIMESTAMP ,
primary key (id)
);
create table dim_org_all
(  
id int ,
parent_id int ,
name varchar(200) ,
close_flag int ,
kind int,
createtime varchar(30), 
creation_timestamp  timestamp default CURRENT_TIMESTAMP ,
primary key (id)
);
create table pub_enum_list
(enum_type  varchar(20),
 enum_code  varchar(20),
 enum_name varchar(100),
 parent_type varchar(20),
 is_default int,
 startdate  varchar(30),
 enddate varchar(30),
 src_table varchar(50),
 creation_timestamp  timestamp default CURRENT_TIMESTAMP ,
primary key (enum_type,is_default,src_table)
);
 
create table  dim_product_suit
(id int,
suit_name varchar(100),
suit_price  float,
description varchar(300),
createtime varchar(30), 
creation_timestamp  timestamp default CURRENT_TIMESTAMP,
primary key (id)
);

select  id, suit_name,suit_price,description,createtime, 
from_unixtime(unix_timestamp())
from crm_product_suit