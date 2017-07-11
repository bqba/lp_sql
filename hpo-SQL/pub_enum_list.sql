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
suit_price  int,
description string ,
creation_timestamp timestamp
)
 row format delimited fields terminated by '\t';