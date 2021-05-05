-- either load CSCL subaddresses directly into this table
-- or insert from some other temporary source (see insert_source.sql)
-- in testing we will populate this from the repo
create table subaddress_source (
    objectid            number
   ,sub_address_id      number(10,0)
   ,melissa_suite       varchar2(255)
   ,ap_id               number(10,0)
   ,additional_loc_info varchar2(80)
   ,building            varchar2(50)
   ,floor               varchar2(50) 
   ,unit                varchar2(50)
   ,room                varchar2(50)
   ,seat                varchar2(50)
   ,created_by          varchar2(50)
   ,created_date        timestamp (6)
   ,modified_by         varchar2(50)
   ,modified_date       timestamp (6)
   ,globalid            char(38) 
   ,boroughcode         varchar2(1)
   ,validation_date     timestamp(6)
   ,update_source       varchar2(50)
   ,constraint subaddress_sourcepkc primary key (sub_address_id)
   ,constraint subaddress_sourceuqc unique (sub_address_id, melissa_suite)
);
create index subaddress_sourceap_id
   on subaddress_source (ap_id);
-- either load melissa_geocoded_addresses.csv directly into this table
-- or insert from some other temporary source (see insert_source.sql)
-- this is limited to the columns we use
-- in testing we will populate this from the repo
create table melissa_geocoded_source (
     suite              varchar2(256)
    ,addresspointid     number
    ,constraint melissa_geocoded_sourcepkc primary key (suite, addresspointid)
);
--the next two are outputs
create table subaddress_delete (
    sub_address_id number(10,0)
   ,constraint subaddress_deletepkc primary key (sub_address_id)
);
create table subaddress_add (
    sub_address_id      number(10,0)
   ,melissa_suite       varchar2(255)
   ,ap_id               number(10,0)
   ,additional_loc_info varchar2(80)
   ,building            varchar2(50)
   ,floor               varchar2(50) 
   ,unit                varchar2(50)
   ,room                varchar2(50)
   ,seat                varchar2(50)
   ,boroughcode         varchar2(1)
   ,constraint subaddress_addpkc primary key (sub_address_id)
   ,constraint subaddress_adduqc unique (sub_address_id, melissa_suite)
);
    