create table subaddress (
    objectid  number
   ,sub_address_id number(10,0)
   ,melissa_suite  varchar2(255)
   ,ap_id number(10,0)
   ,additional_loc_info varchar2(80)
   ,building varchar2(50)
   ,floor varchar2(50) 
   ,unit varchar2(50)
   ,room varchar2(50)
   ,seat varchar2(50)
   ,created_by varchar2(50)
   ,created_date timestamp (6)
   ,modified_by varchar2(50)
   ,modified_date timestamp (6)
   ,globalid char(38) 
   ,boroughcode varchar2(1)
   ,validation_date timestamp (6)
   ,update_source varchar2(50)
   ,constraint subaddresspkc primary key (sub_address_id)
   ,constraint subaddressuqc unique (sub_address_id, melissa_suite)
);
create index subaddressap_id
   on subaddress (ap_id);
create table subaddress_delete (
    sub_address_id number(10,0)
   ,constraint subaddress_deletepkc primary key (sub_address_id)
);
create table subaddress_add (
    sub_address_id number(10,0)
   ,melissa_suite  varchar2(255)
   ,ap_id number(10,0)
   ,additional_loc_info varchar2(80)
   ,building varchar2(50)
   ,floor varchar2(50) 
   ,unit varchar2(50)
   ,room varchar2(50)
   ,seat varchar2(50)
   ,boroughcode varchar2(1)
   ,constraint subaddress_addpkc primary key (sub_address_id)
   ,constraint subaddress_adduqc unique (sub_address_id, melissa_suite)
);
    